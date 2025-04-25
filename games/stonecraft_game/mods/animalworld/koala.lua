local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:koala", {
	stepheight = 1,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = true,
	reach = 2,
	damage = 1,
	hp_min = 5,
	hp_max = 30,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.2, 0.3},
	visual = "mesh",
	mesh = "Koala.b3d",
	textures = {
		{"texturekoala.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "animalworld_koala",
		attack = "animalworld_koala2",
		damage = "animalworld_koala2",
	},
	walk_velocity = 0.5,
	walk_chance = 25,
	run_velocity = 1,
	jump = false,
	jump_height = 8,
	stepheight = 8,
	pushable = true,
	follow = {"naturalbiomes:outback_leaves", "mcl_core:leaves"},
	view_range = 6,
        stay_near = {{"naturalbiomes:outback_leaves", "naturalbiomes:outback_trunk", "naturalbiomes:outback_bush_leaves", "mcl_trees:leaves_acacia",  "mcl_core:acacialeaves"}, 5},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 9,
	animation = {
		speed_normal = 50,
		stand_speed = 25,
		stand_start = 100,
		stand_end = 200,
		stand1_start = 200,
		stand1_end = 300,
		walk_start = 0,
		walk_end = 100,
		punch_speed = 100,
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

local spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_coniferous_litter"}

if minetest.get_mapgen_setting("mg_name") ~= "v6" then
	spawn_on = {"naturalbiomes:outback_litter"}
end

if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:mushroom_dirt", "ethereal:bamboo_dirt", "ethereal:green_dirt", "ethereal:mushroom_dirt", "default:dirt_with_coniferous_litter", "default:dirt_gray"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:koala",
	nodes = {"naturalbiomes:outback_litter", "mcl_core:dirt_with_grass"},
	neighbors = {"naturalbiomes:outback_trunk", "naturalbiomes:outback_bush_leaves", "naturalbiomes:outback_leaves", "mcl_trees:leaves_acacia",  "mcl_core:acacialeaves"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 3,
	min_height = 1,
	max_height = 500,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:koala", ("Koala"), "akoala.png")


mobs:alias_mob("animalworld:koala", "animalworld:koala") -- compatibility
