local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:anteater", {
	stepheight = 1,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 10,
	hp_min = 25,
	hp_max = 65,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	mesh = "Anteater.b3d",
	textures = {
		{"textureanteater.png"},
	},
	makes_footstep_sound = true,
	sounds = {

	},
	walk_velocity = 0.7,
	run_velocity = 2,
	runaway = false,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
	jump_height = 3,
	pushable = true,
	follow = {"fishing:bait:worm", "bees:frame_full", "ethereal:worm", "animalworld:ant", "animalworld:termitequeen", "animalworld:termite", "animalworld:anteggs_raw"},
	view_range = 10,
        stay_near = {{"default:jungletree", "default:junglegrass", "livingjungle::grass2", "livingjungle::grass1", "livingjungle:alocasia", "livingjungle:flamingoflower"}, 6},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	        {name = "mobs:leather", chance = 1, min = 0, max = 2},
	        {name = "animalworld:anteatercorpse", chance = 7, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 75,
		stand_start = 0,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		punch_start = 250,
		punch_end = 350,

		die_start = 250,
		die_end = 350,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

local spawn_on = {"mcl_core:podzol", "default:dirt_withforest_litter"}

if minetest.get_mapgen_setting("mg_name") ~= "v6" then
	spawn_on = {"mcl_core:podzol", "default:dirt_withforest_litter", "default:dry_dirt_with_dry_grass"}
end

if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:grass_grove", "ethereal:green_dirt", "default:dirt_with_rainforest_litter", "livingjungle:jungleground", "livingjungle:leafyjungleground"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:anteater",
	nodes = {"mcl_core:podzol", "default:dirt_with_rainforest_litter", "mcl_core:dirt_with_gras"},
	neighbors = {"default:jungletree", "mcl_core:jungletree"},
	min_light = 0,
	interval = 1,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 1,
	max_height = 50,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:anteater", S("Anteater"), "aanteater.png")


mobs:alias_mob("animalworld:manteater", "animalworld:anteater") -- compatibility

