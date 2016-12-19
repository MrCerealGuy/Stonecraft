-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file utils.lua
--! @brief tool functions for miner mob
--! @copyright Sapier
--! @author Sapier
--! @date 2015-12-20
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

mobf_assert_backtrace(core.global_exists("mob_miner"))


function mob_miner_calc_digtime(tool, nodename)

    local nodedef = core.registered_nodes[nodename]
    
    if (nodedef == nil) then
        return -1
    end
    
    local candig = false
    local result_time = 7200
    local result_wear = 0
    local result_group = ""
    local leveldiff = 0
    
    local nodelevel = 0
    if (nodedef.groups["level"] ~= nil) then
        nodelevel = nodedef.groups["level"]
    end
    
    --print("Checking node: " .. nodename .. " level=" .. nodelevel)
    
    for groupcapname, parameters in pairs(tool.tool_capabilities.groupcaps) do
        
        local rating = 0
        if (nodedef.groups[groupcapname] ~= nil) then
            rating = nodedef.groups[groupcapname]
        end
        
        if parameters.times[rating] ~= nil then
            local leveldiff = parameters.maxlevel - nodelevel
            --print("maxlevel: " .. parameters.maxlevel .. " Level: " .. nodelevel)
            local digtime = parameters.times[rating] / math.max(1, leveldiff)
            local wear = 65535 * (1 / parameters.uses / math.pow(3.0, leveldiff))
            --print("digtime: " .. digtime .. " resulting from: " .. parameters.times[rating] .. " wear: " .. wear)
            candig = true
            if result_time == nil or (digtime < result_time) then
                result_time = digtime
                result_wear = wear
                result_group = groupcapname
            end
        else
        end
    end
    
    if not candig then
        return -1
    end
    
    return result_time, result_wear, result_group
end

function miner_is_dig_safe(pos)
	if (core.find_node_near(pos, 1, 
		{ "default:water_source", "default:water_flowing",
		  "default:river_water_source", "default:river_water_flowing",
		  "default:lava_source", "default:lava_flowing"}) ~= nil) then
		  return false
	end
    return true
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_miner] get_pos2dig_list(direction, basepos, digspec)
--
--! @brief get list of positions to dig next
--! @ingroup mob_miner
--
--! @param direction which direction to get the poslist
--! @param basepos ground position of digging miner
--! @param digspec description of how the tunnel shall look like
--! @return list of positions to be digged according to the parameters
-------------------------------------------------------------------------------
mob_miner.get_pos2dig_list = function(direction, basepos, digspec)

    local poslist = {}
    
    local offset = 0;
    
    if (direction == DIR_EAST) or (direction == DIR_NORTH) then
      offset = 1
    elseif (direction == DIR_WEST) or (direction == DIR_SOUTH) then
      offset = -1
    end
    
    local horiz_offset = math.floor(#digspec /2)    
    local xidx = function(addon, direction, digspecsize)
        if direction == DIR_SOUTH or direction == DIR_EAST then
          return digspecsize - (addon + horiz_offset)
        elseif direction == DIR_NORTH or direction == DIR_WEST then
          return  addon + horiz_offset +1;
        end
    end
    
    if (direction == DIR_NORTH) or (direction == DIR_SOUTH) then
      for yaddon = 0 , #digspec[1], 1  do
          for xaddon = -horiz_offset , horiz_offset, 1  do
          
            if digspec[xidx(xaddon,direction,#digspec)][yaddon +1] then
                table.insert(poslist, {x=basepos.x+xaddon, y=basepos.y+yaddon, z=basepos.z+offset})
            end
          end
      end
    elseif (direction == DIR_EAST) or (direction == DIR_WEST) then
      for yaddon = 0 , #digspec[1], 1  do
          for zaddon = -horiz_offset , horiz_offset, 1  do
            if digspec[xidx(zaddon,direction,#digspec)][yaddon +1] then
                table.insert(poslist, {x=basepos.x+offset, y=basepos.y+yaddon, z=basepos.z+zaddon})
            end
          end
      end
    end
    
    return poslist
end

mob_miner.getDirection =function(entity)
        
        local yaw = entity.object:getyaw()
        
        local direction = "ukn"
        
        while (yaw > (2*math.pi)) do
          yaw = yaw -(2*math.pi)
        end
        
        if (yaw < ((2*math.pi)/8)) then
          direction = DIR_NORTH
        elseif (yaw < (3*((2*math.pi)/8))) then
          direction = DIR_WEST
        elseif (yaw < (5*((2*math.pi)/8))) then
          direction =  DIR_SOUTH
        elseif (yaw < (7*((2*math.pi)/8))) then
          direction = DIR_EAST
        elseif (yaw <= (2*math.pi)) then
          direction = DIR_NORTH
        end
        
        return direction
end


-------------------------------------------------------------------------------
-- @function [parent=#mob_miner] filter_nodes(poslist, filterlist)
--
--! @brief remove all positions containing node within filterlist from list
--! @ingroup mob_miner
--
--! @param poslist list of positions to check
--! @param filterlist list of nodenames to remove from list
--! @return list of positions not containing filtered nodetypes
-------------------------------------------------------------------------------
mob_miner.filter_nodes = function(poslist, filterlist)

	if filterlist == nil then
		return poslist
	end

	local retval = {}

	for i, v in ipairs(poslist) do
		local nodeat = core.get_node(v)

		local found = false
		
		for j, n in ipairs(filterlist) do
			if (nodeat.name == n) then
				found = true
				break
			end
		end
		
		if not found then
			table.insert(retval, v)
		end
	end

	return retval
end