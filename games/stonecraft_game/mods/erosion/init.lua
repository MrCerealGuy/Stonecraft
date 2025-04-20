-- Terrain erosion mechanics using moreblocks' slope blocks

if not rawget(_G,"stairsplus") then
	minetest.log("info", "erosion: stairsplus not found")
	return
end
local nntbl,eroding_lut,eroded_lut,eroding_nodes = {},{},{},{--mod defining sloped nodes, materials produced by erosion
	stone = {"moreblocks:","gravel"},
	cobble = {"moreblocks:","gravel"},
	mossycobble = {"moreblocks:","gravel"},
	desert_stone = {"moreblocks:","desert_sand"},
	desert_cobble = {"moreblocks:","desert_sand"},
	sandstone = {"moreblocks:","sand"},
	dirt = {"erosion:","dirt"},
	dirt_with_grass = {"erosion:","dirt"},
	dirt_with_dry_grass = {"erosion:","dirt"},
	dirt_with_snow = {"erosion:","dirt"},
	sand = {"erosion:","sand"},
	desert_sand = {"erosion:","desert_sand"},
	gravel = {"erosion:","gravel"},
	clay = {"erosion:","clay"},
	snowblock = {"erosion:","snowblock"},
	ice = {"moreblocks:","snowblock"},
}
local gen_nodes = {"stone","desert_stone","sandstone","ice"}
local lntbl,erosion_materials = {},{--erosion products to define
	sand = {
		description = "Sand",
		tiles = {"default_sand.png"},
		groups = {sand = 1},
		sounds = default.node_sound_sand_defaults(),
	},
	desert_sand = {
		description = "Desert Sand",
		tiles = {"default_desert_sand.png"},
		groups = {sand = 1},
		sounds = default.node_sound_sand_defaults(),
	},
	gravel = {
		description= "Gravel",
		groups = {},
		tiles={"default_gravel.png"},
		sounds = default.node_sound_gravel_defaults(),
	},
	dirt = {
		description = "Dirt",
		tiles = {"default_dirt.png"},
		groups = {},
		sounds = default.node_sound_dirt_defaults(),
	},
	dirt_with_grass = {
		description = "Grass Turf",
		tiles = {"default_grass.png", "default_dirt.png",
			{name = "default_dirt.png^default_grass_side.png",
				tileable_vertical = false}},
		groups = {},
		sounds = default.node_sound_dirt_defaults({footstep = {name = "default_grass_footstep", gain = 0.25},}),
	},
	dirt_with_dry_grass = {
		description = "Dry Turf",
		tiles = {"default_dry_grass.png",
			"default_dirt.png",
			{name = "default_dirt.png^default_dry_grass_side.png",
				tileable_vertical = false}},
		groups = {},
		drop = 'default:dirt',
		sounds = default.node_sound_dirt_defaults({footstep = {name = "default_grass_footstep", gain = 0.4},}),
	},
	dirt_with_snow = {
		description = "Snow Turf",
		tiles = {"default_snow.png", "default_dirt.png",
			{name = "default_dirt.png^default_snow_side.png",
				tileable_vertical = false}},
		groups = {},
		drop = 'default:dirt',
		sounds = default.node_sound_dirt_defaults({footstep = {name = "default_snow_footstep", gain = 0.15},}),
	},
	clay = {
		description = "Clay",
		tiles = {"default_clay.png"},
		groups = {},
		drop = 'default:clay_lump 4',
		sounds = default.node_sound_dirt_defaults(),
	},
	snowblock = {
		description = "Drifted Snow",
		tiles = {"default_snow.png"},
		groups = {puts_out_fire = 1},
		sounds = default.node_sound_dirt_defaults({footstep = {
			name = "default_snow_footstep", gain = 0.15},
			dug = {name = "default_snow_footstep", gain = 0.2},
			dig = {name = "default_snow_footstep", gain = 0.2}
		}),
	},
--[[	ice = {
		description = "Ice",
		tiles = {"default_ice.png"},
		is_ground_content = false,
		paramtype = "light",
		groups = {cracky = 3, puts_out_fire = 1},
		sounds = default.node_sound_glass_defaults(),
	}--]]
}
for k,v in pairs(erosion_materials) do lntbl[#lntbl+1] = "default:"..k end
local sntbl,snt1,snt2,slopes = {},{},{},{
	[""] = 2,
	_half = 1,
	_half_raised = 3,
	_inner = 1,
	_inner_half = 1,
	_inner_half_raised = 3,
	_inner_cut = 3,
	_inner_cut_half = 2,
	_inner_cut_half_raised = 3,
	_outer = 1,
	_outer_half = 1,
	_outer_half_raised = 3,
	_outer_cut = 1,
	_outer_cut_half = 1,
	_outer_cut_half_raised = 2,
	_cut = 2,
}
for k,v in pairs(eroding_nodes) do nntbl[#nntbl+1] = "default:"..k eroding_lut["default:"..k] = k
	if erosion_materials[k] then for s,d in pairs(slopes) do eroded_lut[v[1].."slope_"..k..s] = {k,s} end end
	if string.find(k,"cobble") then
		for s,d in pairs(slopes) do
			minetest.register_craft({
				output = v[1].."micro_"..k.." "..slopes[s]*2-1,
				recipe = {{v[1].."slope_"..k..s}}
			})
		end
	end
end
local bstbl = {{"_half","","_half_raised"},{"_outer_cut_half","_cut","_inner_cut_half_raised"}}
local function get_adjacent_nodes(p,nlst)
	local xsr,nvt = minetest.find_nodes_in_area({x=p.x-1,y=p.y,z=p.z-1},{x=p.x+1,y=p.y,z=p.z+1},nlst),{}
	for i=1,#xsr do
		nvt[xsr[i].x] = nvt[xsr[i].x] or {}
		nvt[xsr[i].x][xsr[i].z] = i
	end
	return xsr,nvt
end
local function orient_pile(k,m,p) local _,t0 = get_adjacent_nodes(p,{"air"})
	local a,t1 = get_adjacent_nodes(p,snt1)
	local _,t2 = get_adjacent_nodes(p,snt2)
	local x1,z1,x2,z2,d,nm =
	t0[p.x-1] and t0[p.x-1][p.z] and 0 or t1[p.x-1] and t1[p.x-1][p.z] and 1 or t2[p.x-1] and t2[p.x-1][p.z] and 2 or 3,
	t0[p.x] and t0[p.x][p.z-1] and 0 or t1[p.x] and t1[p.x][p.z-1] and 1 or t2[p.x] and t2[p.x][p.z-1] and 2 or 3,
	t0[p.x+1] and t0[p.x+1][p.z] and 0 or t1[p.x+1] and t1[p.x+1][p.z] and 1 or t2[p.x+1] and t2[p.x+1][p.z] and 2 or 3,
	t0[p.x] and t0[p.x][p.z+1] and 0 or t1[p.x] and t1[p.x][p.z+1] and 1 or t2[p.x] and t2[p.x][p.z+1] and 2 or 3
	d = m>3 and 0
	or z2 > z1 and x1 == x2 and 0
	or x2 > x1 and z1 == z2 and 1
	or z1 > z2 and x1 == x2 and 2
	or x1 > x2 and z1 == z2 and 3
	or z2 > z1 and x1 > x2 and 4
	or x2 > x1 and z2 > z1 and 5
	or z1 > z2 and x2 > x1 and 6
	or x1 > x2 and z1 > z2 and 7 or 4
	nm = m<4 and "erosion:slope_"..k..bstbl[d<4 and 1 or 2][m] or "default:"..k
	minetest.swap_node(p,{name=nm,param2=d<4 and d or d-4})
	return a
end
local function pile_up(k,m,p) p.y = p.y-1
	local un,p1,a = minetest.get_node(p),"erosion:slope_"
	if erosion_materials[eroding_lut[un.name]] then erosionCL(p,un) un = minetest.get_node(p) end
	if un.name == "air" or un.name == "default:water_source" then
	elseif eroded_lut[un.name] then
		orient_pile(k,m+slopes[eroded_lut[un.name][2]],p)
		p.y = p.y+1
		minetest.set_node(p,{name="air"})
	else p.y = p.y+1
		a = orient_pile(k,m,p)
		for i=1,#a do local nn = minetest.get_node(a[i])
			orient_pile(eroded_lut[nn.name][1],slopes[eroded_lut[nn.name][2]],a[i])
		end
	end
end
local function slide_off(p,nd) if eroded_lut[nd.name] then p.y = p.y-1
	local un = minetest.get_node(p).name
	if eroded_lut[un] then p.y = p.y+1
		pile_up(eroded_lut[nd.name][1],slopes[eroded_lut[nd.name][2]],p)
	elseif string.sub(un,1,17) == "moreblocks:slope_" then
		local o = get_adjacent_nodes(p,{"air"})
		if o[1] then p.y = p.y+1
			local n = slopes[eroded_lut[nd.name][2]]
			for i=1,#o>n and n or #o do minetest.place_node(o[1],{name="erosion:fall_"..eroding_nodes[eroded_lut[nd.name][1]][2]}) end
			minetest.set_node(p,{name="air"})
		end
	end
end end
for k,v in pairs(erosion_materials) do local drt = eroding_nodes[k][2] == "dirt"
	v.groups.crumbly,v.groups.falling_node,v.groups.not_in_creative_inventory = 3,1,1
	if not drt or k == "dirt" then
		minetest.register_node("erosion:fall_"..k, {
			description = "Loose "..v.description,
			tiles = v.tiles,
			groups = v.groups,
			sounds = v.sounds,
			on_construct = function(pos) pile_up(k,1,pos) end,
		})
		minetest.register_craft({
			type="shapeless",
			output = "default:"..k,
			recipe = {"erosion:fall_"..k,"erosion:fall_"..k,"erosion:fall_"..k,"erosion:fall_"..k,},
		})
	end
	stairsplus:register_slope("erosion",k,"erosion:"..k,v)
	if drt then minetest.override_item("default:"..k,{groups = {crumbly=3,falling_node=1,soil=1}}) end
	for s,d in pairs(slopes) do sntbl[#sntbl+1] = "erosion:slope_"..k..s
		if d<3 then snt1[#snt1+1] = "erosion:slope_"..k..s
		else snt2[#snt2+1] = "erosion:slope_"..k..s end
		minetest.override_item("erosion:slope_"..k..s,
			{drop = "erosion:fall_"..(not drt and k or "dirt").." "..d,
			on_construct = function(pos) pile_up(k,d,pos) end
		})
	end
end
stairsplus:register_slope("moreblocks","ice","moreblocks:ice",{
	description = "Ice",
	tiles = {"default_ice.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, puts_out_fire = 1},
	sounds = default.node_sound_glass_defaults(),
})
function erosionCL(p,node) if not eroding_lut[node.name] then return end
	local rmnn,flmt = eroding_nodes[eroding_lut[node.name]][1].."slope_"..eroding_lut[node.name],
		"erosion:fall_"..eroding_nodes[eroding_lut[node.name]][2]
	local xpsr,nvtbl = get_adjacent_nodes(p,{"air"})
	if xpsr[1] then
		local xr,zr = 0,0
		if nvtbl[p.x] and nvtbl[p.x][p.z-1] then xr = 5
			minetest.place_node({x=p.x,y=p.y,z=p.z-1},{name=flmt})
		elseif nvtbl[p.x] and nvtbl[p.x][p.z+1] then xr = 3
			minetest.place_node({x=p.x,y=p.y,z=p.z+1},{name=flmt})
		end
		if nvtbl[p.x-1] and nvtbl[p.x-1][p.z] then zr = 6
			minetest.place_node({x=p.x-1,y=p.y,z=p.z},{name=flmt})
		elseif nvtbl[p.x+1] and nvtbl[p.x+1][p.z] then zr = 4
			minetest.place_node({x=p.x+1,y=p.y,z=p.z},{name=flmt})
		end
		if xr+zr < 1 then xr,zr = p.x-xpsr[1].x,p.z-xpsr[1].z+15
			minetest.place_node(xpsr[1],{name=flmt})
		end
		if xr+zr < 7 then minetest.swap_node(p,{name=rmnn.."_half_raised",param2=(xr+zr-1)%4})
		elseif xr+zr < 13 then minetest.swap_node(p,{name=rmnn.."_cut",param2=xr>4 and zr/2-2 or (5-zr/2)%4})
		else minetest.swap_node(p,{name=rmnn.."_inner_cut_half_raised",param2=xr>0 and 9-zr/2 or (zr/2)%4}) end
	end
end

local dpstn,cube3,box = {},{},{}
for x=-1,1 do cube3[x]={} for y=-1,1 do cube3[x][y]={} end end
for k,v in pairs(eroding_nodes) do dpstn[k] = minetest.get_content_id("default:"..k)
	for s,_ in pairs(slopes) do dpstn["slp_"..k..s] = minetest.get_content_id(eroding_nodes[k][1].."slope_"..k..s) end
end
dpstn.air = minetest.get_content_id("air")
local function place_slope(data,prm2,vpos,m)
	box.w = data[vpos+cube3[-1][0][0]] == dpstn[m]
	box.e = data[vpos+cube3[1][0][0]] == dpstn[m]
	box.d = data[vpos+cube3[0][-1][0]] == dpstn[m]
	box.u = data[vpos+cube3[0][1][0]] == dpstn[m]
	box.s = data[vpos+cube3[0][0][-1]] == dpstn[m]
	box.n = data[vpos+cube3[0][0][1]] == dpstn[m]
	if box.w or	box.e or box.d or box.u or box.s or box.n then
		box.t = (box.w and 1 or 0)+(box.e and 1 or 0)+(box.d and 1 or 0)+(box.u and 1 or 0)+(box.s and 1 or 0)+(box.n and 1 or 0)
		if box.t == 2 then
			box.f = box.d and box.n and 10
			or box.d and box.e and 1
			or box.d and box.s and 2
			or box.d and box.w and 13
			or box.u and box.n and 20
			or box.u and box.w and 21
			or box.u and box.s and 6
			or box.u and box.e and 17
			or box.e and box.s and 18
			or box.w and box.s and 7
			or box.e and box.n and 9
			or box.w and box.n and 12
			if box.f then data[vpos],prm2[vpos] = dpstn["slp_"..m],box.f
				if not box.e and data[vpos+cube3[-1][0][0]] == dpstn.air
				and data[vpos+cube3[-1][box.u and 1 or box.d and -1 or 0][box.n and 1 or box.s and -1 or 0]] == dpstn[m]
				and vpos%cube3[0][0][1]~=1 then
					data[vpos+cube3[-1][0][0]],prm2[vpos+cube3[-1][0][0]] = dpstn["slp_"..m.."_outer_cut"],box.f
				end
				if not box.u and data[vpos+cube3[0][-1][0]] == dpstn.air
				and data[vpos+cube3[box.e and 1 or box.w and -1 or 0][-1][box.n and 1 or box.s and -1 or 0]] == dpstn[m]
				and vpos>cube3[0][1][0] then
					data[vpos+cube3[0][-1][0]],prm2[vpos+cube3[0][-1][0]] = dpstn["slp_"..m.."_outer_cut"],box.f
				end
				if not box.n and data[vpos+cube3[0][0][-1]] == dpstn.air
				and data[vpos+cube3[box.e and 1 or box.w and -1 or 0][box.u and 1 or box.d and -1 or 0][-1]] == dpstn[m]
				and vpos%cube3[0][1][0]~=cube3[0][0][1] then
					data[vpos+cube3[0][0][-1]],prm2[vpos+cube3[0][0][-1]] = dpstn["slp_"..m.."_outer_cut"],box.f
				end
			end
		elseif box.t == 3 then
			box.f = box.d and box.n and box.w and 0
			or box.d and box.e and box.n and 1
			or box.d and box.s and box.e and 2
			or box.d and box.w and box.s and 3
			or box.u and box.n and box.e and 20
			or box.u and box.w and box.n and 21
			or box.u and box.s and box.w and 22
			or box.u and box.e and box.s and 23
			if box.f then data[vpos],prm2[vpos] = dpstn["slp_"..m.."_inner_cut"],box.f
				if box.e and data[vpos+cube3[-1][0][0]] == dpstn.air
				and data[vpos+cube3[-1][box.u and 1 or box.d and -1 or 0][box.n and 1 or box.s and -1 or 0]] == dpstn[m]
				and vpos%cube3[0][0][1]~=1 then
					data[vpos+cube3[-1][0][0]],prm2[vpos+cube3[-1][0][0]] = dpstn["slp_"..m.."_outer_cut"],box.f
				end
				if box.u and data[vpos+cube3[0][-1][0]] == dpstn.air and vpos>cube3[0][1][0] then
					data[vpos+cube3[0][-1][0]],prm2[vpos+cube3[0][-1][0]] = dpstn["slp_"..m.."_outer_cut"],box.f
				end
				if box.n and data[vpos+cube3[0][0][-1]] == dpstn.air
				and data[vpos+cube3[box.e and 1 or box.w and -1 or 0][box.u and 1 or box.d and -1 or 0][-1]] == dpstn[m]
				and vpos%cube3[0][1][0]~=cube3[0][0][1] then
					data[vpos+cube3[0][0][-1]],prm2[vpos+cube3[0][0][-1]] = dpstn["slp_"..m.."_outer_cut"],box.f
				end
			end
		end
	end
end
local function erosion_slope_gen(minp,maxp,vm,emin,emax)
	local vxa = VoxelArea:new{MinEdge=emin,MaxEdge=emax}
	local data,prm2 = vm:get_data(),vm:get_param2_data()
	for x=-1,1 do for y=-1,1 do	for z=-1,1 do cube3[x][y][z]=x+y*vxa.ystride+z*vxa.zstride end end end
	for vpos=vxa:index(minp.x,minp.y,minp.z),vxa:index(maxp.x,maxp.y,maxp.z) do
		 if data[vpos] == dpstn.air then for i=1,#gen_nodes do place_slope(data,prm2,vpos,gen_nodes[i]) end end
	end
	return data,prm2,vxa
end
minetest.register_on_generated(function(minp,maxp)
	if minp.y > 256 then return end
	local vm,emin,emax = minetest.get_mapgen_object("voxelmanip")
	local data,prm2,vxa = erosion_slope_gen(minp,maxp,vm,emin,emax)
	if maxp.y > 2 then
		local heightmap,hndx,vpos = minetest.get_mapgen_object("heightmap"),1
		for z=minp.z,maxp.z do for x=minp.x,maxp.x do
			vpos = vxa:index(x,heightmap[hndx]+1,z)
			if data[vpos] == dpstn.air then for k,_ in pairs(eroding_nodes) do place_slope(data,prm2,vpos,k) end end
			hndx = hndx+1
		end end
	end
	vm:set_data(data)
	vm:set_param2_data(prm2)
	vm:calc_lighting()
	vm:write_to_map(data)
end)
minetest.register_chatcommand("erosion_slope_gen",{
	description = "Generate erosion slopes in player's current mapchunk",
	privs = {noclip=true,server=true,rollback=true},
	func = function(nm)
		local plyr,p1,p2 = minetest.get_player_by_name(nm)
		if not plyr then return false,"Player not found!" end
		print ("Generating erosion slopes in mapchunk")
		p1 = plyr:getpos()
		p1.x,p1.y,p1.z = 80*math.floor((p1.x+32)/80)-32,80*math.floor((p1.y+32)/80)-32,80*math.floor((p1.z+32)/80)-32
		p2 = {x=p1.x+79,y=p1.y+79,z=p1.z+79}
		local vm = minetest.get_voxel_manip()
		local emin,emax = vm:read_from_map(p1,p2)
		local data,prm2 = erosion_slope_gen(p1,p2,vm,emin,emax)
		vm:set_data(data)
		vm:set_param2_data(prm2)
		vm:calc_lighting()
		vm:write_to_map(data)
		vm:update_map()
		return true,"Done."
	end
})
local function wwthrngCL(p,n) p.y = p.y+1
	local k = minetest.get_node(p).name
	if k == "air" then
		p.y = p.y-1
		erosionCL(p,n)
	end
end
--[[
minetest.register_lbm({
	name = "erosion:initial_load_pass",
	nodenames = nntbl,
	action = wwthrngCL,
})
--]]
minetest.register_abm({
	nodenames = nntbl,
	neighbors = {"air"},
	interval = 37,
	chance = 9,
	action = wwthrngCL,
})

minetest.register_abm({
	nodenames = lntbl,
	neighbors = {"air"},
	interval = 17,
	chance = 7,
	action = wwthrngCL,
})
--[[
minetest.register_abm({--causes dirt/sand/gravel to erode even when covered, may result in excessive erosion
	nodenames = lntbl,
	neighbors = {"air"},
	interval = 43,
	chance = 9,
	action = erosionCL,
})
--]]
minetest.register_abm({
	nodenames = sntbl,
	neighbors = {"air"},
	interval = 7,
	chance = 3,
	action = slide_off,
})

minetest.register_on_punchnode(wwthrngCL)
