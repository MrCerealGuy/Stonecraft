local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:tiger", {
stepheight = 2,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 2,
        damage = 13,
	hp_min = 45,
	hp_max = 75,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	mesh = "Tiger.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturetiger.png"},
	},
	sounds = {
		random = "animalworld_tiger",
		attack = "animalworld_tiger",
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 4,
	runaway = false,
        knock_back = false,
	jump = true,
        jump_height = 6,
	stepheight = 2,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
		{name = "animalworld:tigercorpse", chance = 7, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 4,
        stay_near = {{"default:jungletree", "default:junglegrass", "naturalbiomes:bamboo_leaves", "naturalbiomes:bambooforest_groundgrass", "livingjungle::grass2", "livingjungle::grass1", "livingjungle:alocasia", "livingjungle:flamingoflower"}, 6},
	animation = {
		speed_normal = 100,
		stand_start = 0,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		punch_start = 200,
		punch_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	follow = {
		"ethereal:fish_raw", "animalworld:rawfish", "mobs_fish:tropical",
		"mobs:meat_raw", "mcl_mobitems:chicken", "mcl_fishing:pufferfish_raw", "mcl_mobitems:rotten_flesh", "mcl_mobitems:mutton", "mcl_mobitems:beef", "mcl_mobitems:porkchop", "mcl_mobitems:rabbit", "animalworld:rabbit_raw", "animalworld:pork_raw", "water_life:meat_raw", "animalworld:chicken_raw", "mobs:meatblock_raw", "animalworld:chicken_raw", "livingfloatlands:ornithischiaraw", "livingfloatlands:largemammalraw", "livingfloatlands:theropodraw", "livingfloatlands:sauropodraw", "animalworld:raw_athropod", "animalworld:whalemeat_raw", "animalworld:rabbit_raw", "nativevillages:chicken_raw", "mobs:meat_raw", "animalworld:pork_raw", "people:mutton:raw"
	},
	view_range = 15,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 0, false, nil) then return end
	end,
})

if minetest.get_modpath("ethereal") then
	spawn_on = {"mcl_core:podzol", "default:dirt_withforest_litter", "ethereal:green_dirt", "ethereal:grass_grove"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:tiger",
	nodes = {"mcl_core:podzol", "mcl_core:dirt_with_gras", "default:dirt_with_rainforest_litter", "ethereal:green_dirt", "ethereal:grass_grove", "naturalbiomes:bambooforest_litter"},
	neighbors = {"default:jungleleaves", "mcl_core:jungletree", "mcl_trees:tree_jungle", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "mcl_trees:leaves_mangrove", "group:grass", "group:normal_grass", "naturalbiomes:bambooforest_groundgrass", "naturalbiomes:bambooforest_groundgrass2"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	min_height = 10,
	max_height = 50,

})
end

mobs:register_egg("animalworld:tiger", ("Tiger"), "atiger.png")
