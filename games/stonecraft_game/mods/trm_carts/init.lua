--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_surprise = world_conf:get("enable_surprise")

if enable_surprise ~= nil and enable_surprise == "false" then
	minetest.log("info", "[trm_carts] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

treasurer.register_treasure("carts:powerrail",0.02,6,{1,2})
treasurer.register_treasure("carts:brakerail",0.02,5.2,{1,2})
treasurer.register_treasure("carts:cart",0.01,4,1)
