local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:bat", {
stepheight = 3,
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = false,
	reach = 2,
        damage = 2,
	hp_min = 5,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.5, 0.2},
	visual = "mesh",
	mesh = "Bat.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturebat.png"},
	},
	sounds = {
		random = "animalworld_bat",
	},
	makes_footstep_sound = false,
	walk_velocity = 5,
	run_velocity = 6,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	fall_speed = 0,
	jump = true,
        jump_height = 6,
	fly = true,
	stepheight = 3,
	drops = {
        {name = "mobs:leather", chance = 1, min = 0, max = 2},
	
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 0,
	animation = {
		speed_normal = 130,
		stand_start = 0,
		stand_end = 100,
		fly_start = 150, -- swim animation
		fly_end = 250,
		die_start = 0,
		die_end = 100,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

fly_in = {"air"},
	floats = 0,
	follow = {
		"animalworld:rawfish", "mcl_fishing:pufferfish_raw", "ethereal:worm", "ethereal:fish_raw", "fishing:fish_raw", "xocean:fish_edible", "livingdesert:date_palm_fruits", "livingdesert:figcactus_fruit"
	},
	
view_range = 4,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

if minetest.get_modpath("ethereal") then
	spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_grass", "default:dry_dirt_with_dry_grass", "default:dirt_with_rainforest_litter", "default:dirt_with_coniferous_litter", "ethereal:gray_dirt", "ethereal:mushroom_dirt", "ethereal:grove_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:bat",
	nodes = {"mcl_core:dirt_with_grass", "default:dirt_with_grass", "default:dry_dirt_with_dry_grass", "default:dirt_with_rainforest_litter", "default:dirt_with_coniferous_litter", "naturalbiomes:mediterran_litter", "livingjungle:jungleground", "livingjungle:leafyjungleground", "naturalbiomes:bushland_bushlandlitter"},
	min_light = 0,
	interval = 60,
	chance = 8000, -- 15000
	active_object_count = 5,
	min_height = -100,
	max_height = 50,
	day_toggle = false,
})
end

mobs:register_egg("animalworld:bat", S("Bat"), "abat.png")
