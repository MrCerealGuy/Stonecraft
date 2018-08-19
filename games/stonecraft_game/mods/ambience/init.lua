
--= Ambience lite by TenPlus1

local max_frequency_all = 1000 -- larger number means more frequent sounds (100-2000)
local SOUNDVOLUME = 1.0
local ambiences

-- override default water sounds
minetest.override_item("default:water_source", { sounds = {} })
minetest.override_item("default:water_flowing", { sounds = {} })
minetest.override_item("default:river_water_source", { sounds = {} })
minetest.override_item("default:river_water_flowing", { sounds = {} })

-- music settings
local music_handler = nil
local MUSICVOLUME = 1
local play_music = minetest.settings:get_bool("ambience_music") ~= false

-- is playerplus running?
local pplus = minetest.get_modpath("playerplus")

-- sound sets (gain defaults to 0.3 unless specifically set)

local night = {
	handler = {}, frequency = 40,
	{name = "hornedowl", length = 2},
	{name = "wolves", length = 4, gain = 0.4},
	{name = "cricket", length = 6},
	{name = "deer", length = 7},
	{name = "frog", length = 1},
}

local day = {
	handler = {}, frequency = 40,
	{name = "cardinal", length = 3},
	{name = "craw", length = 3},
	{name = "bluejay", length = 6},
	{name = "robin", length = 4},
	{name = "bird1", length = 11},
	{name = "bird2", length = 6},
	{name = "crestedlark", length = 6},
	{name = "peacock", length = 2},
	{name = "wind", length = 9},
}

local high_up = {
	handler = {}, frequency = 40,
	{name = "desertwind", length = 8},
	{name = "wind", length = 9},
}

local cave = {
	handler = {}, frequency = 60,
	{name = "drippingwater1", length = 1.5},
	{name = "drippingwater2", length = 1.5}
}

local beach = {
	handler = {}, frequency = 40,
	{name = "seagull", length = 4.5},
	{name = "beach", length = 13},
	{name = "gull", length = 1},
	{name = "beach_2", length = 6},
}

local desert = {
	handler = {}, frequency = 20,
	{name = "coyote", length = 2.5},
	{name = "wind", length = 9},
	{name = "desertwind", length = 8}
}

local flowing_water = {
	handler = {}, frequency = 1000,
	{name = "waterfall", length = 6}
}

local underwater = {
	handler = {}, frequency = 1000,
	{name = "scuba", length = 8}
}

local splash = {
	handler = {}, frequency = 1000,
	{name = "swim_splashing", length = 3},
}

local lava = {
	handler = {}, frequency = 1000,
	{name = "lava", length = 7}
}

local river = {
	handler = {}, frequency = 1000,
	{name = "river", length = 4, gain = 0.1}
}

local smallfire = {
	handler = {}, frequency = 1000,
	{name = "fire_small", length = 6, gain = 0.1}
}

local largefire = {
	handler = {}, frequency = 1000,
	{name = "fire_large", length = 8, gain = 0.4}
}

local jungle = {
	handler = {}, frequency = 200,
	{name = "jungle_day_1", length = 7},
	{name = "deer", length = 7},
	{name = "canadianloon2", length = 14},
	{name = "bird1", length = 11},
	{name = "peacock", length = 2},
}

local jungle_night = {
	handler = {}, frequency = 200,
	{name = "jungle_night_1", length = 4},
	{name = "jungle_night_2", length = 4},
	{name = "deer", length = 7},
	{name = "frog", length = 1},
}

local ice = {
	handler = {}, frequency = 250,
	{name = "icecrack", length = 23},
	{name = "desertwind", length = 8},
	{name = "wind", length = 9},
}

local radius = 6
local num_fire, num_lava, num_water_flowing, num_water_source, num_air,
	num_desert, num_snow, num_jungletree, num_river, num_ice

-- check where player is and which sounds are played
local get_ambience = function(player)

	-- where am I?
	--local player_name = player:get_player_name()
	local pos = player:get_pos()

	-- what is around me?
	local nod_head, nod_feet

	-- is playerplus in use?
	if pplus then

		local name = player:get_player_name()

		nod_head = playerplus[name].nod_head
		nod_feet = playerplus[name].nod_feet
	else

		pos.y = pos.y + 1.4 -- head level
		nod_head = minetest.get_node(pos).name

		pos.y = pos.y - 1.2 -- foot level
		nod_feet = minetest.get_node(pos).name

		pos.y = pos.y - 0.2 -- reset pos
	end

	local tod = minetest.get_timeofday()

	-- play server or local music if available
	if play_music then

--		print ("-- tod", tod, music_handler)

		if tod > 0.01 and tod < 0.02 then
			music_handler = nil
		end

		-- play at midnight
		if tod >= 0.0 and tod <= 0.01 and not music_handler then

			music_handler = minetest.sound_play("ambience_music", {
				to_player = player:get_player_name(),
				gain = MUSICVOLUME
			})
		end
	end

--= START Ambiance

	-- head underwater
	if minetest.registered_nodes[nod_head]
	and minetest.registered_nodes[nod_head].groups.water then
		return {underwater = underwater}
	end

	-- wading through water
	if minetest.registered_nodes[nod_feet]
	and minetest.registered_nodes[nod_feet].groups.water then

		local control = player:get_player_control()

		if control.up or control.down or control.left or control.right then
			return {splash = splash}
		end
	end

	local ps, cn = minetest.find_nodes_in_area(
		{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
		{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius},
		{
			"fire:basic_flame", "fire:permanent_flame",
			"default:lava_flowing", "default:lava_source", "default:jungletree",
			"default:water_flowing", "default:water_source", "default:ice",
			"default:river_water_flowing",
			"default:desert_sand", "default:desert_stone", "default:snowblock"
		})

	num_fire = (cn["fire:basic_flame"] or 0) + (cn["fire:permanent_flame"] or 0)
	num_lava = (cn["default:lava_flowing"] or 0) + (cn["default:lava_source"] or 0)
	num_water_flowing = (cn["default:water_flowing"] or 0)
	num_water_source = (cn["default:water_source"] or 0)
	num_desert = (cn["default:desert_sand"] or 0) + (cn["default:desert_stone"] or 0)
	num_snow = (cn["default:snowblock"] or 0)
	num_jungletree = (cn["default:jungletree"] or 0)
	num_river = (cn["default:river_water_flowing"] or 0)
	num_ice = (cn["default:ice"] or 0)
--[[
print (
	"fr:" .. num_fire,
	"lv:" .. num_lava,
	"wf:" .. num_water_flowing,
	"ws:" .. num_water_source,
	"rv:" .. num_river,
	"ds:" .. num_desert,
	"sn:" .. num_snow,
	"ic:" .. num_ice,
	"jt:" .. num_jungletree
)
]]
	-- is fire redo mod active?
	if fire and fire.mod and fire.mod == "redo" then

		if num_fire > 16 then
			return {largefire = largefire}, 0.4

		elseif num_fire > 8 then
			return {largefire = largefire}

		elseif num_fire > 3 then
			return {smallfire = smallfire}, 0.2

		elseif num_fire > 0 then
			return {smallfire = smallfire}
		end
	end

	-- lava
	if num_lava > 50 then
		return {lava = lava}, 0.5
	elseif num_lava > 5 then
		return {lava = lava}
	end

	-- flowing water
	if num_water_flowing > 50 then
		return {flowing_water = flowing_water}, 0.5
	elseif num_water_flowing > 20 then
		return {flowing_water = flowing_water}
	end

	-- flowing river
	if num_river > 20 then
		return {river = river}, 0.4
	elseif num_river > 5 then
		return {river = river}
	end

	-- sea level beach
	if pos.y < 7 and pos.y > 0
	and num_water_source > 100 then
		return {beach = beach}
	end

	-- ice flows
	if num_ice > 100 and num_snow > 100 then
		return {ice = ice}
	end

	-- desert
	if num_desert > 150 then
		return {desert = desert}
	end

	-- high up or surrounded by snow
	if pos.y > 60
	or num_snow > 150 then
		return {high_up = high_up}
	end

	-- underground
	if pos.y < -15 then
		return {cave = cave}
	end

	if tod > 0.2
	and tod < 0.8 then

		-- jungle day time
		if num_jungletree > 90 then
			return {jungle = jungle}
		end

		-- normal day time
		return {day = day}
	else

		-- jungle night time
		if num_jungletree > 90 then
			return {jungle_night = jungle_night}
		end

		-- normal night time
		return {night = night}
	end

	-- END Ambiance
end

-- play sound, set handler then delete handler when sound finished
local play_sound = function(player_name, list, number, MORE_GAIN)

	if list.handler[player_name] == nil then

		local handler = minetest.sound_play(list[number].name, {
			to_player = player_name,
			gain = ((list[number].gain or 0.3) + (MORE_GAIN or 0)) * SOUNDVOLUME
		})

		if handler then

			list.handler[player_name] = handler

			minetest.after(list[number].length, function(args)

				local list = args[1]
				local player_name = args[2]

				if list.handler[player_name] then

					minetest.sound_stop(list.handler[player_name])

					list.handler[player_name] = nil
				end

			end, {list, player_name})
		end
	end
end

-- stop sound in still_playing
local stop_sound = function (list, player_name)

	if list.handler[player_name] then

		minetest.sound_stop(list.handler[player_name])

		list.handler[player_name] = nil
	end
end

-- check sounds that are not in still_playing
local still_playing = function(still_playing, player_name)

	if not still_playing.cave then stop_sound(cave, player_name) end
	if not still_playing.high_up then stop_sound(high_up, player_name) end
	if not still_playing.beach then stop_sound(beach, player_name) end
	if not still_playing.desert then stop_sound(desert, player_name) end
	if not still_playing.night then stop_sound(night, player_name) end
	if not still_playing.day then stop_sound(day, player_name) end
	if not still_playing.flowing_water then stop_sound(flowing_water, player_name) end
	if not still_playing.splash then stop_sound(splash, player_name) end
	if not still_playing.underwater then stop_sound(underwater, player_name) end
	if not still_playing.river then stop_sound(river, player_name) end
	if not still_playing.lava then stop_sound(lava, player_name) end
	if not still_playing.smallfire then stop_sound(smallfire, player_name) end
	if not still_playing.largefire then stop_sound(largefire, player_name) end
	if not still_playing.jungle then stop_sound(jungle, player_name) end
	if not still_playing.jungle_night then stop_sound(jungle_night, player_name) end
	if not still_playing.ice then stop_sound(ice, player_name) end
end

-- player routine

local timer = 0

minetest.register_globalstep(function(dtime)

	-- every 1 second
	timer = timer + dtime
	if timer < 1 then return end
	timer = 0

	local players = minetest.get_connected_players()
	local MORE_GAIN

	for n = 1, #players do

		local player_name = players[n]:get_player_name()

--local t1 = os.clock()

		ambiences, MORE_GAIN = get_ambience(players[n])

--print(string.format("elapsed time: %.4f\n", os.clock() - t1))

		still_playing(ambiences, player_name)

		for _,ambience in pairs(ambiences) do

			if math.random(1, 1000) <= ambience.frequency then

				play_sound(player_name, ambience, math.random(1, #ambience), MORE_GAIN)
			end
		end
	end
end)

-- set volume commands
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

minetest.register_chatcommand("mvol", {
	params = "<mvol>",
	description = "set music volume (0.1 to 1.0)",
	privs = {server = true},

	func = function(name, param)

		MUSICVOLUME = tonumber(param) or MUSICVOLUME

		if MUSICVOLUME < 0.1 then MUSICVOLUME = 0.1 end
		if MUSICVOLUME > 1.0 then MUSICVOLUME = 1.0 end

		return true, "Music volume set to " .. MUSICVOLUME
	end,
})
