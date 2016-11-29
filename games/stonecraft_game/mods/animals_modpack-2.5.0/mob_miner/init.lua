-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief npc implementation
--! @copyright Sapier
--! @author Sapier
--! @date 2015-12-20
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

mobf_assert_backtrace(not core.global_exists("mob_miner"))
mob_miner = {}

--!path of mod
local miner_modpath = minetest.get_modpath("mob_miner")

local version = "0.1.1"

--include debug trace functions
dofile (miner_modpath .. "/constants.lua")
dofile (miner_modpath .. "/utils.lua")
dofile (miner_modpath .. "/ui.lua")
dofile (miner_modpath .. "/names_m_de.lua")
dofile (miner_modpath .. "/crack_entity.lua")

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
  dofile(minetest.get_modpath("intllib").."/intllib.lua")
  S = intllib.Getter(minetest.get_current_modname())
else
  S = function ( s ) return s end
end


minetest.log("action","MOD: mob_miner mod loading ...")

					
local miner_activate = function(entity)
	local mydata = entity:get_persistent_data()

	--!initialize custom entity functions
	entity.getDirection = mob_miner.getDirection
	entity.completeDig = mob_miner.complete_dig
	entity.add_item = mob_miner.add_to_inventory
	entity.add_wear = mob_miner.add_wear
	entity.stepforward = mob_miner.stepforward
	entity.update_digpos = mob_miner.update_digpos
	
    if (mydata.control == nil ) then
        mydata.control = {
            digstate = "idle",
        }
    end
    
    if (mydata.inventory == nil) then
        mydata.inventory = {}
    end
    
    if type(mydata.control.digpos) ~= "table" then
        mydata.control.digpos= nil
    end
    
    if (mydata.control.digstate == "idle_nothing_to_dig") then
        mydata.control.digstate = "idle"
    end
    
    if (mydata.control.digstate == "idle") then
        entity:set_state("default")
    elseif (mydata.control.digstate == "digging") then
        entity:set_state("digging")
    elseif (mydata.control.digstate == "follow") then
    		entity:set_state("relocate")
    end
    
    if mydata.name == nil then
        
        mydata.name = MINER_NAMES[math.random(#MINER_NAMES)]
    end
    
    if mydata.inventory == nil then
        mydata.inventory = {}
    end
    
    if mydata.inventory.tools == nil then
        mydata.inventory.tools = {}
    end
    
    if mydata.inventory.digged == nil then
        mydata.inventory.digged = {}
    end
    
    if mydata.digspec == nil or 
       #mydata.digspec ~= MINER_MAX_TUNNEL_SIZE then
        mydata.digspec = {}
    end
    
    for x = 1, MINER_MAX_TUNNEL_SIZE, 1 do
        if mydata.digspec[x] == nil or 
           #mydata.digspec[x] ~= MINER_MAX_TUNNEL_SIZE then
            mydata.digspec[x] = {}
            
            for y = 1, MINER_MAX_TUNNEL_SIZE, 1 do
              mydata.digspec[x][y] = false
            end
        end
    end
    
    mydata.digspec[3][1] = true
    mydata.digspec[3][2] = true
    
    if  mydata.control.soundtime == nil then
        mydata.control.soundtime = 0
    end
    
    mydata.unique_entity_id = string.gsub(tostring(entity),"table: ","")
    entity.dynamic_data.miner_formspec_data = {}
    entity.dynamic_data.miner_data = {}
    
    if entity.dynamic_data.spawning.spawner ~= nil then
    	entity.dynamic_data.movement.target = core.get_player_by_name(entity.dynamic_data.spawning.spawner)
    end
end

mob_miner.stepforward  = function(entity)
    local pos = entity.object:getpos()
    local basepos = entity:getbasepos()
    local direction = entity:getDirection()
    
    local targetpos = pos
    local targetbasepos = basepos
    
    if (direction == DIR_EAST) then
        targetpos = {x=pos.x+1, z=pos.z, y=pos.y}
        targetbasepos = {x=basepos.x+1, z=basepos.z, y=basepos.y}
    elseif(direction == DIR_WEST) then
        targetpos = {x=pos.x-1, z=pos.z, y=pos.y}
        targetbasepos = {x=basepos.x-1, z=basepos.z, y=basepos.y}
    elseif (direction == DIR_NORTH) then
        targetpos = {x=pos.x, z=pos.z+1, y=pos.y}
        targetbasepos = {x=basepos.x, z=basepos.z+1, y=basepos.y}
    elseif (direction == DIR_SOUTH) then
        targetpos = {x=pos.x, z=pos.z-1, y=pos.y}
        targetbasepos = {x=basepos.x, z=basepos.z-1, y=basepos.y}
    end
    
    if (environment.pos_is_ok(targetbasepos,entity,true) == "ok") then
       entity.object:moveto( targetpos, true)
       return true
    end

    return false
end

mob_miner.add_wear = function(entity, toolname, wear)
	local inventory = entity:get_persistent_data().inventory.tools

    --! digging using hand
    if (toolname == "") then
        return true
    end
    
    local old_count = #inventory

    for i = 1, #inventory, 1 do
        if (inventory[i] ~= nil) then
            if (inventory[i].name == toolname) then
                inventory[i].wear = inventory[i].wear + wear
                if (inventory[i].wear > 65535) then
                	local new_inventory = {}
                	inventory[i] = nil
                	
                	for i=1, old_count, 1 do
                		if inventory[i] ~= nil then
                			table.insert(new_inventory, inventory[i])
                		end
                	end
                	
                	entity:get_persistent_data().inventory.tools = new_inventory
                end
                return true
            end
        end
    end
    
    return false
end

mob_miner.add_to_inventory = function(entity, itemname)
	local inventory = entity:get_persistent_data().inventory.digged

    local done = false
    
    local temp_stack =  ItemStack( { name=itemname })
    local stack_max = temp_stack:get_stack_max()

    for i = 1, #inventory, 1 do
        if (inventory[i].name == itemname) then
           
            if (inventory[i].count < stack_max) then
                inventory[i].count = inventory[i].count +1
                done = true
            end
        end
    end
    
    if not done and #inventory < 16 then
        table.insert(inventory, temp_stack:to_table())
        done = true
    end
    
    return done
end

mob_miner.update_digpos = function(entity)
	local data = entity:get_persistent_data()
    local basepos = entity:getbasepos()
    local direction = entity:getDirection()
    local non_air_node_detected = false
    local digpositions = mob_miner.get_pos2dig_list(direction, basepos, data.digspec)
            
    for i, v in ipairs(digpositions) do
      local nodeat = core.get_node(v)
      
      if (nodeat.name ~= "air") then
          non_air_node_detected = true;
          --! use hand time as reference
          local digtime, wear, group = mob_miner_calc_digtime(MINER_HAND_TOOLDEF, nodeat.name)
          local used_tool = ""
          
          
          for i=1, #data.inventory.tools, 1 do
              if (data.inventory.tools[i] ~= nil) then
                local toolname = data.inventory.tools[i].name
                local tooldef = core.registered_tools[toolname]
            
                if ( tooldef ~= nil) then
                    local tooldigtime, toolwear, toolgroup = mob_miner_calc_digtime(tooldef, nodeat.name)
                    
                    if (digtime < 0) or 
                        ((tooldigtime > 0) and (tooldigtime < digtime)) then
                        used_tool = toolname
                        digtime = tooldigtime
                        wear = toolwear
                        group = toolgroup
                    end
                end
              end
          end
          
          if (digtime > 0) then
              data.control.digpos = v
              data.control.digtime = 0
              if (data.control.soundtime < 0) or (data.control.soundtime == nil) then
                  data.control.soundtime = MINER_DIG_SOUND_INTERVAL
              end
              data.control.used_tool = used_tool
              data.control.diggroup = group
              
              --print("Using " .. used_tool .. " to dig " .. nodeat.name .. " in " .. digtime .. " seconds group is: " .. group)
              data.control.timetocomplete = digtime
              data.control.add_wear_oncomplete = wear
              break
          else
              local description = core.registered_nodes[nodeat.name].description
              if (description ~= nil) then
                core.chat_send_player(entity:owner(), data.name .. ": " .. 
                  S("I don't have a tool to dig ") .. S(description))
              end
          end
      end
    end

    return non_air_node_detected
end

mob_miner.complete_dig = function(entity)

	local data = entity:get_persistent_data()
    local nodeat = core.get_node(data.control.digpos)
    local nodedef = core.registered_nodes[nodeat.name]
    local tooldef = core.registered_tools[data.control.used_tool]
          
    if (entity:add_wear(data.control.used_tool,
                   data.control.add_wear_oncomplete)) then
    
      core.dig_node(data.control.digpos)
      
      local toadd = nodeat.name
      
      if (nodedef.drop ~= nil) then
        toadd = nodedef.drop
      end
      
      if (not entity:add_item(toadd)) then
          core.add_item(data.control.digpos, toadd)
      end
    else
        print("BUG: Minder didn't find the tool we're supposed to digging with")
    end
    data.control.add_wear_on_complete = nil
    data.control.digpos = nil

end

local miner_onstep = function(entity, now, dtime)

    local mydata = entity:get_persistent_data()
    
    if (mydata.control.digstate == "digging") then

        local non_air_node_found = false
        if (mydata.control.digpos == nil) then
            non_air_node_found = entity:update_digpos()
            
        else
            mydata.control.digtime = mydata.control.digtime + dtime
            mydata.control.soundtime = mydata.control.soundtime + dtime
        end
        
        if mydata.control.digpos ~= nil and not miner_is_dig_safe(mydata.control.digpos) then
            --! TODO send message to owner
            core.chat_send_player(entity:owner(), mydata.name .. ": " .. 
              S("I won't continue to dig here there's something bad behind!"))
            mydata.control.digpos = nil
        end
        
        --! stop digging if we reached the requested depth
        if (mydata.control.digdepth <= 0) then
            mydata.control.digstate = "idle"
            --print ("Miner: reached requested depth nothing to do setting to idle")
            entity:set_state("default")
            return
        end
        
        --! move ahead if we don't have any node left to dig
        if (mydata.control.digpos == nil) and (not non_air_node_found) then
        	if mydata.control.dig_wait_time == nil then
        		mydata.control.dig_wait_time = 0
        	end
        	
        	mydata.control.dig_wait_time = mydata.control.dig_wait_time + dtime
        	
        	if mydata.control.dig_wait_time < 1 then
        		return
        	end
        	
        	mydata.control.dig_wait_time = 0
        
            mydata.control.digdepth = mydata.control.digdepth -1
            
            if (entity:stepforward()) then
                return
            end
        end
        --! stop digging if there ain't any node left
        if (mydata.control.digpos == nil) then
            mydata.control.digstate = "idle"
            mydata.control.soundtime = -1
            --print ("Miner: no diggable node found setting to idle")
            entity:set_state("default")
            return
        end
        
        if mydata.control.digtime == 0 then
              local entitypos = vector.round(mydata.control.digpos)
              print("Adding entity at: " .. dump(mydata.control.digpos) .. " --> " .. dump(entitypos))
              local added = minetest.add_entity(entitypos, "mob_miner:cracksim")
              if added ~= nil then
              	added:get_luaentity().timetotal = (mydata.control.timetocomplete - 0.05)
              end
        end
        
        --! check if dig is completed
        if (mydata.control.digtime ~= nil) and 
            (mydata.control.timetocomplete ~= nil) and
            (mydata.control.digtime > mydata.control.timetocomplete) then
            
            entity:completeDig()
        end
        
        if ((mydata.control.soundtime >= MINER_DIG_SOUND_INTERVAL) and (mydata.control.diggroup ~= nil)) then
            local soundspec = 
              { name="default_dig_" .. mydata.control.diggroup, gain=1.0, max_hear_distance=10 }
        
            sound.play(mydata.control.digpos, soundspec )
            mydata.control.soundtime = mydata.control.soundtime - MINER_DIG_SOUND_INTERVAL
        end
    end
end

local miner_precatch_check = function(entity)
    
    local mydata = entity:get_persistent_data()
    
    for t1 = 1, #mydata.inventory.tools, 1 do
        if (mydata.inventory.tools[t1] ~= nil ) then
            core.chat_send_player(entity:owner(), mydata.name .. ":" .. 
                S("I've still got tools!"))
            return false
        end
    end
    
    for t1 = 1, #mydata.inventory.digged, 1 do
        if (mydata.inventory.digged[t1] ~= nil ) then
            core.chat_send_player(entity:owner(), mydata.name .. ": " .. 
                S("I've still got some nodes!"))
            return false
        end
    end
    return true
end

miner_prototype = {
		name="miner",
		modname="mob_miner",

		factions = {
			member = {
				"npc",
				"hireling"
				}
			},

		generic = {
					description= S("Miner"),
					base_health=40,
					kill_result="",
					armor_groups= {
						fleshy=20,
					},
					groups = MINER_GROUPS,
					envid="simple_air",
					stepheight = 0.51,
					
					custom_on_activate_handler = miner_activate,
					custom_on_step_handler = miner_onstep,
					
					on_rightclick_callbacks = {
						{
							handler = mob_miner.rightclick_control,
							name = "miner_control_rightclick",
							visiblename = mob_miner.rightclick_control_label
						},
						{
							handler = mob_miner.rightclick_relocate,
							name = "miner_relocate_rightclick",
							visiblename = mob_miner.rightclick_relocate_label
						}
					}
				},
		movement =  {
					guardspawnpoint = true,
					teleportdelay = 30,
					min_accel=0.3,
					max_accel=0.7,
					max_speed=1.5,
					min_speed=0.01,
					pattern="stop_and_go",
					canfly=false,
					follow_speedup=10,
					max_distance=2,
					},
		catching = {
					tool="animalmaterials:contract",
					consumed=true,
					can_be_cought = miner_precatch_check,
					},
		states = {
				{
				name = "default",
				movgen = "none",
				typical_state_time = 180,
				chance = 1.00,
				animation = "stand",
				state_mode = "auto",
				graphics_3d = {
					visual = "mesh",
					mesh = "character.b3d",
					textures = {"character.png"},
					collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
					visual_size= {x=1, y=1},
					},
				},
				{
					name = "digging",
					movgen = "none",
					typical_state_time = 180,
					chance = 0,
					animation = "dig",
					state_mode = "user_def",
					graphics_3d = {
						visual = "mesh",
						mesh = "character.b3d",
						textures = {"character.png"},
						collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
						visual_size= {x=1, y=1},
					},
				},
				{
					name = "relocate",
					movgen = "follow_mov_gen",
					typical_state_time = 60,
					chance = 0,
					animation_walk = "walk",
					animation_next_to_target = "stand",
					graphics_3d = 
					{
						visual = "mesh",
						mesh = "character.b3d",
						textures =  {"character.png"},
						collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
						visual_size= {x=1,y=1,z=1},
						model_orientation_fix =  math.pi/2
					},
				},
			},
		animation = {
			stand = {
				start_frame = 0,
				end_frame   = 80,
			},
			walk = {
				start_frame = 168,
				end_frame   = 188,
				basevelocity = 18,
				},
			dig = {
				start_frame = 189,
				end_frame = 199,
			},
			digwalk = {
				start_frame = 200,
				end_frame = 220,
				basevelocity = 18
			}
		},
	}

minetest.log("action","\tadding mob " .. miner_prototype.name)
mobf_add_mob(miner_prototype)
minetest.log("action","MOD: mob_miner mod                version " .. version .. " loaded")
