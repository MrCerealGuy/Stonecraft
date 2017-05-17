--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-05-17 MrCerealGuy: added intllib support

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_mesecons = world_conf:get("enable_mesecons")

if enable_mesecons ~= nil and enable_mesecons == "false" then
	minetest.log("info", "[mesecons:insulated] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

function insulated_wire_get_rules(node)
	local rules = 	{{x = 1,  y = 0,  z = 0},
			 {x =-1,  y = 0,  z = 0}}
	if node.param2 == 1 or node.param2 == 3 then
		return mesecon.rotate_rules_right(rules)
	end
	return rules
end

minetest.register_node("mesecons_insulated:insulated_on", {
	drawtype = "nodebox",
	description = S("Insulated Mesecon"),
	tiles = {
		"jeija_insulated_wire_sides_on.png",
		"jeija_insulated_wire_sides_on.png",
		"jeija_insulated_wire_ends_on.png",
		"jeija_insulated_wire_ends_on.png",
		"jeija_insulated_wire_sides_on.png",
		"jeija_insulated_wire_sides_on.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = { -16/32-0.001, -18/32, -7/32, 16/32+0.001, -12/32, 7/32 }
	},
	node_box = {
		type = "fixed",
		fixed = { -16/32-0.001, -17/32, -3/32, 16/32+0.001, -13/32, 3/32 }
	},
	groups = {dig_immediate = 3, not_in_creative_inventory = 1},
	drop = "mesecons_insulated:insulated_off",
	mesecons = {conductor = {
		state = mesecon.state.on,
		offstate = "mesecons_insulated:insulated_off",
		rules = insulated_wire_get_rules
	}}
})

minetest.register_node("mesecons_insulated:insulated_off", {
	drawtype = "nodebox",
	description = S("Insulated Mesecon"),
	tiles = {
		"jeija_insulated_wire_sides_off.png",
		"jeija_insulated_wire_sides_off.png",
		"jeija_insulated_wire_ends_off.png",
		"jeija_insulated_wire_ends_off.png",
		"jeija_insulated_wire_sides_off.png",
		"jeija_insulated_wire_sides_off.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = { -16/32-0.001, -18/32, -7/32, 16/32+0.001, -12/32, 7/32 }
	},
	node_box = {
		type = "fixed",
		fixed = { -16/32-0.001, -17/32, -3/32, 16/32+0.001, -13/32, 3/32 }
	},
	groups = {dig_immediate = 3},
	mesecons = {conductor = {
		state = mesecon.state.off,
		onstate = "mesecons_insulated:insulated_on",
		rules = insulated_wire_get_rules
	}}
})

minetest.register_craft({
	output = "mesecons_insulated:insulated_off 3",
	recipe = {
		{"mesecons_materials:fiber", "mesecons_materials:fiber", "mesecons_materials:fiber"},
		{"mesecons:wire_00000000_off", "mesecons:wire_00000000_off", "mesecons:wire_00000000_off"},
		{"mesecons_materials:fiber", "mesecons_materials:fiber", "mesecons_materials:fiber"},
	}
})
