-- reimplementation of new_flow_logic branch: processing functions
-- written 2017 by thetaepsilon



local flowlogic = {}
flowlogic.helpers = {}
pipeworks.flowlogic = flowlogic



-- borrowed from above: might be useable to replace the above coords tables
local make_coords_offsets = function(pos, include_base)
	local coords = {
		{x=pos.x,y=pos.y-1,z=pos.z},
		{x=pos.x,y=pos.y+1,z=pos.z},
		{x=pos.x-1,y=pos.y,z=pos.z},
		{x=pos.x+1,y=pos.y,z=pos.z},
		{x=pos.x,y=pos.y,z=pos.z-1},
		{x=pos.x,y=pos.y,z=pos.z+1},
	}
	if include_base then table.insert(coords, pos) end
	return coords
end



-- local debuglog = function(msg) print("## "..msg) end



--~ local formatvec = function(vec) local sep="," return "("..tostring(vec.x)..sep..tostring(vec.y)..sep..tostring(vec.z)..")" end



-- new version of liquid check
-- accepts a limit parameter to only delete water blocks that the receptacle can accept,
-- and returns it so that the receptacle can update it's pressure values.
local check_for_liquids_v2 = function(pos, limit)
	local coords = make_coords_offsets(pos, false)
	local total = 0
	for _, tpos in ipairs(coords) do
		if total >= limit then break end
		local name = minetest.get_node(tpos).name
		if name == "default:water_source" then
			minetest.remove_node(tpos)
			total = total + 1
		end
	end
	--pipeworks.logger("check_for_liquids_v2@"..formatvec(pos).." total "..total)
	return total
end
flowlogic.check_for_liquids_v2 = check_for_liquids_v2



local label_pressure = "pipeworks.water_pressure"
local get_pressure_access = function(pos)
	local metaref = minetest.get_meta(pos)
	return {
		get = function()
			return metaref:get_float(label_pressure)
		end,
		set = function(v)
			metaref:set_float(label_pressure, v)
		end
	}
end


-- logging is unreliable when something is crashing...
--[[
local nilexplode = function(caller, label, value)
	if value == nil then
		error(caller..": "..label.." was nil")
	end
end
--]]



local finitemode = pipeworks.toggles.finite_water
flowlogic.run = function(pos, node)
	local nodename = node.name
	-- get the current pressure value.
	local nodepressure = get_pressure_access(pos)
	local currentpressure = nodepressure.get()
	local oldpressure = currentpressure

	-- if node is an input: run intake phase
	local inputdef = pipeworks.flowables.inputs.list[nodename]
	if inputdef then
		currentpressure = flowlogic.run_input(pos, node, currentpressure, inputdef)
		--debuglog("post-intake currentpressure is "..currentpressure)
		--nilexplode("run()", "currentpressure", currentpressure)
	end

	-- balance pressure with neighbours
	currentpressure = flowlogic.balance_pressure(pos, node, currentpressure)

	-- if node is an output: run output phase
	local outputdef = pipeworks.flowables.outputs.list[nodename]
	if outputdef then
		currentpressure = flowlogic.run_output(
			pos,
			node,
			currentpressure,
			oldpressure,
			outputdef,
			finitemode)
	end

	-- if node has pressure transitions: determine new node
	if pipeworks.flowables.transitions.list[nodename] then
		local newnode = flowlogic.run_transition(node, currentpressure)
		--pipeworks.logger("flowlogic.run()@"..formatvec(pos).." transition, new node name = "..dump(newnode).." pressure "..tostring(currentpressure))
		minetest.swap_node(pos, newnode)
		flowlogic.run_transition_post(pos, newnode)
	end

	-- set the new pressure
	nodepressure.set(currentpressure)
end



local simple_neighbour_offsets = {
		{x=0, y=-1,z= 0},
		{x=0, y= 1,z= 0},
		{x=-1,y= 0,z= 0},
		{x= 1,y= 0,z= 0},
		{x= 0,y= 0,z=-1},
		{x= 0,y= 0,z= 1},
}
local get_neighbour_positions = function(pos, node)
	-- local dname = "get_neighbour_positions@"..formatvec(pos).." "
	-- get list of node neighbours.
	-- if this node is directional and only flows on certain sides,
	-- invoke the callback to retrieve the set.
	-- for simple flowables this is just an auto-gen'd list of all six possible neighbours.
	local candidates = {}
	if pipeworks.flowables.list.simple[node.name] then
		candidates = simple_neighbour_offsets
	else
		-- directional flowables: call the callback to get the list
		local directional = pipeworks.flowables.list.directional[node.name]
		if directional then
			--pipeworks.logger(dname.."invoking neighbourfn")
			local offsets = directional.neighbourfn(node)
			candidates = offsets
		end
	end

	-- then, check each possible neighbour to see if they can be reached from this node.
	local connections = {}
	for _, offset in ipairs(candidates) do
		local npos = vector.add(pos, offset)
		local neighbour = minetest.get_node(npos)
		local nodename = neighbour.name
		local is_simple = (pipeworks.flowables.list.simple[nodename])
		if is_simple then
			local n = get_pressure_access(npos)
			table.insert(connections, n)
		else
			-- if target node is also directional, check if it agrees it can flow in that direction
			local directional = pipeworks.flowables.list.directional[nodename]
			if directional then
				--pipeworks.logger(dname.."directionality test for offset "..formatvec(offset))
				local towards_origin = vector.multiply(offset, -1)
				--pipeworks.logger(dname.."vector passed to directionfn: "..formatvec(towards_origin))
				local result = directional.directionfn(neighbour, towards_origin)
				--pipeworks.logger(dname.."result: "..tostring(result))
				if result then
					local n = get_pressure_access(npos)
					table.insert(connections, n)
				end
			end
		end
	end

	return connections
end



flowlogic.balance_pressure = function(pos, node, currentpressure)
	-- local dname = "flowlogic.balance_pressure()@"..formatvec(pos).." "
	-- check the pressure of all nearby flowable nodes, and average it out.

	-- unconditionally include self in nodes to average over.
	-- result of averaging will be returned as new pressure for main flow logic callback
	local totalv = currentpressure
	local totalc = 1

	-- pressure handles to average over
	local connections = get_neighbour_positions(pos, node)

	-- for each neighbour, add neighbour's pressure to the total to balance out
	for _, neighbour in ipairs(connections) do
		local n = neighbour.get()
		totalv = totalv + n
		totalc = totalc + 1
	end
	local average = totalv / totalc
	for _, target in ipairs(connections) do
		target.set(average)
	end

	return average
end



flowlogic.run_input = function(pos, node, currentpressure, inputdef)
	-- intakefn allows a given input node to define it's own intake logic.
	-- this function will calculate the maximum amount of water that can be taken in;
	-- the intakefn will be given this and is expected to return the actual absorption amount.

	local maxpressure = inputdef.maxpressure
	local intake_limit = maxpressure - currentpressure
	if intake_limit <= 0 then return currentpressure end

	local actual_intake = inputdef.intakefn(pos, intake_limit)
	--pipeworks.logger("run_input@"..formatvec(pos).." oldpressure "..currentpressure.." intake_limit "..intake_limit.." actual_intake "..actual_intake)
	if actual_intake <= 0 then return currentpressure end

	local newpressure = actual_intake + currentpressure
	--debuglog("run_input() end, oldpressure "..currentpressure.." intake_limit "..intake_limit.." actual_intake "..actual_intake.." newpressure "..newpressure)
	return newpressure
end



-- flowlogic output helper implementation:
-- outputs water by trying to place water nodes nearby in the world.
-- neighbours is a list of node offsets to try placing water in.
-- this is a constructor function, returning another function which satisfies the output helper requirements.
-- note that this does *not* take rotation into account.
flowlogic.helpers.make_neighbour_output_fixed = function(neighbours)
	return function(pos, node, currentpressure, finitemode)
		local taken = 0
		for _, offset in pairs(neighbours) do
			local npos = vector.add(pos, offset)
			local name = minetest.get_node(npos).name
			if currentpressure < 1 then break end
			-- take pressure anyway in non-finite mode, even if node is water source already.
			-- in non-finite mode, pressure has to be sustained to keep the sources there.
			-- so in non-finite mode, placing water is dependent on the target node;
			-- draining pressure is not.
			local canplace = (name == "air") or (name == "default:water_flowing")
			if canplace then
				minetest.swap_node(npos, {name="default:water_source"})
			end
			if (not finitemode) or canplace then
				taken = taken + 1
				currentpressure = currentpressure - 1
			end
		end
		return taken
	end
end

-- complementary function to the above when using non-finite mode:
-- removes water sources from neighbor positions when the output is "off" due to lack of pressure.
flowlogic.helpers.make_neighbour_cleanup_fixed = function(neighbours)
	return function(pos, node, currentpressure)
		--pipeworks.logger("neighbour_cleanup_fixed@"..formatvec(pos))
		for _, offset in pairs(neighbours) do
			local npos = vector.add(pos, offset)
			local name = minetest.get_node(npos).name
			if (name == "default:water_source") then
				--pipeworks.logger("neighbour_cleanup_fixed removing "..formatvec(npos))
				minetest.remove_node(npos)
			end
		end
	end
end



flowlogic.run_output = function(pos, node, currentpressure, oldpressure, outputdef, finitemode)
	-- processing step for water output devices.
	-- takes care of checking a minimum pressure value and updating the resulting pressure level
	-- the outputfn is provided the current pressure and returns the pressure "taken".
	-- as an example, using this with the above spigot function,
	-- the spigot function tries to output a water source if it will fit in the world.
	--pipeworks.logger("flowlogic.run_output() pos "..formatvec(pos).." old -> currentpressure "..tostring(oldpressure).." "..tostring(currentpressure).." finitemode "..tostring(finitemode))
	local upper = outputdef.upper
	local lower = outputdef.lower
	local result = currentpressure
	local threshold
	if finitemode then threshold = lower else threshold = upper end
	if currentpressure > threshold then
		local takenpressure = outputdef.outputfn(pos, node, currentpressure, finitemode)
		local newpressure = currentpressure - takenpressure
		if newpressure < 0 then newpressure = 0 end
		result = newpressure
	end
	if (not finitemode) and (currentpressure < lower) and (oldpressure < lower) then
		--pipeworks.logger("flowlogic.run_output() invoking cleanup currentpressure="..tostring(currentpressure))
		outputdef.cleanupfn(pos, node, currentpressure)
	end
	return result
end



-- determine which node to switch to based on current pressure
flowlogic.run_transition = function(node, currentpressure)
	local simplesetdef = pipeworks.flowables.transitions.simple[node.name]
	local result = node
	local found = false

	-- simple transition sets: assumes all nodes in the set share param values.
	if simplesetdef then
		-- assumes that the set has been checked to contain at least one element...
		local nodename_prev = simplesetdef[1].nodename
		local result_nodename = node.name

		for _, element in ipairs(simplesetdef) do
			-- find the highest element that is below the current pressure.
			local threshold = element.threshold
			if threshold > currentpressure then
				result_nodename = nodename_prev
				found = true
				break
			end
			nodename_prev = element.nodename
		end

		-- use last element if no threshold is greater than current pressure
		if not found then
			result_nodename = nodename_prev
			found = true
		end

		-- preserve param1/param2 values
		result = { name=result_nodename, param1=node.param1, param2=node.param2 }
	end

	if not found then
		pipeworks.logger("flowlogic.run_transition() BUG no transition " ..
			"definitions found! node.name=" .. node.name ..
			" currentpressure=" .. tostring(currentpressure))
	end

	return result
end

-- post-update hook for run_transition
-- among other things, updates mesecons if present.
-- node here means the new node, returned from run_transition() above
flowlogic.run_transition_post = function(pos, node)
	local mesecons_def = minetest.registered_nodes[node.name].mesecons
	local mesecons_rules = pipeworks.flowables.transitions.mesecons[node.name]
	if minetest.global_exists("mesecon") and (mesecons_def ~= nil) and mesecons_rules then
		if type(mesecons_def) ~= "table" then
			pipeworks.logger("flowlogic.run_transition_post() BUG mesecons def for "..node.name.."not a table: got "..tostring(mesecons_def))
		else
			local receptor = mesecons_def.receptor
			if receptor then
				local state = receptor.state
				if state == mesecon.state.on then
					mesecon.receptor_on(pos, mesecons_rules)
				elseif state == mesecon.state.off then
					mesecon.receptor_off(pos, mesecons_rules)
				end
			end
		end
	end
end
