--grab a shorthand for the filepath of the mod
local modpath = minetest.get_modpath(minetest.get_current_modname())

if caverealms.config.falling_icicles == true then
	dofile(modpath.."/falling_ice.lua") --complicated function for falling icicles
	print("[caverealms] falling icicles enabled.")
end

local FORTRESSES = caverealms.config.fortresses --true | Should fortresses spawn?
local FOUNTAINS = caverealms.config.fountains --true | Should fountains spawn?

-- Parameters

local STAGCHA = caverealms.config.stagcha --0.002 --chance of stalagmites
local STALCHA = caverealms.config.stalcha --0.003 --chance of stalactites
local CRYSTAL = caverealms.config.crystal --0.007 --chance of glow crystal formations
local GEMCHA = caverealms.config.gemcha --0.03 --chance of small glow gems
local MUSHCHA = caverealms.config.mushcha --0.04 --chance of mushrooms
local MYCCHA = caverealms.config.myccha --0.03 --chance of mycena mushrooms
local WORMCHA = caverealms.config.wormcha --0.03 --chance of glow worms
local GIANTCHA = caverealms.config.giantcha --0.001 -- chance of giant mushrooms
local ICICHA = caverealms.config.icicha --0.035 -- chance of icicles
local FLACHA = caverealms.config.flacha --0.04 --chance of constant flames
local FOUNCHA = caverealms.config.founcha --0.001 --chance of statue + fountain
local FORTCHA = caverealms.config.fortcha --0.0003 --chance of DM Fortresses

local DM_TOP = caverealms.config.dm_top -- -4000 --level at which Dungeon Master Realms start to appear
local DM_BOT = caverealms.config.dm_bot -- -5000 --level at which "" ends
local DEEP_CAVE = caverealms.config.deep_cave -- -7000 --level at which deep cave biomes take over
local YMIN = caverealms.config.ymin
local YMAX = caverealms.config.ymax

local H_LAG = caverealms.config.h_lag --15 --max height for stalagmites
local H_LAC = caverealms.config.h_lac --20 --...stalactites
local H_CRY = caverealms.config.h_cry --9 --max height of glow crystals
local H_CLAC = caverealms.config.h_clac --13 --max height of glow crystal stalactites

minetest.register_alias("caverealms:constant_flame", "fire:permanent_flame")

local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_ice = minetest.get_content_id("default:ice")
local c_stone = minetest.get_content_id("default:stone")
local c_desand = minetest.get_content_id("default:desert_sand")
local c_flame = minetest.get_content_id("fire:permanent_flame")
local c_ice = minetest.get_content_id("default:ice")
local c_lava = minetest.get_content_id("default:lava_source")


local c_algae = minetest.get_content_id("caverealms:stone_with_algae")
local c_ameth = minetest.get_content_id("caverealms:glow_amethyst")
local c_amethore = minetest.get_content_id("caverealms:glow_amethyst_ore")
local c_coalblock = minetest.get_content_id("default:coalblock")
local c_coaldust = minetest.get_content_id("caverealms:coal_dust")
local c_crystal = minetest.get_content_id("caverealms:glow_crystal")
local c_crystore = minetest.get_content_id("caverealms:glow_ore")
local c_emerald = minetest.get_content_id("caverealms:glow_emerald")
local c_emore = minetest.get_content_id("caverealms:glow_emerald_ore")
local c_fortress = minetest.get_content_id("caverealms:s_fortress")
local c_fountain = minetest.get_content_id("caverealms:s_fountain")
local c_fungus = minetest.get_content_id("caverealms:fungus")
local c_gem1 = minetest.get_content_id("caverealms:glow_gem")
local c_gem2 = minetest.get_content_id("caverealms:glow_gem_2")
local c_gem3 = minetest.get_content_id("caverealms:glow_gem_3")
local c_gem4 = minetest.get_content_id("caverealms:glow_gem_4")
local c_gem5 = minetest.get_content_id("caverealms:glow_gem_5")
local c_gobsidian = minetest.get_content_id("caverealms:glow_obsidian")
local c_gobsidian2 = minetest.get_content_id("caverealms:glow_obsidian_2")
local c_hcobble = minetest.get_content_id("caverealms:hot_cobble")
local c_icid = minetest.get_content_id("caverealms:icicle_down")
local c_iciu = minetest.get_content_id("caverealms:icicle_up")
local c_lichen = minetest.get_content_id("caverealms:stone_with_lichen")
local c_mesecry = minetest.get_content_id("caverealms:glow_mese")
local c_meseore = minetest.get_content_id("default:stone_with_mese")
local c_moss = minetest.get_content_id("caverealms:stone_with_moss")
local c_mycena = minetest.get_content_id("caverealms:mycena")
local c_rubore = minetest.get_content_id("caverealms:glow_ruby_ore")
local c_ruby = minetest.get_content_id("caverealms:glow_ruby")
local c_salt = minetest.get_content_id("caverealms:stone_with_salt")
local c_saltcrystal = minetest.get_content_id("caverealms:salt_crystal")
local c_saltgem1 = minetest.get_content_id("caverealms:salt_gem")
local c_saltgem2 = minetest.get_content_id("caverealms:salt_gem_2")
local c_saltgem3 = minetest.get_content_id("caverealms:salt_gem_3")
local c_saltgem4 = minetest.get_content_id("caverealms:salt_gem_4")
local c_saltgem5 = minetest.get_content_id("caverealms:salt_gem_5")
local c_spike1 = minetest.get_content_id("caverealms:spike")
local c_spike2 = minetest.get_content_id("caverealms:spike_2")
local c_spike3 = minetest.get_content_id("caverealms:spike_3")
local c_spike4 = minetest.get_content_id("caverealms:spike_4")
local c_spike5 = minetest.get_content_id("caverealms:spike_5")
local c_thinice = minetest.get_content_id("caverealms:thin_ice")
local c_thinicehanging = minetest.get_content_id("caverealms:hanging_thin_ice")
local c_worm = minetest.get_content_id("caverealms:glow_worm")
local c_stem = minetest.get_content_id("caverealms:mushroom_stem")
local c_cap = minetest.get_content_id("caverealms:mushroom_cap")
local c_gills = minetest.get_content_id("caverealms:mushroom_gills")

local glow_worm_ceiling = function(area, data, ai, vi, bi)
	if math.random() < WORMCHA and data[vi] == c_air and data[bi] == c_air then
		data[vi] = c_worm
		data[bi] = c_worm
		if math.random(2) == 1 then
			local pos = area:position(vi)
			pos.y = pos.y-2
			local bbi = area:indexp(pos)
			if data[bbi] == c_air then
				data[bbi] = c_worm
				if math.random(2) ==1 then
					pos.y = pos.y-1
					local bbbi = area:indexp(pos)
					if data[bbbi] == c_air then
						data[bbbi] = c_worm
					end
				end
			end
		end
	end
end

local obsidian_plug = function(area, data, ai, vi, bi)
	local pos = area:position(ai)
	local x = pos.x
	local y = pos.y
	local z = pos.z	
	for i = x - 3, x + 3 do
		for j = y - 1, y + 1 do
			for k = z - 3, z + 3 do
				data[area:index(i,j,k)] = c_water
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------
-- Dungeon

local dungeon_floor = function(area, data, ai, vi, bi)
	if data[bi] == c_stone then data[bi] = c_hcobble end
	if math.random() < FLACHA then --neverending flames
		data[vi] = c_flame
	elseif math.random() < FOUNCHA and FOUNTAINS then --DM FOUNTAIN
		data[vi] = c_fountain
	elseif math.random() < FORTCHA and FORTRESSES then --DM FORTRESS
		data[vi] = c_fortress
	elseif subterrane:vertically_consistent_random(vi, area) < STAGCHA then
		subterrane:giant_stalagmite(vi, area, data, 6, H_LAG, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(15) == 1 then
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_meseore, c_mesecry)
		else
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_rubore, c_ruby)
		end
	end
end

local dungeon_ceiling = function(area, data, ai, vi, bi)
	glow_worm_ceiling(area, data, ai, vi, bi)
	if subterrane:vertically_consistent_random(vi, area) < STALCHA then
		subterrane:giant_stalactite(vi, area, data, 6, H_LAC, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(15) == 1 then
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_meseore, c_mesecry)
		else
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_rubore, c_ruby)
		end
	end
end

-----------------------------------------------------------------------------------------------------------
-- Moss

local moss_floor = function(area, data, ai, vi, bi)
	if data[bi] == c_stone then data[bi] = c_moss end
	if math.random() < GEMCHA then
		-- gems of random size
		local gems = { c_gem1, c_gem2, c_gem3, c_gem4, c_gem5 }
		local gidx = math.random(1, 12)
		if gidx > 5 then
			gidx = 1
		end
		data[vi] = gems[gidx]
	elseif subterrane:vertically_consistent_random(vi, area) < STAGCHA then
		subterrane:giant_stalagmite(vi, area, data, 6, H_LAG, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(15) == 1 then
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_emore, c_emerald)
		else
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_crystore, c_crystal)
		end
	end
end

local moss_ceiling = function(area, data, ai, vi, bi)
	if data[ai] == c_lava then obsidian_plug(area, data, ai, vi, bi) end
	glow_worm_ceiling(area, data, ai, vi, bi)
	if subterrane:vertically_consistent_random(vi, area) < STALCHA then
		subterrane:giant_stalactite(vi, area, data, 6, H_LAC, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(15) == 1 then
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_emore, c_emerald)
		else
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_crystore, c_crystal)
		end
	end	
end

-----------------------------------------------------------------------------------------------------------
-- Fungal

local fungal_floor = function(area, data, ai, vi, bi)
	if data[bi] == c_stone then data[bi] = c_lichen
		if math.random() < MUSHCHA then --mushrooms
			data[vi] = c_fungus
		elseif math.random() < MYCCHA then --mycena mushrooms
			data[vi] = c_mycena
		elseif math.random() < GIANTCHA then --giant mushrooms
			local cap_radius = math.random(2,5)
			local stem_height = math.random(3,7)
			subterrane:giant_shroom(vi, area, data, c_stem, c_cap, c_gills, stem_height, cap_radius)
		elseif subterrane:vertically_consistent_random(vi, area) < STAGCHA then
			subterrane:giant_stalagmite(vi, area, data, 6, H_LAG, c_stone, c_stone, c_stone)
		elseif math.random() < CRYSTAL then
			if math.random(15) == 1 then
				subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_crystore, c_crystal)
			else
				subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_emore, c_emerald)
			end
		end
	 end
end

local fungal_ceiling = function(area, data, ai, vi, bi)
	if data[ai] == c_lava then obsidian_plug(area, data, ai, vi, bi) end
	glow_worm_ceiling(area, data, ai, vi, bi)
	if subterrane:vertically_consistent_random(vi, area) < STALCHA then
		subterrane:giant_stalactite(vi, area, data, 6, H_LAC, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(15) == 1 then
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_crystore, c_crystal)
		else
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_emore, c_emerald)
		end
	end
end

-----------------------------------------------------------------------------------------------------------
-- Algae

local algae_floor = function(area, data, ai, vi, bi)
	if data[bi] == c_stone then data[bi] = c_algae end
	if subterrane:vertically_consistent_random(vi, area) < STAGCHA then
		subterrane:giant_stalagmite(vi, area, data, 6, H_LAG, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(25) == 1 then
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_meseore, c_mesecry)
		else
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_emore, c_emerald)
		end
	end
end

local algae_ceiling = function(area, data, ai, vi, bi)
	if data[ai] == c_lava then obsidian_plug(area, data, ai, vi, bi) end
	glow_worm_ceiling(area, data, ai, vi, bi)
	
	if subterrane:vertically_consistent_random(vi, area) < STALCHA then
		subterrane:giant_stalactite(vi, area, data, 6, H_LAC, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(25) == 1 then
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_meseore, c_mesecry)
		else
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_emore, c_emerald)
		end
	end

end

-----------------------------------------------------------------------------------------------------------
-- Glaciated

local glaciated_floor = function(area, data, ai, vi, bi)
	data[vi] = c_thinice
	data[bi] = c_thinice
	if math.random() < ICICHA then --if glaciated, place icicles
		data[ai] = c_iciu
	elseif subterrane:vertically_consistent_random(vi, area) < STAGCHA then
		subterrane:giant_stalagmite(vi, area, data, 6, H_LAG, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(3) == 1 then
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_crystore, c_crystal)
		else
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_ice, c_ice, c_thinice)
		end
	end
end

local glaciated_ceiling = function(area, data, ai, vi, bi)
	if data[ai] == c_lava then obsidian_plug(area, data, ai, vi, bi) end
	if math.random() < ICICHA then
		data[vi] = c_icid
	end
	glow_worm_ceiling(area, data, ai, vi, bi)
	if subterrane:vertically_consistent_random(vi, area) < STALCHA then
		subterrane:giant_stalactite(vi, area, data, 6, H_LAC, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(3) == 1 then
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_crystore, c_crystal)
		else
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_ice, c_ice, c_thinicehanging)
		end
	end
end

-----------------------------------------------------------------------------------------------------------
-- Deep Glaciated


local deep_glaciated_floor = function(area, data, ai, vi, bi)
	data[vi] = c_ice
	data[bi] = c_ice
	if math.random() < ICICHA then --if glaciated, place icicles
		data[ai] = c_iciu
	elseif subterrane:vertically_consistent_random(vi, area) < STAGCHA then
		subterrane:giant_stalagmite(vi, area, data, 6, H_LAG, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(3) == 1 then
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_crystore, c_crystal)
		else
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_ice, c_ice, c_thinice)
		end
	end
end

local deep_glaciated_ceiling = function(area, data, ai, vi, bi)
	if data[ai] == c_lava then obsidian_plug(area, data, ai, vi, bi) end
	if math.random() < ICICHA then
		data[vi] = c_icid
	end
	glow_worm_ceiling(area, data, ai, vi, bi)
	
	if subterrane:vertically_consistent_random(vi, area) < STALCHA then
		subterrane:giant_stalactite(vi, area, data, 6, H_LAC, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(3) == 1 then
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_crystore, c_crystal)
		else
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_ice, c_ice, c_thinicehanging)
		end
	end	
end

-----------------------------------------------------------------------------------------------------------
-- Salt


--glowing crystal stalagmite spawner
local salt_stalagmite = function(vi, area, data)
	local pos = area:position(vi)
	local x = pos.x
	local y = pos.y
	local z = pos.z

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
				data[vi] = c_saltcrystal -- make cube
			end
		end
	end
end

local salt_floor = function(area, data, ai, vi, bi)
	data[vi] = c_salt
	data[bi] = c_salt
	if math.random() < GEMCHA then
		-- gems of random size
		local gems = { c_saltgem1, c_saltgem2, c_saltgem3, c_saltgem4, c_saltgem5 }
		local gidx = math.random(1, 12)
		if gidx > 5 then
			gidx = 1
		end
		data[ai] = gems[gidx]
	elseif math.random() < STAGCHA then
		salt_stalagmite(vi, area, data)
	elseif subterrane:vertically_consistent_random(vi, area) < STAGCHA then
		subterrane:giant_stalagmite(vi, area, data, 6, H_LAG, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(15) == 1 then
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_rubore, c_ruby)
		else
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_crystore, c_crystal)
		end
	end
end

local salt_ceiling = function(area, data, ai, vi, bi)
	glow_worm_ceiling(area, data, ai, vi, bi, 7)
	
	if subterrane:vertically_consistent_random(vi, area) < STALCHA then
		subterrane:giant_stalactite(vi, area, data, 6, H_LAC, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(15) == 1 then
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_rubore, c_ruby)
		else
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_crystore, c_crystal)
		end
	end	
end

-----------------------------------------------------------------------------------------------------------
-- Glowing Obsidian

local obsidian_floor = function(area, data, ai, vi, bi)
	if math.random() < 0.5 then
		data[vi] = c_gobsidian
		data[bi] = c_gobsidian
	else
		data[vi] = c_gobsidian2
		data[bi] = c_gobsidian2
	end
	if math.random() < FLACHA then --neverending flames
		data[ai] = c_flame
	elseif subterrane:vertically_consistent_random(vi, area) < STAGCHA then
		subterrane:giant_stalagmite(vi, area, data, 6, H_LAG, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(15) == 1 then
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_emore, c_emerald)
		else
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_rubore, c_ruby)
		end
	end
end

local obsidian_ceiling = function(area, data, ai, vi, bi)
	glow_worm_ceiling(area, data, ai, vi, bi, 8)
	
	if subterrane:vertically_consistent_random(vi, area) < STALCHA then
		subterrane:giant_stalactite(vi, area, data, 6, H_LAC, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(15) == 1 then
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_emore, c_emerald)
		else
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_rubore, c_ruby)
		end
	end
end

-----------------------------------------------------------------------------------------------------------
-- Coal Dust

local coal_floor = function(area, data, ai, vi, bi)
	if math.random() < 0.05 then
		data[vi] = c_coalblock
		data[bi] = c_coalblock
	elseif math.random() < 0.15 then
		data[vi] = c_coaldust
		data[bi] = c_coaldust
	else
		data[vi] = c_desand
		data[bi] = c_desand
	end
	if math.random() < FLACHA * 0.75 then --neverending flames
		data[ai] = c_flame
	elseif math.random() < GEMCHA then
		-- spikes of random size
		local spikes = { c_spike1, c_spike2, c_spike3, c_spike4, c_spike5 }
		local sidx = math.random(1, 12)
		if sidx > 5 then
			sidx = 1
		end
		data[ai] = spikes[sidx]
	elseif subterrane:vertically_consistent_random(vi, area) < STAGCHA then
		subterrane:giant_stalagmite(vi, area, data, 6, H_LAG, c_stone, c_stone, c_stone)
	elseif math.random() < CRYSTAL then
		if math.random(15) == 1 then
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_meseore, c_mesecry)
		else
			subterrane:giant_stalagmite(vi, area, data, 5, H_CRY, c_stone, c_amethore, c_ameth)
		end
	end
end

local coal_ceiling = function(area, data, ai, vi, bi)
	if math.random() < WORMCHA then
		glow_worm_ceiling(area, data, ai, vi, bi)
	end
	if subterrane:vertically_consistent_random(vi, area) < STALCHA then
		subterrane:giant_stalactite(vi, area, data, 6, H_LAC, c_stone, c_stone, c_stone)
	end
	if math.random() < CRYSTAL then
		if math.random(15) == 1 then
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_meseore, c_mesecry)
		else
			subterrane:giant_stalactite(vi, area, data, 6, H_CLAC, c_stone, c_amethore, c_ameth)
		end
	end
end

-------------------------------------------------------------------------------------------

-- default mapgen registers an "underground" biome that gets in the way of everything.
subterrane:override_biome({
	name = "underground",
	y_min = YMAX,
	y_max = -113,
	heat_point = 50,
	humidity_point = 50,
})

minetest.register_biome({
	name = "caverealms_dungeon",
	y_min = DM_BOT,
	y_max = DM_TOP,
	heat_point = 50,
	humidity_point = 50,
	_subterrane_ceiling_decor = dungeon_ceiling,
	_subterrane_floor_decor = dungeon_floor,
	_subterrane_fill_node = c_air,
})

minetest.register_biome({
	name = "caverealms_moss",
	y_min = DEEP_CAVE,
	y_max = YMAX,
	heat_point = 80,
	humidity_point = 10,
	_subterrane_ceiling_decor = moss_ceiling,
	_subterrane_floor_decor = moss_floor,
	_subterrane_fill_node = c_air,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "caverealms_fungal",
	y_min = DEEP_CAVE,
	y_max = YMAX,
	heat_point = 60,
	humidity_point = 50,
	_subterrane_ceiling_decor = fungal_ceiling,
	_subterrane_floor_decor = fungal_floor,
	_subterrane_fill_node = c_air,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "caverealms_algae",
	y_min = DEEP_CAVE,
	y_max = YMAX,
	heat_point = 80,
	humidity_point = 90,
	_subterrane_ceiling_decor = algae_ceiling,
	_subterrane_floor_decor = algae_floor,
	_subterrane_fill_node = c_air,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "caverealms_glaciated",
	y_min = DEEP_CAVE,
	y_max = YMAX,
	heat_point = 0,
	humidity_point = 50,
	_subterrane_ceiling_decor = glaciated_ceiling,
	_subterrane_floor_decor = glaciated_floor,
	_subterrane_fill_node = c_air,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "caverealms_deep_glaciated",
	y_min = YMIN,
	y_max = DEEP_CAVE,
	heat_point = 0,
	humidity_point = 50,
	_subterrane_ceiling_decor = deep_glaciated_ceiling,
	_subterrane_floor_decor = deep_glaciated_floor,
	_subterrane_fill_node = c_air,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "caverealms_salt_crystal",
	y_min = YMIN,
	y_max = DEEP_CAVE,
	heat_point = 80,
	humidity_point = 90,
	_subterrane_ceiling_decor = salt_ceiling,
	_subterrane_floor_decor = salt_floor,
	_subterrane_fill_node = c_air,
})

minetest.register_biome({
	name = "caverealms_glow_obsidian",
	y_min = YMIN,
	y_max = DEEP_CAVE,
	heat_point = 80,
	humidity_point = 10,
	_subterrane_ceiling_decor = obsidian_ceiling,
	_subterrane_floor_decor = obsidian_floor,
	_subterrane_fill_node = c_air,
})

minetest.register_biome({
	name = "caverealms_coal_dust",
	y_min = YMIN,
	y_max = DEEP_CAVE,
	heat_point = 60,
	humidity_point = 50,
	_subterrane_ceiling_decor = coal_ceiling,
	_subterrane_floor_decor = coal_floor,
	_subterrane_fill_node = c_air,
})
