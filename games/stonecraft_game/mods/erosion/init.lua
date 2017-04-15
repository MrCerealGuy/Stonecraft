-- Terrain erosion mechanics using moreblocks' slope blocks

--[[

2016-11-28 modified by MrCerealGuy <mrcerealguy@gmx.de>
	some modifications
	
2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_erosion = world_conf:get("enable_erosion")

if enable_erosion ~= nil and enable_erosion == "false" then
	minetest.log("info", "[erosions] skip loading mod.")
	return
else
	minetest.run_cppmod("erosion")	
end