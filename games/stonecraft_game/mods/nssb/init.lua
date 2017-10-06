--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("nssb") then return end

--Nssb
nssb = {}
local path = minetest.get_modpath("nssb")
dofile(path.."/nodes.lua")
dofile(path.."/mapgen.lua")
dofile(path.."/spawn.lua")
