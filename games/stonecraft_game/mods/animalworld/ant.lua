local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:ant", {
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
	mesh = "Ant.b3d",
	visual_size = {x = 1, y = 1},
	textures = {
		{"textureant.png"},
	},
	sounds = {
		random = "animalworld_ant",
		attack = "animalworld_ant",
	},
	makes_footstep_sound = true,
	stay_near = {"animalworld:anthill", 3},
	view_range = 3,
	walk_velocity = 0.5,
        walk_chance = 70,
	run_velocity = 0.7,
	runaway = false,
	jump = false,
        jump_height = 0,
	stepheight = 3,
        stay_near = {{"animalworld:anthill"}, 4},
	drops = {
		{name = "animalworld:ant", chance = 1, min = 1, max = 1},
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
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
})


if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:ant",
	nodes = {"mcl_core:podzol", "mcl_core:dirt_with_grass", "default:dirt_with_conifrous_litter"},
	neighbors = {"animalworld:anthill"},
	min_light = 0,
	interval = 30,
	chance = 1, -- 15000
	active_object_count = 7,
	min_height = 0,
	max_height = 50,
        day_toggle = true
})
end

mobs:register_egg("animalworld:ant", S("Ant"), "aant.png")

mobs:alias_mob("animalworld:ant", "animalworld:ant")


minetest.register_craftitem(":animalworld:anteggs_raw", {
	description = S("Raw Ant Eggs"),
	inventory_image = "animalworld_anteggs_raw.png",
	on_use = minetest.item_eat(2),
	groups = {food_meat_raw = 1, flammable = 2},
})


minetest.register_craftitem(":animalworld:anteggs_cooked", {
	description = S("Cooked Ant Eggs"),
	inventory_image = "animalworld_anteggs_cooked.png",
	on_use = minetest.item_eat(6),
	groups = {food_meat = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "animalworld:anteggs_cooked",
	recipe = "animalworld:anteggs_raw",
	cooktime = 5,
})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_coniferous_litter", "mcl_core:podzol"},
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
		decoration = "animalworld:anthill"
	})

minetest.register_node("animalworld:anthill", {
    description = S"Anthill",
    visual_scale = 0.5,
    mesh = "Anthil.b3d",
    tiles = {"textureanthil.png"},
    inventory_image = "aanthil.png",
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    groups = {crumbly = 3, shovely = 1, handy = 1,  sand = 2},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.1, 0.5},
            --[[{-0.5, -0.5, -0.5, 0.5, 0.1, 0.5},
            {-0.5, -0.5, -0.5, 0.5, 0.1, 0.5}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.1, 0.5}
        }
    },
	drop = "animalworld:anteggs_raw",
	sounds = animalworld.sounds.node_sound_dirt_defaults(),
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:anthill",
	burntime = 1,
})