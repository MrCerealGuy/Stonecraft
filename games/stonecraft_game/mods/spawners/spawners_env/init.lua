MOD_NAME = minetest.get_current_modname()

-- Spawners configurations
dofile(minetest.get_modpath(MOD_NAME).."/config.lua")

-- API
dofile(minetest.get_modpath(MOD_NAME).."/api.lua")

-- Spawners for mobs
dofile(minetest.get_modpath(MOD_NAME).."/spawners_env.lua")
dofile(minetest.get_modpath(MOD_NAME).."/spawners_gen.lua")

print ("[Mod] Spawners Environmental Loaded.")