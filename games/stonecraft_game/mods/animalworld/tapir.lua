local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:tapir", {
	stepheight = 2,
	type = "animal",
	passive = true,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 2,
	hp_min = 20,
	hp_max = 50,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	mesh = "Tapir.b3d",
	textures = {
		{"texturetapir.png"},
	},
child_texture = {
		{"texturetapirbaby.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "animalworld_tapir",
		damage = "animalworld_tapir",

	},
	walk_velocity = 1,
	run_velocity = 3,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = true,
	jump_height = 3,
	pushable = true,
	follow = {"default:apple", "default:dry_dirt_with_dry_grass", "farming:seed_wheat", "default:junglegrass", "farming:seed_oat", "naturalbiomes:savannagrass", "naturalbiomes:savannagrassmall", "naturalbiomes:savanna_flowergrass", "default:grass_3", "default:dry_grass_3", "ethereal:dry_shrub"},
	view_range = 10,
        stay_near = {{"default:jungletree", "mcl_core:jungletree", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "mcl_trees:leaves_mangrove", "default:junglegrass", "naturalbiomes:bamboo_leaves", "naturalbiomes:bambooforest_groundgrass", "livingjungle::grass2", "livingjungle::grass1", "livingjungle:alocasia", "livingjungle:flamingoflower"}, 5},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	        {name = "mobs:leather", chance = 1, min = 0, max = 2},
	},
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 30,
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
walk_speed = 70,
		walk_start = 200,
		walk_end = 300,
jump_speed = 70,
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


if minetest.get_mapgen_setting("mg_name") ~= "v6" then
	spawn_on = {"default:dry_dirt_with_dry_grass"}
end

if minetest.get_modpath("ethereal") then
	spawn_on = {"default:dry_dirt_with_dry_grass", "ethereal:prairie_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:tapir",
	nodes = {"livingjungle:jungleground", "livingjungle:leafyjungleground", "mcl_core:dirt_with_gras"},
	neighbors = {"default:jungletree", "mcl_trees:tree_jungle", "livingjungle:alocasia", "livingjungle:flamingoflower", "livingjungle:samauma_trunk", "mcl_core:jungletree", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "mcl_trees:leaves_mangrove"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 1,
	max_height = 31000,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:tapir", ("Tapir"), "atapir.png")


mobs:alias_mob("animalworld:tapir", "animalworld:tapir") -- compatibility

