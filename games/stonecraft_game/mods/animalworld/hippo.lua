local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:hippo", {
stepheight = 2,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 3,
        damage = 12,
	hp_min = 65,
	hp_max = 100,
	armor = 100,
	collisionbox = {-0.8, -0.01, -0.8, 0.8, 1.2, 0.8},
	visual = "mesh",
	mesh = "HippoNEW.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturehippoNEW.png"},
	},
	sounds = {
		random = "animalworld_hippo",
		attack = "animalworld_hippo",
	},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2,
	runaway = false,
	jump = true,
        jump_height = 0.5,
	stepheight = 2,
        knock_back = false,
        stay_near = {{"default:dry_grass_1", "default:dry_grass_2", "default:dry_grass_3", "default:dry_grass_4", "mcl_core:dirt_with_grass", "mcl_core:acaciatree", "mcl_trees:tree_acacia"}, 6},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
		{name = "animalworld:hippocorpse", chance = 7, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		stand_start = 100,
		stand_end = 200,
		walk_start = 300,
		walk_end = 400,
		fly_start = 300, -- swim animation
		fly_end = 4000,
                punch_speed = 100,
		punch_start = 200,
		punch_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "mcl_core:water_source", "mcl_core:water_flowing"},
	floats = 0,
	follow = {
		"ethereal:banana_single", "mcl_farming:beetroot_item", "mcl_farming:carrot_item", "mcl_farming:melon_item", "mcl_farming:potato_item", "mcl_farming:pumpkin_item", "mcl_farming:wheat_item", "mcl_farming:sweet_berry", "farming:corn_cob", "farming:cabbage",
		"default:apple", "water_life:meat_raw", "xocean:fish_edible", "ethereal:fish_raw", "ethereal:banana", "farming:cabbage", "farming:lettuce", "farming:melon_slice", "group:grass", "group:normal_grass"
	},
	
view_range = 6,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 25, false, nil) then return end
	end,
})

if minetest.get_modpath("ethereal") then
	spawn_on = {"default:dry_dirt_with_dry_grass"}, {"default:dirt_with_rainforest_litter"}, {"ethereal:grove_dirt"}, {"ethereal:prairie_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:hippo",
	nodes = {"default:dry_dirt_with_dry_grass", "mcl_core:dirt_with_grass"},
	neighbors = {"group:grass", "group:normal_grass", "mcl_trees:leaves_acacia", "mcl_core:acacialeaves", "mcl_core:acaciatree", "mcl_trees:tree_acacia"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 0,
	max_height = 5,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:hippo", S("Hippo"), "ahippo.png")
