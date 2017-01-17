--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_surprise = world_conf:get("enable_surprise")

if enable_surprise ~= nil and enable_surprise == "false" then
	minetest.log("info", "[trm_food] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

treasurer.register_treasure("food:bowl",0.12,2)

treasurer.register_treasure("food:chocolate_powder",0.02,3,{1,5})
treasurer.register_treasure("food:sugar",0.1,1,{4,29})
treasurer.register_treasure("food:cakemix_plain",0.01,5)
treasurer.register_treasure("food:cakemix_choco",0.01,5)
treasurer.register_treasure("food:cakemix_carrot",0.01,5)
treasurer.register_treasure("food:cakemix_cheese",0.01,5)

treasurer.register_treasure("food:dark_chocolate",0.02,3,{1,5})
treasurer.register_treasure("food:milk_chocolate",0.03,3,{1,5})
treasurer.register_treasure("food:pasta",0.01,3.4,1)
treasurer.register_treasure("food:butter",0.05,2.5,{1,2})
treasurer.register_treasure("food:cheese",0.04,2.75,{1,3})
treasurer.register_treasure("food:apple_juice",0.15,2.2,1)
treasurer.register_treasure("food:cactus_juice",0.125,2.2,1)
treasurer.register_treasure("food:rainbow_juice",0.000001,5)
