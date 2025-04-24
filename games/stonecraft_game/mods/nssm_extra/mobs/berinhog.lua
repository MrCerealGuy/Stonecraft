mobs:register_mob("nssm:berinhog", {
	type = "monster",
	hp_max = 36,
	hp_min = 27,
	collisionbox = {-0.5, 0, -0.5, 0.5, 2.2, 0.5},
	visual = "mesh",
	mesh = "berinhog.x",
	textures = {{"berinhog.png"}},
	visual_size = {x = 5, y = 5},
	makes_footstep_sound = true,
	view_range = 18,
	rotate = 270,
	walk_velocity = 1,
	fear_height = 4,
	run_velocity = 3.6,
	sounds = {
		random = "berinhog",
	},
	damage = 6,
	jump = true,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 5, max = 7},
--		{name = "nssm:berinhog_steak", chance = 2, min = 1, max = 2},
--		{name = "nssm:berinhog_fur", chance = 2, min = 1, max = 1},
--		{name = "nssm:berinhog_horn", chance = 3, min = 1, max = 2},
	},
	armor = 70,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 15,
	suffocation = 4,
	reach = 3,
	light_damage = 0,
	group_attack = true,
	attack_animals = true,
	knock_back = 0,
	blood_texture = "nssm_blood.png",
	stepheight = 1.1,
	attack_type = "dogfight",
	animation = {
		speed_normal = 20, speed_run = 20,
		stand_start = 0, stand_end = 40,
		walk_start = 210, walk_end = 250,
		run_start = 140, run_end = 160,
		punch_start = 170, punch_end = 200,
		die_start = 110, die_end = 130,
	},

	do_custom = function(self)

		self.berinhog_timer = self.berinhog_timer or os.time()

		if os.time() - self.berinhog_timer > 1 then

			self.berinhog_timer = os.time()

			local all_objects = minetest.get_objects_inside_radius(self.object:get_pos(), 1)

			for _,obj in ipairs(all_objects) do

				if obj:is_player() then
					obj:set_hp(obj:get_hp() - 1)
				elseif obj:get_luaentity() and obj:get_luaentity().health
				and obj:get_luaentity().name ~= self.object:get_luaentity().name then
					obj:get_luaentity().health = obj:get_luaentity().health - 1
				end
			end
		end
	end
})

