--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("trm_screwdriver") then return end

treasurer.register_treasure("screwdriver:screwdriver",0.02,3,{1,2},nil,"tool")
