local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:moose", {
	stepheight = 1,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 7,
        knock_back = false,
	hp_min = 25,
	hp_max = 60,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 1.7, 0.5},
	visual = "mesh",
	mesh = "Moose.b3d",
	textures = {
		{"texturemoose.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "animalworld_moose",
		attack = "animalworld_moose",
	},
	walk_velocity = 1,
	run_velocity = 3,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
	jump_height = 3,
	pushable = true,
        stay_near = {{"default:tree", "mcl_flowers:double:fern", "mcl_flowers:fern", "mcl_flowers:tallgrass", "mcl_farming:sweet_berry_bush_3", "mcl_core:sprucetree", "mcl_trees:tree_spruce", "mcl_trees:leaves_spruce", "default:fern_1", "default:fern_2", "marinara:reed_bundle", "naturalbiomes:reed_bundle", "default:leaves"}, 6},
	follow = {"default:apple", "mcl_farming:beetroot_item", "mcl_farming:carrot_item", "mcl_farming:melon_item", "mcl_farming:potato_item", "mcl_farming:pumpkin_item", "mcl_farming:wheat_item", "mcl_farming:sweet_berry", "farming:potato", "farming:melon_slice", "farming:cucumber", "farming:cabbage", "farming:lettuce", "farming:bread", "default:dry_grass_1", "default:dry_grass_2", "default:dry_grass_3", "default:grass_1", "default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5", "default:marram_grass_1", "default:marram_grass_2", "default:marram_grass_3", "default:coldsteppe_grass_1", "default:coldsteppe_grass_2", "default:coldsteppe_grass_3", "default:coldsteppe_grass_4", "default:coldsteppe_grass_5", "default:coldsteppe_grass_6", "naturalbiomes:savanna_grass1", "naturalbiomes:savanna_grass2", "naturalbiomes:savanna_grass3", "naturalbiomes:outback_grass1", "naturalbiomes:outback_grass2", "naturalbiomes:outback_grass3", "naturalbiomes:outback_grass4", "naturalbiomes:outback_grass5", "naturalbiomes:outback_grass6", "naturalbiomes:med_grass1", "naturalbiomes:med_grass2", "naturalbiomes:heath_grass1", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:alpine_grass1", "naturalbiomes:alpine_grass2", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:", "naturalbiomes:", "naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4", "naturalbiomes:bushland_grass5", "naturalbiomes:bushland_grass6", "naturalbiomes:bushland_grass7", "group:grass", "group:normal_grass"},
	view_range = 10,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	        {name = "mobs:leather", chance = 1, min = 0, max = 2},
		{name = "animalworld:moosecorpse", chance = 7, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
                stand1_start = 300,
		stand1_end = 400,
		walk_start = 100,
		walk_end = 200,
		jump_start = 400,
		jump_end = 500,
		punch_start = 200,
		punch_end = 300,
		die_start = 200,
		die_end = 300,
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
	spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_dry_grass", "default:dry_dirt_with_dry_grass"}
end

if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:grass_grove", "default:dirt_with_grass", "default:dirt_with_coniferous_litter"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:moose",
	nodes = {"mcl_core:dirt_with_grass", "default:dirt_with_grass", "default:dirt_with_coniferous_litter", "mcl_core:dirt_with_grass", "mcl_core:podzol"},
	neighbors = {"group:grass", "group:normal_grass", "default:fern_1", "default:fern_2", "mcl_flowers:double:fern", "mcl_flowers:fern", "mcl_flowers:tallgrass", "mcl_farming:sweet_berry_bush_3", "mcl_core:sprucetree", "mcl_trees:tree_spruce", "mcl_trees:leaves_spruce"}, 
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	min_height = 0,
	max_height = 120,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:moose", S("Moose"), "amoose.png")


mobs:alias_mob("animalworld:moose", "animalworld:moose") -- compatibility

