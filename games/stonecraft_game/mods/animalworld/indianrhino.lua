local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:indianrhino", {
	type = "animal",
	passive = false,
        attack_type = "dogfight",
	attack_animals = false,
	attack_monsters = true,
	group_attack = true,
	reach = 3,
        damage = 14,
	hp_min = 90,
	hp_max = 140,
	armor = 100,
	collisionbox = {-0.8, -0.01, -0.8, 0.8, 1.5, 0.8},
	visual = "mesh",
	mesh = "Indianrhino.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"textureindianrhino.png"},
	},
	sounds = {
		random = "animalworld_rhino",
		attack = "animalworld_rhino2",
                distance = 13,
	},
	makes_footstep_sound = true,
	walk_velocity = 1.5,
	run_velocity = 3,
        walk_chance = 20,
	runaway = false,
        knock_back = false,
	jump = true,
        jump_height = 6,
	stepheight = 2,
        stay_near = {{"naturalbiomes:savanna_flowergrass", "naturalbiomes:savanna_grass", "naturalbiomes:savanna_grass2", "naturalbiomes:savanna_grass3", "naturalbiomes:savannagrass"}, 6},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	        {name = "mobs:leather", chance = 1, min = 0, max = 2},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 3,
        pathfinding = true,
	animation = {
		speed_normal = 70,
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		walk_start = 200,
		walk_end = 300,
		punch_start = 300,
		punch_end = 400,
		die_start = 300,
		die_end = 400,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

	follow = {"default:apple", "mcl_flowers:tallgrass", "mcl_core:deadbush", "mcl_bamboo:bamboo", "default:dry_dirt_with_dry_grass", "farming:seed_wheat", "default:junglegrass", "farming:seed_oat", "naturalbiomes:savannagrass", "naturalbiomes:savannagrassmall", "naturalbiomes:savanna_flowergrass", "default:dry_grass_1", "default:dry_grass_2", "default:dry_grass_3", "default:grass_1", "default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5", "default:marram_grass_1", "default:marram_grass_2", "default:marram_grass_3", "default:coldsteppe_grass_1", "default:coldsteppe_grass_2", "default:coldsteppe_grass_3", "default:coldsteppe_grass_4", "default:coldsteppe_grass_5", "default:coldsteppe_grass_6", "naturalbiomes:savanna_grass1", "naturalbiomes:savanna_grass2", "naturalbiomes:savanna_grass3", "naturalbiomes:outback_grass1", "naturalbiomes:outback_grass2", "naturalbiomes:outback_grass3", "naturalbiomes:outback_grass4", "naturalbiomes:outback_grass5", "naturalbiomes:outback_grass6", "naturalbiomes:med_grass1", "naturalbiomes:med_grass2", "naturalbiomes:heath_grass1", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:alpine_grass1", "naturalbiomes:alpine_grass2", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:", "naturalbiomes:", "naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4", "naturalbiomes:bushland_grass5", "naturalbiomes:bushland_grass6", "naturalbiomes:bushland_grass7", "group:grass", "group:normal_grass"},
	view_range = 10,
	replace_rate = 10,
	replace_what = {"farming:soil", "farming:soil_wet"},
	replace_with = "default:dirt",
	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 25, false, nil) then return end
	end,
})


if minetest.get_modpath("ethereal") then
	spawn_on = {"mcl_core:podzol", "default:dirt_withforest_litter", "ethereal:green_dirt", "ethereal:grass_grove"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:indianrhino",
	nodes = {"naturalbiomes:savannalitter", "mcl_core:dirt_with_grass"},
	neighbors = {"naturalbiomes:savanna_grass1", "naturalbiomes:savanna_grass2", "naturalbiomes:savanna_grass3", "mcl_core:acaciatree", "mcl_trees:tree_acacia", "mcl_trees:leaves_acacia", "mcl_core:acacialeaves"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 5,
	max_height = 50,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:indianrhino", S("Indian Rhino"), "aindianrhino.png")