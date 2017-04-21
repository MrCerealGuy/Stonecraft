--[[

2017-02-05 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_villages = world_conf:get("enable_villages")

if enable_villages ~= nil and enable_villages == "false" then
	minetest.log("info", "[mg_villages] skip loading mod.")
	return
else
	minetest.run_cppmod("mg_villages")
end
