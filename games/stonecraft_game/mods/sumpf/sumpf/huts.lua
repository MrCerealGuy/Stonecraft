--[[ tests if a hut might intersect with one in a mapchunk next to it
local chance = sumpf.hut_chance
local function is_allowed(pos)
	return (PseudoRandom(math.abs(pos.x+pos.z*5)+325):next(1,chance) == 1
end

function sumpf.hut_allowed(minp, maxp)
	if not is_allowed(minp) then
		return false
	end
	local sidelen = maxp.x-minp.x+1

	minp.x = minp.x+sidelen
	local there_allowed = is_allowed(minp)
	minp.x = minp.x-sidelen
	if there_allowed then
		return false
	end

	minp.z = minp.z+sidelen
	local there_allowed = is_allowed(minp)
	minp.z = minp.z-sidelen
	if there_allowed then
		return false
	end

	return true
end--]]

local chance = sumpf.hut_chance
function sumpf.hut_allowed(pos)
	return (PseudoRandom(math.abs(pos.x+pos.z*5)+325)):next(1,chance) == 1
end


--~ local used_nodes = {
	--~ floor1 = "default:cobble",
	--~ floor2 = "default:desert_cobble",
	--~ wall = "default:stone",
	--~ glass = "default:glass",
	--~ roof1 = "default:wood",
	--~ roof2 = "stairs:slab_wood",
	--~ bef = "wool:white"
--~ }

--~ local function log(msg, t)
	--~ sumpf.inform(msg, 3, t)
--~ end


-- functions for indexing by x and y
local function get(tab, y,x)
	local data = tab[y]
	if data then
		return data[x]
	end
end

local function set(tab, y,x, data)
	if tab[y] then
		tab[y][x] = data
		return
	end
	tab[y] = {[x] = data}
end

--~ local function remove(tab, y,x)
	--~ if get(tab, y,x) == nil then
		--~ return
	--~ end
	--~ tab[y][x] = nil
	--~ if not next(tab[y]) then
		--~ tab[y] = nil
	--~ end
--~ end

local function gtab2tab(tab)
	local t,n = {},1
	local miny, minx, maxy, maxx
	for y,xs in pairs(tab) do
		if not miny then
			miny = y
			maxy = y
		else
			miny = math.min(miny, y)
			maxy = math.max(maxy, y)
		end
		for x,v in pairs(xs) do
			if not minx then
				minx = x
				maxx = x
			else
				minx = math.min(minx, x)
				maxx = math.max(maxx, x)
			end
			t[n] = {y,x, v}
			n = n+1
		end
	end
	return t, {x=minx, y=miny}, {x=maxx, y=maxy}, n-1
end


--~ local typ_order = {"floor1", "floor2", "wall", "glass", "roof1", "roof2"}

--~ local function vmanip_nodes(tab, nodes, area)
	--~ for typ,ps in pairs(tab) do
		--~ local id = minetest.get_content_id(used_nodes[typ_order[typ]])
		--~ for _,p in pairs(ps) do
			--~ local z,y,x = unpack(p)
			--~ nodes[area:index(x,y,z)] = id
		--~ end
	--~ end
--~ end

--~ local function vmanip_spawn_nodes(tab)

	--~ local minz,miny,minx, maxz,maxy,maxx
	--~ for _,ps in pairs(tab) do
		--~ for _,p in pairs(ps) do
			--~ local z,y,x = unpack(p)
			--~ if not minz then
				--~ minz = z
				--~ miny = y
				--~ minx = x
				--~ maxz = z
				--~ maxy = y
				--~ maxx = x
			--~ else
				--~ minz = math.min(z, minz)
				--~ miny = math.min(y, miny)
				--~ minx = math.min(x, minx)
				--~ maxz = math.max(z, maxz)
				--~ maxy = math.max(y, maxy)
				--~ maxx = math.max(x, maxx)
			--~ end
		--~ end
	--~ end
	--~ minp = {x=minx, y=miny, z=minz}
	--~ maxp = {x=maxx, y=maxy, z=maxz}

	--~ local manip = minetest.get_voxel_manip()
	--~ local emerged_pos1, emerged_pos2 = manip:read_from_map(minp, maxp)
	--~ local area = VoxelArea:new({MinEdge=emerged_pos1, MaxEdge=emerged_pos2})
	--~ local nodes = manip:get_data()

	--~ vmanip_nodes(tab, nodes, area)

	--~ manip:set_data(nodes)
	--~ manip:write_to_map()
	--~ log("nodes set after ", t1)
	--~ log("map updated", t1)
--~ end

-- [[ gibt die Positionen innerhalb an (Wandprüfung)
-- und erneuert die Wand Positionen
local function get_inside_ps(startpos, ps, corners)
	local todo,n = {startpos},1
	local avoid = {}
	local tab2 = {}
	local itab = {}
	local new_wall_ps = {}
	local new_wall_tab = {}
	while n do
		local pos = todo[n]

		for i = -1,1,2 do
			for _,p in pairs({
				{x=pos.x+i, z=pos.z},
				{x=pos.x, z=pos.z+i},
			}) do
				local z,x = p.z,p.x
				if x < corners[1]
				or x > corners[2]
				or z < corners[3]
				or z > corners[4] then
					return false
				end
				if not get(avoid, z,x) then
					set(avoid, z,x, true)
					if get(ps, z,x) then
						set(new_wall_ps, z,x, true)
						new_wall_tab[#new_wall_tab+1] = p
					else
						set(tab2, z,x, true)
						itab[#itab+1] = p
						todo[#todo+1] = p
					end
				end
			end
		end

		todo[n] = nil
		n = next(todo)
	end
	return tab2, itab, new_wall_ps, new_wall_tab
end--]]

-- gibt die min und max Werte an
local function get_minmax_coord(oldmin, oldmax, new)
	if not oldmin then
		return new, new
	end
	return math.min(oldmin, new), math.max(oldmax, new)
end

-- gibt die Boden Positionen
local function get_floor_ps(ps, ps_list)
	local xmin, xmax, zmin, zmax
	for _,p in pairs(ps_list) do
		xmin, xmax = get_minmax_coord(xmin, xmax, p.x)
		zmin, zmax = get_minmax_coord(zmin, zmax, p.z)
	end
	return get_inside_ps(
		{x = math.floor((xmin + xmax) / 2), z = math.floor((zmin + zmax) / 2)},
		ps, {xmin-1, xmax+1, zmin-1, zmax+1})
end

-- gibt die Dach Positionen
local function get_roof_ps(wall_ps_list, ps, ps_list)
	for _,p in pairs(wall_ps_list) do
		if not get(ps, p.z,p.x) then
			table.insert(ps_list, p)
			set(ps, p.z,p.x, true)
		end
	end
	for _,p in pairs(wall_ps_list) do
		for i = -1,1,2 do
			for _,pos in pairs({
				{x=p.x+i, z=p.z},
				{x=p.x, z=p.z+i},
			}) do
				if not get(ps, pos.z,pos.x) then
					set(ps, pos.z,pos.x, true)
					pos.h = true
					table.insert(ps_list, pos)
				end
			end
		end
	end
end

-- gibt die Distanz zur naechsten Wandsaeule, Manhattan-Metrik
local function get_wall_dist(pos, wall_ps)
	if pos.h then
		return -1
	end
	if get(wall_ps, pos.z,pos.x) then
		return 0
	end
	local dist = 1
	while dist <= 999 do
		for z = -dist,dist do
			for x = -dist,dist do
				if math.abs(x+z) == dist
				and get(wall_ps, pos.z+z,pos.x+x) then
					return dist
				end
			end
		end
		dist = dist+1
	end
	return 1000
end

-- macht eine Saeule der Wand
local glass_count = -1
local function make_wall(tab, z,y,x)
	local nam
	local n = #tab[3]+1
	tab[3][n] = {z,y-1,x}
	tab[3][n+1] = {z,y,x}
	if glass_count >= 8
	or (math.random(8) == 1 and glass_count >= 4)
	or glass_count == -1 then
		nam = 3
		glass_count = 0
	else
		nam = 4
		glass_count = glass_count+1
	end
	for i = 1,3 do
		tab[nam][#tab[nam]+1] = {z,y+i,x}
	end
end

-- macht einen Block des Bodens
local function make_floor_node(tab, z,y,x)
	local typ
	if z%2 == 0
	or (x%4 == 1 and z%4 == 1)
	or (x%4 == 3 and z%4 == 3) then
		typ = 1
	else
		typ = 2
	end
	tab[typ][#tab[typ]+1] = {z,y,x}
end

-- erstellt den Boden und das Dach
local function make_floor_and_roof(ps,ps_list, wall_ps, wall_ps_list, y, tab)
	y = y-1
	for _,p in pairs(ps_list) do
		make_floor_node(tab, p.z,y,p.x)
	end
	y = y+1
	get_roof_ps(wall_ps_list, ps, ps_list)
	local n1 = 1
	local n2 = 1
	for _,p in pairs(ps_list) do
		local h = get_wall_dist(p, wall_ps)/2
		local h2 = math.ceil(h)
		if h == h2 then
			tab[5][n1] = {p.z,y+4+h,p.x}
			n1 = n1+1
		else
			tab[6][n2] = {p.z,y+4+h2,p.x}
			n2 = n2+1
		end
	end
end

-- reiht die wandpositionen auf
local function arrange_wall_ps_list(pos, wall_ps)
	local ps_list,n = {},1
	local dones = {}
	local current = {pos.z,pos.x}
	while current do
		local yc,xc = unpack(current)
		current = false
		for y = yc-1, yc+1 do
			for x = xc-1, xc+1 do
				if get(wall_ps, y,x)
				and not get(dones, y,x) then
					set(dones, y,x, true)
					ps_list[n] = {y,x}
					n = n+1
					current = {y,x}
					break
				end
			end
			if current then
				break
			end
		end
	end
	return ps_list
end

-- erstellt die Wände
local function make_walls(pos, ps, y, tab)
	for _,p in ipairs(arrange_wall_ps_list(pos, ps)) do
		make_wall(tab, p[1],y,p[2])
	end
	glass_count = -1
end

local function get_hut_node_ps(wall_ps_initial, wall_ps_list_initial, y)
	local ps,ps_list, wall_ps,wall_ps_list = get_floor_ps(wall_ps_initial,
		wall_ps_list_initial)
	local node_ps = {{},{},{},{},{},{}}
	if not ps
	or #wall_ps_list < 2 then
		return node_ps
	end

	make_walls(wall_ps_list[1], wall_ps, y, node_ps)
	make_floor_and_roof(ps,ps_list, wall_ps, wall_ps_list, y, node_ps)
	return node_ps
end

-- returns a perlin chunk field of positions
local default_nparams = {
   offset = 0,
   scale = 1,
   seed = 3337,
   octaves = 6,
   persist = 0.6
}
local function get_perlin_field(rmin, rmax, nparams)
	local t1 = minetest.get_us_time()

	local r = math.ceil(rmax)
	nparams = nparams or {}
	for i,v in pairs(default_nparams) do
		nparams[i] = nparams[i] or v
	end
	nparams.spread = nparams.spread or vector.from_number(r*5)

	local pos = {x=math.random(-30000, 30000), y=math.random(-30000, 30000)}
	local map = minetest.get_perlin_map(nparams, vector.from_number(r+r+1)):get2dMap_flat(pos)

	local id = 1

	local bare_maxdist = rmax*rmax
	local bare_mindist = rmin*rmin

	local mindist = math.sqrt(bare_mindist)
	local dist_diff = math.sqrt(bare_maxdist)-mindist
	mindist = mindist/dist_diff

	local pval_min, pval_max

	local tab = {}
	for z=-r,r do
		local bare_dist_z = z*z
		for x=-r,r do
			local bare_dist = bare_dist_z + x*x
			local add = bare_dist < bare_mindist
			local pval, distdiv
			if not add
			and bare_dist <= bare_maxdist then
				distdiv = math.sqrt(bare_dist)/dist_diff-mindist
				pval = math.abs(map[id]) -- strange perlin values…
				if not pval_min then
					pval_min = pval
					pval_max = pval
				else
					pval_min = math.min(pval, pval_min)
					pval_max = math.max(pval, pval_max)
				end
				add = true--distdiv < 1-math.abs(map[id])
			end

			if add then
				tab[#tab+1] = {z,x, pval, distdiv}
			end
			id = id+1
		end
	end

	-- change strange values
	local pval_diff = pval_max - pval_min
	pval_min = pval_min/pval_diff

	for n,i in pairs(tab) do
		if i[3] then
			local new_pval = math.abs(i[3]/pval_diff - pval_min)
			if i[4] < new_pval then
				tab[n] = {i[1], i[2]}
			else
				tab[n] = nil
			end
		end
	end

	minetest.log("info", ("[home_builder] table created after ca. %.3g s"
		):format((minetest.get_us_time() - t1) / 1000000))
	return tab
end

--[[ tests if it's a round corner
local function outcorner(tab, y,x)
	return (
		get(tab, y+1,x)
		or get(tab, y-1,x)
	)
	and (
		get(tab, y,x+1)
		or get(tab, y,x-1)
	)
end--]]

-- filters possible wall positions from the perlin field
local function get_wall_ps(rmin, rmax)
	local tab = get_perlin_field(rmin, rmax)
	local gtab = {}
	for _,p in pairs(tab) do
		set(gtab, p[1],p[2], true)
	end
	for _,p in pairs(tab) do
		local y,x = unpack(p)
		local is_wall
		for i = -1,1,2 do
			if get(gtab, y+i,x) == nil
			or get(gtab, y,x+i) == nil then
				is_wall = true
				break
			end
		end
		if not is_wall then
			set(gtab, y,x, false)
		end
	end
	--[[for _,p in pairs(tab) do
		local y,x = unpack(p)
		if get(gtab, y,x)
		and outcorner(gtab, y,x) then
			remove(gtab, y,x)
		end
	end--]]
	return gtab,gtab2tab(gtab)
end

-- returns table of positions and which type would be there
local function get_hut_nodes(pos, rmin, rmax)
	local _, wall_ps_list_rel = get_wall_ps(rmin, rmax)
	local wall_ps = {}
	local wall_ps_list,n = {},1
	for _,p in pairs(wall_ps_list_rel) do
		if p[3] then
			local x = pos.x+p[2]
			local z = pos.z+p[1]
			wall_ps_list[n] = {x=x, y=pos.y, z=z}
			n = n+1
			set(wall_ps, z,x, true)
		end
	end
	if not wall_ps
	or #wall_ps_list < 2 then
		return
	end
	return get_hut_node_ps(wall_ps, wall_ps_list, pos.y)
end


-- in time makes a table of nodes where the house can stand on
local hard_nodes = {}
local function hard_node(id)
	if not id then
		return false
	end
	local hard = hard_nodes[id]
	if hard ~= nil then
		return hard
	end
	local name = minetest.get_name_from_content_id(id)
	hard = name == "ignore" or minetest.get_item_group(name, "cracky") > 0
	hard_nodes[id] = hard
	return hard
end

local norm_nodes = {}	--in time makes a table of nodes which are usual
local function usual_node(id)
	if not id then
		return false
	end
	local hard = norm_nodes[id]
	if hard ~= nil then
		return hard
	end
	local name = minetest.get_name_from_content_id(id)
	sumpf.inform("<swampwater> testing if "..name.."is an usual node", 3)
	local node = minetest.registered_nodes[name]
	if not node then
		norm_nodes[id] = false
		return false
	end
	local drawtype = node.drawtype
	if not drawtype
	or drawtype == "normal" then
		norm_nodes[id] = true
		return true
	end
	norm_nodes[id] = false
	return false
end


local c_air = minetest.get_content_id("air")
local c_birch = minetest.get_content_id("sumpf:tree")
local c_jungletree = minetest.get_content_id("default:jungletree")
local c_primfloor = minetest.get_content_id("sumpf:cobble")
local c_secofloor = minetest.get_content_id("sumpf:junglestonebrick")
local c_wall = c_birch
local c_glass
if minetest.registered_nodes["moreblocks:super_glow_glass"] then
	c_glass = minetest.get_content_id("moreblocks:super_glow_glass")
else
	c_glass = minetest.get_content_id("default:glass")
end
local c_primroof = minetest.get_content_id("sumpf:roofing")
local c_secoroof = minetest.get_content_id("stairs:slab_sumpf_roofing") --slab
local c_glass_ruin = minetest.get_content_id("default:obsidian_glass")

-- should be a ruin with somehow fresh grass roofing (todo: how???)
local function generate_ruin_hut(area, nodes, tab, floor_y)
	-- the primary floor is a fairly stable bottom plate
	for _,p in pairs(tab[1]) do
		local z,y,x = unpack(p)
		nodes[area:index(x,y,z)] = c_primfloor
	end

	-- the secondary floor means decoration in the plate
	for _,p in pairs(tab[2]) do
		local z,y,x = unpack(p)
		p = area:index(x,y,z)
		if not usual_node(nodes[p]) then
			nodes[p] = c_secofloor
		end
	end

	-- the wall is made of birch wood,
	-- the builders didn't know it doesn't last long
	for _,p in pairs(tab[3]) do
		local z,y,x = unpack(p)
		local vi = area:index(x,y,z)
		if not hard_node(nodes[vi]) then
			nodes[vi] = c_wall
			if y == floor_y+1 then
				vi = vi - 3 * area.ystride
				for _ = 0, 98 do
					if hard_node(nodes[vi]) then
						break
					end
					nodes[vi] = c_wall
					vi = vi - area.ystride
				end
			end
		end
	end

	-- the obisidian glass is used to not get dirty so fast
	for _,p in pairs(tab[4]) do
		local z,y,x = unpack(p)
		p = area:index(x,y,z)
		if not usual_node(nodes[p]) then
			nodes[p] = c_glass_ruin
		end
	end

	-- the primary roofing's stability must be researched
	for _,p in pairs(tab[5]) do
		local z,y,x = unpack(p)
		p = area:index(x,y,z)
		if nodes[p] == c_air then
			nodes[p] = c_primroof
		end
	end

	-- increasing stability a bit the secondary roofing becomes primary if a not
	-- air is above it (e.g. leaves)
	for _,p in pairs(tab[6]) do
		local z,y,x = unpack(p)
		p = area:index(x,y,z)
		if nodes[p] == c_air then
			if nodes[area:index(x,y+1,z)] == c_air then
				nodes[p] = c_secoroof
			else
				nodes[p] = c_primroof
			end
		end
	end
end

-- this one shouldn't be a ruin
local function generate_fresh_hut(area, nodes, tab, floor_y)
	-- the primary floor is a fairly stable bottom plate
	for _,p in pairs(tab[1]) do
		local z,y,x = unpack(p)
		nodes[area:index(x,y,z)] = c_primfloor
	end

	-- the secondary floor means decoration in the plate
	for _,p in pairs(tab[2]) do
		local z,y,x = unpack(p)
		nodes[area:index(x,y,z)] = c_secofloor
	end

	-- the wall is made of birch wood
	for _,p in pairs(tab[3]) do
		local z,y,x = unpack(p)
		local vi = area:index(x,y,z)
		nodes[vi] = c_wall
		if y == floor_y+1 then
			vi = vi - 3 * area.ystride
			for _ = 0, 98 do
				if hard_node(nodes[vi]) then
					break
				end
				nodes[vi] = c_wall
				vi = vi - area.ystride
			end
		end
	end

	-- glass needs to glow for lighting
	for _,p in pairs(tab[4]) do
		local z,y,x = unpack(p)
		p = area:index(x,y,z)
		if (not usual_node(nodes[p])
			and y == floor_y+1)
		or not usual_node(nodes[p + (floor_y + 1 - y) * area.ystride]) then
			nodes[p] = c_glass
		else
			nodes[p] = c_wall
		end
	end

	-- the primary roofing
	for _,p in pairs(tab[5]) do
		local z,y,x = unpack(p)
		local vi = area:index(x,y,z)
		-- [[ jungletree pillars for stability
		if y >= floor_y+8
		and nodes[vi] == c_jungletree then
			vi = vi + (floor_y - y) * area.ystride
			for _ = 0,y-1-floor_y do
				if nodes[vi] == c_jungletree then
					break
				end
				nodes[vi] = c_jungletree
				vi = vi + area.ystride
			end
		else--]]
			nodes[vi] = c_primroof
			if y ~= floor_y+4 then
				vi = vi + (floor_y - y) * area.ystride
				for _ = 0,y-1-floor_y  do
					nodes[vi] = c_air
					vi = vi + area.ystride
				end
			end
		end
	end

	-- increasing stability a bit the secondary roofing becomes primary if a not
	-- air is above it (e.g. leaves)
	for _,p in pairs(tab[6]) do
		local z,y,x = unpack(p)
		local vi = area:index(x,y,z)
		-- [[ jungletree pillars also here
		if y >= floor_y+8
		and nodes[vi] == c_jungletree then
			vi = vi + (floor_y - y) * area.ystride
			for _ = 0,y-1-floor_y do
				if nodes[vi] == c_jungletree then
					break
				end
				nodes[vi] = c_jungletree
				vi = vi + area.ystride
			end
		else--]]
			local free_above = nodes[vi + area.ystride] == c_air
			if y == floor_y+4 then
				if free_above
				and not usual_node(nodes[vi]) then
					nodes[vi] = c_secoroof
				end
			else
				if free_above then
					nodes[vi] = c_secoroof
				else
					nodes[vi] = c_primroof
				end
				vi = vi + (floor_y - y) * area.ystride
				for _ = 0,y-1-floor_y do
					nodes[vi] = c_air
					vi = vi + area.ystride
				end
			end
		end
	end
end

function sumpf.generate_hut(pos, area, nodes, rmin, rmax, ruin)
	local tab = get_hut_nodes(pos, rmin, rmax)
	if ruin then
		generate_ruin_hut(area, nodes, tab, pos.y)
	else
		generate_fresh_hut(area, nodes, tab, pos.y)
	end
end
