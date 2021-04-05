--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("mesecons") then return end

dofile(minetest.get_modpath("mesecons_extrawires").."/crossover.lua");
dofile(minetest.get_modpath("mesecons_extrawires").."/tjunction.lua");
dofile(minetest.get_modpath("mesecons_extrawires").."/corner.lua");
dofile(minetest.get_modpath("mesecons_extrawires").."/doublecorner.lua");
dofile(minetest.get_modpath("mesecons_extrawires").."/vertical.lua");
dofile(minetest.get_modpath("mesecons_extrawires").."/mesewire.lua");
