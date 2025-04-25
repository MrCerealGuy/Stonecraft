local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:vulture", {
stepheight = 3,
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = false,
	reach = 2,
        damage = 1,
	hp_min = 5,
	hp_max = 45,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.5, 0.3},
	visual = "mesh",
	mesh = "Vulture.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturevulture.png"},
	},
	sounds = {
		random = "animalworld_vulture",
	},
	makes_footstep_sound = false,
	walk_velocity = 5,
	run_velocity = 6,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player"},
	fall_speed = 0,
	jump = true,
        jump_height = 6,
	fly = true,
	stepheight = 3,
	drops = {
		{name = "animalworld:chicken_raw", chance = 1, min = 1, max = 1},
	        {name = "animalworld:chicken_feather", chance = 1, min = 1, max = 1},
		{name = "animalworld:vulturecorpse", chance = 7, min = 1, max = 1},
	
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 0,
	animation = {
		speed_normal = 100,
		stand_start = 150,
		stand_end = 250,
		fly_start = 0, -- swim animation
		fly_end = 100,
		die_start = 0,
		die_end = 100,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
fly_in = {"air"},
	floats = 0,
	follow = {
		"ethereal:fish_raw", "animalworld:rawfish",  "mcl_mobitems:chicken", "mcl_fishing:pufferfish_raw", "mcl_mobitems:rotten_flesh", "mcl_mobitems:mutton", "mcl_mobitems:beef", "mcl_mobitems:porkchop", "mcl_mobitems:rabbit", "mobs_fish:tropical",
		"mobs:meat_raw", "animalworld:rabbit_raw", "animalworld:pork_raw", "water_life:meat_raw"
	},
	
view_range = 10,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:vulture",
	nodes = {"mcl_core:dirt_with_grass", "mcl_core:dirt_with_grass", "default:dirt_with_grass"}, {"default:dry_dirt_with_dry_grass"}, {"default:desert_sand"}, {"default:stone"}, {"livingdesert:coldsteppe_ground4"}, {"livingdesert:coldsteppe_ground3"}, {"default:stone"}, {"livingdesert:coldsteppe_ground4"}, {"livingdesert:coldsteppe_ground3"},
	neighbors = {"group:grass", "mcl_flowers:tallgrass", "mcl_flowers:tulip_red", "mcl_flowers:sunflower", "mcl_flowers:poppy", "mcl_core:birchtree", "mcl_trees:tree_birch", "mcl_trees:tree_oak", "mcl_trees:tree_dark_oak", "mcl_core:tree", "mcl_trees:leaves_oak", "mcl_trees:leaves_dark_oak", "mcl_core:leaves", "mcl_core:birchleaves", "mcl_core:darkleaves", "mcl_core:spruceleaves", "group:normal_grass", "livingdesert:coldsteppe_grass1", "livingdesert:coldsteppe_grass2", "livingdesert:coldsteppe_grass3", "livingdesert:coldsteppe_grass4", "default:dry_shrub"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 3,
	min_height = 50,
	max_height = 300,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:vulture", S("Vulture"), "avulture.png")
