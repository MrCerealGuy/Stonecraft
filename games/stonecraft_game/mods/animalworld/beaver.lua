local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:beaver", {
stepheight = 1,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = false,
	attack_npcs = false,
	reach = 2,
        damage = 6,
	hp_min = 35,
	hp_max = 65,
	armor = 100,
	collisionbox = {-0.6, -0.01, -0.6, 0.6, 0.95, 0.6},
	visual = "mesh",
	mesh = "Beaver.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturebeaver.png"},
	},
	sounds = {
	},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2,
	runaway = false,
	jump = true,
        jump_height = 6,
	stepheight = 2,
        stay_near = {{"animalworld:beaver_nest"}, 4},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 75,
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		walk_start = 200,
		walk_end = 300,
		fly_start = 450, -- swim animation
		fly_end = 550,
		punch_start = 300,
		punch_end = 400,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "mcl_core:water_source", "mcl_core:water_flowing"},
	floats = 1,
	follow = {
		"naturalbiomes:alder_sapling", "naturalbiomes:alppine1_sapling", "naturalbiomes:alppine2_sapling",
		"naturalbiomes:alpine_bush_sapling", "default:sapling", "default:junglesapling", "default:pine_sapling", "default:acacia_sapling", "default:aspen_sapling", "naturalbiomes:olive_sapling", "naturalbiomes:pine_sapling", "naturalbiomes:acacia_sapling", "naturalbiomes:bamboo_sapling", "ethereal:bamboo_sprout", "ethereal:yellow_tree_sapling", "ethereal:willow_sapling", "ethereal:birch_sapling", "ethereal:olive_tree_sapling"
	},
	view_range = 5,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 15, 25, 0, false, nil) then return end
	end,
})

if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:grove_dirt", "default:dry_dirt_with_dry_grass", "default:dirt_with_rainforest_litter"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:beaver",
	nodes = {"mcl_core:water_source", "default:water_source", "default:river_water_source", "mcl_core:water_source", "mcl_core:water_flowing"},
	neighbors = {"animalworld:beaver_nest"},
	min_light = 0,
	interval = 60,
	chance = 1, -- 15000
	active_object_count = 2,
	min_height = 0,
	max_height = 6,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:beaver", S("Beaver"), "abeaver.png")

-- beaver nest
minetest.register_node("animalworld:beaver_nest", {
	description = S("Beaver Nest"),
	tiles = {"animalworld_beaver_nest.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, axey = 2, handy = 1, oddly_breakable_by_hand = 1, flammable = 3},
	_mcl_hardness = 1,
	_mcl_blast_resistance = 1,
	sounds = animalworld.sounds.node_sound_wood_defaults(),
})

	minetest.register_decoration({
		name = "animalworld:beavernest",
		deco_type = "schematic",
		place_on = {"naturalbiomes:alderswamp_litter"},
		place_offset_y = -2,
    sidelen = 16,
    fill_ratio = 0.00018,
		biomes = {"naturalbiomes:alderswamp"},
		y_max = 1,
		y_min = 0,
		schematic = minetest.get_modpath("animalworld") .. "/schematics/animalworld_beavernest.mts",
		flags = "place_center_x",
    flags = "force_placement",
		rotation = "random",
		spawn_by = "naturalbiomes:alderswamp_litter",
		num_spawn_by = 8,
	})
