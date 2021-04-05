-- this bit of code modifies the default chests and furnaces to be compatible
-- with pipeworks.
--
-- the formspecs found here are basically copies of the ones from minetest_game
-- plus bits from pipeworks' sorting tubes

-- Pipeworks Specific
local fs_helpers = pipeworks.fs_helpers
local tube_entry = "^pipeworks_tube_connection_wooden.png"

-- Chest Locals
local open_chests = {}

local function get_chest_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec =
		"size[8,9]" ..
		default.gui_bg ..
		default.gui_bg_img ..
		default.gui_slots ..
		"list[nodemeta:" .. spos .. ";main;0,0.3;8,4;]" ..
		"list[current_player;main;0,4.85;8,1;]" ..
		"list[current_player;main;0,6.08;8,3;8]" ..
		"listring[nodemeta:" .. spos .. ";main]" ..
		"listring[current_player;main]" ..
		default.get_hotbar_bg(0,4.85)

	-- Pipeworks Switch
	formspec = formspec ..
		fs_helpers.cycling_button(
			minetest.get_meta(pos),
			pipeworks.button_base,
			"splitstacks",
			{
				pipeworks.button_off,
				pipeworks.button_on
			}
		)..pipeworks.button_label

	return formspec
end

local function chest_lid_obstructed(pos)
	local above = { x = pos.x, y = pos.y + 1, z = pos.z }
	local def = minetest.registered_nodes[minetest.get_node(above).name]
	-- allow ladders, signs, wallmounted things and torches to not obstruct
	if not def then return true end
	if def.drawtype == "airlike" or
			def.drawtype == "signlike" or
			def.drawtype == "torchlike" or
			(def.drawtype == "nodebox" and def.paramtype2 == "wallmounted") then
		return false
	end
	return true
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "pipeworks:chest_formspec" and player then
		local pn = player:get_player_name()
		if open_chests[pn] then
			local pos = open_chests[pn].pos
			if fields.quit then
				local sound = open_chests[pn].sound
				local swap = open_chests[pn].swap
				local node = minetest.get_node(pos)

				open_chests[pn] = nil
				for _, v in pairs(open_chests) do
					if v.pos.x == pos.x and v.pos.y == pos.y and v.pos.z == pos.z then
						return true
					end
				end
				minetest.after(0.2, function()
					minetest.swap_node(pos, { name = "default:" .. swap, param2 = node.param2 })

					-- Pipeworks notification
					pipeworks.after_place(pos)
				end)
				minetest.sound_play(sound, {gain = 0.3, pos = pos, max_hear_distance = 10})
			elseif pipeworks.may_configure(pos, player) then
				-- Pipeworks Switch
				fs_helpers.on_receive_fields(pos, fields)
				minetest.show_formspec(player:get_player_name(), "pipeworks:chest_formspec", get_chest_formspec(pos))
			end
			return true
		end
	end
end)

-- Original Definitions
local old_chest_def = table.copy(minetest.registered_items["default:chest"])
local old_chest_open_def = table.copy(minetest.registered_items["default:chest_open"])
local old_chest_locked_def = table.copy(minetest.registered_items["default:chest_locked"])
local old_chest_locked_open_def = table.copy(minetest.registered_items["default:chest_locked_open"])

-- Override Construction
local override_protected, override, override_open, override_protected_open
override_protected = {
	tiles = {
		"default_chest_top.png"..tube_entry,
		"default_chest_top.png"..tube_entry,
		"default_chest_side.png"..tube_entry,
		"default_chest_side.png"..tube_entry,
		"default_chest_lock.png",
		"default_chest_inside.png"
	},
	after_place_node = function(pos, placer)
		old_chest_locked_def.after_place_node(pos, placer)
		pipeworks.after_place(pos)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if not default.can_interact_with_node(clicker, pos) then
			return itemstack
		end

		minetest.sound_play(old_chest_locked_def.sound_open, {gain = 0.3,
				pos = pos, max_hear_distance = 10})
		if not chest_lid_obstructed(pos) then
			minetest.swap_node(pos,
					{ name = "default:" .. "chest_locked" .. "_open",
					param2 = node.param2 })
		end
		minetest.after(0.2, minetest.show_formspec,
				clicker:get_player_name(),
				"pipeworks:chest_formspec", get_chest_formspec(pos))
		open_chests[clicker:get_player_name()] = { pos = pos,
				sound = old_chest_locked_def.sound_close, swap = "chest_locked" }
	end,
	groups = table.copy(old_chest_locked_def.groups),
	tube = {
		insert_object = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:add_item("main", stack)
		end,
		can_insert = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if meta:get_int("splitstacks") == 1 then
				stack = stack:peek_item(1)
			end
			return inv:room_for_item("main", stack)
		end,
		input_inventory = "main",
		connect_sides = {left = 1, right = 1, back = 1, bottom = 1, top = 1}
	},
	after_dig_node = pipeworks.after_dig,
	on_rotate = pipeworks.on_rotate
}
override = {
	tiles = {
		"default_chest_top.png"..tube_entry,
		"default_chest_top.png"..tube_entry,
		"default_chest_side.png"..tube_entry,
		"default_chest_side.png"..tube_entry,
		"default_chest_front.png",
		"default_chest_inside.png"
	},
	on_rightclick = function(pos, node, clicker)
		minetest.sound_play(old_chest_def.sound_open, {gain = 0.3, pos = pos,
				max_hear_distance = 10})
		if not chest_lid_obstructed(pos) then
			minetest.swap_node(pos, {
					name = "default:" .. "chest" .. "_open",
					param2 = node.param2 })
		end
		minetest.after(0.2, minetest.show_formspec,
				clicker:get_player_name(),
				"pipeworks:chest_formspec", get_chest_formspec(pos))
		open_chests[clicker:get_player_name()] = { pos = pos,
				sound = old_chest_def.sound_close, swap = "chest" }
	end,
	groups = table.copy(old_chest_def.groups),
	tube = {
		insert_object = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:add_item("main", stack)
		end,
		can_insert = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if meta:get_int("splitstacks") == 1 then
				stack = stack:peek_item(1)
			end
			return inv:room_for_item("main", stack)
		end,
		input_inventory = "main",
		connect_sides = {left = 1, right = 1, back = 1, bottom = 1, top = 1}
	},
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig,
	on_rotate = pipeworks.on_rotate
}
--[[local override_common = {

}
for k,v in pairs(override_common) do
	override_protected[k] = v
	override[k] = v
end]]

override_open = table.copy(override)
override_open.groups = table.copy(old_chest_open_def.groups)
override_open.tube = table.copy(override.tube)
override_open.tube.connect_sides = table.copy(override.tube.connect_sides)
override_open.tube.connect_sides.top = nil

override_protected_open = table.copy(override_protected)
override_protected_open.groups = table.copy(old_chest_locked_open_def.groups)
override_protected_open.tube = table.copy(override_protected.tube)
override_protected_open.tube.connect_sides = table.copy(override_protected.tube.connect_sides)
override_protected_open.tube.connect_sides.top = nil

override_protected.tiles = { -- Rearranged according to the chest registration in Minetest_Game.
	"default_chest_top.png"..tube_entry,
	"default_chest_top.png"..tube_entry,
	"default_chest_side.png"..tube_entry.."^[transformFX",
	"default_chest_side.png"..tube_entry,
	"default_chest_side.png"..tube_entry,
	"default_chest_lock.png",
}
override.tiles = {
	"default_chest_top.png"..tube_entry,
	"default_chest_top.png"..tube_entry,
	"default_chest_side.png"..tube_entry.."^[transformFX",
	"default_chest_side.png"..tube_entry,
	"default_chest_side.png"..tube_entry,
	"default_chest_front.png",
}

-- Add the extra groups
for _,v in ipairs({override_protected, override, override_open, override_protected_open}) do
	v.groups.tubedevice = 1
	v.groups.tubedevice_receiver = 1
end

-- Override with the new modifications.
minetest.override_item("default:chest", override)
minetest.override_item("default:chest_open", override_open)
minetest.override_item("default:chest_locked", override_protected)
minetest.override_item("default:chest_locked_open", override_protected_open)

