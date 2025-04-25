local S = minetest.get_translator("marinaramobs")
local random = math.random

mobs:register_mob("marinaramobs:nautilus", {
stepheight = 0.0,
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = false,
	reach = 1,
        damage = 1,
	hp_min = 5,
	hp_max = 25,
	armor = 100,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.5, 0.2},
	visual = "mesh",
	visual_size = {x = 2.0, y = 2.0},
	mesh = "Nautilus.b3d",
	textures = {
		{"texturenautilus.png"},
	},
	sounds = {},
	makes_footstep_sound = false,
	walk_velocity = 1,
	run_velocity = 1,
	fly = true,
	fly_in = "default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing",
	fall_speed = 0,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
	stepheight = 0.0,
	drops = {
		{name = "marinaramobs:nautilushell", chance = 1, min = 0, max = 1},
	},
	water_damage = 0,
        air_damage = 1,
	lava_damage = 4,
	light_damage = 0,
        stay_near = {{"marinara:sand_with_alage", "marinara:sand_with_seagrass", "default:sand_with_kelp", "marinara:sand_with_kelp", "marinara:reed_root", "flowers:waterlily_waving", "naturalbiomes:waterlily", "default:clay", "marinara:softcoral_red", "marinara:softcoral_white", "marinara:softcoral_green", "marinara:softcoral_white", "marinara:softcoral_green", "default:coral_cyan", "default:coral_pink", "default:coral_green"}, 4},
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		fly_start = 100, -- swim animation
		fly_end = 200,
		die_start = 100,
		die_end = 200,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing"},
	floats = 0,
	follow = {
		"fishing:bait_worm",
		"animalworld:raw_athropod", "animalworld:rawfish", "ethereal:fish_raw", "animalworld:fishfood", "mobs_fish:tropical", "water_life:meat_raw", "marinaramobs:octopus_raw", "marinaramobs:raw_exotic_fish"
	},
	view_range = 5,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 15, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_marinaramobs then
mobs:spawn({
	name = "marinaramobs:nautilus",
	nodes = {"default:water_source"}, {"default:river_water_source"},
	neighbors = {"marinara:sand_with_kelp"},
	min_light = 0,
	interval = 60,
	chance = 2, -- 15000
	active_object_count = 3,
	min_height = -30,
	max_height = 0,
	day_toggle = true,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:water_source", "default:river_water_source"})

			if nods and #nods > 0 then

				-- min herd of 3
				local iter = math.min(#nods, 3)

-- print("--- nautilus at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "marinaramobs:nautilus", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("marinaramobs:nautilus", ("Nautilus"), "anautilus.png")

minetest.register_node("marinaramobs:nautilushell", {
    description = S"Nautilusshell",
    visual_scale = 0.6,
    mesh = "Nautilusshell.b3d",
    tiles = {"marinaramobs_nautilusshell.png"},
    inventory_image = "marinaramobs_nautilusshellinv.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 3},
    drawtype = "mesh",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.4, -0.45, -0.4, 0.4, 0.15, 0.4},
            --[[{-0.4, -0.45, -0.4, 0.4, 0.15, 0.4},
            {-0.4, -0.45, -0.4, 0.4, 0.15, 0.4}]]
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.4, -0.45, -0.4, 0.4, 0.15, 0.4}
        }
    },
    sounds = default.node_sound_wood_defaults()
})
