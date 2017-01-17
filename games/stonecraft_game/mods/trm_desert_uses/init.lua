--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_surprise = world_conf:get("enable_surprise")

if enable_surprise ~= nil and enable_surprise == "false" then
	minetest.log("info", "[trm_desert_uses] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

--[[ registers the desert stone tools ]]
treasurer.register_treasure("desert_uses:pick_desert_stone",0.018,3)
treasurer.register_treasure("desert_uses:axe_desert_stone",0.019,3)
treasurer.register_treasure("desert_uses:shovel_desert_stone",0.05,3)
treasurer.register_treasure("desert_uses:sword_desert_stone",0.016,3)
