local S = minetest.get_translator("livingnether")

mobs:register_mob("livingnether:sokameele", {
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 2,
        damage = 13,
	hp_min = 80,
	hp_max = 125,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 1.5, 0.5},
	visual = "mesh",
	mesh = "Sokameele.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturesokameele.png"},
	},
	sounds = {
		attack = "livingnether_sokameele3",
		damage = "livingnether_sokameele",
		distance = 20,
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 4,
	runaway = false,
        stepheight = 2,
        fear_height = 3,
	jump = true,
        stay_near = {{"nether:glowstone", "nether:fumarole", "nether:basalt"}, 5},
	drops = {
		{name = "default:gold_lump", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	animation = {
		speed_normal = 100,
		stand_start = 0,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		punch_start = 200,
		punch_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	view_range = 15,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_livingnether then
mobs:spawn({
	name = "livingnether:sokameele",
	nodes = {"nether:rack_deep"},
	min_light = 0,
	interval = 60,
	active_object_count = 3,
	chance = 8000, -- 15000
	min_height = livingnether.MIN_HEIGHT,
	max_height = livingnether.MAX_HEIGHT,
})
end

mobs:register_egg("livingnether:sokameele", S("Soka Meele"), "asokameele.png")
