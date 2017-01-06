--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_woodsoils = world_conf:get("enable_woodsoils")

if enable_woodsoils ~= nil and enable_woodsoils == "false" then
	minetest.log("info", "[woodsoils] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------
local title		= "Wood Soils" -- former "Forest Soils"
local version 	= "0.0.9"
local mname		= "woodsoils" -- former "forestsoils"
-----------------------------------------------------------------------------------------------

abstract_woodsoils = {}

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