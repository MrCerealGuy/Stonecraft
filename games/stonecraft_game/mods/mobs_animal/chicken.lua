
local S = minetest.get_translator("mobs_animal")

-- Chicken by JK Murray and Sirrobzeroone

mobs:register_mob("mobs_animal:chicken", {
	stepheight = 0.6,
	type = "animal",
	passive = true,
	hp_min = 5,
	hp_max = 10,
	armor = 100,
	collisionbox = {-0.3, -0.75, -0.3, 0.3, 0.1, 0.3},
	visual = "mesh",
	mesh = "mobs_chicken.b3d",
	textures = {
		{"mobs_chicken.png"}, -- white
		{"mobs_chicken_brown.png"},
		{"mobs_chicken_black.png"}
	},
	child_texture = {{"mobs_chick.png"}},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_chicken",
		replace = "default_dig_crumbly"
	},
	walk_velocity = 1,
	run_velocity = 3,
	runaway = true,
	runaway_from = {"player", "mobs_animal:pumba"},
	drops = {
		{name = "mobs:chicken_raw", chance = 1, min = 1, max = 1},
		{name = "mobs:chicken_feather", chance = 1, min = 0, max = 2}
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fall_damage = 0,
	fall_speed = -4,
	fear_height = 5,
	animation = {
		speed_normal = 15,
		stand_start = 1, stand_end = 30, stand_speed = 28,
		stand1_start = 31, stand1_end = 70, stand1_speed = 32,
		walk_start = 71, walk_end = 90, walk_speed = 24,
		run_start = 91, run_end = 110, run_speed = 24
	},
	follow = {
		"farming:seed_wheat", "farming:seed_cotton", "farming:seed_barley",
		"farming:seed_oat", "farming:seed_rye", "farming:seed_rice",
		"farming:seed_hemp", "farming:seed_sunflower", "farming:seed_mint"
	},
	view_range = 5,
	replace_rate = 5,
	replace_what = {
		{"farming:seed_wheat", "air", 0},
		{"farming:seed_cotton", "air", 0},
		{"farming:seed_barley", "air", 0},
		{"farming:seed_oat", "air", 0},
		{"farming:seed_rye", "air", 0},
		{"farming:seed_rice", "air", 0},
		{"farming:seed_hemp", "air", 0},
		{"farming:seed_mint", "air", 0},
		{"farming:seed_sunflower", "air", 0}
	},
	stay_near = {{"group:seed"}, 7},

	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 30, 50, 80, false, nil) then return end
	end,

	do_custom = function(self, dtime)

		self.egg_timer = (self.egg_timer or 0) + dtime
		if self.egg_timer < 10 then return end
		self.egg_timer = 0

		if self.child then return end

		local pos = self.object:get_pos() ; if not pos then return end

		if math.random(100) == 1 then

			minetest.add_item(pos, "mobs:egg")

			minetest.sound_play("default_place_node_hard",
					{pos = pos, gain = 1.0, max_hear_distance = 5}, true)

		elseif math.random(100) < 3 then
			minetest.add_item(pos, "mobs:chicken_feather")
		end
	end
})

-- where to spawn

if not mobs.custom_spawn_animal then

	local spawn_on = {"default:dirt_with_grass"}

	if minetest.get_modpath("ethereal") then
		spawn_on = {"ethereal:bamboo_dirt", "ethereal:prairie_dirt"}
	end

	mobs:spawn({
		name = "mobs_animal:chicken",
		nodes = spawn_on,
		neighbors = {"group:grass"},
		min_light = 14,
		interval = 60,
		chance = 8000,
		min_height = 5,
		max_height = 200,
		day_toggle = true
	})
end

-- spawn egg

mobs:register_egg("mobs_animal:chicken", S("Chicken"), "mobs_chicken_inv.png", 0)

-- compatibility with older mobs mod

mobs:alias_mob("mobs:chicken", "mobs_animal:chicken")

-- egg entity

mobs:register_arrow("mobs_animal:egg_entity", {
	visual = "sprite",
	visual_size = {x = .5, y = .5},
	textures = {"mobs_chicken_egg.png"},
	velocity = 6,

	hit_player = function(self, player)

		player:punch(minetest.get_player_by_name(self.playername) or self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1}
		}, nil)
	end,

	hit_mob = function(self, player)

		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1}
		}, nil)
	end,

	hit_node = function(self, pos, node)

		if math.random(10) > 1 then return end

		pos.y = pos.y + 1

		local nod = minetest.get_node_or_nil(pos)

		if not nod or not minetest.registered_nodes[nod.name]
		or minetest.registered_nodes[nod.name].walkable == true then
			return
		end

		mobs:add_mob(pos, {
			name = "mobs_animal:chicken",
			child = true,
			owner = self.playername,
--			nametag = "Chicky",
			ignore_count = true -- ignores mob count per map area
		})
	end
})

-- egg throwing function

local egg_GRAVITY = 9
local egg_VELOCITY = 19

local mobs_shoot_egg = function (item, player, pointed_thing)

	local playerpos = player:get_pos()

	minetest.sound_play("default_place_node_hard", 
			{pos = playerpos, gain = 1.0, max_hear_distance = 5}, true)

	local obj = minetest.add_entity({
		x = playerpos.x,
		y = playerpos.y +1.5,
		z = playerpos.z
	}, "mobs_animal:egg_entity")

	local ent = obj:get_luaentity()
	local dir = player:get_look_dir()

	ent.velocity = egg_VELOCITY -- needed for api internal timing
	ent.switch = 1 -- needed so that egg doesn't despawn straight away
	ent._is_arrow = true -- tell advanced mob protection this is an arrow

	obj:set_velocity({
			x = dir.x * egg_VELOCITY, y = dir.y * egg_VELOCITY, z = dir.z * egg_VELOCITY})

	obj:set_acceleration({
			x = dir.x * -3, y = -egg_GRAVITY, z = dir.z * -3})

	-- pass player name to egg for chick ownership
	local ent2 = obj:get_luaentity()

	ent2.playername = player:get_player_name()

	item:take_item()

	return item
end

-- egg

minetest.register_node(":mobs:egg", {
	description = S("Chicken Egg"),
	tiles = {"mobs_chicken_egg.png"},
	inventory_image  = "mobs_chicken_egg.png",
	visual_scale = 0.7,
	drawtype = "plantlike",
	wield_image = "mobs_chicken_egg.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = false,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {food_egg = 1, snappy = 2, dig_immediate = 3},
	sounds = mobs.node_sound_defaults(),

	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "mobs:egg", param2 = 1})
	end,

	on_use = mobs_shoot_egg
})

-- fried egg and recipe

minetest.register_craftitem(":mobs:chicken_egg_fried", {
	description = S("Fried Egg"),
	inventory_image = "mobs_chicken_egg_fried.png",
	on_use = minetest.item_eat(2),
	groups = {food_egg_fried = 1}
})

mobs.add_eatable("mobs:chicken_egg_fried", 2)

minetest.register_craft({
	type  =  "cooking",
	recipe  = "mobs:egg",
	output = "mobs:chicken_egg_fried"
})

-- raw chicken

minetest.register_craftitem(":mobs:chicken_raw", {
	description = S("Raw Chicken"),
	inventory_image = "mobs_chicken_raw.png",
	on_use = minetest.item_eat(2),
	groups = {food_meat_raw = 1, food_chicken_raw = 1}
})

mobs.add_eatable("mobs:chicken_raw", 2)

-- cooked chicken and recipe

minetest.register_craftitem(":mobs:chicken_cooked", {
	description = S("Cooked Chicken"),
	inventory_image = "mobs_chicken_cooked.png",
	on_use = minetest.item_eat(6),
	groups = {food_meat = 1, food_chicken = 1}
})

mobs.add_eatable("mobs:chicken_cooked", 6)

minetest.register_craft({
	type  =  "cooking",
	recipe  = "mobs:chicken_raw",
	output = "mobs:chicken_cooked"
})

-- feather and fuel

minetest.register_craftitem(":mobs:chicken_feather", {
	description = S("Feather"),
	inventory_image = "mobs_chicken_feather.png",
	groups = {flammable = 2, feather = 1}
})

minetest.register_craft({type = "fuel", recipe = "mobs:chicken_feather", burntime = 1})
