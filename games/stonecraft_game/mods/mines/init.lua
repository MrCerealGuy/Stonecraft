--[[

2017-02-05 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_mines = world_conf:get("enable_mines")

if enable_mines ~= nil and enable_mines == "false" then
	minetest.log("info", "[mines] skip loading mod.")
	return
else
	minetest.run_cppmod("mines")
end
