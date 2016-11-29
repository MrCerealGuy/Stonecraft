--rainbow!
minetest.register_entity("nssm:rainbow", {
	textures = {"transparent.png"},
	velocity = 10,
	on_step = function (self, pos, node, dtime)
				local pos = self.object:getpos()
								local n = minetest.env:get_node(pos).name
								if n ~= "default:nyancat_rainbow" then
									if n=="air" then
										minetest.env:set_node(pos, {name="default:nyancat_rainbow"})
									else
									minetest.env:set_node(pos, {name="default:nyancat"})
									self.object:remove()
								end
								end
				end
})

minetest.register_tool("nssm:rainbow_staff", {
	description = "Rainbow Staff",
	inventory_image = "rainbow_staff.png",
	on_use = function(itemstack, placer, pointed_thing)
			local dir = placer:get_look_dir();
			local playerpos = placer:getpos();
			local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+2+dir.y,z=playerpos.z+0+dir.z}, "nssm:rainbow")
			local vec = {x=dir.x*6,y=dir.y*6,z=dir.z*6}
			obj:setvelocity(vec)
		return itemstack
	end,
	groups = {not_in_creative_inventory=1,}
})
