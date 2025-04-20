
local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:garlic_clove", {
	description = S("Garlic clove"),
	inventory_image = "crops_garlic_clove.png",
	groups = {compostability = 35, seed = 2, food_garlic_clove = 1, flammable = 3},

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:garlic_1")
	end
})

-- crop definition

local def = {
	description = S("Garlic") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"crops_garlic_plant_1.png"},
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 3,
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

minetest.register_node("farming:garlic_1", table.copy(def))

-- stage 2

def.tiles = {"crops_garlic_plant_2.png"}
minetest.register_node("farming:garlic_2", table.copy(def))

-- stage 3

def.tiles = {"crops_garlic_plant_3.png"}
minetest.register_node("farming:garlic_3", table.copy(def))

-- stage 4

def.tiles = {"crops_garlic_plant_4.png"}
minetest.register_node("farming:garlic_4", table.copy(def))

-- stage 5

def.tiles = {"crops_garlic_plant_5.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:garlic 2"}, rarity = 1},
		{items = {"farming:garlic"}, rarity = 2},
		{items = {"farming:garlic"}, rarity = 3}
	}
}
minetest.register_node("farming:garlic_5", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:garlic"] = {
	crop = "farming:garlic",
	seed = "farming:garlic_clove",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 5
}

-- mapgen

minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"default:dirt_with_grass", "mcl_core:dirt_with_grass", "ethereal:prairie_dirt",
		"default:dirt_with_rainforest_litter"
	},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.garlic,
		spread = {x = 100, y = 100, z = 100},
		seed = 467,
		octaves = 3,
		persist = 0.6
	},
	y_min = 3, y_max = 45,
	decoration = "farming:garlic_5",
	spawn_by = "group:tree", num_spawn_by = 1
})
