--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_spawners = world_conf:get("enable_spawners")

if enable_spawners ~= nil and enable_spawners == "false" then
	minetest.log("info", "[spawners] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

-- Main settings
dofile(minetest.get_modpath("spawners").."/settings.txt")

-- Spawners configurations
dofile(minetest.get_modpath("spawners").."/config.lua")

-- API
dofile(minetest.get_modpath("spawners").."/API.lua")

-- Spawners for mobs
dofile(minetest.get_modpath("spawners").."/spawners_mobs.lua")

-- Spawners for ores
dofile(minetest.get_modpath("spawners").."/spawners_ores.lua")

-- include mummy mobs redo addon (mob)
if minetest.get_modpath("mobs") then
	dofile(minetest.get_modpath("spawners").."/mob_mummy.lua")
end

-- Spawners Pyramids
if SPAWN_PYRAMIDS then
	dofile(minetest.get_modpath("spawners").."/pyramids.lua")

	print("[Mod][spawners] Pyramids enabled")
end

-- Add Spawners to dungeons, temples..
if SPAWNERS_GENERATE then
	dofile(minetest.get_modpath("spawners").."/spawners_gen.lua")

	print("[Mod][spawners] Spawners generate enabled")
end

-- Add Chests to dungeons, temples..
if CHESTS_GENERATE then
	dofile(minetest.get_modpath("spawners").."/chests_gen.lua")

	print("[Mod][spawners] Chests generate enabled")
end

print ("[Mod] Spawners 0.6 Loaded.")