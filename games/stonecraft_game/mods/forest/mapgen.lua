-- 3D noises

local np_n1 = {
	offset = 0,
	scale = 1,
	spread = {x=30, y=30, z=30},
	seed = 5203,
	octaves = 3,
	persist = 0.6
}

local np_n2 = {
	offset = 0,
	scale = 1,
	spread = {x=30, y=30, z=30},
	seed = 7660,
	octaves = 3,
	persist = 0.6
}

local np_n3 = {
	offset = 0,
	scale = 1,
	spread = {x=30, y=30, z=30},
	seed = 3289,
	octaves = 3,
	persist = 0.6
}

local np_n4 = {
	offset = 0,
	scale = 1,
	spread = {x=150, y=150, z=150},
	seed = 5435,
	octaves = 3,
	persist = 0.6
}

-- 2D noises

local np_n5 = {
	offset = 0,
	scale = 1,
	spread = {x=80, y=80, z=80},
	seed = 9849,
	octaves = 3,
	persist = 0.6
}

local np_n6 = {
	offset = 0,
	scale = 1,
	spread = {x=200, y=200, z=200},
	seed = 7237,
	octaves = 3,
	persist = 0.6
}

local np_n7 = {
	offset = 0,
	scale = 1,
	spread = {x=600, y=600, z=600},
	seed = 5096,
	octaves = 3,
	persist = 0.6
}

local np_n8 = {
	offset = 0,
	scale = 1,
	spread = {x=20, y=20, z=20},
	seed = 7230,
	octaves = 3,
	persist = 0.6
}

local np_n9 = {
	offset = 0,
	scale = 1,
	spread = {x=20, y=20, z=20},
	seed = 9933,
	octaves = 3,
	persist = 0.6
}

-- elevation noises

local np_n1e = {
	offset = 0,
	scale = 1,
	spread = {x=50, y=50, z=50},
	seed = 6831,
	octaves = 3,
	persist = 0.2
}

local np_n2e = {
	offset = 0,
	scale = 1,
	spread = {x=50, y=50, z=50},
	seed = 1590,
	octaves = 3,
	persist = 0.2
}

local np_n3e = {
	offset = 0,
	scale = 1,
	spread = {x=25, y=25, z=25},
	seed = 4385,
	octaves = 3,
	persist = 0.2
}

local np_n4e = {
	offset = 0,
	scale = 1,
	spread = {x=25, y=25, z=25},
	seed = 9726,
	octaves = 3,
	persist = 0.2
}

local np_n5e = {
	offset = 0,
	scale = 1,
	spread = {x=10, y=10, z=10},
	seed = 1792,
	octaves = 3,
	persist = 0.2
}

local np_n6e = {
	offset = 0,
	scale = 1,
	spread = {x=10, y=10, z=10},
	seed = 1016,
	octaves = 3,
	persist = 0.2
}

local np_n7e = {
	offset = 0,
	scale = 1,
	spread = {x=300, y=300, z=300},
	seed = 8110,
	octaves = 3,
	persist = 0.2
}

local np_n8e = {
	offset = 0,
	scale = 1,
	spread = {x=400, y=400, z=400},
	seed = 2698,
	octaves = 3,
	persist = 0.2
}

-- elevation function for spawnplayer

function get_elevation(pos)
	local pos2d = {x = pos.x, y = pos.z}
	local n1 = minetest.get_perlin(6831, 3, 0.2, 50):get2d(pos2d)
	local n2 = minetest.get_perlin(1590, 3, 0.2, 50):get2d(pos2d)
	local n3 = minetest.get_perlin(4385, 3, 0.2, 25):get2d(pos2d)
	local n4 = minetest.get_perlin(9726, 3, 0.2, 25):get2d(pos2d)
	local n5 = minetest.get_perlin(1792, 3, 0.2, 10):get2d(pos2d)
	local n6 = minetest.get_perlin(1016, 3, 0.2, 10):get2d(pos2d)
	local n7 = minetest.get_perlin(8110, 3, 0.2, 300):get2d(pos2d)
	local n8 = minetest.get_perlin(2698, 3, 0.2, 400):get2d(pos2d)
	local value1 = math.abs(n1 - n2) * math.abs(n7)
	local value2 = math.sqrt(value1 * math.abs(n3 - n4)) * math.abs(n7)
	local value3 = math.sqrt(value2 * math.abs(n5 - n6)) * math.abs(n7)
	value1 = value1 + value1 * n8
	value2 = value2 + value2 * n8
	value3 = value3 + value3 * n8
	local value = value1 * 20 + value2 * 15 + value3 * 10 + n8 * 50
	if value < 0 then
		value = -2 * math.sqrt(-value)
	end
	return math.floor(value + 0.5)
end

-- Set mapgen parameters

minetest.register_on_mapgen_init(function(mgparams)
	minetest.set_mapgen_params({mgname="singlenode", flags = "nolight", flagmask = "nolight"})
end)

------------------------ Base map generation ------------------------

minetest.register_on_generated(function(minp, maxp)
	
	local t0 = os.clock()
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z
	
	print ("[forest] Generating map from "..minetest.pos_to_string(minp).." to "..minetest.pos_to_string(maxp))
	
	local c_dstone = minetest.get_content_id("default:desert_stone")
	local c_dsand = minetest.get_content_id("default:desert_sand")
	local c_water = minetest.get_content_id("default:water_source")
	local c_stone = minetest.get_content_id("default:stone")
	local c_sand = minetest.get_content_id("default:sand")
	local c_grass = minetest.get_content_id("default:dirt_with_grass")
	local c_snow = minetest.get_content_id("default:dirt_with_snow")
	local c_dirt = minetest.get_content_id("default:dirt")
	local c_gravel = minetest.get_content_id("default:gravel")
	local c_grasses = {
		minetest.get_content_id("default:grass_1"),
		minetest.get_content_id("default:grass_2"),
		minetest.get_content_id("default:grass_3"),
		minetest.get_content_id("default:grass_4"),
		minetest.get_content_id("default:grass_5")
	}
	local c_jungle = minetest.get_content_id("default:junglegrass")
	local c_flowers = {minetest.get_content_id("flowers:dandelion_yellow"), minetest.get_content_id("flowers:dandelion_yellow"), minetest.get_content_id("flowers:dandelion_yellow"), minetest.get_content_id("flowers:geranium"), minetest.get_content_id("flowers:tulip"), minetest.get_content_id("flowers:rose")}
	local c_papyrus = minetest.get_content_id("default:papyrus")
	local c_shrub = minetest.get_content_id("default:dry_shrub")
	local c_lava = minetest.get_content_id("default:lava_source")
	local c_cactus = minetest.get_content_id("default:cactus")
	local c_ignore = minetest.get_content_id("ignore")
	local c_air = minetest.get_content_id("air")
	-- LVM stuff
	local manip, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
	local data = manip:get_data()
	
	local elevation
	local node
	local pos
	local ground1, ground2, ground3, ground4, plant
	
	-- perlinmap stuff
	local sidelen = x1 - x0 + 1
	local chulens = {x=sidelen, y=sidelen, z=sidelen}
	local minposxyz = {x=x0, y=y0, z=z0}
	local minposxz = {x=x0, y=z0}
	-- 3D noises
	local nvals_n1 = minetest.get_perlin_map(np_n1, chulens):get3dMap_flat(minposxyz)
	local nvals_n2 = minetest.get_perlin_map(np_n2, chulens):get3dMap_flat(minposxyz)
	local nvals_n3 = minetest.get_perlin_map(np_n3, chulens):get3dMap_flat(minposxyz)
	local nvals_n4 = minetest.get_perlin_map(np_n4, chulens):get3dMap_flat(minposxyz)
	-- 2D noises
	local nvals_n5 = minetest.get_perlin_map(np_n5, chulens):get2dMap_flat(minposxz)
	local nvals_n6 = minetest.get_perlin_map(np_n6, chulens):get2dMap_flat(minposxz)
	local nvals_n7 = minetest.get_perlin_map(np_n7, chulens):get2dMap_flat(minposxz)
	local nvals_n8 = minetest.get_perlin_map(np_n8, chulens):get2dMap_flat(minposxz)
	local nvals_n9 = minetest.get_perlin_map(np_n9, chulens):get2dMap_flat(minposxz)
	-- elevation 2D noises
	local nvals_n1e = minetest.get_perlin_map(np_n1e, chulens):get2dMap_flat(minposxz)
	local nvals_n2e = minetest.get_perlin_map(np_n2e, chulens):get2dMap_flat(minposxz)
	local nvals_n3e = minetest.get_perlin_map(np_n3e, chulens):get2dMap_flat(minposxz)
	local nvals_n4e = minetest.get_perlin_map(np_n4e, chulens):get2dMap_flat(minposxz)
	local nvals_n5e = minetest.get_perlin_map(np_n5e, chulens):get2dMap_flat(minposxz)
	local nvals_n6e = minetest.get_perlin_map(np_n6e, chulens):get2dMap_flat(minposxz)
	local nvals_n7e = minetest.get_perlin_map(np_n7e, chulens):get2dMap_flat(minposxz)
	local nvals_n8e = minetest.get_perlin_map(np_n8e, chulens):get2dMap_flat(minposxz)
	
	local nixz = 1 -- 2D noise index
	for z = minp.z, maxp.z do
	for x = minp.x, maxp.x do
		local n1 = nvals_n1e[nixz]
		local n2 = nvals_n2e[nixz]
		local n3 = nvals_n3e[nixz]
		local n4 = nvals_n4e[nixz]
		local n5 = nvals_n5e[nixz]
		local n6 = nvals_n6e[nixz]
		local n7 = nvals_n7e[nixz]
		local n8 = nvals_n8e[nixz]
		local value1 = math.abs(n1 - n2) * math.abs(n7)
		local value2 = math.sqrt(value1 * math.abs(n3 - n4)) * math.abs(n7)
		local value3 = math.sqrt(value2 * math.abs(n5 - n6)) * math.abs(n7)
		value1 = value1 + value1 * n8
		value2 = value2 + value2 * n8
		value3 = value3 + value3 * n8
		local value = value1 * 20 + value2 * 15 + value3 * 10 + n8 * 50
		if value < 0 then
			value = -2 * math.sqrt(-value)
		end
		elevation = math.floor(value + 0.5)
		
		if math.max(elevation, 1) >= minp.y then
			n5v = nvals_n5[nixz]
			n6v = nvals_n6[nixz]
			n7v = nvals_n7[nixz]
			n8v = nvals_n8[nixz]
			n9v = nvals_n9[nixz]
			if elevation < n8v * 5 then
				if n7v < 0.88 then
					if n5v - n6v > 0.8 then
						ground1 = c_gravel
						ground2 = c_gravel
						ground3 = c_stone
						ground4 = c_stone
						plant = nil
					elseif n6v < 0 then
						if n5v < -0.4 then
							ground1 = c_dsand
							ground2 = c_dsand
							ground3 = c_dstone
							ground4 = c_stone
							plant = nil
						else
							ground1 = c_sand
							ground2 = c_sand
							ground3 = c_stone
							ground4 = c_stone
							plant = nil
						end
					elseif n5v + n6v * 5 > 2 then
						if n6v > 0.8 then
							ground1 = c_gravel
							ground2 = c_gravel
							ground3 = c_stone
							ground4 = c_stone
							plant = nil
						else
							ground1 = c_grass
							ground2 = c_dirt
							ground3 = c_stone
							ground4 = c_stone
							plant = {def = c_papyrus, percent = 4, height = math.random(2, 5)}
						end
					else
						ground1 = c_sand
						ground2 = c_sand
						ground3 = c_stone
						ground4 = c_stone
						plant = {def = c_grasses[math.random(5)], percent = 15}
					end
				elseif n5v * 2 - n6v < 0 then
					ground1 = c_gravel
					ground2 = c_gravel
					ground3 = c_stone
					ground4 = c_stone
					plant = nil
				else
					ground1 = c_stone
					ground2 = c_stone
					ground3 = c_stone
					ground4 = c_stone
					plant = nil
				end
			elseif n7v < 0.88 then
				if n5v + 2 * n6v > -0.4 then
					if n5v > 0 then
						ground1 = c_grass
						ground2 = c_dirt
						ground3 = c_stone
						ground4 = c_stone
						plant = nil
					else
						ground1 = c_grass
						ground2 = c_dirt
						ground3 = c_stone
						ground4 = c_stone
						if math.random(2) == 2 then
							plant = {def = c_grasses[math.random(5)], percent = 20}
						else
							plant = {def = c_flowers[math.random(6)], percent = -n5v}
						end
					end
				elseif n6v < -0.4 then
					ground1 = c_dsand
					ground2 = c_dsand
					ground3 = c_dstone
					ground4 = c_stone
					if math.random(2) == 2 then
						plant = {def = c_cactus, percent = 2, height = math.random(2, 6)}
					else
						plant = {def = c_shrub, percent = 5}
					end
				else
					ground1 = c_sand
					ground2 = c_sand
					ground3 = c_dstone
					ground4 = c_stone
					if math.random(2) == 2 then
						plant = {def = c_cactus, percent = 0.25, height = math.random(2, 4)}
					else
						plant = {def = c_jungle, percent = 25}
					end
				end
			elseif n5v ^ 2 + n6v ^ 2 < 0.16 and n7v > 0.9 then
				ground1 = c_air
				ground2 = c_lava
				ground3 = c_stone
				ground4 = c_stone
				plant = nil
				elevation = math.min(
					elevation, get_elevation({x = x, z = z + 1}),
					get_elevation({x = x, z = z - 1}),
					get_elevation({x = x + 1, z = z}),
					get_elevation({x = x - 1, z = z})
				)
			elseif n5v > -0.6 then
				ground1 = c_stone
				ground2 = c_stone
				ground3 = c_stone
				ground4 = c_stone
				plant = nil
			else
				ground1 = c_gravel
				ground2 = c_gravel
				ground3 = c_stone
				ground4 = c_stone
				plant = nil
			end
			
			for y = minp.y, math.min(math.max(elevation, 1), maxp.y) do
				pos = area:index(x, y, z) -- LVM index for node
				local nixyz = (z - z0) * 6400 + (y - y0) * 80 + (x - x0) + 1 -- noise index for node
				n1v = nvals_n1[nixyz]
				n2v = nvals_n2[nixyz]
				n3v = nvals_n3[nixyz]
				n4v = nvals_n4[nixyz]
				if y == elevation then
					if elevation >= 1 then
						node = ground1
					else
						node = ground2
					end
				elseif y > elevation then
					node = c_water
				elseif y + math.random(2, 6) >= elevation then
					node = ground2
				elseif y + 20 + n9v * 10 >= elevation then
					node = ground3
				else
					node = ground4
				end
				if math.max(n1v, n2v, n3v) - math.min(n1v, n2v, n3v) > n4v / 5 or node == c_water then
					data[pos] = node
				end
			end
			
			if elevation > 0 and plant then
				if math.random() * 100 < plant.percent then
					if plant.height then
						for i = 1, plant.height do
							if area:contains(x, elevation + i, z) then
								data[area:index(x, elevation + i, z)] = plant.def
							end
						end
					elseif area:contains(x, elevation + 1, z) then
						data[area:index(x, elevation + 1, z)] = plant.def
					end
				end
			end
		end
		nixz = nixz + 1 -- increment 2D noise index
	end
	end
	manip:set_data(data)
	manip:update_liquids()
	manip:calc_lighting()
	manip:write_to_map(data)

------------------------ Ore generation ------------------------

	local t1 = os.clock()
	local pr = PseudoRandom(math.random(1000))
	for num, def in pairs(ores) do
		local noise = minetest.get_perlin(def.seed, 1, 0, def.scale)
		if def.gradiant then
			for i = 1, def.frequency do
				local middle = {x = pr:next(minp.x, maxp.x), y = pr:next(minp.y, maxp.y), z = pr:next(minp.z, maxp.z)}
				if noise:get3d(middle) + math.random() * 2 >= 1 and middle.y < def.max_y and middle.y > def.min_y then
					local zone = minetest.find_nodes_in_area(
						{x = middle.x - def.radius, y = middle.y - def.radius, z = middle.z - def.radius},
						{x = middle.x + def.radius, y = middle.y + def.radius, z = middle.z + def.radius},
						{def.wherein}
					)
					for node, pos in pairs(zone) do
						if distance(middle, pos) / (def.radius + 1) - math.random() <= 0 and math.random(100) <= def.density then
							minetest.set_node(pos, {name = def.ore})
						end
					end
				end
				if def.center then
					minetest.set_node(middle, {name = def.center})
				end
			end
		else
			for i = 1, def.frequency do
				local middle = {x = pr:next(minp.x, maxp.x), y = pr:next(minp.y, maxp.y), z = pr:next(minp.z, maxp.z)}
				if noise:get3d(middle) + math.random() * 2 >= 1 and middle.y < def.max_y and middle.y > def.min_y then
					local zone = minetest.find_nodes_in_area(
						{x = middle.x - def.radius, y = middle.y - def.radius, z = middle.z - def.radius},
						{x = middle.x + def.radius, y = middle.y + def.radius, z = middle.z + def.radius},
						{def.wherein}
					)
					for node, pos in pairs(zone) do
						if distance(middle, pos) <= def.radius and math.random(100) >= def.density then
							minetest.set_node(pos, {name = def.ore})
						end
					end
				end
			end
		end
		
	end

------------------------ Tree generation ------------------------

	local t2 = os.clock()
	local biomes = minetest.get_perlin(289, 3, 0.6, 200)
	local grass_area = minetest.find_nodes_in_area(minp, maxp, "default:dirt_with_grass")
	for grass, pos in pairs(grass_area) do
		if math.random(12) == math.random(12) then
			local total = 0
			local temperature = get_average_temperature(pos)
			local biome = biomes:get3d(pos) * 50 + 50
			local candidates = {}
			local water = true
			local list = ""
			for specie, def in pairs(apportionment) do
				local difference = (def.biome - biome) ^ 2
				if def.water_proximity then
					if minetest.find_node_near(pos, math.abs(def.water_proximity), {"group:water"}) == nil then
						water = def.water_proximity <= 0
					else
						water = def.water_proximity >= 0
					end
				else
					water = true
				end
				if temperature <= def.temperature.max and temperature >= def.temperature.min and water then
					if difference < def.tolerance ^ 2 then
						local chance = def.frequency * (1 - difference / def.tolerance ^ 2)
						total = total + chance
						candidates[specie] = total
					end
				end
			end
			local num = math.random() * total
			local min = total
			local tree = nil
			for specie, num_chance in pairs(candidates) do
				if num <= num_chance and num_chance <= min then
					tree = specie
					min = num_chance
				end
			end
			local def = apportionment[tree]
			pos = {x = pos.x, y = pos.y + 1, z = pos.z}
			if def then
				if math.random(20) <= def.density then
					trees[tree].method(pos, tree)
				end
			end
		end
	end
	local t3 = os.clock()
	local chugent1 = math.ceil((t1 - t0) * 1000) / 1000
	local chugent2 = math.ceil((t2 - t1) * 1000) / 1000
	local chugent3 = math.ceil((t3 - t2) * 1000) / 1000
	print ("[forest] Base map "..chugent1.." sec, Ores "..chugent2.." sec, Trees "..chugent3.." sec. Total "..chugent1 + chugent2 + chugent3.." sec.")
end)

function spawn_player(player)
	local pr = PseudoRandom(math.random(1000000))
	local pos = {x = pr:next(-250, 250), z = pr:next(-250, 250)}
	local elevation = get_elevation(pos)
	local dir
	local noise = minetest.get_perlin(5096, 3, 0.6, 600)
	while elevation < 2 and noise:get2d({x = pos.x, y = pos.z}) <= 0.85 do
		dir = pr:next(1, 4)
		if dir == 1 then
			pos = {x = pos.x + 1, z = pos.z}
		elseif dir == 2 then
			pos = {x = pos.x - 1, z = pos.z}
		elseif dir == 3 then
			pos = {x = pos.x, z = pos.z + 1}
		elseif dir == 4 then
			pos = {x = pos.x, z = pos.z - 1}
		end
		elevation = get_elevation(pos)
	end
	pos = {x = pos.x, y = elevation + 2, z = pos.z}
	player:setpos(pos)
end

minetest.register_on_newplayer(function(player)
	spawn_player(player)
end)

minetest.register_on_respawnplayer(function(player)
	spawn_player(player)
	return true
end)
