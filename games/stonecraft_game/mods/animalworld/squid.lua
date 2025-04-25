local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:squid", {
stepheight = 0.0,
	type = "animal",
	passive = false,
        attack_type = "dogfight",
	attack_animals = false,
	reach = 2,
        damage = 8,
	hp_min = 10,
	hp_max = 40,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 0.4, 0.4},
	visual = "mesh",
	mesh = "Squid.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturesquid.png"},
	},
	sounds = {},
	makes_footstep_sound = false,
	sounds = {
	},
	walk_velocity = 1,
	run_velocity = 3,
        fly = true,
	fly_in = "default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "mcl_core:water_source", "mcl_core:water_flowing",
	fall_speed = 0,
	runaway = false,
	jump = false,
	stepheight = 0.0,
        stay_near = {{"default:sand_with_kelp", "mcl_ocean:bubble_coral", "mcl_ocean:tube_coral", "mcl_ocean:fire_coral", "mcl_ocean:brain_coral", "mcl_ocean:seagrass_gravel", "mcl_ocean:seagrass:sand", "marinara:sand_with_kelp", "default:softcoral_yellow", "marinara:sand_with_seagrass2", "default_clay", "marinara:sand_with_alage"}, 5},
	drops = {
		{name = "animalworld:rawmollusk", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
        air_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 100,
		stand_start = 0,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		fly_start = 100, -- swim animation
		fly_end = 200,
		punch_start = 270,
		punch_end = 330,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "mcl_core:water_source", "mcl_core:water_flowing"},
	floats = 0,
follow = {
		"mobs:meat_raw", "xocean:fish_edible", "mcl_fishing:pufferfish_raw", "ethereal:fish_raw", "mobs:clownfish_raw", "mobs:bluefish_raw", "fishing:bait_worm", "fishing:clownfish_raw", "fishing:bluewhite_raw", "fishing:exoticfish_raw", "fishing:fish_raw", "fishing:carp_raw", "fishing:perch_raw", "water_life:meat_raw", "fishing:shark_raw", "fishing:pike_raw"
	},
	view_range = 6,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:squid",
	nodes = {"mcl_core:water_source", "default:water_source", "mcl_core:water_source", "mcl_core:water_flowing"},
	neighbors = {"marinara:sand_with_alage", "marinara:sand_with_seagrass", "default:sand_with_kelp", "marinara:sand_with_kelp", "default:clay", "mcl_ocean:seagrass:sand", "mcl_ocean:tube_coral", "mcl_ocean:fire_coral", "mcl_ocean:brain_coral", "mcl_ocean:seagrass_gravel"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 4,
	min_height = -20,
	max_height = 10,
	day_toggle = false,
})
end

mobs:register_egg("animalworld:squid", S("Squid"), "asquid.png")

-- raw squid
minetest.register_craftitem(":animalworld:rawmollusk", {
	description = S("Raw Mollusk"),
	inventory_image = "animalworld_rawmollusk.png",
	on_use = minetest.item_eat(3),
	groups = {food_meat_raw = 1, flammable = 2},
})

-- cooked fish
minetest.register_craftitem(":animalworld:cookedmollusk", {
	description = S("Fried Mollusk"),
	inventory_image = "animalworld_cookedmollusk.png",
	on_use = minetest.item_eat(5),
	groups = {food_meat = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "animalworld:cookedmollusk",
	recipe = "animalworld:rawmollusk",
	cooktime = 5,
})

