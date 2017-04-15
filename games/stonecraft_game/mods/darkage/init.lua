--[[

2017-02-05 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_darkage = world_conf:get("enable_darkage")

if enable_darkage ~= nil and enable_darkage == "false" then
	minetest.log("info", "[darkage] skip loading mod.")
	return
else
	minetest.run_cppmod("darkage")	
end
