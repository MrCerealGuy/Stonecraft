
local S = minetest.get_translator("farming")

-- rice seed

minetest.register_node("farming:seed_rice", {
	description = S("Rice Seed"),
	tiles = {"farming_rice_seed.png"},
	inventory_image = "farming_rice_seed.png",
	wield_image = "farming_rice_seed.png",
	drawtype = "signlike",
	groups = {
		handy = 1, compostability = 48, seed = 1, snappy = 3, attached_node = 1,
		flammable = 4, growing = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	next_plant = "farming:rice_1",

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:seed_rice")
	end,

	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "farming:rice_1", param2 = 3})
	end
})

-- rice item

minetest.register_craftitem("farming:rice", {
	description = S("Rice"),
	inventory_image = "farming_rice.png",
	groups = {seed = 2, food_rice = 1, flammable = 2, compostability = 65},
})

-- dry rice seed to give edible rice

minetest.register_craft({
	type = "cooking",
	cooktime = 1,
	output = "farming:rice",
	recipe = "farming:seed_rice"
})

-- crop definition

local def = {
	description = S("Rice") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_rice_1.png"},
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 3,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	waving = 1,
	selection_box = farming.select,
	groups = {
		handy = 1, snappy = 3, flammable = 4, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults()
}

-- stage 1

minetest.register_node("farming:rice_1", table.copy(def))

-- stage 2

def.tiles = {"farming_rice_2.png"}
minetest.register_node("farming:rice_2", table.copy(def))

-- stage 3

def.tiles = {"farming_rice_3.png"}
minetest.register_node("farming:rice_3", table.copy(def))

-- stage 4

def.tiles = {"farming_rice_4.png"}
minetest.register_node("farming:rice_4", table.copy(def))

-- stage 5

def.tiles = {"farming_rice_5.png"}
minetest.register_node("farming:rice_5", table.copy(def))

-- stage 6

def.tiles = {"farming_rice_6.png"}
def.drop = {
	items = {
		{items = {"farming:seed_rice"}, rarity = 2}
	}
}
minetest.register_node("farming:rice_6", table.copy(def))

-- stage 7

def.tiles = {"farming_rice_7.png"}
def.drop = {
	items = {
		{items = {"farming:seed_rice"}, rarity = 1},
		{items = {"farming:seed_rice"}, rarity = 3}
	}
}
minetest.register_node("farming:rice_7", table.copy(def))

-- stage 8 (final)

def.tiles = {"farming_rice_8.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:seed_rice 2"}, rarity = 1},
		{items = {"farming:seed_rice"}, rarity = 2},
		{items = {"farming:seed_rice"}, rarity = 3},
		{items = {"farming:seed_rice"}, rarity = 4}
	}
}
minetest.register_node("farming:rice_8", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:rice"] = {
	crop = "farming:rice",
	seed = "farming:seed_rice",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}
