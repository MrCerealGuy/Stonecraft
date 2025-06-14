mobs:register_mob("nssm:morwa", {
	type = "monster",
	hp_max = 56,
	hp_min = 49,
	collisionbox = {-1, -0.1, -1, 1, 3, 1},
	visual = "mesh",
	mesh = "morwa.x",
	textures = {
		{"morwa.png"}
	},
	visual_size = {x = 10, y = 10},
	makes_footstep_sound = true,
	view_range = 25,
	fear_height = 4,
	walk_velocity = 0.5,
	run_velocity = 4,
	sounds = {
		random = "morwa"
	},
	damage = 8,
	jump = true,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 3, max = 4},
		{name = "nssm:wrathful_soul_fragment", chance = 3, min = 1, max = 1}
	},
	armor = 50,
	drawtype = "front",
	water_damage = 0,
	reach = 4,
	rotate = 270,
	lava_damage = 0,
	fire_damage = 0,
	light_damage = 0,
	group_attack = true,
	attack_animals = true,
	knock_back = 1,
	blood_texture = "morparticle.png",
	stepheight = 1.1,
	attack_type = "dogshoot",
	dogshoot_switch = true,
	arrow = "nssm:morarrow",
	shoot_interval = 2,
	shoot_offset = 0,
	animation = {
		speed_normal = 25,
		speed_run = 25,
		stand_start = 10,
		stand_end = 40,
		walk_start = 50,
		walk_end = 90,
		run_start = 100,
		run_end = 120,
		punch_start = 130,
		punch_end = 160,
		shoot_start =176,
		shoot_end=226
	},

	do_custom = function (self)

		local pos = self.object:get_pos()
		local light = minetest.get_node_light(pos) or 0

		--minetest.chat_send_all("Luce: "..light)
		if light < 8 then
			self.object:remove()
			minetest.set_node(pos, {name = "nssm:morwa_statue"})
		end
	end
})
