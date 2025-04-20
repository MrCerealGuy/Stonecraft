
--[[
	Original textures from Crops Plus mod
	Copyright (C) 2018 Grizzly Adam
	https://forum.minetest.net/viewtopic.php?f=9&t=19488
]]

local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:onion", {
	description = S("Onion"),
	inventory_image = "crops_onion.png",
	groups = {compostability = 48, seed = 2, food_onion = 1},
	on_use = minetest.item_eat(1),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:onion_1")
	end
})

farming.add_eatable("farming:onion", 1)

-- crop definition

local def = {
	description = S("Onion") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"crops_onion_plant_1.png"},
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 3,
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	waving = 1,
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

minetest.register_node("farming:onion_1", table.copy(def))

-- stage 2

def.tiles = {"crops_onion_plant_2.png"}
minetest.register_node("farming:onion_2", table.copy(def))

-- stage 3

def.tiles = {"crops_onion_plant_3.png"}
minetest.register_node("farming:onion_3", table.copy(def))

-- stage 4

def.tiles = {"crops_onion_plant_4.png"}
minetest.register_node("farming:onion_4", table.copy(def))

-- stage 5

def.tiles = {"crops_onion_plant_5.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:onion 2"}, rarity = 1},
		{items = {"farming:onion"}, rarity = 2},
		{items = {"farming:onion"}, rarity = 4}
	}
}
minetest.register_node("farming:onion_5", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:onion"] = {
	crop = "farming:onion",
	seed = "farming:onion",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 5
}

-- mapgen

minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"default:dirt_with_grass", "mcl_core:dirt_with_grass", "ethereal:prairie_dirt"
	},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.onion,
		spread = {x = 100, y = 100, z = 100},
		seed = 912,
		octaves = 3,
		persist = 0.6
	},
	y_min = 5, y_max = 28,
	decoration = "farming:onion_5"
})
