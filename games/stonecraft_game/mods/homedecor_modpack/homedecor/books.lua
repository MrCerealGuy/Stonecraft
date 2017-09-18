local S = homedecor_i18n.gettext

local function N_(x) return x end

local bookcolors = {
	{ N_("red"),    0xffd26466 },
	{ N_("green"),  0xff62aa66 },
	{ N_("blue"),   0xff8686d7 },
	{ N_("violet"), 0xff9c65a7 },
	{ N_("grey"),   0xff757579 },
	{ N_("brown"),  0xff896958 }
}

local BOOK_FORMNAME = "homedecor:book_form"

local player_current_book = { }

for _, c in ipairs(bookcolors) do
	local color, hue = unpack(c)

	local function book_dig(pos, node, digger)
		if minetest.is_protected(pos, digger:get_player_name()) then return end
		local meta = minetest.get_meta(pos)
		local data = minetest.serialize({
			title = meta:get_string("title") or "",
			text = meta:get_string("text") or "",
			owner = meta:get_string("owner") or "",
			_recover = meta:get_string("_recover") or "",
		})
		local stack = ItemStack({
			name = "homedecor:book_"..color,
			metadata = data,
		})
		stack = digger:get_inventory():add_item("main", stack)
		if not stack:is_empty() then
			minetest.item_drop(stack, digger, pos)
		end
		minetest.remove_node(pos)
	end

	homedecor.register("book_"..color, {
		description = S("Writable Book (@1)", S(color)),
		mesh = "homedecor_book.obj",
		tiles = {
			{ name = "homedecor_book_cover.png", color = hue },
			{ name = "homedecor_book_edges.png", color = "white" }
		},
		overlay_tiles = {
			{ name = "homedecor_book_cover_trim.png", color = "white" },
			""
		},
		groups = { snappy=3, oddly_breakable_by_hand=3, book=1 },
		walkable = false,
		stack_max = 1,
		on_punch = function(pos, node, puncher, pointed_thing)
			local fdir = node.param2
			minetest.swap_node(pos, { name = "homedecor:book_open_"..color, param2 = fdir })
		end,
		on_place = function(itemstack, placer, pointed_thing)
			local plname = placer:get_player_name()
			local pos = pointed_thing.under
			local node = minetest.get_node_or_nil(pos)
			local def = node and minetest.registered_nodes[node.name]
			if not def or not def.buildable_to then
				pos = pointed_thing.above
				node = minetest.get_node_or_nil(pos)
				def = node and minetest.registered_nodes[node.name]
				if not def or not def.buildable_to then return itemstack end
			end
			if minetest.is_protected(pos, plname) then return itemstack end
			local fdir = minetest.dir_to_facedir(placer:get_look_dir())
			minetest.set_node(pos, {
				name = "homedecor:book_"..color,
				param2 = fdir,
			})
			local text = itemstack:get_metadata() or ""
			local meta = minetest.get_meta(pos)
			local data = minetest.deserialize(text) or {}
			if type(data) ~= "table" then
				data = {}
				-- Store raw metadata in case some data is lost by the
				-- transition to the new meta format, so it is not lost
				-- and can be recovered if needed.
				meta:set_string("_recover", text)
			end
			meta:set_string("title", data.title or "")
			meta:set_string("text", data.text or "")
			meta:set_string("owner", data.owner or "")
			if data.title and data.title ~= "" then
				meta:set_string("infotext", data.title)
			end
			if not creative.is_enabled_for(plname) then
				itemstack:take_item()
			end
			return itemstack
		end,
		on_dig = book_dig,
		selection_box = {
		        type = "fixed",
				fixed = {-0.2, -0.5, -0.25, 0.2, -0.35, 0.25}
		}
	})

	homedecor.register("book_open_"..color, {
		mesh = "homedecor_book_open.obj",
		tiles = {
			{ name = "homedecor_book_cover.png", color = hue },
			{ name = "homedecor_book_edges.png", color = "white" },
			{ name = "homedecor_book_pages.png", color = "white" }
		},
		groups = { snappy=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1 },
		drop = "homedecor:book_"..color,
		walkable = false,
		on_dig = book_dig,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local meta = minetest.get_meta(pos)
			local player_name = clicker:get_player_name()
			local title = meta:get_string("title") or ""
			local text = meta:get_string("text") or ""
			local owner = meta:get_string("owner") or ""
			local formspec
			if owner == "" or owner == player_name then
				formspec = "size[8,8]"..default.gui_bg..default.gui_bg_img..
					"field[0.5,1;7.5,0;title;Book title :;"..
						minetest.formspec_escape(title).."]"..
					"textarea[0.5,1.5;7.5,7;text;Book content :;"..
						minetest.formspec_escape(text).."]"..
					"button_exit[2.5,7.5;3,1;save;Save]"
			else
				formspec = "size[8,8]"..default.gui_bg..
				"button_exit[7,0.25;1,0.5;close;X]"..
				default.gui_bg_img..
					"label[0.5,0.5;by "..owner.."]"..
					"label[0.5,0;"..minetest.formspec_escape(title).."]"..
					"textarea[0.5,1.5;7.5,7;;"..minetest.formspec_escape(text)..";]"
			end
			player_current_book[player_name] = pos
			minetest.show_formspec(player_name, BOOK_FORMNAME, formspec)
			return itemstack
		end,
		on_punch = function(pos, node, puncher, pointed_thing)
			local fdir = node.param2
			minetest.swap_node(pos, { name = "homedecor:book_"..color, param2 = fdir })
			minetest.sound_play("homedecor_book_close", {
				pos=pos,
				max_hear_distance = 3,
				gain = 2,
				})
		end,
		selection_box = {
		        type = "fixed",
				fixed = {-0.35, -0.5, -0.25, 0.35, -0.4, 0.25}
		}
	})

end

minetest.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= BOOK_FORMNAME or not fields.save then
		return
	end
	local player_name = player:get_player_name()
	local pos = player_current_book[player_name]
	if not pos then return end
	local meta = minetest.get_meta(pos)
	meta:set_string("title", fields.title or "")
	meta:set_string("text", fields.text or "")
	meta:set_string("owner", player_name)
	if (fields.title or "") ~= "" then
		meta:set_string("infotext", fields.title)
	end
	minetest.log("action", S("@1 has written in a book (title: \"@2\"): \"@3\" at location @4",
			player:get_player_name(), fields.title, fields.text, minetest.pos_to_string(player:getpos())))
end)

minetest.register_alias("homedecor:book", "homedecor:book_grey")
minetest.register_alias("homedecor:book_open", "homedecor:book_open_grey")
