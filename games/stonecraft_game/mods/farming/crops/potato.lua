
--[[
	Original textures from DocFarming mod
	https://forum.minetest.net/viewtopic.php?id=3948
]]

local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:potato", {
	description = S("Potato"),
	inventory_image = "farming_potato.png",
	groups = {compostability = 48, seed = 2, food_potato = 1},

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:potato_1")
	end,

	-- 1 in 3 chance of being poisoned
	on_use = function(itemstack, user, pointed_thing)

		if user then

			if math.random(3) == 1 then
				return minetest.do_item_eat(-1, nil, itemstack, user, pointed_thing)
			else
				return minetest.do_item_eat(1, nil, itemstack, user, pointed_thing)
			end
		end
	end
})

farming.add_eatable("farming:potato", 1)

-- crop definition

local def = {
	description = S("Potato") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_potato_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
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

minetest.register_node("farming:potato_1", table.copy(def))

-- stage 2

def.tiles = {"farming_potato_2.png"}
minetest.register_node("farming:potato_2", table.copy(def))

-- stage 3

def.tiles = {"farming_potato_3.png"}
def.drop = {
	items = {
		{items = {"farming:potato"}, rarity = 1},
		{items = {"farming:potato"}, rarity = 3}
	}
}
minetest.register_node("farming:potato_3", table.copy(def))

-- stage 4 (final)

def.tiles = {"farming_potato_4.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:potato 2"}, rarity = 1},
		{items = {"farming:potato"}, rarity = 2},
		{items = {"farming:potato"}, rarity = 3}
	}
}
minetest.register_node("farming:potato_4", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:potato"] = {
	crop = "farming:potato",
	seed = "farming:potato",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 4
}

-- mapgen

minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"default:dirt_with_grass", "default:dirt_with_rainforest_litter",
		"mcl_core:dirt_with_grass", "ethereal:prairie_dirt"
	},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.potato,
		spread = {x = 100, y = 100, z = 100},
		seed = 465,
		octaves = 3,
		persist = 0.6
	},
	y_min = 5, y_max = 40,
	decoration = "farming:potato_3"
})
