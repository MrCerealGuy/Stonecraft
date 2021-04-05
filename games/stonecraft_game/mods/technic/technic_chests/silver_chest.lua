--[[

2017-05-26 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")


if minetest.get_modpath("moreores") then
	minetest.register_craft({
		output = 'technic:silver_chest',
		recipe = {
			{'moreores:silver_ingot','moreores:silver_ingot','moreores:silver_ingot'},
			{'moreores:silver_ingot','technic:copper_chest','moreores:silver_ingot'},
			{'moreores:silver_ingot','moreores:silver_ingot','moreores:silver_ingot'},
		}
	})

	minetest.register_craft({
		output = 'technic:silver_locked_chest',
		recipe = {
			{'moreores:silver_ingot','moreores:silver_ingot','moreores:silver_ingot'},
			{'moreores:silver_ingot','technic:copper_locked_chest','moreores:silver_ingot'},
			{'moreores:silver_ingot','moreores:silver_ingot','moreores:silver_ingot'},
		}
	})
end

minetest.register_craft({
	output = 'technic:silver_locked_chest',
	type = "shapeless",
	recipe = {
		'basic_materials:padlock',
		'technic:silver_chest',
	}
})

technic.chests:register("Silver", {
	width = 12,
	height = 6,
	sort = true,
	autosort = true,
	infotext = true,
	color = false,
	locked = false,
})

technic.chests:register("Silver", {
	width = 12,
	height = 6,
	sort = true,
	autosort = true,
	infotext = true,
	color = false,
	locked = true,
})

