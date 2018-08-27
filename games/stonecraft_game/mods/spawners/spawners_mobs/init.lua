
--[[

2018-08-27 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("spawners_mobs") then return end

MOD_NAME = minetest.get_current_modname()

-- Spawners configurations
dofile(minetest.get_modpath(MOD_NAME).."/config.lua")

-- API
dofile(minetest.get_modpath(MOD_NAME).."/api.lua")

-- Spawners for mobs
dofile(minetest.get_modpath(MOD_NAME).."/spawners_mobs.lua")

-- include mummy mobs redo addon (mob)
if minetest.get_modpath("mobs") then
	dofile(minetest.get_modpath(MOD_NAME).."/mob_mummy.lua")
	dofile(minetest.get_modpath(MOD_NAME).."/mob_bunny_evil.lua")
	dofile(minetest.get_modpath(MOD_NAME).."/mob_uruk_hai.lua")
	dofile(minetest.get_modpath(MOD_NAME).."/mob_balrog.lua")
	dofile(minetest.get_modpath(MOD_NAME).."/nodes_additional.lua")
end

print ("[Mod] Spawners Mobs Loaded.")
