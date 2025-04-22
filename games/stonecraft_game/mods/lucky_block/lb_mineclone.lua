
local S = lucky_block.S
local mpath = minetest.get_modpath("mcl_core") .. "/schematics/"
local tmp -- helper

-- chest items

lucky_block:add_chest_items({
	{name = "mcl_core:wood", max = 5},
	{name = "mcl_core:apple", max = 3},
	{name = "mcl_core:iron_ingot", max = 3},
	{name = "mcl_core:gold_ingot", max = 3, chance = 2},
	{name = "mcl_core:diamond", max = 2, chance = 3},
	{name = "mcl_core:pick_iron", max = 1, chance = 2, min_wear = 20000, max_wear = 65536}
})

-- Default tree schematics

lucky_block:add_schematics({
	{"oaktree1", mpath .. "mcl_core_oak_large_1.mts", {x = 2, y = 1, z = 2}},
--	{"oaktree2", mpath .. "mcl_core_oak_large_2.mts", {x = 1, y = 1, z = 1}},
--	{"oaktree3", mpath .. "mcl_core_oak_large_3.mts", {x = 1, y = 1, z = 1}},
--	{"oaktree4", mpath .. "mcl_core_oak_large_4.mts", {x = 1, y = 1, z = 1}},
--	{"oaktreeclassic", mpath .. "mcl_core_oak_classic.mts", {x = 1, y = 1, z = 1}},
	{"oaktreeswamp", mpath .. "mcl_core_oak_swamp.mts", {x = 3, y = 1, z = 3}},
	{"mangrovetree1", mpath .. "mcl_mangrove_tree_1.mts", {x = 3, y = 1, z = 3}},
--	{"mangrovetree2", mpath .. "mcl_mangrove_tree_2.mts", {x = 1, y = 1, z = 1}},
--	{"mangrovetree3", mpath .. "mcl_mangrove_tree_3.mts", {x = 1, y = 1, z = 1}},
--	{"mangrovetree4", mpath .. "mcl_mangrove_tree_4.mts", {x = 1, y = 1, z = 1}},
--	{"mangrovetree5", mpath .. "mcl_mangrove_tree_5.mts", {x = 1, y = 1, z = 1}},
	{"jungletree", mpath .. "mcl_core_jungle_tree.mts", {x = 2, y = 1, z = 2}},
	{"sprucetree1", mpath .. "mcl_core_spruce_huge_1.mts", {x = 5, y = 1, z = 5}},
--	{"sprucetree2", mpath .. "mcl_core_spruce_huge_2.mts", {x = 1, y = 1, z = 1}},
--	{"sprucetree3", mpath .. "mcl_core_spruce_huge_3.mts", {x = 1, y = 1, z = 1}},
--	{"sprucetree4", mpath .. "mcl_core_spruce_huge_4.mts", {x = 1, y = 1, z = 1}},
	{"birchtree", mpath .. "mcl_core_birch.mts", {x = 2, y = 1, z = 2}},
	{"birchtreetall", mpath .. "mcl_core_birch_tall.mts", {x = 3, y = 1, z = 3}},
	{"darkoaktree", mpath .. "mcl_core_dark_oak.mts", {x = 5, y = 1, z = 5}},
	{"brownmushroom1", mpath .. "mcl_mushrooms_huge_brown.mts", {x = 3, y = 1, z = 3}},
--	{"brownmushroom2", mpath .. "mcl_mushrooms_giant_brown.mts", {x = 1, y = 1, z = 1}},
	{"redmushroom1", mpath .. "mcl_mushrooms_huge_red.mts", {x = 3, y = 1, z = 3}},
--	{"redmushroom2", mpath .. "mcl_mushrooms_giant_red.mts", {x = 1, y = 1, z = 1}}
})

-- mineclone trees

lucky_block:add_blocks({
	{"sch", "oaktree1", 0, false},
	{"sch", "oaktreeswamp", 0, false},
	{"sch", "mangrovetree1", 0, false},
	{"sch", "jungletree", 0, false},
	{"sch", "sprucetree1", 0, false},
	{"sch", "birchtree", 0, false},
	{"sch", "birchtreetall", 0, false},
	{"sch", "darkoaktree", 0, false},
	{"sch", "brownmushroom1", 0, false},
	{"sch", "redmushroom1", 0, false}
})

-- mineclone lucky blocks

lucky_block:add_blocks({
	{"nod", "mcl_chests_small:chest", 0, {
		{name = "mcl_core:glass_red", max = 5},
		{name = "mcl_core:glass_green", max = 5},
		{name = "mcl_core:glass_blue", max = 5},
		{name = "mcl_core:glass_light_blue", max = 5},
		{name = "mcl_core:glass_black", max = 5},
		{name = "mcl_core:glass_white", max = 5},
		{name = "mcl_core:glass_brown", max = 5},
		{name = "mcl_core:glass_yellow", max = 5},
		{name = "mcl_core:glass_orange", max = 5},
		{name = "mcl_core:glass_pink", max = 5},
		{name = "mcl_core:glass_gray", max = 5},
		{name = "mcl_core:glass_lime", max = 5},
		{name = "mcl_core:glass_silver", max = 5},
		{name = "mcl_core:glass_magenta", max = 5},
		{name = "mcl_core:glass_purple", max = 5},
		{name = "mcl_core:glass_cyan", max = 5},
		{name = "mcl_core:glass_glass", max = 10}
	}},
	{"lig"},
	{"fal", {
		"mcl_core:wood", "mcl_core:gravel", "mcl_core:sand",
		"mcl_core:sand", "mcl_core:stone", "mcl_core:dirt", "mcl_core:goldblock"
	}, 0},
	{"sch", "watertrap", 1, true, {
		{"default:water_source", "mcl_core:water_source"},
		{"default:obsidian_glass", "mcl_core:glass"}
	}},
	{"tel"},
	{"dro", {"mcl_core:apple"}, 10},
	{"dro", {"mcl_core:snow"}, 10},
	{"sch", "sandtrap", 1, true, {
		{"default:sand", "mcl_core:sand"}
	}},
	{"sch", "lavatrap", 1, true, {
		{"default:lava_source", "mcl_core:lava_source"}
	}},
	{"exp", 2},
	{"nod", "mcl_core:diamondblock", 0},
	{"nod", "mcl_core:ironblock", 0},
	{"nod", "mcl_core:dirt", 0},
	{"nod", "mcl_chests:chest_small", 0, {
		{name = "mcl_core:dirt", max = 15},
		{name = "mcl_core:mycelium", max = 15},
		{name = "mcl_core:podzol", max = 15},
		{name = "mcl_core:coarse_dirt", max = 15},
		{name = "mcl_core:dirt_with_grass", max = 15},
	}},
	{"dro", {"default:sword_steel"}},
	{"sch", "jungletree", 0, false},
	{"dro", {
		"mcl_core:axe_iron", "mcl_core:pick_iron",
		"mcl_core:shovel_iron", "mcl_core:sword_iron"
	}},
	{"exp", 2},
	{"dro", {"mcl_core:coal_lump"}, 3},
	{"tro", "mcl_core:diamondblock", "tnt_explode", true},
	{"exp", 3},
	{"nod", "mcl_chests:chest_small", 0, {
		{name = "mcl_core:acaciasapling", max = 10},
		{name = "mcl_core:darksapling", max = 10},
		{name = "mcl_core:birchsapling", max = 10},
		{name = "mcl_core:junglesapling", max = 10},
		{name = "mcl_core:sapling", max = 10},
		{name = "mcl_core:sprucesapling", max = 10},
		{name = "mcl_core:deadbush", max = 5},
	}},
	{"sch", "platform", 1, true, {
		{"default:sandstone", "mcl_core:sandstone"},
		{"default:sandstonebrick", "mcl_core:sandstone"}
	}},
	{"nod", "mcl_core:wood", 0},
	{"nod", "mcl_core:gravel", 0},
	{"sch", "sandtrap", 1, true, {{"default:sand", "mcl_core:gravel"}} },
	{"sch", "obsidiantrap", 1, true, {
		{"default:obsidian", "mcl_core:obsidian"},
		{"default:lava_source", "mcl_core:lava_source"}
	}},
	{"lig"},
	{"nod", "mcl_chests:chest_small", 0, {
		{name = "mcl_core:wood", max = 10},
		{name = "mcl_core:acaciawood", max = 10},
		{name = "mcl_core:darkwood", max = 10},
		{name = "mcl_core:junglewood", max = 10},
		{name = "mcl_core:birchwood", max = 10},
		{name = "mcl_core:sprucewood", max = 10},
	}},
	{"nod", "mcl_chests:chest_small", 0, {
		{name = "mcl_core:tree", max = 10},
		{name = "mcl_core:acaciatree", max = 10},
		{name = "mcl_core:darktree", max = 10},
		{name = "mcl_core:jungletree", max = 10},
		{name = "mcl_core:birchtree", max = 10},
		{name = "mcl_core:sprucetree", max = 10},
	}},
	{"dro", {"mcl_core:sand"}, 20},
	{"dro", {"mcl_core:gravel"}, 15},
	{"nod", "mcl_chests:chest_small", 0, {
		{name = "mcl_core:sand", max = 20},
		{name = "mcl_core:sandstone", max = 20},
		{name = "mcl_core:gravel", max = 20},
	}},
	{"tel", 10, 5},
	{"dro", {"mcl_core:obsidian"}, 14}
})

-- Additional Wishing Well Styles

lucky_block:add_blocks({
	{"sch", "wishingwell", 0, true, {
		{"default:stonebrick", "mcl_core:sandstone"},
		{"stairs:slab_stonebrick", "mcl_stairs:slab_sandstone"},
		{"default:fence_wood", "mcl_fences:fence"},
		{"default:steelblock", "mcl_core:ironblock"},
		{"default:glass", "mcl_core:glass"}
	}}
})

-- mcl_crafting_table

if minetest.get_modpath("mcl_crafting_table") then

	lucky_block:add_blocks({
		{"nod", "mcl_crafting_table:crafting_table", 0},
		{"dro", {"mcl_crafting_table:crafting_table"}, 1}
	})
end

-- mcl_dye

if minetest.get_modpath("mcl_dye") then

	lucky_block:add_blocks({
		{"dro", {"mcl_dye:"}, 10, true}
	})
end

-- mcl_buckets

if minetest.get_modpath("mcl_buckets") then

	lucky_block:add_blocks({
		{"dro", {"mcl_buckets:bucket_empty"}, 5},
		{"dro", {"mcl_buckets:bucket_lava"}},
		{"dro", {"mcl_buckets:bucket_water"}},
		{"dro", {"mcl_buckets:bucket_cod"}},
		{"dro", {"mcl_buckets:bucket_salmon"}},
		{"nod", "mcl_core:water_source", 1}
	})
end

-- mcl_books

if minetest.get_modpath("mcl_books") then

	lucky_block:add_blocks({
		{"nod", "mcl_books:bookshelf"},
		{"dro", {"mcl_books:bookshelf", "mcl_books:book", "mcl_core:paper"}, 5},
	})
end

-- mcl_wool

if minetest.get_modpath("mcl_wool") then

	lucky_block:add_blocks({
		{"sch", "sandtrap", 1, true, {{"default:sand", "mcl_wool:red"}} },
		{"dro", {"mcl_wool:"}, 10, true},
		{"sch", "sandtrap", 1, true, {{"default:sand", "mcl_wool:green"}} },
		{"dro", {"mcl_wool:white"}, 10}
	})
end

-- mcl_flowers

if minetest.get_modpath("mcl_flowers") then

	tmp = "mcl_flowers:"

	lucky_block:add_blocks({
		{"dro", {
			tmp.."tallgrass", tmp.."peony", tmp.."sunflower", tmp.."double_grass",
			tmp.."double_fern", tmp.."fern", tmp.."waterlily", tmp.."poppy",
			tmp.."dandelion", tmp.."oxeye_daisy", tmp.."tulip_orange",
			tmp.."tulip_pink", tmp.."tulip_red", tmp.."tulip_white",
			tmp.."allium", tmp.."azure_bluet", tmp.."blue_orchid"
		}, 12},
		{"nod", "mcl_chests:chest_small", 0, {
			{name = tmp.."tallgrass", max = 10},
			{name = tmp.."peony", max = 10},
			{name = tmp.."sunflower", max = 10},
			{name = tmp.."double_grass", max = 10},
			{name = tmp.."double_fern", max = 10},
			{name = tmp.."fern", max = 10},
			{name = tmp.."waterlily", max = 10},
			{name = tmp.."poppy", max = 10},
			{name = tmp.."dandelion", max = 10},
			{name = tmp.."oxeye_daisy", max = 10},
			{name = tmp.."tulip_orange", max = 10},
			{name = tmp.."tulip_pink", max = 10},
			{name = tmp.."tulip_white", max = 10},
			{name = tmp.."tulip_red", max = 10},
			{name = tmp.."allium", max = 10},
			{name = tmp.."azure_bluet", max = 10},
			{name = tmp.."blue_orchid", max = 10}
		}}
	})
end

-- mcl_hoppers

if minetest.get_modpath("mcl_hoppers") then

	lucky_block:add_blocks({
		{"dro", {"mcl_hoppers:hopper"}}
	})
end

-- mcl_doors

if minetest.get_modpath("mcl_doors") then

	lucky_block:add_blocks({
		{"dro", {"mcl_doors:wooden_door"}},
		{"dro", {"mcl_doors:acacia_door"}},
		{"dro", {"mcl_doors:birch_door"}},
		{"dro", {"mcl_doors:dark_oak_door"}},
		{"dro", {"mcl_doors:jungle_door"}},
		{"dro", {"mcl_doors:spruce_door"}},
		{"dro", {"mcl_doors:iron_door"}},

		{"dro", {"mcl_doors:wooden_trapdoor"}},
		{"dro", {"mcl_doors:acacia_trapdoor"}},
		{"dro", {"mcl_doors:birch_trapdoor"}},
		{"dro", {"mcl_doors:dark_oak_trapdoor"}},
		{"dro", {"mcl_doors:jungle_trapdoor"}},
		{"dro", {"mcl_doors:spruce_trapdoor"}},
		{"dro", {"mcl_doors:iron_trapdoor"}}
	})
end

-- mcl_fences

if minetest.get_modpath("mcl_fences") then

	tmp = "mcl_fences:"

	lucky_block:add_blocks({
		{"dro", {
			tmp.."fence", tmp.."spruce_fence", tmp.."birch_fence",
			tmp.."jungle_fence", tmp.."dark_oak_fence", tmp.."acacia_fence"
		}, 10},
		{"dro", {
			tmp.."fence_gate", tmp.."spruce_fence_gate", tmp.."birch_fence_gate",
			tmp.."jungle_fence_gate", tmp.."dark_oak_fence_gate", tmp.."acacia_fence_gate"
		}, 5}
	})
end

-- Screwdriver mod

if minetest.get_modpath("screwdriver") then

	if screwdriver and screwdriver.handler then

		minetest.register_tool(":screwdriver:screwdriver_magenta", {
			description = S("Super Mega Magenta Ultra Screwdriver 2500"
				.. "@n(left-click to rotate face, right-click to rotates axis)"),
			inventory_image = "screwdriver.png^[colorize:#ff009970",
			groups = {not_in_creative_inventory = 1},

			on_use = function(itemstack, user, pointed_thing)
				screwdriver.handler(itemstack, user, pointed_thing,
						screwdriver.ROTATE_FACE, 2500)
				return itemstack
			end,

			on_place = function(itemstack, user, pointed_thing)
				screwdriver.handler(itemstack, user, pointed_thing,
						screwdriver.ROTATE_AXIS, 2500)
				return itemstack
			end
		})
	end

	lucky_block:add_blocks({
		{"dro", {"screwdriver:screwdriver"}},
		{"dro", {"screwdriver:screwdriver_magenta"}},
	})
end

-- mcl_farming

if minetest.get_modpath("mcl_farming") then

	lucky_block:add_blocks({
		{"dro", {"mcl_farming:beetroot_item"}, 5},
		{"dro", {"mcl_farming:carrot_item"}, 5},
		{"dro", {"mcl_farming:melon_item"}, 5},
		{"dro", {"mcl_farming:potato_item"}, 5},
		{"dro", {"mcl_farming:potato_item_baked"}, 5},
		{"dro", {"mcl_farming:potato_item_poison"}, 3},
		{"nod", "mcl_farming:pumpkin"},
		{"dro", {"mcl_farming:pumpkin_pie"}, 3},
		{"dro", {"mcl_farming:wheat_item"}, 10},
		{"dro", {"mcl_farming:bread"}, 5},
		{"dro", {"mcl_farming:cookie"}, 5},
		{"exp", 2},
		{"nod", "mcl_farming:hay_block"},
		{"dro", {"mcl_farming:hay_block"}, 4},
		{"nod", "mcl_core:water_source", 1},
		{"sch", "instafarm", 0, true, {
			{"farming:soil_wet", "mcl_farming:soil_wet"},
			{"default:dirt", "mcl_core:dirt"},
			{"default:water_source", "mcl_core:water_source"},
			{"farming:wheat_8", "mcl_farming:wheat"},
			{"farming:cotton_8", "mcl_farming:carrot"}
		}},
		{"sch", "instafarm", 0, true, {
			{"farming:soil_wet", "mcl_farming:soil_wet"},
			{"default:dirt", "mcl_core:dirt"},
			{"default:water_source", "mcl_core:water_source"},
			{"farming:wheat_8", "mcl_farming:potato"},
			{"farming:cotton_8", "mcl_farming:beetroot"}
		}},
		{"nod", "mcl_chests:chest_small", 0, {
			{name = "mcl_farming:beetroot_seeds", max = 10},
			{name = "mcl_farming:melon_seeds", max = 10},
			{name = "mcl_farming:pumpkin_seeds", max = 10},
			{name = "mcl_farming:wheat_seeds", max = 10},
			{name = "mcl_farming:wheat_item", max = 10},
			{name = "mcl_farming:melon", max = 2},
			{name = "mcl_farming:pumpkin", max = 2}
		}}
	})
end

-- mcl_boats

if minetest.get_modpath("mcl_boats") then

	lucky_block:add_blocks({
		{"dro", {"mcl_boats:boat"}},
		{"nod", "mcl_core:water_source", 0}
	})
end

-- mcl_beds

if minetest.get_modpath("mcl_beds") then

	lucky_block:add_blocks({
		{"dro", {"mcl_beds:bed_"}, 1, true}
	})
end

-- mcl_walls

if minetest.get_modpath("mcl_walls") then

	lucky_block:add_blocks({
		{"dro", {"mcl_walls:cobble"}, 10},
		{"dro", {"mcl_walls:mossycobble"}, 10},
		{"dro", {"mcl_walls:andesite"}, 10},
		{"dro", {"mcl_walls:granite"}, 10},
		{"dro", {"mcl_walls:diorite"}, 10},
		{"dro", {"mcl_walls:brick"}, 10},
		{"dro", {"mcl_walls:sandstone"}, 10},
		{"dro", {"mcl_walls:redsandstone"}, 10},
		{"dro", {"mcl_walls:stonebrick"}, 10},
		{"dro", {"mcl_walls:stonebrickmossy"}, 10},
		{"dro", {"mcl_walls:prismarine"}, 10},
		{"dro", {"mcl_walls:endbricks"}, 10},
		{"dro", {"mcl_walls:netherbrick"}, 10},
		{"dro", {"mcl_walls:rednetherbrick"}, 10},
		{"dro", {"mcl_walls:mudbrick"}, 10},
		{"flo", 3, {"mcl_core:lava_source"}, 1}
	})
end

-- mcl_minecarts

if minetest.get_modpath("mcl_minecarts") then

	lucky_block:add_blocks({
		{"dro", {"mcl_minecarts:minecart"}},
		{"dro", {"mcl_minecarts:chest_minecart"}},
		{"dro", {"mcl_minecarts:rail"}, 10},
		{"dro", {"mcl_minecarts:golden_rail"}, 5},
		{"dro", {"mcl_minecarts:activator_rail"}, 5},
		{"dro", {"mcl_minecarts:detector_rail"}, 5}
	})
end

-- mcl_armor

if minetest.get_modpath("mcl_armor") then

	tmp = "mcl_armor:"

	lucky_block:add_blocks({
		{"dro", {
			tmp.."leather_helmet", tmp.."leather_chestplate",
			tmp.."leather_leggings", tmp.."leather_boots"
		}, 1},
		{"dro", {
			tmp.."gold_helmet", tmp.."gold_chestplate",
			tmp.."gold_leggings", tmp.."gold_boots"
		}, 1},
		{"dro", {
			tmp.."chain_helmet", tmp.."chain_chestplate",
			tmp.."chain_leggings", tmp.."chain_boots"
		}, 1},
		{"dro", {
			tmp.."iron_helmet", tmp.."iron_chestplate",
			tmp.."iron_leggings", tmp.."iron_boots"
		}, 1},
		{"dro", {
			tmp.."diamond_helmet", tmp.."diamond_chestplate",
			tmp.."diamond_leggings", tmp.."diamond_boots"
		}, 1},
		{"dro", {
			tmp.."netherite_helmet", tmp.."netherite_chestplate",
			tmp.."netherite_leggings", tmp.."netherite_boots"
		}, 1}
	})
end

-- mcl_fire

if minetest.get_modpath("mcl_fire") then

	lucky_block:add_blocks({
		{"dro", {"mcl_fire:flint_and_steel"}},
		{"nod", "mcl_fire:fire", 1},
		{"nod", "mcl_fire:eternal_fire", 1},
		{"sch", "firetrap", 1, true, { {"fire:basic_flame", "mcl_fire:fire"} }},
	})
end

-- mcl_tnt

if minetest.get_modpath("mcl_tnt") then

	lucky_block:add_blocks({
		{"dro", {"mcl_mobitems:gunpowder"}, 5},
		{"spw", {"mcl_tnt:tnt"}, 4, nil, nil, 2},
		{"nod", "mcl_tnt:tnt", 0},
		{"spw", {"mcl_tnt:tnt"}, 6, nil, nil, 5},
	})
end

-- mobs_mc

if minetest.get_modpath("mobs_mc") then

	lucky_block:add_blocks({
		--{"spw", {"entity name"}, how many to spawn, tamed, owned, range, nametag}
		{"spw", {"mobs_mc:bat"}, 3, nil, nil, 5, nil},
		{"spw", {"mobs_mc:chicken"}, 4, nil, nil, 5, "Chicken Squad"},
		{"spw", {"mobs_mc:creeper"}, 1, nil, nil, 3, "Mr. Boombastic"},
		{"spw", {"mobs_mc:parrot"}, 4, nil, nil, 5, "Parrot Party"},
		{"spw", {"mobs_mc:sheep"}, 1, true, true, 5, nil},
		{"spw", {"mobs_mc:silverfish"}, 5, nil, nil, 5, nil},
		{"spw", {"mobs_mc:spider"}, 3, nil, nil, 5, nil},
		{"spw", {"mobs_mc:witch"}, 1, nil, nil, 3, "Ezmerelda"},
		{"spw", {"mobs_mc:wolf"}, 2, nil, nil, 3, nil},
		{"spw", {"mobs_mc:zombie"}, 3, nil, nil, 5, nil},
		{"spw", {"mobs_mc:pig"}, 2, nil, nil, 5, nil}
	})
end

-- mcl_mobitems

if minetest.get_modpath("mcl_mobitems") then

	tmp = "mcl_mobitems:"

	lucky_block:add_blocks({
		{"dro", {tmp.."rotten_flesh"}, 10},
		{"dro", {tmp.."mutton", tmp.."cooked_mutton"}, 10},
		{"dro", {tmp.."beef", tmp.."cooked_beef"}, 10},
		{"dro", {tmp.."chicken", tmp.."cooked_chicken"}, 10},
		{"dro", {tmp.."porkchop", tmp.."cooked_porkchop"}, 10},
		{"dro", {tmp.."rabbit", tmp.."cooked_rabbit"}, 10},
		{"dro", {tmp.."milk_bucket", tmp.."spider_eye"}, 10},
		{"dro", {tmp.."bone", tmp.."string"}, 10},
		{"exp", 4},
		{"dro", {tmp.."blaze_rod", tmp.."blaze_powder"}, 4},
		{"dro", {tmp.."magma_tear", tmp.."ghast_tear"}, 2},
		{"dro", {tmp.."leather", tmp.."feather"}, 5},
		{"dro", {tmp.."saddle"}},
		{"dro", {tmp.."iron_horse_armor"}},
		{"dro", {tmp.."gold_horse_armor"}},
		{"dro", {tmp.."diamond_horse_armor"}}
	})
end

-- mcl_potions

if minetest.get_modpath("mcl_potions") then

	tmp = "mcl_potions:"

	lucky_block:add_blocks({
		{"dro", {tmp.."awkward", tmp.."healing"}, 1},
		{"dro", {tmp.."mundane", tmp.."night_vision"}, 1},
		{"dro", {tmp.."slowness", tmp.."swiftness"}, 1},
		{"dro", {tmp.."poison", tmp.."leaping"}, 1},
		{"dro", {tmp.."invisibility", tmp.."regeneration"}, 1},
		{"dro", {tmp.."water_breathing", tmp.."fire_resistance"}, 1}
	})
end

-- mcl_torches

if minetest.get_modpath("mcl_torches") then

	lucky_block:add_blocks({
		{"dro", {"mcl_torches:torch"}, 5},
		{"nod", "mcl_torches:torch", 1}
	})
end

-- mcl_cake

if minetest.get_modpath("mcl_cake") then

	lucky_block:add_blocks({
		{"dro", {"mcl_cake:cake"}, 3},
		{"nod", "mcl_cake:cake", 0},
		{"nod", "mcl_cake:cake_1", 0},
		{"nod", "mcl_cake:cake_2", 0},
		{"nod", "mcl_cake:cake_3", 0},
		{"nod", "mcl_cake:cake_4", 0},
		{"nod", "mcl_cake:cake_5", 0},
		{"nod", "mcl_cake:cake_6", 0},
		{"lig"}
	})
end

-- mcl_fishing

if minetest.get_modpath("mcl_fishing") then

	tmp = "mcl_fishing:"

	lucky_block:add_blocks({
		{"dro", {tmp.."fishing_rod"}, 1},
		{"dro", {tmp.."salmon_raw", tmp.."salmon_cooked"}, 5},
		{"dro", {tmp.."clownfish_raw", tmp.."pufferfish_raw"}, 5},
	})
end

-- mcl_nether

if minetest.get_modpath("mcl_nether") then

	tmp = "mcl_nether:"

	lucky_block:add_blocks({
		{"flo", 3, {tmp.."glowstone"}, 1},
		{"flo", 3, {tmp.."quartz_ore"}, 1},
		{"flo", 3, {tmp.."netheriteblock"}, 1},
		{"flo", 3, {tmp.."netherrack", tmp.."soul_sand"}, 1},
		{"flo", 3, {tmp.."magma"}, 1},
		{"flo", 5, {
			tmp.."quartz_block", tmp.."quartz_chiseled", tmp.."quartz_smooth"
		}, 2},
	})
end
