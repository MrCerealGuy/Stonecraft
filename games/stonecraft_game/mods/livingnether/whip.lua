local S = minetest.get_translator("livingnether")

mobs:register_mob("livingnether:whip", {
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = false,
        damage = 15,
	reach = 4,
	damage = 25,
	hp_min = 45,
	hp_max = 60,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 2, 0.4},
	visual = "mesh",
	mesh = "Whip.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturewhip.png"},
	},
	sounds = {
		attack = "livingnether_whip",
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
		speed_run = 50,
		stand_start = 0,
		stand_end = 100,
		run_start = 100,
		run_end = 200,
		walk_start = 0,
		walk_end = 100,
		speed_punch = 100,
		punch_start = 200,
		punch_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

view_range = 4,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_livingnether then
mobs:spawn({
	name = "livingnether:whip",
	nodes = {"nether:rack_deep"},
	min_light = 0,
	interval = 60,
	active_object_count = 5,
	chance = 8000, -- 15000
	min_height = livingnether.MIN_HEIGHT,
	max_height = livingnether.MAX_HEIGHT,
})
end

mobs:register_egg("livingnether:whip", S("Flesh Whip"), "awhip.png")
