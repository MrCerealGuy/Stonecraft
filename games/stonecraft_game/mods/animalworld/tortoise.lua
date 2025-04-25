local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:tortoise", {
stepheight = 1,
	type = "animal",
	passive = false,
	reach = 1,
	attack_npcs = true,
	owner_loyal = true,
	reach = 2,
	damage = 0,
	hp_min = 45,
	hp_max = 250,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3,  0.3, 0.4, 0.3},
	visual = "mesh",
	mesh = "Tortoise.b3d",
	drawtype = "front",
	textures = {
		{"texturetortoise.png"},

	},
	sounds = {},
	makes_footstep_sound = false,
	walk_velocity = 0.2,
	run_velocity = 0.3,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
	jump_height = 6,
        stay_near = {{"default:marram_grass_1", "mcl_core:dirt_with_grass", "default:marram_grass_2", "default:marram_grass_3", "livingdesert:date_palm_leaves", "livingdesert:yucca", "default:dry_shrub", "livingdesert:figcactus_trunk", "livingdesert:coldsteppe_grass1", "naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4"}, 6},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 30,
		stand_start = 1,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		walk_start = 200,
		walk_end = 300,
		punch_start = 300,
		punch_end = 400,
		die_start = 300,
		die_end = 400,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	follow = {"farming:carrot", "farming_plus:carrot_item", "default:marram_grass_2", "farming:tomato", "farming:lettuce", "farming:cucumber", "farming:cabbage"},
	view_range = 4,
	replace_rate = 10,
	replace_what = {"farming:carrot_7", "mcl_fishing:pufferfish_raw", "farming:carrot_8", "farming_plus:carrot", "farming:tomato", "farming:lettuce", "farming:cucumber", "farming:cabbage", "livingdesert:date_palm_fruits", "livingdesert:figcactus_fruit"},
	replace_with = "air",
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 55, 75, 0, false, nil) then return end
	end,
})


local spawn_on = "default:sand"

if minetest.get_modpath("ethereal") then
	spawn_on = "ethereal:prairie_dirt"
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:tortoise",
	nodes = {"default:sand", "mcl_core:sand", "naturalbiomes:mediterran_litter", "naturalbiomes:bushland_bushlandlitter"},
	neighbors = {"naturalbiomes:bushland_grass", "mcl_flowers:tallgrass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4", "livingdesert:date_palm_leaves", "livingdesert:yucca", "default:dry_shrub", "livingdesert:figcactus_trunk", "livingdesert:coldsteppe_grass1", "livingdesert:cactus", "livingdesert:cactus3", "livingdesert:cactus2", "livingdesert:cactus4", "default:cactus", "naturalbiomes:med_flower2", "naturalbiomes:med_grass1", "naturalbiomes:med_grass2", "naturalbiomes:med_flower3", "group:grass", "group:normal_grass"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	min_height = 5,
	max_height = 70,
	day_toggle = true,
})
end


mobs:register_egg("animalworld:tortoise", S("Tortoise"), "atortoise.png", 0)


mobs:alias_mob("animalworld:tortoise", "animalworld:tortoise") -- compatibility


