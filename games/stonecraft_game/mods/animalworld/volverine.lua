local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:volverine", {
stepheight = 3,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 2,
        damage = 12,
	hp_min = 15,
	hp_max = 45,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 0.5, 0.4},
	visual = "mesh",
	mesh = "Volverine.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturevolverine.png"},
	},
	sounds = {
		random = "animalworld_volverine",
	},
	makes_footstep_sound = true,
	walk_velocity = 3,
	run_velocity = 4,
	runaway = false,
	jump = true,
        jump_height = 6,
	stepheight = 3,
        stay_near = {{"default:pine_needles", "mcl_flowers:double:fern", "mcl_flowers:fern", "mcl_flowers:tallgrass", "mcl_farming:sweet_berry_bush_3", "mcl_core:sprucetree", "mcl_trees:tree_spruce", "mcl_trees:leaves_spruce", "animalworld:animalworld_tundrashrub5", "animalworld:animalworld_tundrashrub1", "animalworld:animalworld_tundrashrub2", "animalworld:animalworld_tundrashrub3", "animalworld:animalworld_tundrashrub4"}, 6},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
		{name = "mobs:leather", chance = 1, min = 0, max = 2},
		{name = "animalworld:wolverinecorpse", chance = 7, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 6,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		walk_speed = 125,
		walk_start = 100,
		walk_end = 200,
		punch_speed = 100,
		punch_start = 200,
		punch_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

	follow = {
		"animalworld:rawfish", "mcl_mobitems:chicken", "mcl_fishing:pufferfish_raw", "mcl_mobitems:rotten_flesh", "mcl_mobitems:mutton", "mcl_mobitems:beef", "mcl_mobitems:porkchop", "mcl_mobitems:rabbit", "mobs:meat_raw", "animalworld:rabbit_raw", "animalworld:chicken_raw", "water_life:meat_raw", "mobs:meatblock_raw", "animalworld:chicken_raw", "livingfloatlands:ornithischiaraw", "livingfloatlands:largemammalraw", "livingfloatlands:theropodraw", "livingfloatlands:sauropodraw", "animalworld:raw_athropod", "animalworld:whalemeat_raw", "animalworld:rabbit_raw", "nativevillages:chicken_raw", "mobs:meat_raw", "animalworld:pork_raw", "people:mutton:raw"
	},
	view_range = 10,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

if minetest.get_modpath("ethereal") then
	spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_snow"}, {"default:permafrost_with_moss"}, {"default:snowblock"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:volverine",
	nodes = {"default:dirt_with_snow"}, {"default:permafrost_with_moss"}, {"default:snowblock"}, {"default:snow"}, {"mcl_core:snow"},
	neighbors = {"default:pine_needles", "mcl_core:sprucetree", "animalworld:animalworld_tundrashrub1", "animalworld:animalworld_tundrashrub2", "animalworld:animalworld_tundrashrub3", "animalworld:animalworld_tundrashrub4"},
	min_light = 0,
	interval = 60,
	chance = 500, -- 15000
	min_height = 20,
	max_height = 60,
	day_toggle = false,

})
end

mobs:register_egg("animalworld:volverine", S("Wolverine"), "avolverine.png")
