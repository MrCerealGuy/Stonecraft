local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:seahorse", {
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
	collisionbox = {-0.1, 0, -0.1, 0.1, 0.6, 0.1},
	visual = "mesh",
	mesh = "Seahorse.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"textureseahorse.png"},
		{"textureseahorse2.png"},
	},
	sounds = {},
	makes_footstep_sound = false,
	walk_velocity = 0.25,
	run_velocity = 0.5,
	fly = true,
	fly_in = "default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "mcl_core:water_source", "mcl_core:water_flowing",
	fall_speed = 0,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
        stay_near = {{"default:sand_with_kelp", "marinara:sand_with_kelp", "default:softcoral_yellow", "marinara:sand_with_seagrass2", "default_clay"}, 5},
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
		stand2_start = 0,
		stand2_end = 1,
                fly_speed = 30,
		fly_start = 100, -- swim animation
		fly_end = 200,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "mcl_core:water_source", "mcl_core:water_flowing"},
	floats = 0,
	follow = {
		 "animalworld:fishfood"
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
	name = "animalworld:seahorse",
	nodes = {"mcl_core:water_source", "default:water_source", "mcl_core:water_source", "mcl_core:water_flowing"},
	neighbors = {"default:sand_with_kelp", "mcl_flowers:waterlily", "mcl_ocean:seagrass:sand", "mcl_ocean:bubble_coral", "mcl_ocean:tube_coral", "mcl_ocean:fire_coral", "mcl_ocean:brain_coral", "mcl_ocean:seagrass_gravel"},
	min_light = 0,
	interval = 30,
	chance = 2000, -- 15000
	active_object_count = 4,
	min_height = -15,
	max_height = 0,
})
end

mobs:register_egg("animalworld:seahorse", S("Seahorse"), "aseahorse.png")
