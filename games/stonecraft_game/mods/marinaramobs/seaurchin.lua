local S = minetest.get_translator("marinaramobs")

mobs:register_mob("marinaramobs:seaurchin", {
stepheight = 1,
	type = "animal",
	passive = false,
	reach = 1,
	attack_npcs = true,
	attack_type = "dogfight",
	group_attack = true,
	attack_animals = false,
	reach = 2,
	damage = 4,
	hp_min = 10,
	hp_max = 40,
	armor = 100,
	visual_size = {x = 0.7, y = 0.7},
	collisionbox = {-0.2, -0.01, -0.2,  0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "Seaurchin.b3d",
	drawtype = "front",
	textures = {
		{"textureseaurchin.png"},

	},
	sounds = {
	},
	makes_footstep_sound = false,
	walk_velocity = 0.2,
	run_velocity = 0.3,
	runaway = false,
	jump = false,
	jump_height = 6,
	drops = {
		{name = "marinaramobs:seaurchin", chance = 1, min = 0, max = 1},
	},
        stay_near = {{"marinara:sand_with_alage", "marinara:sand_with_seagrass", "default:sand_with_kelp", "marinara:sand_with_kelp", "marinara:reed_root", "flowers:waterlily_waving", "naturalbiomes:waterlily", "default:clay", "marinara:softcoral_red", "marinara:softcoral_white", "marinara:softcoral_green", "marinara:softcoral_white", "marinara:softcoral_green", "default:coral_cyan", "default:coral_pink", "default:coral_green"}, 5},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 25,
		stand_start = 100,
		stand_end = 200,
		stand2_start = 200,
		stand2_end = 300,
		walk_start = 0,
		walk_end = 100,
		punch_start = 0,
		punch_end = 100,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:water_flowing"},
	floats = 0,
	follow = {"marinara:seagrass", "marinara:seagrass2", "marinara:sand_with_seagrass",
		"marinara:sand_with_seagrass2", "marinara:alage", "marinara:sand_with_alage", "default:kelp", "default:sand_with_kelp", "animalworld:rawfish", "mobs_fish:tropical", "mobs:clownfish_raw", 
"mobs:bluefish_raw", "fishing:bait_worm", "fishing:clownfish_raw", "fishing:bluewhite_raw", "fishing:exoticfish_raw", "fishing:fish_raw", "fishing:carp_raw", "fishing:perch_raw", "water_life:meat_raw", "fishing:shark_raw", "fishing:pike_raw", "marinaramobs:octopus_raw", "marinaramobs:raw_exotic_fish"},
	view_range = 5,
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_marinaramobs then
mobs:spawn({
	name = "marinaramobs:seaurchin",
	nodes = {"default:water_source"},
	neighbors = {"marinara:coastrock_alage"},
	min_light = 0,
	interval = 60,
	chance = 2, -- 15000
	active_object_count = 2,
	min_height = -30,
	max_height = 0,
})
end


mobs:register_egg("marinaramobs:seaurchin", S("Seaurchin"), "aseaurchin.png", 0)


mobs:alias_mob("marinaramobs:seaurchin", "marinaramobs:seaurchin") -- compatibility

minetest.register_craftitem(":marinaramobs:seaurchin_cooked", {
	description = S("Cooked Seaurchin"),
	inventory_image = "marinaramobs_seaurchin_cooked.png",
	on_use = minetest.item_eat(8),
	groups = {food_meat = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "marinaramobs:seaurchin_cooked",
	recipe = "marinaramobs:seaurchin",
	cooktime = 2,
})


