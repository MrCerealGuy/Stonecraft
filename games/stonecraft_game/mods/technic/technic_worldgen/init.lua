--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-05-27 MrCerealGuy: added intllib support

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_technic = world_conf:get("enable_technic")

if enable_technic ~= nil and enable_technic == "false" then
	minetest.log("info", "[technic:worldgen] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

local modpath = minetest.get_modpath("technic_worldgen")

technic = rawget(_G, "technic") or {}

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

dofile(modpath.."/config.lua")
dofile(modpath.."/nodes.lua")
dofile(modpath.."/oregen.lua")
dofile(modpath.."/crafts.lua")

-- Rubber trees, moretrees also supplies these
if not minetest.get_modpath("moretrees") then
	dofile(modpath.."/rubber.lua")
else
	-- older versions of technic provided rubber trees regardless
	minetest.register_alias("technic:rubber_sapling", "moretrees:rubber_tree_sapling")
	minetest.register_alias("technic:rubber_tree_empty", "moretrees:rubber_tree_trunk_empty")
end

-- mg suppport
if minetest.get_modpath("mg") then
	dofile(modpath.."/mg.lua")
end

