--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-05-17 MrCerealGuy: added intllib support

--]]

if core.skip_mod("mesecons") then return end

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- The POWER_PLANT
-- Just emits power. always.

minetest.register_node("mesecons_powerplant:power_plant", {
	drawtype = "plantlike",
	visual_scale = 1,
	tiles = {"jeija_power_plant.png"},
	inventory_image = "jeija_power_plant.png",
	paramtype = "light",
	walkable = false,
	groups = {dig_immediate=3, mesecon = 2},
	light_source = default.LIGHT_MAX-9,
    	description=S("Power Plant"),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, -0.5+0.7, 0.3},
	},
	sounds = default.node_sound_leaves_defaults(),
	mesecons = {receptor = {
		state = mesecon.state.on
	}}
})

minetest.register_craft({
	output = "mesecons_powerplant:power_plant 1",
	recipe = {
		{"group:mesecon_conductor_craftable"},
		{"group:mesecon_conductor_craftable"},
		{"group:sapling"},
	}
})
