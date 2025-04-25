local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:notoptera", {
	stepheight = 2,
	type = "animal",
	passive = true,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	reach = 2,
	damage = 1,
	hp_min = 20,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.2, 0.3, 0.3, 0.2},
	visual = "mesh",
	mesh = "Notoptera.b3d",
	textures = {
		{"texturenotoptera.png"},
	},
	makes_footstep_sound = true,
	sounds = {
	},
	walk_velocity = 0.5,
	run_velocity = 1,
        walk_chance = 50,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = true,
	jump_height = 6,
	pushable = true,
        stay_near = {{"default:pine_needles", "mcl_flowers:double:fern", "mcl_flowers:tallgrass", "animalworld:animalworld_tundrashrub5", "animalworld:animalworld_tundrashrub1", "animalworld:animalworld_tundrashrub2", "animalworld:animalworld_tundrashrub3", "animalworld:animalworld_tundrashrub4"}, 4},
	follow = {"default:junglegrass", "mcl_flowers:tallgrass", "default:dry_shrub", "default:blueberry_bush_leaves", "default:grass", "farming:cabbage_6", "farming:lettuce_5", "farming:beetroot_5", "flowers:dandelion_yellow"},
	view_range = 5,
	drops = {
		{name = "animalworld:notoptera", chance = 1, min = 1, max = 1},
	},
	floats = 0,
	water_damage = 2,
	lava_damage = 5,
        air_damage = 0,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 100,
		stand_start = 0,
		stand_end = 100,
		stand2_start = 100,
		stan2d_end = 200,
		walk_start = 200,
		walk_end = 300,
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
	name = "animalworld:notoptera",
	nodes = {"default:permafrost", "default:permafrost_with_moss", "mcl_core:snow"},
	neighbors = {"animalworld:animalworld_tundrashrub1", "mcl_core:sprucetree", "animalworld:animalworld_tundrashrub2", "animalworld:animalworld_tundrashrub3", "animalworld:animalworld_tundrashrub4"},
	min_light = 0,
	interval = 30,
	chance = 1000, -- 15000
	active_object_count = 4,
	min_height = 5,
	max_height = 60,
	day_toggle = true,
})
end

mobs:register_egg("animalworld:notoptera", S("Notoptera"), "anotoptera.png")


mobs:alias_mob("animalworld:notoptera", "animalworld:notoptera") -- compatibility

minetest.register_craftitem(":animalworld:bugice", {
	description = S("Bug on Ice"),
	inventory_image = "animalworld_bugice.png",
	on_use = minetest.item_eat(2),
	groups = {food_meat_raw = 1, flammable = 2},
})


minetest.register_craft({
	output = "animalworld:bugice",
	type = "shapeless",
	recipe = 
		{"animalworld:notoptera", "default:snow"}
})



