
--[[

2017-05-14 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- mushroom soup (Heals 1 heart)
minetest.register_craftitem("ethereal:mushroom_soup", {
	description = S("Mushroom Soup"),
	inventory_image = "mushroom_soup.png",
	on_use = minetest.item_eat(5, "ethereal:bowl"),
})

minetest.register_craft({
	output = "ethereal:mushroom_soup",
	recipe = {
		{"flowers:mushroom_brown"},
		{"flowers:mushroom_brown"},
		{"group:food_bowl"},
	}
})

-- 4x red mushrooms make mushroom block
minetest.register_craft({
	output = "ethereal:mushroom",
	recipe = {
		{"flowers:mushroom_red", "flowers:mushroom_red"},
		{"flowers:mushroom_red", "flowers:mushroom_red"},
	}
})