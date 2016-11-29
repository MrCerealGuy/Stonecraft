
--= Ambience lite by TenPlus1 (17th June 2016)

local max_frequency_all = 1000 -- larger number means more frequent sounds (100-2000)
local SOUNDVOLUME = 1
local volume = 0.3
local ambiences

-- sound sets

local night = {
	handler = {}, frequency = 40,
	{name = "hornedowl", length = 2},
	{name = "wolves", length = 4},
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
	{name = "swim_splashing", length=3},
}

local lava = {
	handler = {}, frequency = 1000,
	{name = "lava", length = 7}
}

local river = {
	handler = {}, frequency = 1000,
	{name = "river", length = 4}
}

local smallfire = {
	handler = {}, frequency = 1000,
	{name = "fire_small", length = 6}
}

local largefire = {
	handler = {}, frequency = 1000,
	{name = "fire_large", length = 8}
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

local radius = 6
local num_fire, num_lava, num_water_flowing, num_water_source,
	num_desert, num_snow, num_jungletree, num_river

-- check where player is and which sounds are played
local get_ambience = function(player)

	-- who and where am I?
	--local player_name = player:get_player_name()
	local pos = player:getpos()

	-- what is around me?
	pos.y = pos.y + 1.4 -- head level
	local nod_head = minetest.get_node(pos).name

	pos.y = pos.y - 1.2 -- foot level
	local nod_feet = minetest.get_node(pos).name

	pos.y = pos.y - 0.2 -- reset pos

--= START Ambiance

	if minetest.registered_nodes[nod_head]
	and minetest.registered_nodes[nod_head].groups.water then
		return {underwater = underwater}
	end

	if minetest.registered_nodes[nod_feet].groups.water then

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
			"default:water_flowing", "default:water_source",
			"default:river_water_flowing", "default:river_water_source",
			"default:desert_sand", "default:desert_stone", "default:snowblock"
		})

	num_fire = (cn["fire:basic_flame"] or 0) + (cn["fire:permanent_flame"] or 0)
	num_lava = (cn["default:lava_flowing"] or 0) + (cn["default:lava_source"] or 0)
	num_water_flowing = (cn["default:water_flowing"] or 0)
	num_water_source = (cn["default:water_source"] or 0)
	num_desert = (cn["default:desert_sand"] or 0) + (cn["default:desert_stone"] or 0)
	num_snow = (cn["default:snowblock"] or 0)
	num_jungletree = (cn["default:jungletree"] or 0)
	num_river = (cn["default:river_water_source"] or 0) + (cn["default:river_water_flowing"] or 0)
--[[
print (
	"fr:" .. num_fire,
	"lv:" .. num_lava,
	"wf:" .. num_water_flowing,
	"ws:" .. num_water_source,
	"ds:" .. num_desert,
	"sn:" .. num_snow,
	"jt:" .. num_jungletree
)
]]
	-- is fire redo mod active?
	if fire and fire.mod and fire.mod == "redo" then

		if num_fire > 8 then
			return {largefire = largefire}

		elseif num_fire > 0 then
			return {smallfire = smallfire}
		end
	end

	if num_lava > 5 then
		return {lava = lava}
	end

	if num_water_flowing > 30 then
		return {flowing_water = flowing_water}
	end

	if num_river > 30 then
		return {river = river}
	end

	if pos.y < 7 and pos.y > 0
	and num_water_source > 100 then
		return {beach = beach}
	end

	if num_desert > 150 then
		return {desert = desert}
	end

	if pos.y > 60
	or num_snow > 150 then
		return {high_up = high_up}
	end

	if pos.y < -10 then
		return {cave = cave}
	end

	local tod = minetest.get_timeofday()

	if tod > 0.2
	and tod < 0.8 then

		if num_jungletree > 90 then
			return {jungle = jungle}
		end

		return {day = day}
	else

		if num_jungletree > 90 then
			return {jungle_night = jungle_night}
		end

		return {night = night}
	end

	-- END Ambiance

end

-- play sound, set handler then delete handler when sound finished
local play_sound = function(player_name, list, number)

	if list.handler[player_name] == nil then

		local handler = minetest.sound_play(list[number].name, {
			to_player = player_name,
			gain = volume * SOUNDVOLUME
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
end

-- player routine

local timer = 0

minetest.register_globalstep(function(dtime)

	-- every 1 second
	timer = timer + dtime
	if timer < 1 then return end
	timer = 0

	local players = minetest.get_connected_players()

	for n = 1, #players do

		local player_name = players[n]:get_player_name()

--local t1 = os.clock()

		ambiences = get_ambience(players[n])

--print(string.format("elapsed time: %.4f\n", os.clock() - t1))

		still_playing(ambiences, player_name)

		for _,ambience in pairs(ambiences) do

			if math.random(1, 1000) <= ambience.frequency then

				play_sound(player_name, ambience, math.random(1, #ambience))
			end
		end
	end
end)

-- set volume command
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
