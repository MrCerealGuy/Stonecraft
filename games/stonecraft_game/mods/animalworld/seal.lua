local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:seal", {
stepheight = 0.6,
	type = "animal",
	passive = true,
	reach = 1,
	hp_min = 20,
	hp_max = 55,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 0.4, 0.4},
	visual = "mesh",
	mesh = "Seal.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"textureseal.png"},
	},
	sounds = {
		random = "animalworld_seal",
		attack = "animalworld_seal",
	},
	makes_footstep_sound = true,
	walk_velocity = 0.8,
	run_velocity = 1,
	runaway = true,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
	stepheight = 1.1,
        stay_near = {{"default:snow", "default:gravel", "mcl_core:snow", "mcl_core:gravel"}, 5},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
		{name = "animalworld:sealcorpse", chance = 7, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 125,
		stand_start = 0,
		stand_end = 400,
		walk_start = 400,
		walk_end = 600,
		fly_start = 650, -- swim animation
		fly_end = 850,
		die_start = 650,
		die_end = 850,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:water_flowing", "default:river_water_flowing", "default:river_water", "mcl_core:water_source", "mcl_core:water_flowing"},
	floats = 0,
	follow = {
		"ethereal:fish_raw", "animalworld:rawfish", "mobs_fish:tropical",
		"mobs_fish:clownfish_set", "mcl_fishing:pufferfish_raw", "mobs_fish:tropical_set", "xocean:fish_edible", "mobs:bluefish_raw", "nativevillages:catfish_raw", "animalworld:rawmollusk", "marinaramobs:octopus_raw", "marinara:raw_oisters", "marinara:raw_athropod", "animalworld:rawfish", "fishing:fish_raw", "fishing:pike_raw", "marinaramobs:raw_exotic_fish", "nativevillages:catfish_raw", "xocean:fish_edible", "ethereal:fish_raw", "mobs:clownfish_raw", "fishing:bluewhite_raw", "fishing:exoticfish_raw", "fishing:fish_raw", "fishing:carp_raw", "fishing:perch_raw", "water_life:meat_raw", "fishing:shark_raw", "fishing:pike_raw"
	},
	view_range = 10,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

if minetest.get_modpath("ethereal") then
	spawn_on = {"default:snowblock", "default_ice"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:seal",
	nodes = {"default:snowblock", "default_ice", "mcl_core:ice", "mcl_core:snow"},
	neighbors = {"default:water_source", "mcl_core:water_source"},
	min_light = 14,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 4,
	min_height = 0,
	max_height = 10,
	day_toggle = true,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:snowblock", "default_ice"})

			if nods and #nods > 0 then

				-- min herd of 4
				local iter = math.min(#nods, 4)

-- print("--- seal at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:seal", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:seal", S("Seal"), "aseal.png")
