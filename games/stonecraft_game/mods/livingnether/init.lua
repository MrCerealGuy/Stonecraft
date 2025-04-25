--This creates the livingnether object.
livingnether = {}

--This creates the naturalbiomes.settings object, and fills it with either the menu selected choices as defined in settingtypes.txt, or default values, (In this case, false).
livingnether.settings = {
	clear_biomes			= minetest.settings:get_bool("livingnether.clear_biomes") or false,
	clear_decos			= minetest.settings:get_bool("livingnether.clear_decos") or false,
	clear_ores			= minetest.settings:get_bool("livingnether.clear_ores") or false,
}

livingnether.MAX_HEIGHT = nether.DEPTH_CEILING
livingnether.MIN_HEIGHT = nether.FLOOR_CEILING

if livingnether.settings.clear_biomes then
	minetest.clear_registered_biomes()
end
if livingnether.settings.clear_decos then
	minetest.clear_registered_decorations()
end
if livingnether.settings.clear_ores then
	minetest.clear_registered_ores()
end

local modname = "livingnether"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")



-- Load support for intllib.
local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"

local S = minetest.get_translator and minetest.get_translator("livingnether") or
		dofile(path .. "intllib.lua")

mobs.intllib = S


-- Check for custom mob spawn file
local input = io.open(path .. "spawn.lua", "r")

if input then
	mobs.custom_spawn_livingnether = true
	input:close()
	input = nil
end


-- Animals
dofile(path .. "razorback.lua") --
dofile(path .. "lavawalker.lua") --
dofile(path .. "tardigrade.lua") --
dofile(path .. "flyingrod.lua") --
dofile(path .. "cyst.lua") --
dofile(path .. "whip.lua") --
dofile(path .. "noodlemaster.lua") --
dofile(path .. "sokaarcher.lua") --
dofile(path .. "sokameele.lua") --



-- Load custom spawning
if mobs.custom_spawn_livingnether then
	dofile(path .. "spawn.lua")
end



print (S("[MOD] Mobs Redo Animals loaded"))
