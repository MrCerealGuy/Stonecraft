
local S = minetest.get_translator("farming")

-- seed

minetest.register_craftitem("farming:pineapple_top", {
	description = S("Pineapple Top"),
	inventory_image = "farming_pineapple_top.png",
	groups = {compostability = 48, seed = 2, flammable = 2},

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:pineapple_1")
	end
})

-- item

minetest.register_node("farming:pineapple", {
	description = S("Pineapple"),
	drawtype = "plantlike",
	tiles = {"farming_pineapple.png"},
	inventory_image = "farming_pineapple.png",
	wield_image = "farming_pineapple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.27, -0.37, -0.27, 0.27, 0.44, 0.27}
	},
	groups = {
		food_pineapple = 1, fleshy = 3, dig_immediate = 3, flammable = 2,
		compostability = 65
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false
})

-- crop definition

local def = {
	description = S("Pineapple") .. S(" Crop"),
	drawtype = "plantlike",
	visual_scale = 1.5,
	tiles = {"farming_pineapple_1.png"},
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

minetest.register_node("farming:pineapple_1", table.copy(def))

-- stage 2

def.tiles = {"farming_pineapple_2.png"}
minetest.register_node("farming:pineapple_2", table.copy(def))

-- stage 3

def.tiles = {"farming_pineapple_3.png"}
minetest.register_node("farming:pineapple_3", table.copy(def))

-- stage 4

def.tiles = {"farming_pineapple_4.png"}
minetest.register_node("farming:pineapple_4", table.copy(def))

-- stage 5

def.tiles = {"farming_pineapple_5.png"}
minetest.register_node("farming:pineapple_5", table.copy(def))

-- stage 6

def.tiles = {"farming_pineapple_6.png"}
minetest.register_node("farming:pineapple_6", table.copy(def))

-- stage 7

def.tiles = {"farming_pineapple_7.png"}
minetest.register_node("farming:pineapple_7", table.copy(def))

-- stage 8 (final)

def.tiles = {"farming_pineapple_8.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:pineapple"}, rarity = 1},
		{items = {"farming:pineapple"}, rarity = 3}
	}
}
minetest.register_node("farming:pineapple_8", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:pineapple"] = {
	crop = "farming:pineapple",
	seed = "farming:pineapple_top",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}

-- mapgen

local spawn_on = {
	"default:dirt_with_dry_grass", "default:dry_dirt_with_dry_grass",
	"mcl_core:dirt_with_grass"
}

if farming.mapgen == "v6" then
	spawn_on = {"default:dirt_with_grass"}
end

minetest.register_decoration({
	deco_type = "simple",
	place_on = spawn_on,
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.pineapple,
		spread = {x = 100, y = 100, z = 100},
		seed = 354,
		octaves = 3,
		persist = 0.6
	},
	y_min = 11, y_max = 30,
	decoration = "farming:pineapple_8"
})
