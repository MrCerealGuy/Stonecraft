local S = minetest.get_translator("livingfloatlands")
local random = math.random

mobs:register_mob("livingfloatlands:ankylosaurus", {
	type = "animal",
	passive = false,
        attack_type = "dogfight",
	group_attack = true,
        attack_monsters = true,
	reach = 5,
        damage = 10,
	hp_min = 650,
	hp_max = 850,
	armor = 100,
	collisionbox = {-1.5, -0.01, -1.0, 1.1, 1.5, 1.0},
	visual = "mesh",
	mesh = "Ankylosaurus.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"textureankylosaurus.png"},
		{"textureankylosaurus2.png"},
	},
	sounds = {
		random = "livingfloatlands_ankylosaurus",
		attack = "default_punch.ogg",
                distance = 15,
	},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2,
        walk_chance = 20,
	runaway = false,
        knock_back = false,
	jump = false,
        jump_height = 6,
	stepheight = 2,
        stay_near = {{"livingfloatlands:paleodesert_fern", "livingfloatlands:puzzlegrass"}, 6},
	drops = {
		{name = "livingfloatlands:ornithischiaraw", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 25,
		stand_start = 0,
		stand_end = 100,
		walk_speed = 50,
		walk_start = 100,
		walk_end = 200,
		punch_speed = 100,
		punch_start = 250,
		punch_end = 350,
		die_start = 250,
		die_end = 350,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},

follow = {"default:apple", "default:dry_dirt_with_dry_grass", "farming:seed_wheat", "default:junglegrass", "farming:seed_oat", "livingfloatlands:paleodesert_joshua_sapling", "livingfloatlands:paleodesert_fern"},
	view_range = 10,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 15, false, nil) then return end
	end,
})


if minetest.get_modpath("ethereal") then
	spawn_on = {"ethereal:prairie_dirt", "ethereal:dry_dirt", "default:sand", "default:desert_sandstone", "default:sandstone", "default:dry_dirt_with_dry_grass"}

end

if not mobs.custom_spawn_livingfloatlands then
mobs:spawn({
	name = "livingfloatlands:ankylosaurus",
	nodes = {"livingfloatlands:paleodesert_litter"},
	neighbors = {"livingfloatlands:paleodesert_fern", "livingfloatlands:puzzlegrass"},
	min_light = 0,
	interval = 60,
	active_object_count = 3,
	chance = 2000, -- 15000
	min_height = 1,
	max_height = 31000,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"livingfloatlands:paleodesert_litter"})

			if nods and #nods > 0 then

				-- min herd of 3
				local iter = math.min(#nods, 3)

-- print("--- ankylosaurus at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "livingfloatlands:ankylosaurus", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("livingfloatlands:ankylosaurus", ("Ankylosaurus"), "aankylosaurus.png")

-- raw Ornithischia
minetest.register_craftitem(":livingfloatlands:ornithischiaraw", {
	description = S("Raw Ornithischia Meat"),
	inventory_image = "livingfloatlands_ornithischiaraw.png",
	on_use = minetest.item_eat(3),
	groups = {food_meat_raw = 1, flammable = 2},
})

-- cooked Ornithischia
minetest.register_craftitem(":livingfloatlands:ornithischiacooked", {
	description = S("Cooked Ornithischia Meat"),
	inventory_image = "livingfloatlands_ornithischiacooked.png",
	on_use = minetest.item_eat(5),
	groups = {food_meat = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "livingfloatlands:ornithischiacooked",
	recipe = "livingfloatlands:ornithischiaraw",
	cooktime = 30,
})

