-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file crack_entity.lua
--! @brief crack simulation entity
--! @copyright Sapier
--! @author Sapier
--! @date 2015-12-27
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

local ANIMATIONSTEPS = 5 +1

minetest.register_entity("mob_miner:cracksim",
	{
		collisionbox    = { -0.49,-0.49,-0.49,0.49,0.49,0.49 },
		visual          = "cube",
		visual_size = {x=1.01, y=1.01, z=1.01},
		textures        = { "mob_miner_blank16x16.png","mob_miner_blank16x16.png","mob_miner_blank16x16.png",
							"mob_miner_blank16x16.png","mob_miner_blank16x16.png","mob_miner_blank16x16.png" },
		physical        = false,
		groups          = { "immortal" },
		on_activate = function(self, staticdata, dtime_s)
			if staticdata ~= nil and staticdata == "delme" then
				print("Staticdata on activation is: " .. dump(staticdata))
				self.object:remove()
			end
			
			self.timepassed = 0
			local ownnode = minetest.get_node_or_nil(self.object:getpos())
			
			if ownnode == nil then
				self.object:remove()
			end
			
			local nodedef = minetest.registered_nodes[ownnode.name]
			
			self.tiledef = nodedef.tiles
			self.laststep = nil
		end,
		on_step = function(self, dtime)
		
			self.timepassed = self.timepassed + dtime
			
			if self.timetotal ~= nil then
				if (self.timepassed > self.timetotal) then
					self.object:remove()
					return
				end
				
				self:update_texture()
			end
			
			if self.timepassed > 20 then
				self.object:remove()
				return
			end
		
		end,
		get_staticdata = function(self)
			return "delme"
		end,
		
		update_texture = function(self)
			
			local current_step = math.floor(self.timepassed / (self.timetotal/ANIMATIONSTEPS))
			
			if self.last_step ~= current_step then
			
				if (current_step ~= 0) then
				
					local properties = self.object:get_properties()
					--local texturename = "mob_miner_blank16x16.png^[crack:" .. (ANIMATIONSTEPS-1) .. ":" .. current_step
					local texturename = "mob_miner_blank16x16.png^[crack:1:" .. current_step
					print("New animstep detected: " .. current_step .. " Texture is: " .. texturename)
				
					properties.textures = {
						texturename, texturename, texturename,
						texturename, texturename, texturename
						}
					
					self.object:set_properties(properties)
				end
				
				
				self.last_step = current_step
			end
		end
	}
	)