-----------------------------------------------------------------------------------------------
local title		= "Cave Stuff"
local version	= "0.0.3"
local mname		= "cavestuff"
-----------------------------------------------------------------------------------------------

-- support for i18n
local S = minetest.get_translator("cavestuff")

dofile(minetest.get_modpath("cavestuff").."/nodes.lua")
dofile(minetest.get_modpath("cavestuff").."/mapgen.lua")

-----------------------------------------------------------------------------------------------

print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
