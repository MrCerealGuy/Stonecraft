--
-- Compatibility hacks for digtron to work well with technic plus new network system
--
-- More information:
-- https://github.com/mt-mods/technic/issues/100
--

local function power_connector_compat()
	local digtron_technic_run = minetest.registered_nodes["digtron:power_connector"].technic_run
	minetest.override_item("digtron:power_connector",{
		technic_run = function(pos, node)
			local network_id = technic.pos2network(pos)
			local sw_pos = network_id and technic.network2sw_pos(network_id)
			local meta = minetest.get_meta(pos)
			meta:set_string("HV_network", sw_pos and minetest.pos_to_string(sw_pos) or "")
			return digtron_technic_run(pos, node)
		end,
		technic_on_disable = function(pos, node)
			local meta = minetest.get_meta(pos)
			meta:set_string("HV_network", "")
			meta:set_string("HV_EU_input", "")
		end,
	})
end

minetest.register_on_mods_loaded(function()
	if minetest.registered_nodes["digtron:power_connector"] then
		power_connector_compat()
	end
end)
