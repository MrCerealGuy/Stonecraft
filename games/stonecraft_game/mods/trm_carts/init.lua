--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("surprise") then return end

treasurer.register_treasure("carts:powerrail",0.02,6,{1,2})
treasurer.register_treasure("carts:brakerail",0.02,5.2,{1,2})
treasurer.register_treasure("carts:cart",0.01,4,1)
