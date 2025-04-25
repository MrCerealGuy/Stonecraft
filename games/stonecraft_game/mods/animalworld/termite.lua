local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:termite", {
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	reach = 1,
        damage = 1,
	hp_min = 1,
	hp_max = 10,
	armor = 100,
	collisionbox = {-0.1, -0.01, -0.1, 0.1, 0.1, 0.1},
	visual = "mesh",
	mesh = "Termite.b3d",
	visual_size = {x = 1, y = 1},
	textures = {
		{"texturetermite.png"},
	},
	sounds = {
		random = "animalworld_termite",
		attack = "animalworld_termite",
	},
	makes_footstep_sound = true,
	view_range = 3,
	walk_velocity = 0.5,
        walk_chance = 70,
	run_velocity = 0.7,
	runaway = false,
	stay_near = {"animalworld:termitemould", 3},
	jump = false,
        jump_height = 0,
	stepheight = 3,
	drops = {
		{name = "animalworld:termite", chance = 1, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 200,
		stand_start = 0,
		stand_end = 0,
		walk_start = 0,
		walk_end = 100,
		punch_start = 100,
		punch_end = 200,
		die_start = 100,
		die_end = 200,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
})


if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:termite",
	nodes = {"default:dry_dirt_with_dry_grass", "mcl_core:dirt_with_grass", "mcl_core:dirt_with_grass"},
	neighbors = {"animalworld:termitemould"},
	min_light = 0,
	interval = 30,
	chance = 1, -- 15000
	active_object_count = 7,
	min_height = 0,
	max_height = 50,
	})
end

mobs:register_egg("animalworld:termite", ("Termite"), "atermite.png")

mobs:alias_mob("animalworld:termite", "animalworld:Termite")


minetest.register_craftitem(":animalworld:termitequeen", {
	description = S("Termite Queen"),
	inventory_image = "animalworld_termitequeen.png",
	on_use = minetest.item_eat(2),
	groups = {food_meat_raw = 1, flammable = 2},
})



	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dry_dirt_with_dry_grass", "mcl_core:dirt_with_grass"},
	        neighbors = {"default:acacia_bush_leaves", "mcl_trees:leaves_acacia",  "mcl_core:acacialeaves"},
		sidelen = 16,
		noise_params = {
			offset = 0.0012,
			scale = 0.0007,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		y_max = 50,
		y_min = 0,
		decoration = "animalworld:termitemould"
	})

minetest.register_node("animalworld:termitemould", {
    description = S"Termite Mound",
    visual_scale = 1,
    mesh = "Termitemould.b3d",
    tiles = {"texturetermitemould.png"},
    inventory_image = "atermitemould.png",
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    groups = {cracky = 3, pickaxey = 1, stone = 2},
    _mcl_hardness = 0.8,
    _mcl_blast_resistance = 1,
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        }
    },
	drop = "animalworld:termiteconcrete 16", 
	sounds = animalworld.sounds.node_sound_dirt_defaults(),
})

minetest.register_node("animalworld:termiteconcrete", {
	description = S("Termite Concrete"),
	tiles = {"termiteconcrete.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})


minetest.register_craft({
	type = "cooking",
	output = "animalworld:termitequeen",
	recipe = "animalworld:termiteconcrete",
})

minetest.register_node("animalworld:termiteconcreteblue", {
	description = S("Termite Concrete Blue"),
	tiles = {"termiteconcreteblue.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})


minetest.register_craft({
	output = "animalworld:termiteconcreteblue 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:blue", "default:sand", "bucket:bucket_water"}

	
})

minetest.register_node("animalworld:termiteconcretegreen", {
	description = S("Termite Concrete Green"),
	tiles = {"termiteconcretegreen.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})


minetest.register_craft({
	output = "animalworld:termiteconcretegreen 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:green", "default:sand", "bucket:bucket_water"}

	
})

minetest.register_node("animalworld:termiteconcreteyellow", {
	description = S("Termite Concrete Yellow"),
	tiles = {"termiteconcreteyellow.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})


minetest.register_craft({
	output = "animalworld:termiteconcreteyellow 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:yellow", "default:sand", "bucket:bucket_water"}

	
})

minetest.register_node("animalworld:termiteconcretered", {
	description = S("Termite Concrete Red"),
	tiles = {"termiteconcretered.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})


minetest.register_craft({
	output = "animalworld:termiteconcretered 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:red", "default:sand", "bucket:bucket_water"}

	
})

minetest.register_node("animalworld:termiteconcreteorange", {
	description = S("Termite Concrete Orange"),
	tiles = {"termiteconcreteorange.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})


minetest.register_craft({
	output = "animalworld:termiteconcreteorange 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:orange", "default:sand", "bucket:bucket_water"}

	
})

minetest.register_node("animalworld:termiteconcreteviolet", {
	description = S("Termite Concrete Violet"),
	tiles = {"termiteconcreteviolet.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})


minetest.register_craft({
	output = "animalworld:termiteconcreteviolet 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:violet", "default:sand", "bucket:bucket_water"}

	
})

minetest.register_node("animalworld:termiteconcretewhite", {
	description = S("Termite Concrete White"),
	tiles = {"termiteconcretewhite.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})


minetest.register_craft({
	output = "animalworld:termiteconcretewhite 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:white", "default:sand", "bucket:bucket_water"}

	
})

minetest.register_node("animalworld:termiteconcreteblack", {
	description = S("Termite Concrete Black"),
	tiles = {"termiteconcreteblack.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "animalworld:termiteconcreteblack 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:black", "default:sand", "bucket:bucket_water"}

	
})

minetest.register_node("animalworld:termiteconcretegrey", {
	description = S("Termite Concrete Grey"),
	tiles = {"termiteconcretegrey.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "animalworld:termiteconcretegrey 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:grey", "default:sand", "bucket:bucket_water"}

	
})

minetest.register_node("animalworld:termiteconcretedarkgreen", {
	description = S("Termite Concrete Dark Green"),
	tiles = {"termiteconcretedarkgreen.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "animalworld:termiteconcretedarkgreen 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:darkgreen", "default:sand", "bucket:bucket_water"}

	
})

minetest.register_node("animalworld:termiteconcretebrown", {
	description = S("Termite Concrete Brown"),
	tiles = {"termiteconcretebrown.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "animalworld:termiteconcretebrown 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:brown", "default:sand", "bucket:bucket_water"}

	
})

minetest.register_node("animalworld:termiteconcretepink", {
	description = S("Termite Concrete Pink"),
	tiles = {"termiteconcretepink.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "animalworld:termiteconcretepink 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:pink", "default:sand", "bucket:bucket_water"}

	
})

minetest.register_node("animalworld:termiteconcretemagenta", {
	description = S("Termite Concrete Magenta"),
	tiles = {"termiteconcretemagenta.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "animalworld:termiteconcretemagenta 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:magenta", "default:sand", "bucket:bucket_water"}

	
})

minetest.register_node("animalworld:termiteconcretecyan", {
	description = S("Termite Concrete Cyan"),
	tiles = {"termiteconcretecyan.png"},
	is_ground_content = false,
	groups = {cracky = 3, pickaxey = 1, stone = 2},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "animalworld:termiteconcretecyan 16",
	type = "shapeless",
	recipe = 
		{"animalworld:termiteconcrete", "dye:cyan", "default:sand", "bucket:bucket_water"}

	
})