-------------------------------------------------------------------------------
-- advanced spawning mod
--
--@license WTFP
--@copyright Sapier
--@author Sapier
--@date 2013-12-05
--
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] MAX
-- @param a first value to compare
-- @param b second value to compare
-- @return maximum of a and b
--------------------------------------------------------------------------------
function adv_spawning.MAX(a,b)
	if a == nil then
		return (b or 0)
	end
	if b == nil then
		return (a or 0)
	end
	if a > b then
		return (a or 0)
	else
		return (b or 0)
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] MIN
-- @param a first value to compare
-- @param b second value to compare
-- @return minimum of a and b
--------------------------------------------------------------------------------
function adv_spawning.MIN(a,b)
	if a == nil then
		return (b or 0)
	end
	if b == nil then
		return (a or 0)
	end
	if a > b then
		return (b or 0)
	else
		return (a or 0)
	end
end


--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] initialize
--------------------------------------------------------------------------------
function adv_spawning.initialize()

	--initialize data
	adv_spawning.quota_starttime = nil
	adv_spawning.quota_reload = 100
	adv_spawning.quota_left = adv_spawning.quota_reload
	adv_spawning.max_spawns_per_spawner = 2
	adv_spawning.spawner_distance = 70
	adv_spawning.spawner_y_offset = 20
	adv_spawning.max_spawning_frequency_hz = 5
	adv_spawning.max_mapgen_tries_per_step = 3
	adv_spawning.spawner_warned = {}
	adv_spawning.loglevel = 0
	adv_spawning.spawner_validation_delta = 0
	adv_spawning.spawner_validation_interval = 30

	adv_spawning.active_range = minetest.setting_get("active_block_range")

	if (adv_spawning.active_range == nil) then
		adv_spawning.log("info", "No \"active_block_range\" set, defaulting to 5")
		adv_spawning.active_range = 5
	else
		adv_spawning.active_range = adv_spawning.active_range * 16
	end

	adv_spawning.spawner_definitions = {}
	adv_spawning.mapgen_jobqueue = {}
	adv_spawning.statistics =
	{
		session =
		{
			spawners_created = 0,
			entities_created = 0,
			steps = 0,
		},
		step =
		{
			min = 0,
			max = 0,
			last = 0,
		},
		load =
		{
			min = 0,
			max = 0,
			cur = 0,
			avg = 0
		}
	}

	adv_spawning.gettime = function() return os.clock() * 1000 end

	if type(minetest.get_us_time) == "function" then
		adv_spawning.log("action", "Using minetest.get_us_time() for quota calc")
		adv_spawning.gettime = function()
				return minetest.get_us_time() / 1000
			end
	else
		if socket == nil then
			local status, module = pcall(require, 'socket')

			if status and type(module.gettime) == "function" then
				adv_spawning.log("action", "Using socket.gettime() for quota calc")
				adv_spawning.gettime = function()
						return socket.gettime()*1000
					end
			end
		end
	end

	--register global onstep
	minetest.register_globalstep(adv_spawning.global_onstep)

	--register seed spawner entity
	adv_spawning.seed_initialize()

	--register mapgen hook
	minetest.register_on_generated(adv_spawning.mapgen_hook)
end


--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] mapgen_hook
-- @param minp minimal position of block
-- @param maxp maximal position of block
-- @param blockseed seed for this block
--------------------------------------------------------------------------------
function adv_spawning.mapgen_hook(minp,maxp,blockseed)
	if adv_spawning.quota_enter(true) then
		--find positions within current block to place a spawner seed
		local start_x =
			math.floor(minp.x/adv_spawning.spawner_distance)
			* adv_spawning.spawner_distance
		local start_y =
			(math.floor(minp.y/adv_spawning.spawner_distance)
				* adv_spawning.spawner_distance)
				+ adv_spawning.spawner_y_offset
		local start_z =
			math.floor(minp.z/adv_spawning.spawner_distance)
			* adv_spawning.spawner_distance

		for x=start_x,maxp.x,adv_spawning.spawner_distance do
		for y=start_y,maxp.y,adv_spawning.spawner_distance do
		for z=start_z,maxp.z,adv_spawning.spawner_distance do

			if x > minp.x and
				y > minp.y and
				z > minp.z then
				if not adv_spawning.quota_leave() then
					adv_spawning.dbg_log(2, "mapgen_hook did use way too much time 1")
				end
				minetest.add_entity({x=x,y=y,z=z},"adv_spawning:spawn_seed")
				adv_spawning.quota_enter(true)
				adv_spawning.log("info", "adv_spawning: adding spawner entity at "
					.. minetest.pos_to_string({x=x,y=y,z=z}))
				adv_spawning.statistics.session.spawners_created =
					adv_spawning.statistics.session.spawners_created +1
			end
		end
		end
		end

		adv_spawning.queue_mapgen_jobs(minp,maxp)
		if not adv_spawning.quota_leave() then
			adv_spawning.dbg_log(2, "mapgen_hook did use way too much time 2")
		end
	else
		assert("Mapgen hook could not be executed" == nil)
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] global_onstep
-- @param dtime time since last call
--------------------------------------------------------------------------------
function adv_spawning.global_onstep(dtime)

	if dtime == 0 then
		-- don't try to calc differences for no time
		return
	end

	adv_spawning.statistics.step.last =
		math.floor(adv_spawning.quota_reload - adv_spawning.quota_left + 0.5)

	adv_spawning.statistics.step.max = adv_spawning.MAX(adv_spawning.statistics.step.last,
											adv_spawning.statistics.step.max)

	adv_spawning.statistics.step.min = adv_spawning.MIN(adv_spawning.statistics.step.last,
											adv_spawning.statistics.step.min)

	adv_spawning.statistics.session.steps =
		adv_spawning.statistics.session.steps + 1

	adv_spawning.statistics.load.cur =
		adv_spawning.statistics.step.last/(dtime*1000)

	adv_spawning.statistics.load.max = adv_spawning.MAX(adv_spawning.statistics.load.cur,
											adv_spawning.statistics.load.max)

	adv_spawning.statistics.load.min = adv_spawning.MIN(adv_spawning.statistics.load.cur,
											adv_spawning.statistics.load.min)

	adv_spawning.statistics.load.avg =
		(	(adv_spawning.statistics.load.avg *
			(adv_spawning.statistics.session.steps-1)) +
			adv_spawning.statistics.load.cur) /
			adv_spawning.statistics.session.steps
			
	if core.is_yes(
			core.setting_get("adv_spawning_validate_spawners")) then
		
			adv_spawning.spawner_validation_delta =
					adv_spawning.spawner_validation_delta + dtime
					
			if adv_spawning.spawner_validation_delta >
					adv_spawning.spawner_validation_interval then
				
				if adv_spawning.quota_enter() then
					local playerlist = core.get_connected_players()
					
					for k,v in ipairs(playerlist) do
						if not adv_spawning.time_over(10) then
							adv_spawning.refresh_spawners(v:getpos())
						else
							break
						end
					end
					
					adv_spawning.spawner_validation_delta = 0
				
				end
			end
	end

	--reduce following quota by overtime from last step
	if adv_spawning.quota_left < 0 then
		adv_spawning.quota_left =
			adv_spawning.MAX(0,adv_spawning.quota_left + adv_spawning.quota_reload)
	else
		adv_spawning.quota_left = adv_spawning.quota_reload
	end

	if adv_spawning.quota_enter() then
		adv_spawning.handle_mapgen_spawning()
		if not adv_spawning.quota_leave() then
			adv_spawning.dbg_log(2, "globalstep took to long")
		end
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] quota_enter
-- @param force ignore quota but start calculation
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.quota_enter(force)
	--ONLY enable this one if you're quite sure there aren't bugs in
	--assert(adv_spawning.quota_starttime == nil)
	local retval = false
	
	if adv_spawning.quota_left <= 0 then
	
		if force == true then
			if adv_spawning.quota_left < -10 then
				adv_spawning.dbg_log(1, "Quota: task is too important to skip do it anyway," ..
					" quota already passed by: " ..
					string.format("%.2f ms",adv_spawning.quota_left))
			end
			retval = true
		else
			if adv_spawning.quota_left * -2 > adv_spawning.quota_reload then
				adv_spawning.dbg_log(1, "Quota: no time left: " ..
					string.format("%.2f ms",adv_spawning.quota_left))
			end
		end
	else
		retval = true
	end
--	print("+++++++++++++++++Quota enter+++++++++++++++++++++")
--	print(debug.traceback())
--	print("+++++++++++++++++++++++++++++++++++++++++++++++++")
	if retval then
		adv_spawning.quota_starttime = adv_spawning.gettime()
	end
	
	return retval
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] time_over
-- @param minimum minimal value required to be left
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.time_over(minimum)
	assert(adv_spawning.quota_starttime ~= nil)
--	if adv_spawning.quota_starttime == nil then
--		return
--	end

	if minimum == nil then
		minimum = 0
	end

	local now = adv_spawning.gettime()

	local time_passed = now - adv_spawning.quota_starttime
	
	if (time_passed < 0) then
		if adv_spawning.timebackwardwarning ~= true then
			core.log("error", "ADV_SPAWNING: Error either there's a bug in time"
				.." calculation\n or your time just went backwards: old timestamp: "
				.. adv_spawning.quota_starttime .. " current_time: " .. now .. "\n")
			adv_spawning.timebackwardwarning = true
			
		end
		return true
	end

	return (adv_spawning.quota_left - time_passed) < minimum
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] quota_leave
--------------------------------------------------------------------------------
function adv_spawning.quota_leave()
	--assert(adv_spawning.quota_starttime ~= nil)
	if adv_spawning.quota_starttime == nil then
		return
	end

	local now = adv_spawning.gettime()

	local time_passed = now - adv_spawning.quota_starttime

	if (time_passed < 0) then
		if adv_spawning.timebackwardwarning ~= true then
			core.log("error", "ADV_SPAWNING: Error either there's a bug in time"
				.." calculation\n or your time just went backwards: old timestamp: "
				.. adv_spawning.quota_starttime .. " current_time: " .. now .. "\n")
			adv_spawning.timebackwardwarning = true
		end
	else
		adv_spawning.quota_left = adv_spawning.quota_left - time_passed
	end
	
	if (adv_spawning.quota_left < -adv_spawning.quota_reload) then
		adv_spawning.dbg_log(1, "excessive overtime, quota remaining: " .. adv_spawning.quota_left)
		return false
	end
	
	adv_spawning.quota_starttime = nil
	--print("-----------------Quota leave----------------------")
	return true
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] handlespawner
-- @param spawnername unique name of spawner
-- @param spawnerpos position of spawner
-- @param minp (OPTIONAL) override spawner defaults
-- @param maxp (OPTIONAL) override spawner defaults
-- @param ignore_active_area set to true for mapgen spawning
-- @return successfull true/false, permanent_error true,false, reason_string
--------------------------------------------------------------------------------
function adv_spawning.handlespawner(spawnername,spawnerpos,minp,maxp,ignore_active_area)

	local permanent_error = false
	local spawndef = adv_spawning.spawner_definitions[spawnername]

	if not adv_spawning.check_daytime(spawndef.daytimes) then
		adv_spawning.log("info","didn't meet daytime check")
		return false,nil, "daytimecheck failed"
	end

	local max_x = spawnerpos.x + adv_spawning.spawner_distance/2
	local min_x = spawnerpos.x - adv_spawning.spawner_distance/2

	local max_z = spawnerpos.z + adv_spawning.spawner_distance/2
	local min_z = spawnerpos.z - adv_spawning.spawner_distance/2

	local upper_y = spawnerpos.y + adv_spawning.spawner_distance/2
	local lower_y = spawnerpos.y - adv_spawning.spawner_distance/2

	if minp ~= nil then
		min_x = minp.x
		min_z = minp.z
		lower_y = minp.y
	end

	if maxp ~= nil then
		max_x = maxp.x
		max_z = maxp.z
		upper_y = maxp.y
	end

	--get random pos
	local new_pos = {}

	new_pos.x = math.random(min_x,max_x)
	new_pos.z = math.random(min_z,max_z)

	local yreason = "ukn"

	--check if entity is configured to spawn at surface
	if spawndef.relative_height == nil or
		(spawndef.relative_height.max ~= nil and
			spawndef.relative_height.max <= 1) then
		new_pos.y, yreason = adv_spawning.get_surface(lower_y,upper_y,new_pos,
							spawndef.spawn_inside)
	else
		if spawndef.spawn_inside == nil then
			print("ERROR: " .. spawnername .. " tries to spawn within nil")
			assert(false)
		end
		new_pos.y, yreason = adv_spawning.get_relative_pos(lower_y,upper_y,new_pos,
							spawndef.spawn_inside,
							spawndef.relative_height,
							spawndef.absolute_height)
	end

	--check if we did found a position within relative range
	if new_pos.y == nil then
		new_pos.y="?"
		adv_spawning.log("info",
			minetest.pos_to_string(new_pos) .. " didn't find a suitable y pos "
			.. lower_y .. "<-->" .. upper_y )
		return false, nil, "didn't find a valid ypos at " .. minetest.pos_to_string(new_pos)
				    .. " " .. lower_y .. "<-->" .. upper_y .. " rsn: " .. yreason
	end

	--check absolute height
	local abs_height_retval, abs_height_rsn = adv_spawning.check_absolute_height(new_pos,spawndef.absolute_height)
	if not abs_height_retval then
		adv_spawning.log("info",
			minetest.pos_to_string(new_pos) .. " didn't meet absolute height check")
		return false, true, "absolute height check failed rsn: " .. abs_height_rsn
	end

	--check active area
	if not ignore_active_area and not adv_spawning.check_active_block(new_pos) then
		adv_spawning.log("info",
			minetest.pos_to_string(new_pos) .. " didn't meet active area check")
		return false, nil , "area check failed"
	end

	--check surface
	--NOTE needs to be done before collision box check as y pos may be modified there
	if not adv_spawning.check_surface(new_pos,
										spawndef.surfaces,
										spawndef.relative_height,
										spawndef.spawn_inside) then
		adv_spawning.log("info",
			minetest.pos_to_string(new_pos) ..
			" didn't meet surface check, is: " ..
			minetest.get_node({x=new_pos.x,z=new_pos.z,y=new_pos.y-1}).name)
		return false, nil, "surface check failed"
	end

	--flat area check
	--NOTE needs to be done before collision box check as y pos may be modified there
	if not adv_spawning.check_flat_area(new_pos,
								spawndef.flat_area,
								spawndef.spawn_inside,
								spawndef.surfaces) then
		adv_spawning.log("info",
			minetest.pos_to_string(new_pos) .. " didn't meet flat area check")
		return false, nil, "flat area check failed"
	end

	--check collisionbox
	local checkresult,y_pos =
		adv_spawning.check_collisionbox(new_pos,
						spawndef.collisionbox,spawndef.spawn_inside)

	if checkresult and y_pos ~= nil then
		new_pos.y = y_pos
	end

	if not checkresult then
		adv_spawning.log("info",
			minetest.pos_to_string(new_pos) .. " didn't meet collisionbox check")
		return false, nil, "collision box check failed"
	end

	--check entities around
	if not adv_spawning.check_entities_around(new_pos,spawndef.entities_around) then
		adv_spawning.log("info",
			minetest.pos_to_string(new_pos) .. " didn't meet entities check")
		return false, nil, "entitie around check failed"
	end

	--check nodes around
	if not adv_spawning.check_nodes_around(new_pos,spawndef.nodes_around) then
		adv_spawning.log("info",
			minetest.pos_to_string(new_pos) .. " didn't meet nodes check")
		return false, nil, "nodes around check failed"
	end

	--check light around
	if not adv_spawning.check_light_around(new_pos,spawndef.light_around) then
		adv_spawning.log("info",
			minetest.pos_to_string(new_pos) .. " didn't meet light  check")
		return false, nil, "light check failed"
	end

--  ONLY use this if you have luajit
--	--check light around
--	if not adv_spawning.check_light_around_voxel(new_pos,spawndef.light_around) then
--		adv_spawning.log("info",
--			minetest.pos_to_string(new_pos) .. " didn't meet light  check")
--		return false, nil, "luajit light check failed"
--	end

	--check humidity
	if not adv_spawning.check_humidity_around(new_pos,spawndef.humidity_around) then
		adv_spawning.log("info",
			minetest.pos_to_string(new_pos) .. " didn't meet humidity check")
		return false, nil, "humidity check failed"
	end

	--check temperature
	if not adv_spawning.check_temperature_around(new_pos,spawndef.temperature_around) then
		adv_spawning.log("info",
			minetest.pos_to_string(new_pos) .. " didn't meet temperature check")
		return false, nil, "temperature check failed"
	end

	--custom check
	if (spawndef.custom_check ~= nil and
		type(spawndef.custom_check) == "function") then
	  
		local retval, reason = spawndef.custom_check(new_pos,spawndef)
		
		if not reason then
			reason = "custom check failed"
		end

		if not retval then
			adv_spawning.log("info",
				minetest.pos_to_string(new_pos) .. " didn't meet custom check")
			return false, nil, reason
		end
	end

	--do spawn
	--print("Now spawning: " .. spawndef.spawnee .. " at " ..
	--	minetest.pos_to_string(new_pos))

	if type(spawndef.spawnee) == "function" then
		spawndef.spawnee(new_pos)
	else
		minetest.add_entity(new_pos,spawndef.spawnee)
	end

	adv_spawning.statistics.session.entities_created =
			adv_spawning.statistics.session.entities_created +1
	return true
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] get_surface
-- @param y_min minumum relevant y pos
-- @param y_max maximum relevant y pos
-- @param new_pos position to spawn at
-- @param spawn_inside nodes to spawn at
-- @return y-value of last spawnable node
--------------------------------------------------------------------------------
function adv_spawning.get_surface(y_min,y_max,new_pos,spawn_inside)

	local top_pos = { x=new_pos.x, z=new_pos.z, y=y_max}
	local bottom_pos = { x=new_pos.x, z=new_pos.z, y=y_min}

	-- get list of all nodes within our y-range we could spawn within
	local spawnable_nodes =
		minetest.find_nodes_in_area(bottom_pos, top_pos, spawn_inside)

	-- if there ain't a single node to spawn within get out of here
	if #spawnable_nodes == 0 then
		return nil, "no spawnable nodes at all"
	end

	local spawnable_node_passed = false

	-- loop from topmost position to bottom
	for i=y_max, y_min, -1 do
		-- get current position
		local pos = { x=new_pos.x,z=new_pos.z,y=i}
		
		-- if the node at current position ain't one of those we can spawn within
		if not adv_spawning.contains_pos(spawnable_nodes,pos) then
			
			-- get more information about this node
			local node = minetest.get_node(pos)
			
			local text = "false"
			
			if spawnable_node_passed then
			   text = "true"
			end

			-- if node ain't unloaded and we did already see a spawnable node above
			-- return position above as pos to spawn
			if node.name ~= "ignore" and
				spawnable_node_passed then
				return i+1, "pos found"
			end
		else
			-- set marker about having seen a spawnable node above
			spawnable_node_passed = true
		end
	end

	return nil, "no matching node, nodecnt: " ..  #spawnable_nodes
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] get_relative_pos
-- @param y_min minumum relevant y pos
-- @param y_max maximum relevant y pos
-- @param new_pos position to spawn at
-- @param spawn_inside nodes to spawn at
-- @param relative_height
-- @param absolute_height
-- @return y-value of last spawnable node
--------------------------------------------------------------------------------
function adv_spawning.get_relative_pos(y_min,y_max,new_pos,spawn_inside,relative_height,absolute_height)
	local y_val = adv_spawning.get_surface(y_min,y_max,new_pos,spawn_inside)

	if y_val == nil then
		if (relative_height.min ~= nil or
			relative_height.max ~= nil) then
			return nil, "y_pos not witing range of " 
				.. relative_height.min .. "<-->" .. relative_height.max
		else
			y_val = y_min
		end
	end

	local top_pos = { x=new_pos.x, z=new_pos.z, y=y_max}
	local bottom_pos = { x=new_pos.x, z=new_pos.z, y=y_val}

	if relative_height ~= nil then
		if relative_height.min ~= nil then
			bottom_pos.y = y_val + relative_height.min
		end

		if relative_height.max ~= nil then
			top_pos.y = y_val + relative_height.max
		end
	end

	top_pos.y = adv_spawning.MIN(absolute_height.max,top_pos.y)
	bottom_pos.y = adv_spawning.MAX(absolute_height.min,bottom_pos.y)

	if top_pos.y < bottom_pos.y then
		--print("Invalid interval: " .. bottom_pos.y .. "<-->" .. top_pos.y)
		return nil, "invalid interval: " .. bottom_pos.y .. "<-->" .. top_pos.y
	end

	local spawnable_nodes =
		minetest.find_nodes_in_area(bottom_pos, top_pos, spawn_inside)

	if #spawnable_nodes > 0 then
		return spawnable_nodes[math.random(1,#spawnable_nodes)].y, "rpos found"
	else
		--print("no suitable nodes" .. bottom_pos.y .. "<-->" .. top_pos.y)
		return nil, "no spawnable nodes found around"
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] contains_pos
-- @param pos_list table containing positions
-- @param pos a position to search
-- @param remove if this is set to true a position is removed on match
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.contains_pos(pos_list,pos,remove)

	for i=1,#pos_list,1 do
		if pos_list[i].x == pos.x and
			pos_list[i].z == pos.z and
			pos_list[i].y == pos.y then

			if remove then
				table.remove(pos_list,i)
			end
			return true
	end
	end
	return false
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] check_absolute_height
-- @param pos to verify
-- @param absolute_height configuration for absolute height check
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.check_absolute_height(pos,absolute_height)
	if absolute_height == nil then
		return true, "no height limit"
	end

	if absolute_height.min ~= nil and
		pos.y < absolute_height.min then
		return false, pos.y .. " < " .. absolute_height.min
	end

	if absolute_height.max ~= nil and
		pos.y > absolute_height.max then
		return false, pos.y .. " > " .. absolute_height.max
	end

	return true, "height ok"
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] check_surface
-- @param pos to verify
-- @param surface configuration
-- @param relative_height required to check for non ground bound spawning
-- @param spawn_inside nodes to spawn inside
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.check_surface(pos,surfaces,relative_height,spawn_inside)

	if surfaces == nil then
		return true
	end

	if relative_height == nil or (
		relative_height.max ~= nil and
		relative_height.max <= 1) then

		local lower_pos = {x=pos.x, y= pos.y-1, z=pos.z}

		local node_below = minetest.get_node(lower_pos)

		return adv_spawning.contains(surfaces,node_below.name)
	else
		local ymin = pos.y-relative_height.max-1
		local ymax = pos.y+relative_height.max
		local surface = adv_spawning.get_surface(ymin, ymax, pos, spawn_inside)
		if surface == nil then
			return false
		else
			local lower_pos = {x=pos.x, y= surface-1, z=pos.z}

			local node_below = minetest.get_node(lower_pos)

			return adv_spawning.contains(surfaces,node_below.name)
		end
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] contains
-- @param table_to_check
-- @param value
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.contains(table_to_check,value)
	for i=1,#table_to_check,1 do
		if table_to_check[i] == value then
			return true
		end
	end
	return false
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] check_daytimes
-- @param table_to_check
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.check_daytime(daytimedefs)
	if daytimedefs == nil then
		return true
	end

	local current_time = minetest.get_timeofday()
	local match = false

	for i=1,#daytimedefs,1 do
		if daytimedefs[i].begin ~= nil and
			daytimedefs[i].stop ~= nil then

			if current_time < daytimedefs[i].stop and
				current_time > daytimedefs[i].begin then
				match = true
			end
			break
		end

		if daytimedefs[i].begin ~= nil and
			current_time > daytimedefs[i].begin then
			match = true
			break
		end

		if daytimedefs[i].stop ~= nil and
			current_time < daytimedefs[i].stop then
			match = true
			break
		end
	end

	return match
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] check_nodes_around
-- @param pos position to validate
-- @param nodes_around node around definitions
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.check_nodes_around(pos,nodes_around)

	if nodes_around == nil then
		return true
	end

	for i=1,#nodes_around,1 do
		--first handle special cases 0 and 1 in a quick way
		if  (nodes_around[i].threshold == 1 and nodes_around[i].type == "MIN") or
			(nodes_around[i].threshold == 0 and nodes_around[i].type == "MAX")then

			local found =
				minetest.find_node_near(pos,nodes_around[i].distance,
										nodes_around[i].name)

			if nodes_around[i].type == "MIN" then
				if found == nil then
					--print("not enough: " .. dump(nodes_around[i].name) .. " around")
					return false
				end
			else
				if found ~= nil then
					--print("to many: " .. dump(nodes_around[i].name) .. " around " .. dump(found))
					return false
				end
			end
		else
			--need to do the full blown check
			local found_nodes = minetest.find_nodes_in_area(
										{   x=pos.x-nodes_around[i].distance,
											y=pos.y-nodes_around[i].distance,
											z=pos.z-nodes_around[i].distance},
										{   x=pos.x+nodes_around[i].distance,
											y=pos.y+nodes_around[i].distance,
											z=pos.z+nodes_around[i].distance},
										nodes_around[i].name)

			if nodes_around[i].type == "MIN" and
				#found_nodes < nodes_around[i].threshold then
				--print("Found MIN: " .. dump(nodes_around[i].name) ..
				--	"\n at locations: " .. dump(found_nodes))
				--print ("Only " .. #found_nodes .. "/" .. nodes_around[i].threshold)
				return false
			end

			if nodes_around[i].type == "MAX" and
				#found_nodes > nodes_around[i].threshold then
				--print("Found MAX: " .. dump(nodes_around[i].name) ..
				--	"\n at locations: " .. dump(found_nodes))
				return false
			end
		end
	end

	return true
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] check_entities_around
-- @param pos position to validate
-- @param entities_around entity around definitions
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.check_entities_around(pos,entities_around)
	if entities_around == nil then
		return true
	end

	for i=1,#entities_around,1 do
		local entity_in_range =
			minetest.get_objects_inside_radius(pos, entities_around[i].distance)

		if entities_around[i].entityname == nil then
			if entities_around[i].type == "MIN" and
				#entity_in_range < entities_around[i].threshold then
				return false
			end

			if entities_around[i].type == "MAX" and
				#entity_in_range > entities_around[i].threshold then
				return false
			end
		end

		local count = 0

		for j=1,#entity_in_range,1 do
			local entity = entity_in_range[j]:get_luaentity()

			if entity ~= nil then
				if entity.name == entities_around[i].entityname then
					count = count +1
				end

				if count > entities_around[i].threshold then
					break
				end
			end
		end

		if entities_around[i].type == "MIN" and
			count < entities_around[i].threshold then
			return false
		end

		if entities_around[i].type == "MAX" and
			count > entities_around[i].threshold then
			return false
		end
	end

	return true
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] check_light_around
-- @param pos position to validate
-- @param light_around light around definitions
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.check_light_around(pos,light_around)
	if light_around == nil then
		return true
	end

	for i=1,#light_around,1 do

		for x=pos.x-light_around[i].distance,pos.x+light_around[i].distance,1 do
		for y=pos.y-light_around[i].distance,pos.y+light_around[i].distance,1 do
		for x=pos.z-light_around[i].distance,pos.z+light_around[i].distance,1 do
			local checkpos = { x=x,y=y,z=z}
			local time = minetest.get_timeofday()
			if light_around[i].type == "TIMED_MIN" or
				light_around[i].type == "TIMED_MAX" then
				time = light_around[i].time
			end

			if light_around[i].type == "OVERALL_MIN" or
				light_around[i].type == "OVERALL_MAX" then

				for j=0,24000,1000 do
					local light_level = minetest.get_node_light(checkpos, j)

					if light_level ~= nil then
						if light_around[i].type == "OVERALL_MAX" and
							light_level > light_around[i].threshold then
							return false
						end

						if light_around[i].type == "OVERALL_MIN" and
							light_level < light_around[i].threshold then
							return false
						end
					end
				end

			else
				local light_level = minetest.get_node_light(checkpos, time)

				if light_level ~= nil then
					if (light_around[i].type == "TIMED_MIN" or
						light_around[i].type == "CURRENT_MIN") and
						light_level < light_around[i].threshold then
							return false
					end

					if (light_around[i].type == "TIMED_MAX" or
						light_around[i].type == "CURRENT_MAX") and
						light_level > light_around[i].threshold then
							return false
					end
				end
			end
		end
		end
		end
	end

	return true
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] check_light_around_voxel
-- @param pos position to validate
-- @param light_around light around definitions
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.check_light_around_voxel(pos,light_around)
	if light_around == nil then
		return true
	end

	local maxdistance = 0

	for i=1,#light_around,1 do
		maxdistance = adv_spawning.MAX(maxdistance,light_around[i].distance)
	end

	-- voxelmanip is of no use for low counts of nodes
	if maxdistance <=10 then
		return adv_spawning.check_light_around(pos,light_around)
	end

	local minp = { x=math.floor(pos.x - maxdistance),
					y=math.floor(pos.y - maxdistance),
					z=math.floor(pos.z - maxdistance)}
	local maxp = { x=math.ceil(pos.x + maxdistance),
					y=math.ceil(pos.y + maxdistance),
					z=math.ceil(pos.z + maxdistance)}

	local voxeldata = minetest.get_voxel_manip()
	local got_minp,got_maxp = voxeldata:read_from_map(minp,maxp)

	local voxel_light_data = voxeldata:get_light_data()
	local node_data = voxeldata:get_data()
	local voxelhelper = VoxelArea:new({MinEdge=got_minp,MaxEdge=got_maxp})


	for i=1,#light_around,1 do

		for x=pos.x-light_around[i].distance,pos.x+light_around[i].distance,1 do
		for y=pos.y-light_around[i].distance,pos.y+light_around[i].distance,1 do
		for z=pos.z-light_around[i].distance,pos.z+light_around[i].distance,1 do
			local checkpos = { x=x,y=y,z=z}
			local time = minetest.get_timeofday()
			if light_around[i].type == "TIMED_MIN" or
				light_around[i].type == "TIMED_MAX" then
				time = light_around[i].time
			end

			if light_around[i].type == "OVERALL_MIN" or
				light_around[i].type == "OVERALL_MAX" then

				for j=0,24000,1000 do
					local light_level =
						adv_spawning.voxelmaniplight(node_data,
														voxel_light_data,
														voxelhelper,
														checkpos,j)

					if light_level ~= nil then
						if light_around[i].type == "OVERALL_MAX" and
							light_level > light_around[i].threshold then
							return false
						end

						if light_around[i].type == "OVERALL_MIN" and
							light_level < light_around[i].threshold then
							return false
						end
					end
				end

			else
				local light_level =
						adv_spawning.voxelmaniplight(node_data,
														voxel_light_data,
														voxelhelper,
														checkpos,time)

				if light_level ~= nil then
					if (light_around[i].type == "TIMED_MIN" or
						light_around[i].type == "CURRENT_MIN") and
						light_level < light_around[i].threshold then
							return false
					end

					if (light_around[i].type == "TIMED_MAX" or
						light_around[i].type == "CURRENT_MAX") and
						light_level > light_around[i].threshold then
							return false
					end
				end
			end
		end
		end
		end
	end

	return true
end

local light_lookup = {
		{4250+125, 150},
		{4500+125, 150},
		{4750+125, 250},
		{5000+125, 350},
		{5250+125, 500},
		{5500+125, 675},
		{5750+125, 875},
		{6000+125, 1000},
		{6250+125, 1000}
	}

function adv_spawning.day_night_ratio(time)

	--make sure time is between 0 and 240000
	if time < 0 then
		time = time - (((time*-1)/24000)*24000)
	end
	if time > 24000 then
		time = time + ((time/24000)*24000)
	end

	--invert time for sunset
	if time > 12000 then
		time = 24000 - time
	end

	local dnr = 1000

	for i=1,#light_lookup,1 do
		if time < light_lookup[i][1] then
			dnr = light_lookup[i][2]
			break
		end
	end

	return dnr
end

function adv_spawning.voxelmaniplight(node_data,light_data,area,pos,time)

	if not area:containsp(pos) then
		return minetest.get_node_light(pos, time)
	end

	pos = vector.round(pos)
	local index = area:indexp(pos)

	local raw_light_value = light_data[index]

	if raw_light_value == nil then
		return nil
	end

	local light_day   = nil
	local light_night = nil

	--read node information
	local content_id = node_data[index]
	local nodename = minetest.get_name_from_content_id(content_id)
	local nodedef = minetest.registered_nodes[nodename]

	-- check for solid node
	if nodedef.paramtype ~= "light" then
		light_day = 0
		light_night = 0
	else
		light_day   = raw_light_value % 16
		light_night = (raw_light_value - light_day)/16
	end

	--check lightsource
	if nodedef.light_source ~= nil then
		light_day = adv_spawning.MAX(nodedef.light_source,light_day)
		light_night = adv_spawning.MAX(nodedef.light_source,light_night)
	end

	time = time *24000
	time = time %24000

	local dnr = adv_spawning.day_night_ratio(time)

	local c = 1000
	local current_light = ((dnr * light_day + (c-dnr) * light_night))/c
	if(current_light > LIGHT_MAX+1) then
		current_light = LIGHT_MAX+1
	end

	return math.floor(current_light)
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] check_temperature_around
-- @param pos position to validate
-- @param temperature_around temperature around definitions
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.check_temperature_around(pos,temperature_around)
	if temperature_around == nil then
		return true
	end

	--TODO
	return true
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] check_humidity_around
-- @param pos position to validate
-- @param humidity_around humidity around definitions
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.check_humidity_around(pos,humidity_around)
	if humidity_around == nil then
		return true
	end
	--TODO
	return true
end
--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] check_flat_area
-- @param pos position to validate
-- @param range to check for same height
-- @param deviation maximum nmber of nodes not matching flat check
-- @param spawn_inside nodes to spawn inside
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.check_flat_area(new_pos,flat_area,spawn_inside,surfaces)

	if flat_area == nil then
		return true
	end

	local range = flat_area.range

	local back_left = {x=new_pos.x-range,y=new_pos.y-1,z=new_pos.z-range}
	local front_right = { x=new_pos.x+range,y=new_pos.y-1,z=new_pos.z+range}

	local current_deviation = 0

	if flat_area.deviation ~= nil then
		current_deviation = flat_area.deviation
	end

	local required_nodes = (range*2+1)*(range*2+1) - current_deviation

	if surfaces == nil then
		local ground_nodes =
			minetest.find_nodes_in_area(back_left, front_right, spawn_inside)

		if #ground_nodes > current_deviation then
			adv_spawning.log("info","check_flat_area: " .. range .. " "
				..dump(current_deviation).. " " .. #ground_nodes )
			--adv_spawning.dump_area({x=back_left.x,y=new_pos.y-1,z=back_left.z},
			--						front_right)
			return false
		end
	else
		local ground_nodes =
			minetest.find_nodes_in_area(back_left, front_right, surfaces)

		if #ground_nodes < required_nodes then
			adv_spawning.log("info","check_flat_area: " .. range .. " " ..
				dump(current_deviation).. " " .. #ground_nodes )
			--adv_spawning.dump_area({x=back_left.x,y=new_pos.y-1,z=back_left.z},
			--						front_right)
			return false
		end
	end

	back_left.y = new_pos.y
	front_right.y = new_pos.y

	local inside_nodes =
		minetest.find_nodes_in_area(back_left, front_right, spawn_inside)

	if #inside_nodes < required_nodes then
		adv_spawning.log("info","check_flat_area: " .. range .. " " ..
			dump(current_deviation) .. " "
			.. #inside_nodes .. "/" .. required_nodes)
		--adv_spawning.dump_area({x=back_left.x,y=new_pos.y-1,z=back_left.z},
		--						front_right)
		return false
	end

	return true
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] log
-- @param level
-- @param text
--------------------------------------------------------------------------------
function adv_spawning.log(level,text)
	local is_debug = false

	if not is_debug then
		return
	end
	print("ADV_SPAWNING:" .. text)
	minetest.log(level,text)
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] check_collisionbox
-- @param pos position to check
-- @param collisionbox collisionbox to use
-- @param spawn_inside nodes to spawn inside
--------------------------------------------------------------------------------
function adv_spawning.check_collisionbox(pos,collisionbox,spawn_inside)
	if collisionbox == nil then
		return true,nil
	end

	--skip for collisionboxes smaller then a single node
	if collisionbox[1] >= -0.5 and collisionbox[2] >= -0.5 and collisionbox[3] >= -0.5 and
		collisionbox[4] <= 0.5 and collisionbox[5] <= 0.5 and collisionbox[6] <= 0.5 then
		return true,nil
	end

	--lets do the more complex checks
	--first check if we need to move up
	if collisionbox[2] < -0.5 then
		pos.y = pos.y + (collisionbox[2]*-1) - 0.45
	end

	local minp = {
				x=pos.x+collisionbox[1],
				y=pos.y+collisionbox[2],
				z=pos.z+collisionbox[3]
				}
	local maxp = {
				x=pos.x+collisionbox[4],
				y=pos.y+collisionbox[5],
				z=pos.z+collisionbox[6]
				}

	local lastpos = nil

	for y=minp.y,maxp.y,1 do
	for z=minp.z,maxp.z,1 do
	for x=minp.x,maxp.x,1 do
		local checkpos = {x=x,y=y,z=z}
		if not adv_spawning.is_same_pos(checkpos,lastpos) then
			local node = minetest.get_node(checkpos)

			if not adv_spawning.contains(spawn_inside,node.name) then
				adv_spawning.log("info","Failed collision box check: " ..
						minetest.pos_to_string(pos) .. " "
						.. dump(node.name) .. " at ".. minetest.pos_to_string(checkpos))
				--adv_spawning.dump_area()
				return false,nil
			end

			lastpos = checkpos
		end
	end
	end
	end

	return true,pos.y
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] check_active_block
-- @param pos position to check
-- @param collisionbox collisionbox to use
-- @param spawn_inside nodes to spawn inside
--------------------------------------------------------------------------------
function adv_spawning.check_active_block(pos)
	local players = minetest.get_connected_players()

	for i=1,#players,1 do
		if vector.distance(pos,players[i]:getpos()) < adv_spawning.active_range then
			return true
		end
	end

	return false
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] is_same_pos
-- @param pos1 first for comparison
-- @param pos2 second position for comparison
--------------------------------------------------------------------------------
function adv_spawning.is_same_pos(pos1,pos2)
	if pos1 == nil or pos2 == nil then
		return false
	end

	if pos1.x ~= pos2.x or
		pos1.y ~= pos2.y or
		pos1.z ~= pos2.z then
		return false
	end

	return true
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] handle_mapgen_spawning
--------------------------------------------------------------------------------
function adv_spawning.handle_mapgen_spawning()
	local continue = false
	while(not continue and #adv_spawning.mapgen_jobqueue > 0) do
		local toprocess = adv_spawning.mapgen_jobqueue[1]
		table.remove(adv_spawning.mapgen_jobqueue,1)

		--print("Processing job: " .. dump(toprocess) .. " no_quota: " ..
		--			dump(adv_spawning.time_over(10)))

		local tries = 0

		while ( toprocess.retries > 0 and
				toprocess.spawntotal > 0 and
				tries < adv_spawning.max_mapgen_tries_per_step and
				(not adv_spawning.time_over(10)) )do

			local single_spawn_check = adv_spawning.gettime()

			local retval,permanent_error = adv_spawning.handlespawner(toprocess.spawner,
											{x=0,y=0,z=0},
											toprocess.minp,
											toprocess.maxp,
											true)
			
			local delta = adv_spawning.gettime() - adv_spawning.quota_starttime

			if retval then
				toprocess.spawntotal = toprocess.spawntotal -1
			end

			if permanent_error then
				toprocess.retries = 0
			end

			toprocess.retries = toprocess.retries -1
			tries = tries +1
		end

		if toprocess.retries > 0 then
			if toprocess.spawntotal > 0 then
				table.insert(adv_spawning.mapgen_jobqueue,toprocess)
			end
			continue = true
		end
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] queue_mapgen_jobs
-- @param minp
-- @param maxp
--------------------------------------------------------------------------------
function adv_spawning.queue_mapgen_jobs(minp,maxp)
	for key,value in pairs(adv_spawning.spawner_definitions) do
		local continue = false

		--check if cyclic spawning is enabled
		if not continue and
			(value.mapgen == nil or
			value.mapgen.enabled == false) then
			continue = true
		end


		if not continue then
			table.insert(adv_spawning.mapgen_jobqueue,
				{
					minp = minp,
					maxp = maxp,
					spawner = key,
					retries = value.mapgen.retries,
					spawntotal = value.mapgen.spawntotal
				})
		end
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] dump_area
-- @param minp
-- @param maxp
--------------------------------------------------------------------------------
function adv_spawning.dump_area(minp,maxp)
	print("Dumping: " .. dump(minp) .. "<-->" .. dump(maxp))
	for y=minp.y,maxp.y,1 do
	print("--- ypos: " .. y .. " --------------------------------------------------------------")
	for z=minp.z,maxp.z,1 do
	local line = ""
	for x=minp.x,maxp.x,1 do
		local node = minetest.get_node({x=x,y=y,z=z})

		local toprint = node.name

		if toprint:find(":") ~= nil then
			toprint = toprint:sub(toprint:find(":")+1)
		end

		line = line .. string.format(" %15s |",toprint)
	end
		print(line)
	end
	print("")
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] check_time
-- @param starttime time since when to check
-- @param checkid name of this check
--
-- @return current time for next check
--------------------------------------------------------------------------------
function adv_spawning.check_time(starttime, checkid)
	local currenttime = adv_spawning.gettime()
	local delta = currenttime - starttime
	
	if (delta > adv_spawning.quota_reload) then
		if adv_spawning.spawner_warned[checkid] ~= true then
			adv_spawning.dbg_log(1, "spawner " .. checkid ..
				"\n\texceeded more then full reload time on init (" .. delta .. " ms)." ..
				"\n\tFix it as it will cause major lag on mapgen!")
			adv_spawning.spawner_warned[checkid] = true
		end
	end
	
	return currenttime
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] dbg_log
-- @param loglevel level print it
-- @param message message to print
--------------------------------------------------------------------------------
function adv_spawning.dbg_log(loglevel, message)
	if (adv_spawning.loglevel >= loglevel ) then
		core.log("action", "ADV_SPAWNING: " .. message)
	end
end


--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] refresh_spawners
-- @param pos to refresh spawners around
--------------------------------------------------------------------------------
function adv_spawning.refresh_spawners(pos)

	local min = {x=pos.x-32, y=pos.y-32, z=pos.z-32}
	local max = {x=pos.x+32, y=pos.y+32, z=pos.z+32}

	local start_x =
		math.floor(min.x/adv_spawning.spawner_distance)
		* adv_spawning.spawner_distance
	local start_y =
		(math.floor(min.y/adv_spawning.spawner_distance)
			* adv_spawning.spawner_distance)
			+ adv_spawning.spawner_y_offset
	local start_z =
		math.floor(min.z/adv_spawning.spawner_distance)
		* adv_spawning.spawner_distance

	for x=start_x,max.x,adv_spawning.spawner_distance do
	for y=start_y,max.y,adv_spawning.spawner_distance do
	for z=start_z,max.z,adv_spawning.spawner_distance do
		if x > min.x and
			y > min.y and
			z > min.z then
			if not adv_spawning.quota_leave() then
				adv_spawning.dbg_log(2,
					"adv_spawning: refresh_spawners did use way too much time 1")
			end
			minetest.add_entity({x=x,y=y,z=z},"adv_spawning:spawn_seed")
			adv_spawning.quota_enter(true)
			adv_spawning.log("info", "adv_spawning: adding spawner entity at "
				.. core.pos_to_string({x=x,y=y,z=z}))
			adv_spawning.statistics.session.spawners_created =
				adv_spawning.statistics.session.spawners_created +1
		end
	end
	end
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] table_count
-- @param tocount table to get number of elements from
--------------------------------------------------------------------------------
function adv_spawning.table_count(tocount)
	local retval = 0
	for k,v in pairs(tocount) do
		retval = retval +1
	end
	
	return retval
end

function adv_spawning.build_shell(pos, d)
	local retval = {}
	
	-- build top face
	for x = -d , d , 1 do
		for z = -d, d, 1 do
			retval[#retval+1] =  { x = pos.x + x, y = pos.y + d, z = pos.z + z}
		end
	end
	
	-- build bottom face
	for x = -d , d , 1 do
		for z = -d, d, 1 do
			retval[#retval+1] =  { x = pos.x + x, y = pos.y -d, z = pos.z + z}
		end
	end
	
	-- build x- face
	for z = -d , d , 1 do
		for y = - (d -1) , (d -1), 1 do
			retval[#retval+1] =  { x = pos.x -d, y = pos.y + y, z = pos.z + z}
		end
	end
	
	-- build x+ face
	for z = -d , d , 1 do
		for y = - (d -1) , (d -1), 1 do
			retval[#retval+1] =  { x = pos.x + d, y = pos.y + y, z = pos.z + z}
		end
	end
	
	-- build z- face
	for x = - (d -1) , (d -1) , 1 do
		for y = - (d -1) , (d -1), 1 do
			retval[#retval+1] =  { x = pos.x + x, y = pos.y + y, z = pos.z - d}
		end
	end
	
	-- build z+ face
	for x = -(d -1) , (d -1) , 1 do
		for y = - (d -1) , (d -1), 1 do
			retval[#retval+1] =  { x = pos.x + x, y = pos.y + y, z = pos.z + d}
		end
	end
	
	return retval;
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] table_count
-- @param tocount table to get number of elements from
--------------------------------------------------------------------------------
function adv_spawning.find_nodes_in(pos, min_range, max_range, nodetypes)

	local nodetypes_to_use = nodetypes

	if type(nodetypes) == "string" then
		nodetypes_to_use = { }
		table.insert(nodetypes_to_use, nodetypes)
	end
	
	for i = min_range, max_range, 1 do
		local positions = adv_spawning.build_shell(pos, i)
		
		for i = 1, #positions, 1 do
			local node = minetest.get_node_or_nil(positions[i])
			
			if node ~= nil then
				for i = 1, #nodetypes_to_use, 1 do
					if node.name == nodetypes_to_use[i] then
						return positions[i]
					end
				end
			end
		end
	end
	
	return nil
end
