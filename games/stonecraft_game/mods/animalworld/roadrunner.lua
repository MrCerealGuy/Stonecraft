local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:roadrunner", {
stepheight = 3,
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = false,
	reach = 2,
        damage = 2,
	hp_min = 5,
	hp_max = 30,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.5, 0.3},
	visual = "mesh",
	mesh = "Roadrunner.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"textureroadrunner.png"},
	},
	sounds = {
		random = "animalworld_roadrunner",
	},
	makes_footstep_sound = true,
	walk_velocity = 3,
	run_velocity = 5,
	fall_speed = -1,
	fall_damage = 0,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = true,
        jump_height = 3,
        stay_near = {{"livingdesert:date_palm_leaves", "mcl_core:deadbush", "mcl_core:cactus", "livingdesert:yucca", "default:dry_shrub", "livingdesert:figcactus_trunk", "livingdesert:coldsteppe_grass1", "livingdesert:cactus", "livingdesert:cactus3", "livingdesert:cactus2", "livingdesert:cactus4"}, 5},
	drops = {
		{name = "animalworld:chicken_raw", chance = 1, min = 1, max = 1},
	        {name = "animalworld:chicken_feather", chance = 1, min = 1, max = 1},
	
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 4,
	animation = {
		speed_normal = 100,
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		walk_start = 220,
		walk_end = 320,
		fly_start = 340, -- swim animation
		fly_end = 420,
		jump_start = 450,
		jump_end = 550,
		die_start = 450,
		die_end = 550,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

fly_in = {"air"},
	floats = 0,
	follow = {
		"fishing:bait:worm", "farming:seed_wheat", "farming:seed_rice", "farming:seed_oat", "ethereal:pine_nuts", "ethereal:worm", "fishing:bait:worm", "bees:frame_full", "animalworld:ant", "animalworld:termite", "livingdesert:figcactus_fruit", "animalworld:cockroach"
	},
	
view_range = 7,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 5, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:roadrunner",
	nodes = {"default:sand", "mcl_core:sand", "mcl_core:redsand"}, 
	neighbors = {"livingdesert:yucca", "default:dry_shrub", "livingdesert:euphoriba_trunk", "mcl_core:deadbush", "mcl_core:cactus"},
	min_light = 0,
	interval = 30,
	chance = 1000, -- 15000
	active_object_count = 1,
	min_height = 0,
	max_height = 100,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:roadrunner", S("Roadrunner"), "aroadrunner.png")
