local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:toucan", {
stepheight = 6,
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = false,
	reach = 2,
        damage = 1,
	hp_min = 5,
	hp_max = 30,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.5, 0.3},
	visual = "mesh",
	mesh = "Toucan.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturetoucan.png"},
	},
	sounds = {
		random = "animalworld_toucan",
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 4,
	fall_speed = -1,
	fall_damage = 0,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = true,
        jump_height = 4,
	stepheight = 6,
        stay_near = {{"default:acacia_tree", "mcl_core:jungletree", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "mcl_trees:leaves_mangrove", "default:acacia_leaves", "default:jungleleaves", "default:jungletree", "livingjungle:samauma_trunk", "livingjungle:samauma_leaves"}, 5},
	drops = {
		{name = "animalworld:chicken_raw", chance = 1, min = 1, max = 1},
	        {name = "animalworld:chicken_feather", chance = 1, min = 1, max = 1},
	
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 10,
	animation = {
		speed_normal = 100,
		stand_speed = 50,
		stand_start = 0,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		fly_start = 250, -- swim animation
		fly_end = 350,
		jump_start = 250, -- swim animation
		jump_end = 350,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

fly_in = {"air"},
	floats = 0,
	follow = {
		"fishing:bait:worm", "mcl_farming:beetroot_item", "mcl_farming:carrot_item", "mcl_farming:melon_item", "mcl_farming:potato_item", "mcl_farming:pumpkin_item", "mcl_farming:wheat_item", "mcl_farming:sweet_berry", "ethereal:worm", "farming:melon_slice", "farming:pineapple", "ethereal:banana", "ethereal:orange", "farming:grapes", "livingdesert:date_palm_fruits", "livingdesert:figcactus_fruit", "animalworld:cockroach", "bees:frame_full", "animalworld:fishfood", "animalworld:ant", "animalworld:termite", "animalworld:bugice", "animalworld:termitequeen", "animalworld:notoptera", "animalworld:anteggs_raw"
	},
	
view_range = 4,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 15, 25, 0, false, nil) then return end
	end,
})


if minetest.get_modpath("ethereal") then
	spawn_on = {"mcl_core:podzol", "default:dirt_withforest_litter", "ethereal:grove_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:toucan",
	nodes = {"mcl_core:dirt_with_gras", "default:dirt_with_rainforest_litter", "livingjungle:jungleground", "livingjungle:leafyjungleground"},
	neighbors = {"default:jungletree", "default:jungleleaves", "mcl_core:jungletree", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "mcl_trees:leaves_mangrove", "livingjungle:alocasia", "livingjungle:flamingoflower", "livingjungle:samauma_trunk"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 15,
	max_height = 50,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:toucan", S("Toucan"), "atoucan.png")

