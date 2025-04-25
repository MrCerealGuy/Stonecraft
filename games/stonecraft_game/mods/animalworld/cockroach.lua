local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:cockroach", {
	stepheight = 3,
	type = "animal",
	passive = true,
	attack_type = "dogfight",
	group_attack = false,
	owner_loyal = true,
	reach = 2,
	damage = 1,
	hp_min = 5,
	hp_max = 10,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.2, 0.3, 0.3, 0.2},
	visual = "mesh",
	mesh = "Cockroach.b3d",
textures = {
		{"texturecockroach.png"},
	},
	child_texture = {
		{"texturecockroachbaby.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "animalworld_ant",
		damage = "animalworld_ant",
	},
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = true,
	jump_height = 8,
	pushable = true,
	follow = {"farming:melon_slice", "mcl_farming:beetroot_item", "mcl_farming:carrot_item", "mcl_farming:melon_item", "mcl_farming:potato_item", "mcl_farming:pumpkin_item", "mcl_farming:wheat_item", "mcl_farming:sweet_berry", "farming:pineapple", "ethereal:banana", "ethereal:orange", "farming:grapes", "default:apple", "farming:potato", "ethereal:banana_bread", "farming:carrot", "farming:seed_rice", "farming:corn", "farming:wheat", "farming:beans", "farming:barley", "farming:oat", "farming:rye", "mobs:cheese", "farming:bread", "ethereal:banana_bread", "ethereal:banana", "farming:cabbage", "farming:lettuce", "farming:melon_slice", "naturalbiomes:coconut", "naturalbiomes:banana", "mobs:meatblock_raw", "animalworld:chicken_raw", "livingfloatlands:ornithischiaraw", "livingfloatlands:largemammalraw", "livingfloatlands:theropodraw", "livingfloatlands:sauropodraw", "animalworld:raw_athropod", "animalworld:whalemeat_raw", "animalworld:rabbit_raw", "nativevillages:chicken_raw", "mobs:meat_raw", "animalworld:pork_raw", "people:mutton:raw"},
	view_range = 2,
        stay_near = {{"default:jungletree", "default:junglegrass", "livingjungle::grass2", "livingjungle::grass1", "livingjungle:alocasia", "livingjungle:flamingoflower"}, 5},
	drops = {
		{name = "animalworld:cockroach", chance = 1, min = 1, max = 1},
	},
	water_damage = 2,
	lava_damage = 5,
        air_damage = 0,
	light_damage = 0,
	fear_height = 4,
	animation = {
		speed_normal = 100,
		stand_start = 0,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		jump_start = 220,
		jump_end = 330,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 25, 0, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:cockroach",
	nodes = {"livingjungle:jungleground", "livingjungle:leafyjungleground", "mcl_core:dirt_with_gras"},
	neighbors = {"livingjungle:samauma_trunk", "mcl_trees:tree_jungle", "livingjungle:liana_stem", "livingjungle:alocasia", "livingjungle:flamingoflower", "mcl_core:jungletree", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "mcl_trees:leaves_mangrove"},
	min_light = 0,
	interval = 30,
	chance = 1000, -- 15000
	active_object_count = 3,
	min_height = 5,
	max_height = 31000,
	day_toggle = false,
})
end

mobs:register_egg("animalworld:cockroach", S("Cockroach"), "acockroach.png")


mobs:alias_mob("animalworld:cockroach", "animalworld:cockroach") -- compatibility

minetest.register_craftitem(":animalworld:roastroach", {
	description = S("Roasted Cockroach"),
	inventory_image = "animalworld_roastroach.png",
	on_use = minetest.item_eat(2),
	groups = {food_meat_raw = 1, flammable = 2},
})


minetest.register_craft({
	output = "animalworld:roastroach",
	type = "shapeless",
	recipe = 
		{"animalworld:cockroach", "default:torch"}
})



