-----------------------------------------------------------------------------------------------
local title		= "Wood Soils" -- former "Forest Soils"
local version	= "0.0.9"
local mname		= "woodsoils" -- former "forestsoils"
-----------------------------------------------------------------------------------------------

abstract_woodsoils = {}

-- support for i18n
local S = plantlife_i18n.gettext

dofile(minetest.get_modpath("woodsoils").."/nodes.lua")
dofile(minetest.get_modpath("woodsoils").."/generating.lua")

-- felt like playing a bit :D
--[[print("  _____                              __")
print("_/ ____\\___________   ____   _______/  |_")
print("\\   __\\/  _ \\_  __ \\_/ __ \\ /  ___/\\   __\\")
print(" |  | (  <_> )  | \\/\\  ___/ \\___ \\  |  |")
print(" |__|  \\____/|__|    \\___  >____  > |__|")
print("                         \\/     \\/")

print("             .__.__")
print("  __________ |__|  |   ______")
print(" /  ___/  _ \\|  |  |  /  ___/")
print(" \\___ (  <_> )  |  |__\\___ \\")
print("/____  >____/|__|____/____  >")
print("     \\/                   \\/")]]

-----------------------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------
