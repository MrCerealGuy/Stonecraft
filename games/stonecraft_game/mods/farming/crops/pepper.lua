
--[[
	Original textures from Crops Plus mod
	Copyright (C) 2018 Grizzly Adam
	https://forum.minetest.net/viewtopic.php?f=9&t=19488
]]

local S = minetest.get_translator("farming")

-- seed

minetest.register_craftitem("farming:peppercorn", {
	description = S("Peppercorn"),
	inventory_image = "crops_peppercorn.png",
	groups = {compostability = 48, seed = 1, food_peppercorn = 1, flammable = 3},

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:pepper_1")
	end
})

-- green pepper

minetest.register_craftitem("farming:pepper", {
	description = S("Green Pepper"),
	inventory_image = "crops_pepper.png",
	on_use = minetest.item_eat(2),
	groups = {food_pepper = 1, compostability = 55}
})

farming.add_eatable("farming:pepper", 2)

-- yellow pepper

minetest.register_craftitem("farming:pepper_yellow", {
	description = S("Yellow Pepper"),
	inventory_image = "crops_pepper_yellow.png",
	on_use = minetest.item_eat(3),
	groups = {food_pepper = 1, compostability = 55}
})

farming.add_eatable("farming:pepper_yellow", 3)

-- red pepper

minetest.register_craftitem("farming:pepper_red", {
	description = S("Red Pepper"),
	inventory_image = "crops_pepper_red.png",
	on_use = minetest.item_eat(4),
	groups = {food_pepper = 1, compostability = 55}
})

farming.add_eatable("farming:pepper_red", 4)

-- pepper to peppercorn recipe

minetest.register_craft({
	output = "farming:peppercorn",
	recipe = {{"group:food_pepper"}}
})

-- crop definition

local def = {
	description = S("Pepper") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"crops_pepper_plant_1.png"},
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 1,
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		handy = 1, snappy = 3, flammable = 3, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults()
}

-- stage 1

minetest.register_node("farming:pepper_1", table.copy(def))

-- stage 2

def.tiles = {"crops_pepper_plant_2.png"}
minetest.register_node("farming:pepper_2", table.copy(def))

-- stage 3

def.tiles = {"crops_pepper_plant_3.png"}
minetest.register_node("farming:pepper_3", table.copy(def))

-- stage 4

def.tiles = {"crops_pepper_plant_4.png"}
minetest.register_node("farming:pepper_4", table.copy(def))

-- stage 5 (green pepper)

def.tiles = {"crops_pepper_plant_5.png"}
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:pepper 2"}, rarity = 1},
		{items = {"farming:pepper"}, rarity = 2},
		{items = {"farming:pepper"}, rarity = 3}
	}
}
minetest.register_node("farming:pepper_5", table.copy(def))

-- stage 6 (yellow pepper)

def.tiles = {"crops_pepper_plant_6.png"}
def.drop = {
	items = {
		{items = {"farming:pepper_yellow 2"}, rarity = 1},
		{items = {"farming:pepper_yellow"}, rarity = 2},
		{items = {"farming:pepper_yellow"}, rarity = 3}
	}
}
minetest.register_node("farming:pepper_6", table.copy(def))

-- stage 7 (red pepper - final)

def.tiles = {"crops_pepper_plant_7.png"}
def.groups.growing = nil
def.drop = {
	items = {
		{items = {"farming:pepper_red 2"}, rarity = 1},
		{items = {"farming:pepper_red"}, rarity = 2},
		{items = {"farming:pepper_red"}, rarity = 3}
	}
}
minetest.register_node("farming:pepper_7", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:pepper"] = {
	crop = "farming:pepper",
	seed = "farming:peppercorn",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 5
}

-- mapgen

minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"default:dirt_with_grass", "default:dirt_with_rainforest_litter",
		"mcl_core:dirt_with_grass", "ethereal:prairie_dirt"
	},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.pepper,
		spread = {x = 100, y = 100, z = 100},
		seed = 243,
		octaves = 3,
		persist = 0.6
	},
	y_min = 5, y_max = 35,
	decoration = {"farming:pepper_5", "farming:pepper_6", "farming:pepper_7"},
	spawn_by = "group:tree", num_spawn_by = 1
})
