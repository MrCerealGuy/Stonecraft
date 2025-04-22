
-- Sandwiches

if minetest.get_modpath("sandwiches") then

	lucky_block:add_blocks({
		{"dro", {"sandwiches:american_sandwich"}, 1},
		{"dro", {"sandwiches:veggie_sandwich"}, 1},
		{"dro", {"sandwiches:classic_sandwich"}, 1},
		{"dro", {"sandwiches:blt_sandwich"}, 1},
		{"dro", {"sandwiches:ham_sandwich"}, 1},
		{"dro", {"sandwiches:bacon_sandwich"}, 1},
		{"dro", {"sandwiches:egg_and_bacon_sandwich"}, 1},
		{"dro", {"sandwiches:tasty_meat_sandwich"}, 1},
		{"dro", {"sandwiches:enhanced_bacon_sandwich"}, 1},
		{"dro", {"sandwiches:tasty_veggie_sandwich"}, 1},
		{"dro", {"sandwiches:hot_ham_sandwich"}, 1},
		{"dro", {"sandwiches:hot_veggie_sandwich"}, 1},
		{"dro", {"sandwiches:italian_sandwich"}, 1},
		{"dro", {"sandwiches:cheesy_sandwich"}, 1},
		{"dro", {"sandwiches:sweet_sandwich"}, 1},
		{"dro", {"sandwiches:blueberry_jam_sandwich"}, 1},
		{"dro", {"sandwiches:raspberry_jam_sandwich"}, 1},
		{"dro", {"sandwiches:strawberry_jam_sandwich"}, 1},
		{"dro", {"sandwiches:blackberry_jam_sandwich"}, 1},
		{"dro", {"sandwiches:grape_jelly_sandwich"}, 1},
		{"dro", {"sandwiches:pb_and_j_sandwich"}, 1},
		{"dro", {"sandwiches:marinated_chicken_sandwich"}, 1},
		{"dro", {"sandwiches:triple_mega_sandwich"}, 1},
		{"dro", {"sandwiches:sand_sandwich"}, 1},
		{"dro", {"sandwiches:fairy_bread"}, 1}
	})
end

-- Animalia

if minetest.get_modpath("animalia") then

	lucky_block:add_blocks({
		{"dro", {"animalia:leather", "animalia:feather", "animalia:pelt_bear"}, 3},
		{"dro", {"animalia:beef_raw", "animalia:beef_cooked", "animalia:rat_raw",
			"animalia:rat_cooked", "animalia:porkchop_raw", "animalia:porkchop_cooked",
			"animalia:venison_raw", "animalia:venison_cooked", "animalia:chicken_egg",
			"animalia:turkey_egg", "animalia:bucket_milk"}, 5},
		{"dro", {"animalia:bucket_guano", "animalia:cat_toy", "animalia:nametag",
			"animalia:saddle", "animalia:net", "animalia:shears"}, 1}
	})

	if minetest.get_modpath("3d_armor") then

		lucky_block:add_blocks({
			{"dro", {"animalia:coat_bear_pelt"}, 1}
		})
	end

	lucky_block:add_blocks({
		{"spw", "animalia:bat", 5},
		{"spw", "animalia:chicken", 3},
		{"spw", "animalia:grizzly_bear", 1},
		{"spw", "animalia:cow", 1},
		{"spw", "animalia:frog", 2},
		{"spw", "animalia:pig", 1},
		{"spw", "animalia:rat", 3},
		{"spw", "animalia:sheep", 2},
		{"spw", "animalia:wolf", 1}
	})
end

-- Obsidian stuff

if minetest.get_modpath("obsidianstuff") then

	lucky_block:add_blocks({
		{"dro", {"obsidianstuff:pick"}, 1},
		{"dro", {"obsidianstuff:shovel"}, 1},
		{"dro", {"obsidianstuff:axe"}, 1},
		{"dro", {"obsidianstuff:sword"}, 1}
	})

	if minetest.get_modpath("3d_armor") then

		lucky_block:add_blocks({
			{"dro", {"obsidianstuff:helmet_obsidian"}, 1},
			{"dro", {"obsidianstuff:chestplate_obsidian"}, 1},
			{"dro", {"obsidianstuff:leggings_obsidian"}, 1},
			{"dro", {"obsidianstuff:boots_obsidian"}, 1}
		})
	end

	if minetest.get_modpath("shields") then

		lucky_block:add_blocks({
			{"dro", {"obsidianstuff:shield_obsidian"}, 1}
		})
	end
end

-- Aerial

if minetest.get_modpath("aerial") then

	lucky_block:add_blocks({
		{"dro", {"aerial:wings_wood"}, 1},
		{"dro", {"aerial:wings_cactus"}, 1},
		{"dro", {"aerial:wings_bronze"}, 1},
		{"dro", {"aerial:wings_steel"}, 1},
		{"dro", {"aerial:wings_gold"}, 1},
		{"dro", {"aerial:wings_diamond"}, 1}
	})
end

-- extra doors mod

if minetest.get_modpath("extra_doors") then

	lucky_block:add_blocks({
		{"dro", {"default:steel_rod"}, 10},
		{"dro", {"extra_doors:door_woodpanel1"}, 1},
		{"dro", {"extra_doors:door_woodglass1"}, 1},
		{"dro", {"extra_doors:door_woodglass2"}, 1},
		{"dro", {"extra_doors:door_door_japanese"}, 1},
		{"dro", {"extra_doors:door_door_french"}, 1},
		{"dro", {"extra_doors:door_door_cottage1"}, 1},
		{"dro", {"extra_doors:door_door_cottage2"}, 1},
		{"dro", {"extra_doors:door_door_barn1"}, 1},
		{"lig"},
		{"dro", {"extra_doors:door_door_barn2"}, 1},
		{"dro", {"extra_doors:door_door_castle1"}, 1},
		{"dro", {"extra_doors:door_door_castle2"}, 1},
		{"dro", {"extra_doors:door_door_mansion1"}, 1},
		{"dro", {"extra_doors:door_door_mansion2"}, 1},
		{"dro", {"extra_doors:door_door_dungeon1"}, 1},
		{"dro", {"extra_doors:door_door_dungeon2"}, 1},
		{"dro", {"extra_doors:door_door_steelpanel1"}, 1},
		{"dro", {"extra_doors:door_door_steelglass1"}, 1},
		{"dro", {"extra_doors:door_door_steelglass2"}, 1}
	})
end

-- Home Decor mod

if minetest.get_modpath("homedecor") then

	lucky_block:add_blocks({
		{"nod", "homedecor:toilet", 0},
		{"nod", "homedecor:table", 0},
		{"nod", "homedecor:chair", 0},
		{"nod", "homedecor:table_lamp_off", 0},
		{"dro", {"homedecor:plastic_sheeting", "homedecor:plastic_base"}, 15},
		{"dro", {"homedecor:roof_tile_terracotta"}, 20},
		{"dro", {"homedecor:shutter_oak"}, 5},
		{"dro", {"homedecor:shutter_black"}, 5},
		{"dro", {"homedecor:shutter_dark_grey"}, 5},
		{"dro", {"homedecor:shutter_grey"}, 5},
		{"dro", {"homedecor:shutter_white"}, 5},
		{"dro", {"homedecor:shutter_mahogany"}, 5},
		{"dro", {"homedecor:shutter_yellow"}, 5},
		{"dro", {"homedecor:shutter_forest_green"}, 5},
		{"dro", {"homedecor:shutter_light_blue"}, 5},
		{"dro", {"homedecor:shutter_violet"}, 5},
		{"dro", {"homedecor:table_legs_wrought_iron", "homedecor:utility_table_legs"}, 5},
		{"dro", {"homedecor:pole_wrought_iron"}, 10},
		{"dro", {"homedecor:fence_picket_white"}, 20}
	})
end

-- Caverealms

if minetest.get_modpath("caverealms") then

	lucky_block:add_blocks({
		{"sch", "sandtrap", 1, true, {{"default:sand", "caverealms:coal_dust"}} },
		{"sch", "obsidiantrap", 1, true, {{"default:obsidian",
				"caverealms:glow_obsidian_brick_2"}} },
		{"flo", 5, {"caverealms:stone_with_moss"}, 2},
		{"flo", 5, {"caverealms:stone_with_lichen"}, 2},
		{"flo", 5, {"caverealms:stone_with_algae"}, 2},
	})
end

-- Moreblocks mod

if minetest.get_modpath("moreblocks") then

	local p = "moreblocks:"
	local lav = {name = "default:lava_source"}
	local air = {name = "air"}
	local trs = {name = p .. "trap_stone"}
	local trg = {name = p .. "trap_glow_glass"}
	local trapstone_trap = {
		size = {x = 3, y = 6, z = 3},
		data = {
			lav, lav, lav, air, air, air, air, air, air,
			air, air, air, air, air, air, trs, trs, trs,
			lav, lav, lav, air, air, air, air, air, air,
			air, air, air, air, trg, air, trs, air, trs,
			lav, lav, lav, air, air, air, air, air, air,
			air, air, air, air, air, air, trs, trs, trs
		}
	}

	lucky_block:add_schematics({
		{"trapstonetrap", trapstone_trap, {x = 1, y = 6, z = 1}}
	})

	lucky_block:add_blocks({
		{"dro", {p.."wood_tile"}, 10},
		{"dro", {p.."wood_tile_center"}, 10},
		{"dro", {p.."wood_tile_full"}, 10},
		{"dro", {p.."wood_tile_offset"}, 10},
		{"dro", {p.."circle_stone_bricks"}, 20},
		{"dro", {p.."grey_bricks"}, 20},
		{"dro", {p.."stone_tile"}, 10},
		{"dro", {p.."split_stone_tile"}, 10},
		{"dro", {p.."split_stone_tile_alt"}, 10},
		{"flo", 5, {"moreblocks:stone_tile", "moreblocks:split_stone_tile"}, 2},
		{"dro", {p.."tar", p.."cobble_compressed"}, 10},
		{"dro", {p.."cactus_brick"}, 10},
		{"dro", {p.."cactus_checker"}, 10},
		{"nod", {p.."empty_bookshelf"}, 0},
		{"dro", {p.."coal_stone"}, 10},
		{"dro", {p.."coal_checker"}, 10},
		{"dro", {p.."coal_stone_bricks"}, 10},
		{"dro", {p.."coal_glass"}, 10},
		{"exp", 3},
		{"dro", {p.."iron_stone"}, 10},
		{"dro", {p.."iron_checker"}, 10},
		{"dro", {p.."iron_stone_bricks"}, 10},
		{"dro", {p.."iron_glass"}, 10},
		{"dro", {p.."trap_obsidian"}, 10},
		{"dro", {p.."trap_sandstone"}, 10},
		{"dro", {p.."trap_desert_stone"}, 10},
		{"dro", {p.."trap_stone"}, 10},
		{"dro", {p.."trap_glass"}, 10},
		{"dro", {p.."trap_glow_glass"}, 10},
		{"dro", {p.."trap_obsidian_glass"}, 10},
		{"lig"},
		{"sch", "trapstonetrap", 0, true},
		{"dro", {p.."all_faces_tree"}, 10},
		{"dro", {p.."all_faces_jungle_tree"}, 10},
		{"dro", {p.."all_faces_pine_tree"}, 10},
		{"dro", {p.."all_faces_acacia_tree"}, 10},
		{"dro", {p.."all_faces_aspen_tree"}, 10},
		{"flo", 3, {p.."all_faces_acacia_tree"}, 1},
		{"dro", {p.."plankstone"}, 10},
		{"fal", {p.."all_faces_tree", p.."all_faces_tree", p.."all_faces_tree",
				p.."all_faces_tree", p.."all_faces_tree"}, 0},
		{"dro", {p.."glow_glass"}, 10},
		{"dro", {p.."super_glow_glass"}, 10},
		{"dro", {p.."clean_glass"}, 10},
		{"nod", "default:chest", 0, {
			{name = p.."rope", max = 10},
			{name = p.."sweeper", max = 1},
			{name = p.."circular_saw", max = 1},
			{name = p.."grey_bricks", max = 10},
			{name = p.."tar", max = 3}
		}},
		{"flo", 3, {"moreblocks:copperpatina"}, 1}
	})
end

-- worm farm mod

if minetest.get_modpath("worm_farm") then

	lucky_block:add_blocks({
		{"nod", "default:chest", 0, {
			{name = "ethereal:worm", max = 5},
			{name = "worm_farm:worm_tea", max = 5},
			{name = "ethereal:worm", max = 5},
			{name = "worm_farm:worm_farm", max = 1}
		}},
		{"cus", dropsy, {item = "ethereal:worm", msg = "Worm Attack!"}},
		{"dro", {"worm_farm:worm_farm"}, 1}
	})
end
