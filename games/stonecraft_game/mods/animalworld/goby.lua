local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:goby", {
stepheight = 0.0,
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = false,
	reach = 1,
        damage = 0,
	hp_min = 5,
	hp_max = 5,
	armor = 100,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "Goby.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturegoby.png"},
	},
	sounds = {},
	makes_footstep_sound = false,
	walk_velocity = 0.5,
	run_velocity = 1,
	fly = true,
	fly_in = "default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "mcl_core:water_source", "mcl_core:water_flowing",
	fall_speed = 0,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
	stepheight = 0.0,
	drops = {
		{name = "animalworld:rawfish", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
        air_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
        stay_near = {{"marinara:sand_with_alage", "marinara:sand_with_seagrass", "mcl_ocean:bubble_coral", "mcl_ocean:tube_coral", "mcl_ocean:fire_coral", "mcl_ocean:brain_coral", "mcl_ocean:seagrass_gravel", "default:sand_with_kelp", "marinara:sand_with_kelp", "marinara:reed_root", "flowers:waterlily_waving", "naturalbiomes:waterlily", "default:clay", "marinara:softcoral_red", "marinara:softcoral_white", "marinara:softcoral_green", "marinara:softcoral_white", "marinara:softcoral_green", "default:coral_cyan", "default:coral_pink", "default:coral_green"}, 4},
	animation = {
		speed_normal = 200,
		stand_start = 0,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		fly_start = 100, -- swim animation
		fly_end = 200,
		die_start = 100,
		die_end = 200,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "mcl_core:water_source", "mcl_core:water_flowing"},
	floats = 0,
	follow = {
		"ethereal:worm", "seaweed", "fishing:bait_worm",
		"animalworld:ant", "animalworld:termite", "animalworld:fishfood"
	},
	view_range = 5,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:goby",
	nodes = {"mcl_core:water_source", "default:water_source", "default:river_water_source"},
	neighbors = {"default:coral_cyan", "default:coral_green", "default:coral_pink", "mcl_ocean:bubble_coral", "mcl_ocean:tube_coral", "mcl_ocean:fire_coral", "mcl_ocean:brain_coral", "mcl_ocean:seagrass_gravel"},
	min_light = 0,
	interval = 30,
	chance = 2000, -- 15000
	active_object_count = 4,
	min_height = -15,
	max_height = 30,
})
end

mobs:register_egg("animalworld:goby", S("Goby"), "agoby.png")
