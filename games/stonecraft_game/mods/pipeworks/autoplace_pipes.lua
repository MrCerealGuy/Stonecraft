--[[

	autorouting for pipes

	To connect pipes to some node, include this in the node def...

	pipe_connections = {
		pattern = <string>,    -- if supplied, search for this pattern instead of the exact node name
		left   = <bool>,       -- true (or 1) if the left side of the node needs to connect to a pipe
		right  = <bool>,       -- or from the right side, etc.
		top    = <bool>,
		bottom = <bool>,
		front  = <bool>,
		back   = <bool>,
		left_param2   = <num>, -- the node must have this param2 to connect from the left
		right_param2  = <num>, -- or right, etc.
		top_param2    = <num>, -- Omit some or all of these to skip checking param2 for those sides
		bottom_param2 = <num>,
		front_param2  = <num>,
		back_param2   = <num>,
	},

	...then add,  pipeworks.scan_for_pipe_objects(pos)
	to your node's after_dig_node and after_place_node callbacks.

]]--

-- get the axis dir (just 6 faces) of target node, assumes the pipe is the axis

function pipeworks.get_axis_dir(nodetable, pattern)
	local pxm,pxp,pym,pyp,pzm,pzp

	if string.find(nodetable.nxm.name, pattern)
	  and minetest.facedir_to_dir(nodetable.nxm.param2).x ~= 0 then
		pxm=1
	end

	if string.find(nodetable.nxp.name, pattern)
	  and minetest.facedir_to_dir(nodetable.nxp.param2).x ~= 0 then
		pxp=1
	end

	if string.find(nodetable.nzm.name, pattern)
	  and minetest.facedir_to_dir(nodetable.nzm.param2).z ~= 0 then
		pzm=1
	end

	if string.find(nodetable.nzp.name, pattern)
	  and minetest.facedir_to_dir(nodetable.nzp.param2).z ~= 0 then
		pzp=1
	end

	if string.find(nodetable.nym.name, pattern)
	  and minetest.facedir_to_dir(nodetable.nym.param2).y ~= 0 then
		pym=1
	end

	if string.find(nodetable.nyp.name, pattern)
	  and minetest.facedir_to_dir(nodetable.nyp.param2).y ~= 0 then
		pyp=1
	end
	local match = pxm or pxp or pym or pyp or pzm or pzp
	return match,pxm,pxp,pym,pyp,pzm,pzp
end

local tube_table = {[0] = 1, 2, 2, 4, 2, 4, 4, 5, 2, 3, 4, 6, 4, 6, 5, 7, 2, 4, 3, 6, 4, 5, 6, 7, 4, 6, 6, 8, 5, 7, 7, 9, 2, 4, 4, 5, 3, 6, 6, 7, 4, 6, 5, 7, 6, 8, 7, 9, 4, 5, 6, 7, 6, 7, 8, 9, 5, 7, 7, 9, 7, 9, 9, 10}
local tube_table_facedirs = {[0] = 0, 0, 5, 0, 3, 4, 3, 0, 2, 0, 2, 0, 6, 4, 3, 0, 7, 12, 5, 12, 7, 4, 5, 5, 18, 20, 16, 0, 7, 4, 7, 0, 1, 8, 1, 1, 1, 13, 1, 1, 10, 8, 2, 2, 17, 4, 3, 6, 9, 9, 9, 9, 21, 13, 1, 1, 10, 10, 11, 2, 19, 4, 3, 0}

local function autoroute_pipes(pos)
	local nctr = minetest.get_node(pos)
	local state = "_empty"
	if (string.find(nctr.name, "pipeworks:pipe_") == nil) then return end
	if (string.find(nctr.name, "_loaded") ~= nil) then state = "_loaded" end
	local nsurround = pipeworks.scan_pipe_surroundings(pos)

	if nsurround == 0 then nsurround = 9 end
	minetest.swap_node(pos, {name = "pipeworks:pipe_"..tube_table[nsurround]..state,
				param2 = tube_table_facedirs[nsurround]})
end

function pipeworks.scan_for_pipe_objects(pos)
	autoroute_pipes({ x=pos.x-1, y=pos.y  , z=pos.z   })
	autoroute_pipes({ x=pos.x+1, y=pos.y  , z=pos.z   })
	autoroute_pipes({ x=pos.x  , y=pos.y-1, z=pos.z   })
	autoroute_pipes({ x=pos.x  , y=pos.y+1, z=pos.z   })
	autoroute_pipes({ x=pos.x  , y=pos.y  , z=pos.z-1 })
	autoroute_pipes({ x=pos.x  , y=pos.y  , z=pos.z+1 })
	autoroute_pipes(pos)
end

-- auto-rotation code for various devices the pipes attach to

function pipeworks.scan_pipe_surroundings(pos)
	local pxm=0
	local pxp=0
	local pym=0
	local pyp=0
	local pzm=0
	local pzp=0

	local nxm = minetest.get_node({ x=pos.x-1, y=pos.y  , z=pos.z   })
	local nxp = minetest.get_node({ x=pos.x+1, y=pos.y  , z=pos.z   })
	local nym = minetest.get_node({ x=pos.x  , y=pos.y-1, z=pos.z   })
	local nyp = minetest.get_node({ x=pos.x  , y=pos.y+1, z=pos.z   })
	local nzm = minetest.get_node({ x=pos.x  , y=pos.y  , z=pos.z-1 })
	local nzp = minetest.get_node({ x=pos.x  , y=pos.y  , z=pos.z+1 })

	local nodetable = {
		nxm = nxm,
		nxp = nxp,
		nym = nym,
		nyp = nyp,
		nzm = nzm,
		nzp = nzp
	}

-- standard handling for pipes...

	if string.find(nxm.name, "pipeworks:pipe_") then pxm=1 end
	if string.find(nxp.name, "pipeworks:pipe_") then pxp=1 end
	if string.find(nym.name, "pipeworks:pipe_") then pym=1 end
	if string.find(nyp.name, "pipeworks:pipe_") then pyp=1 end
	if string.find(nzm.name, "pipeworks:pipe_") then pzm=1 end
	if string.find(nzp.name, "pipeworks:pipe_") then pzp=1 end

-- Special handling for valves...

	local match,a,b,c,d,e,f = pipeworks.get_axis_dir(nodetable, "pipeworks:valve")
	if match then
		pxm = a or pxm
		pxp = b or pxp
		pym = c or pym
		pyp = d or pyp
		pzm = e or pzm
		pzp = f or pzp
	end

-- ...flow sensors...

	local match,a,b,c,d,e,f = pipeworks.get_axis_dir(nodetable, "pipeworks:flow_sensor")
	if match then
		pxm = a or pxm
		pxp = b or pxp
		pym = c or pym
		pyp = d or pyp
		pzm = e or pzm
		pzp = f or pzp
	end

-- ...sealed pipe entry/exit...

	local match,a,b,c,d,e,f = pipeworks.get_axis_dir(nodetable, "pipeworks:entry_panel")
	if match then
		pxm = a or pxm
		pxp = b or pxp
		pym = c or pym
		pyp = d or pyp
		pzm = e or pzm
		pzp = f or pzp
	end

-- ...straight-only pipe...

	local match,a,b,c,d,e,f = pipeworks.get_axis_dir(nodetable, "pipeworks:straight_pipe")
	if match then
		pxm = a or pxm
		pxp = b or pxp
		pym = c or pym
		pyp = d or pyp
		pzm = e or pzm
		pzp = f or pzp
	end

-- ... other nodes

	local def_left   = minetest.registered_nodes[nxp.name] -- the node that {pos} is to the left of (not the
	local def_right  = minetest.registered_nodes[nxm.name] -- ...note that is AT the left!), etc.
	local def_bottom = minetest.registered_nodes[nyp.name]
	local def_top    = minetest.registered_nodes[nym.name]
	local def_front  = minetest.registered_nodes[nzp.name]
	local def_back   = minetest.registered_nodes[nzm.name]

	if def_left and def_left.pipe_connections and def_left.pipe_connections.left
	  and (not def_left.pipe_connections.pattern or string.find(nxp.name, def_left.pipe_connections.pattern))
	  and (not def_left.pipe_connections.left_param2 or (nxp.param2 == def_left.pipe_connections.left_param2)) then
		pxp = 1
	end
	if def_right and def_right.pipe_connections and def_right.pipe_connections.right
	  and (not def_right.pipe_connections.pattern or string.find(nxm.name, def_right.pipe_connections.pattern))
	  and (not def_right.pipe_connections.right_param2 or (nxm.param2 == def_right.pipe_connections.right_param2)) then
		pxm = 1
	end
	if def_top and def_top.pipe_connections and def_top.pipe_connections.top
	  and (not def_top.pipe_connections.pattern or string.find(nym.name, def_top.pipe_connections.pattern))
	  and (not def_top.pipe_connections.top_param2 or (nym.param2 == def_top.pipe_connections.top_param2)) then
		pym = 1
	end
	if def_bottom and def_bottom.pipe_connections and def_bottom.pipe_connections.bottom
	  and (not def_bottom.pipe_connections.pattern or string.find(nyp.name, def_bottom.pipe_connections.pattern))
	  and (not def_bottom.pipe_connections.bottom_param2 or (nyp.param2 == def_bottom.pipe_connections.bottom_param2)) then
		pyp = 1
	end
	if def_front and def_front.pipe_connections and def_front.pipe_connections.front
	  and (not def_front.pipe_connections.pattern or string.find(nzp.name, def_front.pipe_connections.pattern))
	  and (not def_front.pipe_connections.front_param2 or (nzp.param2 == def_front.pipe_connections.front_param2)) then
		pzp = 1
	end
	if def_back and def_back.pipe_connections and def_back.pipe_connections.back
	  and (not def_back.pipe_connections.pattern or string.find(nzm.name, def_back.pipe_connections.pattern))
	  and (not def_back.pipe_connections.back_param2 or (nzm.param2 == def_back.pipe_connections.back_param2)) then
		pzm = 1
	end

	print("stage 2 returns "..pxm+8*pxp+2*pym+16*pyp+4*pzm+32*pzp..
		" for nodes surrounding "..minetest.get_node(pos).name.." at "..minetest.pos_to_string(pos))
	return pxm+8*pxp+2*pym+16*pyp+4*pzm+32*pzp
end

function pipeworks.look_for_stackable_tanks(pos)
	local tym = minetest.get_node({ x=pos.x  , y=pos.y-1, z=pos.z   })

	if string.find(tym.name, "pipeworks:storage_tank_") ~= nil or
	    string.find(tym.name, "pipeworks:expansion_tank_") ~= nil then
		minetest.add_node(pos, { name =  "pipeworks:expansion_tank_0", param2 = tym.param2})
	end
end
