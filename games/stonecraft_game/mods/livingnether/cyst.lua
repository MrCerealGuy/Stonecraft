local S = minetest.get_translator("livingnether")

mobs:register_mob("livingnether:cyst", {
	type = "monster",
	passive = false,
	attack_type = "explode",
	explosion_radius = 2,
	explosion_damage__radius = 6,
	explosion_timer = 2,
	reach = 3,
	damage = 25,
	hp_min = 45,
	hp_max = 60,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "Cyst.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturecyst.png"},
	},
	sounds = {
		damage = "livingnether_cyst",
		fuse = "livingnether_cyst2",
		distance = 16,
	},
	makes_footstep_sound = false,
	walk_velocity = 0,
	run_velocity = 0,
	jump = false,
        jump_height = 6,
	fly = false,
	stepheight = 1,
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 0,
	animation = {
		speed_normal = 50,
		speed_run = 10,
		stand_start = 0,
		stand_end = 100,
		run_start = 100,
		run_end = 200,
		walk_start = 0,
		walk_end = 100,
		hurt_start = 100,
		hurt_end = 200,
		die_start = 0,
		die_end = 100,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

view_range = 6,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_livingnether then
mobs:spawn({
	name = "livingnether:cyst",
	nodes = {"nether:sand", "nether:basalt"},
	min_light = 0,
	interval = 60,
	active_object_count = 5,
	chance = 8000, -- 15000
	min_height = livingnether.MIN_HEIGHT,
	max_height = livingnether.MAX_HEIGHT,
})
end

mobs:register_egg("livingnether:cyst", S("Cyst"), "acyst.png")
