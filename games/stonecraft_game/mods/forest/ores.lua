minetest.register_node("forest:_stone_with_coal", {
	description = "Coal ore in desert stone",
	tiles = {"default_desert_stone.png^default_mineral_coal.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'default:coal_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("forest:_stone_with_iron", {
	description = "Iron ore in desert stone",
	tiles = {"default_desert_stone.png^default_mineral_iron.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = 'default:iron_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("forest:_stone_with_copper", {
	description = "Copper ore in desert stone",
	tiles = {"default_desert_stone.png^default_mineral_copper.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = 'default:copper_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("forest:_stone_with_gold", {
	description = "Gold ore in desert stone",
	tiles = {"default_desert_stone.png^default_mineral_gold.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = 'default:gold_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("forest:_stone_with_mese", {
	description = "Mese ore in desert stone",
	tiles = {"default_desert_stone.png^default_mineral_mese.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = {
		max_items = 1,
		items = {
			{items = {"default:mese_crystal"}, rarity = 8},
			{items = {"default:mese_crystal_fragment 8"}, rarity = 4},
			{items = {"default:mese_crystal_fragment 7"}, rarity = 2},
			{items = {"default:mese_crystal_fragment 6"}},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("forest:_gravel_with_coal", {
	description = "Coal ore in gravel",
	tiles = {"default_gravel.png^default_mineral_coal.png"},
	is_ground_content = true,
	groups = {crumbly=2, falling_node=1},
	drop = 'default:coal_lump',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
})

minetest.register_node("forest:_gravel_with_iron", {
	description = "Iron ore in gravel",
	tiles = {"default_gravel.png^default_mineral_iron.png"},
	is_ground_content = true,
	groups = {crumbly=1, falling_node=1},
	drop = 'default:iron_lump',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
})

minetest.register_node("forest:_gravel_with_gold", {
	description = "Gold ore in gravel",
	tiles = {"default_gravel.png^default_mineral_gold.png"},
	is_ground_content = true,
	groups = {crumbly=1, falling_node=1},
	drop = 'default:gold_lump',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
})

minetest.register_node("forest:_gravel_with_copper", {
	description = "Copper ore in gravel",
	tiles = {"default_gravel.png^default_mineral_copper.png"},
	is_ground_content = true,
	groups = {crumbly=1, falling_node=1},
	drop = 'default:copper_lump',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
})

minetest.register_node("forest:_gravel_with_diamond", {
	description = "Diamond ore in gravel",
	tiles = {"default_gravel.png^default_mineral_diamond.png"},
	is_ground_content = true,
	groups = {crumbly=1, falling_node=1},
	drop = 'default:diamond',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
})

minetest.register_node("forest:_gravel_with_mese", {
	description = "Mese ore in gravel",
	tiles = {"default_gravel.png^default_mineral_mese.png"},
	is_ground_content = true,
	groups = {crumbly=1, falling_node=1},
	drop = {
		max_items = 5,
		items = {
			{items = {"default:mese_crystal_fragment 2"}},
			{items = {"default:mese_crystal_fragment"}, rarity = 3},
			{items = {"default:mese_crystal_fragment"}, rarity = 3},
			{items = {"default:mese_crystal_fragment"}, rarity = 3},
		},
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
})

register_ore({
	ore = "default:water_source",
	wherein = "default:stone",
	frequency = 40,
	radius = 3,
	density = 10,
	gradiant = false,
	min_y = -80,
	max_y = 10,
	seed = 9945,
	scale = 100,
})

register_ore({
	ore = "forest:oil_source",
	wherein = "default:stone",
	frequency = 80,
	radius = 4,
	density = 400,
	gradiant = true,
	min_y = -200,
	max_y = -120,
	seed = 1692,
	scale = 100,
})

register_ore({
	ore = "default:lava_source",
	wherein = "default:stone",
	frequency = 2,
	radius = 12,
	density = 200,
	gradiant = true,
	min_y = -31000,
	max_y = -50,
	seed = 7787,
	scale = 100,
})

register_ore({
	ore = "default:lava_source",
	wherein = "default:stone",
	frequency = 4,
	radius = 8,
	density = 200,
	gradiant = true,
	min_y = -31000,
	max_y = -25,
	seed = 7787,
	scale = 100,
})

register_ore({
	ore = "default:lava_source",
	wherein = "default:stone",
	frequency = 5,
	radius = 4,
	density = 200,
	gradiant = true,
	min_y = -31000,
	max_y = -10,
	seed = 7787,
	scale = 100,
})

register_ore({
	ore = "default:gravel",
	wherein = "default:stone",
	frequency = 10,
	radius = 15,
	density = 100,
	gradiant = true,
	min_y = -31000,
	max_y = 31000,
	seed = 6430,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_coal",
	wherein = "default:stone",
	frequency = 1000,
	radius = 1,
	density = 50,
	gradiant = true,
	min_y = -31000,
	max_y = 31000,
	seed = 6808,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_coal",
	wherein = "default:stone",
	frequency = 1000,
	radius = 1,
	density = 50,
	gradiant = true,
	min_y = -31000,
	max_y = -20,
	seed = 6808,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_coal",
	wherein = "default:stone",
	frequency = 400,
	radius = 4,
	density = 50,
	gradiant = true,
	min_y = -100,
	max_y = -40,
	seed = 6808,
	scale = 100,
})

register_ore({
	ore = "forest:_stone_with_coal",
	wherein = "default:desert_stone",
	frequency = 600,
	radius = 2,
	density = 40,
	gradiant = true,
	min_y = -31000,
	max_y = 0,
	seed = 6808,
	scale = 100,
})

register_ore({
	ore = "forest:_stone_with_coal",
	wherein = "default:desert_stone",
	frequency = 200,
	radius = 3,
	density = 30,
	gradiant = true,
	min_y = -15,
	max_y = 100,
	seed = 6808,
	scale = 100,
})

register_ore({
	ore = "forest:_gravel_with_coal",
	wherein = "default:gravel",
	frequency = 300,
	radius = 1,
	density = 35,
	gradiant = true,
	min_y = -31000,
	max_y = 31000,
	seed = 6808,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_iron",
	wherein = "default:stone",
	frequency = 400,
	radius = 1,
	density = 80,
	gradiant = true,
	min_y = -31000,
	max_y = 31000,
	seed = 2491,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_iron",
	wherein = "default:stone",
	frequency = 300,
	radius = 2,
	density = 90,
	gradiant = true,
	min_y = -1000,
	max_y = -60,
	seed = 2491,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_iron",
	wherein = "default:stone",
	frequency = 100,
	radius = 3,
	density = 70,
	gradiant = true,
	min_y = -150,
	max_y = -10,
	seed = 2491,
	scale = 100,
})

register_ore({
	ore = "forest:_stone_with_iron",
	wherein = "default:desert_stone",
	frequency = 400,
	radius = 1,
	density = 40,
	gradiant = true,
	min_y = -100,
	max_y = 31000,
	seed = 2491,
	scale = 100,
})

register_ore({
	ore = "forest:_stone_with_iron",
	wherein = "default:desert_stone",
	frequency = 50,
	radius = 4,
	density = 60,
	gradiant = true,
	min_y = 100,
	max_y = 31000,
	seed = 2491,
	scale = 100,
})

register_ore({
	ore = "forest:_gravel_with_iron",
	wherein = "default:gravel",
	frequency = 2000,
	radius = 1,
	density = 70,
	gradiant = true,
	min_y = -31000,
	max_y = 31000,
	seed = 2491,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_copper",
	wherein = "default:stone",
	frequency = 350,
	radius = 1,
	density = 50,
	gradiant = false,
	min_y = -31000,
	max_y = -10,
	seed = 1285,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_copper",
	wherein = "default:stone",
	frequency = 100,
	radius = 3,
	density = 90,
	gradiant = false,
	min_y = -31000,
	max_y = -80,
	seed = 1285,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_copper",
	wherein = "default:stone",
	frequency = 25,
	radius = 1,
	density = 50,
	gradiant = false,
	min_y = -31000,
	max_y = -31000,
	seed = 1285,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_mese",
	wherein = "default:stone",
	frequency = 120,
	radius = 1,
	density = 30,
	gradiant = true,
	min_y = -31000,
	max_y = -70,
	seed = 2451,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_mese",
	wherein = "default:stone",
	frequency = 40,
	radius = 3,
	density = 50,
	gradiant = true,
	min_y = -31000,
	max_y = -200,
	seed = 2451,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_mese",
	wherein = "default:stone",
	frequency = 5,
	radius = 2,
	density = 20,
	gradiant = true,
	min_y = -31000,
	max_y = -31000,
	seed = 2451,
	scale = 100,
})

register_ore({
	ore = "forest:_stone_with_mese",
	wherein = "default:desert_stone",
	frequency = 30,
	radius = 1,
	density = 25,
	gradiant = true,
	min_y = -31000,
	max_y = 31000,
	seed = 2451,
	scale = 100,
})

register_ore({
	ore = "forest:_gravel_with_mese",
	wherein = "default:gravel",
	frequency = 40,
	radius = 1,
	density = 20,
	gradiant = false,
	min_y = -31000,
	max_y = 31000,
	seed = 2451,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_diamond",
	wherein = "default:stone",
	frequency = 80,
	radius = 1,
	density = 20,
	gradiant = false,
	min_y = -31000,
	max_y = -40,
	seed = 287,
	scale = 100,
})

register_ore({
	ore = "default:stone_with_diamond",
	wherein = "default:stone",
	frequency = 100,
	radius = 2,
	density = 40,
	gradiant = true,
	min_y = -31000,
	max_y = -180,
	seed = 287,
	scale = 100,
})

register_ore({
	ore = "forest:_gravel_with_diamond",
	wherein = "default:gravel",
	frequency = 10,
	radius = 1,
	density = 20,
	gradiant = false,
	min_y = -31000,
	max_y = 0,
	seed = 287,
	scale = 100,
})

register_ore({
	ore = "default:mese",
	wherein = "default:stone_with_mese",
	frequency = 200,
	radius = 5,
	density = 100,
	gradiant = false,
	min_y = -31000,
	max_y = -300,
	seed = 1322,
	scale = 100,
})

register_ore({
	ore = "default:clay",
	wherein = "default:sand",
	frequency = 100,
	radius = 5,
	density = 100,
	gradiant = true,
	min_y = -40,
	max_y = 20,
	seed = 6975,
	scale = 100,
})

register_ore({
	ore = "forest:mud_source",
	wherein = "default:dirt",
	frequency = 80,
	radius = 2,
	density = 100,
	gradiant = true,
	min_y = 0,
	max_y = 20,
	seed = 2752,
	scale = 100,
})

register_ore({
	ore = "forest:mud_source",
	wherein = "default:dirt",
	frequency = 30,
	radius = 2,
	density = 100,
	gradiant = true,
	min_y = -12,
	max_y = 70,
	seed = 2752,
	scale = 100,
})

register_ore({
	ore = "default:sandstone",
	wherein = "default:sand",
	frequency = 200,
	radius = 3,
	density = 50,
	gradiant = true,
	min_y = -20,
	max_y = 90,
	seed = 4209,
	scale = 100,
})

register_ore({
	ore = "default:nyancat_rainbow",
	--center = "default:nyancat",
	wherein = "default:stone",
	frequency = 1,
	radius = 2,
	density = 50,
	gradiant = true,
	min_y = -20,
	max_y = 90,
	seed = 4209,
	scale = 100,
})

register_ore({
	ore = "default:nyancat",
	--center = "default:nyancat",
	wherein = "default:lava_source",
	frequency = 1,
	radius = 0,
	density = 100,
	gradiant = false,
	min_y = -31000,
	max_y = 31000,
	seed = 4209,
	scale = 100,
})
