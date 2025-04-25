local S = minetest.get_translator("livingfloatlands")
local random = math.random

mobs:register_mob("livingfloatlands:stegosaurus", {
	type = "animal",
	passive = false,
        attack_type = "dogfight",
	attack_animals = false,
	group_attack = true,
        attack_monsters = true,
	reach = 5,
        damage = 16,
	hp_min = 250,
	hp_max = 350,
	armor = 100,
	collisionbox = {-1.0, -0.01, -1.0, 1.0, 2.5, 1.0},
	visual = "mesh",
	mesh = "Stegosaurus.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturestegosaurus.png"},
		{"texturestegosaurus2.png"},
	},
	sounds = {
		random = "livingfloatlands_stegosaurus",
		attack = "default_punch.ogg",
                distance = 16,
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 3,
        walk_chance = 20,
	runaway = false,
        knock_back = false,
	jump = false,
        jump_height = 6,
        stay_near = {{"livingfloatlands:paleojungle_litter_leaves", "livingfloatlands:paleojungle_smallpalm", "livingfloatlands:giantforest_grass3", "livingfloatlands:paleojungle_ferngrass"}, 5},
	stepheight = 2,
	drops = {
		{name = "livingfloatlands:ornithischiaraw", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 3,
        pathfinding = true,
	animation = {
		speed_normal = 25,
		stand_start = 0,
		stand_end = 100,
		walk_speed = 50,
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
		"default:grass_3", "default:dry_grass_3", "ethereal:dry_shrub", "farming:lettuce", "farming:seed_wheat", "default:junglegrass", "livingfloatlands:paleojungle_clubmoss_fruit", "livingfloatlands:giantforest_oaknut", "livingfloatlands:paleojungle_ferngrass"
	},
	view_range = 15,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 5, false, nil) then return end
	end,
})


if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:prairie_dirt", "ethereal:grove_dirt", "default:dirt_with_coniferous_litter", "default:dirt_with_grass", "default:dirt_with_rainforest_litter"}
end

if not mobs.custom_spawn_livingfloatlands then
mobs:spawn({
	name = "livingfloatlands:stegosaurus",
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

-- print("--- stegosaurus at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "livingfloatlands:stegosaurus", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("livingfloatlands:stegosaurus", ("Stegosaurus"), "astegosaurus.png")
