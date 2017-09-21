if core.skip_mod("mobs_animals") then return end


local path = minetest.get_modpath("mobs_animal")

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")
mobs.intllib = S

-- Animals

if core.get_mod_setting("mobs_animal_chicken") 	~= "false" then dofile(path .. "/chicken.lua") 	end -- JKmurray
if core.get_mod_setting("mobs_animal_cow") 		~= "false" then dofile(path .. "/cow.lua") 		end -- KrupnoPavel
if core.get_mod_setting("mobs_animal_rat") 		~= "false" then dofile(path .. "/rat.lua") 		end -- PilzAdam
if core.get_mod_setting("mobs_animal_sheep") 	~= "false" then dofile(path .. "/sheep.lua") 		end -- PilzAdam
if core.get_mod_setting("mobs_animal_warthog") 	~= "false" then dofile(path .. "/warthog.lua") 	end -- KrupnoPavel
if core.get_mod_setting("mobs_animal_bee") 		~= "false" then dofile(path .. "/bee.lua") 		end -- KrupnoPavel
if core.get_mod_setting("mobs_animal_bunny") 	~= "false" then dofile(path .. "/bunny.lua") 		end -- ExeterDad
if core.get_mod_setting("mobs_animal_kitten") 	~= "false" then dofile(path .. "/kitten.lua") 	end -- Jordach/BFD
if core.get_mod_setting("mobs_animal_penguin") 	~= "false" then dofile(path .. "/penguin.lua") 	end -- D00Med

dofile(path .. "/lucky_block.lua")

print (S("[MOD] Mobs Redo 'Animals' loaded"))
