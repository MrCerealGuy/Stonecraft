-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file ui.lua
--! @brief ui functions for miner mob
--! @copyright Sapier
--! @author Sapier
--! @date 2015-12-20
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

mobf_assert_backtrace(core.global_exists("mob_miner"))

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
  dofile(minetest.get_modpath("intllib").."/intllib.lua")
  S = intllib.Getter(minetest.get_current_modname())
else
  S = function ( s ) return s end
end


-------------------------------------------------------------------------------
-- @function [parent=#mob_miner] show_formspec(playername, entity, data)
--
--! @brief show formspec to some player
--! @memberof mob_miner
--
--! @param playername name of player to show to
--! @param entity showing the formspec
--! @param data entity specific data
-------------------------------------------------------------------------------
mob_miner.show_formspec = function(playername, entity, data)

    local storageid = mobf_global_data_store(entity)
    
    local formname = "mobf_miner:" ..storageid
    
    entity.dynamic_data.miner_formspec_data.tools_inventory =
        core.create_detached_inventory(data.unique_entity_id,
          {
            allow_put   = function(inv, listname, index, stack, player)
                if (listname == "tools") then
                    if (stack:get_tool_capabilities() == nil ) then
                       
                        return 0
                    else
                        return 1
                    end
                else
                    return 0
                end
            end,
          })
          
    local inv = entity.dynamic_data.miner_formspec_data.tools_inventory
        
    entity.dynamic_data.miner_formspec_data.tools_inventory:set_size("tools",4)
    
    for i,v in ipairs(data.inventory.tools) do
        inv:set_stack("tools", i, ItemStack(v))
    end
    
    entity.dynamic_data.miner_formspec_data.tools_inventory:set_size("digged",12)
    
    for i,v in ipairs(data.inventory.digged) do
        inv:set_stack("digged", i, ItemStack(v))
    end

    local digdepth = data.last_digdepth or 1

    local miner_formspec = "size[10,8.5;]" ..
      "label[1,0;"..S("Miner %s"):format(data.name).."]" ..
      "label[0,1;"..S("Tools:").."]"..
      "label[6,1;"..S("Tunnel shape:").."]" ..
      "label[0,2.5;"..S("Minerinventory:").."]"..
      "list[detached:" .. data.unique_entity_id .. ";tools;0,1.5;4,1;]" ..
      "list[detached:" .. data.unique_entity_id .. ";digged;0,3;4,3;]" ..
      "list[current_player;main;1,7.5;8,1;]" ..
      "field[0.25,7;1,0.5;te_digdepth;Dig depth;" .. digdepth .."]" ..
      "button_exit[1,6.8;2,0.25;btn_start_digging;" .. S("start digging") .. "]" ..
      "button_exit[8,6.8;2,0.25;btn_take_all_items;" .. S("take all items") .. "]" ..
      "image[7.1,4.25;1.5,2;mob_miner_miner_item.png]"
      
      for x = 1, MINER_MAX_TUNNEL_SIZE, 1 do
          for y = MINER_MAX_TUNNEL_SIZE, 1, -1 do
              if ( x == 3 ) and (y == 1) or
                 ( x == 3 ) and (y == 2) then
                  --! miners size
              else
                  if data.digspec[x][y] then
                    miner_formspec = miner_formspec .. 
                      "image_button[" .. ((x*0.825)+4.85) .. "," .. (6- (y*0.9)) .. ";1,1;" ..
                      "blank.png;" .. 
                      "btn_tunnelshape_" .. x .. "x" .. y .. ";;" .. 
                      "false;false;crack_anylength.png]"
                  else
                    miner_formspec = miner_formspec ..
                      "image_button[" .. ((x*0.825)+4.85) .. "," .. (6-(y*0.9)) .. ";1,1;" ..
                      "default_stone.png;" .. 
                      "btn_tunnelshape_" .. x .. "x" .. y .. ";;" .. 
                      "false;false;crack_anylength.png]"
                  end
              end
          end
      end
      
    core.show_formspec(playername, formname, miner_formspec)
end


-------------------------------------------------------------------------------
-- @function [parent=#mob_miner] formspec_handler(player, formname, fields)
--
--! @brief handle events triggered by formspec
--! @memberof mob_miner
--
--! @param player player causing the formspec action
--! @param formname name of form causing the event
--! @param fields all fields passed from form
-------------------------------------------------------------------------------
mob_miner.formspec_handler = function(player, formname, fields)
    if formname:find("mobf_miner:") == 1 then
        local storageid =  formname:sub(12)
        local entity = mobf_global_data_get(storageid)
        
        if entity ~= nil then
            local mydata = entity:get_persistent_data()
            local minerinv = entity.dynamic_data.miner_formspec_data.tools_inventory
            
            local toolinv = minerinv:get_list("tools")
            
            mydata.inventory.tools = {}
            
            for i,v in ipairs (toolinv) do
                table.insert(mydata.inventory.tools, v:to_table())
            end
            
            
            local inventory = minerinv:get_list("digged")
            
            mydata.inventory.digged = {}
       
            for i,v in ipairs (inventory) do
                table.insert(mydata.inventory.digged, v:to_table())
            end
            
            if fields["btn_start_digging"] ~= nil and 
              tonumber(fields["te_digdepth"]) ~=  nil then
              
                mydata.control.digstate = "digging"
                mydata.control.digtime = 0
                mydata.control.digpos = nil
                mydata.control.digdepth = tonumber(fields["te_digdepth"]) or 0
                mydata.last_digdepth = mydata.control.digdepth
              
                entity:set_state("digging")
            end

            local update_spec = false
            
            for x = 1, MINER_MAX_TUNNEL_SIZE, 1 do
                for y = 1, MINER_MAX_TUNNEL_SIZE, 1 do
                    if (fields["btn_tunnelshape_" .. x .. "x" .. y]) then
                        mydata.digspec[x][y] = not mydata.digspec[x][y]
                        update_spec = true
                    end
                end
            end
            
            if fields["btn_take_all_items"] ~= nil then
                local playerinventory = 
                	core.get_inventory({type="player", name=player:get_player_name()})
            
                for t1 = 1, #mydata.inventory.tools, 1 do
                    if mydata.inventory.tools[t1] ~= nil then
                    	local toadd = ItemStack(mydata.inventory.tools[t1])
                        if (playerinventory:room_for_item( "main", toadd)) then
                        	playerinventory:add_item("main", toadd)
                        	mydata.inventory.tools[t1] = nil
                        end
                    end
                end
                
                for t1 = 1, #mydata.inventory.digged, 1 do
                    if (mydata.inventory.digged[t1] ~= nil ) then
                        local toadd = ItemStack(mydata.inventory.digged[t1])
                        if (playerinventory:room_for_item( "main", toadd)) then
                        	playerinventory:add_item("main", toadd)
                        	mydata.inventory.digged[t1] = nil
                        end
                        
                    end
                end
                update_spec = false
            end
            
            if (update_spec) then
                mob_miner.show_formspec(player:get_player_name(), entity, mydata)
            end
        end
    end
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_miner] rightclick_control_label(entity)
--
--! @brief provide label for rightclick contol button
--! @memberof mob_miner
--
--! @param entity entity to show button for
--! @return label for button
-------------------------------------------------------------------------------
mob_miner.rightclick_control_label = function(entity, player)
	if not player:is_player() then
		return "You aren't even human!"
	end
	
	if player:get_player_name() ~= entity.dynamic_data.spawning.spawner then
		print("Playername: " .. player:get_player_name() .. " spawned by: " .. entity.dynamic_data.spawning.spawner)
		return "Ask my boss!"
	end

    local mydata = entity:get_persistent_data()
    
    if mydata.control.digstate == "idle" then
      local basepos = entity:getbasepos()
      local direction = entity:getDirection()
      local nodestodig  = mob_miner.filter_nodes(
      						mob_miner.get_pos2dig_list(direction,basepos, mydata.digspec),
      						{ "air", "default:torch"}
      						)
      
      if #nodestodig ~= 0 then
        return S("give orders")
      else
        mydata.control.digstate = "idle_nothing_to_dig"
        return S("move ahead")
      end
    elseif (mydata.control.digstate == "idle_nothing_to_dig") then
        return S("move ahead")
    elseif (mydata.control.digstate == "follow") then
    	return S("following you")
    else
      return S("stop digging") .. " (" .. mydata.control.digdepth .. ")"
    end
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_miner] rightclick_relocate_label(entity)
--
--! @brief provide label for rightclick relocate button
--! @memberof mob_miner
--
--! @param entity entity to show button for
--! @return label for button
-------------------------------------------------------------------------------
mob_miner.rightclick_relocate_label = function(entity, player)

	if not player:is_player() then
		return "You aren't even human!"
	end
	
	if player:get_player_name() ~= entity.dynamic_data.spawning.spawner then
		print("Playername: " .. player:get_player_name() .. " spawned by: " .. entity.dynamic_data.spawning.spawner)
		return "Ask my boss!"
	end

    local mydata = entity:get_persistent_data()
    
    if mydata.control.digstate == "follow" then
		return S("stay here")
    else
        return S("follow me")
    end
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_miner] rightclick_control(entity, player)
--
--! @brief handle rightclick of control button
--! @memberof mob_miner
--
--! @param entity being rightclicked
--! @param player player clicking entity
-------------------------------------------------------------------------------
mob_miner.rightclick_control = function(entity, player)
	if not player:is_player() then
		return
	end
	
	if player:get_player_name() ~= entity.dynamic_data.spawning.spawner then
		print("Playername: " .. player:get_player_name() .. " spawned by: " .. entity.dynamic_data.spawning.spawner)
		return
	end

    local mydata = entity:get_persistent_data()

    if mydata.control.digstate == "idle" then
        mob_miner.show_formspec(player:get_player_name(), entity, mydata )
    elseif mydata.control.digstate == "idle_nothing_to_dig" then
        entity:stepforward()
        mydata.control.digstate = "idle"
    elseif mydata.control.digstate == "digging" then
        mydata.control.digstate = "idle"
        entity:set_state("default")
    end
end


-------------------------------------------------------------------------------
-- @function [parent=#mob_miner] rightclick_relocate(entity, player)
--
--! @brief handle rightclick of relocate button
--! @memberof mob_miner
--
--! @param entity being rightclicked
--! @param player player clicking entity
-------------------------------------------------------------------------------
mob_miner.rightclick_relocate = function(entity, player)
	if not player:is_player() then
		return
	end
	
	if player:get_player_name() ~= entity.dynamic_data.spawning.spawner then
		print("Playername: " .. player:get_player_name() .. " spawned by: " .. entity.dynamic_data.spawning.spawner)
		return
	end

    local mydata = entity:get_persistent_data()

    if mydata.control.digstate == "idle" or
    	mydata.control.digstate == "idle_nothing_to_dig" then
    	mydata.control.digstate = "follow"
		if not entity:set_state("relocate") then
			print ("Miner: relocate state not specified")
		end
		entity.dynamic_data.movement.target = 
			core.get_player_by_name(entity.dynamic_data.spawning.spawner)
    elseif mydata.control.digstate == "follow" then
        entity:set_state("default")
        mydata.control.digstate = "idle"
    end
end

minetest.register_on_player_receive_fields(mob_miner.formspec_handler)