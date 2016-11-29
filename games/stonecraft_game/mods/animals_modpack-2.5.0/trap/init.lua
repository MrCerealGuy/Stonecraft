-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
  dofile(minetest.get_modpath("intllib").."/intllib.lua")
  S = intllib.Getter(minetest.get_current_modname())
else
  S = function ( s ) return s end
end

local version = "0.0.3"

minetest.log("action","MOD: trap mod loading ...")

minetest.register_craftitem("trap:undead", {
			description = S("Trap for undead mobs"),
			image = minetest.inventorycube("trap_undead.png","trap_undead.png","trap_undead.png"),
			on_place = function(item, placer, pointed_thing)
				if pointed_thing.type == "node" then
					local pos = pointed_thing.above
			
					local newobject = minetest.add_entity(pos,"trap:undead_ent")

					item:take_item()

					return item
				end
			end
		})
		
minetest.register_craft({
	output = "trap:undead 1",
	recipe = {
		{'default:wood', 'default:wood','default:wood'},
		{'default:wood', "animalmaterials:scale_golden",'default:wood'},
		{'default:wood','default:wood','default:wood'},
	}
})

--Entity
minetest.register_entity(":trap:undead_ent",
	{
		physical 		= true,
		collisionbox 	= {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
		visual 			= "cube",
		textures 		= {"trap_undead.png","trap_undead.png","trap_undead.png","trap_undead.png","trap_undead.png","trap_undead.png"},

		on_step = function(self,dtime)

			local now = os.time(os.date('*t'))
			
			if now ~= self.last_check_time then
			
				local pos = self.object:getpos()
			
				local objectlist = minetest.get_objects_inside_radius(pos,2)
				
				for index,value in pairs(objectlist) do
				
					--print("checking " .. index .. ": ",value)
					local luaentity = value:get_luaentity()
					
					--TODO check if mobf names are required to use here
					if luaentity ~= nil and
						luaentity.name == "animal_vombie:vombie" then
						spawning.remove(luaentity)
						
						self.object:remove()
						
						minetest.add_node(pos,{name="trap:cought_vombie"})
					end
				
				end
			
				self.last_check_time = now
			end
		end,
		
		on_punch = function(self,player)
			player:get_inventory():add_item("main", "trap:undead 1")	
			self.object:remove()	
		end,

		last_check_time = -1,
	})
	

minetest.register_node("trap:cought_vombie", {
		description = S("Trap containing vombie"),
		tiles = {"trap_cought_vombie.png"},
		drawtype = "normal",
		groups = { snappy=3 },
		drop = "animal_vombie:vombie",
		light_source = 2,
	})
	
minetest.log("action","MOD: trap mod                    version " .. version .. " loaded")
