local S = minetest.get_translator("animalworld")
local random = math.random

mobs:register_mob("animalworld:boar", {
	stepheight = 1,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = true,
	reach = 2,
	damage = 5,
	hp_min = 5,
	hp_max = 55,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	mesh = "Boar.b3d",
	textures = {
		{"textureboar.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "animalworld_boar",
		attack = "animalworld_boar",
	},
	walk_velocity = 1,
	run_velocity = 2,
	jump = false,
	pushable = true,
        stay_near = {{"people:feeder", "default:fern_1", "default:fern_2", "marinara:reed_bundle", "naturalbiomes:reed_bundle", "farming:straw"}, 5},
	follow = {"default:apple", "mcl_farming:beetroot_item", "mcl_farming:carrot_item", "mcl_farming:melon_item", "mcl_farming:potato_item", "mcl_farming:pumpkin_item", "mcl_farming:wheat_item", "mcl_farming:sweet_berry", "mcl_farming:mushroom_red", "mcl_farming:mushroom_brown", "farming:potato", "ethereal:banana_bread", "farming:melon_slice", "farming:carrot", "farming:seed_rice", "farming:corn", "naturalbiomes:hazelnut", "livingfloatlands:giantforest_oaknut", "farming:corn_cob", "farming:seed_barley", "farming:seed_oat", "farming:pumpkin_8", "livingfloatlands:giantforest_oaknut", "farming:baked_potato", "farming:sunflower_bread", "farming:pumpkin_bread", "farming:bread_multigrain", "farming:spanish_potatoes"},
	view_range = 6,
	replace_rate = 10,
	replace_what = {"farming:soil", "farming:soil_wet"},
	replace_with = "default:dirt",
	drops = {
		{name = "animalworld:pork_raw", chance = 1, min = 2, max = 5},
		{name = "animalworld:boarcorpse", chance = 7, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 100,
		stand_speed = 50,
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
		if mobs:capture_mob(self, clicker, 0, 15, 25, false, nil) then return end
	end,
})

local spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_coniferous_litter"}

if minetest.get_mapgen_setting("mg_name") ~= "v6" then
	spawn_on = {"mcl_core:dirt_with_grass", "default:dirt_with_dry_grass", "default:dirt_with_coniferous_litter"}
end

if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:mushroom_dirt", "ethereal:bamboo_dirt", "ethereal:green_dirt", "ethereal:mushroom"}
end

if not mobs.custom_spawn_animal then
mobs:spawn({
	name = "animalworld:boar",
	nodes = {"mcl_core:podzol", "default:dirt_with_conifrous_litter", "default:dirt_gray", "mcl_core:dirt_with_grass"},
	neighbors = {"default:fern_1", "default:fern_2", "mcl_flowers:double:fern", "mcl_flowers:fern"},
	min_light = 0,
	interval = 60,
	chance = 2000, -- 15000
	active_object_count = 2,
	min_height = 1,
	max_height = 80,
	day_toggle = true,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:dirt_with_coniferous_litter", "default:dirt_gray"})

			if nods and #nods > 0 then

				-- min herd of 2
				local iter = math.min(#nods, 2)

-- print("--- boar at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "animalworld:boar", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("animalworld:boar", S("Boar"), "aboar.png")


mobs:alias_mob("animalworld:boar", "animalworld:boar") -- compatibility


-- raw porkchop
minetest.register_craftitem(":animalworld:pork_raw", {
	description = S("Raw Pork"),
	inventory_image = "animalworld_pork_raw.png",
	on_use = minetest.item_eat(4),
	groups = {food_meat_raw = 1, food_pork_raw = 1, flammable = 2},
})

-- cooked porkchop
minetest.register_craftitem(":animalworld:pork_cooked", {
	description = S("Cooked Pork"),
	inventory_image = "animalworld_pork_cooked.png",
	on_use = minetest.item_eat(8),
	groups = {food_meat = 1, food_pork = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "animalworld:pork_cooked",
	recipe = "animalworld:pork_raw",
	cooktime = 5,
})
