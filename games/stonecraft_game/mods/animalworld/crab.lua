local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:crab", {
stepheight = 1,
	type = "animal",
	passive = true,
	reach = 1,
	attack_npcs = false,
	reach = 2,
	damage = 0,
	hp_min = 10,
	hp_max = 40,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4,  0.4, 0.4, 0.4},
	visual = "mesh",
	mesh = "Crab.b3d",
	drawtype = "front",
	textures = {
		{"texturecrab.png"},

	},
	sounds = {
		random = "animalworld_crab",
		attack = "animalworld_crab",
	},
	makes_footstep_sound = false,
	walk_velocity = 0.7,
	run_velocity = 1,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
	jump_height = 6,
        stay_near = {{"default:marram_grass_1", "default:marram_grass_2", "default:marram_grass_3", "livingdesert:date_palm_leaves", "livingdesert:yucca", "default:dry_shrub", "livingdesert:figcactus_trunk", "livingdesert:coldsteppe_grass1", "naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4", "marinara:sand_with_seashells"}, 5},
	drops = {
		{name = "animalworld:raw_athropod", chance = 1, min = 0, max = 2},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 75,
		stand_start = 1,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		punch_start = 200,
		punch_end = 400,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:water_flowing"},
	floats = 0,
	follow = {"animalworld:rawfish", "mcl_mobitems:chicken", "mcl_fishing:pufferfish_raw", "mcl_mobitems:rotten_flesh", "mcl_mobitems:mutton", "mcl_mobitems:beef", "mcl_mobitems:porkchop", "mcl_mobitems:rabbit", "default:marram_grass_2", "default:dry_grass_1", "default:dry_grass_2", "default:dry_grass_3", "default:grass_1", "default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5", "default:marram_grass_1", "default:marram_grass_2", "default:marram_grass_3", "default:coldsteppe_grass_1", "default:coldsteppe_grass_2", "default:coldsteppe_grass_3", "default:coldsteppe_grass_4", "default:coldsteppe_grass_5", "default:coldsteppe_grass_6", "naturalbiomes:savanna_grass1", "naturalbiomes:savanna_grass2", "naturalbiomes:savanna_grass3", "naturalbiomes:outback_grass1", "naturalbiomes:outback_grass2", "naturalbiomes:outback_grass3", "naturalbiomes:outback_grass4", "naturalbiomes:outback_grass5", "naturalbiomes:outback_grass6", "naturalbiomes:med_grass1", "naturalbiomes:med_grass2", "naturalbiomes:heath_grass1", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:alpine_grass1", "naturalbiomes:alpine_grass2", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:", "naturalbiomes:", "naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4", "naturalbiomes:bushland_grass5", "naturalbiomes:bushland_grass6", "naturalbiomes:bushland_grass7", "mobs:meatblock_raw", "animalworld:chicken_raw", "livingfloatlands:ornithischiaraw", "livingfloatlands:largemammalraw", "livingfloatlands:theropodraw", "livingfloatlands:sauropodraw", "animalworld:raw_athropod", "animalworld:whalemeat_raw", "animalworld:rabbit_raw", "nativevillages:chicken_raw", "mobs:meat_raw", "animalworld:pork_raw", "people:mutton:raw", "animalworld:rawmollusk", "marinaramobs:octopus_raw", "marinara:raw_oisters", "marinara:raw_athropod", "animalworld:rawfish", "fishing:fish_raw", "fishing:pike_raw", "marinaramobs:raw_exotic_fish", "nativevillages:catfish_raw", "xocean:fish_edible", "ethereal:fish_raw", "mobs:clownfish_raw", "fishing:bluewhite_raw", "fishing:exoticfish_raw", "fishing:fish_raw", "fishing:carp_raw", "fishing:perch_raw", "water_life:meat_raw", "fishing:shark_raw", "fishing:pike_raw", "animalworld:cockroach", "bees:frame_full", "animalworld:fishfood", "animalworld:ant", "animalworld:termite", "animalworld:bugice", "animalworld:termitequeen", "animalworld:notoptera", "animalworld:anteggs_raw"},
	view_range = 5,
	replace_rate = 10,
	replace_what = {"default:marram_grass_2", "ethereal:fish_raw", "fishing:fish_raw", "xocean:fish_edible", "water_life:meat_raw", "mobs:clownfish_raw"},
	replace_with = "air",
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 15, 25, 0, false, nil) then return end
	end,
})


local spawn_on = "default:sand"

if minetest.get_modpath("ethereal") then
	spawn_on = "default:sand"
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:crab",
	nodes = {"default:sand", "mcl_core:sand", "mcl_core:gravel"},
	neighbors = {"group:grass", "mcl_core:reeds", "group:normal_grass", "mcl_core:dirt_with_grass", "marinara:sand_with_seashells", "marinara:sand_with_seashells_pink", "marinara:sand_with_seashells_orange", "marinara:sand_with_seashells_yellow", "marinara:sand_with_seashells_brown", "marinara:sand_with_seashells_white"},
	min_light = 0,
	interval = 60,
	chance = 500, -- 15000
	active_object_count = 2,
	min_height = 0,
	max_height = 4,
})
end


mobs:register_egg("animalworld:crab", S("Crab"), "acrab.png", 0)


mobs:alias_mob("animalworld:crab", "animalworld:crab") -- compatibility


