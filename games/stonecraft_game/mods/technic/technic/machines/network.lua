--
-- Power network specific functions and data should live here
--
local S = technic.getter

local switch_max_range = tonumber(technic.config:get("switch_max_range"))
local off_delay_seconds = tonumber(technic.config:get("switch_off_delay_seconds"))

technic.active_networks = {}
local networks = {}
technic.networks = networks
local cables = {}
technic.cables = cables

local poshash = minetest.hash_node_position
local hashpos = minetest.get_position_from_hash

function technic.create_network(sw_pos)
	local network_id = poshash({x=sw_pos.x,y=sw_pos.y-1,z=sw_pos.z})
	technic.build_network(network_id)
	return network_id
end

function technic.activate_network(network_id, timeout)
	-- timeout is optional ttl for network in seconds, if not specified use default
	local network = networks[network_id]
	if network then
		-- timeout is absolute time in microseconds
		network.timeout = minetest.get_us_time() + ((timeout or off_delay_seconds) * 1000 * 1000)
		technic.active_networks[network_id] = network
	end
end

function technic.sw_pos2tier(pos, use_vm)
	-- Get cable tier for switching station or nil if no cable
	-- use_vm true to use VoxelManip to load node
	local cable_pos = {x=pos.x,y=pos.y-1,z=pos.z}
	if use_vm then
		technic.get_or_load_node(cable_pos)
	end
	return technic.get_cable_tier(minetest.get_node(cable_pos).name)
end

-- Destroy network data
function technic.remove_network(network_id)
	for pos_hash,cable_net_id in pairs(cables) do
		if cable_net_id == network_id then
			cables[pos_hash] = nil
		end
	end
	networks[network_id] = nil
	technic.active_networks[network_id] = nil
end

-- Remove machine or cable from network
local network_node_arrays = {"PR_nodes","BA_nodes","RE_nodes"}
function technic.remove_network_node(network_id, pos)
	local network = networks[network_id]
	if not network then return end
	-- Clear hash tables, cannot use table.remove
	local node_id = poshash(pos)
	cables[node_id] = nil
	network.all_nodes[node_id] = nil
	-- TODO: All following things can be skipped if node is not machine
	--   check here if it is or is not cable
	--   or add separate function to remove cables and move responsibility to caller
	-- Clear indexed arrays, do NOT leave holes
	local machine_removed = false
	for _,tblname in ipairs(network_node_arrays) do
		local tbl = network[tblname]
		for i=#tbl,1,-1 do
			local mpos = tbl[i]
			if mpos.x == pos.x and mpos.y == pos.y and mpos.z == pos.z then
				table.remove(tbl, i)
				machine_removed = true
				break
			end
		end
	end
	if machine_removed then
		-- Machine can still be in world, just not connected to any network. If so then disable it.
		local node = minetest.get_node(pos)
		technic.disable_machine(pos, node)
	end
end

function technic.sw_pos2network(pos)
	return cables[poshash({x=pos.x,y=pos.y-1,z=pos.z})]
end

function technic.sw_pos2network(pos)
	return cables[poshash({x=pos.x,y=pos.y-1,z=pos.z})]
end

function technic.pos2network(pos)
	return cables[poshash(pos)]
end

function technic.network2pos(network_id)
	return hashpos(network_id)
end

function technic.network2sw_pos(network_id)
	-- Return switching station position for network.
	-- It is not guaranteed that position actually contains switching station.
	local sw_pos = hashpos(network_id)
	sw_pos.y = sw_pos.y + 1
	return sw_pos
end

function technic.network_infotext(network_id, text)
	if networks[network_id] == nil then return end
	if text then
		networks[network_id].infotext = text
	else
		return networks[network_id].infotext
	end
end

local node_timeout = {}
local default_timeout = 2

function technic.set_default_timeout(timeout)
	default_timeout = timeout or 2
end

function technic.get_timeout(tier, pos)
	if node_timeout[tier] == nil then
		-- it is normal that some multi tier nodes always drop here when checking all LV, MV and HV tiers
		return 0
	end
	return node_timeout[tier][poshash(pos)] or 0
end

local function touch_node(tier, pos, timeout)
	if node_timeout[tier] == nil then
		-- this should get built up during registration
		node_timeout[tier] = {}
	end
	node_timeout[tier][poshash(pos)] = timeout or default_timeout
end
technic.touch_node = touch_node

function technic.disable_machine(pos, node)
	local nodedef = minetest.registered_nodes[node.name]
	if nodedef and nodedef.technic_disabled_machine_name then
		node.name = nodedef.technic_disabled_machine_name
		minetest.swap_node(pos, node)
	elseif nodedef and nodedef.technic_on_disable then
		nodedef.technic_on_disable(pos, node)
	end
	if nodedef then
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("%s Has No Network"):format(nodedef.description))
	end
	local node_id = poshash(pos)
	for _,nodes in pairs(node_timeout) do
		nodes[node_id] = nil
	end
end

--
-- Network overloading (incomplete cheat mitigation)
--
local overload_reset_time = tonumber(technic.config:get("network_overload_reset_time"))
local overloaded_networks = {}

local function overload_network(network_id)
	local network = networks[network_id]
	if network then
		network.supply = 0
		network.battery_charge = 0
	end
	overloaded_networks[network_id] = minetest.get_us_time() + (overload_reset_time * 1000 * 1000)
end
technic.overload_network = overload_network

local function reset_overloaded(network_id)
	local remaining = math.max(0, overloaded_networks[network_id] - minetest.get_us_time())
	if remaining == 0 then
		-- Clear cache, remove overload and restart network
		technic.remove_network(network_id)
		overloaded_networks[network_id] = nil
	end
	-- Returns 0 when network reset or remaining time if reset timer has not expired yet
	return remaining
end
technic.reset_overloaded = reset_overloaded

local function is_overloaded(network_id)
	return overloaded_networks[network_id]
end
technic.is_overloaded = is_overloaded

--
-- Functions to traverse the electrical network
--

-- Add a machine node to the LV/MV/HV network
local function add_network_machine(nodes, pos, network_id, all_nodes, multitier)
	local node_id = poshash(pos)
	local net_id_old = cables[node_id]
	if net_id_old == nil or (multitier and net_id_old ~= network_id and all_nodes[node_id] == nil) then
		-- Add machine to network only if it is not already added
		table.insert(nodes, pos)
		-- FIXME: Machines connecting to multiple networks should have way to store multiple network ids
		cables[node_id] = network_id
		all_nodes[node_id] = pos
		return true
	elseif not multitier and net_id_old ~= network_id then
		-- Do not allow running from multiple networks, trigger overload
		overload_network(network_id)
		overload_network(net_id_old)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext",S("Network Overloaded"))
	end
end

-- Add a wire node to the LV/MV/HV network
local function add_cable_node(nodes, pos, network_id, queue)
	local node_id = poshash(pos)
	if not cables[node_id] then
		cables[node_id] = network_id
		nodes[node_id] = pos
		table.insert(queue, pos)
	end
end

-- Generic function to add found connected nodes to the right classification array
local function add_network_node(PR_nodes, RE_nodes, BA_nodes, all_nodes, pos, machines, tier, network_id, queue)
	technic.get_or_load_node(pos)
	local name = minetest.get_node(pos).name

	if technic.is_tier_cable(name, tier) then
		add_cable_node(all_nodes, pos, network_id, queue)
	elseif machines[name] then
		if     machines[name] == technic.producer then
			add_network_machine(PR_nodes, pos, network_id, all_nodes)
		elseif machines[name] == technic.receiver then
			add_network_machine(RE_nodes, pos, network_id, all_nodes)
		elseif machines[name] == technic.producer_receiver then
			if add_network_machine(PR_nodes, pos, network_id, all_nodes, true) then
				table.insert(RE_nodes, pos)
			end
		elseif machines[name] == technic.battery then
			add_network_machine(BA_nodes, pos, network_id, all_nodes)
		end
	end
end

-- Generic function to add single nodes to the right classification array of existing network
function technic.add_network_node(pos, network)
	add_network_node(
		network.PR_nodes,
		network.RE_nodes,
		network.BA_nodes,
		network.all_nodes,
		pos,
		technic.machines[network.tier],
		network.tier,
		network.id,
		{}
	)
end

-- Traverse a network given a list of machines and a cable type name
local function traverse_network(PR_nodes, RE_nodes, BA_nodes, all_nodes, pos, machines, tier, network_id, queue)
	local positions = {
		{x=pos.x+1, y=pos.y,   z=pos.z},
		{x=pos.x-1, y=pos.y,   z=pos.z},
		{x=pos.x,   y=pos.y+1, z=pos.z},
		{x=pos.x,   y=pos.y-1, z=pos.z},
		{x=pos.x,   y=pos.y,   z=pos.z+1},
		{x=pos.x,   y=pos.y,   z=pos.z-1}}
	for i, cur_pos in pairs(positions) do
		if not all_nodes[poshash(cur_pos)] then
			add_network_node(PR_nodes, RE_nodes, BA_nodes, all_nodes, cur_pos, machines, tier, network_id, queue)
		end
	end
end

local function touch_nodes(list, tier)
	for _, pos in ipairs(list) do
		touch_node(tier, pos) -- Touch node
	end
end

local function get_network(network_id, tier)
	local cached = networks[network_id]
	if cached and cached.tier == tier then
		touch_nodes(cached.PR_nodes, tier)
		touch_nodes(cached.BA_nodes, tier)
		touch_nodes(cached.RE_nodes, tier)
		return cached.PR_nodes, cached.BA_nodes, cached.RE_nodes
	end
	return technic.build_network(network_id)
end

function technic.add_network_branch(queue, network)
	-- Adds whole branch to network, queue positions can be used to bypass sub branches
	local PR_nodes = network.PR_nodes -- Indexed array
	local BA_nodes = network.BA_nodes -- Indexed array
	local RE_nodes = network.RE_nodes -- Indexed array
	local all_nodes = network.all_nodes -- Hash table
	local network_id = network.id
	local tier = network.tier
	local machines = technic.machines[tier]
	local sw_pos = technic.network2sw_pos(network_id)
	--print(string.format("technic.add_network_branch(%s, %s, %.17g)",queue,minetest.pos_to_string(sw_pos),network.id))
	while next(queue) do
		local to_visit = {}
		for _, pos in ipairs(queue) do
			if vector.distance(pos, sw_pos) > switch_max_range then
				-- max range exceeded
				return
			end
			traverse_network(PR_nodes, RE_nodes, BA_nodes, all_nodes, pos,
					machines, tier, network_id, to_visit)
		end
		queue = to_visit
	end
end

-- Battery charge status updates for network
local function update_battery(self, charge, max_charge, supply, demand)
	self.battery_charge = self.battery_charge + charge
	self.battery_charge_max = self.battery_charge_max + max_charge
	self.battery_supply = self.battery_supply + supply
	self.battery_demand = self.battery_demand + demand
	if demand ~= 0 then
		self.BA_count_active = self.BA_count_active + 1
		self.BA_charge_active = self.BA_charge_active + charge
	end
end

-- Moving average function generator
local function sma(period)
	local values = {}
	local index = 1
	local sum = 0
	return function(n)
		-- Add new value and return average
		sum = sum - (values[index] or 0) + n
		values[index] = n
		index = index ~= period and index + 1 or 1
		return sum / #values
	end
end

function technic.build_network(network_id)
	technic.remove_network(network_id)
	local sw_pos = technic.network2sw_pos(network_id)
	local tier = technic.sw_pos2tier(sw_pos)
	if not tier then
		return
	end
	local network = {
		-- Basic network data and lookup table for attached nodes (no switching stations)
		id = network_id, tier = tier, all_nodes = {},
		-- Indexed arrays for iteration by machine type
		PR_nodes = {}, RE_nodes = {}, BA_nodes = {},
		-- Power generation, usage and capacity related variables
		supply = 0, demand = 0, battery_charge = 0, battery_charge_max = 0,
		BA_count_active = 0, BA_charge_active = 0, battery_supply = 0, battery_demand = 0,
		-- Battery status update function
		update_battery = update_battery,
		-- Network activation and excution control
		timeout = 0, skip = 0, lag = 0, average_lag = sma(5)
	}
	-- Add first cable (one that is holding network id) and build network
	local queue = {}
	add_cable_node(network.all_nodes, technic.network2pos(network_id), network_id, queue)
	technic.add_network_branch(queue, network)
	network.battery_count = #network.BA_nodes
	-- Add newly built network to cache array
	networks[network_id] = network
	-- And return producers, batteries and receivers (should this simply return network?)
	return network.PR_nodes, network.BA_nodes, network.RE_nodes
end

--
-- Execute technic power network
--
local node_technic_run = {}
minetest.register_on_mods_loaded(function()
	for name, _ in pairs(technic.machine_tiers) do
		if type(minetest.registered_nodes[name].technic_run) == "function" then
			node_technic_run[name] = minetest.registered_nodes[name].technic_run
		end
	end
end)

local function run_nodes(list, vm, run_stage, network)
	for _, pos in ipairs(list) do
		local node = minetest.get_node_or_nil(pos)
		if not node then
			vm:read_from_map(pos, pos)
			node = minetest.get_node_or_nil(pos)
		end
		if node and node.name and node_technic_run[node.name] then
			node_technic_run[node.name](pos, node, run_stage, network)
		end
	end
end

local mesecons_path = minetest.get_modpath("mesecons")
local digilines_path = minetest.get_modpath("digilines")

function technic.network_run(network_id)
	--
	-- !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!!
	-- TODO: This function requires a lot of cleanup
	-- It is moved here from switching_station.lua and still
	-- contain a lot of switching station specific stuff which
	-- should be removed and/or refactored.
	--

	local pos = technic.network2sw_pos(network_id)
	local t0 = minetest.get_us_time()

	local PR_nodes
	local BA_nodes
	local RE_nodes

	local tier = technic.sw_pos2tier(pos)
	local network
	if tier then
		PR_nodes, BA_nodes, RE_nodes = get_network(network_id, tier)
		if technic.is_overloaded(network_id) then return end
		network = networks[network_id]
	else
		--dprint("Not connected to a network")
		technic.network_infotext(network_id, S("%s Has No Network"):format(S("Switching Station")))
		return
	end

	-- Reset battery data for updates
	network.battery_charge = 0
	network.battery_charge_max = 0
	network.battery_supply = 0
	network.battery_demand = 0
	network.BA_count_active = 0
	network.BA_charge_active = 0

	local vm = VoxelManip()
	run_nodes(PR_nodes, vm, technic.producer)
	run_nodes(RE_nodes, vm, technic.receiver)
	run_nodes(BA_nodes, vm, technic.battery, network)

	-- Strings for the meta data
	local eu_demand_str    = tier.."_EU_demand"
	local eu_input_str     = tier.."_EU_input"
	local eu_supply_str    = tier.."_EU_supply"

	-- Distribute charge equally across multiple batteries.
	local charge_distributed = math.floor(network.BA_charge_active / network.BA_count_active)
	for n, pos1 in pairs(BA_nodes) do
		local meta1 = minetest.get_meta(pos1)
		if (meta1:get_int(eu_demand_str) ~= 0) then
			meta1:set_int("internal_EU_charge", charge_distributed)
		end
	end

	-- Get all the power from the PR nodes
	local PR_eu_supply = 0 -- Total power
	for _, pos1 in pairs(PR_nodes) do
		local meta1 = minetest.get_meta(pos1)
		PR_eu_supply = PR_eu_supply + meta1:get_int(eu_supply_str)
	end
	--dprint("Total PR supply:"..PR_eu_supply)

	-- Get all the demand from the RE nodes
	local RE_eu_demand = 0
	for _, pos1 in pairs(RE_nodes) do
		local meta1 = minetest.get_meta(pos1)
		RE_eu_demand = RE_eu_demand + meta1:get_int(eu_demand_str)
	end
	--dprint("Total RE demand:"..RE_eu_demand)

	technic.network_infotext(network_id, S("@1. Supply: @2 Demand: @3",
			S("Switching Station"), technic.EU_string(PR_eu_supply),
			technic.EU_string(RE_eu_demand)))

	-- If mesecon signal and power supply or demand changed then
	-- send them via digilines.
	if mesecons_path and digilines_path and mesecon.is_powered(pos) then
		if PR_eu_supply ~= network.supply or
				RE_eu_demand ~= network.demand then
			local meta = minetest.get_meta(pos)
			local channel = meta:get_string("channel")
			digilines.receptor_send(pos, technic.digilines.rules, channel, {
				supply = PR_eu_supply,
				demand = RE_eu_demand
			})
		end
	end

	-- Data that will be used by the power monitor
	network.supply = PR_eu_supply
	network.demand = RE_eu_demand
	network.battery_count = #BA_nodes

	-- If the PR supply is enough for the RE demand supply them all
	local BA_eu_demand = network.battery_demand
	if PR_eu_supply >= RE_eu_demand then
	--dprint("PR_eu_supply"..PR_eu_supply.." >= RE_eu_demand"..RE_eu_demand)
		for _, pos1 in pairs(RE_nodes) do
			local meta1 = minetest.get_meta(pos1)
			local eu_demand = meta1:get_int(eu_demand_str)
			meta1:set_int(eu_input_str, eu_demand)
		end
		-- We have a surplus, so distribute the rest equally to the BA nodes
		-- Let's calculate the factor of the demand
		PR_eu_supply = PR_eu_supply - RE_eu_demand
		local charge_factor = 0 -- Assume all batteries fully charged
		if BA_eu_demand > 0 then
			charge_factor = PR_eu_supply / BA_eu_demand
		end
		-- TODO: EU input for all batteries: math.floor(BA_eu_demand * charge_factor * #BA_nodes)
		for n, pos1 in pairs(BA_nodes) do
			local meta1 = minetest.get_meta(pos1)
			local eu_demand = meta1:get_int(eu_demand_str)
			meta1:set_int(eu_input_str, math.floor(eu_demand * charge_factor))
			--dprint("Charging battery:"..math.floor(eu_demand*charge_factor))
		end
		local t1 = minetest.get_us_time()
		local diff = t1 - t0
		if diff > 50000 then
			minetest.log("warning", "[technic] [+supply] technic_run took " .. diff .. " us at " .. minetest.pos_to_string(pos))
		end

		return
	end

	-- If the PR supply is not enough for the RE demand we will discharge the batteries too
	local BA_eu_supply = network.battery_supply
	if PR_eu_supply + BA_eu_supply >= RE_eu_demand then
		--dprint("PR_eu_supply "..PR_eu_supply.."+BA_eu_supply "..BA_eu_supply.." >= RE_eu_demand"..RE_eu_demand)
		for _, pos1 in pairs(RE_nodes) do
			local meta1  = minetest.get_meta(pos1)
			local eu_demand = meta1:get_int(eu_demand_str)
			meta1:set_int(eu_input_str, eu_demand)
		end
		-- We have a deficit, so distribute to the BA nodes
		-- Let's calculate the factor of the supply
		local charge_factor = 0 -- Assume all batteries depleted
		if BA_eu_supply > 0 then
			charge_factor = (PR_eu_supply - RE_eu_demand) / BA_eu_supply
		end
		for n,pos1 in pairs(BA_nodes) do
			local meta1 = minetest.get_meta(pos1)
			local eu_supply = meta1:get_int(eu_supply_str)
			meta1:set_int(eu_input_str, math.floor(eu_supply * charge_factor))
			--dprint("Discharging battery:"..math.floor(eu_supply*charge_factor))
		end
		local t1 = minetest.get_us_time()
		local diff = t1 - t0
		if diff > 50000 then
			minetest.log("warning", "[technic] [-supply] technic_run took " .. diff .. " us at " .. minetest.pos_to_string(pos))
		end

		return
	end

	-- If the PR+BA supply is not enough for the RE demand: Power only the batteries
	local charge_factor = 0 -- Assume all batteries fully charged
	if BA_eu_demand > 0 then
		charge_factor = PR_eu_supply / BA_eu_demand
	end
	for n, pos1 in pairs(BA_nodes) do
		local meta1 = minetest.get_meta(pos1)
		local eu_demand = meta1:get_int(eu_demand_str)
		meta1:set_int(eu_input_str, math.floor(eu_demand * charge_factor))
	end
	for n, pos1 in pairs(RE_nodes) do
		local meta1 = minetest.get_meta(pos1)
		meta1:set_int(eu_input_str, 0)
	end

	local t1 = minetest.get_us_time()
	local diff = t1 - t0
	if diff > 50000 then
		minetest.log("warning", "[technic] technic_run took " .. diff .. " us at " .. minetest.pos_to_string(pos))
	end

end
