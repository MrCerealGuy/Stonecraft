--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("surprise") then return end

treasurer.register_treasure("flowers:flower_pot",0.1,2.5,{1,5})
