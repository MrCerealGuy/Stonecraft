local S = minetest.get_translator("livingfloatlands")
local random = math.random

mobs:register_mob("livingfloatlands:wildhorse", {
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 2,
        damage = 20,
	hp_min = 50,
	hp_max = 70,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.7, 1.2, 0.7},
	visual = "mesh",
	mesh = "Wildhorse.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturewildhorse.png"},
	},
	sounds = {
		random = "livingfloatlands_wildhorse",
		damage = "livingfloatlands_wildhorse",
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 4,
        walk_chance = 20,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor"},
	jump = true,
        jump_height = 6,
	stepheight = 2,
        stay_near = {{"livingfloatlands:coldsteppe_shrub", "livingfloatlands:coldsteppe_grass", "livingfloatlands:coldsteppe_grass2", "livingfloatlands:coldsteppe_grass3", "livingfloatlands:coldsteppe_grass4", "livingdesert:coldsteppe_grass1", "livingdesert:coldsteppe_grass2", "livingdesert:coldsteppe_grass3"}, 5},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		walk_speed = 75,
		walk_start = 100,
		walk_end = 200,
		run_speed = 100,
		run_start = 200,
		run_end = 300,
		die_start = 100,
		die_end = 200,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

	follow = {
		"default:grass_3", "default:dry_grass_3", "ethereal:dry_shrub", "farming:lettuce", "farming:seed_wheat", "default:junglegrass", "livingfloatlands:coldsteppe_pine3_sapling", "livingfloatlands:coldsteppe_pine2_sapling", "livingfloatlands:coldsteppe_pine_sapling", "livingfloatlands:coldsteppe_bulbous_chervil_root", "livingdesert:coldsteppe_grass1"
	},
	view_range = 15,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 15, false, nil) then return end
	end,
})


if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:crystal_dirt", "ethereal:gray_dirt", "default:dry_dirt_with_dry_grass", "default:dirt_with_grass"}
end

if not mobs.custom_spawn_livingfloatlands then
mobs:spawn({
	name = "livingfloatlands:wildhorse",
	nodes = {"livingfloatlands:coldsteppe_litter", "livingdesert:coldsteppe_ground2"},
	neighbors = {"livingfloatlands:coldsteppe_grass", "livingfloatlands:coldsteppe_grass2", "livingfloatlands:coldsteppe_grass3", "livingdesert:coldsteppe_grass1", "livingdesert:coldsteppe_grass2", "livingdesert:coldsteppe_grass3"},
	min_light = 0,
	interval = 60,
	active_object_count = 4,
	chance = 2000, -- 15000
	min_height = 5,
	max_height = 31000,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"livingfloatlands:coldsteppe_litter", "livingdesert:coldsteppe_ground2"})

			if nods and #nods > 0 then

				-- min herd of 5
				local iter = math.min(#nods, 5)

-- print("--- wildhorse at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "livingfloatlands:wildhorse", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("livingfloatlands:wildhorse", S("Wild Horse"), "awildhorse.png")
