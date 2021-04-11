--Akai ki
--Miki
minetest.register_node("redtrees:rtree", {
	description = "Fiery Tree",
	tiles = {"redtrees_tree_top.png", "redtrees_tree_top.png", "redtrees_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

--Mokuzai
minetest.register_node("redtrees:rwood", {
	description = "Fiery Wooden Planks",
	tiles = {"redtrees_wood.png"},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=10,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

--Karai youfun
	minetest.register_craftitem("redtrees:treechillipowder", {
		inventory_image = "redtrees_powder.png",
		description = "Tree Chilli Powder",
	})

	minetest.register_craftitem("redtrees:treechillitreat", {
		inventory_image = "redtrees_treat.png",
		description = "Tree Chilli Treat",
		on_use = minetest.item_eat(5),
	})
--Wakagi
minetest.register_node("redtrees:rsapling", {
	description = "Fiery Tree Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"redtrees_sapling.png"},
	inventory_image = "redtrees_sapling.png",
	wield_image = "redtrees_sapling.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2,dig_immediate=3,flammable=10,attached_node=1,sapling=1},
	sounds = default.node_sound_leaves_defaults(),
})

--Kinoha
minetest.register_node("redtrees:rleaves", {
	description = "Fiery Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	tiles = {"redtrees_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=10, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"redtrees:rsapling"},
				rarity = 20,
			},
			{
				items = {"redtrees:rleaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = redtrees.after_place_leaves,
})

--Kaidan
stairs.register_stair('rwood', 'redtrees:rwood',
	{choppy=2,oddly_breakable_by_hand=2,flammable=10,wood=1},
	{"redtrees_wood.png"}, "Fiery Wooden Stairs",
	default.node_sound_wood_defaults())

--Ita
stairs.register_slab('rwood', 'redtrees:rwood',
	{choppy=2,oddly_breakable_by_hand=2,flammable=10,wood=1},
	{"redtrees_wood.png"}, "Fiery Wooden Slab",
	default.node_sound_wood_defaults())

--Kashana Tobira
doors.register_door("redtrees:rdoor_wood", {
	description = "Luxurious Door",
	inventory_image = "redtrees_door_wood.png",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1},
	tiles_bottom = {"redtrees_door_wood_bottom.png", "redtrees_door_wood_side.png"},
	tiles_top = {"redtrees_door_wood_top.png", "redtrees_door_wood_side.png"},
	sounds = default.node_sound_wood_defaults(),
	sunlight = false,
})

--Akai Bonsai
minetest.register_node("redtrees:rbonsai", {
	description = "Akai Bonsai",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"redtrees_bonsai.png"},
	inventory_image = "redtrees_bonsai.png",
	wield_image = "redtrees_bonsai.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2,dig_immediate=3,flammable=10,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
})
