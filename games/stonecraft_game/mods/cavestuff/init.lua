--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("caverealms") then return end

-----------------------------------------------------------------------------------------------
local title		= "Cave Stuff"
local version 	= "0.0.3"
local mname		= "cavestuff"
-----------------------------------------------------------------------------------------------

dofile(minetest.get_modpath("cavestuff").."/nodes.lua")
dofile(minetest.get_modpath("cavestuff").."/mapgen.lua")

-----------------------------------------------------------------------------------------------

print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
