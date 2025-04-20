
local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:rhubarb", {
	description = S("Rhubarb"),
	inventory_image = "farming_rhubarb.png",
	groups = {compostability = 48, seed = 2, food_rhubarb = 1},
	on_use = minetest.item_eat(1),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:rhubarb_1")
	end
})

farming.add_eatable("farming:rhubarb", 1)

-- crop definition

local def = {
	description = S("Rhubarb") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_rhubarb_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	waving = 1,
	selection_box = farming.select,
	groups = {
		handy = 1, snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults(),
	minlight = 10,
	maxlight = 12
}

-- stage 1

minetest.register_node("farming:rhubarb_1", table.copy(def))

-- stage2

def.tiles = {"farming_rhubarb_2.png"}
minetest.register_node("farming:rhubarb_2", table.copy(def))

-- stage3

def.tiles = {"farming_rhubarb_3.png"}
def.drop = {
	items = {
		{items = {"farming:rhubarb"}, rarity = 1},
		{items = {"farming:rhubarb"}, rarity = 3}
	}
}
minetest.register_node("farming:rhubarb_3", table.copy(def))

-- stage 4 (final)

def.tiles = {"farming_rhubarb_4.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:rhubarb 2"}, rarity = 1},
		{items = {"farming:rhubarb"}, rarity = 2},
		{items = {"farming:rhubarb"}, rarity = 3}
	}
}
minetest.register_node("farming:rhubarb_4", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:rhubarb"] = {
	crop = "farming:rhubarb",
	seed = "farming:rhubarb",
	minlight = 10,
	maxlight = 12,
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
		scale = farming.rhubarb,
		spread = {x = 100, y = 100, z = 100},
		seed = 798,
		octaves = 3,
		persist = 0.6
	},
	y_min = 3, y_max = 20,
	decoration = "farming:rhubarb_3"
})
