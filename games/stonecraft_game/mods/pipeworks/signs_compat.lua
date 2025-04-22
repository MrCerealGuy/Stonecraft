-- This file adds placement rules for signs_lib, if present

local spv = {
	[4] = true,
	[6] = true,
	[8] = true,
	[10] = true,
	[13] = true,
	[15] = true,
	[17] = true,
	[19] = true
}

local sphns = {
	[1] = true,
	[3] = true,
	[5] = true,
	[7] = true,
	[9] = true,
	[11] = true,
	[21] = true,
	[23] = true
}

local sphew = {
	[0] = true,
	[2] = true,
	[12] = true,
	[14] = true,
	[16] = true,
	[18] = true,
	[20] = true,
	[22] = true
}

local owtv = {
	[5] = true,
	[7] = true,
	[9] = true,
	[11] = true,
	[12] = true,
	[14] = true,
	[16] = true,
	[18] = true
}

local owtns = {
	[0] = true,
	[2] = true,
	[4] = true,
	[6] = true,
	[8] = true,
	[10] = true,
	[20] = true,
	[22] = true
}

local owtew = {
	[1] = true,
	[3] = true,
	[13] = true,
	[15] = true,
	[17] = true,
	[19] = true,
	[21] = true,
	[23] = true
}

local vert_n = {
	[3] = {[5] = true},
	[6] = {[9] = true, [12] = true, [16] = true},
	[7] = {[9] = true, [11] = true},
}

local vert_e = {
	[3] = {[5] = true},
	[6] = {[5] = true, [9] = true, [16] = true},
	[7] = {[7] = true, [11] = true},
}

local vert_s = {
	[3] = {[5] = true},
	[6] = {[5] = true, [12] = true, [16] = true},
	[7] = {[5] = true, [7] = true},
}

local vert_w = {
	[3] = {[5] = true},
	[6] = {[5] = true, [9] = true, [12] = true},
	[7] = {[5] = true, [9] = true},
}

local horiz_n = {
	[3] = {[0] = true},
	[6] = {[0] = true, [4] = true, [20] = true},
	[7] = {[2] = true, [10] = true},
	[8] = {[0] = true},
	[9] = {[2] = true},
}

local horiz_e = {
	[3] = {[1] = true},
	[6] = {[1] = true, [17] = true, [21] = true},
	[7] = {[3] = true, [19] = true},
	[8] = {[1] = true},
	[9] = {[3] = true},
}

local horiz_s = {
	[3] = {[0] = true},
	[6] = {[0] = true, [8] = true, [20] = true},
	[7] = {[0] = true, [4] = true},
	[8] = {[0] = true},
	[9] = {[0] = true},
}

local horiz_w = {
	[3] = {[1] = true},
	[6] = {[1] = true, [13] = true, [21] = true},
	[7] = {[1] = true, [13] = true},
	[8] = {[1] = true},
	[9] = {[1] = true},
}

local function get_sign_dir(node, def)
	if (node.param2 == 4 and def.paramtype2 == "wallmounted")
	  or (node.param2 == 0 and def.paramtype2 ~= "wallmounted") then
		return {["N"] = true}
	elseif (node.param2 == 2 and def.paramtype2 == "wallmounted")
	  or (node.param2 == 1 and def.paramtype2 ~= "wallmounted") then
		return {["E"] = true}
	elseif (node.param2 == 5 and def.paramtype2 == "wallmounted")
	  or (node.param2 == 2 and def.paramtype2 ~= "wallmounted") then
		return {["S"] = true}
	elseif node.param2 == 3 then
		return {["W"] = true}
	end
	return {}
end

--[[
In the functions below:

 pos: the (real) position of the placed sign
 node: the sign node itself
 def: its definition

 ppos: the position of the pointed node (pipe/tube)
 pnode: the node itself
 pdef: its definition

--]]


-- pipes

function pipeworks.check_for_vert_pipe(pos, node, def, ppos, pnode, pdef)
	local signdir = get_sign_dir(node, def)
	local pipenumber = pdef.pipenumber
	local pipedir = pnode.param2
	if string.find(pnode.name, "straight_pipe") and spv[pipedir] then
		return true
	elseif signdir["N"] and vert_n[pipenumber] and vert_n[pipenumber][pipedir] then
		return true
	elseif signdir["E"] and vert_e[pipenumber] and vert_e[pipenumber][pipedir] then
		return true
	elseif signdir["S"] and vert_s[pipenumber] and vert_s[pipenumber][pipedir] then
		return true
	elseif signdir["W"] and vert_w[pipenumber] and vert_w[pipenumber][pipedir] then
		return true
	end
end

function pipeworks.check_for_horiz_pipe(pos, node, def, ppos, pnode, pdef)
	local signdir = get_sign_dir(node, def)
	local pipenumber = pdef.pipenumber
	local pipedir = pnode.param2
	if string.find(pnode.name, "straight_pipe") then
		if (signdir["N"] or signdir["S"]) and sphns[pipedir] then
			return true
		elseif (signdir["E"] or signdir["W"]) and sphew[pipedir] then
			return true
		end
	elseif signdir["N"] and horiz_n[pipenumber] and horiz_n[pipenumber][pipedir] then
		return true
	elseif signdir["E"] and horiz_e[pipenumber] and horiz_e[pipenumber][pipedir] then
		return true
	elseif signdir["S"] and horiz_s[pipenumber] and horiz_s[pipenumber][pipedir] then
		return true
	elseif signdir["W"] and horiz_w[pipenumber] and horiz_w[pipenumber][pipedir] then
		return true
	end
end

-- tubes

function pipeworks.check_for_vert_tube(pos, node, def, ppos, pnode, pdef)
	local signdir = get_sign_dir(node, def)
	local tubenumber = pdef.tubenumber
	local tubedir = pnode.param2
	if pnode.name == "pipeworks:one_way_tube" and owtv[tubedir] then
		return true
	elseif tubenumber == 2 and (tubedir == 5 or tubedir == 7) then -- it's a stub pointing up or down
		return true
	elseif signdir["N"] and vert_n[tubenumber] and vert_n[tubenumber][tubedir] then
		return true
	elseif signdir["E"] and vert_e[tubenumber] and vert_e[tubenumber][tubedir] then
		return true
	elseif signdir["S"] and vert_s[tubenumber] and vert_s[tubenumber][tubedir] then
		return true
	elseif signdir["W"] and vert_w[tubenumber] and vert_w[tubenumber][tubedir] then
		return true
	end
end

function pipeworks.check_for_horiz_tube(pos, node, def, ppos, pnode, pdef)
	local signdir = get_sign_dir(node, def)
	local tubenumber = pdef.tubenumber
	local tubedir = pnode.param2
	if tubenumber == 2 then -- it'a a stub pointing sideways
		if (tubedir == 0 or tubedir == 2) and (signdir["N"] or signdir["S"]) then
			return true
		elseif (tubedir == 1 or tubedir == 3) and (signdir["E"] or signdir["W"]) then
			return true
		end
	elseif pnode.name == "pipeworks:one_way_tube" then
		if (signdir["N"] or signdir["S"]) and owtns[tubedir] then
			return true
		elseif (signdir["E"] or signdir["W"]) and owtew[tubedir] then
			return true
		end
	elseif signdir["N"] and horiz_n[tubenumber] and horiz_n[tubenumber][tubedir] then
		return true
	elseif signdir["E"] and horiz_e[tubenumber] and horiz_e[tubenumber][tubedir] then
		return true
	elseif signdir["S"] and horiz_s[tubenumber] and horiz_s[tubenumber][tubedir] then
		return true
	elseif signdir["W"] and horiz_w[tubenumber] and horiz_w[tubenumber][tubedir] then
		return true
	end
end
