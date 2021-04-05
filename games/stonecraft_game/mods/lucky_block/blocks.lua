
-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP .. "/intllib.lua")


-- Default tree schematics
local dpath = minetest.get_modpath("default") .. "/schematics/"

lucky_block:add_schematics({
	{"appletree", dpath .. "apple_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
	{"jungletree", dpath .. "jungle_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
	{"defpinetree", dpath .. "pine_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
	{"acaciatree", dpath .. "acacia_tree_from_sapling.mts", {x = 4, y = 1, z = 4}},
	{"aspentree", dpath .. "aspen_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
--	{"corals", dpath .. "corals.mts", {x = 2, y = 1, z = 2}},
	{"largecactus", dpath .. "large_cactus.mts", {x = 2, y = 0, z = 0}},
	{"defaultbush", dpath .. "bush.mts", {x = 1, y = 1, z = 1}},
	{"acaciabush", dpath .. "acacia_bush.mts", {x = 1, y = 1, z = 1}},

	{"corals", MP .. "/schematics/corals.mts", {x = 2, y = 1, z = 2}},
})


-- Default blocks
lucky_block:add_blocks({
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
		{name = "default:coal_lump", max = 3} } },
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
	{"dro", {"default:obsidian"}, 14},
})

local green = minetest.get_color_escape_sequence("#1eff00")

-- custom function (punches player with 5 damage)
local function punchy(pos, player)

	player:punch(player, 1.0, {
		full_punch_interval = 1.0,
		damage_groups = {fleshy = 5}
	}, nil)

	minetest.sound_play("player_damage", {pos = pos, gain = 1.0})

	minetest.chat_send_player(player:get_player_name(),
		green .. S("Stop hitting yourself!"))
end

-- custom function (pint sized player) and potion with recipe
local function pint(pos, player)

	player:set_properties({
		visual_size = {x = 0.5, y = 0.5},
		collisionbox = {-0.15, 0.0, -0.15, 0.15, .85, 0.15},
		eye_height = 0.73,
		stepheight = 0.3
	})

	minetest.chat_send_player(player:get_player_name(),
		green .. S("Pint Sized Player!"))

	minetest.sound_play("default_place_node", {pos = pos, gain = 1.0})

	minetest.after (180, function(player, pos) -- 3 minutes

		if player and player:is_player() then

			player:set_properties({
				visual_size = {x = 1.0, y = 1.0},
				collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
				eye_height = 1.47,
				stepheight = 0.6
			})

			minetest.sound_play("default_place_node", {pos = pos, gain = 1.0})
		end
	end, player)
end

minetest.register_craftitem("lucky_block:pint_sized_potion", {
	description = S("Pint Sized Potion (DRINK ME)"),
	inventory_image = "lucky_pint_sized_potion.png",
	on_use = function(itemstack, user, pointed_thing)

		itemstack:take_item()

		local pos = user:get_pos()
		local inv = user:get_inventory()
		local item = "vessels:glass_bottle"

		if inv:room_for_item("main", {name = item}) then
			inv:add_item("main", item)
		else
			minetest.add_item(pos, {name = item})
		end

		pint(pos, user)

		return itemstack
	end,
	groups = {vessel = 1},
})

minetest.register_craft({
	output = "lucky_block:pint_sized_potion",
	recipe = {
		{"default:bush_sapling", "flowers:tulip", "default:acacia_bush_sapling"},
		{"dye:blue", "default:apple", "dye:cyan"},
		{"", "vessels:glass_bottle", ""},
	}
})

-- custom function (drop player inventory and replace with dry shrubs)
local function bushy(pos, player)

	local player_inv = player:get_inventory()

	pos = player:get_pos() or pos

	for i = 1, player_inv:get_size("main") do

		local obj = minetest.add_item(pos, player_inv:get_stack("main", i))

		if obj then

			obj:setvelocity({
				x = math.random(-10, 10) / 9,
				y = 5,
				z = math.random(-10, 10) / 9,
			})
		end

		player_inv:set_stack("main", i, "default:dry_shrub")
	end

	minetest.chat_send_player(player:get_player_name(),
		green .. S("Dry shrub takeover!"))
end

-- lightning staff
minetest.register_tool("lucky_block:lightning_staff", {
	description = S("Lightning Staff"),
	inventory_image = "lucky_lightning_staff.png",
	range = 10,
	groups = {not_in_creative_inventory = 1},

	on_use = function(itemstack, user, pointed_thing)

		local pos = user:get_pos()
		if pointed_thing.type == "object" then
			pos = pointed_thing.ref:get_pos()
		elseif pointed_thing.type == "node" then
			pos = pointed_thing.above
		end

		local bnod = minetest.get_node_or_nil(pos)
		local bref = bnod and minetest.registered_items[bnod.name]

		if bref and bref.buildable_to == true then
			local nod = "fire:basic_flame"
			minetest.set_node(pos, {name = nod})
		end

		local radius = 4
		local objs = minetest.get_objects_inside_radius(pos, radius)
		local obj_pos, dist

		-- add temp entity to cause damage
		local tmp_ent = minetest.add_entity(pos, "lucky_block:temp")

		for n = 1, #objs do

			obj_pos = objs[n]:get_pos()

			dist = vector.distance(pos, obj_pos)

			if dist < 1 then dist = 1 end

			local damage = math.floor((4 / dist) * radius)
			local ent = objs[n]:get_luaentity()

			-- if you blast yourself then delay hurt for bones mod if dead
			if objs[n] == user then

				minetest.after(0.1, function()
					objs[n]:punch(tmp_ent, 1.0, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = damage, fire = 1},
					}, pos)
				end)
			else
				objs[n]:punch(tmp_ent, 1.0, {
					full_punch_interval = 1.0,
					damage_groups = {fleshy = damage, fire = 1},
				}, pos)
			end
		end

		minetest.add_particle({
			pos = {x = pos.x, y = pos.y + 4, z = pos.z},
			velocity = {x = 0, y = 0, z = 0},
			acceleration = {x = 0, y = 0, z = 0},
			expirationtime = 1.0,
			collisiondetection = false,
			texture = "lucky_lightning.png",
			size = 100,
			glow = 15,
		})

		minetest.sound_play("lightning", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 25
		})

		itemstack:add_wear(65535 / 50) -- 50 uses

		return itemstack
	end,
})

lucky_block:add_blocks({
	{"cus", pint},
	{"cus", bushy},
	{"cus", punchy},
	{"dro", {"lucky_block:pint_sized_potion"}, 1},
	{"nod", "default:chest", 0, {
		{name = "default:stick", max = 10},
		{name = "default:acacia_bush_stem", max = 10},
		{name = "default:bush_stem", max = 10},
		{name = "default:pine_bush_stem", max = 10},
		{name = "default:grass_1", max = 10},
		{name = "default:dry_grass_1", max = 10},
		{name = "lucky_block:lightning_staff", max = 1, chance = 10}}},
})

-- wool mod
if minetest.get_modpath("wool") then
	lucky_block:add_blocks({
		{"sch", "sandtrap", 1, true, {{"default:sand", "wool:red"}} },
		{"dro", {"wool:"}, 10, true},
		{"sch", "sandtrap", 1, true, {{"default:sand", "wool:green"}} },
		{"dro", {"wool:white"}, 10},
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
		{"dro", {"extra_doors:door_door_steelglass2"}, 1},
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
			{name = "flowers:waterlily", max = 10},
		}},
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
		{"dro", {"doors:gate_junglewood_closed"}},
	})
end

-- Screwdriver mod
if minetest.get_modpath("screwdriver") then

if screwdriver and screwdriver.handler then
minetest.register_tool(":screwdriver:screwdriver_magenta", {
	description = S("Super Mega Magenta Ultra Screwdriver 2500\n(left-click to rotate face, right-click to rotates axis)"),
	inventory_image = "screwdriver.png^[colorize:#ff009970",
	groups = {not_in_creative_inventory = 1},

	on_use = function(itemstack, user, pointed_thing)
		screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_FACE, 2500)
		return itemstack
	end,

	on_place = function(itemstack, user, pointed_thing)
		screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_AXIS, 2500)
		return itemstack
	end,
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
		{"nod", "vessels:steel_bottle", 0},
	})
end

-- Farming mod (default)
if minetest.get_modpath("farming") then
	lucky_block:add_blocks({
		{"dro", {"farming:bread"}, 5},
		{"sch", "instafarm", 0, true},
		{"nod", "default:water_source", 1},
		{"nod", "farming:straw", 0},
		{"dro", {"farming:straw"}, 8},
	})
end

-- Home Decor mod
if minetest.get_modpath("homedecor") and not core.skip_mod("homedecor") then
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
		{"dro", {"homedecor:fence_picket_white"}, 20},
	})
end

-- Boats mod
if minetest.get_modpath("boats") then
	lucky_block:add_blocks({
		{"dro", {"boats:boat"}},
	})
end

-- Beds mod
if minetest.get_modpath("beds") then
	lucky_block:add_blocks({
		{"dro", {"beds:bed"}},
		{"dro", {"beds:fancy_bed"}},
	})
end

-- Walls mod
if minetest.get_modpath("walls") then
	lucky_block:add_blocks({
		{"dro", {"walls:cobble"}, 10},
		{"dro", {"walls:mossycobble"}, 10},
		{"dro", {"walls:desertcobble"}, 10},
	})
end

-- Carts mod
if minetest.get_modpath("carts")
or (minetest.get_modpath("boost_cart") and not core.skip_mod("boost_cart")) then
	lucky_block:add_blocks({
		{"dro", {"carts:cart"}},
		{"dro", {"default:rail"}, 10},
		{"dro", {"carts:powerrail"}, 5},
	})
end

-- 3D Armor mod
if minetest.get_modpath("3d_armor") then
lucky_block:add_blocks({
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
	{"lig"},
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
	{"exp", 2},
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

-- Caverealms
if minetest.get_modpath("caverealms") and not core.skip_mod("caverealms") then
lucky_block:add_blocks({
	{"sch", "sandtrap", 1, true, {{"default:sand", "caverealms:coal_dust"}} },
	{"sch", "obsidiantrap", 1, true, {{"default:obsidian", "caverealms:glow_obsidian_brick_2"}} },
	{"flo", 5, {"caverealms:stone_with_moss"}, 2},
	{"flo", 5, {"caverealms:stone_with_lichen"}, 2},
	{"flo", 5, {"caverealms:stone_with_algae"}, 2},
})
end

-- TNT mod
if minetest.get_modpath("tnt") then
local p = "tnt:tnt_burning"
lucky_block:add_blocks({
	{"dro", {"tnt:gunpowder"}, 5},
	{"fal", {p, p, p, p, p}, 1, true, 4},
	{"nod", "tnt:tnt_burning", 0},
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
		{name = "default:clay_lump", max = 10},
	}},
})

if minetest.get_modpath("3d_armor") then
lucky_block:add_blocks({
	{"dro", {"3d_armor:helmet_mithril"}},
	{"dro", {"3d_armor:chestplate_mithril"}},
	{"dro", {"3d_armor:leggings_mithril"}},
	{"dro", {"3d_armor:boots_mithril"}},
})
end

if minetest.get_modpath("shields") then
lucky_block:add_blocks({
	{"dro", {"shields:shield_mithril"}},
})
end

end -- END moreores

-- Moreblocks mod
if minetest.get_modpath("moreblocks") then
local p = "moreblocks:"
local lav = {name = "default:lava_source"}
local air = {name = "air"}
local trs = {name = p.."trap_stone"}
local trg = {name = p.."trap_glow_glass"}
local trapstone_trap = {
	size = {x = 3, y = 6, z = 3},
	data = {
		lav, lav, lav, air, air, air, air, air, air,
		air, air, air, air, air, air, trs, trs, trs,
		lav, lav, lav, air, air, air, air, air, air,
		air, air, air, air, trg, air, trs, air, trs,
		lav, lav, lav, air, air, air, air, air, air,
		air, air, air, air, air, air, trs, trs, trs,
	},
}

lucky_block:add_schematics({
	{"trapstonetrap", trapstone_trap, {x = 1, y = 6, z = 1}},
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
	{"fal", {p.."all_faces_tree", p.."all_faces_tree", p.."all_faces_tree", p.."all_faces_tree", p.."all_faces_tree"}, 0},
	{"dro", {p.."glow_glass"}, 10},
	{"dro", {p.."super_glow_glass"}, 10},
	{"dro", {p.."clean_glass"}, 10},
	{"nod", "default:chest", 0, {
		{name = p.."rope", max = 10},
		{name = p.."sweeper", max = 1},
		{name = p.."circular_saw", max = 1},
		{name = p.."grey_bricks", max = 10},
		{name = p.."tar", max = 3}}},
	{"flo", 3, {"moreblocks:copperpatina"}, 1},
})
end

-- Bags mod
if minetest.get_modpath("bags") then
minetest.register_craftitem(":bags:spar", {
	description = "Spar Bag",
	inventory_image = "bags_spar.png",
	groups = {bagslots = 2, flammable = 2},
})
lucky_block:add_blocks({
	{"dro", {"bags:spar"}},
	{"dro", {"bags:small"}},
	{"dro", {"bags:medium"}},
	{"dro", {"bags:large"}},
	{"dro", {"bags:trolley"}},
})
end

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

-- Special items
minetest.register_node("lucky_block:void_mirror", {
	description = S("Void Mirror (Place to see through solid walls during daytime)"),
	drawtype = "normal",
	tiles = {"default_obsidian_glass.png^[brighten"},
	use_texture_alpha = true,
	groups = {snappy = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_glass_defaults(),
})

lucky_block:add_blocks({
	{"dro", {"lucky_block:void_mirror"}},
})

-- Troll
local green = minetest.get_color_escape_sequence("#1eff00")

local function fake_diamonds(pos, player)

	for n = 1, 25 do

	minetest.add_particle({
		time = 15,
		pos = {
			x = pos.x + math.random(-20, 20) / 10,
			y = pos.y,
			z = pos.z + math.random(-20, 20) / 10,
		},
		velocity = {x = 0, y = 2, z = 0},
		acceleration = {x = 0, y = -10, z = 0},
		expirationtime = 4,
		maxsize = 4,
		texture = "default_diamond.png",
		glow = 2,
		size = 5,
		collisiondetection = true,
		vertical = true,
	})

	end

	minetest.chat_send_player(player:get_player_name(),
			green .. S("Wow! So many faux diamonds!"))
end

lucky_block:add_blocks({
	{"cus", fake_diamonds},
})
