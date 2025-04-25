local S = minetest.get_translator("animalworld")


mobs:register_mob("animalworld:wasp", {
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	reach = 1,
        damage = 2,
	hp_min = 1,
	hp_max = 10,
	armor = 100,
	collisionbox = {-0.1, -0.01, -0.1, 0.1, 0.1, 0.1},
	visual = "mesh",
	mesh = "Wasp.b3d",
	visual_size = {x = 1, y = 1},
	textures = {
		{"texturewasp.png"},
	},
	sounds = {
		random = "animalworld_wasp",
		attack = "animalworld_wasp2",
		damage = "animalworld_wasp4",
		death = "animalworld_wasp3",
	},
	makes_footstep_sound = false,
	stay_near = {"animalworld:waspnest", 3},
	view_range = 7,
	walk_velocity = 1,
        walk_chance = 70,
	run_velocity = 2,
        fly = true,
        fly_in = {"air"},
	floats = 0,
	runaway = false,
	stay_near = {"animalworld:waspnest", 3},
	jump = true,
        jump_height = 6,
	stepheight = 3,
	drops = {
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 0,
	animation = {
		speed_normal = 400,
		stand_start = 0,
		stand_end = 100,
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
	name = "animalworld:wasp",
	nodes = {"animalworld:waspnest"},
	neighbors = {"air"},
	min_light = 0,
	interval = 30,
	chance = 1, -- 15000
	active_object_count = 7,
	min_height = 0,
	max_height = 50,
        day_toggle = true
})
end

mobs:register_egg("animalworld:wasp", S("Wasp"), "awasp.png")

mobs:alias_mob("animalworld:wasp", "animalworld:wasp")


	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:aspen_leaves", "mcl_trees:tree_birch", "mcl_core:birchleaves", "mcl_trees:leaves_birch"},
	        neighbors = {"animalworld:waspnest"},
		sidelen = 16,
		noise_params = {
			offset = 1,
			scale = 1,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		y_max = 75,
		y_min = 0,
		decoration = "animalworld:waspnest"
	})

minetest.register_node("animalworld:waspnest", {
    description = S"Wasp Nest",
    visual_scale = 0.5,
    mesh = "Waspnest.b3d",
    tiles = {"texturewaspnest.png"},
    inventory_image = "awaspnest.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3, axey = 1, handy = 1},
    _mcl_hardness = 0.8,
    _mcl_blast_resistance = 1,
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -2.5, -0.5, 0.5, -1.5, 0.5},
            --[[{-0.5, -2.5, -0.5, 0.5, -1.5, 0.5},
            {-0.5, -2.5, -0.5, 0.5, -1.5, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -2.5, -0.5, 0.5, -1.5, 0.5}
        }
    },
	drop = "default:paper",
	sounds = animalworld.sounds.node_sound_dirt_defaults(),
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:waspnest",
	burntime = 1,
})