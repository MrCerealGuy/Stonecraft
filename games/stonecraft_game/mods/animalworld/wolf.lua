local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:wolf", {
stepheight = 2,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 2,
        damage = 9,
	hp_min = 25,
	hp_max = 45,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	mesh = "Wolf.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturewolf.png"},
		{"texturewolf2.png"},
		{"texturewolf.png"},
		{"texturewolf3.png"},
		{"texturewolf.png"},
		{"texturewolf.png"},
	},
	sounds = {
		random = "animalworld_wolf",
		attack = "animalworld_wolf2",
		damage = "animalworld_wolf3",
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 3,
	runaway = false,
	jump = true,
        jump_height = 6,
	stepheight = 2,
        stay_near = {{"default:fern_1", "default:fern_2", "mcl_flowers:double:fern", "mcl_flowers:fern", "mcl_flowers:tallgrass", "mcl_farming:sweet_berry_bush_3", "mcl_core:sprucetree", "mcl_trees:tree_spruce", "mcl_trees:leaves_spruce", "naturalbiomes:alpine_grass1", "naturalbiomes:alpine_grass2", "naturalbiomes:alpine_grass3", "naturalbiomes:alpine_dandelion", "naturalbiomes:alpine_edelweiss"}, 6},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	        {name = "mobs:leather", chance = 1, min = 0, max = 2},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 4,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		stand_start = 100,
		stand_end = 200,
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
		"ethereal:fish_raw", "animalworld:rawfish", "mobs_fish:tropical",
		"mobs:meat_raw", "mcl_mobitems:chicken", "mcl_fishing:pufferfish_raw", "mcl_mobitems:rotten_flesh", "mcl_mobitems:mutton", "mcl_mobitems:beef", "mcl_mobitems:porkchop", "mcl_mobitems:rabbit", "animalworld:rabbit_raw", "animalworld:pork_raw", "water_life:meat_raw", "xocean:fish_edible", "animalworld:chicken_raw", "mobs:meatblock_raw", "animalworld:chicken_raw", "livingfloatlands:ornithischiaraw", "livingfloatlands:largemammalraw", "livingfloatlands:theropodraw", "livingfloatlands:sauropodraw", "animalworld:raw_athropod", "animalworld:whalemeat_raw", "animalworld:rabbit_raw", "nativevillages:chicken_raw", "mobs:meat_raw", "animalworld:pork_raw", "people:mutton:raw"
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
	spawn_on = {"ethereal:dry_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:wolf",
	nodes = {"mcl_core:podzol", "default:dirt_with_conifrous_litter", "naturalbiomes:alpine_litter", "naturalbiomes:heath_litter"},
	neighbors = {"default:pine_needles", "mcl_flowers:double:fern", "mcl_flowers:fern", "mcl_flowers:tallgrass", "mcl_farming:sweet_berry_bush_3", "mcl_core:sprucetree", "mcl_trees:tree_spruce", "mcl_trees:leaves_spruce", "naturalbiomes:pine_leaves", "heath_juniper_leaves", "naturalbiomes:alppine1_leaves", "naturalbiomes:alppine2_leaves"},
	min_light = 0,
	interval = 60,
	chance = 500, -- 15000
	active_object_count = 4,
	min_height = 30,
	max_height = 31000,
	day_toggle = false,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:dirt_with_coniferous_litter", "naturalbiomes:alpine_litter", "naturalbiomes:heath_litter"})

			if nods and #nods > 0 then

				-- min herd of 4
				local iter = math.min(#nods, 4)

-- print("--- wolf at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:wolf", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:wolf", ("Wolf"), "awolf.png")
