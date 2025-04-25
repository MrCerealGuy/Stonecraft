local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:marmot", {
	stepheight = 2,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = false,
	reach = 2,
	damage = 1,
	hp_min = 10,
	hp_max = 30,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.95, 0.3},
	visual = "mesh",
	mesh = "Marmot.b3d",
	textures = {
		{"texturemarmot.png"},
	},
	makes_footstep_sound = true,
	sounds = {		
		random = "animalworld_marmot",
		damage = "animalworld_marmot2",
	},
	walk_velocity = 2,
	run_velocity = 3,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "player", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
	jump_height = 6,
	pushable = true,
	follow = {"default:grass_3", "default:dry_grass_3", "ethereal:dry_shrub", "mcl_flowers:tallgrass", "mcl_flowers:tulip_red", "mcl_flowers:sunflower", "farming:lettuce", "farming:seed_wheat", "default:junglegrass", "naturalbiomes:alpine_grass1", "naturalbiomes:alpine_grass2", "naturalbiomes:alpine_grass3", "naturalbiomes:alpine_dandelion", "livingdesert:coldsteppe_grass1", "livingdesert:coldsteppe_grass2"},
	view_range = 10,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	        {name = "mobs:leather", chance = 1, min = 0, max = 2},
	},
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3,
        stay_near = {{"naturalbiomes:alpine_grass1", "naturalbiomes:alpine_grass2", "naturalbiomes:alpine_grass3", "naturalbiomes:alpine_dandelion", "naturalbiomes:alpine_edelweiss", "livingdesert:coldsteppe_grass1", "livingdesert:coldsteppe_grass2", "livingdesert:coldsteppe_grass3"}, 5},
	animation = {
		speed_normal = 90,
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		stand2_start = 350,
		stand2_end = 450,
		walk_start = 200,
		walk_end = 300,
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
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

local spawn_on = {"default:desert_sand", "default:dry_dirt_with_dry_grass"}

if minetest.get_mapgen_setting("mg_name") ~= "v6" then
	spawn_on = {"default:desert_sand", "default:dry_dirt_with_dry_grass"}
end

if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:grass_grove", "default:desert_sand", "ethereal:dry_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:marmot",
	nodes = {"naturalbiomes:alpine_litter", "mcl_core:dirt_with_grass", "livingdesert:coldsteppe_ground2", "mcl_core:stone", "mcl_core:granite"},
	neighbors = {"naturalbiomes:alpine_grass1", "mcl_flowers:tallgrass", "mcl_flowers:double:fern", "mcl_flowers:fern", "naturalbiomes:alpine_grass2", "naturalbiomes:alpine_grass3", "naturalbiomes:alpine_dandelion", "naturalbiomes:alpine_edelweiss", "livingdesert:coldsteppe_grass1", "livingdesert:coldsteppe_grass2", "livingdesert:coldsteppe_grass3"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 4,
	min_height = 30,
	max_height = 31000,
	day_toggle = true,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"naturalbiomes:alpine_litter", "livingdesert:coldsteppe_ground2"})

			if nods and #nods > 0 then

				-- min herd of 4
				local iter = math.min(#nods, 4)

-- print("--- marmot at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:marmot", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:marmot", S("Marmot"), "amarmot.png")


mobs:alias_mob("animalworld:marmot", "animalworld:marmot") -- compatibility

