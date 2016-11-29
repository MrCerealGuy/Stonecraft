-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file sound.lua
--! @brief component containing sound related functions
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup grp_sound Sound subcomponent
--! @brief Component handling all sound related actions
--! @ingroup framework_int
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
mobf_assert_backtrace(not core.global_exists("sound"))

--! @class sound
--! @brief sound selection and play functions
--!@}
sound =  {}

-------------------------------------------------------------------------------
-- @function [parent=#sound] play(entity)
--
--! @brief play a sound at a specified position
--! @memberof sound
--
--! @param param1 position to play sound at or playername to play sound for
--! @param soundspec sound to play
-------------------------------------------------------------------------------
function sound.play(param1, soundspec)

	local pos = nil
	local playername = nil
	
	if type(param1) == "string" then
		playername = param1
	else
		pos = param1
	end

	if (soundspec ~= nil) then

		local toplay =  {
						gain = soundspec.gain,
						pos = pos,
						to_player = playername,
						max_hear_distance = soundspec.max_hear_distance,
						loop = false,
						}

		minetest.sound_play(soundspec.name,toplay)
	else
		dbg_mobf.sound_lvl2("MOBF: no soundspec")
		--todo add log entry
	end
end


-------------------------------------------------------------------------------
-- @function [parent=#sound] play_random(entity,now)
--
--! @brief play a random sound for mob
--! @memberof sound
--
--! @param entity mob to do action
--! @param now current time
-------------------------------------------------------------------------------
function sound.play_random(entity,now)

	if entity.dynamic_data == nil or
		entity.dynamic_data.sound == nil then
		mobf_bug_warning(LOGLEVEL_ERROR,
			"MOBF BUG!!!: >" ..entity.data.name .. "< removed=" ..
			dump(entity.removed) .. " entity=" .. tostring(entity) ..
			" sound callback without dynamic data")
		return
	end

	if entity.data.sound ~= nil and
		entity.data.sound.random ~= nil then


		-- check for old style random sound definition using chance + min_delta
		if entity.data.sound.random.min_delta ~= nil and
			entity.dynamic_data.sound.random_last
				+ entity.data.sound.random.min_delta > now then
			return
		end

		-- check for old style random sound definition using chance
		if entity.data.sound.random.chance ~= nil and
			math.random() > entity.data.sound.random.chance then
			return
		end
		
		-- check for new style sounds done by gauss distribution
		if entity.dynamic_data.sound.random_next ~= nil and
			entity.dynamic_data.sound.random_next > now then
			return
		end
		
		-- init variable to be passed to play
		local toplay = nil
		
		-- sound list mode
		if entity.data.sound.random.list ~= nil then
		
			-- select random sound from list
			local current_random_sound =
					math.floor(math.random(1,#entity.data.sound.random.list) + 0.5)
			toplay = entity.data.sound.random.list[current_random_sound]
			dbg_mobf.sound_lvl3("MOBF: selected random sound: " ..
				current_random_sound .. "/" .. #entity.data.sound.random.list)
		-- single sound mode
		elseif entity.data.sound.random.name ~= nil then
			toplay = entity.data.sound.random
		else
			dbg_mobf.sound_lvl1("MOBF: invalid random sound configuration")
		end
			
		if toplay ~= nil then
			sound.play(entity.object:getpos(),toplay)
			entity.dynamic_data.sound.random_last = now
			dbg_mobf.sound_lvl3("MOBF: playing sound: " .. toplay.name)
		end
		
		if entity.dynamic_data.sound.random_next ~= nil then
			if entity.data.sound.random.interval == nil or
				entity.data.sound.random.max_interval_deviation == nil then
				dbg_mobf.sound_lvl1("MOBF: invalid random sound configuration," ..
					" missing \"interval\" or \"max_interval_deviation\"")
				return
			end
			
			local delta_next = sound.calc_random_sound_delay(entity)
						
			dbg_mobf.sound_lvl1("MOBF: next random sound in: " .. delta_next .. "s")
			entity.dynamic_data.sound.random_next = now + delta_next
		else
			entity.dynamic_data.sound.random_last = now
		end
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#sound] sound.calc_random_sound_delay(entity)
--
--! @brief calculate delay for random sound
--! @memberof sound
--
--! @param entity mob to calc for
-------------------------------------------------------------------------------
function sound.calc_random_sound_delay(entity)

		local base_value = mobf_gauss(entity.data.sound.random.interval,
								entity.data.sound.random.max_interval_deviation/20)

		local delta_next = math.max(entity.data.sound.random.interval -
							entity.data.sound.random.max_interval_deviation,
							base_value)
		delta_next = math.min(delta_next,
							entity.data.sound.random.interval +
							entity.data.sound.random.max_interval_deviation)
							
		return delta_next
end

-------------------------------------------------------------------------------
-- @function [parent=#sound] sound.init_dynamic_data(entity, now)
--
--! @brief initialize all dynamic data for sound on activate
--! @memberof sound
--
--! @param entity mob to initialize
--! @param now current time
-------------------------------------------------------------------------------
function sound.init_dynamic_data(entity, now)
	local data = {
		random_last = now,
	}
	
	if entity.data.sound.random ~= nil and
		entity.data.sound.random.interval ~= nil and
		entity.data.sound.random.max_interval_deviation then

		local delta_next = sound.calc_random_sound_delay(entity)
								
		data.random_next = delta_next + now
		dbg_mobf.sound_lvl2("MOBF: initalizing random_next to: " .. delta_next
			.. " Interval: " .. entity.data.sound.random.interval .. " Deviation: "
			.. entity.data.sound.random.max_interval_deviation)
	elseif entity.data.sound.random ~= nil and
		entity.data.sound.random.chance == nil then
		dbg_mobf.sound_lvl1("MOBF: invalid random sound definition for \"" ..
			entity.data.name .. "\" ... neither invterval nor probability mode configured")
	end

	entity.dynamic_data.sound = data
end