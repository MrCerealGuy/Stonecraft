
--[[

2018-08-27 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("spawners_ores") then return end

MOD_NAME = minetest.get_current_modname()

-- API
dofile(minetest.get_modpath(MOD_NAME).."/api.lua")

-- Spawners for ores
dofile(minetest.get_modpath(MOD_NAME).."/spawners_ores.lua")

print ("[Mod] Spawners Ores Loaded.")
