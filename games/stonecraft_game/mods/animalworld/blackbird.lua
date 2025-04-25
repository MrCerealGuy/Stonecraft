local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:blackbird", {
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
	mesh = "Blackbird.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"textureblackbird.png"},
	},
	sounds = {
		random = "animalworld_blackbird",
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 4,
	runaway = true,
	fall_speed = -1,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = true,
        jump_height = 4,
        stay_near = {{"default:tree", "default:leaves", "flowers_dandelion_yellow", "default:bush_leaves", "default:grass_1", "naturalbiomes:heath_grass", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:heatherflower", "naturalbiomes:heatherflower2", "naturalbiomes:heatherflower3"}, 6},
	drops = {
		{name = "animalworld:chicken_raw", chance = 1, min = 1, max = 1},
	        {name = "animalworld:chicken_feather", chance = 1, min = 1, max = 1},
		{name = "animalworld:blackbirdcorpse", chance = 7, min = 1, max = 1},
	
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 4,
	animation = {
		speed_normal = 100,
		stand_start = 100,
		stand_end = 200,
		walk_start = 0,
		walk_end = 100,
		fly_start = 250, 
		fly_end = 350,
		jump_start = 250, 
		jump_end = 350,
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
		"fishing:bait:worm", "farming:seed_wheat", "farming:seed_rice", "farming:seed_oat", "ethereal:pine_nuts", "ethereal:worm", "naturalbiomes:blackberry", "animalworld:bugice", "animalworld:termitequeen", "animalworld:notoptera", "animalworld:anteggs_raw", "farming:seed_hemp", "farming:seed_barley", "farming:seed_oat", "farming:seed_cotton", "farming:seed_sunflower", "farming:seed_wheat", "farming:seed_rye"
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
	name = "animalworld:blackbird",
	nodes = {"mcl_core:dirt_with_grass", "default:dirt_with_grass", "naturalbiomes:heath_litter"},
	neighbors = {"group:grass", "group:normal_grass", "naturalbiomes:heath_grass", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:heatherflower"}, 
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 0,
	max_height = 100,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:blackbird", S("Blackbird"), "ablackbird.png")
