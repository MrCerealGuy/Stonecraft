
local S = minetest.get_translator("mobs_animal")

-- Warthog originally by KrupnoPavel, B3D model by sirrobzeroone

mobs:register_mob("mobs_animal:pumba", {
	stepheight = 0.6,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 2,
	hp_min = 10,
	hp_max = 15,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 0.95, 0.4},
	visual = "mesh",
	mesh = "mobs_pumba.b3d",
	textures = {{"mobs_pumba.png"}},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_pig",
		attack = "mobs_pig_angry"
	},
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	jump_height = 6,
	pushable = true,
	follow = {"default:apple", "farming:potato"},
	view_range = 10,
	drops = {
		{name = "mobs:pork_raw", chance = 1, min = 1, max = 3}
	},
	water_damage = 0.01,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 15,
		stand_start = 25, stand_end = 55,
		walk_start = 70, walk_end = 100,
		punch_start = 70, punch_end = 100,
		-- no specific dying animation, so use 2 frames at 1fps and rotate
		die_start = 1, die_end = 2, die_speed = 1,
		die_loop = false, die_rotate = true
	},

	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 5, 50, false, nil) then return end
	end
})

-- where to spawn

if not mobs.custom_spawn_animal then

	local spawn_on = {"default:dirt_with_grass", "default:dry_dirt_with_dry_grass"}
	local spawn_by = {"group:grass"}

	if minetest.get_modpath("ethereal") then
		spawn_on = {"ethereal:mushroom_dirt"}
		spawn_by = {"flowers:mushroom_brown", "flowers:mushroom_red"}
	end

	mobs:spawn({
		name = "mobs_animal:pumba",
		nodes = spawn_on,
		neighbors = spawn_by,
		min_light = 14,
		interval = 60,
		chance = 8000,
		min_height = 0,
		max_height = 200,
		day_toggle = true
	})
end

-- spawn egg

mobs:register_egg("mobs_animal:pumba", S("Warthog"), "mobs_pumba_inv.png")

-- old mobs mod compatibility

mobs:alias_mob("mobs:pumba", "mobs_animal:pumba")

-- raw porkchop

minetest.register_craftitem(":mobs:pork_raw", {
	description = S("Raw Porkchop"),
	inventory_image = "mobs_pork_raw.png",
	on_use = minetest.item_eat(4),
	groups = {food_meat_raw = 1, food_pork_raw = 1}
})

mobs.add_eatable("mobs:pork_raw", 4)

-- cooked porkchop and recipe

minetest.register_craftitem(":mobs:pork_cooked", {
	description = S("Cooked Porkchop"),
	inventory_image = "mobs_pork_cooked.png",
	on_use = minetest.item_eat(8),
	groups = {food_meat = 1, food_pork = 1}
})

mobs.add_eatable("mobs:pork_cooked", 8)

minetest.register_craft({
	type = "cooking",
	output = "mobs:pork_cooked",
	recipe = "mobs:pork_raw",
	cooktime = 5
})
