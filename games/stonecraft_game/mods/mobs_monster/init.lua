if core.skip_mod("mobs_monster") then return end

-- Load support for intllib.
local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"

local S = minetest.get_translator and minetest.get_translator("mobs_monster") or
		dofile(path .. "intllib.lua")

mobs.intllib = S


-- Check for custom mob spawn file
local input = io.open(path .. "spawn.lua", "r")

if input then
	mobs.custom_spawn_monster = true
	input:close()
	input = nil
end


-- Monsters

if core.get_mod_setting("mobs_monster_dirt_monster") 	~= "false" then dofile(path .. "/dirt_monster.lua") 	end -- PilzAdam
if core.get_mod_setting("mobs_monster_dungeon_master") 	~= "false" then dofile(path .. "/dungeon_master.lua") end
if core.get_mod_setting("mobs_monster_oerkki") 			~= "false" then dofile(path .. "/oerkki.lua") 		end
if core.get_mod_setting("mobs_monster_sand_monster") 	~= "false" then dofile(path .. "/sand_monster.lua") 	end
if core.get_mod_setting("mobs_monster_tone_monster") 	~= "false" then dofile(path .. "/stone_monster.lua") 	end
if core.get_mod_setting("mobs_monster_tree_monster") 	~= "false" then dofile(path .. "/tree_monster.lua") 	end
if core.get_mod_setting("mobs_monster_lava_flan") 		~= "false" then dofile(path .. "/lava_flan.lua") 		end -- Zeg9
if core.get_mod_setting("mobs_monster_mese_monster") 	~= "false" then dofile(path .. "/mese_monster.lua") 	end
if core.get_mod_setting("mobs_monster_spider") 			~= "false" then dofile(path .. "/spider.lua") 		end -- AspireMint

-- Load custom spawning
if mobs.custom_spawn_monster then
	dofile(path .. "spawn.lua")
end


-- Lucky Blocks
dofile(path .. "lucky_block.lua")


print (S("[MOD] Mobs Redo Monsters loaded"))
