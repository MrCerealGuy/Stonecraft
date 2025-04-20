mobs:register_mob("nssm:night_master", {
	type = "monster",
	hp_max = 60,
	hp_min = 60,
	collisionbox = {-0.65, -0.4, -0.65, 0.65, 0.4, 0.65},
	visual = "mesh",
	mesh = "moonherontrio.x",
	textures = {
		{"moonherontrio.png"}
	},
	visual_size = {x = 18, y = 18},
	view_range = 40,
	rotate = 270,
	lifetimer = 500,
	floats=1,
	walk_velocity = 3,
	run_velocity = 4,
	fall_speed = 0,
	stepheight = 3,
	sounds = {
		random = "night_master",
		distance = 45
	},
	damage = 10,
	jump = false,
	armor = 60,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	fire_damage = 5,
	light_damage = 0,
	blood_texture = "nssm_blood.png",
	blood_amount = 50,
	fly = true,
	attack_type = "dogfight",
	animation = {
		speed_normal = 25,
		speed_run = 35,
		stand_start = 60,
		stand_end = 120,
		walk_start = 20,
		walk_end = 50,
		run_start = 20,
		run_end = 50,
		punch_start = 130,
		punch_end = 160
	},

	on_die = function(self, pos)

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

		self.object:remove()

		minetest.add_entity(pos, "nssm:night_master_2")
	end
})

mobs:register_mob("nssm:night_master_2", {
	type = "monster",
	hp_max = 60,
	hp_min = 60,
	collisionbox = {-0.65, -0.4, -0.65, 0.65, 0.4, 0.65},
	visual = "mesh",
	mesh = "night_master_2.x",
	textures = {
		{"moonherontrio.png"}
	},
	visual_size = {x = 18, y = 18},
	view_range = 40,
	rotate = 270,
	lifetimer = 500,
	floats = 1,
	walk_velocity = 3,
	run_velocity = 4,
	fall_speed = 0,
	stepheight = 3,
	sounds = {
		random = "night_master",
		distance = 45
	},
	damage = 10,
	jump = false,
	armor = 60,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	fire_damage = 5,
	light_damage = 0,
	fly = true,
	attack_type = "dogfight",
	animation = {
		speed_normal = 25,
		speed_run = 35,
		stand_start = 60,
		stand_end = 120,
		walk_start = 20,
		walk_end = 50,
		run_start = 20,
		run_end = 50,
		punch_start = 130,
		punch_end = 160
	},

	on_die = function(self, pos)

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

		self.object:remove()

		minetest.add_entity(pos, "nssm:night_master_1")
	end
})

mobs:register_mob("nssm:night_master_1", {
	type = "monster",
	hp_max = 70,
	hp_min = 70,
	collisionbox = {-0.65, -0.4, -0.65, 0.65, 0.4, 0.65},
	visual = "mesh",
	mesh = "night_master_1.x",
	textures = {
		{"moonherontrio.png"}
	},
	visual_size = {x = 18, y = 18},
	view_range = 40,
	rotate = 270,
	lifetimer = 500,
	floats=1,
	walk_velocity = 3,
	run_velocity = 4,
	fall_speed = 0,
	stepheight = 3,
	sounds = {
		random = "night_master",
		distance = 45
	},
	damage = 12,
	jump = false,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 6, max = 7},
		{name = "nssm:heron_leg", chance = 1, min = 1, max = 1},
		{name = "nssm:night_feather", chance = 1, min = 1, max = 1}
	},
	armor = 50,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	fire_damage = 5,
	light_damage = 0,
	fly = true,
	attack_type = "dogfight",
	animation = {
		speed_normal = 25,
		speed_run = 35,
		stand_start = 60,
		stand_end = 120,
		walk_start = 20,
		walk_end = 50,
		run_start = 20,
		run_end = 50,
		punch_start = 130,
		punch_end = 160
	}
})
