mobs:register_mob("nssm:flying_duck", {
	type = "monster",
	hp_max = 20,
	hp_min = 10,
	collisionbox = {-0.3, -0.2, -0.3, 0.3, 0.2, 0.3},
	visual = "mesh",
	mesh = "flying_duck.x",
	textures = {
		{"flying_duck.png"}
	},
	visual_size = {x = 1, y = 1},
	view_range = 30,
	walk_velocity = 2,
	run_velocity = 2.5,
	fall_speed = 0,
	stepheight = 3,
	sounds = {
		random = "duck"
	},
	damage = 3,
	reach = 2,
	jump = true,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 1, max = 2},
		{name = "nssm:duck_legs", chance = 2, min = 1, max = 2},
		{name = "nssm:duck_beak", chance = 5, min = 1, max = 1},
		{name = "nssm:duck_feather", chance = 2, min = 4, max = 8}
	},
	armor = 80,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	fire_damage = 5,
	light_damage = 0,
	group_attack = true,
	attack_animals = true,
	knock_back = 5,
	blood_texture = "nssm_blood.png",
	fly = true,
	attack_type = "dogfight",
	animation = {
		speed_normal = 25,
		speed_run = 25,
		stand_start = 0,
		stand_end = 80,
		walk_start = 160,
		walk_end = 200,
		run_start = 160,
		run_end = 220,
		punch_start = 110,
		punch_end = 140
	},
	do_custom = function(self, dtime)

		-- 5 second timer
		self._land_timer = (self._land_timer or 0) + dtime
		if self._land_timer < 5 then return end
		self._land_timer = 0

		-- if flying duck lands in water, change to walking/floating duck
		if minetest.get_item_group(self.standing_in, "water") > 0
		and minetest.get_item_group(self.standing_on, "water") > 0 then

			local pos = self.object:get_pos()

			if mobs:add_mob(pos, {name = "nssm:duck"}) then
				self.object:remove()
			else
				self.object:set_velocity({x = 0, y = 3, z = 0})

				local ent = self.object:get_luaentity()

				ent.state = "walk"
				ent.attack = nil
			end
		end
	end
})
