mobs:register_mob("nssm:larva", {
	type = "monster",
	hp_max = 12,
	hp_min = 8,
	collisionbox = {-0.3, 0, -0.3, 0.3, 0.41, 0.3},
	visual = "mesh",
	mesh = "larva.x",
	textures = {
		{"larva.png"}
	},
	visual_size = {x = 3, y = 3},
	makes_footstep_sound = false,
	view_range = 10,
	rotate = 90,
	jump = false,
	fear_height = 4,
	jump_height = 0,
	walk_velocity = 0.4,
	run_velocity = 0.4,
	sounds = {
		random = "sand"
	},
	damage = 1,
	reach = 1,
	drops = {
		{name = "nssm:life_energy", chance = 3, min = 1, max = 1},
		{name = "nssm:larva_meat", chance = 2, min = 1, max = 2}
	},
	armor = 80,
	drawtype = "front",
	water_damage = 2,
	lava_damage = 4,
	fire_damage = 4,
	light_damage = 0,
	group_attack = true,
	attack_animals = true,
	knock_back = 2,
	blood_texture = "nssm_blood_blue.png",
	attack_type = "dogfight",
	animation = {
		speed_normal = 20,
		speed_run = 20,
		stand_start = 0,
		stand_end = 80,
		walk_start = 100,
		walk_end = 160,
		run_start = 100,
		run_end = 160,
		punch_start = 180,
		punch_end = 230
	},

	do_custom = function (self)

		self.metatimer = self.metatimer or os.time()

		if os.time() - self.metatimer > 20 then

			minetest.log("action", "metatimer expired, metamorphosis!")

			local pos = self.object:get_pos()

			self.object:remove()

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

			if math.random(2) == 1 then
				minetest.add_entity(pos, "nssm:mantis")
			else
				minetest.add_entity(pos, "nssm:mantis_beast")
			end

			return
		end
	end
})
