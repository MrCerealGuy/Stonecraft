--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("trm_tnt") then return end

-- registers TNT and gunpowder

treasurer.register_treasure("tnt:tnt",0.05,5,1)
treasurer.register_treasure("tnt:gunpowder",0.123,3,{1,10})
