
-- craft bones from animalmaterials into bonemeal
if minetest.get_modpath("animalmaterials") then

	minetest.register_craft({
		output = "bonemeal:bonemeal 2",
		recipe = {{"animalmaterials:bone"}}
	})
end


if minetest.get_modpath("default") then

	-- saplings

	local function pine_grow(pos)

		if minetest.find_node_near(pos, 1,
			{"default:snow", "default:snowblock", "default:dirt_with_snow"}) then

			default.grow_new_snowy_pine_tree(pos)
		else
			default.grow_new_pine_tree(pos)
		end
	end

	local function cactus_grow(pos)
		default.grow_cactus(pos, minetest.get_node(pos))
	end

	local function papyrus_grow(pos)
		default.grow_papyrus(pos, minetest.get_node(pos))
	end

	bonemeal:add_sapling({
		{"default:sapling", default.grow_new_apple_tree, "soil"},
		{"default:junglesapling", default.grow_new_jungle_tree, "soil"},
		{"default:emergent_jungle_sapling", default.grow_new_emergent_jungle_tree, "soil"},
		{"default:acacia_sapling", default.grow_new_acacia_tree, "soil"},
		{"default:aspen_sapling", default.grow_new_aspen_tree, "soil"},
		{"default:pine_sapling", pine_grow, "soil"},
		{"default:bush_sapling", default.grow_bush, "soil"},
		{"default:acacia_bush_sapling", default.grow_acacia_bush, "soil"},
		{"default:large_cactus_seedling", default.grow_large_cactus, "sand"},
		{"default:blueberry_bush_sapling", default.grow_blueberry_bush, "soil"},
		{"default:pine_bush_sapling", default.grow_pine_bush, "soil"},
		{"default:cactus", cactus_grow, "sand"},
		{"default:papyrus", papyrus_grow, "soil"}
	})

	-- decoration

	local green_grass = {
		"default:grass_2", "default:grass_3", "default:grass_4",
		"default:grass_5", "", ""
	}

	local dry_grass = {
		"default:dry_grass_2", "default:dry_grass_3", "default:dry_grass_4",
		"default:dry_grass_5", "", ""
	}

	local flowers = {}

	minetest.after(0.1, function()

		for node, def in pairs(minetest.registered_nodes) do

			if def.groups
			and def.groups.flower
			and not node:find("waterlily")
			and not node:find("seaweed")
			and not node:find("xdecor:potted_")
			and not node:find("df_farming:") then
				flowers[#flowers + 1] = node
			end
		end
	end)

	bonemeal:add_deco({
		{"default:dirt", bonemeal.green_grass, flowers},
		{"default:dirt_with_grass", green_grass, flowers},
		{"default:dry_dirt", dry_grass, {}},
		{"default:dry_dirt_with_dry_grass", dry_grass, {}},
		{"default:dirt_with_dry_grass", dry_grass, flowers},
		{"default:sand", {}, {"default:dry_shrub", "", "", ""} },
		{"default:desert_sand", {}, {"default:dry_shrub", "", "", ""} },
		{"default:silver_sand", {}, {"default:dry_shrub", "", "", ""} },
		{"default:dirt_with_rainforest_litter", {}, {"default:junglegrass", "", "", ""} },
		{"default:dirt_with_coniferous_litter", {}, {"default:fern_1", "default:fern_2",
			"default:fern_3", "", "", ""}}
	})
end


if farming then

	bonemeal:add_crop({
		{"farming:cotton_", 8, "farming:seed_cotton"},
		{"farming:wheat_", 8, "farming:seed_wheat"}
	})
end


if farming and farming.mod and farming.mod == "redo" then

	bonemeal:add_crop({
		{"farming:tomato_", 8},
		{"farming:corn_", 8},
		{"farming:melon_", 8},
		{"farming:pumpkin_", 8},
		{"farming:beanpole_", 5},
		{"farming:blueberry_", 4},
		{"farming:raspberry_", 4},
		{"farming:carrot_", 8},
		{"farming:cocoa_", 4},
		{"farming:coffee_", 5},
		{"farming:cucumber_", 4},
		{"farming:potato_", 4},
		{"farming:grapes_", 8},
		{"farming:rhubarb_", 4},
		{"farming:barley_", 8, "farming:seed_barley"},
		{"farming:hemp_", 8, "farming:seed_hemp"},
		{"farming:chili_", 8},
		{"farming:garlic_", 5},
		{"farming:onion_", 5},
		{"farming:pepper_", 7},
		{"farming:pineapple_", 8},
		{"farming:pea_", 5},
		{"farming:beetroot_", 5},
		{"farming:rye_", 8, "farming:seed_rye"},
		{"farming:oat_", 8, "farming:seed_oat"},
		{"farming:rice_", 8, "farming:seed_rice"},
		{"farming:mint_", 4, "farming:seed_mint"},
		{"farming:cabbage_", 6},
		{"farming:lettuce_", 5},
		{"farming:blackberry_", 4},
		{"farming:vanilla_", 8},
		{"farming:soy_", 7},
		{"farming:artichoke_", 5},
		{"farming:parsley_", 3},
		{"farming:sunflower_", 8, "farming:seed_sunflower"},
		{"farming:asparagus_", 5},
		{"farming:eggplant_", 4},
		{"farming:spinach_", 4},
		{"farming:ginger_", 4},
		{"ethereal:strawberry_", 8}
	})
end


if minetest.get_modpath("ethereal") then

	bonemeal:add_crop({
		{"ethereal:strawberry_", 8},
		{"ethereal:onion_", 5}
	})

	bonemeal:add_sapling({
		{"ethereal:palm_sapling", ethereal.grow_palm_tree, "soil"},
		{"ethereal:palm_sapling", ethereal.grow_palm_tree, "sand"},
		{"ethereal:yellow_tree_sapling", ethereal.grow_yellow_tree, "soil"},
		{"ethereal:big_tree_sapling", ethereal.grow_big_tree, "soil"},
		{"ethereal:banana_tree_sapling", ethereal.grow_banana_tree, "soil"},
		{"ethereal:frost_tree_sapling", ethereal.grow_frost_tree, "soil"},
		{"ethereal:mushroom_sapling", ethereal.grow_mushroom_tree, "soil"},
		{"ethereal:mushroom_brown_sapling", ethereal.grow_mushroom_brown_tree, "soil"},
		{"ethereal:willow_sapling", ethereal.grow_willow_tree, "soil"},
		{"ethereal:redwood_sapling", ethereal.grow_redwood_tree, "soil"},
		{"ethereal:giant_redwood_sapling", ethereal.grow_giant_redwood_tree, "soil"},
		{"ethereal:orange_tree_sapling", ethereal.grow_orange_tree, "soil"},
		{"ethereal:bamboo_sprout", ethereal.grow_bamboo_tree, "soil"},
		{"ethereal:birch_sapling", ethereal.grow_birch_tree, "soil"},
		{"ethereal:sakura_sapling", ethereal.grow_sakura_tree, "soil"},
		{"ethereal:lemon_tree_sapling", ethereal.grow_lemon_tree, "soil"},
		{"ethereal:olive_tree_sapling", ethereal.grow_olive_tree, "soil"},
		{"ethereal:basandra_bush_sapling", ethereal.grow_basandra_bush, "soil"}
	})

	local grass = {"default:grass_3", "default:grass_4", "default:grass_5", ""}

	bonemeal:add_deco({
		{"ethereal:crystal_dirt", {"ethereal:crystalgrass", "", "", "", ""}, {}},
		{"ethereal:fiery_dirt", {"ethereal:dry_shrub", "", "", "", ""}, {}},
		{"ethereal:prairie_dirt", grass, {"flowers:dandelion_white",
			"flowers:dandelion_yellow", "flowers:geranium", "flowers:rose",
			"flowers:tulip", "flowers:viola", "ethereal:strawberry_7"}},
		{"ethereal:gray_dirt", {}, {"ethereal:snowygrass", "", ""}},
		{"ethereal:cold_dirt", {}, {"ethereal:snowygrass", "", ""}},
		{"ethereal:mushroom_dirt", {}, {"flowers:mushroom_red", "flowers:mushroom_brown",
				"ethereal:spore_grass", "ethereal:spore_grass", "", "", ""}},
		{"ethereal:jungle_dirt", grass, {"default:junglegrass", "", "", ""}},
		{"ethereal:grove_dirt", grass, {"ethereal:fern", "", "", ""}},
		{"ethereal:bamboo_dirt", grass, {}}
	})
end


if minetest.get_modpath("moretrees") then

	-- special fir check for snow
	local function fir_grow(pos)

		if minetest.find_node_near(pos, 1,
			{"default:snow", "default:snowblock", "default:dirt_with_snow"}) then

			moretrees.grow_fir_snow(pos)
		else
			moretrees.grow_fir(pos)
		end
	end

	bonemeal:add_sapling({
		{"moretrees:beech_sapling", moretrees.spawn_beech_object, "soil"},
		{"moretrees:apple_tree_sapling", moretrees.spawn_apple_tree_object, "soil"},
		{"moretrees:oak_sapling", moretrees.spawn_oak_object, "soil"},
		{"moretrees:sequoia_sapling", moretrees.spawn_sequoia_object, "soil"},
		{"moretrees:birch_sapling", moretrees.grow_birch, "soil"},
		{"moretrees:palm_sapling", moretrees.spawn_palm_object, "soil"},
		{"moretrees:palm_sapling", moretrees.spawn_palm_object, "sand"},
		{"moretrees:date_palm_sapling", moretrees.spawn_date_palm_object, "soil"},
		{"moretrees:date_palm_sapling", moretrees.spawn_date_palm_object, "sand"},
		{"moretrees:spruce_sapling", moretrees.grow_spruce, "soil"},
		{"moretrees:cedar_sapling", moretrees.spawn_cedar_object, "soil"},
		{"moretrees:poplar_sapling", moretrees.spawn_poplar_object, "soil"},
		{"moretrees:poplar_small_sapling", moretrees.spawn_poplar_small_object, "soil"},
		{"moretrees:willow_sapling", moretrees.spawn_willow_object, "soil"},
		{"moretrees:rubber_tree_sapling", moretrees.spawn_rubber_tree_object, "soil"},
		{"moretrees:fir_sapling", fir_grow, "soil"}
	})

elseif minetest.get_modpath("technic_worldgen") then

	bonemeal:add_sapling({
		{"moretrees:rubber_tree_sapling", technic.rubber_tree_model, "soil"}
	})
end


if minetest.get_modpath("caverealms") then

	local fil = minetest.get_modpath("caverealms") .. "/schematics/shroom.mts"
	local add_shroom = function(pos)

		minetest.swap_node(pos, {name = "air"})

		minetest.place_schematic(
			{x = pos.x - 5, y = pos.y, z = pos.z - 5}, fil, 0, nil, false)
	end

	bonemeal:add_sapling({
		{"caverealms:mushroom_sapling", add_shroom, "soil"}
	})
end


local function y_func(grow_func)
	return function(pos)
		grow_func({x = pos.x, y = pos.y - 1, z = pos.z})
	end
end

if minetest.get_modpath("ferns") then

	bonemeal:add_sapling({
		{"ferns:sapling_giant_tree_fern", y_func(abstract_ferns.grow_giant_tree_fern), "soil"},
		{"ferns:sapling_giant_tree_fern", y_func(abstract_ferns.grow_giant_tree_fern), "sand"},
		{"ferns:sapling_tree_fern", y_func(abstract_ferns.grow_tree_fern), "soil"}
	})
end

if minetest.get_modpath("dryplants") then

	bonemeal:add_sapling({
		{"dryplants:reedmace_sapling", y_func(abstract_dryplants.grow_reedmace), "soil"}
	})
end


if minetest.get_modpath("dye") then

	local bonemeal_dyes = {bonemeal = "white", fertiliser = "green", mulch = "brown"}

	for mat, dye in pairs(bonemeal_dyes) do

		minetest.register_craft({
			output = "dye:" .. dye .. " 4",
			recipe = {
				{"bonemeal:" .. mat}
			},
		})
	end
end


if minetest.get_modpath("df_trees") then

	local function spore_tree_fix(pos)
		minetest.remove_node(pos) ; df_trees.spawn_spore_tree(pos)
	end

	local function fungiwood_fix(pos)
		minetest.remove_node(pos) ; df_trees.spawn_fungiwood(pos)
	end

	local function tunnel_fix(pos)
		minetest.remove_node(pos) ; df_trees.spawn_tunnel_tube(pos)
	end

	local function black_cap_fix(pos)
		minetest.remove_node(pos) ; df_trees.spawn_black_cap(pos)
	end

	local function goblin_cap_fix(pos)
		minetest.remove_node(pos) ; df_trees.spawn_goblin_cap(pos)
	end

	local function tower_cap_fix(pos)
		minetest.remove_node(pos) ; df_trees.spawn_tower_cap(pos)
	end

	local function nether_cap_fix(pos)
		minetest.remove_node(pos) ; df_trees.spawn_nether_cap(pos)
	end

	bonemeal:add_sapling({
		{"df_trees:black_cap_sapling", black_cap_fix, "soil", true},
		{"df_trees:fungiwood_sapling", fungiwood_fix, "soil", true},
		{"df_trees:goblin_cap_sapling", goblin_cap_fix, "soil", true},
		{"df_trees:spore_tree_sapling", spore_tree_fix, "soil", true},
		{"df_trees:tower_cap_sapling", tower_cap_fix, "soil", true},
		{"df_trees:tunnel_tube_sapling", tunnel_fix, "soil", true},
		{"df_trees:nether_cap_sapling", nether_cap_fix, "group:nether_cap", true},
		{"df_trees:nether_cap_sapling", nether_cap_fix, "group:cools_lava", true}
	})
end


if minetest.get_modpath("df_farming") then

	bonemeal:add_crop({
		{"df_farming:cave_wheat_", 8, "df_farming:cave_wheat_seed", true},
		{"df_farming:dimple_cup_", 4, "df_farming:dimple_cup_seed", true},
		{"df_farming:pig_tail_", 8, "df_farming:pig_tail_seed", true},
		{"df_farming:plump_helmet_", 4, "df_farming:plump_helmet_spawn", true},
		{"df_farming:quarry_bush_", 5, "df_farming:quarry_bush_seed", true},
		{"df_farming:sweet_pod_", 6, "df_farming:sweet_pod_seed", true}
	})
end


if minetest.get_modpath("df_primordial_items") then

	local function mush_fix(pos)
		minetest.set_node(pos, {name = "air"})
		mapgen_helper.place_schematic(pos,
			df_primordial_items.get_primordial_mushroom(), (math.random(4) - 1) * 90)
	end

	local function fern_fix(pos)
		minetest.set_node(pos, {name = "air"})
		local rotations = {0, 90, 180, 270}
		mapgen_helper.place_schematic(pos,
			df_primordial_items.get_fern_schematic(), rotations[math.random(#rotations)])
	end

	local function blood_fix(pos)
		df_trees.grow_blood_thorn(pos, minetest.get_node(pos))
	end

	bonemeal:add_sapling({
		{"df_primordial_items:jungle_mushroom_sapling",
				df_primordial_items.spawn_jungle_mushroom, "soil", true},
		{"df_primordial_items:jungletree_sapling",
				df_primordial_items.spawn_jungle_tree, "soil", true},
		{"df_primordial_items:mush_sapling", mush_fix, "soil", true},
		{"df_primordial_items:fern_sapling", fern_fix, "soil", true},
		{"df_trees:blood_thorn", blood_fix, "sand", true}
	})

	local jgrass = {
		"df_primordial_items:jungle_grass_1",
		"df_primordial_items:jungle_grass_2",
		"df_primordial_items:jungle_grass_3",
		"df_primordial_items:fern_1",
		"df_primordial_items:fern_2",
		"", "", "", ""
	}

	local jdeco = {
		"df_primordial_items:jungle_mushroom_1",
		"df_primordial_items:jungle_mushroom_2",
		"df_primordial_items:glow_plant_1",
		"df_primordial_items:glow_plant_2",
		"df_primordial_items:glow_plant_3",
		"", "", ""
	}

	bonemeal:add_deco({
		{"df_primordial_items:dirt_with_jungle_grass", jgrass, jdeco}
	})

	local fgrass = {
		"df_primordial_items:fungal_grass_1",
		"df_primordial_items:fungal_grass_2",
		"", "", "", ""
	}

	local fdeco = {
		"df_primordial_items:glow_orb_stalks",
		"df_primordial_items:glow_pods",
		"", "", ""
	}

	bonemeal:add_deco({
		{"df_primordial_items:dirt_with_mycelium", fgrass, fdeco}
	})
end


if minetest.get_modpath("everness") then

	bonemeal:add_sapling({
		{"everness:baobab_sapling", Everness.grow_baobab_tree, "soil"},
		{"everness:coral_tree_bioluminescent_sapling",
				Everness.coral_tree_bioluminescent, "soil"},
		{"everness:coral_tree_sapling", Everness.grow_coral_tree, "soil"},
		{"everness:crystal_bush_sapling", Everness.grow_crystal_bush, "soil"},
		{"everness:crystal_tree_large_sapling", Everness.grow_crystal_large_tree, "soil"},
		{"everness:crystal_tree_sapling", Everness.grow_crystal_tree, "soil"},
		{"everness:cursed_bush_sapling", Everness.grow_cursed_bush, "soil"},
		{"everness:cursed_dream_tree_sapling", Everness.grow_cursed_dream_tree, "soil"},
		{"everness:dry_tree_sapling", Everness.grow_dry_tree, "soil"},
		{"everness:sequoia_tree_sapling", Everness.grow_sequoia_tree, "soil"},
		{"everness:willow_tree_sapling", Everness.grow_willow_tree, "soil"}
	})
end


if minetest.get_modpath("bushes_classic") then

	local function grow_bush(pos)

		local meta = minetest.get_meta(pos)
		local bush_name = meta:get_string("bush_type")

		-- only change if meta found
		if meta and bush_name then
			minetest.swap_node(pos, {name = "bushes:" .. bush_name .. "_bush"})
		end
	end

	bonemeal:add_sapling({
		{"bushes:fruitless_bush", grow_bush, "soil"},
	})
end
