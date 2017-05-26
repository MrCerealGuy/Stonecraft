-- Minetest 0.4.7 mod: technic
-- namespace: technic
-- (c) 2012-2013 by RealBadAngel <mk@realbadangel.pl>

--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-05-26 MrCerealGuy: added intllib support

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_technic = world_conf:get("enable_technic")

if enable_technic ~= nil and enable_technic == "false" then
	minetest.log("info", "[technic:technic] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

local load_start = os.clock()

technic = rawget(_G, "technic") or {}
technic.creative_mode = minetest.setting_getbool("creative_mode")


local modpath = minetest.get_modpath("technic")
technic.modpath = modpath

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- Read configuration file
dofile(modpath.."/config.lua")

-- Helper functions
dofile(modpath.."/helpers.lua")

-- Items 
dofile(modpath.."/items.lua")

-- Craft recipes for items 
dofile(modpath.."/crafts.lua")

-- Register functions
dofile(modpath.."/register.lua")

-- Machines
dofile(modpath.."/machines/init.lua")

-- Tools
dofile(modpath.."/tools/init.lua")

-- Aliases for legacy node/item names
dofile(modpath.."/legacy.lua")

if minetest.setting_getbool("log_mods") then
	print(S("[Technic] Loaded in @1 seconds", os.clock() - load_start))
end

