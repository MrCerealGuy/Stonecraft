local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:goose", {
stepheight = 6,
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = false,
	owner_loyal = true,
	reach = 2,
        damage = 1,
	hp_min = 15,
	hp_max = 30,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.5, 0.3},
	visual = "mesh",
	mesh = "Goose.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturegoose.png"},
	},
	sounds = {
		attack = "animalworld_goose2",
		random = "animalworld_goose",
		damage = "animalworld_goose3",
	},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 3,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = true,
        jump_height = 6,
	stepheight = 1,
        stay_near = {{"naturalbiomes:alderswamp_reed3", "naturalbiomes:alderswamp_reed2", "naturalbiomes:alderswamp_reed", "naturalbiomes:alderswamp_yellowflower", "naturalbiomes:waterlily"}, 5},
	drops = {
		{name = "animalworld:chicken_raw", chance = 1, min = 1, max = 1},
	        {name = "animalworld:chicken_feather", chance = 1, min = 1, max = 1},
	
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 60,
		stand_speed = 30,
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		stand2_start = 200,
		stand2_end = 300,
		walk_start = 300,
		walk_end = 400,
		fly_start = 450, -- swim animation
		fly_end = 550,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "mcl_core:water_source", "mcl_core:water_flowing"},
	floats = 1,
	follow = {
		"default:dry_dirt_with_dry_grass", "mcl_flowers:tallgrass", "mcl_core:deadbush", "mcl_bamboo:bamboo", "farming:seed_wheat", "default:junglegrass", "farming:seed_oat", "naturalbiomes:savannagrass", "naturalbiomes:savannagrassmall", "naturalbiomes:alderswamp_reed", "naturalbiomes:alderswamp_reed2", "naturalbiomes:alderswamp_reed3", "farming:lettuce", "farming:cabbage", "ethereal:snowygrass", "default:dry_grass_1", "default:dry_grass_2", "default:dry_grass_3", "default:grass_1", "default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5", "default:marram_grass_1", "default:marram_grass_2", "default:marram_grass_3", "default:coldsteppe_grass_1", "default:coldsteppe_grass_2", "default:coldsteppe_grass_3", "default:coldsteppe_grass_4", "default:coldsteppe_grass_5", "default:coldsteppe_grass_6", "naturalbiomes:savanna_grass1", "naturalbiomes:savanna_grass2", "naturalbiomes:savanna_grass3", "naturalbiomes:outback_grass1", "naturalbiomes:outback_grass2", "naturalbiomes:outback_grass3", "naturalbiomes:outback_grass4", "naturalbiomes:outback_grass5", "naturalbiomes:outback_grass6", "naturalbiomes:med_grass1", "naturalbiomes:med_grass2", "naturalbiomes:heath_grass1", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:alpine_grass1", "naturalbiomes:alpine_grass2", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:", "naturalbiomes:", "naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4", "naturalbiomes:bushland_grass5", "naturalbiomes:bushland_grass6", "naturalbiomes:bushland_grass7", "group:grass", "group:normal_grass"
	},
	
view_range = 5,

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
	name = "animalworld:goose",
	nodes = {"naturalbiomes:alderswamp_litter", "default:permafrost", "mcl_core:dirt_with_grass"},
	neighbors = {"naturalbiomes:alderswamp_reed3", "naturalbiomes:alderswamp_reed2", "naturalbiomes:alderswamp_reed", "mcl_flowers:waterlily", "mcl_ocean:seagrass:sand", "mcl_core:reeds", "naturalbiomes:alderswamp_yellowflower", "group:grass", "group:normal_grass", "animalworld:animalworld_tundrashrub1", "animalworld:animalworld_tundrashrub2"},
	min_light = 0,
	interval = 60,
	chance = 1000, -- 15000
	active_object_count = 4,
	min_height = -1,
	max_height = 3,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:goose", S("Goose"), "agoose.png")

