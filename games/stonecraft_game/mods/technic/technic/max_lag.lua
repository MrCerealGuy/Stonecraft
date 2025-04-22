
local multiplier = tonumber(technic.config:get("max_lag_reduction_multiplier"))

local last_step = minetest.get_us_time()

local max_lag = 0

minetest.register_globalstep(function()
	-- Calculate own dtime as a workaround to 2 second limit
	local now = minetest.get_us_time()
	local dtime = now - last_step
	last_step = now

	max_lag = max_lag * multiplier  -- Decrease slowly

	if dtime > max_lag then
		max_lag = dtime
	end
end)

function technic.get_max_lag()
	return max_lag / 1000000
end
