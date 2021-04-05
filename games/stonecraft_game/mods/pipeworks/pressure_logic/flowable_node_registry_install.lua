-- flowable node registry: add entries and install ABMs if new flow logic is enabled
-- written 2017 by thetaepsilon



-- use for hooking up ABMs as nodes are registered
local abmregister = pipeworks.flowlogic.abmregister

-- registration functions
pipeworks.flowables.register = {}
local register = pipeworks.flowables.register

-- some sanity checking for passed args, as this could potentially be made an external API eventually
local checkexists = function(nodename)
	if type(nodename) ~= "string" then error("pipeworks.flowables nodename must be a string!") end
	return pipeworks.flowables.list.all[nodename]
end

local insertbase = function(nodename)
	if checkexists(nodename) then error("pipeworks.flowables duplicate registration!") end
	pipeworks.flowables.list.all[nodename] = true
	-- table.insert(pipeworks.flowables.list.nodenames, nodename)
	if pipeworks.toggles.pipe_mode == "pressure" then
		abmregister.flowlogic(nodename)
	end
end

local regwarning = function(kind, nodename)
	--~ local tail = ""
	--~ if pipeworks.toggles.pipe_mode ~= "pressure" then tail = " but pressure logic not enabled" end
	--pipeworks.logger(kind.." flow logic registry requested for "..nodename..tail)
end

-- Register a node as a simple flowable.
-- Simple flowable nodes have no considerations for direction of flow;
-- A cluster of adjacent simple flowables will happily average out in any direction.
register.simple = function(nodename)
	insertbase(nodename)
	pipeworks.flowables.list.simple[nodename] = true
	table.insert(pipeworks.flowables.list.simple_nodenames, nodename)
	regwarning("simple", nodename)
end

-- Register a node as a directional flowable:
-- has a helper function which determines which nodes to consider valid neighbours.
register.directional = function(nodename, neighbourfn, directionfn)
	insertbase(nodename)
	pipeworks.flowables.list.directional[nodename] = {
		neighbourfn = neighbourfn,
		directionfn = directionfn
	}
	regwarning("directional", nodename)
end

-- register a node as a directional flowable that can only flow through either the top or bottom side.
-- used for fountainheads (bottom side) and pumps (top side).
-- this is in world terms, not facedir relative!
register.directional_vertical_fixed = function(nodename, topside)
	local y
	if topside then y = 1 else y = -1 end
	local side = { x=0, y=y, z=0 }
	local neighbourfn = function(node) return { side } end
	local directionfn = function(node, direction)
		return vector.equals(direction, side)
	end
	register.directional(nodename, neighbourfn, directionfn)
end

-- register a node as a directional flowable whose accepting sides depends upon param2 rotation.
-- used for entry panels, valves, flow sensors and spigots.
-- this is mostly for legacy reasons and SHOULD NOT BE USED IN NEW CODE.
register.directional_horizonal_rotate = function(nodename, doubleended)
	local rotations = {
		{x= 0,y= 0,z= 1},
		{x= 1,y= 0,z= 0},
		{x= 0,y= 0,z=-1},
		{x=-1,y= 0,z= 0},
	}
	local getends = function(node)
		--local dname = "horizontal rotate getends() "
		local param2 = node.param2
		-- the pipeworks nodes use a fixed value for vertical facing nodes
		-- if that is detected, just return that directly.
		if param2 == 17 then
			return {{x=0,y=1,z=0}, {x=0,y=-1,z=0}}
		end

		-- the sole end of the spigot points in the direction the rotation bits suggest
		-- also note to self: lua arrays start at one...
		local mainend = (param2 % 4) + 1
		-- use modulus wrap-around to find other end for straight-run devices like the valve
		local otherend = ((param2 + 2) % 4) + 1
		local mainrot = rotations[mainend]
		--pipeworks.logger(dname.."mainrot: "..dump(mainrot))
		local result
		if doubleended then
			result = { mainrot, rotations[otherend] }
		else
			result = { mainrot }
		end
		--pipeworks.logger(dname.."result: "..dump(result))
		return result
	end
	local neighbourfn = function(node)
		return getends(node)
	end
	local directionfn = function(node, direction)
		local result = false
		for _, endvec in ipairs(getends(node)) do
			if vector.equals(direction, endvec) then result = true end
		end
		return result
	end
	register.directional(nodename, neighbourfn, directionfn)
end



local checkbase = function(nodename)
	if not checkexists(nodename) then error("pipeworks.flowables node doesn't exist as a flowable!") end
end

local duplicateerr = function(kind, nodename) error(kind.." duplicate registration for "..nodename) end



-- Registers a node as a fluid intake.
-- intakefn is used to determine the water that can be taken in a node-specific way.
-- Expects node to be registered as a flowable (is present in flowables.list.all),
-- so that water can move out of it.
-- maxpressure is the maximum pipeline pressure that this node can drive;
-- if the input's node exceeds this the callback is not run.
-- possible WISHME here: technic-driven high-pressure pumps
register.intake = function(nodename, maxpressure, intakefn)
	-- check for duplicate registration of this node
	local list = pipeworks.flowables.inputs.list
	checkbase(nodename)
	if list[nodename] then duplicateerr("pipeworks.flowables.inputs", nodename) end
	list[nodename] = { maxpressure=maxpressure, intakefn=intakefn }
	regwarning("intake", nodename)
end



-- Register a node as a simple intake:
-- tries to absorb water source nodes from it's surroundings.
-- may exceed limit slightly due to needing to absorb whole nodes.
register.intake_simple = function(nodename, maxpressure)
	register.intake(nodename, maxpressure, pipeworks.flowlogic.check_for_liquids_v2)
end



-- Register a node as an output.
-- Expects node to already be a flowable.
-- upper and lower thresholds have different meanings depending on whether finite liquid mode is in effect.
-- if not (the default unless auto-detected),
-- nodes above their upper threshold have their outputfn invoked (and pressure deducted),
-- nodes between upper and lower are left idle,
-- and nodes below lower have their cleanup fn invoked (to say remove water sources).
-- the upper and lower difference acts as a hysteresis to try and avoid "gaps" in the flow.
-- if finite mode is on, upper is ignored and lower is used to determine whether to run outputfn;
-- cleanupfn is ignored in this mode as finite mode assumes something causes water to move itself.
register.output = function(nodename, upper, lower, outputfn, cleanupfn)
	if pipeworks.flowables.outputs.list[nodename] then
		error("pipeworks.flowables.outputs duplicate registration!")
	end
	checkbase(nodename)
	pipeworks.flowables.outputs.list[nodename] = {
		upper=upper,
		lower=lower,
		outputfn=outputfn,
		cleanupfn=cleanupfn,
	}
	-- output ABM now part of main flow logic ABM to preserve ordering.
	-- note that because outputs have to be a flowable first
	-- (and the installation of the flow logic ABM is conditional),
	-- registered output nodes for new_flow_logic is also still conditional on the enable flag.
	regwarning("output node", nodename)
end

-- register a simple output:
-- drains pressure by attempting to place water in nearby nodes,
-- which can be set by passing a list of offset vectors.
-- will attempt to drain as many whole nodes as there are positions in the offset list.
-- for meanings of upper and lower, see register.output() above.
-- non-finite mode:
--	above upper pressure: places water sources as appropriate, keeps draining pressure.
--	below lower presssure: removes it's neighbour water sources.
-- finite mode:
--	same as for above pressure in non-finite mode,
--	but only drains pressure when water source nodes are actually placed.
register.output_simple = function(nodename, upper, lower, neighbours)
	local outputfn = pipeworks.flowlogic.helpers.make_neighbour_output_fixed(neighbours)
	local cleanupfn = pipeworks.flowlogic.helpers.make_neighbour_cleanup_fixed(neighbours)
	register.output(nodename, upper, lower, outputfn, cleanupfn)
end



-- common base checking for transition nodes
-- ensures the node has only been registered once as a transition.
local transition_list = pipeworks.flowables.transitions.list
local insert_transition_base = function(nodename)
	checkbase(nodename)
	if transition_list[nodename] then duplicateerr("base transition", nodename) end
	transition_list[nodename] = true
end



-- register a simple transition set.
-- expects a table with nodenames as keys and threshold pressures as values.
-- internally, the table is sorted by value, and when one of these nodes needs to transition,
-- the table is searched starting from the lowest (even if it's value is non-zero),
-- until a value is found which is higher than or equal to the current node pressure.
-- ex. nodeset = { ["mod:level_0"] = 0, ["mod:level_1"] = 1, --[[ ... ]] }
local simpleseterror = function(msg)
	error("register.transition_simple_set(): "..msg)
end
local simple_transitions = pipeworks.flowables.transitions.simple

register.transition_simple_set = function(nodeset, extras)
	local set = {}
	if extras == nil then extras = {} end

	local length = #nodeset
	if length < 2 then simpleseterror("nodeset needs at least two elements!") end
	for index, element in ipairs(nodeset) do
		if type(element) ~= "table" then simpleseterror("element "..tostring(index).." in nodeset was not table!") end
		local nodename = element[1]
		local value = element[2]
		if type(nodename) ~= "string" then simpleseterror("nodename "..tostring(nodename).."was not a string!") end
		if type(value) ~= "number" then simpleseterror("pressure value "..tostring(value).."was not a number!") end
		insert_transition_base(nodename)
		if simple_transitions[nodename] then duplicateerr("simple transition set", nodename) end
		-- assigning set to table is done separately below

		table.insert(set, { nodename=nodename, threshold=value })
	end

	-- sort pressure values, smallest first
	local smallest_first = function(a, b)
		return a.threshold < b.threshold
	end
	table.sort(set, smallest_first)

	-- individual registration of each node, all sharing this set,
	-- so each node in the set will transition to the correct target node.
	for _, element in ipairs(set) do
		--pipeworks.logger("register.transition_simple_set() after sort: nodename "..element.nodename.." value "..tostring(element.threshold))
		simple_transitions[element.nodename] = set
	end

	-- handle extra options
	-- if mesecons rules table was passed, set for each node
	if extras.mesecons then
		local mesecons_rules = pipeworks.flowables.transitions.mesecons
		for _, element in ipairs(set) do
			mesecons_rules[element.nodename] = extras.mesecons
		end
	end
end
