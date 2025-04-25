local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:beluga", {
	stepheight = 1,
	type = "animal",
	passive = true,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 1,
	hp_min = 250,
	hp_max = 455,
	armor = 100,
	collisionbox = {-0.8, -0.01, -0.8, 0.8, 1.2, 0.8},
	visual = "mesh",
	mesh = "Beluga.b3d",
	textures = {
		{"texturebeluga.png"},

	},
	makes_footstep_sound = true,
	sounds = {
                random = "animalworld_beluga",
		attack = "animalworld_beluga2",
                damage = "animalworld_beluga3",
		death = "animalworld_beluga4",
	},
	walk_velocity = 2,
	run_velocity = 5,
	fly = true,
	fly_in = "default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "mcl_core:water_source", "mcl_core:water_flowing",
	fall_speed = 0,
	jump = true,
	jump_height = 0,
        stay_near = {{"default:clay", "marinara:sand_with_seagrass", "marinara:coastrock_with:brownalage", "marinara:sand_with_seagrass2", "mcl_ocean:seagrass:sand", "mcl_ocean:tube_coral", "mcl_ocean:fire_coral", "mcl_ocean:brain_coral", "mcl_ocean:seagrass_gravel"}, 5},
 runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	pushable = true,
	follow = {
		"animalworld:rawmollusk", "mcl_fishing:pufferfish_raw", "marinaramobs:octopus_raw", "marinara:raw_oisters", "marinara:raw_athropod", "animalworld:rawfish", "fishing:fish_raw", "fishing:pike_raw", "marinaramobs:raw_exotic_fish", "nativevillages:catfish_raw", "xocean:fish_edible", "ethereal:fish_raw", "mobs:clownfish_raw", "fishing:bluewhite_raw", "fishing:exoticfish_raw", "fishing:fish_raw", "fishing:carp_raw", "fishing:perch_raw", "water_life:meat_raw", "fishing:shark_raw", "fishing:pike_raw"
	},
	view_range = 20,
	drops = {
		{name = "animalworld:whaleblubber", chance = 1, min = 3, max = 10},
		{name = "animalworld:whalemeat_raw", chance = 1, min = 3, max = 10},
	},
	water_damage = 0,
        air_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 0,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		fly_start = 150,
		fly_end = 250,
		fly2_start = 250,
		fly2_end = 350,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 25, false, nil) then return end
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:beluga",
	nodes = {"mcl_core:water_source", "default:water_source"},
	neighbors = {"default:ice", "default:snowblock", "mcl_core:ice", "mcl_core:snow"},
	min_light = 0,
	interval = 30,
	chance = 2000, -- 15000
	active_object_count = 3,
	min_height = -20,
	max_height = 0,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:water_source"})

			if nods and #nods > 0 then

				-- min herd of 3
				local iter = math.min(#nods, 3)

-- print("--- beluga at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:beluga", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:beluga", S("Beluga Whale"), "abeluga.png")


mobs:alias_mob("animalworld:beluga", "animalworld:beluga") -- compatibility


-- raw whale
minetest.register_craftitem(":animalworld:whalemeat_raw", {
	description = S("Raw Whale Meat"),
	inventory_image = "animalworld_whalemeat_raw.png",
	on_use = minetest.item_eat(4),
	groups = {food_meat_raw = 1, flammable = 2},
})

-- cooked whale
minetest.register_craftitem(":animalworld:whalemeat_cooked", {
	description = S("Cooked Whale Meat"),
	inventory_image = "animalworld_whalemeat_cooked.png",
	on_use = minetest.item_eat(8),
	groups = {food_meat = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "animalworld:whalemeat_cooked",
	recipe = "animalworld:whalemeat_raw",
	cooktime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "animalworld:whaleblubber",
	burntime = 10,
})

minetest.register_craftitem("animalworld:whaleblubber", {
	description = S("Whale Blubber"),
	inventory_image = "animalworld_whaleblubber.png",
})