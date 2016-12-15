-- main `S` code in init.lua
local S
S = farming.S

minetest.register_craftitem("farming_plus:potato_seed", {
	description = ("Potato Seeds"),
	inventory_image = "farming_potato_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming_plus:potato_1")
	end
})

minetest.register_node("farming_plus:potato_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_potato_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:potato_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_potato_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+9/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:potato", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_potato_3.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'farming_plus:potato_seed'} },
			{ items = {'farming_plus:potato_seed'}, rarity = 2},
			{ items = {'farming_plus:potato_seed'}, rarity = 5},
			{ items = {'farming_plus:potato_item'} },
			{ items = {'farming_plus:potato_item'}, rarity = 2 },
			{ items = {'farming_plus:potato_item'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("farming_plus:potato_item", {
	description = S("Potato"),
	inventory_image = "farming_potato.png",
})

farming.add_plant("farming_plus:potato", {"farming_plus:potato_1", "farming_plus:potato_2"}, 50, 20)

minetest.register_alias("farming_plus:potatoe_item", "farming_plus:potato_item")
minetest.register_alias("farming_plus:potatoe_seed", "farming_plus:potato_seed")
minetest.register_alias("farming_plus:potatoe", "farming_plus:potato")
minetest.register_alias("farming_plus:potatoe_1", "farming_plus:potato_1")
minetest.register_alias("farming_plus:potatoe_2", "farming_plus:potato_2")

