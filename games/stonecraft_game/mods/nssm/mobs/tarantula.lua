mobs:register_mob("nssm:tarantula", {
	type = "monster",
	hp_max = 50,
	hp_min = 50,
	collisionbox = {-0.5, 0.00, -0.5, 0.5, 0.9, 0.5},
	visual = "mesh",
	mesh = "tarantula.x",
	textures = {{"tarantula.png"}},
	visual_size = {x=8, y=8},
	makes_footstep_sound = true,
	view_range = 20,
	lifetimer = 500,
	walk_velocity = 0.7,
	fear_height = 4,
	run_velocity = 3,
    rotate = 270,
    sounds = {
		random = "tarry",
	},
	damage = 8,
	jump = true,
	drops = {
		{name = "nssm:super_silk_gland",
		chance = 1,
		min = 3,
		max = 5,},
	},
	armor = 60,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 7,
	reach = 3,
	knock_back=0,
	blood_texture="nssm_blood_blue.png",
	stepheight=1.1,
	light_damage = 0,
	on_rightclick = nil,
	dogshoot_switch = true,
	attack_type = "dogshoot",
    arrow = "nssm:thickwebball",
    shoot_interval = 2,
    shoot_offset = 1,
	animation = {
		speed_normal = 20,
		speed_run = 25,
		stand_start = 1,
		stand_end = 60,
		walk_start = 100,
		walk_end = 140,
		run_start = 140,
		run_end = 160,
		punch_start = 180,
		punch_end = 200,
		shoot_start = 180,
		shoot_end = 200,
	},
	on_die = function(self, pos)
		self.object:remove()
		minetest.add_particlespawner(
			200, --amount
			0.1, --time
			{x=pos.x-1, y=pos.y-1, z=pos.z-1}, --minpos
			{x=pos.x+1, y=pos.y+1, z=pos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=1, y=1, z=1}, --maxvel
			{x=-0.5,y=5,z=-0.5}, --minacc
			{x=0.5,y=5,z=0.5}, --maxacc
			0.1, --minexptime
			1, --maxexptime
			3, --minsize
			4, --maxsize
			false, --collisiondetection
			"tnt_smoke.png" --texture
		)
		minetest.add_entity(pos, "nssm:tarantula_propower")
	end,
})


mobs:register_mob("nssm:tarantula_propower", {
	type = "monster",
	hp_max = 90,
	hp_min = 90,
	collisionbox = {-0.5, 0.00, -0.5, 0.5, 1, 0.5},
	visual = "mesh",
	mesh = "tarantula_propower.x",
	textures = {{"tarantula.png"}},
	visual_size = {x=10, y=10},
	makes_footstep_sound = true,
	view_range = 30,
	lifetimer = 500,
	walk_velocity = 1.5,
	run_velocity = 3.3,
    rotate = 270,
    sounds = {
		random = "tarry",
	},
	damage = 12,
	jump = true,
	drops = {
		{name = "nssm:life_energy",
		chance = 1,
		min = 16,
		max = 18,},
		{name = "nssm:spider_leg",
		chance = 1,
		min = 1,
		max = 8,},
		{name = "nssm:tarantula_chelicerae",
		chance = 1,
		min = 1,
		max = 1,},
		{name = "nssm:silk_gland",
		chance = 2,
		min = 1,
		max = 3,},
		{name = "nssm:spider_meat",
		chance = 2,
		min = 1,
		max = 2,},
	},
	armor = 40,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 3,
	reach = 4,
	knock_back=0,
	blood_texture="nssm_blood_blue.png",
	stepheight=2.1,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 20,
		speed_run = 25,
		stand_start = 1,
		stand_end = 60,
		walk_start = 100,
		walk_end = 140,
		run_start = 140,
		run_end = 160,
		punch_start = 180,
		punch_end = 200,
	}
})
