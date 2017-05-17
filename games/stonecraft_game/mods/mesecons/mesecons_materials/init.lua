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
	minetest.log("info", "[mesecons:materials] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- Glue and fiber
minetest.register_craftitem("mesecons_materials:glue", {
	image = "mesecons_glue.png",
	on_place_on_ground = minetest.craftitem_place_item,
    	description=S("Glue"),
})

minetest.register_craftitem("mesecons_materials:fiber", {
	image = "mesecons_fiber.png",
	on_place_on_ground = minetest.craftitem_place_item,
    	description=S("Fiber"),
})

minetest.register_craft({
	output = "mesecons_materials:glue 2",
	type = "cooking",
	recipe = "group:sapling",
	cooktime = 2
})

minetest.register_craft({
	output = "mesecons_materials:fiber 6",
	type = "cooking",
	recipe = "mesecons_materials:glue",
	cooktime = 4
})

-- Silicon
minetest.register_craftitem("mesecons_materials:silicon", {
	image = "mesecons_silicon.png",
	on_place_on_ground = minetest.craftitem_place_item,
    	description=S("Silicon"),
})

minetest.register_craft({
	output = "mesecons_materials:silicon 4",
	recipe = {
		{"group:sand", "group:sand"},
		{"group:sand", "default:steel_ingot"},
	}
})
