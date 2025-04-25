local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:hyena", {
stepheight = 2,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 2,
        damage = 16,
	hp_min = 35,
	hp_max = 65,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	mesh = "Hyena.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturehyena.png"},
	},
	sounds = {
		random = "animalworld_hyena",
		attack = "animalworld_hyena",
	},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 3,
	runaway = false,
	jump = true,
        jump_height = 6,
	stepheight = 2,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
		{name = "animalworld:hyenacorpse", chance = 7, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 4,
        stay_near = {{"naturalbiomes:savanna_flowergrass", "mcl_trees:leaves_acacia",  "mcl_core:acacialeaves", "naturalbiomes:savanna_grass", "naturalbiomes:savanna_grass2", "naturalbiomes:savanna_grass3", "naturalbiomes:savannagrass"}, 6},
	animation = {
		speed_normal = 75,
		stand_start = 0,
		stand_end = 100,
		walk_start = 150,
		walk_end = 250,
		punch_start = 250,
		punch_end = 350,
		die_start = 200,
		die_end = 300,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

	follow = {
		"ethereal:fish_raw", "mcl_mobitems:chicken", "mcl_fishing:pufferfish_raw", "mcl_mobitems:rotten_flesh", "mcl_mobitems:mutton", "mcl_mobitems:beef", "mcl_mobitems:porkchop", "mcl_mobitems:rabbit", "animalworld:rawfish", "mobs_fish:tropical",
		"mobs:meat_raw", "animalworld:rabbit_raw", "animalworld:pork_raw", "water_life:meat_raw", "xocean:fish_edible", "animalworld:chicken_raw", "mobs:meatblock_raw", "animalworld:chicken_raw", "livingfloatlands:ornithischiaraw", "livingfloatlands:largemammalraw", "livingfloatlands:theropodraw", "livingfloatlands:sauropodraw", "animalworld:raw_athropod", "animalworld:whalemeat_raw", "animalworld:rabbit_raw", "nativevillages:chicken_raw", "mobs:meat_raw", "animalworld:pork_raw", "people:mutton:raw"
	},
	view_range = 10,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 15, 0, false, nil) then return end
	end,
})

if minetest.get_modpath("ethereal") then
	spawn_on = {"default:dry_dirt_with_dry_grass"}, {"ethereal:dry_dirt"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:hyena",
	nodes = {"default:dry_dirt_with_dry_grass", "naturalbiomes:savannalitter", "mcl_core:dirt_with_grass"},
	neighbors = {"group:grass", "group:normal_grass", "naturalbiomes:savanna_grass2", "naturalbiomes:savanna_grass3", "mcl_trees:leaves_acacia", "mcl_core:acacialeaves", "mcl_core:acaciatree", "mcl_trees:tree_acacia"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 3,
	min_height = 20,
	max_height = 60,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:dry_dirt_with_dry_grass", "naturalbiomes:savannalitter"})

			if nods and #nods > 0 then

				-- min herd of 3
				local iter = math.min(#nods, 3)

-- print("--- hyena at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:hyena", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:hyena", S("Hyena"), "ahyena.png")
