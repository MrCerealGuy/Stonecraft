--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-05-18 MrCerealGuy: added intllib support

--]]

if core.skip_mod("nssb") then return end

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--Nssb
nssb = {}
local path = minetest.get_modpath("nssb")
dofile(path.."/nodes.lua")
dofile(path.."/mapgen.lua")
dofile(path.."/spawn.lua")
