-- The Rainbow Staff is a reward for defeating the final boss
-- Classic implementation produces ranbow blocks in any direction it is pointed at and used
-- This tends to be problematic on servers, so is replaced with a powerful tool instead
-- if classic rainbow staff is not enabled

-- How long the rainbow generating entity should remain in existence, Used to be 10,
-- really should not last so long, given that it adds rainbow on every server step...
local max_rainbow_time = 1

if nssm.classic_rainbow_staff
and minetest.registered_nodes["nyancat:nyancat_rainbow"] then

	minetest.register_entity("nssm:rainbow", {
		textures = {"transparent.png"},
		velocity = 10,
		hp_max = 50,

		on_step = function (self, pos, node, dtime)

			self.timer = self.timer or os.time()

			local pos = self.object:get_pos()

			if minetest.is_protected(pos, "") then
				return
			end

			if os.time() - self.timer > max_rainbow_time then
				minetest.set_node(pos, {name = "nyancat:nyancat"})
				self.object:remove()
			end

			if minetest.get_node(pos) then

				local n = minetest.get_node(pos).name

				if n ~= "nyancat:nyancat_rainbow" then

					if n == "air" then
						minetest.set_node(pos, {name = "nyancat:nyancat_rainbow"})
					else
						minetest.chat_send_all("Nome:" .. n)
						minetest.set_node(pos, {name = "nyancat:nyancat"})

						self.object:remove()
					end
				end
			end
		end
	})

	minetest.register_tool("nssm:rainbow_staff", {
		description = "Rainbow Staff",
		inventory_image = "rainbow_staff.png",
		groups = {not_in_creative_inventory = 1},

		on_use = function(itemstack, placer, pointed_thing)

			local dir = placer:get_look_dir()
			local playerpos = placer:get_pos()
			local obj = minetest.add_entity({
				x = playerpos.x + dir.x,
				y = playerpos.y + 2 + dir.y,
				z = playerpos.z + dir.z
			}, "nssm:rainbow")

			local vec = {x = dir.x * 6, y = dir.y * 6, z = dir.z * 6}

			obj:set_velocity(vec)

			return itemstack
		end
	})

else

	minetest.register_tool("nssm:rainbow_staff", {
		description = "Rainbow Bludgeon",
		inventory_image = "rainbow_staff.png",
		tool_capabilities = {
			full_punch_interval = 0.2,
			max_drop_level = 1,
			groupcaps = {
				snappy = {
					times = {[1] = 0.80, [2] = 0.40, [3] = 0.20}, uses = 70, maxlevel = 1
				},
				crumbly = {
					times = {[1] = 0.80, [2] = 0.40, [3] = 0.20}, uses = 70, maxlevel = 1
				},
				choppy = {
					times = {[1] = 0.80, [2] = 0.40, [3] = 0.20}, uses = 70, maxlevel = 1
				},
				cracky = {
					times = {[1] = 0.80, [2] = 0.40, [3] = 0.20}, uses = 70, maxlevel = 1
				},
				fleshy = {
					times = {[1] = 0.80, [2] = 0.60, [3] = 0.20}, uses = 140, maxlevel = 1
				}
			},
			damage_groups = {fleshy = 40},
		},

		groups = {not_in_creative_inventory = 1}
	})
end
