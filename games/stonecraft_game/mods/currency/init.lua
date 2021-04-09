local modpath = minetest.get_modpath("currency")

minetest.log("info", "Currency mod loading...")

currency = {}
if minetest.global_exists("default") then
	currency.node_sound_wood_defaults = default.node_sound_wood_defaults
else
	currency.node_sound_wood_defaults = function() end
end

dofile(modpath.."/craftitems.lua")
minetest.log("info", "[Currency] Craft_items Loaded!")
dofile(modpath.."/shop.lua")
minetest.log("info", "[Currency] Shop Loaded!")
dofile(modpath.."/barter.lua")
minetest.log("info", "[Currency] Barter Loaded!")
dofile(modpath.."/safe.lua")
minetest.log("info", "[Currency] Safe Loaded!")
dofile(modpath.."/crafting.lua")
minetest.log("info", "[Currency] Crafting Loaded!")

if minetest.settings:get_bool("creative_mode") then
	minetest.log("info", "[Currency] Creative mode in use, skipping basic income.")
else
	dofile(modpath.."/income.lua")
	minetest.log("info", "[Currency] Income Loaded!")
end
