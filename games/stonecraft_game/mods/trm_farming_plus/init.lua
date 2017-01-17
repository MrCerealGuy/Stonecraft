--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_surprise = world_conf:get("enable_surprise")

if enable_surprise ~= nil and enable_surprise == "false" then
	minetest.log("info", "[trm_farming_plus] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

-- weed
treasurer.register_treasure("farming:weed",0.2,0.1,{1,20})
treasurer.register_treasure("farming:weed",0.2,0.1,{1,20})

-- seeds
treasurer.register_treasure("farming_plus:strawberry_seed",0.02,3.9,{1,5})
treasurer.register_treasure("farming_plus:rhubarb_seed",0.02,4.1,{1,5})
treasurer.register_treasure("farming_plus:potatoe_seed",0.02,4.2,{1,5})
treasurer.register_treasure("farming_plus:tomato_seed",0.02,4,{1,5})
treasurer.register_treasure("farming_plus:orange_seed",0.02,3.9,{1,5})
treasurer.register_treasure("farming_plus:carrot_seed",0.02,3.9,{1,5})

-- 
treasurer.register_treasure("farming_plus:banana_sapling",0.02,5)
treasurer.register_treasure("farming_plus:cocoa_sapling",0.02,5)

-- fruit and stuff
treasurer.register_treasure("farming:pumpkin",0.0555,3.5,1)
treasurer.register_treasure("farming_plus:banana",0.08,3.3,{1,2})
treasurer.register_treasure("farming_plus:carrot_item",0.12,2.3,{1,3})
treasurer.register_treasure("farming_plus:cocoa_bean",0.02,1,{10,20})
treasurer.register_treasure("farming_plus:cocoa",0.02,2,{1,2})
treasurer.register_treasure("farming_plus:orange",0.07,3,{1,3})
treasurer.register_treasure("farming_plus:tomato",0.1,3,{1,3})
treasurer.register_treasure("farming_plus:strawberry",0.1,2.5,{1,6})
treasurer.register_treasure("farming_plus:potatoe_item",0.15,1,{1,5})
treasurer.register_treasure("farming_plus:rhubarb_item",0.1,1,{1,5})

-- comestibles
treasurer.register_treasure("farming:pumpkin_bread",0.01,4,1)
treasurer.register_treasure("farming:pumpkin_flour",0.011,1,1)
