local modpath = minetest.get_modpath("currency")

-- internationalization boilerplate
local S, NS = dofile(modpath.."/intllib.lua")

minetest.log("info", S("Currency mod loading..."))

dofile(modpath.."/craftitems.lua")
minetest.log("info", "[Currency] "..S("Craft_items Loaded!"))
dofile(modpath.."/shop.lua")
minetest.log("info", "[Currency] "..S("Shop Loaded!"))
dofile(modpath.."/barter.lua")
minetest.log("info", "[Currency] "..S("Barter Loaded!"))
dofile(modpath.."/safe.lua")
minetest.log("info", "[Currency] "..S("Safe Loaded!"))
dofile(modpath.."/crafting.lua")
minetest.log("info", "[Currency] "..S("Crafting Loaded!"))

if minetest.settings:get_bool("creative_mode") then
	minetest.log("info", "[Currency] "..S("Creative mode in use, skipping basic income."))
else
	dofile(modpath.."/income.lua")
	minetest.log("info", "[Currency] "..S("Income Loaded!"))
end
