local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:orangutan", {
	stepheight = 3,
	type = "animal",
	passive = false,
        attack_npcs = false,
        attack_animals = false,
	attack_type = "dogshoot",
	dogshoot_switch = 1,
	dogshoot_count_max = 3, -- shoot for 10 seconds
	dogshoot_count2_max = 5, -- dogfight for 3 seconds
	shoot_interval = 1,
	arrow = "animalworld:pooball",
	shoot_offset = 0.8,
	group_attack = true,
	owner_loyal = true,
	reach = 2,
	damage = 6,
	hp_min = 35,
	hp_max = 65,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	mesh = "Orangutan.b3d",
	textures = {
		{"textureorangutan.png"},

	},
	child_texture = {
		{"textureorangutanbaby.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "animalworld_orangutan2",
		attack = "animalworld_orangutan",
                damage = "animalworld_orangutan4",
		death = "animalworld_orangutan3",
                distance = 13,
	},
	walk_velocity = 1,
	run_velocity = 2,
	jump = true,
	jump_height = 6,
	pushable = true,
	follow = {"farming:melon_8", "mcl_farming:beetroot_item", "mcl_farming:carrot_item", "mcl_farming:melon_item", "mcl_farming:potato_item", "mcl_farming:pumpkin_item", "mcl_farming:wheat_item", "mcl_farming:sweet_berry", "farming:pumpkin_8", "ethereal:strawberry", "farming:blackberry", "naturalbiomes:blackberry", "naturalbiomes:cowberry", "naturalbiomes:banana", "naturalbiomes:banana_bunch", "farming:blueberries", "ethereal:orange", "livingdesert:figcactus_fruit", "livingfloatlands:paleojungle_clubmoss_fruit", "ethereal:banana", "livingdesert:date_palm_fruits", "farming:melon_slice", "naturalbiomes:wildrose", "naturalbiomes:banana"},
	view_range = 10,
        stay_near = {{"default:jungleleaves", "mcl_core:jungletree", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "mcl_trees:leaves_mangrove", "naturalbiomes:bamboo_leaves", "naturalbiomes:bambooforest_groundgrass", "livingjungle:samauma_trunk", "livingjungle:samauma_leaves"}, 5},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 3},
	        {name = "mobs:leather", chance = 1, min = 0, max = 2},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 4,
	animation = {
		speed_normal = 25,
		stand_speed = 75,
		stand_start = 100,
		stand_end = 200,
		stand2_start = 200,
		stand2_end = 300,
		stand3_start = 300,
		stand3_end = 400,
		jump_speed = 75,
		jump_start = 400,
		jump_end = 500,
		walk_speed = 65,
		walk_start = 0,
		walk_end = 100,
		punch_speed = 70,
		punch_start = 500,
		punch_end = 600,
                shoot_speed = 70,
                shoot_start = 500,
		shoot_end = 600,
		die_start = 400,
		die_end = 500,
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


if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:orangutan",
	nodes = {"default:dirt_with_rainforest_litter", "default:jungleleaves", "naturalbiomes:bambooforest_litter", "livingjungle:jungleground", "livingjungle:leafyjungleground", "mcl_core:dirt_with_gras"},
	neighbors = {"default:jungletree", "mcl_core:jungletree", "mcl_trees:tree_jungle", "mcl_core:jungleleaves", "mcl_trees:leaves_jungle", "mcl_trees:leaves_mangrove", "livingjungle:alocasia", "livingjungle:flamingoflower", "livingjungle:samauma_trunk", "naturalbiomes:bambooforest_groundgrass", "naturalbiomes:bambooforest_groundgrass2"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 4,
	min_height = 3,
	max_height = 500,
	day_toggle = true,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:dry_dirt_with_dry_grass", "default:dirt_with_rainforest_litter", "default:jungleleaves", "naturalbiomes:bambooforest_litter", "livingjungle:jungleground", "livingjungle:leafyjungleground"})

			if nods and #nods > 0 then

				-- min herd of 4
				local iter = math.min(#nods, 6)

-- print("--- orangutan at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:orangutan", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:orangutan", S("Orang Utan"), "aorangutan.png")


