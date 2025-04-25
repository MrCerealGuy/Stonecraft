local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:elephant", {
stepheight = 2,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 3,
        damage = 16,
	hp_min = 75,
	hp_max = 120,
	armor = 100,
	collisionbox = {-1.0, -0.01, -1.0, 1.0, 2, 1.0},
	visual = "mesh",
	mesh = "Elephant.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"textureelephant.png"},
	},
	sounds = {
		random = "animalworld_elephant",
		attack = "animalworld_elephant",
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 4,
	runaway = false,
	jump = false,
        jump_height = 6,
	stepheight = 2,
        knock_back = false,
        stay_near = {{"default:dry_grass_1", "default:dry_grass_2", "default:dry_grass_3", "default:dry_grass_4"}, 6},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
		{name = "animalworld:elephantcorpse", chance = 7, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 4,
        pathfinding = true,
	animation = {
		speed_normal = 80,
		stand_start = 0,
		stand_end = 100,
		walk_start = 300,
		walk_end = 450,
		punch_start = 100,
		punch_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

	follow = {
		"ethereal:banana_single", "mcl_farming:beetroot_item", "mcl_farming:carrot_item", "mcl_farming:melon_item", "mcl_farming:potato_item", "mcl_farming:pumpkin_item", "mcl_farming:wheat_item", "mcl_farming:sweet_berry", "farming:corn_cob", "farming:cabbage",
		"default:apple", "farming:cabbage", "farming:carrot", "farming:cucumber", "farming:grapes", "farming:pineapple", "ethereal:orange", "ethereal:coconut", "ethereal:coconut_slice", "livingdesert:date_palm_fruits", "livingdesert:figcactus_fruit", "default:dry_grass_1", "default:dry_grass_2", "default:dry_grass_3", "default:grass_1", "default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5", "default:marram_grass_1", "default:marram_grass_2", "default:marram_grass_3", "default:coldsteppe_grass_1", "default:coldsteppe_grass_2", "default:coldsteppe_grass_3", "default:coldsteppe_grass_4", "default:coldsteppe_grass_5", "default:coldsteppe_grass_6", "naturalbiomes:savanna_grass1", "naturalbiomes:savanna_grass2", "naturalbiomes:savanna_grass3", "naturalbiomes:outback_grass1", "naturalbiomes:outback_grass2", "naturalbiomes:outback_grass3", "naturalbiomes:outback_grass4", "naturalbiomes:outback_grass5", "naturalbiomes:outback_grass6", "naturalbiomes:med_grass1", "naturalbiomes:med_grass2", "naturalbiomes:heath_grass1", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:alpine_grass1", "naturalbiomes:alpine_grass2", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:", "naturalbiomes:", "naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4", "naturalbiomes:bushland_grass5", "naturalbiomes:bushland_grass6", "naturalbiomes:bushland_grass7", "farming:melon_8", "farming:pumpkin_8", "ethereal:strawberry", "farming:blackberry", "naturalbiomes:blackberry", "naturalbiomes:cowberry", "naturalbiomes:banana", "naturalbiomes:banana_bunch", "farming:blueberries", "ethereal:orange", "livingdesert:figcactus_fruit", "livingfloatlands:paleojungle_clubmoss_fruit", "ethereal:banana", "livingdesert:date_palm_fruits", "farming:melon_slice", "naturalbiomes:wildrose", "naturalbiomes:banana", "group:grass", "group:normal_grass"
	},
	view_range = 6,
	replace_rate = 10,
	replace_what = {"farming:soil", "farming:soil_wet"},
	replace_with = "default:dirt",
	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 25, false, nil) then return end
	end,
})

if minetest.get_modpath("ethereal") then
	spawn_on = {"default:dry_dirt_with_dry_grass"}, {"default:dirt_with_rainforest_litter"}, {"ethereal:grove_dirt"}, {"ethereal:bamboo_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:elephant",
	nodes = {"default:dry_dirt_with_dry_grass", "mcl_core:dirt_with_grass", "mcl_core:dirt_with_grass"},
	neighbors = {"group:grass", "group:normal_grass", "mcl_trees:leaves_acacia",  "mcl_core:acacialeaves"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 3,
	min_height = 0,
	max_height = 65,
	day_toggle = true,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:dry_dirt_with_dry_grass"})

			if nods and #nods > 0 then

				-- min herd of 3
				local iter = math.min(#nods, 3)

-- print("--- elephant at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:elephant", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:elephant", S("Elephant"), "aelephant.png")
