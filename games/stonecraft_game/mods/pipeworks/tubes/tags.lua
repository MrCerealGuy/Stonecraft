local S = minetest.get_translator("pipeworks")
local fs_helpers = pipeworks.fs_helpers

if not pipeworks.enable_item_tags or not pipeworks.enable_tag_tube then return end

local help_text = minetest.formspec_escape(
	S("Separate multiple tags using commas.").."\n"..
	S("Use \"<none>\" to match items without tags.")
)

local update_formspec = function(pos)
	local meta = minetest.get_meta(pos)
	local buttons_formspec = ""
	for i = 0, 5 do
		buttons_formspec = buttons_formspec .. fs_helpers.cycling_button(meta,
			"image_button[9," .. (i + (i * 0.25) + 0.5) .. ";1,0.6", "l" .. (i + 1) .. "s",
			{
				pipeworks.button_off,
				pipeworks.button_on
			}
		)
	end
	local size = "10.2,9"
	meta:set_string("formspec",
		"formspec_version[2]" ..
		"size[" .. size .. "]" ..
		pipeworks.fs_helpers.get_prepends(size) ..
		"field[1.5,0.25;7.25,1;tags1;;${tags1}]" ..
		"field[1.5,1.5;7.25,1;tags2;;${tags2}]" ..
		"field[1.5,2.75;7.25,1;tags3;;${tags3}]" ..
		"field[1.5,4.0;7.25,1;tags4;;${tags4}]" ..
		"field[1.5,5.25;7.25,1;tags5;;${tags5}]" ..
		"field[1.5,6.5;7.25,1;tags6;;${tags6}]" ..

		"image[0.22,0.25;1,1;pipeworks_white.png]" ..
		"image[0.22,1.50;1,1;pipeworks_black.png]" ..
		"image[0.22,2.75;1,1;pipeworks_green.png]" ..
		"image[0.22,4.00;1,1;pipeworks_yellow.png]" ..
		"image[0.22,5.25;1,1;pipeworks_blue.png]" ..
		"image[0.22,6.50;1,1;pipeworks_red.png]" ..
		buttons_formspec ..
		"label[0.22,7.9;"..help_text.."]"..
		"button[7.25,7.8;1.5,0.8;set_item_tags;" .. S("Set") .. "]"
	)
end

pipeworks.register_tube("pipeworks:tag_tube", {
	description = S("Tag Sorting Pneumatic Tube Segment"),
	inventory_image = "pipeworks_tag_tube_inv.png",
	noctr = { "pipeworks_tag_tube_noctr_1.png", "pipeworks_tag_tube_noctr_2.png", "pipeworks_tag_tube_noctr_3.png",
		"pipeworks_tag_tube_noctr_4.png", "pipeworks_tag_tube_noctr_5.png", "pipeworks_tag_tube_noctr_6.png" },
	plain = { "pipeworks_tag_tube_plain_1.png", "pipeworks_tag_tube_plain_2.png", "pipeworks_tag_tube_plain_3.png",
		"pipeworks_tag_tube_plain_4.png", "pipeworks_tag_tube_plain_5.png", "pipeworks_tag_tube_plain_6.png" },
	ends = { "pipeworks_tag_tube_end.png" },
	short = "pipeworks_tag_tube_short.png",
	no_facedir = true, -- Must use old tubes, since the textures are rotated with 6d ones
	node_def = {
		tube = {
			can_go = function(pos, node, velocity, stack, tags)
				local tbl, tbln = {}, 0
				local found, foundn = {}, 0
				local meta = minetest.get_meta(pos)
				local tag_hash = {}
				if #tags > 0 then
					for _,tag in ipairs(tags) do
						tag_hash[tag] = true
					end
				else
					tag_hash["<none>"] = true  -- Matches items without tags
				end
				for i, vect in ipairs(pipeworks.meseadjlist) do
					local npos = vector.add(pos, vect)
					local node = minetest.get_node(npos)
					local reg_node = minetest.registered_nodes[node.name]
					if meta:get_int("l" .. i .. "s") == 1 and reg_node then
						local tube_def = reg_node.tube
						if not tube_def or not tube_def.can_insert or
							tube_def.can_insert(npos, node, stack, vect) then
							local side_tags = meta:get_string("tags" .. i)
							if side_tags ~= "" then
								side_tags = pipeworks.sanitize_tags(side_tags)
								for _,tag in ipairs(side_tags) do
									if tag_hash[tag] then
										foundn = foundn + 1
										found[foundn] = vect
										break
									end
								end
							else
								tbln = tbln + 1
								tbl[tbln] = vect
							end
						end
					end
				end
				return (foundn > 0) and found or tbl
			end
		},
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			for i = 1, 6 do
				meta:set_int("l" .. tostring(i) .. "s", 1)
			end
			update_formspec(pos)
			meta:set_string("infotext", S("Tag sorting pneumatic tube"))
		end,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			if placer and placer:is_player() and placer:get_player_control().aux1 then
				local meta = minetest.get_meta(pos)
				for i = 1, 6 do
					meta:set_int("l" .. tostring(i) .. "s", 0)
				end
				update_formspec(pos)
			end
			return pipeworks.after_place(pos, placer, itemstack, pointed_thing)
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			if (fields.quit and not fields.key_enter_field)
				or not pipeworks.may_configure(pos, sender) then
				return
			end

			local meta = minetest.get_meta(pos)
			for i = 1, 6 do
				local field_name = "tags" .. tostring(i)
				if fields[field_name] then
					local tags = pipeworks.sanitize_tags(fields[field_name])
					meta:set_string(field_name, table.concat(tags, ","))
				end
			end

			fs_helpers.on_receive_fields(pos, fields)
			update_formspec(pos)
		end,
		can_dig = function(pos, player)
			return true
		end,
	},
})
