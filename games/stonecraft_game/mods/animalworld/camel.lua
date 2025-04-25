local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:camel", {
	stepheight = 1,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 5,
	hp_min = 20,
	hp_max = 60,
	armor = 100,
	collisionbox = {-0.7, -0.01, -0.7, 0.7, 2, 0.7},
	visual = "mesh",
	mesh = "Camel.b3d",
	textures = {
		{"texturecamel.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "animalworld_camel",
		attack = "animalworld_camel",
	},
	walk_velocity = 2,
	run_velocity = 5,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
	jump_height = 3,
	pushable = true,
	follow = {"default:dry_shrub", "default:grass_1", "ethereal:dry_shrub", "farming:seed_wheat", "farming:seed_rye", "default:junglegrass", "farming:melon_8", "farming:pumpkin_8", "ethereal:strawberry", "farming:blackberry", "naturalbiomes:blackberry", "naturalbiomes:cowberry", "naturalbiomes:banana", "naturalbiomes:banana_bunch", "farming:blueberries", "ethereal:orange", "livingdesert:figcactus_fruit", "livingfloatlands:paleojungle_clubmoss_fruit", "ethereal:banana", "livingdesert:date_palm_fruits", "farming:melon_slice", "naturalbiomes:wildrose", "naturalbiomes:banana", "default:dry_grass_1", "default:dry_grass_2", "default:dry_grass_3", "default:grass_1", "default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5", "default:marram_grass_1", "default:marram_grass_2", "default:marram_grass_3", "default:coldsteppe_grass_1", "default:coldsteppe_grass_2", "default:coldsteppe_grass_3", "default:coldsteppe_grass_4", "default:coldsteppe_grass_5", "default:coldsteppe_grass_6", "naturalbiomes:savanna_grass1", "naturalbiomes:savanna_grass2", "mcl_flowers:tallgrass", "mcl_core:deadbush", "mcl_bamboo:bamboo", "naturalbiomes:savanna_grass3", "naturalbiomes:outback_grass1", "naturalbiomes:outback_grass2", "naturalbiomes:outback_grass3", "naturalbiomes:outback_grass4", "naturalbiomes:outback_grass5", "naturalbiomes:outback_grass6", "naturalbiomes:med_grass1", "naturalbiomes:med_grass2", "naturalbiomes:heath_grass1", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:alpine_grass1", "naturalbiomes:alpine_grass2", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:", "naturalbiomes:", "naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4", "naturalbiomes:bushland_grass5", "naturalbiomes:bushland_grass6", "naturalbiomes:bushland_grass7", "group:grass", "group:normal_grass"},
	view_range = 7,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
		{name = "animalworld:camelcorpse", chance = 7, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
        knock_back = false,
	fear_height = 2,
        stay_near = {{"livingdesert:date_palm_leaves", "mcl_flowers:tallgrass", "mcl_core:deadbush", "livingdesert:yucca", "default:dry_shrub", "livingdesert:figcactus_trunk", "livingdesert:coldsteppe_grass1", "livingdesert:cactus", "livingdesert:cactus3", "livingdesert:cactus2", "livingdesert:cactus4"}, 5},
	animation = {
		speed_normal = 35,
		stand_start = 0,
		stand_end = 100,
		walk_start = 200,
		walk_end = 300,
		punch_start = 100,
		punch_end = 200,
		die_start = 100,
		die_end = 200,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 25, false, nil) then return end
	end,
})

local spawn_on = {"default:desert_sand", "default:sandstone"}

if minetest.get_mapgen_setting("mg_name") ~= "v6" then
	spawn_on = {"default:desert_sand", "default:sandstone"}
end

if minetest.get_modpath("ethereal") then
	spawn_on = {"default:desert_sand", "ethereal:dry_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:camel",
	nodes = {"default:desert_sand", "default:sandstone", "mcl_core:sand", "mcl_core:redsand"},
	neighbors = {"livingdesert:date_palm_leaves", "mcl_core:deadbush", "mcl_core:cactus", "livingdesert:yucca", "default:dry_shrub", "livingdesert:figcactus_trunk", "livingdesert:coldsteppe_grass1", "livingdesert:cactus", "livingdesert:cactus3", "livingdesert:cactus2", "livingdesert:cactus4", "default:cactus"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 3,
	min_height = 0,
	max_height = 40,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:desert_sand", "default:sandstone"})

			if nods and #nods > 0 then

				-- min herd of 3
				local iter = math.min(#nods, 3)

-- print("--- camel at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:camel", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:camel", S("Camel"), "acamel.png")


mobs:alias_mob("animalworld:camel", "animalworld:camel") -- compatibility

