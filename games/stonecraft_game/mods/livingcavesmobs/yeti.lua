local S = minetest.get_translator("livingcavesmobs")

mobs:register_mob("livingcavesmobs:yeti", {
	stepheight = 3,
	type = "animal",
	passive = false,
	attack_type = "dogshoot",
	dogshoot_switch = 1,
	dogshoot_count_max = 3, -- shoot for 10 seconds
	dogshoot_count2_max = 5, -- dogfight for 3 seconds
	shoot_interval = 1,
	arrow = "livingcavesmobs:iceball",
	shoot_offset = 0.8,
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	attack_monsters = true,
	reach = 2,
	damage = 6,
	hp_min = 65,
	hp_max = 95,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.5, 0.4},
	visual = "mesh",
	mesh = "Yeti.b3d",
	visual_size = {x = 3.0, y = 3.0},
	textures = {
		{"textureyeti.png"},
		{"textureyeti2.png"},
	},
	child_texture = {
		{"textureyetibaby.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "livingcavesmobs_yeti2",
		attack = "livingcavesmobs_yeti3",
                damage = "livingcavesmobs_yeti",

	},
	walk_velocity = 2,
	run_velocity = 3,
        knock_back = false,
	jump = true,
	jump_height = 2,
	pushable = true,
	follow = {"default:apple", "farming:potato", "ethereal:banana_bread", "farming:carrot", "farming:seed_rice", "farming:corn", "farming:wheat", "farming:beans", "farming:barley", "farming:oat", "farming:rye", "mobs:cheese", "farming:bread", "ethereal:banana_bread", "ethereal:banana", "farming:cabbage", "farming:lettuce", "farming:melon_slice", "livingcavesmobs:termitequeen", "livingcavesmobs:locust_roasted", "livingdesert:date_palm_fruits", "livingdesert:figcactus_fruit"},
	view_range = 10,
	replace_rate = 10,
	replace_what = {"livingcaves:icestalagmite", "livingcaves:icestalagmiteend", "livingcaves:icestalagtite", "livingcaves:icestalagtiteend", "livingcaves:icestalagmitelarge", "livingcaves:icestalagmitelargeend", "livingcaves:icestalagtitelarge", "livingcaves:icestalagtitelargeend"},
	replace_with = "air",
	drops = {
		{name = "wool:white", chance = 1, min = 1, max = 3},
		{name = "wool:grey", chance = 1, min = 1, max = 3},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 4,
	animation = {
		speed_normal = 100,
		stand_speed = 75,
		stand_start = 0,
		stand_end = 100,
		stand2_start = 100,
		stand2_end = 200,
		stand3_start = 200,
		stand3_end = 300,
		walk_start = 300,
		walk_end = 400,
		punch_start = 400,
		punch_end = 500,
                shoot_start = 400,
		shoot_end = 500,
		die_start = 400,
		die_end = 500,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})


if not mobs.custom_spawn_livingcavesmobs then
mobs:spawn({
	name = "livingcavesmobs:yeti",
	nodes = {"livingcaves:icecave_ice"},
	min_light = 0,
	interval = 60,
	chance = 2, -- 15000
	active_object_count = 1,
	min_height = -30,
	max_height = -5,
})
end

mobs:register_egg("livingcavesmobs:yeti", ("Yeti"), "ayeti.png")

mobs:register_arrow("livingcavesmobs:iceball", {
	visual = "sprite",
	visual_size = {x=.5, y=.5},
	textures = {"livingcavesmobs_iceball.png"},
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


