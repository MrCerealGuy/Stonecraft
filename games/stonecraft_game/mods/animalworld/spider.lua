local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:spider", {
stepheight = 4,
	type = "monster",
	passive = false,
	attack_type = "shoot",
	shoot_interval = 0.5,
	arrow = "animalworld:silk_arrow",
	shoot_offset = 2,
	attack_animals = true,
	reach = 6,
        damage = 6,
	hp_min = 10,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 0.4, 0.4},
	visual = "mesh",
	mesh = "Spider.b3d",
	visual_size = {x = 0.3, y = 0.3},
	textures = {
		{"texturespider.png"},
	},
	sounds = {
		random = "animalworld_spider",
		attack = "animalworld_spider",
	},
	makes_footstep_sound = true,
	view_range = 6,
	walk_velocity = 1,
	run_velocity = 3,
	runaway = false,
	jump = true,
        jump_height = 0,
	stepheight = 4,
	stay_near = {{"livingcaves:spiderweb", "livingcaves:spiderweb2", "livingcaves:spiderweb3", "livingcaves:spiderweb4", "livingcaves:spiderweb5", "livingcaves:spiderweb6", "livingcaves:spiderweb7", "livingcaves:spiderweb8", "livingcaves:spiderweb9"}, 3},
	drops = {
		{name = "animalworld:raw_athropod", chance = 1, min = 0, max = 2},
		{name = "wool:white", chance = 1, min = 0, max = 2},
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 8,
	animation = {
		speed_normal = 100,
		stand_start = 0,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		punch_start = 200,
		punch_end = 300,
		shoot_start = 200,
		shoot_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
})


if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:spider",
	nodes = {"default:stone", "default:desert_stone", "default:sandstone", "mcl_core:stone", "mcl_core:granite"},
	min_light = 0,
	interval = 60,
	chance = 8000, -- 15000
	active_object_count = 2,
	min_height = -30,
	max_height = 1,
})
end


mobs:register_egg("animalworld:spider", S("Spider"), "aspider.png")


mobs:alias_mob("animalworld:spider", "animalworld:spider") -- compatiblity

-- raw athropod
minetest.register_craftitem(":animalworld:raw_athropod", {
	description = S("Raw Athropod"),
	inventory_image = "animalworld_raw_athropod.png",
	on_use = minetest.item_eat(3),
	groups = {food_meat_raw = 1, flammable = 2},
})

-- mese arrow (weapon)
mobs:register_arrow("animalworld:silk_arrow", {
	visual = "sprite",
--	visual = "wielditem",
	visual_size = {x = 0.5, y = 0.5},
	textures = {"animalworld_silk_arrow.png"},
	--textures = {""animalworld_silk_arrow.png""},
	velocity = 6,
--	rotate = 180,

	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 2},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 2},
		}, nil)
	end,

	hit_node = function(self, pos, node)
	end
})

-- cooked athropod
minetest.register_craftitem(":animalworld:cooked_athropod", {
	description = S("Cooked Athropod"),
	inventory_image = "animalworld_cooked_athropod.png",
	on_use = minetest.item_eat(5),
	groups = {food_meat = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "animalworld:cooked_athropod",
	recipe = "animalworld:raw_athropod",
	cooktime = 5,
})

