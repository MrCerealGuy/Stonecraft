-- caverealms v.0.8 by HeroOfTheWinds
-- original cave code modified from paramat's subterrain
-- For Minetest 0.4.8 stable
-- Depends default
-- License: code WTFPL

--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-05-02 Added Voxmanip heap api functions

2017-10-10 register_on_generated: added call collectgarbage()

2018-03-21 MrCerealGuy: disallow abms when the server is lagging

--]]

if core.skip_mod("caverealms") then return end

--grab a shorthand for the filepath of the mod
local modpath = minetest.get_modpath(minetest.get_current_modname())

caverealms = {}

--load companion lua files
dofile(modpath.."/config.lua") --configuration file; holds various constants
dofile(modpath.."/crafting.lua")
dofile(modpath.."/falling_ice.lua")
dofile(modpath.."/nodes.lua")
dofile(modpath.."/caverealms_biomes.lua")

local caverealms_def = {
	minimum_depth = caverealms.config.ymax,
	maximum_depth = caverealms.config.ymin,
	cave_threshold = caverealms.config.tcave,
	boundary_blend_range = 128,
	perlin_cave = {
		offset = 0,
		scale = 1,
		spread = {x=256, y=256, z=256},
		seed = -400000000089,
		octaves = 3,
		persist = 0.67
	},
	perlin_wave = {
		offset = 0,
		scale = 1,
		spread = {x=512, y=256, z=512}, -- squashed 2:1
		seed = 59033,
		octaves = 6,
		persist = 0.63
	},
}

subterrane:register_cave_layer(caverealms_def)

if caverealms.config.cavespawn then
	subterrane:register_cave_spawn(caverealms_def, -960)
end