--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("surprise") then return end

treasurer.register_treasure("vessels:glass_bottle",0.005,1,{1,3},nil,"deco")
treasurer.register_treasure("vessels:drinking_glass",0.005,1,{1,12},nil,"deco")
treasurer.register_treasure("vessels:steel_bottle",0.0045,2,1,nil,"deco")

treasurer.register_treasure("vessels:glass_fragments",0.01,1,{1,8},nil,"crafting_component")
