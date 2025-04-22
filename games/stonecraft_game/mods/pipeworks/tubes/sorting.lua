local S = minetest.get_translator("pipeworks")
local fs_helpers = pipeworks.fs_helpers

if pipeworks.enable_mese_tube then
	local function update_formspec(pos)
		local meta = minetest.get_meta(pos)
		local old_formspec = meta:get_string("formspec")
		if string.find(old_formspec, "button1") then -- Old version
			local inv = meta:get_inventory()
			for i = 1, 6 do
				for _, stack in ipairs(inv:get_list("line"..i)) do
					minetest.add_item(pos, stack)
				end
			end
		end
		local buttons_formspec = ""
		for i = 0, 5 do
			buttons_formspec = buttons_formspec .. fs_helpers.cycling_button(meta,
				"image_button[9,"..(i+(i*0.25)+0.5)..";1,0.6", "l"..(i+1).."s",
				{
					pipeworks.button_off,
					pipeworks.button_on
				}
			)
		end
		local list_backgrounds = ""
		if minetest.get_modpath("i3") or minetest.get_modpath("mcl_formspec") then
			list_backgrounds = "style_type[box;colors=#666]"
			for i=0, 5 do
				for j=0, 5 do
					list_backgrounds = list_backgrounds .. "box[".. 1.5+(i*1.25) ..",".. 0.25+(j*1.25) ..";1,1;]"
				end
			end
		end
		local size = "10.2,13"
		meta:set_string("formspec",
			"formspec_version[2]"..
			"size["..size.."]"..
			pipeworks.fs_helpers.get_prepends(size)..
			"list[context;line1;1.5,0.25;6,1;]"..
			"list[context;line2;1.5,1.50;6,1;]"..
			"list[context;line3;1.5,2.75;6,1;]"..
			"list[context;line4;1.5,4.00;6,1;]"..
			"list[context;line5;1.5,5.25;6,1;]"..
			"list[context;line6;1.5,6.50;6,1;]"..
			list_backgrounds..
			"image[0.22,0.25;1,1;pipeworks_white.png]"..
			"image[0.22,1.50;1,1;pipeworks_black.png]"..
			"image[0.22,2.75;1,1;pipeworks_green.png]"..
			"image[0.22,4.00;1,1;pipeworks_yellow.png]"..
			"image[0.22,5.25;1,1;pipeworks_blue.png]"..
			"image[0.22,6.50;1,1;pipeworks_red.png]"..
			buttons_formspec..
			--"list[current_player;main;0,8;8,4;]" ..
			pipeworks.fs_helpers.get_inv(8)..
			"listring[current_player;main]" ..
			"listring[current_player;main]" ..
			"listring[context;line1]" ..
			"listring[current_player;main]" ..
			"listring[context;line2]" ..
			"listring[current_player;main]" ..
			"listring[context;line3]" ..
			"listring[current_player;main]" ..
			"listring[context;line4]" ..
			"listring[current_player;main]" ..
			"listring[context;line5]" ..
			"listring[current_player;main]" ..
			"listring[context;line6]"
			)
	end

	pipeworks.register_tube("pipeworks:mese_tube", {
			description = S("Sorting Pneumatic Tube Segment"),
			inventory_image = "pipeworks_mese_tube_inv.png",
			noctr = {"pipeworks_mese_tube_noctr_1.png", "pipeworks_mese_tube_noctr_2.png", "pipeworks_mese_tube_noctr_3.png",
				"pipeworks_mese_tube_noctr_4.png", "pipeworks_mese_tube_noctr_5.png", "pipeworks_mese_tube_noctr_6.png"},
			plain = {"pipeworks_mese_tube_plain_1.png", "pipeworks_mese_tube_plain_2.png", "pipeworks_mese_tube_plain_3.png",
				"pipeworks_mese_tube_plain_4.png", "pipeworks_mese_tube_plain_5.png", "pipeworks_mese_tube_plain_6.png"},
			ends = { "pipeworks_mese_tube_end.png" },
			short = "pipeworks_mese_tube_short.png",
			no_facedir = true,  -- Must use old tubes, since the textures are rotated with 6d ones
			node_def = {
				tube = {can_go = function(pos, node, velocity, stack)
						 local tbl, tbln = {}, 0
						 local found, foundn = {}, 0
						 local meta = minetest.get_meta(pos)
						 local inv = meta:get_inventory()
						 local name = stack:get_name()
						 for i, vect in ipairs(pipeworks.meseadjlist) do
							local npos = vector.add(pos, vect)
							local node = minetest.get_node(npos)
							local reg_node = minetest.registered_nodes[node.name]
							if meta:get_int("l"..i.."s") == 1 and reg_node then
								local tube_def = reg_node.tube
								if not tube_def or not tube_def.can_insert or
								tube_def.can_insert(npos, node, stack, vect) then
									local invname = "line"..i
									local is_empty = true
									for _, st in ipairs(inv:get_list(invname)) do
										if not st:is_empty() then
											is_empty = false
											if st:get_name() == name then
												foundn = foundn + 1
												found[foundn] = vect
											end
										end
									end
									if is_empty then
										tbln = tbln + 1
										tbl[tbln] = vect
									end
								end
							 end
						 end
						 return (foundn > 0) and found or tbl
					end},
				on_construct = function(pos)
					local meta = minetest.get_meta(pos)
					local inv = meta:get_inventory()
					for i = 1, 6 do
						meta:set_int("l"..tostring(i).."s", 1)
						inv:set_size("line"..tostring(i), 6*1)
					end
					update_formspec(pos)
					meta:set_string("infotext", S("Sorting pneumatic tube"))
				end,
				after_place_node = function(pos, placer, itemstack, pointed_thing)
					if placer and placer:is_player() and placer:get_player_control().aux1 then
						local meta = minetest.get_meta(pos)
						for i = 1, 6 do
							meta:set_int("l"..tostring(i).."s", 0)
						end
						update_formspec(pos)
					end
					return pipeworks.after_place(pos, placer, itemstack, pointed_thing)
				end,
				on_punch = update_formspec,
				on_receive_fields = function(pos, formname, fields, sender)
					if (fields.quit and not fields.key_enter_field)
							or not pipeworks.may_configure(pos, sender) then
						return
					end
					fs_helpers.on_receive_fields(pos, fields)
					update_formspec(pos)
				end,
				can_dig = function(pos, player)
					update_formspec(pos) -- so non-virtual items would be dropped for old tubes
					return true
				end,
				allow_metadata_inventory_put = function(pos, listname, index, stack, player)
					if not pipeworks.may_configure(pos, player) then return 0 end
					update_formspec(pos) -- For old tubes
					local inv = minetest.get_meta(pos):get_inventory()
					local stack_copy = ItemStack(stack)
					stack_copy:set_count(1)
					inv:set_stack(listname, index, stack_copy)
					return 0
				end,
				allow_metadata_inventory_take = function(pos, listname, index, stack, player)
					if not pipeworks.may_configure(pos, player) then return 0 end
					update_formspec(pos) -- For old tubes
					local inv = minetest.get_meta(pos):get_inventory()
					inv:set_stack(listname, index, ItemStack(""))
					return 0
				end,
				allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
					if not pipeworks.may_configure(pos, player) then return 0 end
					update_formspec(pos) -- For old tubes
					local inv = minetest.get_meta(pos):get_inventory()

					if from_list:match("line%d") and to_list:match("line%d") then
						return count
					else
						inv:set_stack(from_list, from_index, ItemStack(""))
						return 0
					end
				end,
			},
	})
end
