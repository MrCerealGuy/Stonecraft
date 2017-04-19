--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_forests = world_conf:get("enable_forests")

if enable_forests ~= nil and enable_forests == "false" then
	minetest.log("info", "[forest] skip loading mod.")
	return
else
	minetest.run_cppmod("forest")	
end