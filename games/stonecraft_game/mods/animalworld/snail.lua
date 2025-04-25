local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:snail", {
	stepheight = 3,
	type = "animal",
	passive = true,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 0,
	hp_min = 10,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.3, 0.2},
	visual = "mesh",
	mesh = "Snail.b3d",
	textures = {
		{"texturesnail.png"},
	},
	makes_footstep_sound = true,
	sounds = {
	},
	walk_velocity = 0.2,
	run_velocity = 0.4,
	runaway = false,
        stay_near = {{"farming:cabbage6", "farming:carrot8", "farming:raspberry_4", "farming:cucumber_4", "farming:lettuce_5", "farming:beetroot_5", "flowers:dandelion_yellow", "mcl_flowers:tallgrass", "mcl_flowers:tulip_red", "mcl_flowers:sunflower", "mcl_flowers:poppy"}, 6},
	jump = false,
	jump_height = 3,
	pushable = true,
	follow = {"default:apple", "default:dry_dirt_with_dry_grass", "farming:seed_wheat", "default:junglegrass", "farming:seed_oat", "default:kelp", "seaweed", "xocean:kelp",
		"default:grass", "farming:cucumber", "farming:cabbage", "mcl_farming:beetroot_item", "mcl_farming:carrot_item", "mcl_farming:melon_item", "mcl_farming:potato_item", "mcl_farming:pumpkin_item", "mcl_farming:sweet_berry", "xocean:seagrass", "farming:lettuce", "default:junglegrass"},
	view_range = 5,
	drops = {
		{name = "animalworld:snail", chance = 3, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 25,
		stand_start = 0,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		die_start = 100,
		die_end = 200,
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
	name = "animalworld:snail",
	nodes = {"mcl_core:dirt_with_grass", "default:dirt_with_grass", "mcl_core:dirt_with_grass"},
	neighbors = {"mcl_flowers:tallgrass", "mcl_flowers:tulip_red", "mcl_flowers:sunflower", "mcl_flowers:poppy", "farming:cucumber", "farming:cabbage_6", "farming:lettuce_5", "farming:beetroot_5", "flowers:dandelion_yellow", "farming:strawberry_7", "farming:parsley_3"},
	min_light = 0,
	interval = 30,
	chance = 800, -- 15000
	active_object_count = 3,
	min_height = 6,
	max_height = 40,
})
end

mobs:register_egg("animalworld:snail", S("Snail"), "asnail.png")


mobs:alias_mob("animalworld:snail", "animalworld:snail") -- compatibility

minetest.register_craftitem(":animalworld:escargots", {
	description = S("Escargots"),
	inventory_image = "animalworld_escargots.png",
	on_use = minetest.item_eat(2),
	groups = {food_meat_raw = 1, flammable = 2},
})


minetest.register_craft({
	output = "animalworld:escargots",
	type = "shapeless",
	recipe = 
		{"animalworld:snail", "farming:garlic_clove", "animalworld:butter", "farming:bread"}
})

