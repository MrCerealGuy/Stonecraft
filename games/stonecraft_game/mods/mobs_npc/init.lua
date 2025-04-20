
-- translation and get mod path
local S = minetest.get_translator("mobs_npc")
local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"

-- Global
mobs_npc = {}

-- Check for custom mob spawn file

local input = io.open(path .. "spawn.lua", "r")

if input then
	mobs.custom_spawn_npc = true
	input:close()
	input = nil
end

dofile(path .. "functions.lua") -- useful functions
dofile(path .. "npc.lua") -- TenPlus1
dofile(path .. "trader.lua")
dofile(path .. "igor.lua")

-- Load custom spawning if found

if mobs.custom_spawn_npc then
	dofile(path .. "spawn.lua")
end

-- Lucky Blocks

if minetest.get_modpath("lucky_block") then
	dofile(path .. "/lucky_block.lua")
end

print ("[MOD] Mobs Redo NPC's loaded")
