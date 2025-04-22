
local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:parsley", {
	description = S("Parsley"),
	inventory_image = "farming_parsley.png",
	groups = {compostability = 48, seed = 2, food_parsley = 1},
	on_use = minetest.item_eat(1),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:parsley_1")
	end
})

farming.add_eatable("farming:parsley", 1)

-- crop definition

local def = {
	description = S("Parsley") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_parsley_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop =  "",
	waving = 1,
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

minetest.register_node("farming:parsley_1", table.copy(def))

-- stage 2

def.tiles = {"farming_parsley_2.png"}
minetest.register_node("farming:parsley_2", table.copy(def))

-- stage 3 (final)

def.tiles = {"farming_parsley_3.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:parsley 2"}, rarity = 1},
		{items = {"farming:parsley"}, rarity = 2},
		{items = {"farming:parsley"}, rarity = 3}
	}
}
minetest.register_node("farming:parsley_3", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:parsley"] = {
	crop = "farming:parsley",
	seed = "farming:parsley",
	minlight = 13,
	maxlight = 15,
	steps = 3
}

-- mapgen

minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"default:dirt_with_grass", "mcl_core:dirt_with_grass", "ethereal:prairie_dirt",
		"ethereal:grove_dirt"
	},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.parsley,
		spread = {x = 100, y = 100, z = 100},
		seed = 23,
		octaves = 3,
		persist = 0.6
	},
	y_min = 10, y_max = 40,
	decoration = "farming:parsley_3"
})
