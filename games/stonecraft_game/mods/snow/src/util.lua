--Global config and function table.
snow = {
	snowball_gravity = tonumber(minetest.settings:get("snow_snowball_gravity")) or 0.91,
	snowball_velocity = tonumber(minetest.settings:get("snow_snowball_velocity")) or 19,
	sleds = minetest.settings:get_bool("snow_sleds", true),
	enable_snowfall = minetest.settings:get_bool("snow_enable_snowfall", true),
	lighter_snowfall = minetest.settings:get_bool("snow_lighter_snowfall", false),
	debug = minetest.settings:get_bool("snow_debug", false),
	smooth_biomes = minetest.settings:get_bool("snow_smooth_biomes", true),
	christmas_content = minetest.settings:get_bool("snow_christmas_content", true),
	smooth_snow = minetest.settings:get_bool("snow_smooth_snow", true),
	min_height = tonumber(minetest.settings:get("snow_min_height")) or 3,
	mapgen_rarity = tonumber(minetest.settings:get("snow_mapgen_rarity")) or 18,
	mapgen_size = tonumber(minetest.settings:get("snow_mapgen_size")) or 210,
	disable_mapgen =  minetest.settings:get_bool("snow_disable_mapgen", true),
}


-- functions for dynamically changing settings

snow.register_on_configuring = function() end
--[[
local on_configurings,n = {},1
function snow.register_on_configuring(func)
	on_configurings[n] = func
	n = n+1
end

local function change_setting(name, value)
	if snow[name] == value then
		return
	end
	for i = 1,n-1 do
		if on_configurings[i](name, value) == false then
			return
		end
	end
	snow[name] = value
end


local function value_from_string(v)
	if v == "true" then
		v = true
	elseif v == "false" then
		v = false
	else
		local a_number = tonumber(v)
		if a_number then
			v = a_number
		end
	end
	return v
end
--]]
