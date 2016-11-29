
--function
function spears_shot (itemstack, player)
	local spear = itemstack:get_name() .. '_entity'
	local playerpos = player:getpos()
	local obj = minetest.add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, spear)
	local dir = player:get_look_dir()
	local sp = 16
	local dr = .3
	local gravity = 9.8
	obj:setvelocity({x=dir.x*sp, y=dir.y*sp, z=dir.z*sp})
	obj:setacceleration({x=-dir.x*dr, y=-gravity, z=-dir.z*dr})
	obj:setyaw(player:get_look_yaw()+math.pi)
	minetest.sound_play("spears_sound", {pos=playerpos})
	obj:get_luaentity().wear = itemstack:get_wear()
	return true
end

function spears_set_entity(kind, eq, toughness)
	local SPEAR_ENTITY={
		physical = false,
		timer=0,
		visual = "wielditem",
		visual_size = {x=0.15, y=0.1},
		textures = {"nssm:spear_" .. kind},
		lastpos={},
		collisionbox = {0,0,0,0,0,0},
		on_punch = function(self, puncher)
			if puncher then
				if puncher:is_player() then
					local stack = {name='nssm:spear_' .. kind, wear=self.wear+65535/toughness}
					local inv = puncher:get_inventory()
					if inv:room_for_item("main", stack) then
						inv:add_item("main", stack)
						self.object:remove()
					end
				end
			end
		end,
	}
	
	SPEAR_ENTITY.on_step = function(self, dtime)
		self.timer=self.timer+dtime
		local pos = self.object:getpos()
		local node = minetest.get_node(pos)
		if not self.wear then
			self.object:remove()
			return
		end
		if self.lastpos.x~=nil then
			if node.name ~= "air" and not (string.find(node.name, 'grass') and not string.find(node.name, 'dirt')) and not string.find(node.name, 'flowers:') and not string.find(node.name, 'farming:') then
				self.object:remove()
				if self.wear+65535/toughness < 65535 then
					minetest.add_item(self.lastpos, {name='nssm:spear_' .. kind, wear=self.wear+65535/toughness})
				end
			elseif self.timer>0.2 then
				local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)
				for k, obj in pairs(objs) do
					if obj:get_luaentity() ~= nil then
						if obj:get_luaentity().name ~= "nssm:spear_" .. kind .. "_entity" and obj:get_luaentity().name ~= "__builtin:item" then
							local speed = vector.length(self.object:getvelocity())
							local damage = (speed + eq)^1.12-20
							obj:punch(self.object, 1.0, {
								full_punch_interval=1.0,
								damage_groups={fleshy=damage},
							}, nil)
							self.object:remove()
							if self.wear+65535/toughness < 65535 then
								minetest.add_item(self.lastpos, {name='nssm:spear_' .. kind, wear=self.wear+65535/toughness})
							end
						end
					end
				end
			end
		end
		self.lastpos={x=pos.x, y=pos.y, z=pos.z}
	end
	return SPEAR_ENTITY
end

--Tools

function spears_register_spear(kind, desc, eq, toughness, material)

	minetest.register_tool("nssm:spear_" .. kind, {
		description = desc .. " spear",
                wield_image = "spear_" .. kind .. ".png",
		inventory_image = "spear_" .. kind .. ".png^[transform4",
		wield_scale= {x=2,y=1,z=1},
		on_drop = function(itemstack, user, pointed_thing)
			spears_shot(itemstack, user)
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end,
		on_place = function(itemstack, user, pointed_thing)
			minetest.add_item(pointed_thing.above, itemstack)
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end,
		tool_capabilities = {
			full_punch_interval = 1.3,
			max_drop_level=1,
			groupcaps={
				snappy = {times={[3]=0.2, [2]=0.2, [1]=0.2}, uses=toughness, maxlevel=1},
			},
			damage_groups = {fleshy=eq},
		}
	})
	
	SPEAR_ENTITY=spears_set_entity(kind, eq, toughness)
	
	minetest.register_entity("nssm:spear_" .. kind .. "_entity", SPEAR_ENTITY)
	
	minetest.register_craft({
		output = 'nssm:spear_' .. kind,
		recipe = {
			{'group:wood', 'group:wood', material},
		}
	})
	
	minetest.register_craft({
		output = 'nssm:spear_' .. kind,
		recipe = {
			{material, 'group:wood', 'group:wood'},
		}
	})
end


spears_register_spear('ant', 'Ant', 6, 25, 'nssm:ant_mandible')

spears_register_spear('mantis', 'Mantis', 6, 10, 'nssm:mantis_claw')

spears_register_spear('manticore', 'Manticore', 8, 8, 'nssm:manticore_spine')

spears_register_spear('ice_tooth', 'Ice Tooth', 16, 200, 'nssm:ice_tooth')

spears_register_spear('little_ice_tooth', 'Little Ice Tooth', 7, 10, 'nssm:little_ice_tooth')

spears_register_spear('duck_beak', 'Duck Beak', 5, 6, 'nssm:duck_beak')
