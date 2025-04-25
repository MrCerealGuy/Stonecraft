local S = minetest.get_translator("livingfloatlands")

mobs:register_mob("livingfloatlands:rhamphorhynchus", {
stepheight = 3,
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = false,
	reach = 2,
        damage = 1,
	hp_min = 5,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.5, 0.3},
	visual = "mesh",
	mesh = "Rhamphorhynchus.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturerhamphorhynchus.png"},
	},
	sounds = {
		random = "livingfloatlands_rhamphorhynchus",
                distance = 15,
	},
	makes_footstep_sound = false,
	walk_velocity = 3,
	run_velocity = 4,
        walk_chance = 50,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "player"},
	fall_speed = 0,
	jump = true,
        jump_height = 6,
	fly = true,
	stepheight = 3,
	drops = {
	        {name = "livingfloatlands:dinosaur_feather", chance = 1, min = 1, max = 1},
	
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 0,
	animation = {
		speed_normal = 100,
		stand_start = 150,
		stand_end = 250,
		fly_start = 0, 
		fly_end = 100,
		die_start = 0,
		die_end = 100,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

fly_in = {"air", "default:water_source", "default:river_water_source"},
	floats = 0,
	follow = {
		"animalworld:rawfish", "mobs:clownfish_raw", "mobs:bluefish_raw", "fishing:bait_worm", "fishing:clownfish_raw", "fishing:bluewhite_raw", "fishing:exoticfish_raw", "fishing:fish_raw", "fishing:carp_raw", "fishing:perch_raw", "xocean:fish_edible"
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
	spawn_on = {"ethereal:grove_dirt", "ethereal:bamboo_dirt", "default:dirt_with_rainforest_litter", "default:dirt_with_grass", "default:sand"}
end

if not mobs.custom_spawn_livingfloatlands then
mobs:spawn({
	name = "livingfloatlands:rhamphorhynchus",
	nodes = {"livingfloatlands:giantforest_paleoredwood_wood", "livingfloatlands:paleojungle_litter"},
	min_light = 0,
	interval = 60,
	chance = 200, -- 15000
	active_object_count = 2,
	min_height = 2,
	max_height = 31000,
	day_toggle = true,
})
end

mobs:register_egg("livingfloatlands:rhamphorhynchus", ("Rhamphorhynchus"), "arhamphorhynchus.png")


-- feather
minetest.register_craftitem(":livingfloatlands:dinosaur_feather", {
	description = S("Dinosaur Feather"),
	inventory_image = "livingfloatlands_dinosaur_feather.png",
	groups = {flammable = 2},
})

minetest.register_craft({
	type = "fuel",
	recipe = "livingfloatlands:dinosaur_feather",
	burntime = 2,
})
