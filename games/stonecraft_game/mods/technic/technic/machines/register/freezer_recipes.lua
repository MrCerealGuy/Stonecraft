--[[

2019-02-11 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

technic.register_recipe_type("freezing", { description = S("Freezing") })

function technic.register_freezer_recipe(data)
	data.time = data.time or 5
	technic.register_recipe("freezing", data)
end

local recipes = {
	{"bucket:bucket_water", { "default:ice", "bucket:bucket_empty" } },
	{"bucket:bucket_river_water", { "default:ice", "bucket:bucket_empty" } },
	{"default:dirt", "default:dirt_with_snow" },
	{"bucket:bucket_lava", { "default:obsidian", "bucket:bucket_empty" } }
}

for _, data in pairs(recipes) do
	technic.register_freezer_recipe({input = {data[1]}, output = data[2]})
end

