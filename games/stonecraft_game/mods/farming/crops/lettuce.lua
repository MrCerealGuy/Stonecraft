
local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:lettuce", {
	description = S("Lettuce"),
	inventory_image = "farming_lettuce.png",
	groups = {compostability = 48, seed = 2, food_lettuce = 1},
	on_use = minetest.item_eat(2),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:lettuce_1")
	end
})

farming.add_eatable("farming:lettuce", 2)

-- crop definition

local def = {
	description = S("Lettuce") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_lettuce_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop =  "",
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

minetest.register_node("farming:lettuce_1", table.copy(def))

-- stage 2

def.tiles = {"farming_lettuce_2.png"}
minetest.register_node("farming:lettuce_2", table.copy(def))

-- stage 3

def.tiles = {"farming_lettuce_3.png"}
minetest.register_node("farming:lettuce_3", table.copy(def))

-- stage 4

def.tiles = {"farming_lettuce_4.png"}
minetest.register_node("farming:lettuce_4", table.copy(def))

-- stage 5

def.tiles = {"farming_lettuce_5.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:lettuce 2"}, rarity = 1},
		{items = {"farming:lettuce"}, rarity = 3}
	}
}
minetest.register_node("farming:lettuce_5", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:lettuce"] = {
	crop = "farming:lettuce",
	seed = "farming:lettuce",
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
		scale = farming.lettuce,
		spread = {x = 100, y = 100, z = 100},
		seed = 689,
		octaves = 3,
		persist = 0.6
	},
	y_min = 5, y_max = 35,
	decoration = "farming:lettuce_5"
})
