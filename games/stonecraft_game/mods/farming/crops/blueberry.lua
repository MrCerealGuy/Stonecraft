
local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:blueberries", {
	description = S("Wild Blueberries"),
	inventory_image = "farming_blueberries.png",
	groups = {
		compostability = 48,seed = 2, food_blueberries = 1, food_blueberry = 1,
		food_berry = 1
	},
	on_use = minetest.item_eat(1),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:blueberry_1")
	end
})

farming.add_eatable("farming:blueberries", 1)

-- ctop definition
local def = {
	description = S("Blueberry") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_blueberry_1.png"},
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

minetest.register_node("farming:blueberry_1", table.copy(def))

-- stage 2

def.tiles = {"farming_blueberry_2.png"}
minetest.register_node("farming:blueberry_2", table.copy(def))

-- stage 3

def.tiles = {"farming_blueberry_3.png"}
minetest.register_node("farming:blueberry_3", table.copy(def))

-- stage 4 (final)

def.tiles = {"farming_blueberry_4.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:blueberries 2"}, rarity = 1},
		{items = {"farming:blueberries"}, rarity = 2},
		{items = {"farming:blueberries"}, rarity = 3}
	}
}
minetest.register_node("farming:blueberry_4", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:blueberries"] = {
	crop = "farming:blueberry",
	seed = "farming:blueberries",
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
		scale = farming.blueberry,
		spread = {x = 100, y = 100, z = 100},
		seed = 678,
		octaves = 3,
		persist = 0.6
	},
	y_min = 3, y_max = 15,
	decoration = "farming:blueberry_4"
})
