local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:divingbeetle", {
	stepheight = 1,
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	attack_npcs = true,
	reach = 2,
	damage = 1,
	hp_min = 5,
	hp_max = 25,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.3, 0.3},
	visual = "mesh",
	mesh = "Divingbeetle.b3d",
	textures = {
		{"texturedivingbeetle.png"},
	},
	makes_footstep_sound = false,
	sounds = {
	},
	walk_velocity = 1,
	run_velocity = 2,
	runaway = false,
	jump = false,
	jump_height = 3,
	pushable = true,
	view_range = 6,
	drops = {
		{name = "animalworld:fishfood", chance = 1, min = 0, max = 2},
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "mcl_core:water_source", "mcl_core:water_flowing"},
	floats = 0,
	fly = true,
	follow = {
	},
	water_damage = 0,
	lava_damage = 5,
        air_damage = 1,
	light_damage = 0,
	fear_height = 2,
        stay_near = {{"marinara:sand_with_alage", "mcl_flowers:waterlily", "mcl_ocean:seagrass:sand", "mcl_core:reeds", "marinara:sand_with_seagrass", "default:sand_with_kelp", "marinara:sand_with_kelp", "marinara:reed_root", "flowers:waterlily_waving", "naturalbiomes:waterlily", "default:clay"}, 4},
	animation = {
		speed_normal = 100,
                stand_speed = 50,
		stand_start = 100,
		stand_end = 300,
		walk_start = 0,
		walk_end = 100,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 5, 25, 0, false, nil) then return end
	end,
})


if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:divingbeetle",
	nodes = {"mcl_core:water_source", "default:water_source", "default:river_water_source", "mcl_core:water_source", "mcl_core:water_flowing"},
	neighbors = {"default:papyrus", "mcl_core:reeds"},
	min_light = 0,
	interval = 30,
	active_object_count = 2,
	chance = 500, -- 15000
	min_height = -10,
	max_height = 30,
})
end

mobs:register_egg("animalworld:divingbeetle", S("Diving Beetle"), "adivingbeetle.png")


mobs:alias_mob("animalworld:divingbeetle", "animalworld:divingbeetle") -- compatibility

