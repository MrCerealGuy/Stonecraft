if core.skip_mod("mobs_monster") then return end

local path = minetest.get_modpath("mobs_monster")

-- Intllib
local S
if minetest.global_exists("intllib") then
	if intllib.make_gettext_pair then
		-- New method using gettext.
		S = intllib.make_gettext_pair()
	else
		-- Old method using text files.
		S = intllib.Getter()
	end
else
	S = function(s) return s end
end
mobs.intllib = S

-- Monsters

if core.get_mod_setting("enable_mobs_monster_dirt_monster") 	~= "false" then dofile(path .. "/dirt_monster.lua") 	end -- PilzAdam
if core.get_mod_setting("enable_mobs_monster_dungeon_master") 	~= "false" then dofile(path .. "/dungeon_master.lua") end
if core.get_mod_setting("enable_mobs_monster_oerkki") 			~= "false" then dofile(path .. "/oerkki.lua") 		end
if core.get_mod_setting("enable_mobs_monster_sand_monster") 	~= "false" then dofile(path .. "/sand_monster.lua") 	end
if core.get_mod_setting("enable_mobs_monster_tone_monster") 	~= "false" then dofile(path .. "/stone_monster.lua") 	end
if core.get_mod_setting("enable_mobs_monster_tree_monster") 	~= "false" then dofile(path .. "/tree_monster.lua") 	end
if core.get_mod_setting("enable_mobs_monster_lava_flan") 		~= "false" then dofile(path .. "/lava_flan.lua") 		end -- Zeg9
if core.get_mod_setting("enable_mobs_monster_mese_monster") 	~= "false" then dofile(path .. "/mese_monster.lua") 	end
if core.get_mod_setting("enable_mobs_monster_spider") 			~= "false" then dofile(path .. "/spider.lua") 		end -- AspireMint

dofile(path .. "/lucky_block.lua")

print ("[MOD] Mobs Redo 'Monsters' loaded")
