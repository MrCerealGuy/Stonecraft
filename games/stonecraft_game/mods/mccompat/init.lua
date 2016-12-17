

mccompat = {}

local mccompat_modpath = minetest.get_modpath( "mccompat");

dofile(mccompat_modpath.."/gates.lua")
dofile(mccompat_modpath.."/pressure_plates.lua")
dofile(mccompat_modpath.."/liquids.lua")
dofile(mccompat_modpath.."/blocklist.lua")

