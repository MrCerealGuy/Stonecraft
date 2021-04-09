--= Chicken for Creatures MOB-Engine (cme) =--
-- Copyright (c) 2015-2016 BlockMen <blockmen2015@gmail.com>
--
-- egg.lua
--
-- This software is provided 'as-is', without any express or implied warranty. In no
-- event will the authors be held liable for any damages arising from the use of
-- this software.
--
-- Permission is granted to anyone to use this software for any purpose, including
-- commercial applications, and to alter it and redistribute it freely, subject to the
-- following restrictions:
--
-- 1. The origin of this software must not be misrepresented; you must not
-- claim that you wrote the original software. If you use this software in a
-- product, an acknowledgment in the product documentation is required.
-- 2. Altered source versions must be plainly marked as such, and must not
-- be misrepresented as being the original software.
-- 3. This notice may not be removed or altered from any source distribution.
--



local function timer(step, entity)
	if not entity then
		return
	end

	if entity.physical_state == false then
		if entity.ref then
			if math.random(1, 20) == 5 then
				core.add_entity(entity.ref:getpos(), "creatures:chicken")
			end
			entity.ref:remove()
		end
	else
		core.after(step, timer, step, entity)
	end
end

function throw_egg(player, strength)
	local pos = player:getpos()
	pos.y = pos.y + 1.5
	local dir = player:get_look_dir()
	pos.x = pos.x + dir.x
	pos.z = pos.z + dir.z
	local obj = minetest.add_item(pos, "creatures:egg")
	if obj then
		local entity = obj:get_luaentity()
		entity.ref = obj
		entity.mergeable = false
		obj:setvelocity({x = dir.x * strength, y = -3, z = dir.z * strength})
		obj:setacceleration({x = dir.x * -5 + dir.y, y = -13, z = dir.z * -5 + dir.y})
		timer(0.1, entity)
		return true
	end
	return false
end

core.register_craftitem(":creatures:egg", {
	description = "Egg",
	inventory_image = "creatures_egg.png",
	on_use = function(itemstack, user, pointed_thing)
		--if pointed_thing.type ~= "none" then
		--	return
		--end
		if throw_egg(user, 12) then
			itemstack:take_item()
		end
		return itemstack
	end,
})

core.register_craftitem(":creatures:fried_egg", {
	description = "Fried Egg",
	inventory_image = "creatures_fried_egg.png",
	on_use = core.item_eat(2)
})

core.register_craft({
	type = "cooking",
	output = "creatures:fried_egg",
	recipe = "creatures:egg",
})
