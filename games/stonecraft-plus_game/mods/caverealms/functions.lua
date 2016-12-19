--CaveRealms functions.lua

--FUNCTIONS--

local H_LAG = caverealms.config.h_lag --15 --max height for stalagmites
local H_LAC = caverealms.config.h_lac --20 --...stalactites
local H_CRY = caverealms.config.h_cry --9 --max height of glow crystals
local H_CLAC = caverealms.config.h_clac --13 --max height of glow crystal stalactites

function caverealms:above_solid(x,y,z,area,data)
	local c_air = minetest.get_content_id("air")
	
	local c_vac
	if (minetest.get_modpath("moontest")) then
		c_vac = minetest.get_content_id("moontest:vacuum")
	else
		c_vac = minetest.get_content_id("air")
	end
	
	local ai = area:index(x,y+1,z-3)
	if data[ai] == c_air or data[ai] == c_vac then
		return false
	else
		return true
	end
end
function caverealms:below_solid(x,y,z,area,data)
	local c_air = minetest.get_content_id("air")
	
	local c_vac
	if (minetest.get_modpath("moontest")) then
		c_vac = minetest.get_content_id("moontest:vacuum")
	else
		c_vac = minetest.get_content_id("air")
	end
	
	local ai = area:index(x,y-1,z-3)
	if data[ai] == c_air or data[ai] == c_vac then
		return false
	else
		return true
	end
end

--stalagmite spawner
function caverealms:stalagmite(x,y,z, area, data)

	if not caverealms:below_solid(x,y,z,area,data) then
		return
	end
	
	--contest ids
	local c_stone = minetest.get_content_id("default:stone")

	local top = math.random(6,H_LAG) --grab a random height for the stalagmite
	for j = 0, top do --y
		for k = -3, 3 do
			for l = -3, 3 do
				if j == 0 then
					if k*k + l*l <= 9 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = c_stone
					end
				elseif j <= top/5 then
					if k*k + l*l <= 4 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = c_stone
					end
				elseif j <= top/5 * 3 then
					if k*k + l*l <= 1 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = c_stone
					end
				else
					local vi = area:index(x, y+j, z-3)
					data[vi] = c_stone
				end
			end
		end
	end
end

--stalactite spawner
function caverealms:stalactite(x,y,z, area, data)

	if not caverealms:above_solid(x,y,z,area,data) then
		return
	end

	--contest ids
	local c_stone = minetest.get_content_id("default:stone")--("caverealms:limestone")

	local bot = math.random(-H_LAC, -6) --grab a random height for the stalagmite
	for j = bot, 0 do --y
		for k = -3, 3 do
			for l = -3, 3 do
				if j >= -1 then
					if k*k + l*l <= 9 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = c_stone
					end
				elseif j >= bot/5 then
					if k*k + l*l <= 4 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = c_stone
					end
				elseif j >= bot/5 * 3 then
					if k*k + l*l <= 1 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = c_stone
					end
				else
					local vi = area:index(x, y+j, z-3)
					data[vi] = c_stone
				end
			end
		end
	end
end

--glowing crystal stalagmite spawner
function caverealms:crystal_stalagmite(x,y,z, area, data, biome)

	if not caverealms:below_solid(x,y,z,area,data) then
		return
	end
	
	--contest ids
	local c_stone = minetest.get_content_id("default:stone")
	local c_crystal = minetest.get_content_id("caverealms:glow_crystal")
	local c_crystore = minetest.get_content_id("caverealms:glow_ore")
	local c_emerald = minetest.get_content_id("caverealms:glow_emerald")
	local c_emore = minetest.get_content_id("caverealms:glow_emerald_ore")
	local c_mesecry = minetest.get_content_id("caverealms:glow_mese")
	local c_meseore = minetest.get_content_id("default:stone_with_mese")
	local c_ruby = minetest.get_content_id("caverealms:glow_ruby")
	local c_rubore = minetest.get_content_id("caverealms:glow_ruby_ore")
	local c_ameth = minetest.get_content_id("caverealms:glow_amethyst")
	local c_amethore = minetest.get_content_id("caverealms:glow_amethyst_ore")
	local c_ice = minetest.get_content_id("default:ice")
	local c_thinice = minetest.get_content_id("caverealms:thin_ice")

	--for randomness
	local mode = 1
	if math.random(15) == 1 then
		mode = 2
	end
	if biome == 3 then
		if math.random(25) == 1 then
			mode = 2
		else
			mode = 1
		end
	end
	if biome == 4 or biome == 5 then
		if math.random(3) == 1 then
			mode = 2
		end
	end

	local stalids = {
 		{ {c_crystore, c_crystal}, {c_emore, c_emerald} },
 		{ {c_emore, c_emerald}, {c_crystore, c_crystal} },
 		{ {c_emore, c_emerald}, {c_meseore, c_mesecry} },
 		{ {c_ice, c_thinice}, {c_crystore, c_crystal}},
		{ {c_ice, c_thinice}, {c_crystore, c_crystal}},
		{ {c_rubore, c_ruby}, {c_meseore, c_mesecry}},
		{ {c_crystore, c_crystal}, {c_rubore, c_ruby} },
		{ {c_rubore, c_ruby}, {c_emore, c_emerald}},
		{ {c_amethore, c_ameth}, {c_meseore, c_mesecry} },
 	}

 	local nid_a
 	local nid_b
	local nid_s = c_stone --stone base, will be rewritten to ice in certain biomes

 	if biome > 3 and biome < 6 then
 		if mode == 1 then
 			nid_a = c_ice
			nid_b = c_thinice
			nid_s = c_ice
 		else
 			nid_a = c_crystore
			nid_b = c_crystal
 		end
 	elseif mode == 1 then
 		nid_a = stalids[biome][1][1]
 		nid_b = stalids[biome][1][2]
 	else
 		nid_a = stalids[biome][2][1]
 		nid_b = stalids[biome][2][2]
 	end

	local top = math.random(5,H_CRY) --grab a random height for the stalagmite
	for j = 0, top do --y
		for k = -3, 3 do
			for l = -3, 3 do
				if j == 0 then
					if k*k + l*l <= 9 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = nid_s
					end
				elseif j <= top/5 then
					if k*k + l*l <= 4 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = nid_a
					end
				elseif j <= top/5 * 3 then
					if k*k + l*l <= 1 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = nid_b
					end
				else
					local vi = area:index(x, y+j, z-3)
					data[vi] = nid_b
				end
			end
		end
	end
end

--crystal stalactite spawner
function caverealms:crystal_stalactite(x,y,z, area, data, biome)

	if not caverealms:above_solid(x,y,z,area,data) then
		return
	end

	--contest ids
	local c_stone = minetest.get_content_id("default:stone")
	local c_crystore = minetest.get_content_id("caverealms:glow_ore")
	local c_crystal = minetest.get_content_id("caverealms:glow_crystal")
	local c_emerald = minetest.get_content_id("caverealms:glow_emerald")
	local c_emore = minetest.get_content_id("caverealms:glow_emerald_ore")
	local c_mesecry = minetest.get_content_id("caverealms:glow_mese")
	local c_meseore = minetest.get_content_id("default:stone_with_mese")
	local c_ruby = minetest.get_content_id("caverealms:glow_ruby")
	local c_rubore = minetest.get_content_id("caverealms:glow_ruby_ore")
	local c_ameth = minetest.get_content_id("caverealms:glow_amethyst")
	local c_amethore = minetest.get_content_id("caverealms:glow_amethyst_ore")
	local c_ice = minetest.get_content_id("default:ice")
	local c_thinice = minetest.get_content_id("caverealms:hanging_thin_ice")

	--for randomness
	local mode = 1
	if math.random(15) == 1 then
		mode = 2
	end
	if biome == 3 then
		if math.random(25) == 1 then
			mode = 2
		else
			mode = 1
		end
	end
	if biome == 4 or biome == 5 then
		if math.random(3) == 1 then
			mode = 2
		end
	end

	local stalids = {
 		{ {c_crystore, c_crystal}, {c_emore, c_emerald} },
 		{ {c_emore, c_emerald}, {c_crystore, c_crystal} },
 		{ {c_emore, c_emerald}, {c_meseore, c_mesecry} },
 		{ {c_ice, c_thinice}, {c_crystore, c_crystal}},
		{ {c_ice, c_thinice}, {c_crystore, c_crystal}},
		{ {c_rubore, c_ruby}, {c_meseore, c_mesecry}},
		{ {c_crystore, c_crystal}, {c_rubore, c_ruby} },
		{ {c_rubore, c_ruby}, {c_emore, c_emerald}},
		{ {c_amethore, c_ameth}, {c_meseore, c_mesecry} },
 	}

 	local nid_a
 	local nid_b
	local nid_s = c_stone --stone base, will be rewritten to ice in certain biomes

 	if biome > 3 and biome < 6 then
 		if mode == 1 then
 			nid_a = c_ice
			nid_b = c_thinice
			nid_s = c_ice
 		else
 			nid_a = c_crystore
			nid_b = c_crystal
 		end
 	elseif mode == 1 then
 		nid_a = stalids[biome][1][1]
 		nid_b = stalids[biome][1][2]
 	else
 		nid_a = stalids[biome][2][1]
 		nid_b = stalids[biome][2][2]
 	end

	local bot = math.random(-H_CLAC, -6) --grab a random height for the stalagmite
	for j = bot, 0 do --y
		for k = -3, 3 do
			for l = -3, 3 do
				if j >= -1 then
					if k*k + l*l <= 9 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = nid_s
					end
				elseif j >= bot/5 then
					if k*k + l*l <= 4 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = nid_a
					end
				elseif j >= bot/5 * 3 then
					if k*k + l*l <= 1 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = nid_b
					end
				else
					local vi = area:index(x, y+j, z-3)
					data[vi] = nid_b
				end
			end
		end
	end
end

--glowing crystal stalagmite spawner
function caverealms:salt_stalagmite(x,y,z, area, data, biome)

	if not caverealms:below_solid(x,y,z,area,data) then
		return
	end
	
	--contest ids
	local c_stone = minetest.get_content_id("default:stone")
	local c_salt = minetest.get_content_id("caverealms:salt_crystal")
	
	local scale = math.random(2, 4)
	if scale == 2 then
		for j = -3, 3 do
			for k = -3, 3 do
				local vi = area:index(x+j, y, z+k)
				data[vi] = c_stone
				if math.abs(j) ~= 3 and math.abs(k) ~= 3 then
					local vi = area:index(x+j, y+1, z+k)
					data[vi] = c_stone
				end
			end
		end
	else
		for j = -4, 4 do
			for k = -4, 4 do
				local vi = area:index(x+j, y, z+k)
				data[vi] = c_stone
				if math.abs(j) ~= 4 and math.abs(k) ~= 4 then
					local vi = area:index(x+j, y+1, z+k)
					data[vi] = c_stone
				end
			end
		end
	end
	for j = 2, scale + 2 do --y
		for k = -2, scale - 2 do
			for l = -2, scale - 2 do
				local vi = area:index(x+k, y+j, z+l)
				data[vi] = c_salt -- make cube
			end
		end
	end
end

--function to create giant 'shrooms
function caverealms:giant_shroom(x, y, z, area, data)

	if not caverealms:below_solid(x,y,z,area,data) then
		return
	end

	--as usual, grab the content ID's
	local c_stem = minetest.get_content_id("caverealms:mushroom_stem")
	local c_cap = minetest.get_content_id("caverealms:mushroom_cap")
	local c_gills = minetest.get_content_id("caverealms:mushroom_gills")

	z = z - 5
	--cap
	for k = -5, 5 do
	for l = -5, 5 do
		if k*k + l*l <= 25 then
			local vi = area:index(x+k, y+5, z+l)
			data[vi] = c_cap
		end
		if k*k + l*l <= 16 then
			local vi = area:index(x+k, y+6, z+l)
			data[vi] = c_cap
			vi = area:index(x+k, y+5, z+l)
			data[vi] = c_gills
		end
		if k*k + l*l <= 9 then
			local vi = area:index(x+k, y+7, z+l)
			data[vi] = c_cap
		end
		if k*k + l*l <= 4 then
			local vi = area:index(x+k, y+8, z+l)
			data[vi] = c_cap
		end
	end
	end
	--stem
	for j = 0, 5 do
		for k = -1,1 do
			local vi = area:index(x+k, y+j, z)
			data[vi] = c_stem
			if k == 0 then
				local ai = area:index(x, y+j, z+1)
				data[ai] = c_stem
				ai = area:index(x, y+j, z-1)
				data[ai] = c_stem
			end
		end
	end
end

function caverealms:legacy_giant_shroom(x, y, z, area, data) --leftovers :P
	--as usual, grab the content ID's
	local c_stem = minetest.get_content_id("caverealms:mushroom_stem")
	local c_cap = minetest.get_content_id("caverealms:mushroom_cap")
	
	z = z - 4
	--cap
	for k = -4, 4 do
	for l = -4, 4 do
		if k*k + l*l <= 16 then
			local vi = area:index(x+k, y+5, z+l)
			data[vi] = c_cap
		end
		if k*k + l*l <= 9 then
			local vi = area:index(x+k, y+4, z+l)
			data[vi] = c_cap
			vi = area:index(x+k, y+6, z+l)
			data[vi] = c_cap
		end
		if k*k + l*l <= 4 then
			local vi = area:index(x+k, y+7, z+l)
			data[vi] = c_cap
		end
	end
	end
	--stem
	for j = 0, 4 do
		for k = -1,1 do
			local vi = area:index(x+k, y+j, z)
			data[vi] = c_stem
			if k == 0 then
				local ai = area:index(x, y+j, z+1)
				data[ai] = c_stem
				ai = area:index(x, y+j, z-1)
				data[ai] = c_stem
			end
		end
	end
end

-- Experimental and very geometric function to create giant octagonal crystals in a variety of random directions
-- Uses calculations for points on a sphere, lines in geometric space
-- CURRENTLY USELESS, NOT LIKELY TO BE IMPLEMENTED SOON
function caverealms:octagon(x, y, z, area, data)
	--Grab content id's... diamond is a placeholder
	local c_crys = minetest.get_content_id("default:diamondblock")
	
	local MAX_LEN = 25 --placeholder for a config file constant
	local MIN_LEN = 10 --ditto
	
	local target = {x=0, y=MAX_LEN, z=0} -- 3D space coordinate of the crystal's endpoint
	
	local length = math.random(MIN_LEN, MAX_LEN) --get a random length for the crystal
	local dir1 = math.random(0, 359) -- Random direction in degrees around a circle
	local dir2 = math.random(0, 180) -- Random direction in a semicircle, for 3D location
	
	--OK, so now make a 3D point out of those spherical coordinates...
	target.x = math.ceil(length * math.cos(dir1 * 3.14/180)) --Round it up to make sure it's a nice integer for the coordinate system
	target.z = math.ceil(length * math.sin(dir1 * 3.14/180))
	--Y is also simple, just use dir2.  Note that, due to how these calculations are carried out, this is not a coordinate on a perfect sphere. This is OK for our purposes.
	target.y = math.ceil(length * math.sin(dir2 * 3.14/180))
	
	-- Now, determine if the crystal should go up or down, based on where it is
	if (caverealms:above_solid(x,y,z,area,data)) then
		target.y = target.y * -1
	end
	
	--Bring the coordinates near the area you're generating
	target.x = target.x + x
	target.y = target.y + y
	target.z = target.z + z
	
	
end

local CAVESPAWN = caverealms.config.cavespawn --false by default.  Change to true in order to spawn in the caves when joining as a new player or respawning after death
local spawned = false;
local ydepth = -960;

if (CAVESPAWN) then
	minetest.register_on_newplayer(function(player)
		while spawned ~= true do
			player:setpos({x=0,y=ydepth,z=0})
			--minetest.after(2, function(player, ydepth)
				spawnplayer(player, ydepth)
			--end, player, ydepth)
			ydepth = ydepth - 80
		end
	end)

	minetest.register_on_respawnplayer(function(player)
		while spawned ~= true do
			player:setpos({x=0,y=ydepth,z=0})
			--minetest.after(2, function(player, ydepth)
				spawnplayer(player, ydepth)
			--end, player, ydepth)
			ydepth = ydepth - 80
		end
		return true
	end)
end

-- Spawn player underground
function spawnplayer(player, ydepth)
	
	local xsp
	local ysp
	local zsp
	-- 3D noise for caves

	local np_cave = {
		offset = 0,
		scale = 1,
		spread = {x=512, y=256, z=512}, -- squashed 2:1
		seed = 59033,
		octaves = 6,
		persist = 0.63
	}

	-- 3D noise for wave

	local np_wave = {
		offset = 0,
		scale = 1,
		spread = {x=256, y=256, z=256},
		seed = -400000000089,
		octaves = 3,
		persist = 0.67
	}
	
	local YMIN = caverealms.config.ymin -- Approximate realm limits.
	local YMAX = caverealms.config.ymax
	local TCAVE = caverealms.config.tcave --0.5 -- Cave threshold. 1 = small rare caves, 0.5 = 1/3rd ground volume, 0 = 1/2 ground volume
	local BLEND = 128 -- Cave blend distance near YMIN, YMAX
	
	local yblmin = YMIN + BLEND * 1.5
	local yblmax = YMAX - BLEND * 1.5
	
	for chunk = 1, 64 do
		print ("[caverealms] searching for spawn "..chunk)
		local x0 = 80 * math.random(-32, 32) - 32
		local z0 = 80 * math.random(-32, 32) - 32
		local y0 = ydepth-32
		local x1 = x0 + 79
		local z1 = z0 + 79
		local y1 = ydepth+47

		local sidelen = 80
		local chulens = {x=sidelen, y=sidelen, z=sidelen}
		local minposxyz = {x=x0, y=y0, z=z0}
		local minposxz = {x=x0, y=z0}

		local nvals_cave = minetest.get_perlin_map(np_cave, chulens):get3dMap_flat(minposxyz) --cave noise for structure
		local nvals_wave = minetest.get_perlin_map(np_wave, chulens):get3dMap_flat(minposxyz) --wavy structure of cavern ceilings and floors

		local nixz = 1
		local nixyz = 1
		for z = z0, z1 do
			for y = y0, y1 do
				for x = x0, x1 do
					local n_abscave = math.abs(nvals_cave[nixyz])
					local n_abswave = math.abs(nvals_wave[nixyz])
					
					local tcave --declare variable
					--determine the overal cave threshold
					if y < yblmin then
						tcave = TCAVE + ((yblmin - y) / BLEND) ^ 2
					elseif y > yblmax then
						tcave = TCAVE + ((y - yblmax) / BLEND) ^ 2
					else
						tcave = TCAVE
					end
					
					--if y >= 1 and density > -0.01 and density < 0 then
					if (nvals_cave[nixyz] + nvals_wave[nixyz])/2 > tcave + 0.005 and (nvals_cave[nixyz] + nvals_wave[nixyz])/2 < tcave + 0.015 then --if node falls within cave threshold
						ysp = y + 1
						xsp = x
						zsp = z
						break
					end
					nixz = nixz + 1
					nixyz = nixyz + 1
				end
				if ysp then
					break
				end
				nixz = nixz - 80
			end
			if ysp then
				break
			end
			nixz = nixz + 80
		end
		if ysp then
			break
		end
	end
	print ("[caverealms] spawn player ("..xsp.." "..ysp.." "..zsp..")")
	player:setpos({x=xsp, y=ysp, z=zsp})
	spawned = true
end

--minetest.register_on_newplayer(function(player)
	--spawnplayer(player)
--end)

