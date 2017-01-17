--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_surprise = world_conf:get("enable_surprise")

if enable_surprise ~= nil and enable_surprise == "false" then
	minetest.log("info", "[trm_tnt] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

-- registers TNT and gunpowder

treasurer.register_treasure("tnt:tnt",0.05,5,1)
treasurer.register_treasure("tnt:gunpowder",0.123,3,{1,10})
