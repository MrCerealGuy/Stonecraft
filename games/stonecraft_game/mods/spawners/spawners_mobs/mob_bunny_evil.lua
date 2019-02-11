-- Evil Bunny by ExeterDad

local bunny_evil_def = {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	pathfinding = false,
	reach = 3,
	damage = 3,
	hp_min = 35,
	hp_max = 65,
	armor = 100,
	collisionbox = {-0.268, -0.5, -0.268,  0.268, 0.167, 0.268},
	visual = "mesh",
	mesh = "spawners_mobs_evil_bunny.b3d",
	rotate = 0,
	textures = {
		{"spawners_mobs_evil_bunny.png"},
	},
	sounds = {
		random = "spawners_mobs_bunny",
	},
	makes_footstep_sound = false,
	walk_velocity = 1.5,
	run_velocity = 4,
	view_range = 10,
	jump = true,
	floats = 1,
	drops = {
		{name = "mobs:meat_raw", chance = 5, min = 1, max = 1},
	},
	water_damage = 5,
	lava_damage = 10,
	light_damage = 10,
	fear_height = 3,
	animation = {
		speed_normal = 15,
		stand_start = 1,
		stand_end = 15,
		walk_start = 16,
		walk_end = 24,
		punch_start = 16,
		punch_end = 24,
	},
	-- follow = {"mobs:lava_orb"},
	-- on_rightclick = function(self, clicker)

	-- 	if mobs:feed_tame(self, clicker, 3, true, true) then
	-- 		return
	-- 	end

	-- 	mobs:capture_mob(self, clicker, 30, 50, 80, false, nil)
	-- end,
}

mobs:register_mob("spawners_mobs:bunny_evil", bunny_evil_def)

mobs:spawn({
	name = "spawners_mobs:bunny_evil",
	nodes = {"default:snowblock", "default:dirt_with_snow", "default:ice"},
	chance = 7000,
	min_light = 0,
	max_light = 14,
	active_object_count = 1,
	day_toggle = false,
})

mobs:register_egg("spawners_mobs:bunny_evil", "Evil Bunny", "spawners_mobs_evil_bunny_egg.png", 0)
