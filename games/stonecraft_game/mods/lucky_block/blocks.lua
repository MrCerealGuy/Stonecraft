
-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")


-- Default tree schematics
local dpath = minetest.get_modpath("default") .. "/schematics/"

lucky_block:add_schematics({
	{"appletree", dpath .. "apple_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
	{"jungletree", dpath .. "jungle_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
	{"defpinetree", dpath .. "pine_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
	{"acaciatree", dpath .. "acacia_tree_from_sapling.mts", {x = 4, y = 1, z = 4}},
	{"aspentree", dpath .. "aspen_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
	{"corals", dpath .. "corals.mts", {x = 2, y = 1, z = 2}},
	{"largecactus", dpath .. "large_cactus.mts", {x = 2, y = 0, z = 0}},
	{"defaultbush", dpath .. "bush.mts", {x = 1, y = 1, z = 1}},
	{"acaciabush", dpath .. "acacia_bush.mts", {x = 1, y = 1, z = 1}},
})

-- Default blocks
lucky_block:add_blocks({
	{"sch", "watertrap", 1, true},
	{"tel"},
	{"dro", {"wool:"}, 10, true},
	{"dro", {"default:apple"}, 10},
	{"sch", "appletree", 0, false},
	{"dro", {"default:snow"}, 10},
	{"nod", "default:chest", 0, {
		{name = "bucket:bucket_water", max = 1},
		{name = "default:wood", max = 3},
		{name = "default:pick_diamond", max = 1},
		{name = "default:coal_lump", max = 3}}},
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
	{"dro", {"dye:"}, 10, true},
	{"dro", {"default:sword_steel"}},
	{"sch", "jungletree", 0, false},
	{"dro", {"default:pick_steel"}},
	{"dro", {"default:shovel_steel"}},
	{"dro", {"default:coal_lump"}, 3},
	{"sch", "defaultbush", 0, false},
	{"tro", "default:mese", "tnt_blast", true},
	{"sch", "acaciatree", 0, false},
	{"dro", {"default:axe_steel"}},
	{"dro", {"default:sword_bronze"}},
	{"exp", 3},
	{"sch", "platform", 1, true},
	{"nod", "default:wood", 0},
	{"dro", {"default:pick_bronze"}},
	{"sch", "aspentree", 0, false},
	{"dro", {"default:shovel_bronze"}},
	{"nod", "default:gravel", 0},
	{"sch", "largecactus", 0, false},
	{"dro", {"default:axe_bronze"}},
	{"dro", {"default:bookshelf", "default:book", "default:paper"}, 5},
	{"dro", {"default:fence_wood"}, 10},
	{"dro", {"default:fence_acacia_wood"}, 10},
	{"dro", {"default:fence_aspen_wood"}, 10},
	{"dro", {"default:fence_junglewood"}, 10},
	{"dro", {"default:fence_pine_wood"}, 10},
	{"sch", "obsidiantrap", 1, true},
})

-- default coral blocks
if minetest.registered_nodes["default:coral_brown"] then
	lucky_block:add_blocks({
		{"dro", {"default:coral_brown"}, 5},
		{"dro", {"default:coral_orange"}, 5},
		{"dro", {"default:coral_skeleton"}, 5},
		{"sch", "corals", 0, true},
	})
end

-- default mese post light or sands
if minetest.registered_nodes["default:mese_post_light"] then
	lucky_block:add_blocks({
		{"dro", {"default:mese_post_light"}, 5},
		{"dro", {"default:fence_wood"}, 5},
		{"nod", "default:mese_post_light"},
		{"dro", {"default:silver_sand"}, 20},
		{"dro", {"default:sand"}, 20},
		{"dro", {"default:desert_sand"}, 20},
		{"dro", {"default:gravel"}, 15},
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
or minetest.get_modpath("boost_cart") then
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

-- TNT mod
if minetest.get_modpath("tnt") then
local p = "tnt:tnt_burning"
lucky_block:add_blocks({
	{"dro", {"tnt:gunpowder"}, 5, true},
	{"fal", {p, p, p, p, p}, 1, true, 4},
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
	{"dro", {p.."wood_tile_flipped"}, 10},
	{"dro", {p.."wood_tile_center"}, 10},
	{"dro", {p.."wood_tile_full"}, 10},
	{"dro", {p.."wood_tile_up"}, 10},
	{"dro", {p.."wood_tile_down"}, 10},
	{"dro", {p.."wood_tile_left"}, 10},
	{"dro", {p.."wood_tile_right"}, 10},
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
	{"dro", {p.."trap_stone"}, 10},
	{"dro", {p.."trap_glass"}, 10},
	{"dro", {p.."trap_glow_glass"}, 10},
	{"sch", "trapstonetrap", 0, true},
	{"dro", {p.."all_faces_tree"}, 10},
	{"dro", {p.."all_faces_jungle_tree"}, 10},
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
lucky_block:add_blocks({
	{"dro", {"bags:small"}},
	{"dro", {"bags:medium"}},
	{"dro", {"bags:large"}},
	{"dro", {"bags:trolley"}},
})
end

-- Bonemeal mod
if minetest.get_modpath("bonemeal") then
lucky_block:add_blocks({
	{"dro", {"bonemeal:mulch"}, 10},
	{"dro", {"bonemeal:bonemeal"}, 10},
	{"dro", {"bonemeal:fertiliser"}, 10},
	{"dro", {"default:dirt"}, 20},
})
end

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
