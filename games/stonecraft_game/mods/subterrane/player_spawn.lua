local spawned = false

function subterrane:register_cave_spawn(cave_layer_def, start_depth)
	local ydepth = start_depth or cave_layer_def.minimum_depth;
	minetest.register_on_newplayer(function(player)
		while spawned ~= true do
			player:setpos({x=0,y=ydepth,z=0})
			spawnplayer(cave_layer_def, player, ydepth)
			ydepth = ydepth - 80
			if ydepth < cave_layer_def.maximum_depth then
				ydepth = cave_layer_def.minimum_depth
			end
		end
	end)

	minetest.register_on_respawnplayer(function(player)
		while spawned ~= true do
			player:setpos({x=0,y=ydepth,z=0})
			spawnplayer(cave_layer_def, player, ydepth)
			ydepth = ydepth - 80
			if ydepth < cave_layer_def.maximum_depth then
				ydepth = cave_layer_def.minimum_depth
			end
		end
		return true
	end)
end

-- Spawn player underground
function spawnplayer(cave_layer_def, player, ydepth)
	
	local YMIN = cave_layer_def.maximum_depth
	local YMAX = cave_layer_def.minimum_depth
	local BLEND = math.min(cave_layer_def.boundary_blend_range or 128, (YMIN-YMAX)/2)
	local TCAVE = cave_layer_def.cave_threshold or 0.5

	-- 3D noise for cave
	local np_cave = cave_layer_def.perlin_cave or subterrane.default_perlin_cave
	-- 3D noise for wave
	local np_wave = cave_layer_def.perlin_wave or subterrane.default_perlin_wave

	local yblmin = YMIN + BLEND * 1.5
	local yblmax = YMAX - BLEND * 1.5
	
	local xsp
	local ysp
	local zsp
	
	for chunk = 1, 64 do
		print ("[subterrane] searching for spawn "..chunk)
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
	print ("[subterrane] spawn player ("..xsp.." "..ysp.." "..zsp..")")
	player:setpos({x=xsp, y=ysp, z=zsp})
	spawned = true
end
