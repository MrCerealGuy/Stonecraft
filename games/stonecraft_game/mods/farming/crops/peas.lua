
-- Textures for peas and their crop were done by Andrey01

local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:pea_pod", {
	description = S("Pea Pod"),
	inventory_image = "farming_pea_pod.png",
	groups = {compostability = 48, seed = 2, food_peas = 1, food_pea_pod = 1},
	on_use = minetest.item_eat(1),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:pea_1")
	end
})

farming.add_eatable("farming:pea_pod", 1)

-- replacement for separate peas item that was removed

minetest.register_alias("farming:peas", "farming:pea_pod")

-- crop definition

local def = {
	description = S("Pea") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_pea_1.png"},
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
		handy = 1, snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults()
}

-- stage 1

minetest.register_node("farming:pea_1", table.copy(def))

-- stage 2

def.tiles = {"farming_pea_2.png"}
minetest.register_node("farming:pea_2", table.copy(def))

-- stage 3

def.tiles = {"farming_pea_3.png"}
minetest.register_node("farming:pea_3", table.copy(def))

-- stage 4

def.tiles = {"farming_pea_4.png"}
minetest.register_node("farming:pea_4", table.copy(def))

-- stage 5 (final)

def.tiles = {"farming_pea_5.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:pea_pod 2"}, rarity = 1},
		{items = {"farming:pea_pod"}, rarity = 2},
		{items = {"farming:pea_pod"}, rarity = 3}
	}
}
minetest.register_node("farming:pea_5", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:pea_pod"] = {
	crop = "farming:pea",
	seed = "farming:pea_pod",
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
		scale = farming.peas,
		spread = {x = 100, y = 100, z = 100},
		seed = 132,
		octaves = 3,
		persist = 0.6
	},
	y_min = 25, y_max = 55,
	decoration = "farming:pea_5"
})
