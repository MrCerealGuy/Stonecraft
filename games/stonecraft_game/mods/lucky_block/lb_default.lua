
local S = lucky_block.S
local MP = minetest.get_modpath("lucky_block")

-- default mod

if lucky_block.def_mod then

	-- chest items
	lucky_block:add_chest_items({
		{name = "default:wood", max = 5},
		{name = "default:apple", max = 3},
		{name = "default:steel_ingot", max = 3},
		{name = "default:gold_ingot", max = 3, chance = 2},
		{name = "default:diamond", max = 2, chance = 3},
		{name = "default:mese_crystal_fragment", max = 3, chance = 3},
		{name = "default:pick_steel", max = 1, chance = 2, min_wear = 20000, max_wear = 65536}
	})

	local dpath = minetest.get_modpath("default") .. "/schematics/"

	-- Default tree schematics
	lucky_block:add_schematics({
		{"appletree", dpath .. "apple_tree_from_sapling.mts", {x = 3, y = 1, z = 3}},
		{"jungletree", dpath .. "jungle_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
		{"defpinetree", dpath .. "pine_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
		{"acaciatree", dpath .. "acacia_tree_from_sapling.mts", {x = 4, y = 1, z = 4}},
		{"aspentree", dpath .. "aspen_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
		{"largecactus", dpath .. "large_cactus.mts", {x = 2, y = 1, z = 2}},
		{"defaultbush", dpath .. "bush.mts", {x = 1, y = 1, z = 1}},
		{"acaciabush", dpath .. "acacia_bush.mts", {x = 1, y = 1, z = 1}},
		{"corals", MP .. "/schematics/corals.mts", {x = 2, y = 1, z = 2}}
	})

	-- Default lucky blocks
	lucky_block:add_blocks({
		{"nod", {"default:chest"}, 0},
		{"lig"},
		{"fal", {"default:wood", "default:gravel", "default:sand",
			"default:desert_sand", "default:stone", "default:dirt",
			"default:goldblock"}, 0},
		{"sch", "watertrap", 1, true},
		{"tel"},
		{"dro", {"default:apple"}, 10},
		{"sch", "appletree", 0, false},
		{"dro", {"default:snow"}, 10},
		{"nod", "default:chest", 0, {
			{name = "bucket:bucket_water", max = 1},
			{name = "default:wood", max = 3},
			{name = "default:pick_diamond", max = 1},
			{name = "default:coal_lump", max = 3}
		}},
		{"sch", "sandtrap", 1, true},
		{"sch", "defpinetree", 0, false},
		{"sch", "lavatrap", 1, true},
		{"dro", {"default:mese_crystal_fragment"}, 15},
		{"dro", {"default:mese_crystal"}, 10},
		{"dro", {"default:mese"}, 1},
		{"exp", 2},
		{"sch", "acaciabush", 0, false},
		{"nod", "default:diamondblock", 0},
		{"nod", "default:steelblock", 0},
		{"nod", "default:dirt", 0},
		{"nod", "default:chest", 0, {
			{name = "default:dirt", max = 15},
			{name = "default:dirt_with_dry_grass", max = 15},
			{name = "default:dirt_with_rainforest_litter", max = 15},
			{name = "default:dirt_with_grass", max = 15},
			{name = "default:dirt_with_snow", max = 15},
		}},
		{"dro", {"dye:"}, 10, true},
		{"dro", {"default:sword_steel"}},
		{"sch", "jungletree", 0, false},
		{"sch", "sandtrap", 1, true, {{"default:sand", "default:silver_sand"}} },
		{"dro", {"default:pick_steel"}},
		{"dro", {"default:shovel_steel"}},
		{"exp"},
		{"dro", {"default:coal_lump"}, 3},
		{"sch", "defaultbush", 0, false},
		{"tro", "default:mese", "tnt_blast", true},
		{"sch", "acaciatree", 0, false},
		{"dro", {"default:axe_steel"}},
		{"dro", {"default:sword_bronze"}},
		{"exp", 3},
		{"nod", "default:chest", 0, {
			{name = "default:acacia_sapling", max = 10},
			{name = "default:aspen_sapling", max = 10},
			{name = "default:pine_sapling", max = 10},
			{name = "default:sapling", max = 10},
			{name = "default:junglesapling", max = 10},
			{name = "default:acacia_bush_sapling", max = 5},
			{name = "default:bush_sapling", max = 5},
		}},
		{"sch", "platform", 1, true},
		{"nod", "default:wood", 0},
		{"dro", {"default:pick_bronze"}},
		{"sch", "aspentree", 0, false},
		{"dro", {"default:shovel_bronze"}},
		{"nod", "default:gravel", 0},
		{"sch", "sandtrap", 1, true, {{"default:sand", "default:gravel"}} },
		{"sch", "largecactus", 0, false},
		{"dro", {"default:axe_bronze"}},
		{"dro", {"default:bookshelf", "default:book", "default:paper"}, 5},
		{"dro", {"default:fence_wood"}, 10},
		{"dro", {"default:fence_acacia_wood"}, 10},
		{"dro", {"default:fence_aspen_wood"}, 10},
		{"dro", {"default:fence_junglewood"}, 10},
		{"dro", {"default:fence_pine_wood"}, 10},
		{"sch", "obsidiantrap", 1, true},
		{"sch", "sandtrap", 1, true, {{"default:sand", "default:desert_sand"}} },
		{"nod", "default:chest", 0, {
			{name = "default:acacia_wood", max = 10},
			{name = "default:aspen_wood", max = 10},
			{name = "default:pine_wood", max = 10},
			{name = "default:wood", max = 10},
			{name = "default:junglewood", max = 10},
		}},
		{"nod", "default:chest", 0, {
			{name = "default:acacia_tree", max = 10},
			{name = "default:aspen_tree", max = 10},
			{name = "default:pine_tree", max = 10},
			{name = "default:tree", max = 10},
			{name = "default:jungletree", max = 10},
		}},
		{"dro", {"default:coral_brown"}, 5},
		{"dro", {"default:coral_orange"}, 5},
		{"dro", {"default:coral_skeleton"}, 5},
		{"sch", "corals", 0, true},
		{"dro", {"default:mese_post_light"}, 5},
		{"dro", {"default:fence_wood"}, 5},
		{"nod", "default:mese_post_light"},
		{"dro", {"default:silver_sand"}, 20},
		{"dro", {"default:sand"}, 20},
		{"dro", {"default:desert_sand"}, 20},
		{"dro", {"default:gravel"}, 15},
		{"nod", "default:chest", 0, {
			{name = "default:silver_sand", max = 20},
			{name = "default:silver_sandstone", max = 20},
			{name = "default:desert_sand", max = 20},
			{name = "default:silver_sandstone", max = 20},
			{name = "default:sand", max = 20},
			{name = "default:sandstone", max = 20},
			{name = "default:gravel", max = 20},
		}},
		{"dro", {"default:obsidian"}, 14}
	})

	-- Additional Wishing Well Styles
	lucky_block:add_blocks({
		{"sch", "wishingwell", 0, true},
		{"sch", "wishingwell", 0, true, {
			{"default:stonebrick", "default:silver_sandstone_brick"},
			{"stairs:slab_stonebrick", "stairs:slab_silver_sandstone_brick"},
			{"default:fence_wood", "default:fence_aspen_wood"},
			{"default:steelblock", "default:tinblock"},
		} },
		{"sch", "wishingwell", 0, true, {
			{"default:stonebrick", "default:sandstonebrick"},
			{"stairs:slab_stonebrick", "stairs:slab_sandstonebrick"},
			{"default:fence_wood", "default:fence_junglewood"},
			{"default:steelblock", "default:goldblock"},
		} },
		{"sch", "wishingwell", 0, true, {
			{"default:stonebrick", "default:desert_stonebrick"},
			{"stairs:slab_stonebrick", "stairs:slab_desert_stonebrick"},
			{"default:fence_wood", "default:fence_acacia_wood"},
			{"default:steelblock", "default:copperblock"},
		} },
		{"sch", "wishingwell", 0, true, {
			{"default:stonebrick", "default:desert_sandstone_brick"},
			{"stairs:slab_stonebrick", "stairs:slab_desert_sandstone_brick"},
			{"default:fence_wood", "default:fence_pine_wood"},
			{"default:steelblock", "default:bronzeblock"},
		} },
	})
end

-- wool mod

if minetest.get_modpath("wool") then

	lucky_block:add_blocks({
		{"sch", "sandtrap", 1, true, {{"default:sand", "wool:red"}} },
		{"dro", {"wool:"}, 10, true},
		{"sch", "sandtrap", 1, true, {{"default:sand", "wool:green"}} },
		{"dro", {"wool:white"}, 10}
	})
end

-- Flowers mod

if minetest.get_modpath("flowers") then

	lucky_block:add_blocks({
		{"nod", "flowers:rose", 0},
		{"dro", {"flowers:mushroom_red"}, 5},
		{"dro", {"flowers:mushroom_brown"}, 5},
		{"dro", {"flowers:rose", "flowers:tulip", "flowers:dandelion_yellow",
				"flowers:geranium", "flowers:viola", "flowers:dandelion_white"}, 12},
		{"nod", "default:chest", 0, {
			{name = "flowers:geranium", max = 15},
			{name = "flowers:viola", max = 15},
			{name = "flowers:dandelion_white", max = 15},
			{name = "flowers:dandelion_yellow", max = 15},
			{name = "flowers:tulip", max = 15},
			{name = "flowers:rose", max = 15},
			{name = "flowers:mushroom_brown", max = 10},
			{name = "flowers:mushroom_red", max = 10},
			{name = "flowers:waterlily", max = 10}
		}}
	})
end

-- Doors mod

if minetest.get_modpath("doors") then

	lucky_block:add_blocks({
		{"dro", {"doors:door_wood"}},
		{"dro", {"doors:door_steel"}},
		{"dro", {"doors:door_glass"}},
		{"dro", {"doors:door_obsidian_glass"}},
		{"dro", {"doors:trapdoor"}},
		{"dro", {"doors:trapdoor_steel"}},
		{"dro", {"doors:gate_acacia_wood_closed"}},
		{"dro", {"doors:gate_aspen_wood_closed"}},
		{"dro", {"doors:gate_wood_closed"}},
		{"dro", {"doors:gate_pine_wood_closed"}},
		{"dro", {"doors:gate_junglewood_closed"}}
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

-- Vessels mod

if minetest.get_modpath("vessels") then

	lucky_block:add_blocks({
		{"dro", {"vessels:shelf", "vessels:drinking_glass", "vessels:glass_bottle",
			"vessels:steel_bottle", "vessels:glass_fragments"}, 5},
		{"nod", "vessels:drinking_glass", 0},
		{"nod", "vessels:glass_bottle", 0},
		{"nod", "vessels:steel_bottle", 0}
	})
end

-- Farming mod (default)

if minetest.get_modpath("farming") then

	lucky_block:add_blocks({
		{"dro", {"farming:bread"}, 5},
		{"sch", "instafarm", 0, true},
		{"nod", "default:water_source", 1},
		{"nod", "farming:straw", 0},
		{"dro", {"farming:straw"}, 8}
	})
end

-- Boats mod

if minetest.get_modpath("boats") then

	lucky_block:add_blocks({
		{"dro", {"boats:boat"}}
	})
end

-- Beds mod

if minetest.get_modpath("beds") then

	lucky_block:add_blocks({
		{"dro", {"beds:bed"}},
		{"dro", {"beds:fancy_bed"}}
	})
end

-- Walls mod

if minetest.get_modpath("walls") then

	lucky_block:add_blocks({
		{"dro", {"walls:cobble"}, 10},
		{"dro", {"walls:mossycobble"}, 10},
		{"dro", {"walls:desertcobble"}, 10}
	})
end

-- Carts mod

if minetest.get_modpath("carts") or minetest.get_modpath("boost_cart") then

	lucky_block:add_blocks({
		{"dro", {"carts:cart"}},
		{"dro", {"default:rail"}, 10},
		{"dro", {"carts:powerrail"}, 5},
		{"dro", {"carts:brakerail"}, 5}
	})
end

-- 3D Armor mod

if minetest.get_modpath("3d_armor") then

	local drop_armor = function(pos, player)

		local name, armor_inv = armor:get_valid_player(player, "[on_dieplayer]")

		if not name then return end

		minetest.chat_send_player(player:get_player_name(),
				lucky_block.green .. S("In your Birthday Suit!"))

		for i = 1, armor_inv:get_size("armor") do

			local stack = armor_inv:get_stack("armor", i)

			if stack:get_count() > 0 then

				armor.drop_armor(pos, stack)
				armor:run_callbacks("on_unequip", player, i, stack)
				armor_inv:set_stack("armor", i, nil)
			end
		end

		armor:save_armor_inventory(player)
		armor:set_player_armor(player)

		minetest.sound_play("wolf-whistle",
				{pos = pos, gain = 1.0, max_hear_distance = 10}, true)
	end

	lucky_block:add_blocks({
		{"cus", drop_armor},
		{"dro", {"3d_armor:boots_wood"}},
		{"dro", {"3d_armor:leggings_wood"}},
		{"dro", {"3d_armor:chestplate_wood"}},
		{"dro", {"3d_armor:helmet_wood"}},
		{"tel"},
		{"dro", {"3d_armor:boots_steel"}},
		{"dro", {"3d_armor:leggings_steel"}},
		{"dro", {"3d_armor:chestplate_steel"}},
		{"dro", {"3d_armor:helmet_steel"}},
		{"dro", {"3d_armor:boots_gold"}},
		{"dro", {"3d_armor:leggings_gold"}},
		{"dro", {"3d_armor:chestplate_gold"}},
		{"exp"},
		{"dro", {"3d_armor:helmet_gold"}},
		{"dro", {"3d_armor:boots_cactus"}},
		{"dro", {"3d_armor:leggings_cactus"}},
		{"dro", {"3d_armor:chestplate_cactus"}},
		{"dro", {"3d_armor:helmet_cactus"}},
		{"dro", {"3d_armor:boots_bronze"}},
		{"dro", {"3d_armor:leggings_bronze"}},
		{"dro", {"3d_armor:chestplate_bronze"}},
		{"dro", {"3d_armor:helmet_bronze"}},
		{"lig"}
	})
end

-- 3D Armor's Shields mod

if minetest.get_modpath("shields") then

	lucky_block:add_blocks({
		{"dro", {"shields:shield_wood"}},
		{"dro", {"shields:shield_steel"}},
		{"dro", {"shields:shield_gold"}},
		{"dro", {"shields:shield_cactus"}},
		{"dro", {"shields:shield_bronze"}},
		{"exp", 2}
	})
end

-- Fire mod

if minetest.get_modpath("fire") then

	lucky_block:add_blocks({
		{"dro", {"fire:flint_and_steel"}},
		{"dro", {"default:flint"}, 5},
		{"nod", "fire:basic_flame", 1},
		{"nod", "fire:permanent_flame", 1},
		{"sch", "firetrap", 1, true},
	})
end

-- TNT mod

if minetest.get_modpath("tnt") then

	local p = "tnt:tnt_burning"

	lucky_block:add_blocks({
		{"dro", {"tnt:gunpowder"}, 5},
		{"fal", {p, p, p, p, p}, 1, true, 4},
		{"nod", "tnt:tnt_burning", 0}
	})
end

-- More Ore's mod

if minetest.get_modpath("moreores") then

	lucky_block:add_blocks({
		{"nod", "moreores:tin_block", 0},
		{"nod", "moreores:silver_block", 0},
		{"fal", {"default:sand", "default:sand", "default:sand", "default:sand",
				"default:sand", "default:sand", "moreores:mithril_block"}, 0},
		{"dro", {"moreores:pick_silver"}},
		{"dro", {"moreores:pick_mithril"}},
		{"tro", "moreores:silver_block"},
		{"dro", {"moreores:shovel_silver"}},
		{"dro", {"moreores:shovel_mithril"}},
		{"dro", {"moreores:axe_silver"}},
		{"dro", {"moreores:axe_mithril"}},
		{"tro", "moreores:mithril_block"},
		{"dro", {"moreores:hoe_silver"}},
		{"dro", {"moreores:hoe_mithril"}},
		{"lig"},
		{"nod", "default:chest", 0, {
			{name = "moreores:silver_lump", max = 10},
			{name = "moreores:mithril_lump", max = 10},
			{name = "default:copper_lump", max = 10},
			{name = "default:gold_lump", max = 10},
			{name = "default:iron_lump", max = 10},
			{name = "default:tin_lump", max = 10},
			{name = "default:coal_lump", max = 10},
			{name = "default:clay_lump", max = 10}
		}}
	})

	if minetest.get_modpath("3d_armor") then

		lucky_block:add_blocks({
			{"dro", {"3d_armor:helmet_mithril"}},
			{"dro", {"3d_armor:chestplate_mithril"}},
			{"dro", {"3d_armor:leggings_mithril"}},
			{"dro", {"3d_armor:boots_mithril"}}
		})
	end

	if minetest.get_modpath("shields") then

		lucky_block:add_blocks({
			{"dro", {"shields:shield_mithril"}}
		})
	end
end -- END moreores

-- Bags mod

if minetest.get_modpath("bags") or minetest.get_modpath("sfinv_bags") then

	minetest.register_craftitem(":bags:spar", {
		description = S("Spar Bag"),
		inventory_image = "bags_spar.png",
		groups = {bagslots = 2, flammable = 2}
	})

	lucky_block:add_blocks({
		{"dro", {"bags:spar"}},
		{"dro", {"bags:small"}},
		{"dro", {"bags:medium"}},
		{"dro", {"bags:large"}},
		{"dro", {"bags:trolley"}}
	})
end

-- Nether Mod

if minetest.get_modpath("nether") then

	local p = "nether:"

	-- add well blocks
	lucky_block.wellblocks[#lucky_block.wellblocks + 1] = {p.."glowstone", 4}
	lucky_block.wellblocks[#lucky_block.wellblocks + 1] = {p.."glowstone_deep", 4}

	-- add lucky blocks
	lucky_block:add_blocks({
		{"flo", 3, {p.."rack", p.."brick", p.."brick_cracked"}, 1},
		{"flo", 3, {p.."rack_deep", p.."brick_deep"}, 1},
		{"flo", 3, {p.."basalt", p.."basalt_hewn", p.."basalt_chiselled"}, 1},
		{"nod", p.."glowstone", 0},
		{"nod", p.."glowstone_deep", 0},
		{"exp", 3},
		{"fal", {p.."sand", p.."sand", p.."sand", p.."sand", p.."sand", p.."glowstone"}, 0},
		{"nod", p.."lava_crust", 1},
		{"nod", "default:chest", 0, {
			{name = p.."fence_nether_brick", max = 5},
			{name = p.."rack_wall", max = 5},
			{name = p.."rack", max = 5},
			{name = p.."axe_nether", max = 1},
			{name = p.."sword_nether", max = 1},
			{name = p.."nether_lump", max = 3}
		}},
		{"exp", 2},
		{"sch", "wishingwell", 0, true, {
			{"default:stonebrick", p.."brick"},
			{"stairs:slab_stonebrick", "stairs:slab_nether_brick"},
			{"default:fence_wood", p.."fence_nether_brick"},
			{"default:steelblock", p.."basalt_chiselled"},
			{"default:water_source", "default:lava_source"},
			{"default:glass", "default:obsidian_glass"}
		}},
		{"lig"},
		{"sch", "platform", 1, true, {
			{"default:sandstonebrick", p.."brick_deep"},
			{"default:sandstone", p.."rack_deep"},
			{"lucky_block:lucky_block", "lucky_block:super_lucky_block"}
		}},
		{"nod", "default:chest", 0, {
			{name = p.."rack_deep_wall", max = 5},
			{name = p.."rack_deep", max = 5},
			{name = p.."pick_nether", max = 1},
			{name = p.."shovel_nether", max = 1},
			{name = p.."nether_lump", max = 3}
		}},
	})

	if minetest.get_modpath("3d_armor") then

		lucky_block:add_blocks({
			{"dro", {"3d_armor:helmet_nether"}},
			{"dro", {"3d_armor:chestplate_nether"}},
			{"dro", {"3d_armor:leggings_nether"}},
			{"dro", {"3d_armor:boots_nether"}}
		})
	end

	if minetest.get_modpath("shields") then

		lucky_block:add_blocks({
			{"dro", {"shields:shield_nether"}}
		})
	end

	if minetest.get_modpath("xpanes") and minetest.registered_nodes["nether:geode"] then

		lucky_block:add_blocks({
			{"dro", {"xpanes:nether_crystal_pane_flat"}, 5},
			{"nod", "nether_geode", 0},
			{"dro", {"nether_geode"}, 3}
		})
	end
end
