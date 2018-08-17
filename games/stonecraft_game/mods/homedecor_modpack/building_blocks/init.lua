--[[

2017-06-30 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("homedecor") then return end

local S = homedecor_i18n.gettext
local modpath = minetest.get_modpath("building_blocks")

dofile(modpath.."/alias.lua")
dofile(modpath.."/node_stairs.lua")
dofile(modpath.."/others.lua")
dofile(modpath.."/recipes.lua")