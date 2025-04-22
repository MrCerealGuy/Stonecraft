
local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end
--local S = minetest.get_translator("technic_chests")

local has_pipeworks = minetest.get_modpath("pipeworks")
local has_digilines = minetest.get_modpath("digilines")
local has_protector = minetest.get_modpath("protector")

local tube_entry = has_pipeworks and "^pipeworks_tube_connection_metallic.png" or ""
local protector_overlay = has_protector and "^protector_logo.png" or "^technic_protector_overlay.png"

local node_groups = {
	snappy = 2,
	choppy = 2,
	oddly_breakable_by_hand = 2,
	tubedevice = 1,
	tubedevice_receiver = 1,
	technic_chest = 1,
}

local node_groups_no_inv = {
	snappy = 2,
	choppy = 2,
	oddly_breakable_by_hand = 2,
	tubedevice = 1,
	tubedevice_receiver = 1,
	technic_chest = 1,
	not_in_creative_inventory = 1,
}

local function get_tiles(name, data, color)
	local tiles = {
		"technic_"..name.."_chest_top.png"..tube_entry,
		"technic_"..name.."_chest_top.png"..tube_entry,
		"technic_"..name.."_chest_side.png"..tube_entry,
		"technic_"..name.."_chest_side.png"..tube_entry,
		"technic_"..name.."_chest_side.png"..tube_entry,
		"technic_"..name.."_chest_front.png"
	}
	if data.color and color then
		tiles[6] = tiles[6].."^technic_chest_overlay_"..technic.chests.colors[color][1]..".png"
	end
	if data.locked then
		tiles[6] = tiles[6].."^technic_"..name.."_chest_lock_overlay.png"
	elseif data.protected then
		tiles[6] = tiles[6]..protector_overlay
	end
	return tiles
end

function technic.chests.register_chest(name, data)
	local lname = name:lower()
	name = S(name)
	if data.digilines and not has_digilines then
		data.digilines = nil
	end
	if data.locked then
		data.node_name = "technic:"..lname.."_locked_chest"
		data.description = S("%s Locked Chest"):format(name)
	elseif data.protected then
		data.node_name = "technic:"..lname.."_protected_chest"
		data.description = S("%s Protected Chest"):format(name)
	else
		data.node_name = "technic:"..lname.."_chest"
		data.description = S("%s Chest"):format(name)
	end
	data.formspec = technic.chests.get_formspec(data)
	local def = {
		description = data.description,
		tiles = get_tiles(lname, data),
		paramtype2 = "facedir",
		legacy_facedir_simple = true,
		groups = node_groups,
		sounds = default.node_sound_wood_defaults(),
		drop = data.node_name,
		after_place_node = function(pos, placer)
			local meta = minetest.get_meta(pos)
			if data.locked then
				local owner = placer:get_player_name() or ""
				meta:set_string("owner", owner)
				meta:set_string("infotext", S("%s Locked Chest (owned by %s)"):format(name, owner))
			else
				meta:set_string("infotext", data.description)
			end
			if has_pipeworks then
				pipeworks.after_place(pos)
			end
		end,
		after_dig_node = function(pos)
			if has_pipeworks then
				pipeworks.after_dig(pos)
			end
		end,
		tube = {
			insert_object = function(pos, node, stack)
				local meta = minetest.get_meta(pos)
				if data.digilines and meta:get_int("send_inject") == 1 then
					technic.chests.send_digiline_message(pos, "inject", nil, {stack:to_table()})
				end
				technic.chests.log_inv_change(pos, "pipeworks tube", "put", stack:get_name())
				return meta:get_inventory():add_item("main", stack)
			end,
			can_insert = function(pos, node, stack)
				local meta = minetest.get_meta(pos)
				if meta:get_int("splitstacks") == 1 then
					stack = stack:peek_item(1)
				end
				local can_insert = meta:get_inventory():room_for_item("main", stack)
				if not can_insert and data.digilines and meta:get_int("send_overflow") == 1 then
					technic.chests.send_digiline_message(pos, "overflow", nil, {stack:to_table()})
				end
				return can_insert
			end,
			remove_items = function(pos, node, stack, dir, count, list, index)
				local meta = minetest.get_meta(pos)
				local item = stack:take_item(count)
				meta:get_inventory():set_stack(list, index, stack)
				if data.digilines and meta:get_int("send_pull") == 1 then
					technic.chests.send_digiline_message(pos, "pull", nil, {item:to_table()})
				end
				technic.chests.log_inv_change(pos, "pipeworks tube", "take", item:get_name())
				return item
			end,
			input_inventory = "main",
			connect_sides = {left=1, right=1, front=1, back=1, top=1, bottom=1},
		},
		on_construct = function(pos)
			local inv = minetest.get_meta(pos):get_inventory()
			inv:set_size("main", data.width * data.height)
			if data.quickmove then
				inv:set_size("quickmove", 1)
			end
			technic.chests.update_formspec(pos, data)
		end,
		can_dig = function(pos, player)
			if not technic.chests.change_allowed(pos, player, data.locked, data.protected) then
				return false
			end
			return minetest.get_meta(pos):get_inventory():is_empty("main")
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			if not technic.chests.change_allowed(pos, player, data.locked, data.protected) then
				return 0
			end
			if data.quickmove and to_list == "quickmove" then
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				local stack = inv:get_stack("main", from_index)
				local moved_items = technic.chests.move_inv(inv, player:get_inventory(), stack:get_name())
				if data.digilines and meta:get_int("send_take") == 1 then
					technic.chests.send_digiline_message(pos, "take", player, moved_items)
				end
				technic.chests.log_inv_change(pos, player:get_player_name(), "take", "stuff")
				return 0
			end
			return count
		end,
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			if not technic.chests.change_allowed(pos, player, data.locked, data.protected) then
				return 0
			end
			if data.quickmove and listname == "quickmove" then
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				local moved_items = technic.chests.move_inv(player:get_inventory(), inv, stack:get_name())
				if data.digilines and meta:get_int("send_put") == 1 then
					technic.chests.send_digiline_message(pos, "put", player, moved_items)
				end
				technic.chests.log_inv_change(pos, player:get_player_name(), "put", "stuff")
				return 0
			end
			return stack:get_count()
		end,
		allow_metadata_inventory_take = function(pos, listname, index, stack, player)
			if not technic.chests.change_allowed(pos, player, data.locked, data.protected) then
				return 0
			end
			return stack:get_count()
		end,
		on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			technic.chests.log_inv_change(pos, player:get_player_name(), "move", "stuff")
		end,
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			if data.digilines and minetest.get_meta(pos):get_int("send_put") == 1 then
				technic.chests.send_digiline_message(pos, "put", player, {stack:to_table()})
			end
			technic.chests.log_inv_change(pos, player:get_player_name(), "put", stack:get_name())
		end,
		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			if data.digilines and minetest.get_meta(pos):get_int("send_take") == 1 then
				technic.chests.send_digiline_message(pos, "take", player, {stack:to_table()})
			end
			technic.chests.log_inv_change(pos, player:get_player_name(), "take", stack:get_name())
		end,
		on_blast = function(pos)
			if data.locked or data.protected then
				return
			end
			local drops = {}
			default.get_inventory_drops(pos, "main", drops)
			drops[#drops+1] = data.node_name
			minetest.remove_node(pos)
			return drops
		end,
		on_receive_fields = technic.chests.get_receive_fields(data),
	}
	if data.locked then
		def.on_skeleton_key_use = function(pos, player, newsecret)
			-- Copied from default chests.lua
			local meta = minetest.get_meta(pos)
			local owner = meta:get_string("owner")
			local player_name = player:get_player_name()
			if owner ~= player_name then
				minetest.record_protection_violation(pos, player_name)
				minetest.chat_send_player(player_name, "You do not own this chest.")
				return nil
			end
			local secret = meta:get_string("key_lock_secret")
			if secret == "" then
				secret = newsecret
				meta:set_string("key_lock_secret", secret)
			end
			return secret, "a locked chest", owner
		end
	end
	if data.digilines then
		def.digiline = {
			receptor = {},
			effector = {
				action = technic.chests.digiline_effector
			},
		}
	end
	minetest.register_node(":"..data.node_name, def)
	if data.color then
		for i = 1, 15 do
			local colordef = {}
			for k, v in pairs(def) do
				colordef[k] = v
			end
			colordef.groups = node_groups_no_inv
			colordef.tiles = get_tiles(lname, data, i)
			minetest.register_node(":"..data.node_name.."_"..technic.chests.colors[i][1], colordef)
		end
	end
end
