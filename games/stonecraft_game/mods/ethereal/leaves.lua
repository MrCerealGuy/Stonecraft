
local S = minetest.get_translator("ethereal")

-- set leaftype (0 for plantlike, 1 for block)

local leaftype = "plantlike"
local leafscale = 1.4

if ethereal.leaftype ~= 0 then
	leaftype = "allfaces_optional"
	leafscale = 1.0
end

-- default apple tree leaves

minetest.override_item("default:leaves", {
	drawtype = leaftype,
	visual_scale = leafscale,
	inventory_image = "default_leaves.png",
	wield_image = "default_leaves.png",
	walkable = ethereal.leafwalk
})

-- ability to craft big tree sapling

minetest.register_craft({
	recipe = {{"default:sapling", "default:sapling", "default:sapling"}},
	output = "ethereal:big_tree_sapling"
})

-- default jungle tree leaves

minetest.override_item("default:jungleleaves", {
	drawtype = leaftype,
	visual_scale = leafscale,
	inventory_image = "default_jungleleaves.png",
	wield_image = "default_jungleleaves.png",
	walkable = ethereal.leafwalk
})

-- default pine tree leaves

minetest.override_item("default:pine_needles", {
	drawtype = leaftype,
	visual_scale = leafscale,
	inventory_image = "default_pine_needles.png",
	wield_image = "default_pine_needles.png",
	walkable = ethereal.leafwalk,
	drop = {
		max_items = 1,
		items = {
			{items = {"default:pine_sapling"}, rarity = 20},
			{items = {"ethereal:pine_nuts"}, rarity = 5},
			{items = {"default:pine_needles"}}
		}
	}
})

-- default acacia tree leaves

minetest.override_item("default:acacia_leaves", {
	drawtype = leaftype,
	inventory_image = "default_acacia_leaves.png",
	wield_image = "default_acacia_leaves.png",
	visual_scale = leafscale,
	walkable = ethereal.leafwalk
})

-- default aspen tree leaves

minetest.override_item("default:aspen_leaves", {
	drawtype = leaftype,
	inventory_image = "default_aspen_leaves.png",
	wield_image = "default_aspen_leaves.png",
	visual_scale = leafscale,
	walkable = ethereal.leafwalk
})

-- willow twig

minetest.register_node("ethereal:willow_twig", {
	description = S("Willow Twig"),
	drawtype = "plantlike",
	tiles = {"ethereal_willow_twig.png"},
	inventory_image = "ethereal_willow_twig.png",
	wield_image = "ethereal_willow_twig.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	visual_scale = 1.4,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:willow_sapling"}, rarity = 50},
			{items = {"ethereal:willow_twig"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

-- redwood leaves

minetest.register_node("ethereal:redwood_leaves", {
	description = S("Redwood Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_redwood_leaves.png"},
	inventory_image = "ethereal_redwood_leaves.png",
	wield_image = "ethereal_redwood_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:redwood_sapling"}, rarity = 50},
			{items = {"ethereal:redwood_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

-- orange tree leaves

minetest.register_node("ethereal:orange_leaves", {
	description = S("Orange Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_orange_leaves.png"},
	inventory_image = "ethereal_orange_leaves.png",
	wield_image = "ethereal_orange_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:orange_tree_sapling"}, rarity = 15},
			{items = {"ethereal:orange_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

-- banana tree leaves

minetest.register_node("ethereal:bananaleaves", {
	description = S("Banana Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_banana_leaf.png"},
	inventory_image = "ethereal_banana_leaf.png",
	wield_image = "ethereal_banana_leaf.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:banana_tree_sapling"}, rarity = 10},
			{items = {"ethereal:bananaleaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

-- healing tree leaves

minetest.register_node("ethereal:yellowleaves", {
	description = S("Healing Tree Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_yellow_leaves.png"},
	inventory_image = "ethereal_yellow_leaves.png",
	wield_image = "ethereal_yellow_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, eatable = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:yellow_tree_sapling"}, rarity = 50},
			{items = {"ethereal:yellowleaves"}}
		}
	},
	on_use = minetest.item_eat(1),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
	light_source = 9
})

-- palm tree leaves

minetest.register_node("ethereal:palmleaves", {
	description = S("Palm Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"moretrees_palm_leaves.png"},
	inventory_image = "moretrees_palm_leaves.png",
	wield_image = "moretrees_palm_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:palm_sapling"}, rarity = 10},
			{items = {"ethereal:palmleaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

-- birch tree leaves

minetest.register_node("ethereal:birch_leaves", {
	description = S("Birch Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"moretrees_birch_leaves.png"},
	inventory_image = "moretrees_birch_leaves.png",
	wield_image = "moretrees_birch_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:birch_sapling"}, rarity = 20},
			{items = {"ethereal:birch_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

-- frost tree leaves

minetest.register_node("ethereal:frost_leaves", {
	description = S("Frost Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_frost_leaves.png"},
	inventory_image = "ethereal_frost_leaves.png",
	wield_image = "ethereal_frost_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, puts_out_fire = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:frost_tree_sapling"}, rarity = 15},
			{items = {"ethereal:frost_leaves"}}
		}
	},
	light_source = 9,
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

-- bamboo stalk leaves

minetest.register_node("ethereal:bamboo_leaves", {
	description = S("Bamboo Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_bamboo_leaves.png"},
	inventory_image = "ethereal_bamboo_leaves.png",
	wield_image = "ethereal_bamboo_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:bamboo_sprout"}, rarity = 10},
			{items = {"ethereal:bamboo_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

-- sakura leaves

minetest.register_node("ethereal:sakura_leaves", {
	description = S("Sakura Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_sakura_leaves.png"},
	inventory_image = "ethereal_sakura_leaves.png",
	wield_image = "ethereal_sakura_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:sakura_sapling"}, rarity = 30},
			{items = {"ethereal:sakura_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

minetest.register_node("ethereal:sakura_leaves2", {
	description = S("Sakura Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_sakura_leaves2.png"},
	inventory_image = "ethereal_sakura_leaves2.png",
	wield_image = "ethereal_sakura_leaves2.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:sakura_sapling"}, rarity = 30},
			{items = {"ethereal:sakura_leaves2"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

-- lemon tree leaves

minetest.register_node("ethereal:lemon_leaves", {
	description = S("Lemon Tree Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_lemon_leaves.png"},
	inventory_image = "ethereal_lemon_leaves.png",
	wield_image = "ethereal_lemon_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:lemon_tree_sapling"}, rarity = 25},
			{items = {"ethereal:lemon_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

-- olive tree leaves

minetest.register_node("ethereal:olive_leaves", {
	description = S("Olive Tree Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_olive_leaves.png"},
	inventory_image = "ethereal_olive_leaves.png",
	wield_image = "ethereal_olive_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:olive_tree_sapling"}, rarity = 25},
			{items = {"ethereal:olive_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

-- red mushroom top

minetest.register_node("ethereal:mushroom", {
	description = S("Mushroom Cap"),
	tiles = {"ethereal_mushroom_block.png"},
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, leafdecay = 3},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:mushroom_sapling"}, rarity = 20},
			{items = {"ethereal:mushroom"}}
		}
	},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:mushroom",
	burntime = 10
})

-- brown mushroom top

minetest.register_node("ethereal:mushroom_brown", {
	description = S("Brown Mushroom Cap"),
	tiles = {"ethereal_mushroom_block_brown.png"},
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, leafdecay = 3},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:mushroom_brown_sapling"}, rarity = 15},
			{items = {"ethereal:mushroom_brown"}}
		}
	},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:mushroom_brown",
	burntime = 10
})

-- mushroom pore (spongelike material found inside giant shrooms)

minetest.register_node("ethereal:mushroom_pore", {
	description = S("Mushroom Pore"),
	tiles = {"ethereal_mushroom_pore.png"},
	groups = {
		snappy = 3, cracky = 3, choppy = 3, oddly_breakable_by_hand = 3,
		flammable = 2, disable_jump = 1, fall_damage_add_percent = -100,
		leafdecay = 3
	},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:mushroom_pore",
	burntime = 3
})

-- hedge block

minetest.register_node("ethereal:bush", {
	description = S("Bush"),
	tiles = {"ethereal_bush.png"},
	walkable = true,
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_craft({
	output = "ethereal:bush",
	recipe = {
		{"group:leaves", "group:leaves", "group:leaves"},
		{"group:leaves", "ethereal:bamboo_leaves", "group:leaves"},
		{"group:leaves", "group:leaves", "group:leaves"}
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:bush",
	burntime = 1
})

-- bush block #2

minetest.register_node("ethereal:bush2", {
	drawtype = "allfaces_optional",
	description = S("Bush #2"),
	tiles = {"default_aspen_leaves.png"},
	paramtype = "light",
	walkable = true,
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_craft({
	output = "ethereal:bush2",
	recipe = {
		{"group:leaves", "group:leaves", "group:leaves"},
		{"group:leaves", "default:aspen_leaves", "group:leaves"},
		{"group:leaves", "group:leaves", "group:leaves"}
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:bush2",
	burntime = 1
})

-- pine needles bush (replaces bush 3)

minetest.register_alias("ethereal:bush3", "default:pine_bush_needles")

minetest.register_craft({
	output = "default:pine_bush_needles",
	recipe = {
		{"group:leaves", "group:leaves", "group:leaves"},
		{"group:leaves", "default:pine_needles", "group:leaves"},
		{"group:leaves", "group:leaves", "group:leaves"}
	}
})

-- basandra bush stem, leaves

minetest.register_node("ethereal:basandra_bush_stem", {
	description = S("Basandra Bush Stem"),
	drawtype = "plantlike",
	visual_scale = 1.41,
	walkable = false,
	damage_per_second = 2,
	tiles = {"ethereal_basandra_bush_stem.png"},
	inventory_image = "ethereal_basandra_bush_stem.png",
	wield_image = "ethereal_basandra_bush_stem.png",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy = 2, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed", fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
	}
})

minetest.register_node("ethereal:basandra_bush_leaves", {
	description = S("Basandra Bush Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"ethereal_basandra_bush_leaves.png"},
	paramtype = "light",
	groups = {snappy = 3, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:basandra_bush_sapling"}, rarity = 5},
			{items = {"ethereal:basandra_bush_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults()
})

-- leafdecay helper function

local function decay(tru, lea, rad)
	default.register_leafdecay({trunks = tru, leaves = lea, radius = rad})
end

-- add leafdecay registrations

decay({"default:tree"}, {"default:apple", "default:leaves", "ethereal:orange",
		"ethereal:orange_leaves", "ethereal:lemon", "ethereal:lemon_leaves",
		"ethereal:vine"}, 3)

decay({"ethereal:willow_trunk"}, {"ethereal:willow_twig"}, 3)

decay({"ethereal:redwood_trunk"}, {"ethereal:redwood_leaves"}, 3)

decay({"ethereal:frost_tree"}, {"ethereal:frost_leaves"}, 3)

decay({"ethereal:yellow_trunk"}, {"ethereal:yellowleaves", "ethereal:golden_apple"}, 3)

decay({"ethereal:palm_trunk"}, {"ethereal:palmleaves", "ethereal:coconut"}, 3)

decay({"ethereal:banana_trunk"}, {"ethereal:bananaleaves", "ethereal:banana",
		"ethereal:banana_bunch"}, 3)

decay({"ethereal:birch_trunk"}, {"ethereal:birch_leaves"}, 3)

decay({"ethereal:bamboo"}, {"ethereal:bamboo_leaves"}, 3)

decay({"ethereal:sakura_trunk"}, {"ethereal:sakura_leaves", "ethereal:sakura_leaves2"}, 3)

decay({"ethereal:olive_trunk"}, {"ethereal:olive_leaves", "ethereal:olive"}, 3)

decay({"ethereal:mushroom_trunk"}, {"ethereal:mushroom", "ethereal:mushroom_brown",
		"ethereal:mushroom_pore", "ethereal:lightstring"}, 4)

-- falling leaf particles

if minetest.settings:get_bool("ethereal.leaf_particles") ~= false then

	local leaf_list = {
		{"ethereal:frost_leaves", "331b37", 9},
		{"ethereal:bananaleaves", "28581e"},
		{"ethereal:lemon_leaves", "507c1e"},
		{"ethereal:olive_leaves", "416531"},
		{"ethereal:orange_leaves", "1a3b1b"},
		{"ethereal:redwood_leaves", "15342a"},
		{"ethereal:sakura_leaves", "c281a9"},
		{"ethereal:sakura_leaves2", "d4cbac"},
		{"ethereal:willow_twig", "0b9445"},
		{"ethereal:yellowleaves", "8b5f00", 9},
		{"ethereal:birch_leaves", "274527"},
		{"ethereal:palmleaves", "2b6000"},
		{"ethereal:bamboo_leaves", "445811"},
		{"default:acacia_leaves", "296600"},
		{"default:aspen_leaves", "395d16"},
		{"default:jungleleaves", "141e10"},
		{"default:pine_needles", "00280e"},
		{"default:leaves", "223a20"}
	}

	minetest.register_abm({
		label = "Ethereal falling leaves",
		nodenames = {"group:leaves"},
		neighbors = {"air"},
		interval = 9,
		chance = 75,
		catch_up = false,

		action = function(pos, node)

			local text, glow

			for n = 1, #leaf_list do

				if node.name == leaf_list[n][1] then

					text = "ethereal_falling_leaf.png^[multiply:#"
							.. leaf_list[n][2] .. "70"

					glow = leaf_list[n][3] ; break
				end
			end

			if text then

				minetest.add_particlespawner({
					amount = 1,
					time = 2,
					minpos = {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
					maxpos = {x = pos.x + 1, y = pos.y, z = pos.z + 1},
					minvel = {x = -0.8, y = -1, z = -0.8},
					maxvel = {x = 0.8, y = -3, z = 0.8},
					minacc = {x = -0.1, y = -1, z = -0.1},
					maxacc = {x = 0.2, y = -3, z = 0.2},
					minexptime = 5,
					maxexptime = 10,
					minsize = 3,
					maxsize = 4,
					collisiondetection = true, collision_removal = true,
					texture = text,
					vertical = true,
					glow = glow
				})
			end
		end
	})
end
