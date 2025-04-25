local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:muskox", {
	stepheight = 2,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = true,
	reach = 2,
	damage = 8,
	hp_min = 25,
	hp_max = 75,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 1.4, 0.5},
	visual = "mesh",
	mesh = "Muskox.b3d",
	textures = {
		{"texturemuskox.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "animalworld_muskox",
		attack = "animalworld_muskox2",
	},
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	jump_height = 6,
	pushable = true,
        knock_back = false,
        stay_near = {{"default:pine_needles", "mcl_trees:tree_spruce", "mcl_core:sprucetree", "animalworld:animalworld_tundrashrub5", "animalworld:animalworld_tundrashrub1", "animalworld:animalworld_tundrashrub2", "animalworld:animalworld_tundrashrub3", "animalworld:animalworld_tundrashrub4"}, 6},
	follow = {"default:apple", "mcl_flowers:tallgrass", "mcl_core:deadbush", "mcl_bamboo:bamboo", "farming:potato", "ethereal:banana_bread", "farming:melon_slice", "farming:carrot", "farming:seed_rice", "farming:corn", "ethereal:snowygrass", "ethereal:crystalgrass", "default:dry_grass_1", "default:dry_grass_2", "default:dry_grass_3", "default:grass_1", "default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5", "default:marram_grass_1", "default:marram_grass_2", "default:marram_grass_3", "default:coldsteppe_grass_1", "default:coldsteppe_grass_2", "default:coldsteppe_grass_3", "default:coldsteppe_grass_4", "default:coldsteppe_grass_5", "default:coldsteppe_grass_6", "naturalbiomes:savanna_grass1", "naturalbiomes:savanna_grass2", "naturalbiomes:savanna_grass3", "naturalbiomes:outback_grass1", "naturalbiomes:outback_grass2", "naturalbiomes:outback_grass3", "naturalbiomes:outback_grass4", "naturalbiomes:outback_grass5", "naturalbiomes:outback_grass6", "naturalbiomes:med_grass1", "naturalbiomes:med_grass2", "naturalbiomes:heath_grass1", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:alpine_grass1", "naturalbiomes:alpine_grass2", "naturalbiomes:heath_grass2", "naturalbiomes:heath_grass3", "naturalbiomes:", "naturalbiomes:", "naturalbiomes:bushland_grass", "naturalbiomes:bushland_grass2", "naturalbiomes:bushland_grass3", "naturalbiomes:bushland_grass4", "naturalbiomes:bushland_grass5", "naturalbiomes:bushland_grass6", "naturalbiomes:bushland_grass7", "group:grass", "group:normal_grass"},
	view_range = 6,
	replace_rate = 10,
	replace_what = {"farming:soil", "farming:soil_wet"},
	replace_with = "default:dirt",
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 3},
		{name = "animalworld:muskoxcorpse", chance = 7, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 50,
		stand_speed = 50,
		stand_start = 0,
		stand_end = 100,
		stand2_start = 100,
		stand2_end = 200,
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
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 25, false, nil) then return end
	end,
})


if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:muskox",
        nodes = {"default:permafrost", "default:permafrost_with_moss", "default:permafrost_with_stones", "mcl_core:ice", "mcl_core:snow"},
	neighbors = {"animalworld:animalworld_tundrashrub1", "mcl_core:sprucetree", "animalworld:animalworld_tundrashrub2", "animalworld:animalworld_tundrashrub1", "animalworld:animalworld_tundrashrub2", "animalworld:animalworld_tundrashrub3", "animalworld:animalworld_tundrashrub4"},
	min_light = 0,
	interval = 60,
	chance = 1000, -- 15000
	active_object_count = 5,
	min_height = 10,
	max_height = 60,
	day_toggle = true,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:permafrost", "default:permafrost_with_moss", "default:permafrost_with_stones"})

			if nods and #nods > 0 then

				-- min herd of 5
				local iter = math.min(#nods, 5)

-- print("--- muskox at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:muskox", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:muskox", S("Musk Ox"), "amuskox.png")


mobs:alias_mob("animalworld:muskox", "animalworld:muskox") -- compatibility

