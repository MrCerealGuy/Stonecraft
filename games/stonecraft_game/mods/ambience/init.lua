
ambience = {}

-- override default water sounds
minetest.override_item("default:water_source", { sounds = {} })
minetest.override_item("default:water_flowing", { sounds = {} })
minetest.override_item("default:river_water_source", { sounds = {} })
minetest.override_item("default:river_water_flowing", { sounds = {} })

-- settings
local SOUNDVOLUME = 1.0
local MUSICVOLUME = 1.0
local play_music = minetest.settings:get_bool("ambience_music") ~= false
local pplus = minetest.get_modpath("playerplus")
local radius = 6
local playing = {}
local sound_sets = {} -- all the sounds and their settings
local sound_set_order = {} -- needed because pairs loops randomly through tables
local set_nodes = {} -- all the nodes needed for sets


-- global functions

-- add set to list
ambience.add_set = function(set_name, def)

	if not set_name or not def then
		return
	end

	sound_sets[set_name] = {
		frequency = def.frequency or 50,
		sounds = def.sounds,
		sound_check = def.sound_check,
		nodes = def.nodes
	}

	-- add set name to the sound_set_order table
	local can_add = true

	for i = 1, #sound_set_order do

		if sound_set_order[i] == set_name then
			can_add = false
		end
	end

	if can_add then
		table.insert(sound_set_order, set_name)
	end

	-- add any missing nodes to the set_nodes table
	if def.nodes then

		for i = 1, #def.nodes do

			can_add = def.nodes[i]

			for j = 1, #set_nodes do

				if def.nodes[i] == set_nodes[j] then
					can_add = false
				end
			end

			if can_add then
				table.insert(set_nodes, can_add)
			end
		end
	end
end


-- return set from list using name
ambience.get_set = function(set_name)

	if sound_sets[set_name] then
		return sound_sets[set_name]
	end
end


-- remove set from list
ambience.del_set = function(set_name)

	sound_sets[set_name] = nil

	local can_del = false

	for i = 1, #sound_set_order do

		if sound_set_order[i] == set_name then
			can_del = i
		end
	end

	if can_del then
		table.remove(sound_set_order, can_del)
	end
end


-- plays music and selects sound set
local get_ambience = function(player, tod, name)

	-- play server or local music if available
	if play_music and playing[name] then

		-- play at midnight
		if tod >= 0.0 and tod <= 0.01 then

			if not playing[name].music then

				playing[name].music = minetest.sound_play("ambience_music", {
					to_player = player:get_player_name(),
					gain = MUSICVOLUME
				})
			end

		elseif tod > 0.1 and playing[name].music then

			playing[name].music = nil
		end
	end


	-- get foot and head level nodes at player position
	local pos = player:get_pos() ; if not pos then return end

	pos.y = pos.y + 1.4 -- head level

	local nod_head = pplus and name and playerplus[name].nod_head or
			minetest.get_node(pos).name

	pos.y = pos.y - 1.2 -- foot level

	local nod_feet = pplus and name and playerplus[name].nod_feet or
			minetest.get_node(pos).name

	pos.y = pos.y - 0.2 -- reset pos

	-- get all set nodes around player
	local ps, cn = minetest.find_nodes_in_area(
		{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
		{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, set_nodes)

	-- loop through sets in order and choose first that meets it's conditions
	for n = 1, #sound_set_order do

		local set = sound_sets[ sound_set_order[n] ]

		if set and set.sound_check then

			-- pass settings to function for condition check
			local set_name, gain = set.sound_check({
				player = player,
				pos = pos,
				tod = tod,
				totals = cn,
				positions = ps,
				head_node = nod_head,
				feet_node = nod_feet
			})

			-- if conditions met return set name and gain value
			if set_name then
				return set_name, gain
			end
		end
	end
end


local timer = 0
local random = math.random

-- players routine
minetest.register_globalstep(function(dtime)

	-- one second timer
	timer = timer + dtime
	if timer < 1 then return end
	timer = 0

	-- get list of players and set some variables
	local players = minetest.get_connected_players()
	local player_name, number, chance, ambience, handler, ok
	local tod = minetest.get_timeofday()

	-- loop through players
	for n = 1, #players do

		player_name = players[n]:get_player_name()

--local t1 = os.clock()

		local set_name, MORE_GAIN = get_ambience(players[n], tod, player_name)

--print(string.format("elapsed time: %.4f\n", os.clock() - t1))

		ok = true -- everything starts off ok

		-- are we playing something already?
		if playing[player_name]
		and playing[player_name].handler then

			-- stop current sound if another set active or gain changed
			if playing[player_name].set ~= set_name
			or playing[player_name].gain ~= MORE_GAIN then

--print ("-- change stop", set_name, playing[player_name].handler)

				minetest.sound_stop(playing[player_name].handler)

				playing[player_name].set = nil
				playing[player_name].handler = nil
				playing[player_name].gain = nil
			else
				ok = false -- sound set still playing, skip new sound
			end
		end

		-- set random chance
		chance = random(1, 1000)

		-- if chance is lower than set frequency then select set
		if ok and set_name and chance < sound_sets[set_name].frequency then

			-- choose random sound from set
			number = random(#sound_sets[set_name].sounds)
			ambience = sound_sets[set_name].sounds[number]

			-- play sound
			handler = minetest.sound_play(ambience.name, {
				to_player = player_name,
				gain = ((ambience.gain or 0.3) + (MORE_GAIN or 0)) * SOUNDVOLUME,
				pitch = ambience.pitch or 1.0
			}, ambience.ephemeral)

--print ("playing... " .. ambience.name .. " (" .. chance .. " < "
--		.. sound_sets[set_name].frequency .. ") @ ", MORE_GAIN, handler)

			-- only continue if sound playing returns handler
			if handler then

--print("-- current handler", handler)

				-- set what player is currently listening to
				playing[player_name] = {
					set = set_name, gain = MORE_GAIN, handler = handler
				}

				-- set timer to stop sound
				minetest.after(ambience.length, function()

--print("-- after", set_name, handler)

					-- make sure we are stopping same sound we started
					if playing[player_name]
					and playing[player_name].handler
					and playing[player_name].handler == handler then

--print("-- timed stop", set_name, handler)

						minetest.sound_stop(handler)

						-- reset player variables and backup handler
						playing[player_name] = {
							set = nil, gain = nil, handler = nil
						}
					end
				end)
			end
		end
	end
end)


-- sound volume command
minetest.register_chatcommand("svol", {
	params = "<svol>",
	description = "set sound volume (0.1 to 1.0)",
	privs = {server = true},

	func = function(name, param)

		SOUNDVOLUME = tonumber(param) or SOUNDVOLUME

		if SOUNDVOLUME < 0.1 then SOUNDVOLUME = 0.1 end
		if SOUNDVOLUME > 1.0 then SOUNDVOLUME = 1.0 end

		return true, "Sound volume set to " .. SOUNDVOLUME
	end,
})


-- music volume command (0 stops music)
minetest.register_chatcommand("mvol", {
	params = "<mvol>",
	description = "set music volume (0.1 to 1.0)",
	privs = {server = true},

	func = function(name, param)

		MUSICVOLUME = tonumber(param) or MUSICVOLUME

		-- ability to stop music just as it begins
		if MUSICVOLUME == 0 and playing[name].music then
			minetest.sound_stop(playing[name].music)
		end

		if MUSICVOLUME < 0.1 then MUSICVOLUME = 0.1 end
		if MUSICVOLUME > 1.0 then MUSICVOLUME = 1.0 end

		return true, "Music volume set to " .. MUSICVOLUME
	end,
})


-- load default sound sets
dofile(minetest.get_modpath("ambience") .. "/soundsets.lua")


print("[MOD] Ambience Lite loaded")
