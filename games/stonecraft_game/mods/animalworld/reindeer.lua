local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:reindeer", {
	stepheight = 1,
	type = "animal",
	passive = true,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 2,
	hp_min = 25,
	hp_max = 50,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.3, 0.95, 0.3},
	visual = "mesh",
	mesh = "Reindeer.b3d",
	textures = {
		{"texturereindeer.png"},
	},
	makes_footstep_sound = true,
	sounds = {

	},
	walk_velocity = 1,
	run_velocity = 3,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
	jump_height = 3,
	pushable = true,
        stay_near = {{"default:pine_needles", "mcl_flowers:double:fern", "mcl_flowers:fern", "mcl_flowers:tallgrass", "mcl_farming:sweet_berry_bush_3", "mcl_core:sprucetree", "mcl_trees:tree_spruce", "mcl_trees:leaves_spruce", "animalworld:animalworld_tundrashrub5", "animalworld:animalworld_tundrashrub1", "animalworld:animalworld_tundrashrub2", "animalworld:animalworld_tundrashrub3", "animalworld:animalworld_tundrashrub4"}, 6},
	follow = {"default:apple", "mcl_flowers:tallgrass", "mcl_core:deadbush", "mcl_bamboo:bamboo", "default:permafrost_with_moss", "ethereal:snowygrass", "ethereal:crystalgrass", "livingdesert:coldsteppe_grass1"},
	view_range = 10,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
		{name = "animalworld:reindeercorpse", chance = 7, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 70,
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
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 25, false, nil) then return end
	end,
})

local spawn_on = {"default:permafrost_with_moss", "default:dirt_with_snow"}

if minetest.get_mapgen_setting("mg_name") ~= "v6" then
	spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_snow", "default:permafrost_with_moss"}
end

if minetest.get_modpath("ethereal") then
	spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_snow", "default:permafrost_with_moss", "ethereal:crystal_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:reindeer",
	nodes = {"default:dirt_with_snow", "mcl_core:snow", "default:permafrost_with_moss", "ethereal:crystal_dirt", "livingdesert:coldsteppe_ground3", "livingdesert:coldsteppe_ground4"},
	neighbors = {"default:pine_tree", "mcl_core:sprucetree", "animalworld:animalworld_tundrashrub1", "animalworld:animalworld_tundrashrub2", "animalworld:animalworld_tundrashrub3", "animalworld:animalworld_tundrashrub4"},
	min_light = 0,
	interval = 30,
	chance = 1000, -- 15000
	active_object_count = 4,
	min_height = 16,
	max_height = 80,
	day_toggle = true,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:dirt_with_snow", "default:permafrost_with_moss", "ethereal:crystal_dirt", "livingdesert:coldsteppe_ground3", "livingdesert:coldsteppe_ground4"})

			if nods and #nods > 0 then

				-- min herd of 4
				local iter = math.min(#nods, 4)

-- print("--- reindeer at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:reindeer", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:reindeer", S("Reindeer"), "areindeer.png")


mobs:alias_mob("animalworld:moose", "animalworld:reindeer") -- compatibility

