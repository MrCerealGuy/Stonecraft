if core.skip_mod("mobs_redo") then return end

local path = minetest.get_modpath("mobs")

-- Mob API
dofile(path .. "/api.lua")

-- Rideable Mobs
dofile(path .. "/mount.lua")

-- Mob Items
dofile(path .. "/crafts.lua")

-- Mob Spawner
dofile(path .. "/spawner.lua")

-- Lucky Blocks
dofile(path .. "/lucky_block.lua")

minetest.log("action", "[MOD] Mobs Redo loaded")
