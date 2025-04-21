-- this file is basically a modified copy of
-- minetest_game/mods/default/furnaces.lua

local def--, def_active
if minetest.get_modpath("default") then
	def = table.copy(minetest.registered_nodes["default:furnace"])
	--def_active = table.copy(minetest.registered_nodes["default:furnace_active"])
elseif minetest.get_modpath("hades_furnaces") then
	def = table.copy(minetest.registered_nodes["hades_furnaces:furnace"])
	--def_active = table.copy(minetest.registered_nodes["hades_furnaces:furnace_active"])
end

local tube_entry = "^pipeworks_tube_connection_stony.png"

local groups = def.groups
groups["tubedevice"] = 1
groups["tubedevice_receiver"] = 1
local groups_active = table.copy(groups)
groups_active["not_in_creative_inventory"] = 1

--
-- Node definitions
--

local override = {
	tiles = {
		"default_furnace_top.png"..tube_entry,
		"default_furnace_bottom.png"..tube_entry,
		"default_furnace_side.png"..tube_entry,
		"default_furnace_side.png"..tube_entry,
		"default_furnace_side.png"..tube_entry,
		"default_furnace_front.png"
	},
	groups = groups,
	tube = {
		insert_object = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local timer = minetest.get_node_timer(pos)
			if not timer:is_started() then
				timer:start(1.0)
			end
			if direction.y == 1 then
				return inv:add_item("fuel", stack)
			else
				return inv:add_item("src", stack)
			end
		end,
		can_insert = function(pos,node,stack,direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if direction.y == 1 then
				return inv:room_for_item("fuel", stack)
			else
				if meta:get_int("split_material_stacks") == 1 then
					stack = stack:peek_item(1)
				end
				return inv:room_for_item("src", stack)
			end
		end,
		input_inventory = "dst",
		connect_sides = {left = 1, right = 1, back = 1, bottom = 1, top = 1}
	},

	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig,
	on_rotate = pipeworks.on_rotate
}

local override_active = {
	tiles = {
		"default_furnace_top.png"..tube_entry,
		"default_furnace_bottom.png"..tube_entry,
		"default_furnace_side.png"..tube_entry,
		"default_furnace_side.png"..tube_entry,
		"default_furnace_side.png"..tube_entry,
		{
			image = "default_furnace_front_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}
	},
	groups = groups_active,
	tube = {
		insert_object = function(pos,node,stack,direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local timer = minetest.get_node_timer(pos)
			if not timer:is_started() then
				timer:start(1.0)
			end
			if direction.y == 1 then
				return inv:add_item("fuel", stack)
			else
				return inv:add_item("src", stack)
			end
		end,
		can_insert = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if direction.y == 1 then
				return inv:room_for_item("fuel", stack)
			else
				return inv:room_for_item("src", stack)
			end
		end,
		input_inventory = "dst",
		connect_sides = {left = 1, right = 1, back = 1, bottom = 1, top = 1}
	},

	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig,
	on_rotate = pipeworks.on_rotate
}

if minetest.get_modpath("default") then
	minetest.override_item("default:furnace", override)
	minetest.override_item("default:furnace_active", override_active)
elseif minetest.get_modpath("hades_furnaces") then
	minetest.override_item("hades_furnaces:furnace", override)
	minetest.override_item("hades_furnaces:furnace_active", override_active)
end

