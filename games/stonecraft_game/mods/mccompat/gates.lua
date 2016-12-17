-- this is taken from ethereal

-- Node Box coords
local nb_gap = 	{
		{-1, 0.1875, -0.0625, -0.5, 0.3125, 0.0625},
		{-1, -0.1875, -0.0625, -0.5, -0.3125, 0.0625},
		{0.5, 0.1875, -0.0625, 1, 0.3125, 0.0625},
		{0.5, -0.1875, -0.0625, 1, -0.3125, 0.0625}
		}

local nb_pil = 	{
		{0.5, -0.5, -0.09375, 0.5625, 0.5, 0.09375},
		{-0.5625, -0.5, -0.09375, -0.5, 0.5, 0.09375},
		{-0.5, -0.3125, -0.0625, -0.375, 0.3125, 0.0625},
		{0.375, -0.3125, -0.0625, 0.5, 0.3125, 0.0625}
		}

-- Open/Close Gates
function gate_rightclick(pos, node)
	local gate, open = unpack(string.split(node.name, "_", 2))
	local gate = gate.."_"
	local sound, name
	if open == "open" then
		sound = "close"
		name = "closed"
	else
		sound = "open"
		name = "open"
	end
	node.name = gate..name
	minetest.set_node(pos, node)
	minetest.sound_play("doors_door_"..sound, {
		pos = pos,
		gain = 0.3,
		max_hear_distance = 10
	})
end

--[[
local gates = {
	{"wood", "Wood", "default_wood.png", "default:wood"},
	{"junglewood", "Jungle Wood", "default_junglewood.png", "default:junglewood"},
	{"scorched", "Scorched", "scorched_tree.png", "ethereal:scorched_tree"},
	{"frostwood", "Frost Wood", "frost_wood.png", "ethereal:frost_wood"},
	{"redwood", "Redwood", "redwood_wood.png", "ethereal:redwood_wood"},
	{"willow", "Willow", "willow_wood.png", "ethereal:willow_wood"},
	{"yellowwood", "Healing Wood", "yellow_wood.png", "ethereal:yellow_wood"},
	{"palm", "Palm Wood", "moretrees_palm_wood.png", "ethereal:palm_wood"},
	{"banana", "Banana Wood", "banana_wood.png", "ethereal:banana_wood"},
	{"mushroom", "Mushroom", "mushroom_trunk.png", "ethereal:mushroom_trunk"},
	{"acacia", "Acacia Wood", "moretrees_acacia_wood.png", "ethereal:acacia_wood"},
	{"pine", "Pine Wood", "default_pinewood.png", "default:pinewood"},
}

for _, row in pairs(gates) do
--]]

-- row needs to contain:  {gate_name, description, texture, node_name_craft_indigrent}
mccompat.register_gate = function( row )

minetest.register_node("mccompat:"..row[1].."gate_open", {
	tiles = {row[3]},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = true,
	groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_inventory = 1},
	drop = "mccompat:"..row[1].."gate_closed",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.3125, 0.4375, -0.375, 0.3125, 0.5},
			{0.375, -0.3125, 0.4375, 0.5, 0.3125, 0.5},
			{-0.5, 0.1875, 0.0625, -0.375, 0.3125, 0.4375},
			{-0.5, -0.1875, 0.0625, -0.375, -0.3125, 0.4375},
			{0.375, 0.1875, 0.0625, 0.5, 0.3125, 0.4375},
			{0.375, -0.1875, 0.0625, 0.5, -0.3125, 0.4375},
			nb_pil[1], nb_pil[2],
			nb_pil[3], nb_pil[4],
			nb_gap[1], nb_gap[2],
			nb_gap[3], nb_gap[4],
			}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.3125, -0.0625, -0.375, 0.3125, 0.5},
			{0.375, -0.3125, -0.0625, 0.5, 0.3125, 0.5},
			}
	},
	on_rightclick = gate_rightclick,
})

minetest.register_node("mccompat:"..row[1].."gate_closed", {
	description = row[2].." Gate",
	tiles = {row[3]},
	inventory_image = "default_gate_overlay.png^"..row[3].."^default_gate_overlay.png^[makealpha:255,126,126",
	wield_image = "default_gate_overlay.png^"..row[3].."^default_gate_overlay.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = true,
	groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			nb_pil[1], nb_pil[2],
			nb_pil[3], nb_pil[4],
			{-0.0625, -0.3125, -0.0625, 0.0625, 0.3125, 0.0625},
			{-1, 0.1875, -0.0625, 1, 0.3125, 0.0625},
			{-1, -0.1875, -0.0625, 1, -0.3125, 0.0625},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {{-0.5, -0.3125, -0.0625, 0.5, 0.3125, 0.0625}}
	},
	on_rightclick = gate_rightclick,
})

minetest.register_craft({
	output = "mccompat:"..row[1].."gate_closed",
	recipe = {
		 {"group:stick", row[4], "group:stick"},
		 {"group:stick", row[4], "group:stick"},
	}
})

end
