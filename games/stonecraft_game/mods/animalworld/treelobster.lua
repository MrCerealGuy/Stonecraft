local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:treelobster", {
	stepheight = 2,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	reach = 2,
	damage = 1,
	hp_min = 20,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.3, 0.3},
	visual = "mesh",
	mesh = "Treelobster.b3d",
	textures = {
		{"texturetreelobster.png"},
	},
	makes_footstep_sound = true,
	sounds = {
	},
	walk_velocity = 0.5,
	run_velocity = 1,
        walk_chance = 20,
	runaway = false,
	jump = false,
	jump_height = 3,
	pushable = true,
        stay_near = {{"people:jungleleaves", "mcl_core:jungletree", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "people:jungletree", "livingjungle::grass2", "livingjungle::grass1", "livingjungle:alocasia", "livingjungle:flamingoflower"}, 4},
	follow = {"default:junglegrass", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "default:jungleleaves", "default:blueberry_bush_leaves", "default:blueberry_bush_leaves_with_berries"},
	view_range = 10,
	drops = {
		{name = "animalworld:raw_athropod", chance = 1, min = 0, max = 2},
	},
	floats = 0,
	water_damage = 2,
	lava_damage = 5,
        air_damage = 0,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 100,
		stand_start = 0,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		punch_start = 250,
		punch_end = 350,
		die_start = 250,
		die_end = 350,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 25, 55, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:treelobster",
	nodes = {"default:dirt_with_rainforest_litter", "mcl_core:dirt_with_gras"},
	neighbors = {"mcl_flowers:tallgrass", "mcl_trees:tree_jungle", "default:junglegrass", "mcl_core:jungletree", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle",},
	min_light = 0,
	interval = 30,
	chance = 2000, -- 15000
	active_object_count = 4,
	min_height = 5,
	max_height = 40,
	day_toggle = false,
})
end

mobs:register_egg("animalworld:treelobster", S("Tree Lobster"), "atreelobster.png")


mobs:alias_mob("animalworld:treelobster", "animalworld:treelobster") -- compatibility

