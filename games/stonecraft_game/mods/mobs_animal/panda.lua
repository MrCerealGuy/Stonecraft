
local S = minetest.get_translator("mobs_animal")

-- Panda by AspireMint (CC BY-SA 3.0)

mobs:register_mob("mobs_animal:panda", {
	stepheight = 0.6,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = false,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 3,
	hp_min = 10,
	hp_max = 24,
	armor = 100,
	collisionbox = {-0.4, -0.45, -0.4, 0.4, 0.45, 0.4},
	visual = "mesh",
	mesh = "mobs_panda.b3d",
	textures = {{"mobs_panda.png"}},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_panda",
		attack = "mobs_panda"
	},
	walk_chance = 5,
	walk_velocity = 0.5,
	run_velocity = 1.5,
	jump = false,
	jump_height = 6,
	follow = {"ethereal:bamboo", "bamboo:trunk"},
	view_range = 8,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 2}
	},
	water_damage = 0.01,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 6,
	animation = {
		speed_normal = 15,
		stand_start = 130, stand_end = 270,
		stand1_start = 0, stand1_end = 0, -- rest
		stand2_start = 1, stand2_end = 1, -- covers eyes
		stand3_start = 2, stand3_end = 2, -- surprised
		walk_start = 10, walk_end = 70,
		run_start = 10, run_end = 70,
		punch_start = 80, punch_end = 120
	},

	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 20, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 5, 50, false, nil) then return end
	end
})

-- where to spawn (ethereal bamboo biome only)

if minetest.get_modpath("ethereal") and not mobs.custom_spawn_animal then

	mobs:spawn({
		name = "mobs_animal:panda",
		nodes = {"ethereal:bamboo_dirt"},
		neighbors = {"group:grass"},
		min_light = 14,
		interval = 60,
		chance = 8000,
		min_height = 10,
		max_height = 80,
		day_toggle = true
	})
end

-- spawn egg

mobs:register_egg("mobs_animal:panda", S("Panda"), "mobs_panda_inv.png")
