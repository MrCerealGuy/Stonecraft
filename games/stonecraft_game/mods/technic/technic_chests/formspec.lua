
local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end
--local S = minetest.get_translator("technic_chests")

local has_pipeworks = minetest.get_modpath("pipeworks")

local function get_pipeworks_fs(x, y, meta)
	-- Use a container to reposition the pipeworks button.
	return "container["..x..","..(y - 4.3).."]"..
		pipeworks.fs_helpers.cycling_button(
			meta,
			pipeworks.button_base,
			"splitstacks",
			{
				pipeworks.button_off,
				pipeworks.button_on
			}
		)..pipeworks.button_label.."container_end[]"
end

local function get_color_fs(x, y, meta)
	local fs = ""
	for a = 0, 3 do
		for b = 0, 3 do
			fs = fs.."image_button["..(x + b * 0.73)..","..(y + 0.1 + a * 0.79)..";0.8,0.8;"..
				"technic_colorbutton"..(a * 4 + b)..".png;color_button"..(a * 4 + b + 1)..";]"
		end
	end
	local selected = meta:get_int("color")
	local color
	if technic.chests.colors[selected] then
		color = technic.chests.colors[selected][2]
	else
		color = S("None")
	end
	return fs.."label["..(x + 0.1)..","..(y + 3.4)..";"..S("Selected Color: %s"):format(color).."]"
end

local function get_quickmove_fs(x, y)
	return "button["..x..","..y..";3,1;existing_to_chest;"..S("Move existing to Chest").."]"..
		"label["..(x + 0.1)..","..(y + 1.15)..";"..S("Move specific")..":\n("..S("Drop to move")..")]"..
		"list[context;quickmove;"..(x + 1.8)..","..(y + 1.15)..";1,1]"..
		"button["..x..","..(y + 2.3)..";3,1;all_to_chest;"..S("Move all to Chest").."]"..
		"button["..x..","..(y + 3.2)..";3,1;all_to_inv;"..S("Move all to Inventory").."]"
end

local function get_digilines_fs(x, y, meta)
	local channel = minetest.formspec_escape(meta:get_string("channel"))
	local put = meta:get_int("send_put") == 1 and "true" or "false"
	local take = meta:get_int("send_take") == 1 and "true" or "false"
	local inject = meta:get_int("send_inject") == 1 and "true" or "false"
	local pull = meta:get_int("send_pull") == 1 and "true" or "false"
	local overflow = meta:get_int("send_overflow") == 1 and "true" or "false"
	return "field["..(x + 0.3)..","..(y + 0.5)..";3,1;channel;Digiline Channel:;"..channel.."]"..
		"button["..(x + 0.5)..","..(y + 1.1)..";2,1;save_channel;Save Channel]"..
		"checkbox["..(x + 0.1)..","..(y + 1.8)..";send_put;"..S("Send player put messages")..";"..put.."]"..
		"checkbox["..(x + 0.1)..","..(y + 2.2)..";send_take;"..S("Send player take messages")..";"..take.."]"..
		"checkbox["..(x + 0.1)..","..(y + 2.6)..";send_inject;"..S("Send tube inject messages")..";"..inject.."]"..
		"checkbox["..(x + 0.1)..","..(y + 3.0)..";send_pull;"..S("Send tube pull messages")..";"..pull.."]"..
		"checkbox["..(x + 0.1)..","..(y + 3.4)..";send_overflow;"..S("Send overflow messages")..";"..overflow.."]"
end

local function get_infotext_fs(editing, meta)
	local infotext = minetest.formspec_escape(meta:get_string("infotext"))
	if editing then
		return "image_button[0,0.1;0.8,0.8;technic_checkmark_icon.png;save_infotext;]"..
			"field[1,0.3;4,1;infotext;;"..infotext.."]"
	else
		return "image_button[0,0.1;0.8,0.8;technic_pencil_icon.png;edit_infotext;]"..
			"label[1,0;"..infotext.."]"
	end
end

local function get_autosort_fs(x, meta)
	if meta:get_int("autosort") == 1 then
		return "button["..x..",0;2,1;autosort;"..S("Auto-sort is On").."]"
	else
		return "button["..x..",0;2,1;autosort;"..S("Auto-sort is Off").."]"
	end
end

local function get_sort_fs(x, meta)
	local mode = meta:get_int("sort_mode")
	local fs = "button["..(x + 2)..",0;1,1;sort;"..S("Sort").."]"
	if mode == 1 then
		return fs.."button["..x..",0;2,1;sort_mode;"..S("Sort by Quantity").."]"
	elseif mode == 2 then
		return fs.."button["..x..",0;2,1;sort_mode;"..S("Sort by Type").."]"
	elseif mode == 3 then
		return fs.."button["..x..",0;2,1;sort_mode;"..S("Sort by Wear").."]"
	else
		return fs.."button["..x..",0;2,1;sort_mode;"..S("Sort by Item").."]"
	end
end

function technic.chests.get_formspec(data)
	local formspec = {}
	local top_width = (data.infotext and 6 or 0) + (data.autosort and 2 or 0) + (data.sort and 3 or 0)
	local bottom_width = (data.quickmove and 3 or 0) + ((data.color or data.digilines) and 3 or 0) + 8
	local width = math.max(top_width, bottom_width, data.width)
	local padding = (width - bottom_width) / 2
	if data.quickmove and (data.color or data.digilines) then
		padding = (width - bottom_width) / 4
	elseif data.quickmove or data.color or data.digilines then
		padding = (width - bottom_width) / 3
	end
	local player_inv_left = padding
	if data.quickmove then
		player_inv_left = padding + 3 + padding
	end
	local player_inv_top = data.height + (has_pipeworks and 1.6 or 1.3)
	local height = data.height + (has_pipeworks and 5.4 or 5.1)
	local chest_inv_left = (width - data.width) / 2
	formspec.base =
		"size["..width..","..height.."]"..
		"list[context;main;"..chest_inv_left..",1;"..data.width..","..data.height..";]"..
		"list[current_player;main;"..player_inv_left..","..player_inv_top..";8,4;]"..
		"listring[context;main]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(player_inv_left, player_inv_top)
	if data.quickmove then
		formspec.base = formspec.base..get_quickmove_fs(padding, data.height + 1.2)
	end
	formspec.padding = padding
	formspec.width = width
	return formspec
end

function technic.chests.update_formspec(pos, data, edit_infotext)
	local formspec = data.formspec.base
	local meta = minetest.get_meta(pos)
	if data.infotext then
		formspec = formspec..get_infotext_fs(edit_infotext, meta)
	end
	if data.sort then
		formspec = formspec..get_sort_fs(data.formspec.width - 3, meta)
		if data.autosort then
			formspec = formspec..get_autosort_fs(data.formspec.width - 5, meta)
		end
	end
	if has_pipeworks then
		local offset = data.quickmove and (data.formspec.padding * 2 + 3) or data.formspec.padding
		formspec = formspec..get_pipeworks_fs(offset, data.height + 1, meta)
	end
	if data.color or data.digilines then
		local offset = data.quickmove and (data.formspec.padding * 3 + 11) or (data.formspec.padding * 2 + 8)
		if data.color then
			formspec = formspec..get_color_fs(offset, data.height + 1.2, meta)
		else
			formspec = formspec..get_digilines_fs(offset, data.height + 1.2, meta)
		end
	end
	meta:set_string("formspec", formspec)
end

function technic.chests.get_receive_fields(data)
	return function(pos, formname, fields, player)
		if not fields or not player then
			return
		end
		local meta = minetest.get_meta(pos)
		local chest_inv = meta:get_inventory()
		local player_inv = player:get_inventory()
		if fields.quit then
			if meta:get_int("autosort") == 1 then
				technic.chests.sort_inv(chest_inv, meta:get_int("sort_mode"))
			end
			technic.chests.update_formspec(pos, data)
			return
		end
		if not technic.chests.change_allowed(pos, player, data.locked, data.protected) then
			return
		end
		if data.sort and fields.sort then
			technic.chests.sort_inv(chest_inv, meta:get_int("sort_mode"))
			return
		end
		if data.quickmove then
			if fields.all_to_chest then
				local moved_items = technic.chests.move_inv(player_inv, chest_inv)
				if data.digilines and meta:get_int("send_put") == 1 then
					technic.chests.send_digiline_message(pos, "put", player, moved_items)
				end
				technic.chests.log_inv_change(pos, player:get_player_name(), "put", "stuff")
				return
			elseif fields.all_to_inv then
				local moved_items = technic.chests.move_inv(chest_inv, player_inv)
				if data.digilines and meta:get_int("send_take") == 1 then
					technic.chests.send_digiline_message(pos, "take", player, moved_items)
				end
				technic.chests.log_inv_change(pos, player:get_player_name(), "take", "stuff")
				return
			elseif fields.existing_to_chest then
				local items = technic.chests.get_inv_items(chest_inv)
				local moved_items = technic.chests.move_inv(player_inv, chest_inv, items)
				if data.digilines and meta:get_int("send_put") == 1 then
					technic.chests.send_digiline_message(pos, "put", player, moved_items)
				end
				technic.chests.log_inv_change(pos, player:get_player_name(), "put", "stuff")
				return
			end
		end
		if not technic.chests.change_allowed(pos, player, data.locked, true) then
			return  -- Protect settings from being changed, even for open chests
		end
		if has_pipeworks then
			pipeworks.fs_helpers.on_receive_fields(pos, fields)
		end
		if data.sort and fields.sort_mode then
			local value = meta:get_int("sort_mode") + 1
			if value < 0 or value > 3 then
				value = 0
			end
			meta:set_int("sort_mode", value)
		end
		if data.autosort and fields.autosort then
			local value = meta:get_int("autosort") == 1 and 0 or 1
			meta:set_int("autosort", value)
		end
		if data.color then
			for i = 1, 16 do
				if fields["color_button"..i] then
					local node = minetest.get_node(pos)
					if technic.chests.colors[i] then
						node.name = data.node_name.."_"..technic.chests.colors[i][1]
					else
						node.name = data.node_name
					end
					minetest.swap_node(pos, node)
					meta:set_int("color", i)
					break
				end
			end
		end
		if data.digilines then
			if fields.save_channel and fields.channel then
				meta:set_string("channel", fields.channel)
			end
			for _,setting in pairs({"send_put", "send_take", "send_inject", "send_pull", "send_overflow"}) do
				if fields[setting] then
					local value = fields[setting] == "true" and 1 or 0
					meta:set_int(setting, value)
				end
			end
		end
		if data.infotext then
			if fields.edit_infotext then
				technic.chests.update_formspec(pos, data, true)
				return
			elseif fields.save_infotext and fields.infotext then
				meta:set_string("infotext", fields.infotext)
			end
		end
		technic.chests.update_formspec(pos, data)
	end
end
