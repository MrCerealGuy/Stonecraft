--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_surprise = world_conf:get("enable_surprise")

if enable_surprise ~= nil and enable_surprise == "false" then
	minetest.log("info", "[trm_farming] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

treasurer.register_treasure("farming:hoe_wood",0.01,2,nil,nil,"tool")
treasurer.register_treasure("farming:hoe_stone",0.030,2.2,nil,nil,"tool")
treasurer.register_treasure("farming:hoe_steel",0.05,2.4,nil,nil,"tool")
treasurer.register_treasure("farming:hoe_bronze",0.004,2.6,nil,nil,"tool")

treasurer.register_treasure("farming:seed_cotton",0.006,2,{1,4},nil,"seed")
treasurer.register_treasure("farming:seed_wheat",0.01,3,{1,3},nil,"seed")

treasurer.register_treasure("farming:wheat",0.02,0.8,{1,3},nil,"raw_food")
treasurer.register_treasure("farming:flour",0.01,1.8,{1,3},nil,"raw_food")
treasurer.register_treasure("farming:bread",0.006,2,{1,2},nil,"raw_food")

treasurer.register_treasure("farming:string",0.06,1,{1,4},nil,"crafting_component")
