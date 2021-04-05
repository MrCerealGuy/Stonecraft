if core.skip_mod("mobs_npc") then return end

-- Load support for intllib.
local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"

local S = minetest.get_translator and minetest.get_translator("mobs_npc") or
		dofile(path .. "intllib.lua")

mobs.intllib = S

-- NPC
if core.get_mod_setting("mobs_npc_npc") 	~= "false" then dofile(path .. "/npc.lua")	end -- TenPlus1
if core.get_mod_setting("mobs_npc_trader") 	~= "false" then dofile(path .. "/trader.lua") end
if core.get_mod_setting("mobs_npc_igor") 	~= "false" then dofile(path .. "/igor.lua")	end

-- Check for custom mob spawn file
local input = io.open(path .. "spawn.lua", "r")

if input then
	mobs.custom_spawn_npc = true
	input:close()
	input = nil
end


-- NPCs
dofile(path .. "npc.lua") -- TenPlus1
dofile(path .. "trader.lua")
dofile(path .. "igor.lua")


-- Load custom spawning
if mobs.custom_spawn_npc then
	dofile(path .. "spawn.lua")
end


-- Lucky Blocks
dofile(path .. "/lucky_block.lua")


print (S("[MOD] Mobs Redo NPCs loaded"))
