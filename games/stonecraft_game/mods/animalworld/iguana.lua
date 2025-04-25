local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:iguana", {
	stepheight = 2,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = true,
	reach = 2,
	damage = 2,
	hp_min = 15,
	hp_max = 25,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	mesh = "Iguana.b3d",
	textures = {
		{"textureiguana.png"},
		{"textureiguana2.png"},
		{"textureiguana3.png"},
		{"textureiguana4.png"},
		{"textureiguana5.png"},
	},
	makes_footstep_sound = true,
	sounds = {
	},
	walk_velocity = 1,
	run_velocity = 2,
	jump = false,
	pushable = true,
	follow = {"ethereal:banana_single", "mcl_farming:beetroot_item", "mcl_farming:carrot_item", "mcl_farming:melon_item", "mcl_farming:potato_item", "mcl_farming:pumpkin_item", "mcl_farming:wheat_item", "mcl_farming:sweet_berry", "farming:corn_cob", "farming:cabbage",
		"default:apple", "farming:cabbage", "farming:carrot", "farming:cucumber", "farming:grapes", "farming:pineapple", "ethereal:orange", "ethereal:coconut", "ethereal:coconut_slice", "livingdesert:date_palm_fruits", "livingdesert:figcactus_fruit", "farming:melon_8", "farming:pumpkin_8", "ethereal:strawberry", "farming:blackberry", "naturalbiomes:blackberry", "naturalbiomes:cowberry", "naturalbiomes:banana", "naturalbiomes:banana_bunch", "farming:blueberries", "ethereal:orange", "livingdesert:figcactus_fruit", "livingfloatlands:paleojungle_clubmoss_fruit", "ethereal:banana", "livingdesert:date_palm_fruits", "farming:melon_slice", "naturalbiomes:wildrose", "naturalbiomes:banana"},
	view_range = 10,
	replace_rate = 10,
	replace_what = {"farming:soil", "farming:soil_wet"},
	replace_with = "default:dirt",
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	        {name = "mobs:leather", chance = 1, min = 0, max = 2},
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "mcl_core:water_source", "mcl_core:water_flowing"},
	floats = 0,
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3,
        stay_near = {{"default:jungletree", "mcl_core:jungletree", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "mcl_trees:leaves_mangrove", "default:junglegrass", "naturalbiomes:bambooforest_groundgrass", "livingjungle:grass2", "livingjungle::grass1", "livingjungle:alocasia", "livingjungle:flamingoflower"}, 5},
	animation = {
		speed_normal = 80,
		stand_speed = 30,
		stand1_speed = 30,
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		walk_start = 220,
		walk_end = 320,
		punch_start = 320,
		punch_end = 420,
		fly_start = 440,
		fly_end = 540,
		die_start = 300,
		die_end = 400,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 15, 25, 0, false, nil) then return end
	end,
})

local spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_coniferous_litter"}

if minetest.get_mapgen_setting("mg_name") ~= "v6" then
	spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_dry_grass", "default:dirt_with_coniferous_litter"}
end

if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:mushroom_dirt", "ethereal:bamboo_dirt", "ethereal:green_dirt", "ethereal:mushroom_dirt", "default:dirt_with_coniferous_litter", "default:dirt_gray"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:iguana",
	nodes = {"livingjungle:jungleground", "livingjungle:leafyjungleground", "mcl_core:dirt_with_gras"},
	neighbors = {"default:jungletree", "livingjungle:alocasia", "livingjungle:flamingoflower", "livingjungle:samauma_trunk", "mcl_core:jungletree", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "mcl_trees:leaves_mangrove"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 1,
	max_height = 31000,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:iguana", S("Iguana"), "aiguana.png")


mobs:alias_mob("animalworld:iguana", "animalworld:iguana") -- compatibility


