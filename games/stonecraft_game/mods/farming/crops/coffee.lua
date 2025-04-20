
local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:coffee_beans", {
	description = S("Coffee Beans"),
	inventory_image = "farming_coffee_beans.png",
	groups = {compostability = 48, seed = 2, food_coffee = 1, flammable = 2},

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:coffee_1")
	end
})

-- crop definition

local def = {
	description = S("Coffee") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_coffee_1.png"},
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

minetest.register_node("farming:coffee_1", table.copy(def))

-- stage 2

def.tiles = {"farming_coffee_2.png"}
minetest.register_node("farming:coffee_2", table.copy(def))

-- stage 3

def.tiles = {"farming_coffee_3.png"}
minetest.register_node("farming:coffee_3", table.copy(def))

-- stage 4

def.tiles = {"farming_coffee_4.png"}
minetest.register_node("farming:coffee_4", table.copy(def))

-- stage 5 (final)

def.tiles = {"farming_coffee_5.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:coffee_beans 2"}, rarity = 1},
		{items = {"farming:coffee_beans"}, rarity = 2},
		{items = {"farming:coffee_beans"}, rarity = 3}
	}
}
minetest.register_node("farming:coffee_5", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:coffee"] = {
	crop = "farming:coffee",
	seed = "farming:coffee_beans",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 5
}

-- mapgen

local spawn_on = {
	"default:dirt_with_dry_grass", "default:dirt_with_rainforest_litter",
	"default:dry_dirt_with_dry_grass", "mcl_core:dirt_with_grass",
	"ethereal:prairie_dirt"
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
		scale = farming.coffee,
		spread = {x = 100, y = 100, z = 100},
		seed = 12,
		octaves = 3,
		persist = 0.6
	},
	y_min = 20, y_max = 55,
	decoration = "farming:coffee_5"
})
