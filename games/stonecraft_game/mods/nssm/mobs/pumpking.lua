mobs:register_mob("nssm:pumpking", {
	type = "monster",
	hp_max = 220,
	hp_min = 220,
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
	damage = 13,
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
		{name = "nssm:black_powder",
		chance = 1,
		min = 9,
		max = 12,},
	},
	armor =40,
	drawtype = "front",
	water_damage = 2,
	lava_damage = 5,
	light_damage = 0,
	blood_texture="nssm_blood.png",
	blood_amount=25,
	stepheight=2.1,
	knock_back=0,
	jump_height=12,
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
		self.object:remove()
		minetest.after(0.2, function(pos)
			tnt.boom(pos, {damage_radius=5,radius=4,ignore_protection=false})
		end, pos)
	end,
	custom_attack = function(self)
		self.pumpking_timer = (self.pumpking_timer or os.time())
		if (os.time() - self.pumpking_timer) >3 then
			set_animation(self, "punch")
			self.pumpking_timer = os.time()
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
				minetest.after(1, function(pos1)
					minetest.set_node(pos1, {name="nssm:pumpbomb"})
					minetest.get_node_timer(pos1):start(2)
				end,
				pos1)
			end
		end
	end
})
