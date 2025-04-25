local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:robin", {
stepheight = 5,
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = false,
	reach = 2,
        damage = 2,
	hp_min = 5,
	hp_max = 30,
	armor = 100,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "Robin.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturerobin.png"},
	},
	sounds = {
		random = "animalworld_robin",
		damage = "animalworld_robin2",
		death = "animalworld_robin3",
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 4,
	fall_speed = -1,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = true,
        jump_height = 4,
	drops = {
		{name = "animalworld:chicken_raw", chance = 1, min = 0, max = 1},
	        {name = "animalworld:chicken_feather", chance = 1, min = 0, max = 1},
	
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 6,
        stay_near = {{"naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4", "naturalbiomes:bushland_wildrose_leaves", "naturalbiomes:bushland_wildrose_leaves2", "naturalbiomes:bushland_hazelnut_leaves", "naturalbiomes:bushland_hazelnut_leaves2"}, 5},
	animation = {
		speed_normal = 100,
		stand_start = 0,
		stand_end = 100,
		stand2_start = 100,
		stand2_end = 200,
		stand3_start = 200,
		stand3_end = 300,
		walk_speed = 150,
		walk_start = 300,
		walk_end = 400,
		fly_start = 420, 
		fly_end = 520,
		jump_start = 420, 
		jump_end = 520,
		die_start = 420,
		die_end = 520,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

fly_in = {"air"},
	floats = 0,
	follow = {
		"fishing:bait:worm", "farming:seed_wheat", "mcl_farming:wheat_seeds", "farming:seed_rice", "farming:seed_oat", "ethereal:pine_nuts", "ethereal:worm", "naturalbiomes:blackberry", "naturalbiomes:wildrose"
	},
	
view_range = 4,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 15, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:robin",
	nodes = {"naturalbiomes:bushland_bushlandlitter", "mcl_core:dirt_with_grass"}, 
	neighbors = {"naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4", "naturalbiomes:bushland_wildrose_leaves", "naturalbiomes:bushland_wildrose_leaves2", "naturalbiomes:bushland_hazelnut_leaves", "naturalbiomes:bushland_hazelnut_leaves2", "mcl_flowers:tallgrass", "mcl_flowers:tulip_red", "mcl_flowers:sunflower", "mcl_flowers:poppy", "mcl_core:birchtree", "mcl_trees:tree_birch", "mcl_trees:tree_oak", "mcl_trees:tree_dark_oak", "mcl_core:tree", "mcl_trees:leaves_oak", "mcl_trees:leaves_dark_oak", "mcl_core:leaves", "mcl_core:birchleaves", "mcl_core:darkleaves", "mcl_core:spruceleaves"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 0,
	max_height = 100,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:robin", S("Robin"), "arobin.png")
