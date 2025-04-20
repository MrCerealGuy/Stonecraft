mobs:register_mob("nssm:masticone", {
	type = "monster",
	hp_max = 25,
	hp_min = 24,
	collisionbox = {-0.45, 0.00, -0.45, 0.45, 0.40, 0.45},
	visual = "mesh",
	mesh = "masticone.x",
	textures = {
		{"masticone.png"}
	},
	visual_size = {x = 4, y = 4},
	makes_footstep_sound = true,
	view_range = 15,
	lifetimer = 500,
	fear_height = 4,
	rotate = 270,
	walk_velocity = 1.5,
	run_velocity = 2.5,
	sounds = {
		random = "masticone"
	},
	damage = 5,
	jump = true,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 7, max = 8},
		{name = "nssm:masticone_fang", chance = 1, min = 1, max = 2},
		{name = "nssm:masticone_skull_fragments", chance = 2, min = 1, max = 2}
	},
	armor = 60,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 10,
	fire_damage = 10,
	floats = 0,
	light_damage = 0,
	group_attack = true,
	attack_animals = true,
	knock_back = 4,
	blood_texture = "nssm_blood_blue.png",
	stepheight = 1.1,
	attack_type = "dogfight",
	reach =1.5,
	animation = {
		speed_normal = 20,
		speed_run = 25,
		stand_start = 80,
		stand_end = 140,
		walk_start = 20,
		walk_end = 40,
		run_start = 20,
		run_end = 40,
		punch_start = 150,
		punch_end = 180
	},

	on_die = function(self, pos)

		self.object:remove()

		core.after(2, function()

			minetest.add_particlespawner({
				amount = 200,
				time = 0.1,
				minpos = {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
				maxpos = {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
				minvel = {x = -0, y = -0, z = -0},
				maxvel = {x = 1, y = 1, z = 1},
				minacc = {x = -0.5, y = 5, z = -0.5},
				maxacc = {x = 0.5, y = 5, z = 0.5},
				minexptime = 0.1,
				maxexptime = 1,
				minsize = 3,
				maxsize = 4,
				collisiondetection = false,
				texture = "tnt_smoke.png"
			})

			local respawn_count = 3

			for i = 1, respawn_count do

				local chance = math.random(1, math.ceil(respawn_count * 1.5))

				if chance == 1 then

					local pos = {
						x = pos.x + math.random(-1, 1),
						y = pos.y + 0.5,
						z = pos.z + math.random(-1, 1)
					}

					local n = minetest.get_node(pos).name

					if n == "air" then
						minetest.add_entity(pos, "nssm:masticone")
					end
				end
			end
		end)
	end
})
