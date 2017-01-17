-- „Parameter“/„Settings“
local setting

-- Probability function
-- TODO: Check if this is correct
local P = function (float)
	return math.floor(32767 * float)
end

-- Wahrscheinlichkeit für jeden Chunk, solche Gänge mit Schienen zu bekommen
-- Probability for every newly generated chunk to get corridors
local probability_railcaves_in_chunk = P(1/3)
setting = tonumber(minetest.setting_get("tsm_railcorridors_probability_railcaves_in_chunk"))
if setting then
	probability_railcaves_in_chunk = P(setting)
end

-- Innerhalb welcher Parameter soll sich die Pfadlänge bewegen? (Forks heben den Maximalwert auf)
-- Minimal and maximal value of path length (forks don't look up this value)
local way_min = 4;
local way_max = 7;
setting = tonumber(minetest.setting_get("tsm_railcorridors_way_min"))
if setting then
	way_min = setting
end
setting = tonumber(minetest.setting_get("tsm_railcorridors_way_max"))
if setting then
	way_max = setting
end

-- Wahrsch. für jeden geraden Teil eines Korridors, Fackeln zu bekommen
-- Probability for every horizontal part of a corridor to be with torches
local probability_torches_in_segment = P(0.5)
setting = tonumber(minetest.setting_get("tsm_railcorridors_probability_torches_in_segment"))
if setting then
	probability_torches_in_segment = P(setting)
end

-- Wahrsch. für jeden Teil eines Korridors, nach oben oder nach unten zu gehen
-- Probability for every part of a corridor to go up or down
local probability_up_or_down = P(0.2)
setting = tonumber(minetest.setting_get("tsm_railcorridors_probability_up_or_down"))
if setting then
	probability_up_or_down = P(setting)
end

-- Wahrscheinlichkeit für jeden Teil eines Korridors, sich zu verzweigen – vorsicht, wenn fast jeder Gang sich verzweigt, kann der Algorithums unlösbar werden und MT hängt sich auf
-- Probability for every part of a corridor to fork – caution, too high values may cause MT to hang on.
local probability_fork = P(0.04)
setting = tonumber(minetest.setting_get("tsm_railcorridors_probability_fork"))
if setting then
	probability_fork = P(setting)
end

-- Wahrscheinlichkeit für jeden geraden Teil eines Korridors eine Kiste zu enthalten
-- Probability for every part of a corridor to contain a chest
local probability_chest = P(0.05)
setting = tonumber(minetest.setting_get("tsm_railcorridors_probability_chest"))
if setting then
	probability_chest = P(setting)
end

-- Parameter Ende


-- random generator
local pr
local pr_initialized = false

local function InitRandomizer(seeed)
	pr = PseudoRandom(seeed)
	pr_initialized = true
end

-- Checks if the mapgen is allowed to carve through this structure and only sets
-- the node if it is allowed.
local function SetNodeIfCanBuild(pos, node)
	if minetest.registered_nodes[minetest.get_node(pos).name].is_ground_content then
		minetest.set_node(pos, node)
		return true
	else
		return false
	end
end

-- Checks if the node is empty space which requires to be filled by a platform
local function NeedsPlatform(pos)
	local node = minetest.get_node(pos)
	local node2 = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
	local nodedef = minetest.registered_nodes[node.name]
	local node2def = minetest.registered_nodes[node2.name]
	return nodedef.is_ground_content and nodedef.walkable == false
		and node2def.is_ground_content and node2def.walkable == false
end

-- Würfel…
-- Cube…
local function Cube(p, radius, node)
	for zi = p.z-radius, p.z+radius do
		for yi = p.y-radius, p.y+radius do
			for xi = p.x-radius, p.x+radius do
				SetNodeIfCanBuild({x=xi,y=yi,z=zi}, node)
			end
		end
	end
end

local function Platform(p, radius, node)
	for zi = p.z-radius, p.z+radius do
		for xi = p.x-radius, p.x+radius do
			if NeedsPlatform({x=xi,y=p.y-(radius+1),z=zi}) then
				minetest.set_node({x=xi,y=p.y-(radius+1),z=zi}, node)
			end
		end
	end
end

-- Random chest items
-- Zufälliger Kisteninhalt
local function rci()
	if(minetest.get_modpath("treasurer") ~= nil) then
		local treasures
		if pr:next(0,100) < 3 then
			treasures = treasurer.select_random_treasures(1,2,4)
		elseif pr:next(0,100) < 5 then
			if pr:next(0,100) < 50 then
				treasures = treasurer.select_random_treasures(1,2,4,"seed")
			else
				treasures = treasurer.select_random_treasures(1,2,4,"seed")
			end
		elseif pr:next(0,1000) < 5 then
			return "tnt:tnt "..pr:next(1,3)
		elseif pr:next(0,1000) < 3 then
			if pr:next(0,1000) < 800 then
				treasures = treasurer.select_random_treasures(1,3,6,"mineral")
			else
				treasures = treasurer.select_random_treasures(1,5,9,"mineral")
			end
		end

		if(treasures ~= nil) then
			if(#treasures>=1) then
				return treasures[1]:get_name()
			else
				return ""
			end
		else
			return ""
		end
	else

		if pr:next(0,100) < 3 then
			return "farming:bread "..pr:next(1,3)
		elseif pr:next(0,100) < 5 then
			if pr:next(0,100) < 50 then
				return "farming:seed_cotton "..pr:next(1,5)
			else
				return "farming:seed_wheat "..pr:next(1,5)
			end
		elseif pr:next(0,1000) < 5 then
			return "tnt:tnt "..pr:next(1,3)
		elseif pr:next(0,1000) < 3 then
			if pr:next(0,1000) < 800 then
				return "default:mese_crystal "..pr:next(1,3)
			else
				return "default:diamond "..pr:next(1,3)
			end
		else
			return ""
		end
	end
end
-- chests
local function Place_Chest(pos)
	if SetNodeIfCanBuild(pos, {name="default:chest"}) then
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		for i=1,32 do
			inv:set_stack("main", i, ItemStack(rci()))
		end
	end
end
	
local function WoodBulk(pos, wood)
	SetNodeIfCanBuild({x=pos.x+1, y=pos.y, z=pos.z+1}, {name=wood})
	SetNodeIfCanBuild({x=pos.x-1, y=pos.y, z=pos.z+1}, {name=wood})
	SetNodeIfCanBuild({x=pos.x+1, y=pos.y, z=pos.z-1}, {name=wood})
	SetNodeIfCanBuild({x=pos.x-1, y=pos.y, z=pos.z-1}, {name=wood})
end

-- Gänge mit Schienen
-- Corridors with rails

local function corridor_part(start_point, segment_vector, segment_count, wood, post)
	local p = {x=start_point.x, y=start_point.y, z=start_point.z}
	local torches = pr:next() < probability_torches_in_segment
	local dir = {0, 0}
	local torchdir = {1, 1}
	local node_wood = {name=wood}
	local node_fence = {name=post}
	if segment_vector.x == 0 and segment_vector.z ~= 0 then
		dir = {1, 0}
		torchdir = {5, 4}
	elseif segment_vector.x ~= 0 and segment_vector.z == 0 then
		dir = {0, 1}
		torchdir = {3, 2}
	end
	for segmentindex = 0, segment_count-1 do
		Cube(p, 1, {name="air"})
		-- Add wooden platform, if neccessary. To avoid floating rails
		if segment_vector.y == 0 then
			Platform(p, 1, node_wood)
		end
		-- Diese komischen Holz-Konstruktionen
		-- These strange wood structs
		if segmentindex % 2 == 1 and segment_vector.y == 0 then
			local calc = {
				p.x+dir[1], p.z+dir[2], -- X and Z, added by direction
				p.x-dir[1], p.z-dir[2], -- subtracted
				p.x+dir[2], p.z+dir[1], -- orthogonal
				p.x-dir[2], p.z-dir[1], -- orthogonal, the other way
			}
			--[[ Shape:
				WWW
				P.P
				PrP
				pfp
			W = wood
			P = post (above floor level)
			p = post (in floor level, only placed if no floor)
			
			From previous generation (for reference):
			f = floor
			r = rail
			. = air
			]]

			-- Don't place those wood structs below open air
			if not (minetest.get_node({x=calc[1], y=p.y+2, z=calc[2]}).name == "air" and
				minetest.get_node({x=calc[3], y=p.y+2, z=calc[4]}).name == "air" and
				minetest.get_node({x=p.x, y=p.y+2, z=p.z}).name == "air") then

				-- Left post and planks
				local left_ok = true
				left_ok = SetNodeIfCanBuild({x=calc[1], y=p.y-1, z=calc[2]}, node_fence)
				if left_ok then left_ok = SetNodeIfCanBuild({x=calc[1], y=p.y  , z=calc[2]}, node_fence) end
				if left_ok then left_ok = SetNodeIfCanBuild({x=calc[1], y=p.y+1, z=calc[2]}, node_wood) end

				-- Right post and planks
				local right_ok = true
				right_ok = SetNodeIfCanBuild({x=calc[3], y=p.y-1, z=calc[4]}, node_fence)
				if right_ok then right_ok = SetNodeIfCanBuild({x=calc[3], y=p.y  , z=calc[4]}, node_fence) end
				if right_ok then right_ok = SetNodeIfCanBuild({x=calc[3], y=p.y+1, z=calc[4]}, node_wood) end

				-- Middle planks
				local top_planks_ok = false
				if left_ok and right_ok then top_planks_ok = SetNodeIfCanBuild({x=p.x, y=p.y+1, z=p.z}, node_wood) end

				if minetest.get_node({x=p.x,y=p.y-2,z=p.z}).name=="air" then
					if left_ok then SetNodeIfCanBuild({x=calc[1], y=p.y-2, z=calc[2]}, node_fence) end
					if right_ok then SetNodeIfCanBuild({x=calc[3], y=p.y-2, z=calc[4]}, node_fence) end
				end
				-- Torches on the middle planks
				if torches and top_planks_ok then
					-- Place torches at horizontal sides
					local walltorchtype
					if minetest.get_modpath("torches") then
						--[[ This is compability code with the torches mod, which overwrites the way how torches work.
						This is needed so that torches are drawn properly. ]]
						walltorchtype = "default:torch_wall"
					else
						walltorchtype = "default:torch"
					end
					SetNodeIfCanBuild({x=calc[5], y=p.y+1, z=calc[6]}, {name=walltorchtype, param2=torchdir[1]})
					SetNodeIfCanBuild({x=calc[7], y=p.y+1, z=calc[8]}, {name=walltorchtype, param2=torchdir[2]})
				end
			elseif torches then
				-- Try to build torches instead of the wood structs
				local node = {name="default:torch", param2=minetest.dir_to_wallmounted({x=0,y=-1,z=0})}

				-- Try two different height levels
				local pos1 = {x=calc[1], y=p.y-2, z=calc[2]}
				local pos2 = {x=calc[3], y=p.y-2, z=calc[4]}
				local nodedef1 = minetest.registered_nodes[minetest.get_node(pos1).name]
				local nodedef2 = minetest.registered_nodes[minetest.get_node(pos2).name]

				if nodedef1.walkable then
					pos1.y = pos1.y + 1
				end
				SetNodeIfCanBuild(pos1, node)

				if nodedef2.walkable then
					pos2.y = pos2.y + 1
				end
				SetNodeIfCanBuild(pos2, node)

			end
		end
		
		-- nächster Punkt durch Vektoraddition
		-- next way point
		p = vector.add(p, segment_vector)
	end
end

local function corridor_func(waypoint, coord, sign, up_or_down, up, wood, post)
	local segamount = 3
	if up_or_down then
		segamount = 1
	end
	if sign then
		segamount = 0-segamount
	end
	local vek = {x=0,y=0,z=0};
	if coord == "x" then
		vek.x=segamount
	elseif coord == "z" then
		vek.z=segamount
	end
	if up_or_down then
		if up then
			vek.y = 1
		else
			vek.y = -1
		end
	end
	local segcount = pr:next(4,6)
	corridor_part(waypoint, vek, segcount, wood, post)
	local corridor_vek = {x=vek.x*segcount, y=vek.y*segcount, z=vek.z*segcount}

	-- nachträglich Schienen legen
	-- after this: rails
	segamount = 1
	if sign then
		segamount = 0-segamount
	end
	if coord == "x" then
		vek.x=segamount
	elseif coord == "z" then
		vek.z=segamount
	end
	if up_or_down then
		if up then
			vek.y = 1
		else
			vek.y = -1
		end
	end
	if not up_or_down then
		segcount = segcount * 3
	end
	local minuend = 1
	if up_or_down then
		minuend = minuend - 1
		if not up then
			minuend = minuend - 1
		end
	end
	local chestplace = -1
	if pr:next() < probability_chest then
		chestplace = pr:next(1,segcount+1)
	end
	if not up_or_down then
		for i=1,segcount do
			local p = {x=waypoint.x+vek.x*i, y=waypoint.y+vek.y*i-1, z=waypoint.z+vek.z*i}
			if minetest.get_node({x=p.x,y=p.y-1,z=p.z}).name=="air" and minetest.get_node({x=p.x,y=p.y-3,z=p.z}).name~="default:rail" then
				p.y = p.y - 1;
			end
			if minetest.get_node({x=p.x,y=p.y-1,z=p.z}).name ~="default:rail" then
				SetNodeIfCanBuild(p, {name = "default:rail"})
			end
			if i == chestplace then
				if minetest.get_node({x=p.x+vek.z,y=p.y-1,z=p.z-vek.x}).name == post then
					chestplace = chestplace + 1
				else
					Place_Chest({x=p.x+vek.z,y=p.y,z=p.z-vek.x})
				end
			end
		end
	end
	
	return {x=waypoint.x+corridor_vek.x, y=waypoint.y+corridor_vek.y, z=waypoint.z+corridor_vek.z}
end

local function start_corridor(waypoint, coord, sign, length, psra, wood, post)
	local wp = waypoint
	local c = coord
	local s = sign
	local ud
	local up
	for i=1,length do
		-- Nach oben oder nach unten?
		--Up or down?
		if pr:next() < probability_up_or_down and i~=1 then
			ud = true
			up = pr:next(0, 2) < 1
		else
			 ud = false
		end
		-- Make corridor / Korridor graben
		wp = corridor_func(wp,c,s, ud, up, wood, post)
		-- Verzweigung?
		-- Fork?
		if pr:next() < probability_fork then
			local p = {x=wp.x, y=wp.y, z=wp.z}
			start_corridor(wp, c, s, pr:next(way_min,way_max), psra, wood, post)
			if c == "x" then c="z" else c="x" end
			start_corridor(wp, c, s, pr:next(way_min,way_max), psra, wood, post)
			start_corridor(wp, c, not s, pr:next(way_min,way_max), psra, wood, post)
			WoodBulk({x=p.x, y=p.y-1, z=p.z}, wood)
			WoodBulk({x=p.x, y=p.y,   z=p.z}, wood)
			WoodBulk({x=p.x, y=p.y+1, z=p.z}, wood)
			WoodBulk({x=p.x, y=p.y+2, z=p.z}, wood)
			return
		end
		-- coord und sign verändern
		-- randomly change sign and coord
		if c=="x" then
			c="z"
		elseif c=="z" then
			c="x"
	 	end;
		s = pr:next(0, 2) < 1
	end
end

local corridor_woods = {
	wood = { wood = "default:wood", post = "default:fence_wood"},
	jungle = { wood = "default:junglewood", post = "default:fence_junglewood"},
	acacia = { wood = "default:acacia_wood", post = "default:fence_acacia_wood"},
	pine = { wood = "default:pine_wood", post = "default:fence_pine_wood"},
	aspen = { wood = "default:aspen_wood", post = "default:fence_aspen_wood"},
}

local function place_corridors(main_cave_coords, psra)
	if pr:next(0, 100) < 50 then
		Cube(main_cave_coords, 4, {name="default:dirt"})
		Cube(main_cave_coords, 3, {name="air"})
		main_cave_coords.y =main_cave_coords.y - 1
	else
		Cube(main_cave_coords, 3, {name="default:dirt"})
		Cube(main_cave_coords, 2, {name="air"})
	end
	local xs = pr:next(0, 2) < 1
	local zs = pr:next(0, 2) < 1;

	-- Select random wood type, but with bias towards default wood
	local rnd = pr:next(1,1000)

	local woodtype
	-- Wood: 80%
	if rnd <= 800 then
		woodtype = "wood"
	-- Jungle: 15%
	elseif rnd <= 950 then
		woodtype = "jungle"
	-- Acacia: 4.5%
	elseif rnd <= 995 then
		woodtype = "acacia"
	-- Pine: 0.3%
	elseif rnd <= 998 then
		woodtype = "pine"
	-- Aspen: 0.2%
	else
		woodtype = "aspen"
	end
	local wood = corridor_woods[woodtype].wood
	local post = corridor_woods[woodtype].post
	start_corridor(main_cave_coords, "x", xs, pr:next(way_min,way_max), psra, wood, post)
	start_corridor(main_cave_coords, "z", zs, pr:next(way_min,way_max), psra, wood, post)
	-- Auch mal die andere Richtung?
	-- Try the other direction?
	if pr:next(0, 100) < 70 then
		start_corridor(main_cave_coords, "x", not xs, pr:next(way_min,way_max), psra, wood, post)
	end
	if pr:next(0, 100) < 70 then
		start_corridor(main_cave_coords, "z", not zs, pr:next(way_min,way_max), psra, wood, post)
	end
end

minetest.register_on_generated(function(minp, maxp, seed)	
	if not pr_initialized then
		InitRandomizer(seed)
	end
	if maxp.y < 0 and pr:next() < probability_railcaves_in_chunk then
		-- Mittelpunkt berechnen
		-- Mid point of the chunk
		local p = {x=minp.x+(maxp.x-minp.x)/2, y=minp.y+(maxp.y-minp.y)/2, z=minp.z+(maxp.z-minp.z)/2}
		-- Haupthöhle und alle weiteren
		-- Corridors; starting with main cave out of dirt
		place_corridors(p, pr)
	end
end)
