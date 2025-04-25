local S = minetest.get_translator("livingfloatlands")

mobs:register_mob("livingfloatlands:gastornis", {
stepheight = 2,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
        attack_monsters = true,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 12,
	hp_min = 80,
	hp_max = 120,
	armor = 100,
	collisionbox = {-0.7, -0.01, -0.5, 0.5, 1.5, 0.7},
	visual = "mesh",
	mesh = "Gastornis.b3d",
	textures = {
		{"texturegastornis.png"}, -- white
		{"texturegastornis.png"},
		{"texturegastornis.png"},
	},
	child_texture = {
		{"texturegastornis.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "livingfloatlands_gastornis",
                distance = 15,
	},
	walk_velocity = 1.5,
	run_velocity = 3,
	jump = true,
        jump_height = 6,
        stay_near = {{"livingfloatlands:giantforest_grass", "livingfloatlands:giantforest_grass2", "livingfloatlands:giantforest_grass3"}, 5},
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor"},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
		{name = "livingfloatlands:dinosaur_feather", chance = 1, min = 0, max = 2},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 50,
		stand_start = 1,
		stand_end = 100,
		stand1_start = 1,
		stand1_end = 100,
		walk_speed = 75,
		walk_start = 100,
		walk_end = 200,
		speed_run = 100,
		run_start = 100,
		run_end = 200,
		speed_punch = 50,
		punch_start = 200,
		punch_end = 300,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	follow = {
		"farming:seed_wheat", "farming:seed_cotton", "farming:seed_barley",
		"farming:seed_oat", "farming:seed_rye", "mobs:meat_raw", "animalworld:rabbit_raw", "animalworld:pork_raw", "water_life:meat_raw", "animalworld:chicken_raw", "livingfloatlands:ornithischiaraw", "livingfloatlands:sauropodraw", "livingfloatlands:theropodraw", "livingfloatlands:giantforest_oaknut"
	},
	view_range = 10,

	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 15, false, nil) then return end
	end,

})


if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:grove_dirt", "ethereal:bamboo_dirt", "default:dirt_with_rainforest_litter"}
end

if not mobs.custom_spawn_livingfloatlands then
mobs:spawn({
	name = "livingfloatlands:gastornis",
	nodes = {"livingfloatlands:giantforest_litter"},
	neighbors = {"livingfloatlands:giantforest_paleoredwood_trunk", "livingfloatlands:giantforest_paleooak_trunk"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 5,
	max_height = 31000,
	day_toggle = true,
})
end


mobs:register_egg("livingfloatlands:gastornis", ("Gastornis"), "agastornis.png", 0)


mobs:alias_mob("livingfloatlands:gastornis", "livingfloatlands:gastornis") -- compatibility


