--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_surprise = world_conf:get("enable_surprise")

if enable_surprise ~= nil and enable_surprise == "false" then
	minetest.log("info", "[trm_vessels] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

treasurer.register_treasure("vessels:glass_bottle",0.005,1,{1,3},nil,"deco")
treasurer.register_treasure("vessels:drinking_glass",0.005,1,{1,12},nil,"deco")
treasurer.register_treasure("vessels:steel_bottle",0.0045,2,1,nil,"deco")

treasurer.register_treasure("vessels:glass_fragments",0.01,1,{1,8},nil,"crafting_component")
