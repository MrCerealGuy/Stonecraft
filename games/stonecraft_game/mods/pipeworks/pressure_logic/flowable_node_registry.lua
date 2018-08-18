-- registry of flowable node behaviours in new flow logic
-- written 2017 by thetaepsilon

-- the actual registration functions which edit these tables can be found in flowable_node_registry_install.lua
-- this is because the ABM code needs to inspect these tables,
-- but the registration code needs to reference said ABM code.
-- so those functions were split out to resolve a circular dependency.



pipeworks.flowables = {}
pipeworks.flowables.list = {}
pipeworks.flowables.list.all = {}
-- pipeworks.flowables.list.nodenames = {}

-- simple flowables - balance pressure in any direction
pipeworks.flowables.list.simple = {}
pipeworks.flowables.list.simple_nodenames = {}

-- directional flowables - can only flow on certain sides
-- format per entry is a table with the following fields:
-- neighbourfn: function(node),
--	called to determine which nodes to consider as neighbours.
--	can be used to e.g. inspect the node's param values for facedir etc.
--	returns: array of vector offsets to look for possible neighbours in
-- directionfn: function(node, vector):
--	can this node flow in this direction?
--	called in the context of another node to check the matching entry returned by neighbourfn.
-- for every offset vector returned by neighbourfn,
-- the node at that absolute position is checked.
-- if that node is also a directional flowable,
-- then that node's vector is passed to that node's directionfn
-- (inverted, so that directionfn sees a vector pointing out from it back to the origin node).
-- if directionfn agrees that the neighbour node can currently flow in that direction,
-- the neighbour is to participate in pressure balancing.
pipeworks.flowables.list.directional = {}

-- simple intakes - try to absorb any adjacent water nodes
pipeworks.flowables.inputs = {}
pipeworks.flowables.inputs.list = {}
pipeworks.flowables.inputs.nodenames = {}

-- outputs - takes pressure from pipes and update world to do something with it
pipeworks.flowables.outputs = {}
pipeworks.flowables.outputs.list = {}
-- not currently any nodenames arraylist for this one as it's not currently needed.

-- nodes with registered node transitions
-- nodes will be switched depending on pressure level
pipeworks.flowables.transitions = {}
pipeworks.flowables.transitions.list = {}	-- master list
pipeworks.flowables.transitions.simple = {}	-- nodes that change based purely on pressure
pipeworks.flowables.transitions.mesecons = {}	-- table of mesecons rules to apply on transition
