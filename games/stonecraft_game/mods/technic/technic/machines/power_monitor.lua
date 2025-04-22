-- POWER MONITOR
-- The power monitor can be used to monitor how much power is available on a network,
-- similarly to the old "slave" switching stations.

local S = technic.getter

local cable_entry = "^technic_cable_connection_overlay.png"

-- Get registered cable or nil, returns nil if area is not loaded
local function get_cable(pos)
	local node = minetest.get_node_or_nil(pos)
	return (node and technic.get_cable_tier(node.name)) and node
end

-- return the position of connected cable or nil
-- TODO: Make it support every possible orientation
local function get_connected_cable_network(pos)
	local param2 = minetest.get_node(pos).param2
	-- should probably also work sideways or upside down but for now it wont
	if param2 > 3 then return end
	-- Below?
	local checkpos = {x=pos.x,y=pos.y-1,z=pos.z}
	local network_id = get_cable(checkpos) and technic.pos2network(checkpos)
	if network_id then
		return network_id
	end
	-- Behind?
	checkpos = vector.add(minetest.facedir_to_dir(param2),pos)
	network_id = get_cable(checkpos) and technic.pos2network(checkpos)
	return network_id
end

-- return the position of the associated switching station or nil
local function get_network(pos)
	local network_id = get_connected_cable_network(pos)
	local network = network_id and technic.networks[network_id]
	local swpos = network and technic.network2sw_pos(network_id)
	local is_powermonitor = swpos and minetest.get_node(swpos).name == "technic:switching_station"
	return (is_powermonitor and network.all_nodes[network_id]) and network
end

minetest.register_craft({
	output = "technic:power_monitor",
	recipe = {
		{"",                 "",                       ""},
		{"",                 "technic:machine_casing", "default:copper_ingot"},
		{"technic:lv_cable", "technic:lv_cable",       "technic:lv_cable"}
	}
})

minetest.register_node("technic:power_monitor",{
	description = S("Power Monitor"),
	tiles  = {
		"technic_power_monitor_sides.png",
		"technic_power_monitor_sides.png"..cable_entry,
		"technic_power_monitor_sides.png",
		"technic_power_monitor_sides.png",
		"technic_power_monitor_sides.png"..cable_entry,
		"technic_power_monitor_front.png"
	},
	paramtype2 = "facedir",
	groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2, technic_all_tiers=1},
	connect_sides = {"bottom", "back"},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Power Monitor"))
		meta:set_string("channel", "power_monitor"..minetest.pos_to_string(pos))
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if not fields.channel then
			return
		end
		local plname = sender:get_player_name()
    if minetest.is_protected(pos, plname) and not minetest.check_player_privs(sender, "protection_bypass") then
			minetest.record_protection_violation(pos, plname)
			return
		end
		local meta = minetest.get_meta(pos)
		meta:set_string("channel", fields.channel)
	end,
	digiline = {
		receptor = {
			rules = technic.digilines.rules,
			action = function() end
		},
		effector = {
			rules = technic.digilines.rules,
			action = function(pos, node, channel, msg)
				if msg ~= "GET" and msg ~= "get" then
					return
				end
				local meta = minetest.get_meta(pos)
				if channel ~= meta:get_string("channel") then
					return
				end

				local network = get_network(pos)
				if not network then return end

				digilines.receptor_send(pos, technic.digilines.rules, channel, {
					supply = network.supply,
					demand = network.demand,
					lag = network.lag,
					battery_count = network.battery_count,
					battery_charge = network.battery_charge,
					battery_charge_max = network.battery_charge_max,
				})
			end
		},
	},
})

minetest.register_abm({
	nodenames = {"technic:power_monitor"},
	label = "Machines: run power monitor",
	interval   = 1,
	chance     = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		local network = get_network(pos)
		if network then
			meta:set_string("infotext", S("Power Monitor. Supply: @1 Demand: @2",
					technic.EU_string(network.supply), technic.EU_string(network.demand)))
		else
			meta:set_string("infotext",S("Power Monitor Has No Network"))
		end
	end,
})
