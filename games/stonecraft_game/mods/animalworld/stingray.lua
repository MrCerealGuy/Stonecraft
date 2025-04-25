local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:stingray", {
stepheight = 0.0,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 2,
        damage = 6,
	hp_min = 15,
	hp_max = 65,
	armor = 100,
	collisionbox = {-0.7, -0.01, -0.7, 0.7, 0.95, 0.7},
	visual = "mesh",
	mesh = "Stingray.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturestingray.png"},
	},
	sounds = {},
	makes_footstep_sound = false,
	sounds = {
		attack = "animalworld_shark",
	},
	walk_velocity = 2,
	run_velocity = 4,
        fly = true,
	fly_in = "default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "mcl_core:water_source", "mcl_core:water_flowing",
	fall_speed = 0,
	runaway = false,
	jump = false,
	stepheight = 0.0,
        stay_near = {{"marinara:sand_with_alage", "mcl_ocean:bubble_coral", "mcl_ocean:tube_coral", "mcl_ocean:fire_coral", "mcl_ocean:brain_coral", "mcl_ocean:seagrass_gravel", "mcl_flowers:waterlily", "marinara:sand_with_seagrass", "default:sand_with_kelp", "marinara:sand_with_kelp", "marinara:reed_root", "flowers:waterlily_waving", "naturalbiomes:waterlily", "default:clay"}, 5},
	drops = {
		{name = "animalworld:rawfish", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
        air_damage = 2,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 100,
		stand_start = 0,
		stand_end = 100,
		fly_start = 100, -- swim animation
		fly_end = 200,
		punch_start = 200,
		punch_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "mcl_core:water_source", "mcl_core:water_flowing"},
	floats = 0,
	follow = {
		"mobs:meat_raw", "animalworld:raw_athropod", "xocean:fish_edible", "ethereal:fish_raw", "mobs:clownfish_raw", "mobs:bluefish_raw", "fishing:bait_worm", "fishing:clownfish_raw", "fishing:bluewhite_raw", "fishing:exoticfish_raw", "fishing:fish_raw", "fishing:carp_raw", "fishing:perch_raw", "water_life:meat_raw", "fishing:shark_raw", "fishing:pike_raw", "animalworld:rawfish"
	},
	view_range = 2,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:stingray",
	nodes = {"mcl_core:water_source", "default:water_source", "default:river_water_source", "mcl_core:water_source", "mcl_core:water_flowing"},
	neighbors = {"naturalbiomes:palmbeach_sand", "mcl_core:sand", "mcl_core:gravel"},
	min_light = 0,
	interval = 60,
	active_object_count = 2,
	chance = 2000, -- 15000
	min_height = -10,
	max_height = 5,
})
end

mobs:register_egg("animalworld:stingray", S("Stingray"), "astingray.png")
