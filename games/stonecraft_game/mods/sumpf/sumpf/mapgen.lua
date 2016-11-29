-- might decrease lag a bit
local minetest = minetest

local hut_allowed
if sumpf.hut_chance > 0 then
	dofile(minetest.get_modpath("sumpf") .. "/huts.lua")
	hut_allowed = sumpf.hut_allowed
else
	function hut_allowed()
		return false
	end
end

local plants_enabled = sumpf.enable_plants
local swampwater = sumpf.swampwater

local c, is_ground, water_allowed
local function define_contents()
	c = {
		air = minetest.get_content_id("air"),
		stone = minetest.get_content_id("default:stone"),
		water = minetest.get_content_id("default:water_source"),
		dirtywater = minetest.get_content_id("sumpf:dirtywater_source"),
		coal = minetest.get_content_id("default:stone_with_coal"),
		iron = minetest.get_content_id("default:stone_with_iron"),

		sumpfg = minetest.get_content_id("sumpf:sumpf"),
		sumpf2 = minetest.get_content_id("sumpf:sumpf2"),
		sumpfstone = minetest.get_content_id("sumpf:junglestone"),
		sumpfcoal = minetest.get_content_id("sumpf:kohle"),
		sumpfiron = minetest.get_content_id("sumpf:eisen"),
		peat = minetest.get_content_id("sumpf:peat"),

		brown_shroom = minetest.get_content_id("riesenpilz:brown"),
		red_shroom = minetest.get_content_id("riesenpilz:red"),
		fly_agaric = minetest.get_content_id("riesenpilz:fly_agaric"),
		sumpfgrass = minetest.get_content_id("sumpf:gras"),
		junglegrass = minetest.get_content_id("default:junglegrass"),

		USUAL_STUFF = {
			[minetest.get_content_id("default:dry_shrub")] = true,
			[minetest.get_content_id("default:cactus")] = true,
			[minetest.get_content_id("default:papyrus")] = true
		},
		TREE_STUFF = {
			[minetest.get_content_id("default:tree")] = true,
			[minetest.get_content_id("default:leaves")] = true,
			[minetest.get_content_id("default:apple")] = true,
		},
	}
	local grounds = {[c.water] = true}
	function is_ground(id)
		local is = grounds[id]
		if is ~= nil then
			return is
		end
		local data = minetest.registered_nodes[minetest.get_name_from_content_id(id)]
		if not data then
			grounds[id] = false
			return false
		end
		local groups = data.groups
		if groups
		and (groups.crumbly == 3 or groups.soil == 1) then
			grounds[id] = true
			return true
		end
		grounds[id] = false
		return false
	end

	if swampwater then
		local hard_nodes = {}	--in time makes a table of nodes which are allowed to be next to swampwater
		local function hard_node(id)
			if not id then
				return false
			end
			local hard = hard_nodes[id]
			if hard ~= nil then
				return hard
			end
			local name = minetest.get_name_from_content_id(id)
			sumpf.inform("<swampwater> testing if "..name.."is a hard node", 3)
			local node = minetest.registered_nodes[name]
			if not node then
				hard_nodes[id] = false
				return false
			end
			local drawtype = node.drawtype
			if not drawtype
			or drawtype == "normal" then
				hard_nodes[id] = true
				return true
			end
			hard_nodes[id] = false
			return false
		end

		--tests if swampwater is allowed to generate at this position
		function water_allowed(data, area, x, y, z)
			for _,p in pairs({
				{0,-1},
				{0,1},
				{-1,0},
				{1,0},
			}) do
				local id = data[area:index(x+p[1], y, z+p[2])]
				if id ~= c.dirtywater
				and not hard_node(id) then
					return false
				end
			end
			return true
		end
	end
end


-- perlin noise "hills" are not peaks but looking like sinus curve
local function upper_rarity(rarity)
	return math.sign(rarity)*math.sin(math.abs(rarity)*math.pi/2)
end

local rarity = sumpf.mapgen_rarity
local sumpf_size = sumpf.mapgen_size

local nosmooth_rarity = 1-rarity/50
local perlin_scale = sumpf_size*100/rarity
local smooth_rarity_max, smooth_rarity_min, smooth_rarity_dif
local smooth = sumpf.smooth
if smooth then
	local smooth_trans_size = sumpf.smooth_trans_size
	smooth_rarity_max = upper_rarity(nosmooth_rarity+smooth_trans_size*2/perlin_scale)
	smooth_rarity_min = upper_rarity(nosmooth_rarity-smooth_trans_size/perlin_scale)
	smooth_rarity_dif = smooth_rarity_max-smooth_rarity_min
end
nosmooth_rarity = upper_rarity(nosmooth_rarity)

local contents_defined
minetest.register_on_generated(function(minp, maxp, seed)

	--avoid calculating perlin noises for unneeded places
	if maxp.y <= -6
	or minp.y >= 150 then
		return
	end

	local x0,z0,x1,z1 = minp.x,minp.z,maxp.x,maxp.z	-- Assume X and Z lengths are equal
	local perlin1 = minetest.get_perlin(1123,3, 0.5, perlin_scale)	--Get map specific perlin

	if not sumpf.always_generate then
		local biome_allowed
		for x = x0, x1, 16 do
			for z = z0, z1, 16 do
				if perlin1:get2d({x=x, y=z}) > nosmooth_rarity then
					biome_allowed = true
					break
				end
			end
			if biome_allowed then
				break
			end
		end
		if not biome_allowed then
			return
		end
	end

	local t1 = os.clock()

		--Information:
	sumpf.inform("tries to generate a swamp at: x=["..x0.."; "..x1.."]; y=["..minp.y.."; "..maxp.y.."]; z=["..z0.."; "..z1.."]", 2)

	local divs = x1-x0
	local pr = PseudoRandom(seed+68)

	if not contents_defined then
		define_contents()
		contents_defined = true
	end

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

	for p_pos in area:iterp(minp, maxp) do	--remove tree stuff
		if data[p_pos] ~= c.air
		and c.TREE_STUFF[data[p_pos]] then
			data[p_pos] = c.air
		end
	end

	local hut
	if hut_allowed(minp) then
		hut = {
			rmin = pr:next(4,6),
			rmax = pr:next(10,20),
			ruin = pr:next(1,2) == 1
		}
		-- sidelen-2*radius_max-2*roof_outside
		local sidelen = maxp.x-minp.x+1
		local hsidelen = math.floor(sidelen/2)
		local diff = math.max(hsidelen-hut.rmax-1, 0)

		hut.x = minp.x+hsidelen+pr:next(-diff,diff)
		hut.z = minp.z+hsidelen+pr:next(-diff,diff)
	end

	local num = 1
	local tab = {}

	local heightmap = minetest.get_mapgen_object("heightmap")
	local hmi = 1

	for j=0,divs do
		for i=0,divs do
			local x,z = x0+i,z0+j

			--Check if we are in a "Swamp biome"
			local in_biome = false
			local test = perlin1:get2d({x=x, y=z})
			if sumpf.always_generate then
				in_biome = true
			elseif smooth then
				--smooth transitions, sinus not used yet
				if test >= smooth_rarity_max
				or (
					test > smooth_rarity_min
					and pr:next(1, 1000) <= ((test-smooth_rarity_min)/smooth_rarity_dif)*1000
				) then
					in_biome = true
				end
			elseif test > nosmooth_rarity then
				in_biome = true
			end

			if in_biome then

				local ymin = math.max(heightmap[hmi]-5, minp.y) -- -5 because of caves

				-- skip the air part
				local ground
				for y = math.min(heightmap[hmi]+20, maxp.y),ymin,-1 do
					if data[area:index(x, y, z)] ~= c.air then
						ground = y
						break
					end
				end

				local ground_y
				if ground then
					for y = ground,ymin,-1 do
						local p_pos = area:index(x, y, z)
						local d_p_pos = data[p_pos]
						if c.USUAL_STUFF[d_p_pos] then --remove usual stuff
							data[p_pos] = c.air
						elseif is_ground(d_p_pos) then --else search ground_y
							ground_y = y
							break
						end
					end
				end

				if ground_y then
					if hut
					and not hut.y
					and x == hut.x
					and z == hut.z then
						hut.y = math.max(1, ground_y)
						hut.y = hut.y + 1
					end

					local p_ground = area:index(x, ground_y, z)

					if data[p_ground] == c.water then	--Dreckseen:
						local h
						if smooth then
							h = pr:next(4,5)
						else
							h = 5
						end	--find_node_near may be a laggy function here
						if minetest.find_node_near({x=x, y=ground_y, z=z}, h, "group:crumbly") then
						--if data[area:index(x, ground_y-(3+pr:next(1,2)), z)] ~= c.water then
							local min = math.max(-pr:next(16,20), minp.y-16-ground_y)
							for y = min,0 do
								local p_pos = area:index(x, y+ground_y, z)
								if data[p_pos] == c.water then
									data[p_pos] = c.dirtywater
								else
									data[p_pos] = c.peat
								end
							end
						end
					else
						local p_boden = area:index(x, ground_y+1, z)
						local d_p_boden = data[p_boden]
						local plant_allowed = plants_enabled
						if swampwater
						and ground_y ~= 1
						and d_p_boden == c.air
						and pr:next(1,2) == 2
						and water_allowed(data, area, x, ground_y, z) then
							plant_allowed = false	--disable plants on swampwater
							local min = math.max(-pr:next(1,9)-10, minp.y-16-ground_y)
							for s=0,min,-1 do
								local p_pos = area:index(x, ground_y+s, z)
								if data[p_pos] == c.air then
									break
								end
								data[p_pos] = c.dirtywater
							end
						else
							local p_uground = area:index(x, ground_y-1, z)
							local p_uuground = area:index(x, ground_y-2, z)
							if sumpf.wet_beaches
							and ground_y == 1
							and d_p_boden == c.air
							and pr:next(1,3) == 1 then
								plant_allowed = false	--disable plants on swampwater
								data[p_ground] = c.dirtywater
								if pr:next(1,3) == 1 then
									data[p_uground] = c.dirtywater
								else
									data[p_uground] = c.peat
								end
								data[p_uuground] = c.peat
							else --Sumpfboden:
								data[p_ground] = c.sumpfg
								data[p_uground] = c.sumpfg
								data[p_uuground] = c.sumpf2
							end
							local min = math.max(-30, minp.y-16-ground_y)
							for i=-3,min,-1 do
								local p_pos = area:index(x, ground_y+i, z)
								local d_p_pos = data[p_pos]
								if d_p_pos == c.air then
									break
								end
								if d_p_pos == c.coal then
									data[p_pos] = c.sumpfcoal
								elseif d_p_pos == c.iron then
									data[p_pos] = c.sumpfiron
								else
									data[p_pos] = c.sumpfstone
								end
							end
						end

						if plant_allowed then	--Pflanzen (und Pilz):

							if pr:next(1,80) == 1 then	-- Birke
								tab[num] = {1, {x=x, y=ground_y+1, z=z}}
								num = num+1
							elseif pr:next(1,20) == 1 then	-- jungletree
								tab[num] = {2, {x=x, y=ground_y+1, z=z}}
								num = num+1
							elseif pr:next(1,50) == 1 then
								data[p_boden] = c.brown_shroom
							elseif pr:next(1,100) == 1 then
								data[p_boden] = c.red_shroom
							elseif pr:next(1,200) == 1 then
								data[p_boden] = c.fly_agaric
							elseif pr:next(1,4) == 1 then
								data[p_boden] = c.sumpfgrass
							elseif pr:next(1,6) == 1 then
								data[p_boden] = c.junglegrass
							end
						end
					end
				end
			end
			hmi = hmi+1
		end
	end
	sumpf.inform("ground finished", 2, t1)

	local param2s
	if num ~= 1 then
		-- spawn trees
		local t2 = os.clock()
		for _,v in pairs(tab) do
			if v[1] == 1 then
				if not param2s then
					param2s = vm:get_param2_data()
				end
				sumpf.generate_birch(v[2], area, data, pr, param2s)
			else
				sumpf.generate_jungletree(v[2], area, data, pr, maxp.y)
			end
		end
		sumpf.inform("trees made", 2, t2)
	end

	if hut
	and hut.y then
		local t2 = os.clock()
		sumpf.generate_hut({x=hut.x, y=hut.y, z=hut.z}, area, data, hut.rmin, hut.rmax, hut.ruin)
		sumpf.inform("hut made", 2, t2)
	end

	local t2 = os.clock()
	vm:set_data(data)
	if param2s then
		vm:set_param2_data(param2s)
	end
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map()
	sumpf.inform("data set", 2, t2)

	sumpf.inform("done", 1, t1)

	--[[local t3 = os.clock()
	minetest.after(0, function(param)
		local tab, minp, maxp, t1, t3 = unpack(param)
		sumpf.inform("continuing", 2, t3)

		local t2 = os.clock()
		if plants_enabled then	--Trees:
			for _,v in ipairs(tab) do
				local p = v[2]
				if v[1] == 1 then
					mache_birke(p, 1)
				else
					sumpf_make_jungletree(p, 1)
				end
			end
		end
		sumpf.inform("trees made", 2, t2)

		local t2 = os.clock()
		fix_light(minp, maxp)
		sumpf.inform("shadows added", 2, t2)
		sumpf.inform("done", 1, t1)
	end, {tab, minp, maxp, t1, t3})]]
end)
