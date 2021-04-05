if core.skip_mod("mobs_animals") then return end

-- Load support for intllib.
local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"

local S = minetest.get_translator and minetest.get_translator("mobs_animal") or
		dofile(path .. "intllib.lua")

mobs.intllib = S


-- Check for custom mob spawn file
local input = io.open(path .. "spawn.lua", "r")

if input then
	mobs.custom_spawn_animal = true
	input:close()
	input = nil
end


-- Animals

if core.get_mod_setting("mobs_animal_chicken") 	~= "false" then dofile(path .. "/chicken.lua") 	end -- JKmurray
if core.get_mod_setting("mobs_animal_cow") 	~= "false" then dofile(path .. "/cow.lua") 	end -- KrupnoPavel
if core.get_mod_setting("mobs_animal_rat") 	~= "false" then dofile(path .. "/rat.lua") 	end -- PilzAdam
if core.get_mod_setting("mobs_animal_sheep") 	~= "false" then dofile(path .. "/sheep.lua") 	end -- PilzAdam
if core.get_mod_setting("mobs_animal_warthog") 	~= "false" then dofile(path .. "/warthog.lua") 	end -- KrupnoPavel
if core.get_mod_setting("mobs_animal_bee") 	~= "false" then dofile(path .. "/bee.lua") 	end -- KrupnoPavel
if core.get_mod_setting("mobs_animal_bunny") 	~= "false" then dofile(path .. "/bunny.lua") 	end -- ExeterDad
if core.get_mod_setting("mobs_animal_kitten") 	~= "false" then dofile(path .. "/kitten.lua") 	end -- Jordach/BFD
if core.get_mod_setting("mobs_animal_penguin") 	~= "false" then dofile(path .. "/penguin.lua") 	end -- D00Med
if core.get_mod_setting("mobs_animal_panda") 	~= "false" then dofile(path .. "/panda.lua")	end -- AspireMint

-- Load custom spawning
if mobs.custom_spawn_animal then
	dofile(path .. "spawn.lua")
end


-- Lucky Blocks
dofile(path .. "lucky_block.lua")


print (S("[MOD] Mobs Redo Animals loaded"))
