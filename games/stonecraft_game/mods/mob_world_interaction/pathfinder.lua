
-- pathfinder from burli.
--   See https://forum.minetest.net/viewtopic.php?f=9&t=17406 and
--   https://github.com/MarkuBu/pathfinder for original version.
--
-- Modifications:
-- * can plot paths through doors
-- * thin slabs on the ceiling (up to 2/16 thick) do not hinder pathfinding
-- * TODO: thin slabs on the floor ought to be ok as well
-- * climbable nodes (ladders etc.) are handled to some degree

mob_world_interaction.pathfinder = {}

mob_world_interaction.pathfinder.max_path_length = 100;

--[[
minetest.get_content_id(name)
minetest.registered_nodes
minetest.get_name_from_content_id(id)
local ivm = a:index(pos.x, pos.y, pos.z)
local ivm = a:indexp(pos)
minetest.hash_node_position({x=,y=,z=})
minetest.get_position_from_hash(hash)

start_index, target_index, current_index
^ Hash of position

current_value
^ {int:hCost, int:gCost, int:fCost, hash:parent, vect:pos}
]]--


--print("loading mob_world_interaction.pathfinder")

local openSet = {}
local closedSet = {}


local function get_distance(start_pos, end_pos)
	local distX = math.abs(start_pos.x - end_pos.x)
	local distZ = math.abs(start_pos.z - end_pos.z)

	if distX > distZ then
		return 14 * distZ + 10 * (distX - distZ)
	else
		return 14 * distX + 10 * (distZ - distX)
	end
end

local function get_distance_to_neighbor(start_pos, end_pos)
	local distX = math.abs(start_pos.x - end_pos.x)
	local distY = math.abs(start_pos.y - end_pos.y)
	local distZ = math.abs(start_pos.z - end_pos.z)

	if distX > distZ then
		return (14 * distZ + 10 * (distX - distZ)) * (distY + 1)
	else
		return (14 * distX + 10 * (distZ - distX)) * (distY + 1)
	end
end

local function walkable(node, curr_height, max_height )
	if( mob_world_interaction ) then
		return mob_world_interaction.walkable( node, curr_height, max_height );
	end
	return minetest.registered_nodes[node.name].walkable
end

mob_world_interaction.climbable = function(node)
	if( not( node ) or not( node.name ) or not( minetest.registered_nodes[ node.name ])) then
		return false;
	end
	return minetest.registered_nodes[node.name].climbable;
end


-- seems to be unused
local function check_clearance(cpos, x, z, height, data)
	for i = 1, height do
		local n_name = mob_world_interaction.get_node({x = cpos.x + x, y = cpos.y + i, z = cpos.z + z}, data).name
		local c_name = mob_world_interaction.get_node({x = cpos.x, y = cpos.y + i, z = cpos.z}, data).name
		--~ print(i, n_name, c_name)
		if walkable(n_name, i, height) or walkable(c_name, i, height) then
			return false
		end
	end
	return true
end

local function get_neighbor_ground_level(pos, jump_height, fall_height, data)
	local node = mob_world_interaction.get_node(pos, data)
	local height = 0
	local relevant_height = 0;
	if walkable(node,1,2) then
		repeat
			height = height + 1
			if( not( mob_world_interaction.climbable(node ))) then
				relevant_height = relevant_height + 1;
			end
			if relevant_height > jump_height then
				return nil
			end
			pos.y = pos.y + 1
			node = mob_world_interaction.get_node(pos, data)
		until not walkable(node,2,2)
		return pos
	else
		repeat
			height = height + 1
			if( not( mob_world_interaction.climbable(node ))) then
				relevant_height = relevant_height + 1;
			end
			if relevant_height > fall_height then
				return nil
			end
			pos.y = pos.y - 1
			node = mob_world_interaction.get_node(pos, data)
		until walkable(node,1,2)
		return {x = pos.x, y = pos.y + 1, z = pos.z}
	end
end

function mob_world_interaction.find_path(pos, endpos, entity, data)
	local start_index = minetest.hash_node_position(pos)
	local target_index = minetest.hash_node_position(endpos)
	local count = 1

	openSet = {}
	closedSet = {}

	local h_start = get_distance(pos, endpos)
	openSet[start_index] = {hCost = h_start, gCost = 0, fCost = h_start, parent = nil, pos = pos}

	-- Entity values
	local entity_height = math.ceil(entity.collisionbox[5] - entity.collisionbox[2])
	local entity_fear_height = entity.fear_height or 2
	local entity_jump_height = entity.jump_height or 1

	repeat
		local current_index
		local current_values

		-- Get one index as reference from openSet
		for i, v in pairs(openSet) do
			current_index = i
			current_values = v
			break
		end

		-- Search for lowest fCost
		for i, v in pairs(openSet) do
			if v.fCost < openSet[current_index].fCost or v.fCost == current_values.fCost and v.hCost < current_values.hCost then
				current_index = i
				current_values = v
			end
		end

		openSet[current_index] = nil
		closedSet[current_index] = current_values
		count = count - 1

		if current_index == target_index then
			-- print("Success")
			local path = {}
			local reverse_path = {}
			repeat
				if not closedSet[current_index] then
					return
				end
				table.insert(path, closedSet[current_index].pos)
				current_index = closedSet[current_index].parent
				if #path > mob_world_interaction.pathfinder.max_path_length then
					-- print("path to long")
					return
				end
			until start_index == current_index
			repeat
				table.insert(reverse_path, table.remove(path))
			until #path == 0
			-- print("path lenght: "..#reverse_path)
			return reverse_path
		end

		local current_pos = current_values.pos

		local neighbors = {}
		local neighbors_index = 1
		for z = -1, 1 do
		for x = -1, 1 do
			local neighbor_pos = {x = current_pos.x + x, y = current_pos.y, z = current_pos.z + z}
			local neighbor = mob_world_interaction.get_node(neighbor_pos, data)
			local neighbor_ground_level = get_neighbor_ground_level(neighbor_pos, entity_jump_height, entity_fear_height, data)
			local neighbor_clearance = false
			if neighbor_ground_level then
				-- print(neighbor_ground_level.y - current_pos.y)
				-- minetest.set_node(neighbor_ground_level, {name = "default:dry_shrub"})
				local node_above_head = mob_world_interaction.get_node(
						{x = current_pos.x, y = current_pos.y + entity_height, z = current_pos.z}, data)
				if neighbor_ground_level.y - current_pos.y > 0 and not walkable(node_above_head,entity_height,entity_height) then
					local height = -1
					repeat
						height = height + 1
						local node = mob_world_interaction.get_node(
								{x = neighbor_ground_level.x,
								y = neighbor_ground_level.y + height,
								z = neighbor_ground_level.z}, data)
					until walkable(node, entity_height, entity_height) or height > entity_height
					if height >= entity_height then
						neighbor_clearance = true
					end
				elseif neighbor_ground_level.y - current_pos.y > 0 and walkable(node_above_head,entity_height,entity_height) then
					neighbors[neighbors_index] = {
							hash = nil,
							pos = nil,
							clear = nil,
							walkable = nil,
					}
				else
					local height = -1 
					repeat
						height = height + 1
						local node = mob_world_interaction.get_node(
								{x = neighbor_ground_level.x,
								y = current_pos.y + height,
								z = neighbor_ground_level.z}, data)
					until walkable(node,2,2) or height > entity_height
					if height >= entity_height then
						neighbor_clearance = true
					end
				end

				neighbors[neighbors_index] = {
						hash = minetest.hash_node_position(neighbor_ground_level),
						pos = neighbor_ground_level,
						clear = neighbor_clearance,
						walkable = walkable(neighbor,1,2),
				}
			else
				neighbors[neighbors_index] = {
						hash = nil,
						pos = nil,
						clear = nil,
						walkable = nil,
				}
			end
			neighbors_index = neighbors_index + 1
		end
		end

		for id, neighbor in pairs(neighbors) do
			-- don't cut corners
			local cut_corner = false
			if id == 1 then
				if not neighbors[id + 1].clear or not neighbors[id + 3].clear
					or neighbors[id + 1].walkable or neighbors[id + 3].walkable then
					cut_corner = true
				end
			elseif id == 3 then
				if not neighbors[id - 1].clear or not neighbors[id + 3].clear
					or neighbors[id - 1].walkable or neighbors[id + 3].walkable then
					cut_corner = true
				end
			elseif id == 7 then
				if not neighbors[id + 1].clear or not neighbors[id - 3].clear
				or neighbors[id + 1].walkable or neighbors[id - 3].walkable then
					cut_corner = true
				end
			elseif id == 9 then
				if not neighbors[id - 1].clear or not neighbors[id - 3].clear
				or neighbors[id - 1].walkable or neighbors[id - 3].walkable then
					cut_corner = true
				end
			end

			if neighbor.hash ~= current_index and not closedSet[neighbor.hash] and neighbor.clear and not cut_corner then
				local move_cost_to_neighbor = current_values.gCost + get_distance_to_neighbor(current_values.pos, neighbor.pos)
				local gCost = 0
				if openSet[neighbor.hash] then
					gCost = openSet[neighbor.hash].gCost
				end
				if move_cost_to_neighbor < gCost or not openSet[neighbor.hash] then
					if not openSet[neighbor.hash] then
						count = count + 1
					end
					local hCost = get_distance(neighbor.pos, endpos)
					openSet[neighbor.hash] = {
							gCost = move_cost_to_neighbor,
							hCost = hCost,
							fCost = move_cost_to_neighbor + hCost,
							parent = current_index,
							pos = neighbor.pos
					}
				end
			end
		end
		if count > mob_world_interaction.pathfinder.max_path_length then
			-- print("fail")
			return
		end
	until count < 1
	-- print("count < 1")
	return {pos}
end
