local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:fox", {
	stepheight = 1,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 3,
	hp_min = 10,
	hp_max = 25,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	mesh = "Fox.b3d",
	textures = {
		{"texturefox.png"},
		{"texturefox2.png"},
		{"texturefox3.png"},
	},
	makes_footstep_sound = true,
	sounds = {
	        random = "animalworld_fox3",
		attack = "animalworld_fox",
                damage = "animalworld_fox2",
	},
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	jump_height = 6,
        runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	pushable = true,
        stay_near = {{"default:pine_needles", "animalworld:animalworld_tundrashrub5", "animalworld:animalworld_tundrashrub1", "animalworld:animalworld_tundrashrub2", "animalworld:animalworld_tundrashrub3", "animalworld:animalworld_tundrashrub4"}, 6},
	follow = {"default:apple", "farming:potato", "ethereal:banana_bread", "farming:melon_slice", "farming:carrot", "farming:seed_rice", "farming:corn", "ethereal:fish_raw", "animalworld:rawfish", "mobs_fish:tropical",
		"mobs:meat_raw", "animalworld:rabbit_raw", "xocean:fish_edible", "fishing:fish_raw", "water_life:meat_raw", "fishing:carp_raw", "animalworld:chicken_raw", "naturalbiomes:blackberry", "mobs:meatblock_raw", "animalworld:chicken_raw", "livingfloatlands:ornithischiaraw", "livingfloatlands:largemammalraw", "livingfloatlands:theropodraw", "livingfloatlands:sauropodraw", "animalworld:raw_athropod", "animalworld:whalemeat_raw", "animalworld:rabbit_raw", "nativevillages:chicken_raw", "mobs:meat_raw", "animalworld:pork_raw", "people:mutton:raw"},
	view_range = 12,
	drops = {
		{name = "mobs:leather", chance = 7, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 120,
		stand_speed = 50,
		stand_start = 0,
		stand_end = 100,
		stand2_start = 100,
		stand2_end = 200,
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
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:fox",
        nodes = {"default:permafrost", "mcl_core:snow", "default:permafrost_with_moss", "default:permafrost_with_stones"},
	neighbors = {"animalworld:animalworld_tundrashrub1", "mcl_core:sprucetree", "animalworld:animalworld_tundrashrub2", "animalworld:animalworld_tundrashrub1", "animalworld:animalworld_tundrashrub2", "animalworld:animalworld_tundrashrub3", "animalworld:animalworld_tundrashrub4"},
	min_light = 0,
	interval = 60,
	chance = 1000, -- 15000
	active_object_count = 2,
	min_height = 1,
	max_height = 80,
})
end

mobs:register_egg("animalworld:fox", S("Fox"), "afox.png")


mobs:alias_mob("animalworld:fox", "animalworld:fox") -- compatibility

