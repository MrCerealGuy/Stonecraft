--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("surprise") then return end

treasurer.register_treasure("bucket:bucket_empty",0.01,3.5,{1,3},nil,"tool")
