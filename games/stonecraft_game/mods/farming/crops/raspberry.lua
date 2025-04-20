
local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:raspberries", {
	description = S("Raspberries"),
	inventory_image = "farming_raspberries.png",
	groups = {
		compostability = 48, seed = 2, food_raspberries = 1, food_raspberry = 1,
		food_berry = 1
	},
	on_use = minetest.item_eat(1),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:raspberry_1")
	end
})

farming.add_eatable("farming:raspberries", 1)

-- crop definition

local def = {
	description = S("Raspberry") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_raspberry_1.png"},
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

minetest.register_node("farming:raspberry_1", table.copy(def))

-- stage 2

def.tiles = {"farming_raspberry_2.png"}
minetest.register_node("farming:raspberry_2", table.copy(def))

-- stage 3

def.tiles = {"farming_raspberry_3.png"}
minetest.register_node("farming:raspberry_3", table.copy(def))

-- stage 4 (final)

def.tiles = {"farming_raspberry_4.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:raspberries 2"}, rarity = 1},
		{items = {"farming:raspberries"}, rarity = 2},
		{items = {"farming:raspberries"}, rarity = 3}
	}
}
minetest.register_node("farming:raspberry_4", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:raspberries"] = {
	crop = "farming:raspberry",
	seed = "farming:raspberries",
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
		scale = farming.raspberry,
		spread = {x = 100, y = 100, z = 100},
		seed = 687,
		octaves = 3,
		persist = 0.6
	},
	y_min = 3, y_max = 15,
	decoration = "farming:raspberry_4"
})
