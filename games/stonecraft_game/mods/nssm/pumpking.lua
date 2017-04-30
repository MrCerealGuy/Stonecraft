nssm:register_mob("nssm:pumpking", {
	type = "monster",
	hp_max = 100,
	hp_min = 100,
	collisionbox = {-0.4, 0.00, -0.4, 0.4, 3.2, 0.4},
	visual = "mesh",
	mesh = "pumpking.x",
	textures = {{"pumpking.png"}},
	visual_size = {x=2.5, y=2.5},
	makes_footstep_sound = true,
	lifetimer=500,
	rotate=270,
	fear_height = 4,
	view_range = 35,
	walk_velocity = 2,
	run_velocity = 4,
    sounds = {
		random = "king",
		explode = "tnt_explode",
	},
	damage = 9,
	jump = true,
	drops = {
		{name = "nssm:life_energy",
		chance = 1,
		min = 7,
		max = 9,},
		{name = "nssm:cursed_pumpkin_seed",
		chance = 1,
		min = 1,
		max = 1,},
	},
	armor =50,
	drawtype = "front",
	water_damage = 2,
	lava_damage = 5,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		stand_start = 165,		stand_end = 210,
		walk_start = 220,		walk_end = 260,
		run_start = 220,		run_end = 260,
		punch_start = 300,		punch_end = 330,
		speed_normal = 15,		speed_run = 15,
	},
	on_die=function(self,pos)
		nssm:explosion(pos, 3, 0, 1, self.sounds.explode)
	end,
	custom_attack = function(self)
		if self.timer >3 then
			self.timer = 0
			local s = self.object:getpos()
			local p = self.attack:getpos()
			p.y = p.y + 1.5
			s.y = s.y + 1.5
			if minetest.line_of_sight(p, s) == true then
				-- play attack sound
				if self.sounds.attack then
					minetest.sound_play(self.sounds.attack, {
					object = self.object,
					max_hear_distance = self.sounds.distance
					})
				end
				local pos1 = {x=s.x+math.random(-1,1), y=s.y-1.5, z=s.z+math.random(-1,1)}
				minetest.set_node(pos1, {name="nssm:pumpbomb"})
				minetest.get_node_timer(pos1):start(2)
			end
		end
	end
})
