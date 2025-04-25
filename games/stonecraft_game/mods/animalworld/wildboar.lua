local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:wildboar", {
	stepheight = 2,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = true,
	reach = 2,
	damage = 6,
	hp_min = 35,
	hp_max = 85,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	mesh = "Wildboar.b3d",
	textures = {
		{"texturewildboar.png"},
		{"texturewildboar2.png"},
		{"texturewildboar3.png"},
	},
	child_texture = {
		{"texturewildboarbaby.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "animalworld_boar",
		attack = "animalworld_boar",
	},
	walk_velocity = 1,
	run_velocity = 2.5,
	jump = true,
	jump_height = 4,
	pushable = true,
        stay_near = {{"people:feeder", "mcl_flowers:double:fern", "mcl_flowers:fern", "mcl_flowers:tallgrass", "mcl_farming:sweet_berry_bush_3", "mcl_core:sprucetree", "mcl_trees:tree_spruce", "mcl_trees:leaves_spruce", "default:fern_1", "default:fern_2", "marinara:reed_bundle", "naturalbiomes:reed_bundle", "farming:straw", "naturalbiomes:med_flower2", "naturalbiomes:med_grass1", "naturalbiomes:med_grass2", "naturalbiomes:med_flower3"}, 6},
	follow = {"default:apple", "mcl_farming:beetroot_item", "mcl_farming:mushroom_red", "mcl_farming:mushroom_brown", "mcl_farming:carrot_item", "mcl_farming:melon_item", "mcl_farming:potato_item", "mcl_farming:pumpkin_item", "mcl_farming:wheat_item", "mcl_farming:sweet_berry", "farming:potato", "ethereal:banana_bread", "farming:melon_slice", "farming:carrot", "farming:seed_rice", "farming:corn", "naturalbiomes:hazelnut", "livingfloatlands:giantforest_oaknut"},
	view_range = 10,
	replace_rate = 10,
	replace_what = {"farming:soil", "farming:soil_wet"},
	replace_with = "default:dirt",
	drops = {
		{name = "animalworld:pork_raw", chance = 1, min = 1, max = 3},
	        {name = "mobs:leather", chance = 1, min = 0, max = 2},
	},
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 80,
		stand_speed = 50,
		stand_start = 0,
		stand_end = 100,
		stand1_speed = 50,
		stand1_start = 100,
		stand1_end = 200,
		walk_start = 200,
		walk_end = 300,
	        jump_start = 300,
		jump_end = 400,
		punch_start = 400,
		punch_end = 500,
		die_start = 400,
		die_end = 500,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 15, 25, false, nil) then return end
	end,
})

local spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_coniferous_litter"}

if minetest.get_mapgen_setting("mg_name") ~= "v6" then
	spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_dry_grass", "default:dirt_with_coniferous_litter"}
end

if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:mushroom_dirt", "ethereal:bamboo_dirt", "ethereal:green_dirt", "ethereal:mushroom_dirt", "default:dirt_with_coniferous_litter", "default:dirt_gray"}
end

if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:wildboar",
	nodes = {"mcl_core:podzol", "default:dirt_with_conifrous_litter", "default:dirt_gray", "naturalbiomes:mediterran_litter", "mcl_core:dirt_with_grass", "mcl_core:podzol"},
	neighbors = {"default:fern_1", "mcl_flowers:double:fern", "mcl_flowers:fern", "mcl_flowers:tallgrass", "mcl_farming:sweet_berry_bush_3", "mcl_core:sprucetree", "mcl_trees:tree_spruce", "mcl_trees:leaves_spruce", "default:fern_2", "naturalbiomes:med_flower2", "naturalbiomes:med_grass1", "naturalbiomes:med_grass2", "naturalbiomes:med_flower3"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 3,
	min_height = 1,
	max_height = 80,
	day_toggle = true,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:dirt_with_coniferous_litter", "default:dirt_gray", "naturalbiomes:mediterran_litter"})

			if nods and #nods > 0 then

				-- min herd of 3
				local iter = math.min(#nods, 3)

-- print("--- wildboar at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:wildboar", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:wildboar", S("Wild Boar"), "awildboar.png")


mobs:alias_mob("animalworld:wildboar", "animalworld:wildboar") -- compatibility


