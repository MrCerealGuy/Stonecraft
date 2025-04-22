local path = technic.modpath.."/machines"

technic.digilines = {
	rules = {
		-- digilines.rules.default
		{x= 1,y= 0,z= 0},{x=-1,y= 0,z= 0}, -- along x beside
		{x= 0,y= 0,z= 1},{x= 0,y= 0,z=-1}, -- along z beside
		{x= 1,y= 1,z= 0},{x=-1,y= 1,z= 0}, -- 1 node above along x diagonal
		{x= 0,y= 1,z= 1},{x= 0,y= 1,z=-1}, -- 1 node above along z diagonal
		{x= 1,y=-1,z= 0},{x=-1,y=-1,z= 0}, -- 1 node below along x diagonal
		{x= 0,y=-1,z= 1},{x= 0,y=-1,z=-1}, -- 1 node below along z diagonal
		-- added rules for digi cable
		{x =  0, y = -1, z = 0}, -- along y below
	}
}

-- https://github.com/mt-mods/technic/issues/100
dofile(path.."/compat/digtron.lua")

dofile(path.."/network.lua")

dofile(path.."/register/init.lua")

-- Tiers
dofile(path.."/LV/init.lua")
dofile(path.."/MV/init.lua")
dofile(path.."/HV/init.lua")

dofile(path.."/switching_station.lua")
dofile(path.."/switching_station_globalstep.lua")

dofile(path.."/power_monitor.lua")
dofile(path.."/supply_converter.lua")

dofile(path.."/other/init.lua")

--
-- Technic power network administrative functions
--

local active_networks = technic.active_networks
local networks = technic.networks
local cables = technic.cables
--
-- Enable / disable technic globalstep
--
technic.powerctrl_state = true
minetest.register_chatcommand("powerctrl", {
	params = "[on|off]",
	description = "Enables or disables technic network globalstep handler",
	privs = { [technic.config:get("admin_priv")] = true },
	func = function(name, state)
		if state == "on" then
			technic.powerctrl_state = true
		elseif state == "off" then
			technic.powerctrl_state = false
		end
		minetest.chat_send_player(name, ("Technic network globalstep %s."):format(
			technic.powerctrl_state and "enabled" or "disabled"
		))
	end
})

--
-- List all active networks with additional data
--
minetest.register_chatcommand("technic_get_active_networks", {
	params = "[minlag]",
	description = "list all active networks with additional network data",
	privs = { [technic.config:get("admin_priv")] = true },
	func = function(name, minlag)
		minlag = tonumber(minlag) or 0
		local activecount = 0
		local network_info = {}
		local netcount = 0
		local nodecount = 0
		local function align(s, w)
			s = tostring(s)
			return string.rep(' ', w - #s) .. s
		end
		local function net2str(id)
			local p=technic.network2pos(id)
			return align(("%s,%s,%s"):format(p.x,p.y,p.z),21)
		end
		for id,net in pairs(active_networks) do
			if minlag == 0 or (net.lag and net.lag >= minlag * 1000) then
				activecount = activecount + 1
				table.insert(network_info, ("Pos:%s PR:%s RE:%s BA:%s Skip:%s Lag:%sms"):format(
					net2str(id), align(#net.PR_nodes, 4), align(#net.RE_nodes, 4), align(#net.BA_nodes, 4),
					align(net.skip, 3), net.lag and align(("%0.2f"):format(net.lag / 1000), 6) or ""
				))
			end
		end
		for _ in pairs(networks) do netcount = netcount + 1 end
		for _ in pairs(cables) do nodecount = nodecount + 1 end
		minetest.chat_send_player(name,
			("Cached networks: %d active, %d total, %d nodes, %0.2f max lag.\n%s"):format(
			activecount, netcount, nodecount, technic.get_max_lag(), table.concat(network_info, "\n")
		))
	end
})

--
-- Clear technic active networks
--
minetest.register_chatcommand("technic_flush_switch_cache", {
	description = "removes all active networks from the cache",
	privs = { [technic.config:get("admin_priv")] = true },
	func = function(name)
		local activecount = 0
		for id in pairs(active_networks) do
			activecount = activecount + 1
			active_networks[id] = nil
		end
		minetest.chat_send_player(name, ("Network data removed: %d active networks deactivated."):format(activecount))
	end
})

--
-- Completely clear all technic network caches
--
minetest.register_chatcommand("technic_clear_network_data", {
	description = "removes all networks and network nodes from the cache",
	privs = { [technic.config:get("admin_priv")] = true },
	func = function(name)
		-- Clear all network data keeping all reference links intact
		local activecount = 0
		local netcount = 0
		local nodecount = 0
		for id in pairs(active_networks) do
			activecount = activecount + 1
			active_networks[id] = nil
		end
		for id in pairs(networks) do
			netcount = netcount + 1
			networks[id] = nil
		end
		for id in pairs(cables) do
			nodecount = nodecount + 1
			cables[id] = nil
		end
		minetest.chat_send_player(name, string.format(
			"Network data removed: %d active networks, %d total networks, %d network nodes.",
			activecount, netcount, nodecount
		))
	end
})

--
-- Metadata cleanup LBM, removes old metadata values from nodes
--
--luacheck: ignore 511
if false then
	minetest.register_lbm({
		name = "technic:metadata-cleanup",
		nodenames = {
			"group:technic_machine",
			"group:technic_all_tiers",
			"technic:switching_station",
			"technic:power_monitor",
		},
		action = function(pos, node)
			-- Delete all listed metadata key/value pairs from technic machines
			local keys = {
				"LV_EU_timeout", "MV_EU_timeout", "HV_EU_timeout",
				"LV_network", "MV_network", "HV_network",
				"active_pos", "supply", "demand",
				"battery_count", "battery_charge", "battery_charge_max",
			}
			local meta = minetest.get_meta(pos)
			for _,key in ipairs(keys) do
				-- Value of `""` will delete the key.
				meta:set_string(key, "")
			end
			if node.name == "technic:switching_station" then
				meta:set_string("active", "")
			end
		end,
	})
end
