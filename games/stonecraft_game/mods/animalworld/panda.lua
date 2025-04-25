local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:panda", {
stepheight = 1,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 2,
        damage = 5,
	hp_min = 35,
	hp_max = 50,
	armor = 100,
	collisionbox = {-0.6, -0.01, -0.6, 0.6, 0.95, 0.6},
	visual = "mesh",
	mesh = "Panda.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturepanda.png"},
	},
	sounds = {
		random = "animalworld_bear",
	},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 3,
	runaway = false,
	jump = false,
        jump_height = 6,
	stepheight = 6,
        stay_near = {{"naturalbiomes:bamboo_leaves", "naturalbiomes:bambooforest_groundgrass", "mcl_bamboo:bamboo", "mcl_trees:tree_cherry_blossom"}, 5},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	        {name = "mobs:leather", chance = 1, min = 0, max = 2},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 7,
	animation = {
		speed_normal = 30,
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		stand2_start = 450,
		stand2_end = 550,
		walk_start = 200,
		walk_end = 300,
		punch_speed = 100,
		punch_start = 300,
		punch_end = 400,
		die_start = 300,
		die_end = 400,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

	follow = {
		"naturalbiomes:bamboo_leaves", "naturalbiomes:bamboo_sapling", "mcl_bamboo:bamboo", "mcl_trees:tree_cherry_blossom"},
	view_range = 4,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 25, false, nil) then return end
	end,
})

if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:bamboo_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:panda",
	nodes = {"naturalbiomes:bambooforest_litter", "mcl_core:dirt_with_gras"},
	neighbors = {"naturalbiomes:bambooforest_groundgrass", "mcl_bamboo:bamboo", "mcl_trees:tree_jungle", "mcl_trees:tree_cherry_blossom", "naturalbiomes:bambooforest_groundgrass2", "naturalbiomes:bamboo_leaves"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	min_height = 30,
	max_height = 1000,

})
end

mobs:register_egg("animalworld:panda", S("Panda"), "apanda.png")
