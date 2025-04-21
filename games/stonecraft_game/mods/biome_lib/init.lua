-- Biome library mod by VanessaE
--
-- I got the temperature map idea from "hmmmm", values used for it came from
-- Splizard's snow mod.
--

biome_lib = {}
biome_lib.modpath = minetest.get_modpath("biome_lib")

local function tableize(s)
	return string.split(string.trim(string.gsub(s, " ", "")))
end

local c1 = minetest.settings:get("biome_lib_default_grow_through_nodes")
biome_lib.default_grow_through_nodes = {["air"] = true}
if c1 then
	for _, i in ipairs(tableize(c1)) do
		biome_lib.default_grow_through_nodes[i] = true
	end
else
	biome_lib.default_grow_through_nodes["default:snow"] = true
end

local c2 = minetest.settings:get("biome_lib_default_water_nodes")
biome_lib.default_water_nodes = {}
if c2 then
	for _, i in ipairs(tableize(c2)) do
		biome_lib.default_water_nodes[i] = true
	end
else
	biome_lib.default_water_nodes["default:water_source"] = true
	biome_lib.default_water_nodes["default:water_flowing"] = true
	biome_lib.default_water_nodes["default:river_water_source"] = true
	biome_lib.default_water_nodes["default:river_water_flowing"] = true
end

local c3 = minetest.settings:get("biome_lib_default_wet_surfaces")
local c4 = minetest.settings:get("biome_lib_default_ground_nodes")
local c5 = minetest.settings:get("biome_lib_default_grow_nodes")

biome_lib.default_wet_surfaces = c3 and tableize(c3) or {"default:dirt", "default:dirt_with_grass", "default:sand"}
biome_lib.default_ground_nodes = c4 and tableize(c4) or {"default:dirt_with_grass"}
biome_lib.default_grow_nodes =   c5 and tableize(c5) or {"default:dirt_with_grass"}

biome_lib.debug_log_level = tonumber(minetest.settings:get("biome_lib_debug_log_level")) or 0

local rr = tonumber(minetest.settings:get("biome_lib_queue_ratio")) or -200
biome_lib.queue_ratio = 100 - rr
biome_lib.entries_per_step = math.max(-rr, 1)

-- the timer that manages the block timeout is in microseconds, but the timer
-- that manages the queue wakeup call has to be in seconds, and works best if
-- it takes a fraction of the block timeout interval.

local t = tonumber(minetest.settings:get("biome_lib_block_timeout")) or 300

biome_lib.block_timeout = t * 1000000

-- we don't want the wakeup function to trigger TOO often,
-- in case the user's block timeout setting is really low

biome_lib.block_queue_wakeup_time = math.min(t/2, math.max(20, t/10))

-- the actual important stuff starts here ;-)

dofile(biome_lib.modpath .. "/api.lua")
dofile(biome_lib.modpath .. "/search_functions.lua")
dofile(biome_lib.modpath .. "/growth.lua")
dofile(biome_lib.modpath .. "/compat.lua")

minetest.after(0.01, function()
	-- report the final registration results and enable the active block queue stuff

	local n = #biome_lib.actionslist_aircheck + #biome_lib.actionslist_no_aircheck

	biome_lib.dbg("All mapgen registrations completed.", 0)

	if n > 0 then
		biome_lib.dbg("Total items/actions to handle manually: "..n..
				" ("..#biome_lib.actionslist_no_aircheck.." without air checks)", 0)
		biome_lib.dbg("Total surface types to handle manually: "
				..#biome_lib.surfaceslist_aircheck + #biome_lib.surfaceslist_no_aircheck, 0)
	else
		biome_lib.dbg("There are no \"handle manually\" items/actions registered,", 0)
		biome_lib.dbg("so the mapblock queue will not be used this session.", 0)
	end

	biome_lib.dbg("Items sent to the engine's decorations handler: "..#biome_lib.registered_decorations, 0)
	biome_lib.dbg("Elevation range: "..biome_lib.mapgen_elevation_limit.min.." to "..
			string.format("%+d", biome_lib.mapgen_elevation_limit.max).." meters.", 0)

	if n > 0 then
		dofile(biome_lib.modpath .. "/block_queue_checks.lua")
	end
end)
