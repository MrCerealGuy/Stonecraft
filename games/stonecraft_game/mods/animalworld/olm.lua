local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:olm", {
stepheight = 0.0,
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = false,
	reach = 1,
        damage = 1,
	hp_min = 10,
	hp_max = 25,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.3, 0.3},
	visual = "mesh",
	mesh = "Olm.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"textureolm.png"},
	},
	sounds = {},
	makes_footstep_sound = false,
	walk_velocity = 1,
        walk_chance = 10,
	run_velocity = 2,
	fly = true,
	fly_in = "default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "livingcaves:water_source", "livingcaves:water_flowing", "mcl_core:water_source", "mcl_core:water_flowing",
	fall_speed = 0,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
	stepheight = 0.0,
	drops = {
	},
	water_damage = 0,
        air_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		fly_speed = 100,
		fly_start = 150, -- swim animation
		fly_end = 250,
		die_start = 100,
		die_end = 200,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "livingcaves:water_source", "livingcaves:water_flowing", "mcl_core:water_source", "mcl_core:water_flowing"},
	floats = 0,
	follow = {
		"ethereal:worm", "seaweed", "fishing:bait_worm", "animalworld:ant", "animalworld:termite", "animalworld:fishfood"
	},
	view_range = 1,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 15, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:olm",
	nodes = {"mcl_core:water_source", "default:water_source", "mcl_core:water_source", "mcl_core:water_flowing", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "livingcaves:water_source", "livingcaves:water_flowing",},
	neighbors = {"default:stone", "mcl_core:stone"},
	min_light = 0,
	interval = 30,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = -500,
	max_height = -25,
})
end

mobs:register_egg("animalworld:olm", ("Olm"), "aolm.png")



