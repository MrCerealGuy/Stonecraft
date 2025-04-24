
-- tools

minetest.register_tool(":nssm:ice_sword", {
	description = "Ice Sword",
	inventory_image = "ice_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level = 1,
		groupcaps = {
			snappy = {times = {[1] = 0.4, [2] = 0.3, [3] = 0.2}, uses = 300, maxlevel = 1},
			fleshy = {times = {[2] = 0.7, [3] = 0.3}, uses = 300, maxlevel = 1}
		},
		damage_groups = {fleshy = 12},
	},

	on_drop = function(itemstack, dropper, pos)

		local objects = minetest.get_objects_inside_radius(pos, 10)
		local flag = 0
		local vec = dropper:get_look_dir()
		local pos = dropper:get_pos()

		for i = 1, 4 do
			pos = vector.add(pos, vec)
		end

		local pname = dropper:get_player_name()
		local player_inv = minetest.get_inventory({type = "player", name = pname})
		local found = 0

		for i = 1, 32 do

			local items = player_inv:get_stack("main", i)
			local n = items:get_name()

			if n == "nssm:life_energy" then
				found = i
				break
			end
		end

		if found == 0 then
			minetest.chat_send_player(pname, "You haven't got any Life Energy!")
			return
		else

			local items = player_inv:get_stack("main", found)

			items:take_item()

			player_inv:set_stack("main", found, items)

			for dx = -1, 1 do
				for dz = -1, 1 do

					local pos = {x = pos.x + dx, y = pos.y - 1, z = pos.z + dz}

					if not minetest.is_protected(pos, "")
					or not minetest.get_item_group(
							minetest.get_node(pos).name, "unbreakable") == 1 then

						minetest.set_node(pos, {name = "default:ice"})
					end
				end
			end
		end
	end
})

minetest.register_tool(":nssm:earth_warhammer", {
	description = "Earth Warhammer",
	inventory_image = "earth_warhammer.png",
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level = 1,
		groupcaps = {
			snappy = {times = {[1] = 0.4, [2] = 0.3, [3] = 0.2}, uses = 300, maxlevel = 1},
			fleshy = {times = {[2] = 0.7, [3] = 0.3}, uses = 300, maxlevel = 1}
		},
		damage_groups = {fleshy = 12},
	},

	on_drop = function(itemstack, dropper, pos)

		local objects = minetest.env:get_objects_inside_radius(pos, 10)
		local flag = 0

		for _,obj in ipairs(objects) do

			local part = 0

			if flag == 0 then

				local pname = dropper:get_player_name()
				local player_inv = minetest.get_inventory({type = "player", name = pname})

				if player_inv:is_empty("main") then
--					minetest.chat_send_all("Inventory empty")
				else
					local found = 0

					for i = 1, 32 do

						local items = player_inv:get_stack("main", i)
						local n = items:get_name()

						if n == "nssm:energy_globe" then
							found = i
							break
						end
					end

					if found == 0 then
						minetest.chat_send_player(pname, "You haven't got any Energy Globe!")
						return
					else
						local pos = obj:get_pos()

						pos.y = pos.y - 3

						if obj:is_player() then

							if obj:get_player_name() ~= dropper:get_player_name() then

								part = 1
								obj:set_pos(pos)
--								flag = 1

								local items = player_inv:get_stack("main", found)

								items:take_item()

								player_inv:set_stack("main", found, items)
							end
						else
							if obj:get_luaentity().health then
								obj:get_luaentity().old_y = pos.y
								obj:set_pos(pos)
								part = 1
--								flag = 1

								local items = player_inv:get_stack("main", found)

								items:take_item()

								player_inv:set_stack("main", found, items)
							end
						end
					end
				end
			end
		end
	end
})

minetest.register_tool(":nssm:earth_sword", {
	description = "Earth Sword",
	inventory_image = "earth_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level = 1,
		groupcaps = {
			snappy = {times = {[1] = 0.4, [2] = 0.3, [3] = 0.2}, uses = 300, maxlevel = 1},
			fleshy = {times = {[2] = 0.7, [3] = 0.3}, uses = 300, maxlevel = 1}
		},
		damage_groups = {fleshy = 12},
	},

	on_drop = function(itemstack, dropper, pos)

		local objects = minetest.get_objects_inside_radius(pos, 10)
		local flag = 0
		local vec = dropper:get_look_dir()
		local pos = dropper:get_pos()
--		vec.y = 0

		for i = 1, 6 do
			pos = vector.add(pos, vec)
		end

		local pname = dropper:get_player_name()
		local player_inv = minetest.get_inventory({type = "player", name = pname})
		local found = 0

		for i = 1, 32 do

			local items = player_inv:get_stack("main", i)
			local n = items:get_name()

			if n == "nssm:energy_globe" then
				found = i
				break
			end
		end

		if found == 0 then
			minetest.chat_send_player(pname, "You haven't got any Energy Globe!")
			return
		else
			local items = player_inv:get_stack("main", found)

			items:take_item()

			player_inv:set_stack("main", found, items)

			for dx = -1, 1 do
				for dy = -12, 3 do
					for dz = -1, 1 do

						local pos = {x = pos.x + dx, y = pos.y + dy, z = pos.z + dz}

						if not minetest.is_protected(pos, "")
						or not minetest.get_item_group(
								minetest.get_node(pos).name, "unbreakable") == 1 then

							minetest.set_node(pos, {name = "air"})
						end
					end
				end
			end
		end
	end
})

