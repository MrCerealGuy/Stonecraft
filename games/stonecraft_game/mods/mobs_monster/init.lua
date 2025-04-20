
-- translation and mod path

local S = minetest.get_translator("mobs_monster")
local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"

-- Check for custom mob spawn file

local input = io.open(path .. "spawn.lua", "r")

if input then
	mobs.custom_spawn_monster = true
	input:close()
	input = nil
end

-- helper function

local function ddoo(mob)

	if minetest.settings:get_bool("mobs_monster." .. mob) == false then
		print("[Mobs_Monster] " .. mob .. " disabled!")
		return
	end

	dofile(path .. mob .. ".lua")
end

-- Monsters

ddoo("dirt_monster") -- PilzAdam
ddoo("dungeon_master")
ddoo("oerkki")
ddoo("sand_monster")
ddoo("stone_monster")
ddoo("tree_monster")
ddoo("lava_flan") -- Zeg9
ddoo("mese_monster")
ddoo("spider") -- AspireMint
ddoo("land_guard")
ddoo("fire_spirit")

-- Load custom spawning if found

if mobs.custom_spawn_monster then
	dofile(path .. "spawn.lua")
end

-- Lucky Blocks

if minetest.get_modpath("lucky_block") then
	dofile(path .. "lucky_block.lua")
end

print ("[MOD] Mobs Redo Monsters loaded")
