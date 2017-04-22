--[[


2016-05-03 modified by MrCerealGuy <mrcerealguy@gmx.de>
	removed flying_duck

--]] 

--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_nssm = world_conf:get("enable_nssm")

if enable_nssm ~= nil and enable_nssm == "false" then
	minetest.log("info", "[nssm] skip loading mod.")
	return
else
	minetest.run_cppmod("nssm")
end
