-- Biome library mod by VanessaE
--
-- I got the temperature map idea from "hmmmm", values used for it came from
-- Splizard's snow mod.
--

-- Various settings - most of these probably won't need to be changed

biome_lib = {}
biome_lib.air = {name = "air"}

plantslib = setmetatable({}, { __index=function(t,k) print("Use of deprecated function:", k) return biome_lib[k] end })

biome_lib.blocklist_aircheck = {}
biome_lib.blocklist_no_aircheck = {}

biome_lib.surface_nodes_aircheck = {}
biome_lib.surface_nodes_no_aircheck = {}

biome_lib.surfaceslist_aircheck = {}
biome_lib.surfaceslist_no_aircheck = {}

biome_lib.actioncount_aircheck = {}
biome_lib.actioncount_no_aircheck = {}

biome_lib.actionslist_aircheck = {}
biome_lib.actionslist_no_aircheck = {}

biome_lib.modpath = minetest.get_modpath("biome_lib")

biome_lib.total_no_aircheck_calls = 0

biome_lib.queue_run_ratio = tonumber(minetest.settings:get("biome_lib_queue_run_ratio")) or 100

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.global_exists("intllib") then
	if intllib.make_gettext_pair then
		S = intllib.make_gettext_pair()
	else
		S = intllib.Getter()
	end
else
	S = function(s) return s end
end
biome_lib.intllib = S

local DEBUG = false --... except if you want to spam the console with debugging info :-)

function biome_lib:dbg(msg)
	if DEBUG then
		print("[Plantlife] "..msg)
		minetest.log("verbose", "[Plantlife] "..msg)
	end
end

biome_lib.plantlife_seed_diff = 329	-- needs to be global so other mods can see it

local perlin_octaves = 3
local perlin_persistence = 0.6
local perlin_scale = 100

local temperature_seeddiff = 112
local temperature_octaves = 3
local temperature_persistence = 0.5
local temperature_scale = 150

local humidity_seeddiff = 9130
local humidity_octaves = 3
local humidity_persistence = 0.5
local humidity_scale = 250

local time_scale = 1
local time_speed = tonumber(minetest.settings:get("time_speed"))

if time_speed and time_speed > 0 then
	time_scale = 72 / time_speed
end

--PerlinNoise(seed, octaves, persistence, scale)

biome_lib.perlin_temperature = PerlinNoise(temperature_seeddiff, temperature_octaves, temperature_persistence, temperature_scale)
biome_lib.perlin_humidity = PerlinNoise(humidity_seeddiff, humidity_octaves, humidity_persistence, humidity_scale)

-- Local functions

local function get_biome_data(pos, perlin_fertile)
	local fertility = perlin_fertile:get_2d({x=pos.x, y=pos.z})

	if type(minetest.get_biome_data) == "function" then
		local data = minetest.get_biome_data(pos)
		if data then
			return fertility, data.heat / 100, data.humidity / 100
		end
	end

	local temperature = biome_lib.perlin_temperature:get2d({x=pos.x, y=pos.z})
	local humidity = biome_lib.perlin_humidity:get2d({x=pos.x+150, y=pos.z+50})

	return fertility, temperature, humidity
end

function biome_lib:is_node_loaded(node_pos)
	local n = minetest.get_node_or_nil(node_pos)
	if (not n) or (n.name == "ignore") then
		return false
	end
	return true
end

function biome_lib:set_defaults(biome)
	biome.seed_diff = biome.seed_diff or 0
	biome.min_elevation = biome.min_elevation or -31000
	biome.max_elevation = biome.max_elevation or 31000
	biome.temp_min = biome.temp_min or 1
	biome.temp_max = biome.temp_max or -1
	biome.humidity_min = biome.humidity_min or 1
	biome.humidity_max = biome.humidity_max or -1
	biome.plantlife_limit = biome.plantlife_limit or 0.1
	biome.near_nodes_vertical = biome.near_nodes_vertical or 1

-- specific to on-generate

	biome.neighbors = biome.neighbors or biome.surface
	biome.near_nodes_size = biome.near_nodes_size or 0
	biome.near_nodes_count = biome.near_nodes_count or 1
	biome.rarity = biome.rarity or 50
	biome.max_count = biome.max_count or 5
	if biome.check_air ~= false then biome.check_air = true end

-- specific to abm spawner
	biome.seed_diff = biome.seed_diff or 0
	biome.light_min = biome.light_min or 0
	biome.light_max = biome.light_max or 15
	biome.depth_max = biome.depth_max or 1
	biome.facedir = biome.facedir or 0
end

local function search_table(t, s)
	for i = 1, #t do
		if t[i] == s then return true end
	end
	return false
end

-- register the list of surfaces to spawn stuff on, filtering out all duplicates.
-- separate the items by air-checking or non-air-checking map eval methods

function biome_lib:register_generate_plant(biomedef, nodes_or_function_or_model)

	-- if calling code passes an undefined node for a surface or 
	-- as a node to be spawned, don't register an action for it.

	if type(nodes_or_function_or_model) == "string"
	  and string.find(nodes_or_function_or_model, ":")
	  and not minetest.registered_nodes[nodes_or_function_or_model] then
		biome_lib:dbg("Warning: Ignored registration for undefined spawn node: "..dump(nodes_or_function_or_model))
		return
	end

	if type(nodes_or_function_or_model) == "string"
	  and not string.find(nodes_or_function_or_model, ":") then
		biome_lib:dbg("Warning: Registered function call using deprecated string method: "..dump(nodes_or_function_or_model))
	end

	if biomedef.check_air == false then 
		biome_lib:dbg("Register no-air-check mapgen hook: "..dump(nodes_or_function_or_model))
		biome_lib.actionslist_no_aircheck[#biome_lib.actionslist_no_aircheck + 1] = { biomedef, nodes_or_function_or_model }
		local s = biomedef.surface
		if type(s) == "string" then
			if s and (string.find(s, "^group:") or minetest.registered_nodes[s]) then
				if not search_table(biome_lib.surfaceslist_no_aircheck, s) then
					biome_lib.surfaceslist_no_aircheck[#biome_lib.surfaceslist_no_aircheck + 1] = s
				end
			else
				biome_lib:dbg("Warning: Ignored no-air-check registration for undefined surface node: "..dump(s))
			end
		else
			for i = 1, #biomedef.surface do
				local s = biomedef.surface[i]
				if s and (string.find(s, "^group:") or minetest.registered_nodes[s]) then
					if not search_table(biome_lib.surfaceslist_no_aircheck, s) then
						biome_lib.surfaceslist_no_aircheck[#biome_lib.surfaceslist_no_aircheck + 1] = s
					end
				else
					biome_lib:dbg("Warning: Ignored no-air-check registration for undefined surface node: "..dump(s))
				end
			end
		end
	else
		biome_lib:dbg("Register with-air-checking mapgen hook: "..dump(nodes_or_function_or_model))
		biome_lib.actionslist_aircheck[#biome_lib.actionslist_aircheck + 1] = { biomedef, nodes_or_function_or_model }
		local s = biomedef.surface
		if type(s) == "string" then
			if s and (string.find(s, "^group:") or minetest.registered_nodes[s]) then
				if not search_table(biome_lib.surfaceslist_aircheck, s) then
					biome_lib.surfaceslist_aircheck[#biome_lib.surfaceslist_aircheck + 1] = s
				end
			else
				biome_lib:dbg("Warning: Ignored with-air-checking registration for undefined surface node: "..dump(s))
			end
		else
			for i = 1, #biomedef.surface do
				local s = biomedef.surface[i]
				if s and (string.find(s, "^group:") or minetest.registered_nodes[s]) then
					if not search_table(biome_lib.surfaceslist_aircheck, s) then
						biome_lib.surfaceslist_aircheck[#biome_lib.surfaceslist_aircheck + 1] = s
					end
				else
					biome_lib:dbg("Warning: Ignored with-air-checking registration for undefined surface node: "..dump(s))
				end
			end
		end
	end
end

-- Function to check whether a position matches the given biome definition
-- Returns true when the surface can be populated

local function populate_single_surface(biome, pos, perlin_fertile_area, checkair)
	local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }

	if math.random(1, 100) <= biome.rarity then
		return
	end

	local fertility, temperature, humidity = get_biome_data(pos, perlin_fertile_area)

	local pos_biome_ok = pos.y >= biome.min_elevation and pos.y <= biome.max_elevation
		and fertility > biome.plantlife_limit
		and temperature <= biome.temp_min and temperature >= biome.temp_max
		and humidity <= biome.humidity_min and humidity >= biome.humidity_max
	
	if not pos_biome_ok then
		return -- Y position mismatch, outside of biome
	end

	local biome_surfaces_string = dump(biome.surface)
	local surface_ok = false

	if not biome.depth then
		local dest_node = minetest.get_node(pos)
		if string.find(biome_surfaces_string, dest_node.name) then
			surface_ok = true
		else
			if string.find(biome_surfaces_string, "group:") then
				for j = 1, #biome.surface do
					if string.find(biome.surface[j], "^group:") 
					  and minetest.get_item_group(dest_node.name, biome.surface[j]) then
						surface_ok = true
						break
					end
				end
			end
		end
	elseif not string.find(biome_surfaces_string,
			minetest.get_node({ x = pos.x, y = pos.y-biome.depth-1, z = pos.z }).name) then
		surface_ok = true
	end
	
	if not surface_ok then
		return -- Surface does not match the given node group/name
	end

	if checkair and minetest.get_node(p_top).name ~= "air" then
		return
	end

	if biome.below_nodes and
			not string.find(dump(biome.below_nodes),
				minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
			) then
		return -- Node below does not match
	end

	if biome.ncount and
			#minetest.find_nodes_in_area(
				{x=pos.x-1, y=pos.y, z=pos.z-1},
				{x=pos.x+1, y=pos.y, z=pos.z+1},
				biome.neighbors
			) <= biome.ncount then
		return -- Not enough similar biome nodes around
	end

	if biome.near_nodes and
			#minetest.find_nodes_in_area(
				{x=pos.x-biome.near_nodes_size, y=pos.y-biome.near_nodes_vertical, z=pos.z-biome.near_nodes_size},
				{x=pos.x+biome.near_nodes_size, y=pos.y+biome.near_nodes_vertical, z=pos.z+biome.near_nodes_size}, 
				biome.near_nodes
			) < biome.near_nodes_count then
		return -- Long distance neighbours do not match
	end

	-- Position fits into given biome
	return true
end

function biome_lib:populate_surfaces(biome, nodes_or_function_or_model, snodes, checkair)

	biome_lib:set_defaults(biome)

	-- filter stage 1 - find nodes from the supplied surfaces that are within the current biome.

	local in_biome_nodes = {}
	local perlin_fertile_area = minetest.get_perlin(biome.seed_diff, perlin_octaves, perlin_persistence, perlin_scale)

	for i = 1, #snodes do
		local pos = vector.new(snodes[i])
		if populate_single_surface(biome, pos, perlin_fertile_area, checkair) then
			in_biome_nodes[#in_biome_nodes + 1] = pos
		end
	end

	-- filter stage 2 - find places within that biome area to place the plants.

	local num_in_biome_nodes = #in_biome_nodes

	if num_in_biome_nodes == 0 then
		return
	end

	for i = 1, math.min(biome.max_count, num_in_biome_nodes) do
		local tries = 0
		local spawned = false
		while tries < 2 and not spawned do
			local pos = in_biome_nodes[math.random(1, num_in_biome_nodes)]
			if biome.spawn_replace_node then
				pos.y = pos.y-1
			end
			local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }

			if not (biome.avoid_nodes and biome.avoid_radius
					and minetest.find_node_near(p_top, biome.avoid_radius
					+ math.random(-1.5,2), biome.avoid_nodes)) then
				if biome.delete_above then
					minetest.swap_node(p_top, biome_lib.air)
					minetest.swap_node({x=p_top.x, y=p_top.y+1, z=p_top.z}, biome_lib.air)
				end

				if biome.delete_above_surround then
					minetest.swap_node({x=p_top.x-1, y=p_top.y, z=p_top.z}, biome_lib.air)
					minetest.swap_node({x=p_top.x+1, y=p_top.y, z=p_top.z}, biome_lib.air)
					minetest.swap_node({x=p_top.x,   y=p_top.y, z=p_top.z-1}, biome_lib.air)
					minetest.swap_node({x=p_top.x,   y=p_top.y, z=p_top.z+1}, biome_lib.air)

					minetest.swap_node({x=p_top.x-1, y=p_top.y+1, z=p_top.z}, biome_lib.air)
					minetest.swap_node({x=p_top.x+1, y=p_top.y+1, z=p_top.z}, biome_lib.air)
					minetest.swap_node({x=p_top.x,   y=p_top.y+1, z=p_top.z-1}, biome_lib.air)
					minetest.swap_node({x=p_top.x,   y=p_top.y+1, z=p_top.z+1}, biome_lib.air)
				end

				if biome.spawn_replace_node then
					minetest.swap_node(pos, biome_lib.air)
				end

				local objtype = type(nodes_or_function_or_model)

				if objtype == "table" then
					if nodes_or_function_or_model.axiom then
						biome_lib:generate_tree(p_top, nodes_or_function_or_model)
						spawned = true
					else
						local fdir = nil
						if biome.random_facedir then
							fdir = math.random(biome.random_facedir[1], biome.random_facedir[2])
						end
						minetest.swap_node(p_top, { name = nodes_or_function_or_model[math.random(#nodes_or_function_or_model)], param2 = fdir })
						spawned = true
					end
				elseif objtype == "string" and
				  minetest.registered_nodes[nodes_or_function_or_model] then
					local fdir = nil
					if biome.random_facedir then
						fdir = math.random(biome.random_facedir[1], biome.random_facedir[2])
					end
					minetest.swap_node(p_top, { name = nodes_or_function_or_model, param2 = fdir })
					spawned = true
				elseif objtype == "function" then
					nodes_or_function_or_model(pos)
					spawned = true
				elseif objtype == "string" and pcall(loadstring(("return %s(...)"):
					format(nodes_or_function_or_model)),pos) then
					spawned = true
				else
					biome_lib:dbg("Warning: Ignored invalid definition for object "..dump(nodes_or_function_or_model).." that was pointed at {"..dump(pos).."}")
				end
			else
				tries = tries + 1
			end
		end
	end
end

-- Primary mapgen spawner, for mods that can work with air checking enabled on
-- a surface during the initial map read stage.

function biome_lib:generate_block_with_air_checking()
	if not biome_lib.blocklist_aircheck[1] then
		return
	end

	local minp =		biome_lib.blocklist_aircheck[1][1]
	local maxp =		biome_lib.blocklist_aircheck[1][2]

	-- use the block hash as a unique key into the surface nodes
	-- tables, so that we can write the tables thread-safely.

	local blockhash =	minetest.hash_node_position(minp)

	if not biome_lib.surface_nodes_aircheck.blockhash then -- read it into the block cache
		biome_lib.surface_nodes_aircheck.blockhash =
			minetest.find_nodes_in_area_under_air(minp, maxp, biome_lib.surfaceslist_aircheck)
		biome_lib.actioncount_aircheck.blockhash = 1

	else
		if biome_lib.actionslist_aircheck[biome_lib.actioncount_aircheck.blockhash] then
			-- [1] is biome, [2] is node/function/model
			biome_lib:populate_surfaces(
				biome_lib.actionslist_aircheck[biome_lib.actioncount_aircheck.blockhash][1],
				biome_lib.actionslist_aircheck[biome_lib.actioncount_aircheck.blockhash][2],
				biome_lib.surface_nodes_aircheck.blockhash, true)
			biome_lib.actioncount_aircheck.blockhash = biome_lib.actioncount_aircheck.blockhash + 1
		else
			table.remove(biome_lib.blocklist_aircheck, 1)
			biome_lib.surface_nodes_aircheck.blockhash = nil
			biome_lib.actioncount_aircheck.blockhash = nil
		end
	end
end

-- Secondary mapgen spawner, for mods that require disabling of
-- checking for air during the initial map read stage.

function biome_lib:generate_block_no_aircheck()
	if not biome_lib.blocklist_no_aircheck[1] then
		return
	end

	local minp =		biome_lib.blocklist_no_aircheck[1][1]
	local maxp =		biome_lib.blocklist_no_aircheck[1][2]

	local blockhash =	minetest.hash_node_position(minp)

	if not biome_lib.surface_nodes_no_aircheck.blockhash then
		biome_lib.surface_nodes_no_aircheck.blockhash =
			minetest.find_nodes_in_area(minp, maxp, biome_lib.surfaceslist_no_aircheck)
		biome_lib.actioncount_no_aircheck.blockhash = 1

	else
		if biome_lib.actionslist_no_aircheck[biome_lib.actioncount_no_aircheck.blockhash] then
			biome_lib:populate_surfaces(
				biome_lib.actionslist_no_aircheck[biome_lib.actioncount_no_aircheck.blockhash][1],
				biome_lib.actionslist_no_aircheck[biome_lib.actioncount_no_aircheck.blockhash][2],
				biome_lib.surface_nodes_no_aircheck.blockhash, false)
			biome_lib.actioncount_no_aircheck.blockhash = biome_lib.actioncount_no_aircheck.blockhash + 1
		else
			table.remove(biome_lib.blocklist_no_aircheck, 1)
			biome_lib.surface_nodes_no_aircheck.blockhash = nil
			biome_lib.actioncount_no_aircheck.blockhash = nil
		end
	end
end

-- "Play" them back, populating them with new stuff in the process

local step_duration = tonumber(minetest.settings:get("dedicated_server_step"))
minetest.register_globalstep(function(dtime)
	if dtime >= step_duration + 0.1 -- don't attempt to populate if lag is already too high
			or math.random(100) > biome_lib.queue_run_ratio
			or (#biome_lib.blocklist_aircheck == 0 and #biome_lib.blocklist_no_aircheck == 0) then
		return
	end

	biome_lib.globalstep_start_time = minetest.get_us_time()
	biome_lib.globalstep_runtime = 0
	while (#biome_lib.blocklist_aircheck > 0 or #biome_lib.blocklist_no_aircheck > 0)
	  and biome_lib.globalstep_runtime < 200000 do  -- 0.2 seconds, in uS.
		if #biome_lib.blocklist_aircheck > 0 then
			biome_lib:generate_block_with_air_checking()
		end
		if #biome_lib.blocklist_no_aircheck > 0 then
			biome_lib:generate_block_no_aircheck()
		end
		biome_lib.globalstep_runtime = minetest.get_us_time() - biome_lib.globalstep_start_time
	end
end)

-- Play out the entire log all at once on shutdown
-- to prevent unpopulated map areas

minetest.register_on_shutdown(function()
	if #biome_lib.blocklist_aircheck == 0 then
		return
	end

	print("[biome_lib] Stand by, playing out the rest of the aircheck mapblock log")
	print("(there are "..#biome_lib.blocklist_aircheck.." entries)...")
	while #biome_lib.blocklist_aircheck > 0 do
		biome_lib:generate_block_with_air_checking(0.1)
	end
end)

minetest.register_on_shutdown(function()
	if #biome_lib.blocklist_aircheck == 0 then
		return
	end

	print("[biome_lib] Stand by, playing out the rest of the no-aircheck mapblock log")
	print("(there are "..#biome_lib.blocklist_no_aircheck.." entries)...")
	while #biome_lib.blocklist_no_aircheck > 0 do
		biome_lib:generate_block_no_aircheck(0.1)
	end
end)

-- The spawning ABM

function biome_lib:spawn_on_surfaces(sd,sp,sr,sc,ss,sa)

	local biome = {}

	if type(sd) ~= "table" then
		biome.spawn_delay = sd	-- old api expects ABM interval param here.
		biome.spawn_plants = {sp}
		biome.avoid_radius = sr
		biome.spawn_chance = sc
		biome.spawn_surfaces = {ss}
		biome.avoid_nodes = sa
	else
		biome = sd
	end

	if biome.spawn_delay*time_scale >= 1 then
		biome.interval = biome.spawn_delay*time_scale
	else
		biome.interval = 1
	end

	biome_lib:set_defaults(biome)
	biome.spawn_plants_count = #(biome.spawn_plants)

	local n
	if type(biome.spawn_plants) == "table" then
		n = "random: "..biome.spawn_plants[1]..", ..."
	else
		n = biome.spawn_plants
	end
	biome.label = biome.label or "biome_lib spawn_on_surfaces(): "..n

	minetest.register_abm({
		nodenames = biome.spawn_surfaces,
		interval = biome.interval,
		chance = biome.spawn_chance,
		neighbors = biome.neighbors,
		label = biome.label,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }	
			local n_top = minetest.get_node(p_top)
			local perlin_fertile_area = minetest.get_perlin(biome.seed_diff, perlin_octaves, perlin_persistence, perlin_scale)

			local fertility, temperature, humidity = get_biome_data(pos, perlin_fertile_area)

			local pos_biome_ok = pos.y >= biome.min_elevation and pos.y <= biome.max_elevation
				and fertility > biome.plantlife_limit
				and temperature <= biome.temp_min and temperature >= biome.temp_max
				and humidity <= biome.humidity_min and humidity >= biome.humidity_max
				and biome_lib:is_node_loaded(p_top)

			if not pos_biome_ok then
				return -- Outside of biome
			end

			local n_light = minetest.get_node_light(p_top, nil)
			if n_light < biome.light_min or n_light > biome.light_max then
				return -- Too dark or too bright
			end

			if biome.avoid_nodes and biome.avoid_radius and minetest.find_node_near(
					p_top, biome.avoid_radius + math.random(-1.5,2), biome.avoid_nodes) then
				return -- Nodes to avoid are nearby
			end

			if biome.neighbors and biome.ncount and
					#minetest.find_nodes_in_area(
						{x=pos.x-1, y=pos.y, z=pos.z-1},
						{x=pos.x+1, y=pos.y, z=pos.z+1},
						biome.neighbors
					) <= biome.ncount then
				return -- Near neighbour nodes are not present
			end

			local NEAR_DST = biome.near_nodes_size
			if biome.near_nodes and biome.near_nodes_count and biome.near_nodes_size and
					#minetest.find_nodes_in_area(
						{x=pos.x-NEAR_DST, y=pos.y-biome.near_nodes_vertical, z=pos.z-NEAR_DST},
						{x=pos.x+NEAR_DST, y=pos.y+biome.near_nodes_vertical, z=pos.z+NEAR_DST},
						biome.near_nodes
					) < biome.near_nodes_count then
				return -- Far neighbour nodes are not present
			end

			if (biome.air_count and biome.air_size) and
					#minetest.find_nodes_in_area(
						{x=p_top.x-biome.air_size, y=p_top.y, z=p_top.z-biome.air_size},
						{x=p_top.x+biome.air_size, y=p_top.y, z=p_top.z+biome.air_size},
						"air"
					) < biome.air_count then
				return -- Not enough air
			end

			local walldir = biome_lib:find_adjacent_wall(p_top, biome.verticals_list, biome.choose_random_wall)
			if biome.alt_wallnode and walldir then
				if n_top.name == "air" then
					minetest.swap_node(p_top, { name = biome.alt_wallnode, param2 = walldir })
				end
				return
			end

			local currentsurface = minetest.get_node(pos).name

			if currentsurface == "default:water_source" and
					#minetest.find_nodes_in_area(
						{x=pos.x, y=pos.y-biome.depth_max-1, z=pos.z},
						vector.new(pos),
						{"default:dirt", "default:dirt_with_grass", "default:sand"}
					) == 0 then
				return -- On water but no ground nearby
			end

			local rnd = math.random(1, biome.spawn_plants_count)
			local plant_to_spawn = biome.spawn_plants[rnd]
			local fdir = biome.facedir
			if biome.random_facedir then
				fdir = math.random(biome.random_facedir[1],biome.random_facedir[2])
			end
			if type(biome.spawn_plants) == "string" then
				assert(loadstring(biome.spawn_plants.."(...)"))(pos)
			elseif not biome.spawn_on_side and not biome.spawn_on_bottom and not biome.spawn_replace_node then
				if n_top.name == "air" then
					minetest.swap_node(p_top, { name = plant_to_spawn, param2 = fdir })
				end
			elseif biome.spawn_replace_node then
				minetest.swap_node(pos, { name = plant_to_spawn, param2 = fdir })

			elseif biome.spawn_on_side then
				local onside = biome_lib:find_open_side(pos)
				if onside then
					minetest.swap_node(onside.newpos, { name = plant_to_spawn, param2 = onside.facedir })
				end
			elseif biome.spawn_on_bottom then
				if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "air" then
					minetest.swap_node({x=pos.x, y=pos.y-1, z=pos.z}, { name = plant_to_spawn, param2 = fdir} )
				end
			end
		end
	})
end

-- Function to decide how to replace a plant - either grow it, replace it with
-- a tree, run a function, or die with an error.

function biome_lib:replace_object(pos, replacement, grow_function, walldir, seeddiff)
	local growtype = type(grow_function)
	if growtype == "table" then
		minetest.swap_node(pos, biome_lib.air)
		biome_lib:grow_tree(pos, grow_function)
		return
	elseif growtype == "function" then
		local perlin_fertile_area = minetest.get_perlin(seeddiff, perlin_octaves, perlin_persistence, perlin_scale)
		local fertility, temperature, _ = get_biome_data(pos, perlin_fertile_area)
		grow_function(pos, fertility, temperature, walldir)
		return
	elseif growtype == "string" then
		local perlin_fertile_area = minetest.get_perlin(seeddiff, perlin_octaves, perlin_persistence, perlin_scale)
		local fertility, temperature, _ = get_biome_data(pos, perlin_fertile_area)
		assert(loadstring(grow_function.."(...)"))(pos, fertility, temperature, walldir)
		return
	elseif growtype == "nil" then
		minetest.swap_node(pos, { name = replacement, param2 = walldir})
		return
	elseif growtype ~= "nil" and growtype ~= "string" and growtype ~= "table" then
		error("Invalid grow function "..dump(grow_function).." used on object at ("..dump(pos)..")")
	end
end


dofile(biome_lib.modpath .. "/search_functions.lua")
assert(loadfile(biome_lib.modpath .. "/growth.lua"))(time_scale)



-- Check for infinite stacks

if minetest.get_modpath("unified_inventory") or not minetest.settings:get_bool("creative_mode") then
	biome_lib.expect_infinite_stacks = false
else
	biome_lib.expect_infinite_stacks = true
end

-- read a field from a node's definition

function biome_lib:get_nodedef_field(nodename, fieldname)
	if not minetest.registered_nodes[nodename] then
		return nil
	end
	return minetest.registered_nodes[nodename][fieldname]
end

print("[Biome Lib] Loaded")

minetest.after(0, function()
	print("[Biome Lib] Registered a total of "..(#biome_lib.surfaceslist_aircheck)+(#biome_lib.surfaceslist_no_aircheck).." surface types to be evaluated, spread")
	print("[Biome Lib] across "..#biome_lib.actionslist_aircheck.." actions with air-checking and "..#biome_lib.actionslist_no_aircheck.." actions without.")
end)

