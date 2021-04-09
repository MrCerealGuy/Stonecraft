
--rainbow!

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

		if os.time() - self.timer > 10 then
			minetest.set_node(pos, {name="nyancat:nyancat"})
			self.object:remove()
		end

		if minetest.get_node(pos) then
			local n = minetest.get_node(pos).name
			if n ~= "nyancat:nyancat_rainbow" then
				if n=="air" then
					minetest.set_node(pos, {name="nyancat:nyancat_rainbow"})
				else
					minetest.chat_send_all("Nome:"..n)
					minetest.set_node(pos, {name="nyancat:nyancat"})
					self.object:remove()
				end
			end
		end
	end
})

minetest.register_tool("nssm:rainbow_staff", {
	description = "Rainbow Staff",
	inventory_image = "rainbow_staff.png",
	on_use = function(itemstack, placer, pointed_thing)
		local dir = placer:get_look_dir();
		local playerpos = placer:get_pos();
		local obj = minetest.add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+2+dir.y,z=playerpos.z+0+dir.z}, "nssm:rainbow")
		local vec = {x=dir.x*6,y=dir.y*6,z=dir.z*6}
		obj:set_velocity(vec)
		return itemstack
	end,
	groups = {not_in_creative_inventory=1,}
})
