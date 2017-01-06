--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_caverealms = world_conf:get("enable_caverealms")

if enable_caverealms ~= nil and enable_caverealms == "false" then
	minetest.log("info", "[caverealms] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------
local title		= "Cave Stuff"
local version 	= "0.0.3"
local mname		= "cavestuff"
-----------------------------------------------------------------------------------------------

dofile(minetest.get_modpath("cavestuff").."/nodes.lua")
dofile(minetest.get_modpath("cavestuff").."/mapgen.lua")

-----------------------------------------------------------------------------------------------

print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
