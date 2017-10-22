-- CaveRealms: falling icicles
-- borrowed from base MineTest game's falling.lua

--
-- Falling ice
--

minetest.register_entity("caverealms:falling_ice", {
	initial_properties = {
		physical = true,
		collide_with_objects = false,
		collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
		visual = "wielditem",
		textures = {},
		visual_size = {x=0.667, y=0.667},
	},

	node = {},

	set_node = function(self, node)
		self.node = node
		local stack = ItemStack(node.name)
		local itemtable = stack:to_table()
		local itemname = nil
		if itemtable then
			itemname = stack:to_table().name
		end
		local item_texture = nil
		local item_type = ""
		if minetest.registered_items[itemname] then
			item_texture = minetest.registered_items[itemname].inventory_image
			item_type = minetest.registered_items[itemname].type
		end
		prop = {
			is_visible = true,
			textures = {node.name},
		}
		self.object:set_properties(prop)
	end,

	get_staticdata = function(self)
		return self.node.name
	end,

	on_activate = function(self, staticdata)
		self.object:set_armor_groups({immortal=1})
		--self.object:setacceleration({x=0, y=-10, z=0})
		self:set_node({name=staticdata})
	end,

	on_step = function(self, dtime)
		-- Set gravity
		self.object:setacceleration({x=0, y=-10, z=0})
		-- Destroy when collides to ground or just move
		local pos = self.object:getpos()
		local bcp = {x=pos.x, y=pos.y-0.7, z=pos.z} -- Position of bottom center point
		local bcn = minetest.get_node(bcp)
		local bcd = minetest.registered_nodes[bcn.name]
		--check for players next to this and hurt them >:D
		local all_objects = minetest.get_objects_inside_radius(pos, 1)
		local _,obj
		for _,obj in ipairs(all_objects) do
			if obj:is_player() then
				obj:set_hp(obj:get_hp() - 8)
			end
		end
		-- Note: walkable is in the node definition, not in item groups
		if not bcd or
				(bcd.walkable or
				(minetest.get_item_group(self.node.name, "float") ~= 0 and
				bcd.liquidtype ~= "none")) then
			if bcd and bcd.leveled and
					bcn.name == self.node.name then
				local addlevel = self.node.level
				if addlevel == nil or addlevel <= 0 then
					addlevel = bcd.leveled
				end
				if minetest.add_node_level(bcp, addlevel) == 0 then
					self.object:remove()
					return
				end
			elseif bcd and bcd.buildable_to and
					(minetest.get_item_group(self.node.name, "float") == 0 or
					bcd.liquidtype == "none") then
				minetest.remove_node(bcp)
				return
			end
			local np = {x=bcp.x, y=bcp.y+1, z=bcp.z}
			-- Check what's here
			local n2 = minetest.get_node(np)
			-- remove node and replace it with it's drops
			local drops = minetest.get_node_drops(n2.name, "")
			minetest.remove_node(np)
			local _, dropped_item
			for _, dropped_item in ipairs(drops) do
				minetest.add_item(np, dropped_item)
			end
			-- Run script hook
			local _, callback
			for _, callback in ipairs(minetest.registered_on_dignodes) do
				callback(np, n2, nil)
			end
			-- remove entity
			--minetest.add_node(np, self.node)
			self.object:remove()
			caverealms:nodeupdate(np)
		else
			-- Do nothing
		end
	end
})

function caverealms:spawn_falling_node(p, node)
	obj = minetest.add_entity(p, "caverealms:falling_ice")
	obj:get_luaentity():set_node(node)
end

function caverealms:drop_attached_node(p)
	local nn = minetest.get_node(p).name
	minetest.remove_node(p)
	for _,item in ipairs(minetest.get_node_drops(nn, "")) do
		local pos = {
			x = p.x + math.random()/2 - 0.25,
			y = p.y + math.random()/2 - 0.25,
			z = p.z + math.random()/2 - 0.25,
		}
		minetest.add_item(pos, item)
	end
end

function caverealms:check_attached_node(p, n)
	local def = minetest.registered_nodes[n.name]
	local d = {x=0, y=0, z=0}
	if def.paramtype2 == "wallmounted" then
		if n.param2 == 0 then
			d.y = 1
		elseif n.param2 == 1 then
			d.y = -1
		elseif n.param2 == 2 then
			d.x = 1
		elseif n.param2 == 3 then
			d.x = -1
		elseif n.param2 == 4 then
			d.z = 1
		elseif n.param2 == 5 then
			d.z = -1
		end
	else
		d.y = -1
	end
	local p2 = {x=p.x+d.x, y=p.y+d.y, z=p.z+d.z}
	local nn = minetest.get_node(p2).name
	local def2 = minetest.registered_nodes[nn]
	if def2 and not def2.walkable then
		return false
	end
	return true
end

--
-- Some common functions
--

function caverealms:nodeupdate_single(p, delay)
	n = minetest.get_node(p)
	if minetest.get_item_group(n.name, "falling_node") ~= 0 then
		p_bottom = {x=p.x, y=p.y-1, z=p.z}
		n_bottom = minetest.get_node(p_bottom)
		-- Note: walkable is in the node definition, not in item groups
		if minetest.registered_nodes[n_bottom.name] and
				(minetest.get_item_group(n.name, "float") == 0 or
					minetest.registered_nodes[n_bottom.name].liquidtype == "none") and
				(n.name ~= n_bottom.name or (minetest.registered_nodes[n_bottom.name].leveled and
					minetest.get_node_level(p_bottom) < minetest.get_node_max_level(p_bottom))) and
				(not minetest.registered_nodes[n_bottom.name].walkable or
					minetest.registered_nodes[n_bottom.name].buildable_to) then
			if delay then
				minetest.after(0.1, caverealms.nodeupdate_single, {x=p.x, y=p.y, z=p.z}, false)
			else
				n.level = minetest.env:get_node_level(p)
				minetest.remove_node(p)
				caverealms:spawn_falling_node(p, n)
				caverealms:nodeupdate(p)
			end
		end
	end

	if minetest.get_item_group(n.name, "attached_node") ~= 0 then
		if not caverealms:check_attached_node(p, n) then
			caverealms:drop_attached_node(p)
			caverealms:nodeupdate(p)
		end
	end
end

function caverealms:nodeupdate(p, delay)
	-- Round p to prevent falling entities to get stuck
	p.x = math.floor(p.x+0.5)
	p.y = math.floor(p.y+0.5)
	p.z = math.floor(p.z+0.5)

	for x = -1,1 do
	for y = -1,1 do
	for z = -1,1 do
		caverealms:nodeupdate_single({x=p.x+x, y=p.y+y, z=p.z+z}, delay or not (x==0 and y==0 and z==0))
	end
	end
	end
end

