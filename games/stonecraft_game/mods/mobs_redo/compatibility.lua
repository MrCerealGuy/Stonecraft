
-- called after mob registration to check for older settings

function mobs.compatibility_check(self)

	-- simple mobs rotation setting
	if self.drawtype == "side" then self.rotate = math.rad(90) end

	-- replace floats var from number to bool
	if self.floats == 1 then self.floats = true
	elseif self.floats == 0 then self.floats = false end
end

-- deprecated functions

function mobs:yaw(entity, yaw, delay)
	entity:set_yaw(yaw, delay)
end

function mobs:set_animation(entity, anim)
	entity:set_animation(anim)
end

function mobs:line_of_sight(entity, pos1, pos2)
	return entity:line_of_sight(pos1, pos2)
end

function mobs:yaw_to_pos(entity, target, rot)
	return entity:yaw_to_pos(target, rot)
end

function mobs:register_spawn(name, nodes, max_light, min_light, chance,
		active_object_count, max_height, day_toggle)

	mobs:spawn_specific(name, nodes, {"air"}, min_light, max_light, 30,
		chance, active_object_count, -31000, max_height, day_toggle)
end

function mobs:explosion(pos, radius)
	mobs:boom({sounds = {explode = "tnt_explode"}}, pos, radius, radius, "mobs_tnt_smoke.png")
end
