
--[[

2017-05-26 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

technic.register_recipe_type("alloy", {
	description = S("Alloying"),
	input_size = 2,
})

function technic.register_alloy_recipe(data)
	data.time = data.time or 6
	technic.register_recipe("alloy", data)
end

local recipes = {
	{"technic:copper_dust 3",         "technic:tin_dust",           "technic:bronze_dust 4"},
	{"default:copper_ingot 3",        "default:tin_ingot",          "default:bronze_ingot 4"},
	{"technic:wrought_iron_dust",     "technic:coal_dust",          "technic:carbon_steel_dust", 3},
	{"technic:wrought_iron_ingot",    "technic:coal_dust",          "technic:carbon_steel_ingot", 3},
	{"technic:carbon_steel_dust",     "technic:coal_dust",          "technic:cast_iron_dust", 3},
	{"technic:carbon_steel_ingot",    "technic:coal_dust",          "technic:cast_iron_ingot", 3},
	{"technic:carbon_steel_dust 3",   "technic:chromium_dust",      "technic:stainless_steel_dust 4"},
	{"technic:carbon_steel_ingot 3",  "technic:chromium_ingot",     "technic:stainless_steel_ingot 4"},
	{"technic:copper_dust 2",         "technic:zinc_dust",          "technic:brass_dust 3"},
	{"default:copper_ingot 2",        "technic:zinc_ingot",         "basic_materials:brass_ingot 3"},
	{"default:sand 2",                "technic:coal_dust 2",        "technic:silicon_wafer"},
	{"technic:silicon_wafer",         "technic:gold_dust",          "technic:doped_silicon_wafer"},
	-- from https://en.wikipedia.org/wiki/Carbon_black
	-- The highest volume use of carbon black is as a reinforcing filler in rubber products, especially tires.
	-- "[Compounding a] pure gum vulcanizate … with 50% of its weight of carbon black improves its tensile strength and wear resistance …"
	{"technic:raw_latex 4",           "technic:coal_dust 2",        "technic:rubber 6", 2},
}

for _, data in pairs(recipes) do
	technic.register_alloy_recipe({input = {data[1], data[2]}, output = data[3], time = data[4]})
end
