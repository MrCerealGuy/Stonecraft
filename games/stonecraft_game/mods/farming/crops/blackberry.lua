
local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:blackberry", {
	description = S("Blackberries"),
	inventory_image = "farming_blackberry.png",
	groups = {
		compostability = 48, seed = 2, food_blackberries = 1, food_blackberry = 1,
		food_berry = 1
	},
	on_use = minetest.item_eat(1),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:blackberry_1")
	end
})

farming.add_eatable("farming:blackberry", 1)

-- crop definition

local def = {
	description = S("Blackberry") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_blackberry_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
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

minetest.register_node("farming:blackberry_1", table.copy(def))

-- stage 2

def.tiles = {"farming_blackberry_2.png"}
minetest.register_node("farming:blackberry_2", table.copy(def))

-- stage 3

def.tiles = {"farming_blackberry_3.png"}
minetest.register_node("farming:blackberry_3", table.copy(def))

-- stage 4 (final)

def.tiles = {"farming_blackberry_4.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:blackberry 2"}, rarity = 1},
		{items = {"farming:blackberry"}, rarity = 2},
		{items = {"farming:blackberry"}, rarity = 3},
	}
}
minetest.register_node("farming:blackberry_4", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:blackberry"] = {
	crop = "farming:blackberry",
	seed = "farming:blackberry",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 4
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
		scale = farming.blackberry,
		spread = {x = 100, y = 100, z = 100},
		seed = 567,
		octaves = 3,
		persist = 0.6
	},
	y_min = 3, y_max = 20,
	decoration = "farming:blackberry_4"
})
