-- Basic materials mod
-- by Vanessa Dannenberg

-- This mod supplies all those little random craft items that everyone always
-- seems to need, such as metal bars (ala rebar), plastic, wire, and so on.

basic_materials = {}
basic_materials.mod = { author = "Vanessa Dannenberg" }
basic_materials.modpath = minetest.get_modpath("basic_materials")

dofile(basic_materials.modpath .. "/nodes.lua")
dofile(basic_materials.modpath .. "/craftitems.lua")
dofile(basic_materials.modpath .. "/crafts.lua")
dofile(basic_materials.modpath .. "/aliases.lua")