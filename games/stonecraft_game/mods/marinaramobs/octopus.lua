local S = minetest.get_translator("marinaramobs")

mobs:register_mob("marinaramobs:octopus", {
stepheight = 0.0,
	type = "monster",
	passive = false,
	attack_animals = true,
	attack_npcs = true,
	reach = 2,
        damage = 5,
	attack_type = "dogshoot",
	dogshoot_switch = 1,
	dogshoot_count_max = 3, 
	dogshoot_count2_max = 5, 
	shoot_interval = 1,
	arrow = "marinara:octopusink",
	shoot_offset = 0.8,
	hp_min = 60,
	hp_max = 95,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	mesh = "Octopus.b3d",
	visual_size = {x = 0.5, y = 0.5},
	textures = {
		{"textureoctopus.png"},
	},
	sounds = {},
	makes_footstep_sound = false,
	sounds = {
		attack = "marinaramobs_octopus",
	},
	walk_velocity = 1,
	run_velocity = 2,
        fly = true,
	fly_in = "default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing",
	fall_speed = 0,
	runaway = false,
	jump = false,
	stepheight = 0.0,
        stay_near = {{"marinara:bountychest", "marinara:bountychest2", "marinara:bountychest3", "marinara:bountychest4", "marinara:bountychest5", "marinara:bountychest6", "marinara:bountychest7", "marinara:bountychest8", "marinara:bountychest9", "marinara:bountychest10", "marinara:bountychest11", "marinara:bountychest12", "marinara:hardcoral", "marinara:seapocks"}, 4},
	drops = {
		{name = "marinaramobs:octopus_raw", chance = 1, min = 0, max = 1},
		{name = "dye:black", chance = 1, min = 0, max = 1},
	},
	water_damage = 0,
        air_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		fly_start = 100,
		fly_end = 200,
		punch_start = 200,
		punch_end = 300,
                shoot_start = 200,
		shoot_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing"},
	floats = 0,
	follow = {
		"mobs:meat_raw", "xocean:fish_edible", "ethereal:fish_raw", "mobs:clownfish_raw", "mobs:bluefish_raw", "fishing:bait_worm", "fishing:clownfish_raw", "fishing:bluewhite_raw", "fishing:exoticfish_raw", "fishing:fish_raw", "fishing:carp_raw", "fishing:perch_raw", "water_life:meat_raw", "fishing:octopus_raw", "fishing:pike_raw", "marinaramobs:octopus_raw", "marinaramobs:raw_exotic_fish"
	},
	view_range = 6,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_marinaramobs then
mobs:spawn({
	name = "marinaramobs:octopus",
	nodes = {"default:water_source"},
	neighbors = {"marinara:bountychest", "marinara:bountychest2", "marinara:bountychest3", "marinara:bountychest4", "marinara:bountychest5", "marinara:bountychest6", "marinara:bountychest7", "marinara:bountychest8", "marinara:bountychest9", "marinara:bountychest10", "marinara:bountychest11"},
	min_light = 0,
	interval = 60,
	chance = 2, -- 15000
	min_height = -30,
	max_height = 0,
})

mobs:register_egg("marinaramobs:octopus", S("Octopus"), "aoctopus.png")

mobs:register_arrow("marinaramobs:octopusink", {
	visual = "sprite",
	visual_size = {x=.10, y=.10},
	textures = {"marinaramobs_octopusink.png"},
	velocity = 12,
	drop = true,

	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
		full_punch_interval=1.0,
		damage_groups = {fleshy=13},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
		full_punch_interval=1.0,
		damage_groups = {fleshy=13},
		}, nil)
	end,

	hit_node = function(self, pos, node)
	end,
})


-- raw octopus
minetest.register_craftitem("marinaramobs:octopus_raw", {
	description = S("Raw Octopus"),
	inventory_image = "marinaramobs_octopus_raw.png",
	on_use = minetest.item_eat(3),
	groups = {food_meat_raw = 1, flammable = 2},
})

-- cooked octopus
minetest.register_craftitem("marinaramobs:octopus_cooked", {
	description = S("Cooked Octopus"),
	inventory_image = "marinaramobs_octopus_cooked.png",
	on_use = minetest.item_eat(5),
	groups = {food_meat = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "marinaramobs:octopus_cooked",
	recipe = "marinaramobs:octopus_raw",
	cooktime = 5,
})
end
