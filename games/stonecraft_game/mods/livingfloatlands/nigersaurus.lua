local S = minetest.get_translator("livingfloatlands")
local random = math.random


mobs:register_mob("livingfloatlands:nigersaurus", {
stepheight = 2,
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 6,
        damage = 20,
	hp_min = 100,
	hp_max = 400,
	armor = 100,
	collisionbox = {-1.0, -0.01, -1.0, 1.0, 1.5, 1.0},
	visual = "mesh",
	mesh = "Nigersaurus.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturenigersaurus.png"},
	},
	sounds = {
		random = "livingfloatlands_nigersaurus",
		damage = "livingfloatlands_nigersaurus2",
                distance = 15,
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 3,
        walk_chance = 20,
        knock_back = false,
	runaway = false,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor"},
	jump = false,
        jump_height = 6,
        stay_near = {{"livingfloatlands:paleojungle_litter_leaves", "livingfloatlands:paleojungle_smallpalm", "livingfloatlands:giantforest_grass3", "livingfloatlands:paleojungle_ferngrass"}, 5},
	drops = {
		{name = "livingfloatlands:sauropodraw", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 3,
        pathfinding = true,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		walk_speed = 50,
		walk_start = 100,
		walk_end = 200,
		die_start = 100,
		die_end = 200,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

	follow = {"default:dry_shrub ", "default:grass_1", "ethereal:dry_shrub", "farming:seed_wheat", "farming:seed_rye", "default:junglegrass", "default:apple", "farming:cabbage", "farming:carrot", "farming:cucumber", "farming:grapes", "farming:pineapple", "ethereal:orange", "ethereal:coconut", "ethereal:coconut_slice", "livingfloatlands:paleojungle_clubmoss_fruit", "livingfloatlands:giantforest_oaknut", "livingfloatlands:paleojungle_ferngrass"},
	view_range = 25,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 5, false, nil) then return end
	end,
})


if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:grove_dirt", "ethereal:bamboo_dirt", "default:dirt_with_coniferous_litter"}
end

if not mobs.custom_spawn_livingfloatlands then
mobs:spawn({
	name = "livingfloatlands:nigersaurus",
	nodes = {"livingfloatlands:paleojungle_litter"},
	neighbors = {"livingfloatlands:paleojungle_ferngrass"},
	min_light = 0,
	interval = 60,
	active_object_count = 2,
	chance = 2000, -- 15000
	min_height = 0,
	max_height = 31000,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"livingfloatlands:paleojungle_litter"})

			if nods and #nods > 0 then

				-- min herd of 2
				local iter = math.min(#nods, 2)

-- print("--- nigersaurus at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "livingfloatlands:nigersaurus", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("livingfloatlands:nigersaurus", ("Nigersaurus"), "anigersaurus.png")

-- raw Sauropod
minetest.register_craftitem(":livingfloatlands:sauropodraw", {
	description = S("Raw Sauropod Meat"),
	inventory_image = "livingfloatlands_sauropodraw.png",
	on_use = minetest.item_eat(3),
	groups = {food_meat_raw = 1, flammable = 2},
})

-- cooked Sauropod
minetest.register_craftitem(":livingfloatlands:sauropodcooked", {
	description = S("Cooked Sauropod Meat"),
	inventory_image = "livingfloatlands_sauropodcooked.png",
	on_use = minetest.item_eat(5),
	groups = {food_meat = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "livingfloatlands:sauropodcooked",
	recipe = "livingfloatlands:sauropodraw",
	cooktime = 30,
})


