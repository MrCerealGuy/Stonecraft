local S = minetest.get_translator("livingcavesmobs")
local random = math.random

mobs:register_mob("livingcavesmobs:explodingbacteria", {
stepheight = 0,
	type = "animal",
	passive = false,
	attack_type = "explode",
	explosion_radius = 2,
	explosion_damage__radius = 6,
	explosion_timer = 2,
	attack_npcs = false,
	attack_animals = false,
	reach = 3,
	damage = 18,
	hp_min = 15,
	hp_max = 30,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4,  0.4, 0.4, 0.4},
	visual = "mesh",
	visual_size = {x = 2.6, y = 2.6},
	mesh = "Explodingbacteria.b3d",
	drawtype = "front",
	textures = {
		{"textureexplodingbacteria.png"},

	},
sounds = {
		random = "",},
	makes_footstep_sound = false,
	walk_velocity = 1.5,
	run_velocity = 2,
	runaway = false,
	jump = false,
	jump_height = 6,
        stay_near = {{"livingcaves:bacteriacave_nest"}, 5},
	sounds = {
		attack = "livingcavesmobs_explodingbacteria",
		random = "livingcavesmobs_explodingbacteria3",
		damage = "livingcavesmobs_explodingbacteria2",
		distance = 10,
	},
	drops = {
		{name = "tnt:gunpowder", chance = 1, min = 0, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 0,
	animation = {
		speed_normal = 50,
		stand_start = 1,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		walk_start = 200,
		walk_end = 300,
		fly_start = 200, -- swim animation
		fly_end = 300,
		punch_start = 300,
		punch_end = 400,
	},
	fly_in = {"air"},
	floats = 1,
	fly = true,
	follow = {"default:stone", "default:coal", "livingcaves:hangingmoldend", "livingcaves:hangingmold"},
	view_range = 13,
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})


if not mobs.custom_spawn_livingcavesmobs then
mobs:spawn({
	name = "livingcavesmobs:explodingbacteria",
	nodes = {"livingcaves:bacteriacave_nest"},
	neighbors = {"livingcaves:bacteriacave_nestfoot"},
	min_light = 0,
	interval = 10,
	chance = 1, 
	active_object_count = 4,
	min_height = -400,
	max_height = -200,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"livingcaves:bacteriacave_nest"})

			if nods and #nods > 0 then

				-- min herd of 4
				local iter = math.min(#nods, 4)

-- print("--- explodingbacteria at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "livingcavesmobs:explodingbacteria", child = kid})
					end
				end
			end
		end
	})
end


mobs:register_egg("livingcavesmobs:explodingbacteria", S("Giant Bacteria"), "aexplodingbacteria.png", 0)


mobs:alias_mob("livingcavesmobs:explodingbacteria", "livingcavesmobs:explodingbacteria") -- compatibility