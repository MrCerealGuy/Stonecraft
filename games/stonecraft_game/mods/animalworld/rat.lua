local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:rat", {
	type = "animal",
	stepheight = 3,
	passive = false,
	attack_type = "dogfight",
	attack_npcs = false,
	group_attack = true,
	reach = 2,
	damage = 3,
	hp_min = 5,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 0.6, 0.4},
	visual = "mesh",
	mesh = "Rat.b3d",
	textures = {
		{"texturerat.png"},
		{"texturerat.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "animalworld_rat",
		attack = "animalworld_rat",
	},
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	jump_height = 6,
	pushable = true,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 3},

	},
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 6,
	animation = {
		stand_start = 0,
		stand_end = 100,
		stand_speed = 50,
		walk_start = 100,
		walk_end = 200,
		walk_speed = 130,
		punch_start = 250,
		punch_end = 350,
		punch_speed = 125,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	follow = {"farming:wheat", "farming:beans", "farming:barley", "farming:oat", "farming:rye", "mobs:cheese", "farming:bread", "ethereal:banana_bread", "animalworld:cockroach", "farming:baked_potato", "farming:sunflower_bread", "farming:pumpkin_bread", "farming:garlic_bread", "farming:tomato_soup", "pie:brpd_0", "farming:bread", "farming:bread_multigrain", "farming:spanish_potatoes", "farming:beetroot_soup", "farming:blueberry_pie", "farming:porridge", "farming:bibimbap", "farming:burger", "farming:paella", "farming:mac_and_cheese", "livingcaves:healingsoup", "farming:spaghetti", "animalworld:escargots", "farming:rhubarb_pie", "farming:potato_omlet", "farming:potato_salad", "farming:corn_cob", "farming:seed_hemp", "farming:seed_barley", "farming:seed_oat", "farming:seed_cotton", "farming:seed_sunflower", "farming:seed_wheat", "farming:seed_rye", "naturalbiomes:coconut", "naturalbiomes:coconut_slice", "naturalbiomes:hazelnut", "naturalbiomes:hazelnut_cracked", "farming:sunflower_seeds_toasted", "livingfloatlands:roasted_pine_nuts", "livingfloatlands:giantforest_oaknut", "mcl_farming:wheat_seeds", "livingfloatlands:giantforest_oaknut_cracked", "livingfloatlands:coldsteppe_pine3_pinecone", "livingfloatlands:coldsteppe_pine_pinecone", "livingfloatlands:coldsteppe_pine2_pinecone"},
	view_range = 10,

})

if minetest.get_modpath("ethereal") then
	spawn_on = {"default:stone", "default:mossycobble", "ethereal:dry_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:rat",
	nodes = {"mcl_core:stone", "default:stone", "default:mossycobble", "default:dirt", "mcl_core:stone", "mcl_core:granite"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = -100,
	max_height = 0,

})
end


mobs:register_egg("animalworld:rat", S("Rat"), "arat.png")


mobs:alias_mob("animalworld:rat", "animalworld:rat") -- compatibility

-- cooked rat, yummy!
minetest.register_craftitem(":animalworld:rat_cooked", {
	description = S("Cooked Rodent Meat"),
	inventory_image = "animalworld_cooked_rat.png",
	on_use = minetest.item_eat(3),
	groups = {food_rat = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "animalworld:rat_cooked",
	recipe = "animalworld:rat",
	cooktime = 5,
})


