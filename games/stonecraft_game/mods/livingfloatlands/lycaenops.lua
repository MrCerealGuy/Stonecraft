local S = minetest.get_translator("livingfloatlands")

mobs:register_mob("livingfloatlands:lycaenops", {
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 2,
        damage = 10,
	hp_min = 25,
	hp_max = 65,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 0.5, 0.4},
	visual = "mesh",
	mesh = "Lycaenops.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturelycaenops.png"},
	},
	sounds = {
		random = "livingfloatlands_lycaenops2",
		attack = "livingfloatlands_lycaenops",
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 3,
	runaway = false,
	jump = false,
        jump_height = 6,
	stepheight = 2,
        stay_near = {{"livingfloatlands:giantforest_grass", "livingfloatlands:giantforest_grass2", "livingfloatlands:giantforest_grass3"}, 6},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
		{name = "mobs:leather", chance = 1, min = 0, max = 2},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		walk_speed = 75,
		walk_start = 100,
		walk_end = 200,
		punch_speed = 100,
		punch_start = 250,
		punch_end = 350,
		die_start = 250,
		die_end = 350,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

	follow = {
		"animalworld:rawfish", "mobs:meat_raw", "animalworld:rabbit_raw", "animalworld:chicken_raw", "water_life:meat_raw", "livingfloatlands:ornithischiaraw", "livingfloatlands:sauropodraw", "livingfloatlands:theropodraw", "mobs:meatblock_raw", "animalworld:chicken_raw", "livingfloatlands:ornithischiaraw", "livingfloatlands:largemammalraw", "livingfloatlands:theropodraw", "livingfloatlands:sauropodraw", "animalworld:raw_athropod", "animalworld:whalemeat_raw", "animalworld:rabbit_raw", "nativevillages:chicken_raw", "mobs:meat_raw", "animalworld:pork_raw", "people:mutton:raw"
	},
	view_range = 8,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})


if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:gray_dirt", "dry:dry_dirt", "default:dirt_with_grass", "default:dry_dirt_with_dry_grass", "default:dirt_with_coniferous_litter"}
end

if not mobs.custom_spawn_livingfloatlands then
mobs:spawn({
	name = "livingfloatlands:lycaenops",
	nodes = {"livingfloatlands:giantforest_litter"},
	neighbors = {"livingfloatlands:giantforest_grass", "livingfloatlands:giantforest_grass2", "livingfloatlands:giantforest_grass3"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	min_height = 2,
	max_height = 31000,

})
end

mobs:register_egg("livingfloatlands:lycaenops", ("Lycaenops"), "alycaenops.png")
