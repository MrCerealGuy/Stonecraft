local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:monkey", {
	stepheight = 3,
	type = "animal",
	passive = false,
	attack_type = "dogshoot",
	dogshoot_switch = 1,
	dogshoot_count_max = 3, -- shoot for 10 seconds
	dogshoot_count2_max = 5, -- dogfight for 3 seconds
	shoot_interval = 1,
	arrow = "animalworld:pooball",
	shoot_offset = 0.8,
	group_attack = true,
	owner_loyal = true,
	attack_npcs = true,
	reach = 2,
	damage = 4,
	hp_min = 15,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	mesh = "Monkey.b3d",
	textures = {
		{"texturemonkey.png"},
		{"texturemonkey2.png"},
		{"texturemonkey3.png"},
		{"texturemonkey4.png"},
		{"texturemonkey5.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "animalworld_monkey",
		attack = "animalworld_monkey2",
                damage = "animalworld_monkey3",

	},
	walk_velocity = 2,
	run_velocity = 3,
        walk_chance = 20,
	jump = true,
	jump_height = 8,
	pushable = true,
	follow = {"default:apple", "farming:potato", "mcl_farming:beetroot_item", "mcl_farming:carrot_item", "mcl_farming:melon_item", "mcl_farming:potato_item", "mcl_farming:pumpkin_item", "mcl_farming:wheat_item", "mcl_farming:sweet_berry", "ethereal:banana_bread", "farming:carrot", "farming:seed_rice", "farming:corn", "farming:wheat", "farming:beans", "farming:barley", "farming:oat", "farming:rye", "mobs:cheese", "farming:bread", "ethereal:banana_bread", "ethereal:banana", "farming:cabbage", "farming:lettuce", "farming:melon_slice", "animalworld:termitequeen", "animalworld:locust_roasted", "livingdesert:date_palm_fruits", "livingdesert:figcactus_fruit"},
	view_range = 15,
	replace_rate = 10,
	replace_what = {"farming:soil", "farming:soil_wet"},
	replace_with = "default:dirt",
        stay_near = {{"default:acacia_tree", "mcl_core:jungletree", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "mcl_trees:leaves_mangrove", "default:acacia_leaves", "default:jungleleaves", "naturalbiomes:bamboo_leaves", "naturalbiomes:bambooforest_groundgrass", "livingjungle:samauma_trunk", "livingjungle:samauma_leaves"}, 5},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 3},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 4,
	animation = {
		speed_normal = 100,
		stand_speed = 75,
		stand_start = 350,
		stand_end = 450,
		walk_start = 0,
		walk_end = 100,
		punch_start = 100,
		punch_end = 200,
                shoot_start = 200,
		shoot_end = 300,
		die_start = 200,
		die_end = 300,
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


if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:monkey",
	nodes = {"default:dry_dirt_with_dry_grass", "mcl_core:jungletree", "mcl_core:dirt_with_gras", "default:dirt_with_rainforest_litter", "default:jungleleaves", "naturalbiomes:bambooforest_litter", "livingjungle:jungleground", "livingjungle:leafyjungleground"},
	neighbors = {"default:jungletree", "mcl_trees:tree_jungle", "mcl_core:jungletree", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "mcl_trees:leaves_mangrove", "livingjungle:alocasia", "livingjungle:flamingoflower", "livingjungle:samauma_trunk", "group:grass", "group:normal_grass", "naturalbiomes:bambooforest_groundgrass", "naturalbiomes:bambooforest_groundgrass2"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 6,
	min_height = 30,
	max_height = 75,
	day_toggle = true,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:dry_dirt_with_dry_grass", "default:dirt_with_rainforest_litter", "default:jungleleaves", "naturalbiomes:bambooforest_litter", "livingjungle:jungleground", "livingjungle:leafyjungleground"})

			if nods and #nods > 0 then

				-- min herd of 6
				local iter = math.min(#nods, 6)

-- print("--- monkey at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:monkey", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:monkey", S("Monkey"), "amonkey.png")

mobs:register_arrow("animalworld:pooball", {
	visual = "sprite",
	visual_size = {x=.5, y=.5},
	textures = {"animalworld_pooball.png"},
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


