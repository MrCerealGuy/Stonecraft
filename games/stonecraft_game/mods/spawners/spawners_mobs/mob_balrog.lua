-- modified Sand Monster by PilzAdam with Mummy by BlockMen

local balrog_def = {
	type = "monster",
	passive = false,
	rotate = 180,
	hp_min = 1000,
	hp_max = 1250,
	pathfinding = false,
	attack_type = "dogshoot",
	shoot_interval = 0.6,
	dogshoot_switch = 1,
	dogshoot_count_max = 10,
	shoot_offset = 1,
	arrow = "spawners_mobs:balrog_firebolt",
	reach = 5,
	damage = 10,
	armor = 100,
	collisionbox = {-0.8, -2.1, -0.8, 0.8, 2.6, 0.8},
	visual_size = {x=2, y=2},
	visual = "mesh",
	mesh = "spawners_mobs_balrog.b3d",
	drawtype = "front",
	textures = {
		{"spawners_mobs_balrog.png"},
	},
	blood_texture = "fire_basic_flame.png",
	makes_footstep_sound = true,
	sounds = {
		death = "spawners_mobs_howl",
		attack = "spawners_mobs_stone_death",
		shoot_attack = "spawners_mobs_fireball",
	},
	walk_velocity = 3,
	run_velocity = 4,
	view_range = 20,
	jump = true,
	floats = 1,
	drops = {
		{name = "default:diamondblock", chance = 2, min = 1, max = 8},
		{name = "default:diamondblock", chance = 2, min = 1, max = 8},
		{name = "default:diamondblock", chance = 2, min = 1, max = 4},
		{name = "default:diamondblock", chance = 2, min = 1, max = 4},
		{name = "default:diamondblock", chance = 2, min = 1, max = 4},
		{name = "default:diamond", chance = 2, min = 1, max = 8},
		{name = "default:diamond", chance = 2, min = 1, max = 8},
		{name = "default:diamond", chance = 2, min = 1, max = 4},
		{name = "default:diamond", chance = 2, min = 1, max = 4},
		{name = "default:diamond", chance = 2, min = 1, max = 4},
		{name = "default:mese", chance = 2, min = 1, max = 4},
		{name = "default:mese_crystal", chance = 2, min = 1, max = 4},
		{name = "default:mese", chance = 2, min = 1, max = 4},
		{name = "default:mese_crystal", chance = 2, min = 1, max = 4},
		{name = "default:mese", chance = 2, min = 1, max = 4},
		{name = "default:mese_crystal", chance = 2, min = 1, max = 4},
		{name = "default:mese", chance = 2, min = 1, max = 4},
		{name = "default:mese_crystal", chance = 2, min = 1, max = 4},
		{name = "default:mese", chance = 2, min = 1, max = 4},
		{name = "default:mese_crystal", chance = 2, min = 1, max = 4},
		{name = "3d_armor:boots_diamond", chance = 2, min = 1, max = 4},
		{name = "3d_armor:chestplate_diamond", chance = 2, min = 1, max = 1},
		{name = "3d_armor:helmet_diamond", chance = 2, min = 1, max = 1},
		{name = "3d_armor:leggings_diamond", chance = 2, min = 1, max = 1},
		{name = "3d_armor:chestplate_bronze", chance = 2, min = 1, max = 1},
		{name = "3d_armor:helmet_bronze", chance = 2, min = 1, max = 1},
		{name = "3d_armor:leggings_bronze", chance = 2, min = 1, max = 1},
		{name = "3d_armor:chestplate_gold", chance = 2, min = 1, max = 1},
		{name = "3d_armor:helmet_gold", chance = 2, min = 1, max = 1},
		{name = "3d_armor:leggings_gold", chance = 2, min = 1, max = 1},
		{name = "obsidianmese:pick", chance = 2, min = 1, max = 1},
		{name = "obsidianmese:sword", chance = 2, min = 1, max = 1},
		{name = "default:pick_diamond", chance = 2, min = 1, max = 1},
		{name = "default:sword_diamond", chance = 2, min = 1, max = 1},
		{name = "default:shovel_diamond", chance = 2, min = 1, max = 1},
		{name = "default:axe_diamond", chance = 2, min = 1, max = 1},
		{name = "default:hoe_diamond", chance = 2, min = 1, max = 1},
		{name = "default:pick_mese", chance = 2, min = 1, max = 1},
		{name = "default:sword_mese", chance = 2, min = 1, max = 1},
		{name = "default:shovel_mese", chance = 2, min = 1, max = 1},
		{name = "default:axe_mese", chance = 2, min = 1, max = 1},
		{name = "default:hoe_mese", chance = 2, min = 1, max = 1},
		{name = "default:pick_bronze", chance = 2, min = 1, max = 1},
		{name = "default:sword_bronze", chance = 2, min = 1, max = 1},
		{name = "default:shovel_bronze", chance = 2, min = 1, max = 1},
		{name = "default:axe_bronze", chance = 2, min = 1, max = 1},
		{name = "default:hoe_bronze", chance = 2, min = 1, max = 1},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "obsidianmese:mese_apple", chance = 2, min = 1, max = 3},
		{name = "obsidianmese:mese_apple", chance = 2, min = 1, max = 3},
		{name = "obsidianmese:mese_apple", chance = 2, min = 1, max = 3},
		{name = "obsidianmese:mese_apple", chance = 2, min = 1, max = 3},
		{name = "obsidianmese:mese_apple", chance = 2, min = 1, max = 3},
	},
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
	fear_height = 3,
	animation = {
		stand_start = 0,
		stand_end = 240,
		walk_start = 240,
		walk_end = 300,
		punch_start = 300,
		punch_end = 380,
		speed_normal = 15,
		speed_run = 15,
	},
}

mobs:register_mob("spawners_mobs:balrog", balrog_def)

-- mobs:spawn({
-- 	name = "spawners_mobs:balrog",
-- 	nodes = {"default:desert_sand", "default:desert_stone", "default:sand", "default:sandstone", "default:silver_sand"},
-- 	min_light = 0,
-- 	max_light = 20,
-- 	chance = 2000,
-- 	active_object_count = 2,
-- 	day_toggle = false,
-- })

mobs:register_egg("spawners_mobs:balrog", "balrog", "default_coal_block.png", 1, true)

-- shooting
mobs:register_arrow("spawners_mobs:balrog_firebolt", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"spawners_mobs_firebolt.png"},
	velocity = 15,
	-- tail = 1,
	-- tail_texture = "spawners_mobs_black_skull.png",
	-- tail_size = 10,

	-- direct hit, no fire... just plenty of pain
	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},
		}, nil)
	end,

	hit_node = function(self, pos, node)
		-- minetest.set_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="default:lava_flowing"})
	end
})
