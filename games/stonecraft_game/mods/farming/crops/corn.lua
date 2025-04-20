
--[[
	Original textures from GeMinecraft
	http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1440575-1-2-5-generation-minecraft-beta-1-2-farming-and
]]

local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:corn", {
	description = S("Corn"),
	inventory_image = "farming_corn.png",
	groups = {compostability = 45, seed = 2, food_corn = 1},
	on_use = minetest.item_eat(3),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:corn_1")
	end
})

farming.add_eatable("farming:corn", 3)

-- crop definition

local def = {
	description = S("Corn") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_corn_1.png"},
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
	sounds = farming.node_sound_leaves_defaults()
}

-- stage 1

minetest.register_node("farming:corn_1", table.copy(def))

-- stage 2

def.tiles = {"farming_corn_2.png"}
minetest.register_node("farming:corn_2", table.copy(def))

-- stage 3

def.tiles = {"farming_corn_3.png"}
minetest.register_node("farming:corn_3", table.copy(def))

-- stage 4

def.tiles = {"farming_corn_4.png"}
minetest.register_node("farming:corn_4", table.copy(def))

-- stage 5

def.tiles = {"farming_corn_5.png"}
minetest.register_node("farming:corn_5", table.copy(def))

-- stage 6

def.tiles = {"farming_corn_6.png"}
def.visual_scale = 1.9
minetest.register_node("farming:corn_6", table.copy(def))

-- stage 7

def.tiles = {"farming_corn_7.png"}
def.drop = {
	items = {
		{items = {"farming:corn"}, rarity = 1},
		{items = {"farming:corn"}, rarity = 3}
	}
}
minetest.register_node("farming:corn_7", table.copy(def))

-- stage 8 (final)

def.tiles = {"farming_corn_8.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:corn 2"}, rarity = 1},
		{items = {"farming:corn"}, rarity = 2},
		{items = {"farming:corn"}, rarity = 3}
	}
}
minetest.register_node("farming:corn_8", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:corn"] = {
	crop = "farming:corn",
	seed = "farming:corn",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
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
		scale = farming.corn,
		spread = {x = 100, y = 100, z = 100},
		seed = 134,
		octaves = 3,
		persist = 0.6
	},
	y_min = 12, y_max = 27,
	decoration = "farming:corn_7"
})
