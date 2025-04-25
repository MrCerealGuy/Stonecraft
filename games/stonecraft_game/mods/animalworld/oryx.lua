local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:oryx", {
	stepheight = 2,
	type = "animal",
	passive = true,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 2,
	hp_min = 40,
	hp_max = 70,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 1.2, 0.5},
	visual = "mesh",
	mesh = "Oryx.b3d",
	textures = {
		{"textureoryx.png"},
	},
	child_texture = {
		{"textureoryxbaby.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "animalworld_gnu",

	},
	walk_velocity = 1,
	run_velocity = 4,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = true,
	jump_height = 3,
        stay_near = {{"livingdesert:date_palm_leaves", "mcl_core:deadbush", "mcl_core:cactus", "livingdesert:yucca", "default:dry_shrub", "livingdesert:figcactus_trunk", "livingdesert:coldsteppe_grass1", "livingdesert:cactus", "livingdesert:cactus3", "livingdesert:cactus2", "livingdesert:cactus4"}, 5},
	follow = {"default:dry_dirt_with_dry_grass", "mcl_flowers:tallgrass", "mcl_core:deadbush", "mcl_bamboo:bamboo", "farming:seed_wheat", "default:junglegrass", "farming:seed_oat", "default:apple", "default:dry_dirt_with_dry_grass", "farming:seed_wheat", "default:junglegrass", "farming:seed_oat", "naturalbiomes:savannagrass", "naturalbiomes:savannagrassmall", "naturalbiomes:savanna_flowergrass", "default:grass_3", "default:dry_grass_3", "ethereal:dry_shrub", "default:dry_shrub", "default:dry_grass_1", "default:dry_grass_2", "default:dry_grass_3", "default:grass_1", "default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5", "default:marram_grass_1", "default:marram_grass_2", "default:marram_grass_3", "default:coldsteppe_grass_1", "default:coldsteppe_grass_2", "default:coldsteppe_grass_3", "default:coldsteppe_grass_4", "default:coldsteppe_grass_5", "default:coldsteppe_grass_6", "naturalbiomes:savanna_grass1", "naturalbiomes:savanna_grass2", "naturalbiomes:savanna_grass3", "naturalbiomes:outback_grass1", "naturalbiomes:outback_grass2", "naturalbiomes:outback_grass3", "naturalbiomes:outback_grass4", "naturalbiomes:outback_grass5", "naturalbiomes:outback_grass6", "naturalbiomes:med_grass1", "naturalbiomes:med_grass2", "naturalbiomes:heath_grass1", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:alpine_grass1", "naturalbiomes:alpine_grass2", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:", "naturalbiomes:", "naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4", "naturalbiomes:bushland_grass5", "naturalbiomes:bushland_grass6", "naturalbiomes:bushland_grass7", "group:grass", "group:normal_grass"},
	view_range = 10,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
		{name = "mobs:leather", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3,
        pushable = true,
	animation = {
		speed_normal = 60,
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		walk_start = 200,
		walk_end = 300,
		jump_start = 300,
		jump_end = 400,
		die_start = 300,
		die_end = 400,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 25, false, nil) then return end
	end,
})

local spawn_on = {"default:dry_dirt_with_dry_grass"}

if minetest.get_mapgen_setting("mg_name") ~= "v6" then
	spawn_on = {"default:dry_dirt_with_dry_grass"}
end

if minetest.get_modpath("ethereal") then
	spawn_on = {"default:dry_dirt_with_dry_grass", "ethereal:prairie_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:oryx",
	nodes = {"default:sand", "mcl_core:sand", "mcl_core:redsand"}, 
	neighbors = {"livingdesert:yucca", "default:dry_shrub", "livingdesert:euphoriba_trunk", "mcl_core:deadbush", "mcl_core:cactus"},
	min_light = 0,
	interval = 30,
	chance = 2000, -- 15000
	active_object_count = 3,
	min_height = 10,
	max_height = 50,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:oryx", S("Oryx"), "aoryx.png")


mobs:alias_mob("animalworld:oryx", "animalworld:oryx") -- compatibility

