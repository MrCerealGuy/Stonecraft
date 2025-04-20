
-- ethereal schematic path

local epath = minetest.get_modpath("ethereal") .. "/schematics/"

-- add schematics

lucky_block:add_schematics({
	{"pinetree", ethereal.pinetree, {x = 3, y = 0, z = 3}},
	{"palmtree", ethereal.palmtree, {x = 4, y = 0, z = 4}},
	{"bananatree", ethereal.bananatree, {x = 3, y = 0, z = 3}},
	{"orangetree", ethereal.orangetree, {x = 2, y = 0, z = 2}},
	{"birchtree", ethereal.birchtree, {x = 2, y = 0, z = 2}},
	{"basandrabush", ethereal.basandrabush, {x = 1, y = 0, z = 1}},
	{"mushroomone", ethereal.mushroomone, {x = 4, y = 0, z = 4}},
	{"mushroomtwo", ethereal.mushroomtwo, {x = 1, y = 0, z = 1}},
	{"underspike", ethereal.desertstone_under_spike, {x = 1, y = 0, z = 1}},
	{"ethereal_pond", ethereal.pond, {x = 6, y = 2, z = 7}}
})

-- add lucky blocks

lucky_block:add_blocks({
	{"sch", "basandrabush", 0, false},
	{"dro", {"ethereal:basandra_wood"}, 5},
	{"dro", {"ethereal:firethorn"}, 3},
	{"dro", {"ethereal:firethorn_jelly"}, 3},
	{"nod", "ethereal:crystal_spike", 1},
	{"sch", "pinetree", 0, false},
	{"dro", {"ethereal:orange"}, 10},
	{"sch", "appletree", 0, false},
	{"dro", {"ethereal:strawberry"}, 10},
	{"sch", "bananatree", 0, false},
	{"sch", "orangetree", 0, false},
	{"dro", {"ethereal:banana"}, 10},
	{"sch", "acaciatree", 0, false},
	{"dro", {"ethereal:golden_apple"}, 3},
	{"sch", "palmtree", 0, false},
	{"dro", {"ethereal:tree_sapling"}, 5},
	{"dro", {"ethereal:orange_tree_sapling"}, 5},
	{"dro", {"ethereal:banana_tree_sapling"}, 5},
	{"dro", {"ethereal:willow_sapling"} ,5},
	{"dro", {"ethereal:mushroom_sapling"} ,5},
	{"dro", {"ethereal:palm_sapling"} ,5},
	{"sch", "mushroomone", 0, false},
	{"dro", {"ethereal:flight_potion"}, 1},
	{"dro", {"ethereal:birch_sapling"} ,5},
	{"dro", {"ethereal:redwood_sapling"} ,1},
	{"dro", {"ethereal:prairie_dirt"}, 10},
	{"dro", {"ethereal:grove_dirt"}, 10},
	{"fal", {"default:lava_source", "default:lava_source", "default:lava_source",
			"default:lava_source", "default:lava_source"}, 1, true, 4},
	{"dro", {"ethereal:cold_dirt"}, 10},
	{"dro", {"ethereal:mushroom_dirt"}, 10},
	{"dro", {"ethereal:fiery_dirt"}, 10},
	{"sch", "mushroomtwo", 0, false},
	{"dro", {"ethereal:axe_crystal"}},
	{"nod", "ethereal:fire_flower", 1},
	{"dro", {"ethereal:sword_crystal"}},
	{"nod", "ethereal:basandra_bush_stem", 1},
	{"dro", {"ethereal:pick_crystal"}},
	{"sch", "birchtree", 0, false},
	{"dro", {"ethereal:fish_raw"}},
	{"dro", {"ethereal:shovel_crystal"}},
	{"dro", {"ethereal:fishing_rod_baited"}},
	{"exp"},
	{"sch", "underspike", 0, false},
	{"sch", "underspike", 0, false, {
		{"default:cobble", "default:desert_cobble"},
		{"default:stone", "default:desert_stone"}
	}},
	{"sch", "underspike", 0, false, {
		{"default:cobble", "default:sandstone"},
		{"default:stone", "default:sandstonebrick"}
	}},
	{"sch", "underspike", 0, false, {
		{"default:cobble", "default:desert_sandstone"},
		{"default:stone", "default:desert_sandstone_brick"}
	}},
	{"sch", "underspike", 0, false, {
		{"default:cobble", "default:silver_sandstone"},
		{"default:stone", "default:silver_sandstone_brick"}
	}},
	{"dro", {"ethereal:fire_dust"}, 2},
	{"exp", 4},
	{"dro", {"ethereal:crystal_gilly_staff"}},
	{"dro", {"ethereal:light_staff"}},
	{"nod", "default:chest", 0, {
		{name = "ethereal:birch_sapling", max = 10},
		{name = "ethereal:palm_sapling", max = 10},
		{name = "ethereal:orange_tree_sapling", max = 10},
		{name = "ethereal:redwood_sapling", max = 10},
		{name = "ethereal:bamboo_sprout", max = 10},
		{name = "ethereal:banana_tree_sapling", max = 10},
		{name = "ethereal:mushroom_sapling", max = 10},
		{name = "ethereal:mushroom_brown_sapling", max = 10},
		{name = "ethereal:frost_tree_sapling", max = 10},
		{name = "ethereal:sakura_sapling", max = 10},
		{name = "ethereal:willow_sapling", max = 10},
		{name = "ethereal:lemon_tree_sapling", max = 10},
		{name = "ethereal:olive_tree_sapling", max = 10}
	}},
	{"flo", 5, {"ethereal:blue_marble_tile"}, 2},
	{"dro", {"ethereal:blue_marble", "ethereal:blue_marble_tile"}, 8},
	{"dro", {"ethereal:etherium_ore"}, 5},
	{"nod", "default:chest", 0, {
		{name = "ethereal:fish_bluefin", max = 4},
		{name = "ethereal:fish_blueram", max = 4},
		{name = "ethereal:fish_catfish", max = 4},
		{name = "ethereal:fish_clownfish", max = 4},
		{name = "ethereal:fish_pike", max = 4},
		{name = "ethereal:fish_flathead", max = 4},
		{name = "ethereal:fish_plaice", max = 4},
		{name = "ethereal:fish_pufferfish", max = 4},
		{name = "ethereal:fish_salmon", max = 4},
		{name = "ethereal:fish_cichlid", max = 4},
		{name = "ethereal:fish_trout", max  = 4},
		{name = "ethereal:fish_tilapia", max  = 4},
		{name = "ethereal:fish_parrot", max  = 4},
		{name = "ethereal:fishing_rod", max = 1},
		{name = "ethereal:worm", max = 10}
	}},
	{"nod", "default:chest", 0, {
		{name = "ethereal:fish_carp", max = 4},
		{name = "ethereal:fish_coy", max = 4},
		{name = "ethereal:fish_flounder", max = 4},
		{name = "ethereal:fish_jellyfish", max = 4},
		{name = "ethereal:fish_mackerel", max = 4},
		{name = "ethereal:fish_redsnapper", max = 4},
		{name = "ethereal:fish_tuna", max = 4},
		{name = "ethereal:fish_squid", max = 4},
		{name = "ethereal:fish_shrimp", max = 4},
		{name = "ethereal:fish_angler", max = 4},
		{name = "ethereal:fish_piranha", max = 4},
		{name = "ethereal:fish_trevally", max  = 4},
		{name = "ethereal:fishing_rod", max = 1},
		{name = "ethereal:worm", max = 10}
	}},
	{"dro", {"ethereal:lemon"}, 9},
	{"dro", {"ethereal:fish_seahorse", "ethereal:fish_seahorse_green",
		"ethereal:fish_seahorse_pink", "ethereal:fish_seahorse_blue",
		"ethereal:fish_seahorse_yellow"}, 1},
	{"dro", {"ethereal:jellyfish_salad"}, 2},
	{"dro", {"ethereal:calamari_cooked", "ethereal:calamari_raw"}, 4},
	{"dro", {"ethereal:fish_shrimp", "ethereal:fish_shrimp_cooked"}, 4},
	{"dro", {"ethereal:teriyaki_chicken", "ethereal:teriyaki_beef"}, 4},
	{"dro", {"ethereal:sushi_tamago", "ethereal:sushi_nigiri",
		"ethereal:sushi_kappamaki", "ethereal:fugu", "ethereal:sashimi"}, 4},
	{"flo", 3, {"ethereal:gray_moss", "ethereal:fiery_moss", "ethereal:green_moss",
		"ethereal:crystal_moss", "ethereal:mushroom_moss"}, 1},
	{"tro", "ethereal:candle_red", "tnt_blast", true},
	{"nod", "ethereal:candle_orange", 0},
	{"nod", "ethereal:candle", 0},
	{"dro", {"ethereal:fish_tetra", "ethereal:fish_shrimp", "ethereal:worm"}, 1},
	{"nod", "default:chest", 0, {
		{name = "ethereal:fish_n_chips", max = 1},
		{name = "ethereal:calamari_cooked", max = 1},
		{name = "ethereal:jellyfish_salad", max = 1},
		{name = "ethereal:garlic_shrimp", max = 1},
		{name = "ethereal:fish_shrimp_cooked", max = 1},
		{name = "ethereal:mushroom_soup", max = 1},
		{name = "ethereal:teriyaki_beed", max = 1},
		{name = "ethereal:teriyaki_chicken", max = 1},
		{name = "ethereal:fugu", max = 1},
		{name = "ethereal:sushu_tamago", max = 1},
		{name = "ethereal:sushi_nigiri", max = 1},
		{name = "ethereal:sushi_kappamaki", max = 1},
		{name = "ethereal:hearty_stew", max = 1},
	}},
	{"sch", "ethereal_pond", 0, false},
	{"sch", "ethereal_pond", 0, false, {
		{"default:river_water_source", "default:lava_source"},
		{"default:clay", "default:stone"},
		{"default:dirt", "ethereal:fiery_dirt"},
		{"default:mossycobble", "default:obsidian"},
		{"ethereal:bush2", "ethereal:basandra_bush_leaves"},
		{"default:fern_1", "ethereal:dry_shrub"},
		{"default:fern_2", "ethereal:dry_shrub"},
		{"default:fern_3", "ethereal:fire_flower"},
		{"default:grass_4", "ethereal:dry_shrub"}
	}},
	{"sch", "ethereal_pond", 0, false, {
		{"default:clay", "default:dirt"},
		{"default:dirt", "default:dry_dirt_with_dry_grass"},
		{"default:mossycobble", "default:dry_dirt"},
		{"ethereal:bush2", "default:acacia_bush_leaves"},
		{"default:fern_1", "default:dry_grass_1"},
		{"default:fern_2", "default:dry_grass_2"},
		{"default:fern_3", "default:dry_grass_3"},
		{"default:grass_4", "default:dry_grass_4"}
	}},
	{"sch", "ethereal_pond", 0, false, {
		{"default:river_water_source", "default:water_source"},
		{"default:dirt", "default:sand"},
		{"default:mossycobble", "default:dirt"},
		{"ethereal:bush2", "default:pine_bush_needles"},
		{"default:fern_1", "default:marram_grass_1"},
		{"default:fern_2", "default:marram_grass_2"},
		{"default:fern_3", "default:marram_grass_3"},
		{"default:grass_4", "default:dry_shrub"}
	}},
		{"sch", "ethereal_pond", 0, false, {
		{"default:river_water_source", "default:water_source"},
		{"default:dirt", "default:coral_brown"},
		{"default:mossycobble", "default:coral_orange"},
		{"ethereal:bush2", "default:coral_skeleton"},
		{"default:fern_1", "ethereal:coral2"},
		{"default:fern_2", "ethereal:coral3"},
		{"default:fern_3", "ethereal:coral4"},
		{"default:grass_4", "ethereal:seaweed"}
	}}
})

if minetest.get_modpath("3d_armor") then

	lucky_block:add_blocks({
		{"dro", {"3d_armor:helmet_crystal"}},
		{"dro", {"3d_armor:chestplate_crystal"}},
		{"dro", {"3d_armor:leggings_crystal"}},
		{"dro", {"3d_armor:boots_crystal"}},
		{"lig"}
	})
end

if minetest.get_modpath("shields") then

	lucky_block:add_blocks({
		{"dro", {"shields:shield_crystal"}},
		{"exp"}
	})
end
