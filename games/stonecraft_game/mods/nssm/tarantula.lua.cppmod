nssm:register_mob("nssm:tarantula", {
	type = "monster",
	hp_max = 30,
	hp_min = 30,
	collisionbox = {-0.5, 0.00, -0.5, 0.5, 0.9, 0.5},
	visual = "mesh",
	mesh = "tarantula.x",
	textures = {{"tarantula.png"}},
	visual_size = {x=8, y=8},
	makes_footstep_sound = true,
	view_range = 20,
	lifetimer = 500,
	walk_velocity = 1.5,
	fear_height = 4,
	run_velocity = 3,
    rotate = 270,
    sounds = {
		random = "tarry",
	},
	damage = 5,
	jump = true,
	armor = 80,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 7,
	reach = 3,
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
	},
	on_die = function(self, pos)
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


nssm:register_mob("nssm:tarantula_propower", {
	type = "monster",
	hp_max = 70,
	hp_min = 70,
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
	damage = 10,
	jump = true,
	drops = {
		{name = "nssm:life_energy",
		chance = 1,
		min = 1,
		max = 2,},
		{name = "nssm:spider_leg",
		chance = 1,
		min = 1,
		max = 8,},
		{name = "nssm:tarantula_chelicerae",
		chance = 1,
		min = 1,
		max = 1,},
	},
	armor = 60,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 3,
	reach = 4,
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
