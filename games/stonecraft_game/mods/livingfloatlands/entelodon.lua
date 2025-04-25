local S = minetest.get_translator("livingfloatlands")
local random = math.random

mobs:register_mob("livingfloatlands:entelodon", {
	type = "animal",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
        attack_monsters = true,
	group_attack = true,
	reach = 3,
        damage = 13,
	hp_min = 100,
	hp_max = 150,
	armor = 100,
	collisionbox = {-0.8, -0.01, -0.8, 0.8, 1.8, 0.8},
	visual = "mesh",
	mesh = "Entelodon.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"textureentelodon.png"},
	},
	sounds = {
		random = "livingfloatlands_entelodon2",
		attack = "livingfloatlands_entelodon",
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 3,
	runaway = false,
	jump = false,
        jump_height = 6,
        knock_back = false,
	stepheight = 2,
        stay_near = {{"livingfloatlands:giantforest_grass", "livingfloatlands:giantforest_grass2", "livingfloatlands:giantforest_grass3"}, 5},
	drops = {
		{name = "livingfloatlands:largemammalraw", chance = 1, min = 1, max = 1},
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
		walk_speed = 75,
		walk_start = 100,
		walk_end = 200,
		punch_speed = 100,
		punch_start = 250,
		punch_end = 350,
		die_start = 250,
		die_end = 350,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

	follow = {
		"ethereal:banana_single", "farming:corn_cob", "farming:cabbage",
		"default:apple", "farming:cabbage", "farming:carrot", "farming:cucumber", "farming:grapes", "farming:pineapple", "ethereal:orange", "ethereal:coconut", "ethereal:coconut_slice", "mobs:meat_raw", "animalworld:rabbit_raw", "animalworld:pork_raw", "water_life:meat_raw", "animalworld:chicken_raw", "livingfloatlands:ornithischiaraw", "livingfloatlands:sauropodraw", "livingfloatlands:theropodraw", "livingfloatlands:giantforest_oaknut"
	},
	view_range = 12,
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
	spawn_on = {"ethereal:prairie_dirt", "ethereal:dry_dirt", "default:desert_sand", "default:dry_dirt_with_dry_grass"}
end

if not mobs.custom_spawn_livingfloatlands then
mobs:spawn({
	name = "livingfloatlands:entelodon",
	nodes = {"livingfloatlands:giantforest_litter"},
	neighbors = {"livingfloatlands:giantforest_paleoredwood_trunk", "livingfloatlands:giantforest_paleooak_trunk"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 5,
	max_height = 31000,
	day_toggle = true,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"livingfloatlands:giantforest_litter"})

			if nods and #nods > 0 then

				-- min herd of 2
				local iter = math.min(#nods, 2)

-- print("--- entelodon at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "livingfloatlands:entelodon", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("livingfloatlands:entelodon", ("Entelodon"), "aentelodon.png")
