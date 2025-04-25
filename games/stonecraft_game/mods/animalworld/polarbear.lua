local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:polarbear", {
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 2,
        damage = 10,
	hp_min = 25,
	hp_max = 80,
	armor = 100,
        knock_back = false,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 1.4, 0.5},
	visual = "mesh",
	mesh = "Polarbear.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturepolarbear.png"},
	},
	sounds = {
		random = "animalworld_bear",
	},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 3,
	runaway = false,
	jump = false,
        jump_height = 6,
	stepheight = 2,
        stay_near = {{"default:snow"}, 5},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
		{name = "animalworld:polarbearcorpse", chance = 7, min = 1, max = 1},
	},
        fly_in = {"default:water_source", "default:water_flowing", "default:river_water_flowing", "default:river_water",  "mcl_core:water_source", "mcl_core:water_flowing"},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		stand_start = 100,
		stand_end = 200,
		walk_start = 200,
		walk_end = 300,
		fly_start = 400,
		fly_end = 500,
		punch_start = 300,
		punch_end = 400,
		die_start = 300,
		die_end = 400,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

	follow = {
		"ethereal:fish_raw", "animalworld:rawfish", "mobs_fish:tropical",
		"mobs:meat_raw", "animalworld:rabbit_raw", "xocean:fish_edible", "farming:melon_slice", "farming:melon_slice", "water_life:meat_raw", "water_life:meat_raw", "fishing:fish_raw", "animalworld:chicken_raw", "nativevillages:catfish_raw", "nativevillages:chicken_raw", "animalworld:whalemeat_raw", "mobs:meatblock_raw", "animalworld:chicken_raw", "livingfloatlands:ornithischiaraw", "livingfloatlands:largemammalraw", "livingfloatlands:theropodraw", "livingfloatlands:sauropodraw", "animalworld:raw_athropod", "animalworld:whalemeat_raw", "animalworld:rabbit_raw", "nativevillages:chicken_raw", "mobs:meat_raw", "animalworld:pork_raw", "people:mutton:raw", "animalworld:rawmollusk", "marinaramobs:octopus_raw", "marinara:raw_oisters", "marinara:raw_athropod", "animalworld:rawfish", "fishing:fish_raw", "fishing:pike_raw", "marinaramobs:raw_exotic_fish", "nativevillages:catfish_raw", "xocean:fish_edible", "ethereal:fish_raw", "mobs:clownfish_raw", "fishing:bluewhite_raw", "fishing:exoticfish_raw", "fishing:fish_raw", "fishing:carp_raw", "fishing:perch_raw", "water_life:meat_raw", "fishing:shark_raw", "mcl_mobitems:chicken", "mcl_fishing:pufferfish_raw", "mcl_mobitems:rotten_flesh", "mcl_mobitems:mutton", "mcl_mobitems:beef", "mcl_mobitems:porkchop", "mcl_mobitems:rabbit", "fishing:pike_raw"
	},
	view_range = 12,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 25, false, nil) then return end
	end,
})


if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:polarbear",
nodes = {"default:ice", "default:snowblock", "mcl_core:ice", "mcl_core:snow"},
	neighbors = {"default:water_source", "mcl_core:water_source", "mcl_core:water_flowing"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 1,
	min_height = -10,
	max_height = 10,
	day_toggle = true,

})
end

mobs:register_egg("animalworld:polarbear", S("Polar Bear"), "apolarbear.png")
