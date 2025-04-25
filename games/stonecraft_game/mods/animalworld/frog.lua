local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:frog", {
stepheight = 3,
	type = "animal",
	passive = true,
	reach = 1,
	attack_npcs = false,
	damage = 1,
	hp_min = 5,
	hp_max = 25,
	armor = 100,
	collisionbox = {-0.268, -0.01, -0.268,  0.268, 0.25, 0.268},
	visual = "mesh",
	mesh = "Frog.b3d",
	drawtype = "front",
	textures = {
		{"texturefrog.png"},

	},
sounds = {
		random = "animalworld_frog",},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 3,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = true,
	jump_height = 6,
        stay_near = {{"mcl_flowers:waterlily", "naturalbiomes:alderswamp_reed3", "mcl_core:reeds", "naturalbiomes:alderswamp_reed2", "naturalbiomes:alderswamp_reed", "naturalbiomes:alderswamp_yellowflower", "default:grass", "default:grass_2", "default:grass_3"}, 5},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 6,
	animation = {
		speed_normal = 100,
		stand_start = 1,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		fly_start = 250, -- swim animation
		fly_end = 350,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "mcl_core:water_source", "mcl_core:water_flowing"},
	floats = 0,
	follow = {"fishing:bait:worm", "ethereal:worm", "animalworld:ant", "animalworld:termite", "animalworld:cockroach"},
	view_range = 6,
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 15, 25, 0, false, nil) then return end
	end,
})


local spawn_on = "default:sand"

if minetest.get_modpath("ethereal") then
	spawn_on = "ethereal:prairie_dirt", "default:dirt_with_grass", "ethereal:green_dirt"
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:frog",
	nodes = {"mcl_core:dirt_with_grass", "default:dirt_with_grass", "default:dirt_with_rainforest_litter", "naturalbiomes:alderswamp_litter", "naturalbiomes:heath_litter"},
	neighbors = {"naturalbiomes:alderswamp_reed3", "naturalbiomes:alderswamp_reed2", "naturalbiomes:alderswamp_reed", "naturalbiomes:alderswamp_yellowflower", "group:grass", "group:normal_grass", "mcl_flowers:tallgrass", "mcl_flowers:tulip_red", "mcl_flowers:sunflower", "mcl_flowers:poppy", "mcl_core:birchtree", "mcl_trees:tree_birch", "mcl_trees:tree_oak", "mcl_trees:tree_dark_oak", "mcl_core:tree", "mcl_trees:leaves_oak", "mcl_trees:leaves_dark_oak", "mcl_core:leaves", "mcl_core:birchleaves", "mcl_core:darkleaves", "mcl_core:spruceleaves"},
	min_light = 0,
	interval = 60,
	chance = 1000, -- 15000
	active_object_count = 2,
	min_height = -10,
	max_height = 2,
})
end


mobs:register_egg("animalworld:frog", S("Frog"), "afrog.png", 0)


mobs:alias_mob("animalworld:frog", "animalworld:frog") -- compatibility


