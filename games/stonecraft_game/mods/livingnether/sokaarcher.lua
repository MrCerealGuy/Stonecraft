local S = minetest.get_translator("livingnether")

mobs:register_mob("livingnether:sokaarcher", {
	-- animal, monster, npc
	type = "monster",
	-- aggressive, shoots shuriken
	passive = false,
	damage = 13,
	attack_type = "shoot",
	shoot_interval = 2,
	arrow = "livingnether:sarrow",
	shoot_offset = 2,
	attacks_monsters = false,
	-- health & armor
	hp_min = 50, hp_max = 100, armor = 100,
	-- textures and model
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "Sokaarcher.b3d",
	drawtype = "front",
	textures = {
		{"texturesokaarcher.png"},
	},
	visual_size = {x=1, y=1},
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		shoot_attack = "livingnether_sokaarcher",
		damage = "livingnether_sokaarcher2",
		distance = 20,
},
	-- speed and jump
	walk_velocity = 2,
	run_velocity = 3,
        stepheight = 2,
        fear_height = 3,
	jump = true,
	drops = {
		{name = "default:gold_lump",
		chance = 1, min = 1, max = 1},
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fall_damage = 0,
	view_range = 15,
        stay_near = {{"nether:glowstone", "nether:fumarole", "nether:basalt"}, 5},
	-- model animation
	animation = {
		speed_normal = 70,		speed_run = 100,
		stand_start = 0,		stand_end = 100,
		walk_start = 100,		walk_end = 200,
		run_start = 100,		run_end = 200,
		shoot_start = 200,		shoot_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
})

if not mobs.custom_spawn_livingnether then
mobs:spawn({
	name = "livingnether:sokaarcher",
	nodes = {"nether:rack_deep"},
	min_light = 0,
	interval = 60,
	active_object_count = 3,
	chance = 8000, -- 15000
	min_height = livingnether.MIN_HEIGHT,
	max_height = livingnether.MAX_HEIGHT,
})
end

mobs:register_egg("livingnether:sokaarcher", S"Soka Archer", "asokaarcher.png")

mobs:register_arrow("livingnether:sarrow", {
	visual = "sprite",
	visual_size = {x=.5, y=.5},
	textures = {"sarrow.png"},
	velocity = 12,
	drop = true,

	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
		full_punch_interval=1.0,
		damage_groups = {fleshy=13},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
		full_punch_interval=1.0,
		damage_groups = {fleshy=13},
		}, nil)
	end,

	hit_node = function(self, pos, node)
	end,
})
