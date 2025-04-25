local S = minetest.get_translator("animalworld")
local random = math.random


mobs:register_mob("animalworld:nandu", {
stepheight = 1,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 5,
	hp_min = 20,
	hp_max = 50,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.3, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "Nandu.b3d",
	textures = {
		{"texturenandu.png"}, -- white
		{"texturenandu.png"},
		{"texturenandu.png"},
	},
	child_texture = {
		{"texturenandubaby.png"},
	},
	makes_footstep_sound = true,
	walk_velocity = 0.7,
	run_velocity = 3,
        stay_near = {{"people:feeder", "mcl_flowers:tallgrass", "mcl_flowers:tulip_red", "mcl_flowers:sunflower", "mcl_flowers:poppy", "flowers:tulip_black", "flowers:chrysanthemum_green", "flowers:geranium", "flowers:dandelion_white", "default:grass_1", "marinara:reed_bundle", "naturalbiomes:reed_bundle", "farming:straw", "naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4"}, 5},
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	drops = {
		{name = "animalworld:chicken_raw", chance = 1, min = 1, max = 1},
		{name = "animalworld:chicken_feather", chance = 1, min = 0, max = 2},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 50,
		stand_start = 1,
		stand_end = 100,
		stand1_start = 1,
		stand1_end = 100,
		walk_speed = 75,
		walk_start = 100,
		walk_end = 200,
		run_speed = 125,
		run_start = 100,
		run_end = 200,
		punch_start = 200,
		punch_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	follow = {
		"farming:seed_wheat", "mcl_farming:wheat_seeds", "farming:seed_cotton", "farming:seed_barley", "farming:seed_oat", "farming:seed_rye", "farming:corn_cob", "farming:seed_hemp", "farming:seed_barley", "farming:seed_oat", "farming:seed_cotton", "farming:seed_sunflower", "farming:seed_wheat", "farming:seed_rye", "naturalbiomes:hazelnut", "naturalbiomes:hazelnut_cracked", "farming:sunflower_seeds_toasted", "livingfloatlands:roasted_pine_nuts", "livingfloatlands:giantforest_oaknut_cracked", "livingfloatlands:coldsteppe_pine3_pinecone", "livingfloatlands:coldsteppe_pine_pinecone", "livingfloatlands:coldsteppe_pine2_pinecone"
	},
	view_range = 10,

	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 5, 25, 0, false, nil) then return end
	end,

	do_custom = function(self, dtime)

		self.egg_timer = (self.egg_timer or 0) + dtime
		if self.egg_timer < 10 then
			return
		end
		self.egg_timer = 0

		if self.child
		or math.random(1, 100) > 1 then
			return
		end

		local pos = self.object:get_pos()

		minetest.add_item(pos, "mobs:egg")

		minetest.sound_play("default_place_node_hard", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
	end,
})


local spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_grass"}

if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:bamboo_dirt", "ethereal:prairie_dirt", "default:dirt_with_grass", "naturalbiomes:bushland_bushlandlitter"}
end


if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:nandu",
	nodes = {"mcl_core:dirt_with_grass", "default:dirt_with_grass"}, 
	neighbors = {"group:grass", "group:normal_grass", "mcl_flowers:tallgrass", "mcl_flowers:tulip_red", "mcl_flowers:sunflower", "mcl_flowers:poppy"}, 
	min_light = 14,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 3,
	min_height = 10,
	max_height = 40,
	day_toggle = true,


		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:dirt_with_grass"})

			if nods and #nods > 0 then

				-- min herd of 3
				local iter = math.min(#nods, 3)

-- print("--- nandu at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:nandu", child = kid})
					end
				end
			end
		end
	})
end


mobs:register_egg("animalworld:nandu", ("Nandu"), "anandu.png", 0)


mobs:alias_mob("animalworld:andu", "animalworld:nandu") -- compatibility


-- egg entity

mobs:register_arrow("animalworld:egg_entity", {
	visual = "sprite",
	visual_size = {x=.5, y=.5},
	textures = {"mobs_chicken_egg.png"},
	velocity = 6,

	hit_player = function(self, player)
		player:punch(minetest.get_player_by_name(self.playername) or self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(minetest.get_player_by_name(self.playername) or self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1},
		}, nil)
	end,

	hit_node = function(self, pos, node)

		if math.random(1, 10) > 1 then
			return
		end

		pos.y = pos.y + 1

		local nod = minetest.get_node_or_nil(pos)

		if not nod
		or not minetest.registered_nodes[nod.name]
		or minetest.registered_nodes[nod.name].walkable == true then
			return
		end

		local mob = minetest.add_entity(pos, "animalworld:nandu")
		local ent2 = mob:get_luaentity()

		mob:set_properties({
			textures = ent2.child_texture[1],
			visual_size = {
				x = ent2.base_size.x / 2,
				y = ent2.base_size.y / 2
			},
			collisionbox = {
				ent2.base_colbox[1] / 2,
				ent2.base_colbox[2] / 2,
				ent2.base_colbox[3] / 2,
				ent2.base_colbox[4] / 2,
				ent2.base_colbox[5] / 2,
				ent2.base_colbox[6] / 2
			},
		})

		ent2.child = true
		ent2.tamed = true
		ent2.owner = self.playername
	end
})


-- egg throwing item

local egg_GRAVITY = 9
local egg_VELOCITY = 19

-- shoot egg
local mobs_shoot_egg = function (item, player, pointed_thing)

	local playerpos = player:get_pos()

	minetest.sound_play("default_place_node_hard", {
		pos = playerpos,
		gain = 1.0,
		max_hear_distance = 5,
	})

	local obj = minetest.add_entity({
		x = playerpos.x,
		y = playerpos.y +1.5,
		z = playerpos.z
	}, "animalworld:egg_entity")

	local ent = obj:get_luaentity()
	local dir = player:get_look_dir()

	ent.velocity = egg_VELOCITY -- needed for api internal timing
	ent.switch = 1 -- needed so that egg doesn't despawn straight away

	obj:setvelocity({
		x = dir.x * egg_VELOCITY,
		y = dir.y * egg_VELOCITY,
		z = dir.z * egg_VELOCITY
	})

	obj:setacceleration({
		x = dir.x * -3,
		y = -egg_GRAVITY,
		z = dir.z * -3
	})

	-- pass player name to egg for chick ownership
	local ent2 = obj:get_luaentity()
	ent2.playername = player:get_player_name()

	item:take_item()

	return item
end


-- egg
minetest.register_node(":animalworld:egg", {
	description = S("Bird Egg"),
	tiles = {"mobs_chicken_egg.png"},
	inventory_image  = "mobs_chicken_egg.png",
	visual_scale = 0.7,
	drawtype = "plantlike",
	wield_image = "mobs_chicken_egg.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {food_egg = 1, snappy = 2, swordy = 1, handy = 1, dig_immediate = 3},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1,
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name = "animalworld:egg", param2 = 1})
		end
	end,
	on_use = mobs_shoot_egg
})


-- fried egg
minetest.register_craftitem(":animalworld:chicken_egg_fried", {
	description = S("Fried Egg"),
	inventory_image = "animalworld_chicken_egg_fried.png",
	on_use = minetest.item_eat(2),
	groups = {food_egg_fried = 1, flammable = 2},
})

minetest.register_craft({
	type  =  "cooking",
	recipe  = "animalworld:egg",
	output = "animalworld:chicken_egg_fried",
})

-- raw chicken
minetest.register_craftitem(":animalworld:chicken_raw", {
description = S("Raw Birdmeat"),
	inventory_image = "animalworld_chicken_raw.png",
	on_use = minetest.item_eat(2),
	groups = {food_meat_raw = 1, food_chicken_raw = 1, flammable = 2},
})

-- cooked chicken
minetest.register_craftitem(":animalworld:chicken_cooked", {
description = S("Cooked Birdmeat"),
	inventory_image = "animalworld_chicken_cooked.png",
	on_use = minetest.item_eat(6),
	groups = {food_meat = 1, food_chicken = 1, flammable = 2},
})

minetest.register_craft({
	type  =  "cooking",
	recipe  = "animalworld:chicken_raw",
	output = "animalworld:chicken_cooked",
})

-- feather
minetest.register_craftitem(":animalworld:chicken_feather", {
	description = S("Feather"),
	inventory_image = "animalworld_chicken_feather.png",
	groups = {flammable = 2},
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:chicken_feather",
	burntime = 1,
})
