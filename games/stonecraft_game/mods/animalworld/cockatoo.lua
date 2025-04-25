local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:cockatoo", {
stepheight = 3,
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = false,
	reach = 2,
        damage = 2,
	hp_min = 10,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.3, 0.3},
	visual = "mesh",
	mesh = "Cockatoo.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturecockatoo.png"},
	},
	sounds = {
		attack = "animalworld_cockatoo3",
		random = "animalworld_cockatoo",
		damage = "animalworld_cockatoo2",
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 4,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = true,
        jump_height = 6,
	stepheight = 3,
        stay_near = {{"naturalbiomes:outback_leaves", "naturalbiomes:outback_trunk", "naturalbiomes:outback_bush_leaves", "livingdesert:cactus", "livingdesert:cactus3", "livingdesert:cactus2", "livingdesert:cactus4"}, 5},
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
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		walk_start = 200,
		walk_end = 300,
		fly_start = 350, -- swim animation
		fly_end = 450,
		punch_start = 100,
		punch_end = 200,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

fly_in = {"air"},
	floats = 0,
	follow = {
		"farming:melon_slice", "mcl_farming:beetroot_item", "mcl_farming:carrot_item", "mcl_farming:melon_item", "mcl_farming:potato_item", "mcl_farming:pumpkin_item", "mcl_farming:wheat_item", "mcl_farming:sweet_berry", "farming:pineapple", "ethereal:banana", "ethereal:orange", "farming:grapes", "default:apple", "farming:potato", "ethereal:banana_bread", "farming:carrot", "farming:seed_rice", "farming:corn", "farming:wheat", "farming:beans", "farming:barley", "farming:oat", "farming:rye", "mobs:cheese", "farming:bread", "ethereal:banana_bread", "ethereal:banana", "farming:cabbage", "farming:lettuce", "farming:melon_slice", "naturalbiomes:coconut", "naturalbiomes:banana", "livingdesert:date_palm_fruits", "livingdesert:figcactus_fruit"
	},
	
view_range = 4,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 15, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:cockatoo",
	nodes = {"naturalbiomes:outback_litter", "mcl_core:dirt_with_grass", "mcl_core:acaciatree", "mcl_trees:tree_acacia"}, 
	neighbors = {"naturalbiomes:outback_trunk", "naturalbiomes:outback_bush_leaves", "naturalbiomes:outback_leaves", "mcl_trees:leaves_acacia",  "mcl_core:acacialeaves"},
	min_light = 0,
	interval = 60,
	chance = 800, -- 15000
	active_object_count = 2,
	min_height = 5,
	max_height = 31000,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:cockatoo", S("Cockatoo"), "acockatoo.png")