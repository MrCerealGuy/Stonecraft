--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-05-17 MrCerealGuy: added intllib support

--]]

if core.skip_mod("mesecons") then return end

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local lightstone_rules = {
	{x=0,  y=0,  z=-1},
	{x=1,  y=0,  z=0},
	{x=-1, y=0,  z=0},
	{x=0,  y=0,  z=1},
	{x=1,  y=1,  z=0},
	{x=1,  y=-1, z=0},
	{x=-1, y=1,  z=0},
	{x=-1, y=-1, z=0},
	{x=0,  y=1,  z=1},
	{x=0,  y=-1, z=1},
	{x=0,  y=1,  z=-1},
	{x=0,  y=-1, z=-1},
	{x=0,  y=-1, z=0},
}

function mesecon.lightstone_add(name, desc, base_item, texture_off, texture_on)
	minetest.register_node("mesecons_lightstone:lightstone_" .. name .. "_off", {
		tiles = {texture_off},
		groups = {cracky=2, mesecon_effector_off = 1, mesecon = 2},
		description=desc..S(" Lightstone"),
		sounds = default.node_sound_stone_defaults(),
		mesecons = {effector = {
			rules = lightstone_rules,
			action_on = function (pos, node)
				minetest.swap_node(pos, {name = "mesecons_lightstone:lightstone_" .. name .. "_on", param2 = node.param2})
			end,
		}}
	})
	minetest.register_node("mesecons_lightstone:lightstone_" .. name .. "_on", {
	tiles = {texture_on},
	groups = {cracky=2,not_in_creative_inventory=1, mesecon = 2},
	drop = "mesecons_lightstone:lightstone_" .. name .. "_off",
	light_source = default.LIGHT_MAX-2,
	sounds = default.node_sound_stone_defaults(),
	mesecons = {effector = {
		rules = lightstone_rules,
		action_off = function (pos, node)
			minetest.swap_node(pos, {name = "mesecons_lightstone:lightstone_" .. name .. "_off", param2 = node.param2})
		end,
	}}
	})

	minetest.register_craft({
		output = "mesecons_lightstone:lightstone_" .. name .. "_off",
		recipe = {
			{"",base_item,""},
			{base_item,"default:torch",base_item},
			{"","group:mesecon_conductor_craftable",""}
		}
	})
end


mesecon.lightstone_add("red", S("Red"), "dye:red", "jeija_lightstone_red_off.png", "jeija_lightstone_red_on.png")
mesecon.lightstone_add("green", S("Green"), "dye:green", "jeija_lightstone_green_off.png", "jeija_lightstone_green_on.png")
mesecon.lightstone_add("blue", S("Blue"), "dye:blue", "jeija_lightstone_blue_off.png", "jeija_lightstone_blue_on.png")
mesecon.lightstone_add("gray", S("Gray"), "dye:grey", "jeija_lightstone_gray_off.png", "jeija_lightstone_gray_on.png")
mesecon.lightstone_add("darkgray", S("Darkgray"), "dye:dark_grey", "jeija_lightstone_darkgray_off.png", "jeija_lightstone_darkgray_on.png")
mesecon.lightstone_add("yellow", S("Yellow"), "dye:yellow", "jeija_lightstone_yellow_off.png", "jeija_lightstone_yellow_on.png")
