local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:giraffe", {
	type = "animal",
	passive = false,
        attack_type = "dogfight",
	attack_animals = false,
	attack_monsters = true,
	group_attack = true,
	reach = 3,
        damage = 18,
	hp_min = 100,
	hp_max = 160,
	armor = 100,
	collisionbox = {-1, -0.01, -1, 1, 2.0, 1},
	visual = "mesh",
	mesh = "Giraffe.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturegiraffe.png"},
	},
	sounds = {
		random = "animalworld_giraffe",
		attack = "animalworld_giraffe2",
                distance = 13,
	},
	makes_footstep_sound = true,
	walk_velocity = 1.0,
	run_velocity = 2,
        walk_chance = 30,
	runaway = false,
	jump = false,
        jump_height = 6,
	stepheight = 1,
        stay_near = {{"naturalbiomes:savanna_flowergrass", "naturalbiomes:savanna_grass", "naturalbiomes:savanna_grass2", "naturalbiomes:savanna_grass3", "naturalbiomes:savannagrass"}, 6},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	        {name = "mobs:leather", chance = 1, min = 0, max = 2},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
        knock_back = false,
        pathfinding = true,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		stand2_start = 0,
		stand2_end = 100,
		stand3_start = 0,
		stand3_end = 100,
		walk_start = 200,
		walk_end = 300,
		punch_start = 300,
		punch_end = 400,
		die_start = 300,
		die_end = 400,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

	follow = {"default:apple", "mcl_trees:leaves_oak", "mcl_trees:leaves_dark_oak", "mcl_core:leaves", "mcl_core:birchleaves", "mcl_core:darkleaves", "mcl_core:spruceleaves", "default:dry_dirt_with_dry_grass", "mcl_trees:leaves_oak", "mcl_trees:leaves_dark_oak", "farming:seed_wheat", "default:junglegrass", "farming:seed_oat", "naturalbiomes:savannagrass", "naturalbiomes:savannagrassmall", "naturalbiomes:savanna_flowergrass", "default:acacia_leaves", "naturalbiomes:acacia_leaves"},
	view_range = 10,
	replace_rate = 10,
	replace_what = {"farming:soil", "farming:soil_wet"},
	replace_with = "default:dirt",
	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 15, false, nil) then return end
	end,
})


if minetest.get_modpath("ethereal") then
	spawn_on = {"mcl_core:podzol", "default:dirt_withforest_litter", "ethereal:green_dirt", "ethereal:grass_grove"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:giraffe",
	nodes = {"naturalbiomes:savannalitter", "mcl_core:dirt_with_grass"},
	neighbors = {"naturalbiomes:acacia_trunk", "mcl_core:acaciatree", "mcl_trees:tree_acacia"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 3,
	min_height = 5,
	max_height = 100,
	day_toggle = true,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"naturalbiomes:savannalitter"})

			if nods and #nods > 0 then

				-- min herd of 3
				local iter = math.min(#nods, 3)

-- print("--- boar at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:giraffe", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:giraffe", ("Giraffe"), "agiraffe.png")