--This creates the livingfloatlands object.
naturalbiomes = {}

--This creates the naturalbiomes.settings object, and fills it with either the menu selected choices as defined in settingtypes.txt, or default values, (In this case, false).
naturalbiomes.settings = {
	clear_biomes			= minetest.settings:get_bool("livingfloatlands.clear_biomes") or false,
	clear_decos			= minetest.settings:get_bool("livingfloatlands.clear_decos") or false,
	clear_ores			= minetest.settings:get_bool("livingfloatlands.clear_ores") or false,
}

if naturalbiomes.settings.clear_biomes then
	minetest.clear_registered_biomes()
end
if naturalbiomes.settings.clear_decos then
	minetest.clear_registered_decorations()
end
if naturalbiomes.settings.clear_ores then
	minetest.clear_registered_ores()
end

local modname = "livingfloatlands"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

-- Load support for intllib.
local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"

local S = minetest.get_translator and minetest.get_translator("livingfloatlands") or
		dofile(path .. "intllib.lua")

mobs.intllib = S


-- Check for custom mob spawn file
local input = io.open(path .. "spawn.lua", "r")

if input then
	mobs.custom_spawn_livingfloatlands = true
	input:close()
	input = nil
end


-- Animals
dofile(path .. "carnotaurus.lua") -- 
dofile(path .. "nigersaurus.lua") -- 
dofile(path .. "deinotherium.lua") -- 
dofile(path .. "mammooth.lua") -- 
dofile(path .. "gastornis.lua") -- 
dofile(path .. "woollyrhino.lua") -- 
dofile(path .. "velociraptor.lua") -- 
dofile(path .. "triceratops.lua") -- 
dofile(path .. "smilodon.lua") -- 
dofile(path .. "parasaurolophus.lua") -- 
dofile(path .. "gigantopithecus.lua") -- 
dofile(path .. "wildhorse.lua") -- 
dofile(path .. "entelodon.lua") -- 
dofile(path .. "oviraptor.lua") -- 
dofile(path .. "stegosaurus.lua") -- 
dofile(path .. "ankylosaurus.lua") -- 
dofile(path .. "lycaenops.lua") -- 
dofile(path .. "tyrannosaurus.lua") -- 
dofile(path .. "cavebear.lua") -- 
dofile(path .. "rhamphorhynchus.lua") -- 
dofile(path .. "coldsteppe.lua") -- 
dofile(path .. "paleodesert.lua") -- 
dofile(path .. "giantforest.lua") -- 
dofile(path .. "coldgiantforest.lua") -- 
dofile(path .. "paleojungle.lua") -- 
dofile(path .. "dye.lua") -- 
dofile(path .. "leafdecay.lua") -- 
dofile(path .. "hunger.lua") -- 



-- Load custom spawning
if mobs.custom_spawn_livingfloatlands then
	dofile(path .. "spawn.lua")
end



print (S("[MOD] Mobs Redo Animals loaded"))
