local S = minetest.get_translator("marinaramobs")

mobs:register_mob("marinaramobs:starfish", {
stepheight = 1,
	type = "animal",
	passive = true,
	reach = 1,
	attack_npcs = false,
	reach = 2,
	damage = 0,
	hp_min = 10,
	hp_max = 40,
	armor = 100,
	collisionbox = {-0.2, -0.01, -0.2,  0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "Starfish.b3d",
	drawtype = "front",
	textures = {
		{"texturestarfish.png"},

	},
	sounds = {
	},
	makes_footstep_sound = false,
	walk_velocity = 0.2,
	run_velocity = 0.4,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
	jump_height = 6,
	drops = {
		{name = "marinaramobs:starfish", chance = 1, min = 0, max = 1},
	},
        stay_near = {{"marinara:sand_with_alage", "marinara:sand_with_seagrass", "default:sand_with_kelp", "marinara:sand_with_kelp", "marinara:reed_root", "flowers:waterlily_waving", "naturalbiomes:waterlily", "default:clay", "marinara:softcoral_red", "marinara:softcoral_white", "marinara:softcoral_green", "marinara:softcoral_white", "marinara:softcoral_green", "default:coral_cyan", "default:coral_pink", "default:coral_green"}, 5},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 25,
		stand_start = 100,
		stand_end = 200,
		stand2_start = 200,
		stand2_end = 300,
		walk_start = 0,
		walk_end = 100,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:water_flowing"},
	floats = 0,
	follow = {"animalworld:rawfish", "mobs_fish:tropical", "mobs:clownfish_raw", 
"mobs:bluefish_raw", "fishing:bait_worm", "fishing:clownfish_raw", "fishing:bluewhite_raw", "fishing:exoticfish_raw", "fishing:fish_raw", "fishing:carp_raw", "fishing:perch_raw", "water_life:meat_raw", "fishing:shark_raw", "fishing:pike_raw", "marinaramobs:octopus_raw", "marinaramobs:raw_exotic_fish"},
	view_range = 5,
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 15, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_marinaramobs then
mobs:spawn({
	name = "marinaramobs:starfish",
	nodes = {"default:water_source"},
	neighbors = {"marinara:coastrock"},
	min_light = 0,
	interval = 60,
	chance = 2, 
	active_object_count = 3,
	min_height = -30,
	max_height = 0,
})


mobs:register_egg("marinaramobs:starfish", S("Starfish"), "astarfish.png", 0)


mobs:alias_mob("marinaramobs:starfish", "marinaramobs:starfish") -- compatibility

minetest.register_craft({
	output = "marinaramobs:starfishmobile",
	type = "shapeless",
	recipe = 
		{"marinaramobs:starfish", "farming:string"}

})

minetest.register_node("marinaramobs:starfishmobile", {
	description = S("Starfish Mobile"),
	drawtype = "plantlike",
	waving = 0,
	tiles = {"marinaramobs_starfishmobile.png"},
	inventory_image = "marinaramobs_starfishmobile.png",
	wield_image = "marinaramobs_starfishmobile.png",
	paramtype = "light",
	sunlight_propagates = true,
	climbable = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})
end