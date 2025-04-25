local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:shark", {
stepheight = 0.0,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 2,
        damage = 14,
	hp_min = 30,
	hp_max = 95,
	armor = 100,
	collisionbox = {-0.7, -0.01, -0.7, 0.7, 0.95, 0.7},
	visual = "mesh",
	mesh = "Shark.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"textureshark.png"},
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
        stay_near = {{"marinara:sand_with_alage", "mcl_ocean:tube_coral", "mcl_ocean:fire_coral", "mcl_ocean:brain_coral", "mcl_ocean:seagrass_gravel", "mcl_flowers:waterlily", "mcl_ocean:seagrass:sand", "marinara:sand_with_seagrass", "default:sand_with_kelp", "marinara:sand_with_kelp", "marinara:reed_root", "flowers:waterlily_waving", "naturalbiomes:waterlily", "default:clay"}, 5},
	drops = {
		{name = "animalworld:rawfish", chance = 1, min = 1, max = 1},
		{name = "animalworld:sharkcorpse", chance = 7, min = 1, max = 1},
	},
	water_damage = 0,
        air_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 100,
		stand_start = 0,
		stand_end = 0,
		walk_start = 0,
		walk_end = 100,
		fly_start = 0, -- swim animation
		fly_end = 100,
		punch_start = 100,
		punch_end = 200,
		die_start = 100,
		die_end = 200,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "mcl_core:water_source", "mcl_core:water_flowing"},
	floats = 0,
	follow = {
		"mobs:meat_raw", "xocean:fish_edible", "ethereal:fish_raw", "mobs:clownfish_raw", "mobs:bluefish_raw", "fishing:bait_worm", "fishing:clownfish_raw", "fishing:bluewhite_raw", "fishing:exoticfish_raw", "fishing:fish_raw", "fishing:carp_raw", "fishing:perch_raw", "water_life:meat_raw", "fishing:shark_raw", "fishing:pike_raw", "animalworld:rawmollusk", "marinaramobs:octopus_raw", "marinara:raw_oisters", "marinara:raw_athropod", "animalworld:rawfish", "fishing:fish_raw", "fishing:pike_raw", "marinaramobs:raw_exotic_fish", "nativevillages:catfish_raw", "xocean:fish_edible", "ethereal:fish_raw", "mobs:clownfish_raw", "fishing:bluewhite_raw", "fishing:exoticfish_raw", "fishing:fish_raw", "fishing:carp_raw", "fishing:perch_raw", "water_life:meat_raw", "fishing:shark_raw", "fishing:pike_raw", "mobs:meatblock_raw", "animalworld:chicken_raw", "livingfloatlands:ornithischiaraw", "livingfloatlands:largemammalraw", "livingfloatlands:theropodraw", "livingfloatlands:sauropodraw", "animalworld:raw_athropod", "animalworld:whalemeat_raw", "animalworld:rabbit_raw", "mcl_mobitems:chicken", "mcl_fishing:pufferfish_raw", "mcl_mobitems:rotten_flesh", "mcl_mobitems:mutton", "mcl_mobitems:beef", "mcl_mobitems:porkchop", "mcl_mobitems:rabbit", "nativevillages:chicken_raw", "mobs:meat_raw", "animalworld:pork_raw", "people:mutton:raw"
	},
	view_range = 15,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:shark",
	nodes = {"mcl_core:water_source", "default:water_source", "mcl_core:water_source", "mcl_core:water_flowing"},
	neighbors = {"marinara:sand_with_alage", "mcl_ocean:seagrass:sand", "mcl_ocean:bubble_coral", "mcl_ocean:tube_coral", "mcl_ocean:fire_coral", "mcl_ocean:brain_coral", "mcl_ocean:seagrass_gravel", "marinara:sand_with_seagrass", "default:sand_with_kelp", "marinara:sand_with_kelp", "default:clay"},
	min_light = 0,
	interval = 60,
	chance = 1000, -- 15000
	min_height = -40,
	max_height = 10,
	day_toggle = false,
})
end

mobs:register_egg("animalworld:shark", S("Shark"), "ashark.png")
