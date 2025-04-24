
function nssm:do_charge(self)

	self.state = ""

	if self.charge_vec and self.charge_dir then

		self:set_animation("punch2")
		self.object:set_velocity(self.charge_vec)
		self.object:set_yaw(self.charge_dir)

		local prop = self.object:get_properties()
		local all_objects = minetest.get_objects_inside_radius(
				self.object:get_pos(), 1.5 * prop.collisionbox[5] / 2)

		for _,obj in ipairs(all_objects) do

			if obj:is_player() then
				obj:set_hp(obj:get_hp() - self.damage / 5)
			elseif obj:get_luaentity() and obj:get_luaentity().health
			and obj:get_luaentity().name ~= self.object:get_luaentity().name then
				obj:get_luaentity().health = obj:get_luaentity().health - self.damage / 5
			end
		end
	end

	if self.charge_timer and os.time() - self.charge_timer > 5 then
		self.other_state = "stand"
		self.state = "stand"
	end
end


function nssm:charge_attack(self)

	local s = self.object:get_pos()
	local p = self.attack:get_pos()
	local vec = vector.multiply(vector.normalize(
			vector.subtract(p, s)), self.run_velocity)

	if self.other_state and self.other_state == "charge" then -- mob was already charging
		nssm:do_charge(self)
	else
		self.other_state = "charge"
		vec.y = -5
		self.charge_vec = vec
		self.charge_dir = self.object:get_yaw()
		self.charge_timer = os.time()

		nssm:do_charge(self)

		minetest.after(3, function(self)
			self.other_state = "stand"
			self.state = "stand"
		end,self)
	end
end

