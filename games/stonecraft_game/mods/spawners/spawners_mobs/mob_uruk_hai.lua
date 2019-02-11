-- uruk_hai

local uruk_hai_def = {
	type = "monster",
	docile_by_day = true,
	passive = false,
	hp_min = 40,
	hp_max = 65,
	pathfinding = false,
	attack_type = "dogfight",
	group_attack = true,
	reach = 3,
	damage = 6,
	armor = 100,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "spawners_mobs_character.b3d",
	drawtype = "front",
	textures = {
		{"spawners_mobs_uruk_hai.png", "spawners_mobs_trans.png","spawners_mobs_galvornsword.png", "spawners_mobs_trans.png"},
		{"spawners_mobs_uruk_hai_1.png", "spawners_mobs_trans.png","spawners_mobs_galvornsword.png", "spawners_mobs_trans.png"},
		{"spawners_mobs_uruk_hai_2.png", "spawners_mobs_trans.png","spawners_mobs_galvornsword.png", "spawners_mobs_trans.png"},
		{"spawners_mobs_uruk_hai_3.png", "spawners_mobs_trans.png","spawners_mobs_galvornsword.png", "spawners_mobs_trans.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "spawners_mobs_uruk_hai_neutral",
		death = "spawners_mobs_uruk_hai_death",
		attack = "spawners_mobs_uruk_hai_attack",
		damage = "spawners_mobs_uruk_hai_hit",
		distance = 15
	},
	walk_velocity = 2,
	run_velocity = 4,
	view_range = 10,
	jump = true,
	floats = 1,
	drops = {
		{name = "default:apple", chance = 3, min = 1, max = 2},
		{name = "default:wood", chance = 4, min = 1, max = 2},
		{name = "default:stick", chance = 2, min = 1, max = 2},
		{name = "default:torch", chance = 3, min = 1, max = 2},
		{name = "default:sword_bronze", chance = 5, min = 1, max = 1},
		{name = "default:sword_mese", chance = 6, min = 1, max = 1},
		{name = "obsidianmese:sword_engraved", chance = 20, min = 1, max = 1},
		{name = "bones:bones", chance = 5, min = 1, max = 1},
		{name = "spawners_mobs:uruk_hai", chance = 20, min = 1, max = 1},
	},
	water_damage = 5,
	lava_damage = 10,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
}

mobs:register_mob("spawners_mobs:uruk_hai", uruk_hai_def)

-- mobs:spawn({
-- 	name = "spawners_mobs:uruk_hai",
-- 	nodes = {"default:desert_sand", "default:desert_stone", "default:sand", "default:sandstone", "default:silver_sand"},
-- 	min_light = 0,
-- 	max_light = 20,
-- 	chance = 2000,
-- 	active_object_count = 2,
-- 	day_toggle = false,
-- })

mobs:register_egg("spawners_mobs:uruk_hai", "uruk_hai", "spawners_mobs_uruk_hai_egg.png", 0, true)
