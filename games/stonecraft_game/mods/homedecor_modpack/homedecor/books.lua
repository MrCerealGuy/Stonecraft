
local S = homedecor_i18n.gettext

local BOOK_FORMNAME = "homedecor:book_form"

local player_current_book = { }

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
		name = "homedecor:book",
		metadata = data,
	})
	stack = digger:get_inventory():add_item("main", stack)
	if not stack:is_empty() then
		minetest.item_drop(stack, digger, pos)
	end
	minetest.remove_node(pos)
end

local inv_img = "homedecor_book_inv.png^homedecor_book_trim_inv.png"

homedecor.register("book", {
	description = S("Writable Book"),
	mesh = "homedecor_book.obj",
	tiles = {
		"homedecor_book_cover.png",
		{ name = "homedecor_book_edges.png", color = 0xffffffff },
		{ name = "homedecor_book_cover_trim.png", color = 0xffffffff }
	},
	inventory_image = inv_img,
	wield_image = inv_img,
	groups = { snappy=3, oddly_breakable_by_hand=3, book=1, ud_param2_colorable = 1 },
	walkable = false,
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	after_dig_node = unifieddyes.after_dig_node,
	stack_max = 1,
	on_punch = function(pos, node, puncher, pointed_thing)
		local fdir = node.param2
		minetest.swap_node(pos, { name = "homedecor:book_open", param2 = fdir })
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
			name = "homedecor:book",
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
		if not homedecor.expect_infinite_stacks then
			itemstack:take_item()
		end
		unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
		return itemstack
	end,
	on_rotate = unifieddyes.fix_after_screwdriver_nsew,
	on_dig = book_dig,
	selection_box = {
			type = "fixed",
			fixed = {-0.2, -0.5, -0.25, 0.2, -0.35, 0.25}
	}
})

homedecor.register("book_open", {
	mesh = "homedecor_book_open.obj",
	tiles = {
		"homedecor_book_cover.png",
		{ name = "homedecor_book_edges.png", color = 0xffffffff },
		{ name = "homedecor_book_pages.png", color = 0xffffffff }
	},
	groups = { snappy=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1, ud_param2_colorable = 1 },
	drop = "homedecor:book",
	walkable = false,
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	after_place_node = unifieddyes.fix_rotation_nsew,
	after_dig_node = unifieddyes.after_dig_node,
	on_rotate = unifieddyes.fix_after_screwdriver_nsew,
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
		minetest.swap_node(pos, { name = "homedecor:book", param2 = fdir })
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

-- convert old static nodes to param2

local bookcolors = {
	"red",
	"green",
	"blue",
	"violet",
	"grey",
	"brown"
}

homedecor.old_static_books = {}
for _, color in ipairs(bookcolors) do
	table.insert(homedecor.old_static_books, "homedecor:book_"..color)
	table.insert(homedecor.old_static_books, "homedecor:book_open_"..color)
end

minetest.register_lbm({
	name = "homedecor:convert_books",
	label = "Convert homedecor books to use param2 color",
	run_at_every_load = false,
	nodenames = homedecor.old_static_books,
	action = function(pos, node)
		local name = node.name
		local color = string.sub(name, string.find(name, "_", -7)+1)
		local newname = "homedecor:book"
		if string.find(name, "open") then
			newname = "homedecor:book_open"
		end

		local old_fdir = math.floor(node.param2 % 32)
		local new_fdir = 3

		if old_fdir == 0 then
			new_fdir = 3
		elseif old_fdir == 1 then
			new_fdir = 4
		elseif old_fdir == 2 then
			new_fdir = 2
		elseif old_fdir == 3 then
			new_fdir = 5
		end

		if color == "grey" then
			color = "dark_grey"
		elseif color == "violet" then
			color = "dark_magenta"
		elseif color == "brown" then
			color = "dark_orange"
		elseif color == "blue" then
			color = "light_blue"
		else
			color = "medium_"..color
		end

		local paletteidx = unifieddyes.getpaletteidx("unifieddyes:"..color, "wallmounted")
		local param2 = paletteidx + new_fdir

		minetest.swap_node(pos, { name = newname, param2 = param2 })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)

	end
})
