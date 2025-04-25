local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:owl", {
stepheight = 3,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	owner_loyal = true,
	reach = 2,
        damage = 3,
	hp_min = 5,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.5, 0.3},
	visual = "mesh",
	mesh = "Owl.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"textureowl.png"},
	},
	sounds = {
		random = "animalworld_owl",
	},
	makes_footstep_sound = false,
	walk_velocity = 5,
	run_velocity = 5,
	fall_speed = 0,
	jump = true,
        jump_height = 6,
	stepheight = 3,
	fly = true,
	drops = {
		{name = "animalworld:chicken_raw", chance = 1, min = 1, max = 1},
	        {name = "animalworld:chicken_feather", chance = 1, min = 1, max = 1},
		{name = "animalworld:owlcorpse", chance = 7, min = 1, max = 1},
	
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 0,
	animation = {
		speed_normal = 100,
		stand_start = 0,
		stand_end = 90,
		walk_start = 400,
		walk_end = 500,
		fly_start = 400, -- swim animation
		fly_end = 500,
		punch_start = 200,
		punch_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

fly_in = {"air"},
	floats = 0,
	follow = {
		"animalworld:rabbit_raw", "mcl_mobitems:chicken", "mobs:meat_raw", "animalworld:chicken_raw", "water_life:meat_raw" 
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
	spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_coniferous_litter"}, {"default:pine_needles"}, {"ethereal:mushroom_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:owl",
	nodes = {"default:pine_needles"}, {"naturalbiomes:pine_leaves"}, {"naturalbiomes:alppine1_leaves"}, {"naturalbiomes:birch_leaves"}, {"mcl_core:podzol"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	min_height = 10,
	max_height = 60,
	day_toggle = false,
})
end

mobs:register_egg("animalworld:owl", S("Owl"), "aowl.png")
