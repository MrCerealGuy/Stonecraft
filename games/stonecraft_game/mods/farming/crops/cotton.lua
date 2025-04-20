
local S = minetest.get_translator("farming")

-- seed

minetest.register_node("farming:seed_cotton", {
	description = S("Cotton Seed"),
	tiles = {"farming_cotton_seed.png"},
	inventory_image = "farming_cotton_seed.png",
	wield_image = "farming_cotton_seed.png",
	drawtype = "signlike",
	groups = {
		compostability = 48, seed = 1, snappy = 3, attached_node = 1,
		flammable = 4, growing = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	next_plant = "farming:cotton_1",

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:seed_cotton")
	end,

	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "farming:cotton_1", param2 = 1})
	end
})

-- item

minetest.register_craftitem("farming:cotton", {
	description = S("Cotton"),
	inventory_image = "farming_cotton.png",
	groups = {flammable = 4, compostability = 50}
})

-- crop definition

local def = {
	description = S("Cotton") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_cotton_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop =  "",
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

minetest.register_node("farming:cotton_1", table.copy(def))

-- stage 2

def.tiles = {"farming_cotton_2.png"}
minetest.register_node("farming:cotton_2", table.copy(def))

-- stage 3

def.tiles = {"farming_cotton_3.png"}
minetest.register_node("farming:cotton_3", table.copy(def))

-- stage 4

def.tiles = {"farming_cotton_4.png"}
minetest.register_node("farming:cotton_4", table.copy(def))

-- stage 5

def.tiles = {"farming_cotton_5.png"}
def.drop = {
	items = {
		{items = {"farming:seed_cotton"}, rarity = 1}
	}
}
minetest.register_node("farming:cotton_5", table.copy(def))

-- stage 6

def.tiles = {"farming_cotton_6.png"}
minetest.register_node("farming:cotton_6", table.copy(def))

-- stage 7

def.tiles = {"farming_cotton_7.png"}
def.drop = {
	items = {
		{items = {"farming:cotton"}, rarity = 2},
		{items = {"farming:seed_cotton"}, rarity = 1}
	}
}
minetest.register_node("farming:cotton_7", table.copy(def))

-- stage 8 (final)

def.tiles = {"farming_cotton_8.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:cotton"}, rarity = 1},
		{items = {"farming:cotton"}, rarity = 2},
		{items = {"farming:cotton"}, rarity = 3},
		{items = {"farming:seed_cotton"}, rarity = 1},
		{items = {"farming:seed_cotton"}, rarity = 2},
		{items = {"farming:seed_cotton"}, rarity = 3}
	}
}
minetest.register_node("farming:cotton_8", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:cotton"] = {
	crop = "farming:cotton",
	seed = "farming:seed_cotton",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}

-- wild cotton (this is what you find on the map)

minetest.register_node("farming:cotton_wild", {
	description = S("Wild Cotton"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"farming_cotton_wild.png"},
	inventory_image = "farming_cotton_wild.png",
	wield_image = "farming_cotton_wild.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {handy = 1, snappy = 3, attached_node = 1, flammable = 4, compostability = 60},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	drop = {
		items = {
			{items = {"farming:cotton"}, rarity = 2},
			{items = {"farming:seed_cotton"}, rarity = 1}
		}
	},
	sounds = farming.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -8 / 16, -6 / 16, 6 / 16, 5 / 16, 6 / 16}
	}
})

-- mapgen

local spawn_on = {
	"default:dry_dirt_with_dry_grass", "default:dirt_with_dry_grass",
	"mcl_core:dirt_with_grass"
}

if farming.mapgen == "v6" then
	spawn_on = {"default:dirt_with_grass"}
end

minetest.register_decoration({
	name = "farming:cotton_wild",
	deco_type = "simple",
	place_on = spawn_on,
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.cotton,
		spread = {x = 100, y = 100, z = 100},
		seed = 4242,
		octaves = 3,
		persist = 0.6
	},
	y_min = 1, y_max = 120,
	decoration = "farming:cotton_wild"
})

--[[ Cotton using api
farming.register_plant("farming:cotton", {
	description = "Cotton seed",
	inventory_image = "farming_cotton_seed.png",
	groups = {flammable = 2},
	steps = 8,
})]]
