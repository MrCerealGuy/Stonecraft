-- See also technic/doc/api.md

local mesecons_path = minetest.get_modpath("mesecons")

local S = technic.getter

local cable_entry = "^technic_cable_connection_overlay.png"

minetest.register_craft({
	output = "technic:switching_station",
	recipe = {
		{"",                     "technic:lv_transformer", ""},
		{"default:copper_ingot", "technic:machine_casing", "default:copper_ingot"},
		{"technic:lv_cable",     "technic:lv_cable",       "technic:lv_cable"}
	}
})

local function start_network(pos)
	local tier = technic.sw_pos2tier(pos)
	if not tier then
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("%s Has No Network"):format(S("Switching Station")))
		return
	end
	local network_id = technic.sw_pos2network(pos) or technic.create_network(pos)
	technic.activate_network(network_id)
end

local mesecon_def
if mesecons_path then
	mesecon_def = {effector = {
		rules = mesecon.rules.default,
	}}
end

minetest.register_node("technic:switching_station",{
	description = S("Switching Station"),
	tiles  = {
		"technic_water_mill_top_active.png",
		"technic_water_mill_top_active.png"..cable_entry,
		"technic_water_mill_top_active.png",
		"technic_water_mill_top_active.png",
		"technic_water_mill_top_active.png",
		"technic_water_mill_top_active.png"},
	groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2, technic_all_tiers=1},
	connect_sides = {"bottom"},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Switching Station"))
		meta:set_string("channel", "switching_station"..minetest.pos_to_string(pos))
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
		start_network(pos)
	end,
	on_destruct = function(pos)
		-- Remove network when switching station is removed, if
		-- there's another switching station network will be rebuilt.
		local network_id = technic.sw_pos2network(pos)
		if technic.networks[network_id] then
			technic.remove_network(network_id)
		end
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if not fields.channel then
			return
		end
		local plname = sender:get_player_name()
		if minetest.is_protected(pos, plname) then
			minetest.record_protection_violation(pos, plname)
			return
		end
		local meta = minetest.get_meta(pos)
		meta:set_string("channel", fields.channel)
	end,
	mesecons = mesecon_def,
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
				local network_id = technic.sw_pos2network(pos)
				local network = network_id and technic.networks[network_id]
				if network then
					digilines.receptor_send(pos, technic.digilines.rules, channel, {
						supply = network.supply,
						demand = network.demand,
						lag = network.lag
					})
				else
					digilines.receptor_send(pos, technic.digilines.rules, channel, {
						error = "No network",
					})
				end
			end
		},
	},
})

-----------------------------------------------
-- The action code for the switching station --
-----------------------------------------------

-- Timeout ABM
-- Timeout for a node in case it was disconnected from the network
-- A node must be touched by the station continuously in order to function
minetest.register_abm({
	label = "Machines: timeout check",
	nodenames = {"group:technic_machine"},
	interval   = 1,
	chance     = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if not technic.machine_tiers[node.name] then
			-- https://github.com/mt-mods/technic/issues/123
			return
		end
		-- Check for machine timeouts for all tiers
		local tiers = technic.machine_tiers[node.name]
		local timed_out = true
		for _, tier in ipairs(tiers) do
			local timeout = technic.get_timeout(tier, pos)
			if timeout > 0 then
				technic.touch_node(tier, pos, timeout - 1)
				timed_out = false
			end
		end
		-- If all tiers for machine timed out take action
		if timed_out then
			technic.disable_machine(pos, node)
		end
	end,
})

--Re-enable network of switching station if necessary, similar to the timeout above
minetest.register_abm({
	label = "Machines: re-enable check",
	nodenames = {"technic:switching_station"},
	interval   = 1,
	chance     = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local network_id = technic.sw_pos2network(pos)
		-- Check if network is overloaded / conflicts with another network
		if network_id then
			local infotext
			local meta = minetest.get_meta(pos)
			if technic.is_overloaded(network_id) then
				local remaining = technic.reset_overloaded(network_id)
				if remaining > 0 then
					infotext = S("%s Network Overloaded, Restart in %dms"):format(S("Switching Station"), remaining / 1000)
				else
					infotext = S("%s Restarting Network"):format(S("Switching Station"))
				end
				technic.network_infotext(network_id, infotext)
			else
				-- Network exists and is not overloaded, reactivate network
				technic.activate_network(network_id)
				infotext = technic.network_infotext(network_id)
			end
			meta:set_string("infotext", infotext)
		else
			-- Network does not exist yet, attempt to create new network here
			start_network(pos)
		end
	end,
})
