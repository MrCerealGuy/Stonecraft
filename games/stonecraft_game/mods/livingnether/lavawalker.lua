local S = minetest.get_translator("livingnether")

mobs:register_mob("livingnether:lavawalker", {
stepheight = 4,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 4,
        damage = 17,
	hp_min = 200,
	hp_max = 700,
	armor = 100,
	collisionbox = {-1.5, -0.01, -1.5, 1.5, 1.5, 1.5},
	visual = "mesh",
	mesh = "Lavawalker.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturelavawalker.png"},
	},
	sounds = {
		random = "livingnether_lavawalker",
		attack = "livingnether_lavawalker2",
		distance = 12,
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 3,
	runaway = false,
	jump = false,
        jump_height = 6,
	fear_height = 5,
        knock_back = false,
        stay_near = {{"nether:glowstone", "nether:fumarole", "nether:basalt"}, 5},
	drops = {
		{name = "default:steel_ingot", chance = 1, min = 1, max = 2},
	},
	water_damage = 4,
	lava_damage = 4,
	light_damage = 0,
	animation = {
		speed_normal = 100,
		stand_speed = 40,
		stand_start = 0,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		punch_speed = 150,
		punch_start = 200,
		punch_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	view_range = 8,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 25, false, nil) then return end
	end,
})

if not mobs.custom_spawn_livingnether then
mobs:spawn({
	name = "livingnether:lavawalker",
	nodes = {"nether:rack"},
	min_light = 0,
	interval = 60,
	active_object_count = 3,
	chance = 8000, -- 15000
	min_height = livingnether.MIN_HEIGHT,
	max_height = livingnether.MAX_HEIGHT,

})
end

mobs:register_egg("livingnether:lavawalker", S("Lavawalker"), "alavawalker.png")
