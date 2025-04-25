local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:echidna", {
	stepheight = 1,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = true,
	reach = 3,
	damage = 15,
	hp_min = 25,
	hp_max = 65,
	armor = 100,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.95, 0.2},
	visual = "mesh",
	mesh = "Echidna.b3d",
	textures = {
		{"textureechidna.png"},
	},
child_texture = {
		{"textureechidnababy.png"},
	},
	makes_footstep_sound = true,
	sounds = {

	},
	walk_velocity = 0.5,
	run_velocity = 0.5,
	runaway = false,
	jump = false,
	jump_height = 3,
	pushable = true,
        stay_near = {{"animalworld:termitemould", "naturalbiomes:outback_grass", "naturalbiomes:outback_grass3", "naturalbiomes:outback_grass2", "naturalbiomes:outback_grass4", "naturalbiomes:outback_grass5", "livingdesert:cactus", "livingdesert:cactus3", "livingdesert:cactus2", "livingdesert:cactus4"}, 6},
	follow = {"fishing:bait:worm", "bees:frame_full", "ethereal:worm", "animalworld:ant", "animalworld:termite"},
	view_range = 3,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	        {name = "mobs:leather", chance = 1, min = 0, max = 2},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 2,
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
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 15, 25, 0, false, nil) then return end
	end,
})

local spawn_on = {"mcl_core:podzol", "default:dirt_withforest_litter"}

if minetest.get_mapgen_setting("mg_name") ~= "v6" then
	spawn_on = {"mcl_core:podzol", "default:dirt_withforest_litter", "default:dry_dirt_with_dry_grass"}
end

if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:grass_grove", "ethereal:green_dirt", "default:dirt_with_rainforest_litter"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:echidna",
	nodes = {"naturalbiomes:outback_litter", "mcl_core:sand", "mcl_core:redsand"},
	neighbors = {"group:grass", "mcl_core:deadbush", "mcl_core:cactus", "group:normal_grass", "naturalbiomes:outback_grass", "naturalbiomes:outback_grass3", "naturalbiomes:outback_grass2", "naturalbiomes:outback_grass4", "naturalbiomes:outback_grass5"}, 
	min_light = 0,
	interval = 30,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 5,
	max_height = 50,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:echidna", S("Echidna"), "aechidna.png")


mobs:alias_mob("animalworld:echidna", "animalworld:echidna") -- compatibility

