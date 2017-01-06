-- main `S` code in init.lua
local S
S = farming.S

minetest.register_craftitem("farming_plus:orange_seed", {
	description = S("Orange Seeds"),
	inventory_image = "farming_orange_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming_plus:orange_1")
	end
})

minetest.register_node("farming_plus:orange_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_orange_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:orange_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_orange_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+8/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:orange_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_orange_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+14/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:orange", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_orange_4.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'farming_plus:orange_seed'} },
			{ items = {'farming_plus:orange_seed'}, rarity = 2},
			{ items = {'farming_plus:orange_seed'}, rarity = 5},
			{ items = {'farming_plus:orange_item'} },
			{ items = {'farming_plus:orange_item'}, rarity = 2 },
			{ items = {'farming_plus:orange_item'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("farming_plus:orange_item", {
	description = S("Orange"),
	inventory_image = "farming_orange.png",
	on_use = minetest.item_eat(4),
})

farming.add_plant("farming_plus:orange", {"farming_plus:orange_1", "farming_plus:orange_2", "farming_plus:orange_3"}, 50, 20)
