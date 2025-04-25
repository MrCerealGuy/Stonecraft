local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:clamydosaurus", {
stepheight = 3,
	type = "animal",
	passive = true,
	reach = 1,
	attack_npcs = false,
	damage = 1,
	hp_min = 10,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.268, -0.01, -0.268,  0.268, 0.25, 0.268},
	visual = "mesh",
	mesh = "Clamydosaurus.b3d",
	drawtype = "front",
	textures = {
		{"textureclamydosaurus.png"},

	},
sounds = {
		random = "animalworld_monitor",},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 4,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = true,
	jump_height = 6,
        stepheight = 5,
        stay_near = {{"naturalbiomes:outback_rock", "mcl_core:deadbush", "mcl_core:cactus", "naturalbiomes:outback_trunk", "naturalbiomes:outback_bush_leaves", "livingdesert:cactus", "livingdesert:cactus3", "livingdesert:cactus2", "livingdesert:cactus4"}, 5},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	        {name = "mobs:leather", chance = 1, min = 0, max = 2},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 6,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		walk_speed = 150,
		walk_start = 250,
		walk_end = 350,
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
	follow = {"animalworld:cockroach", "bees:frame_full", "animalworld:fishfood", "animalworld:ant", "animalworld:termite", "animalworld:bugice", "animalworld:termitequeen", "animalworld:notoptera", "animalworld:anteggs_raw"},
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
	name = "animalworld:clamydosaurus",
	nodes = {"naturalbiomes:outback_litter", "mcl_core:sand", "mcl_core:redsand"}, 
	neighbors = {"naturalbiomes:outback_rock", "naturalbiomes:outback_trunk", "naturalbiomes:outback_bush_leaves", "mcl_core:deadbush", "mcl_core:cactus"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 2,
	max_height = 50,
})
end


mobs:register_egg("animalworld:clamydosaurus", S("Clamydosaurus"), "aclamydosaurus.png", 0)


mobs:alias_mob("animalworld:clamydosaurus", "animalworld:clamdydosaurus") -- compatibility

