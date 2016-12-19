--- Forcefield generator.
-- @author ShadowNinja
--
-- Forcefields are powerful barriers but they consume huge amounts of power.
-- The forcefield Generator is an HV machine.

-- How expensive is the generator?
-- Leaves room for upgrades lowering the power drain?
local forcefield_power_drain   = 10

local S = technic.getter

minetest.register_craft({
	output = "technic:forcefield_emitter_off",
	recipe = {
			{"default:mese",         "technic:motor",          "default:mese"        },
			{"technic:deployer_off", "technic:machine_casing", "technic:deployer_off"},
			{"default:mese",         "technic:hv_cable",       "default:mese"        },
	}
})


local replaceable_cids = {}

minetest.after(0, function()
	for name, ndef in pairs(minetest.registered_nodes) do
		if ndef.buildable_to == true and name ~= "ignore" then
			replaceable_cids[minetest.get_content_id(name)] = true
		end
	end
end)


-- Idea: Let forcefields have different colors by upgrade slot.
-- Idea: Let forcefields add up by detecting if one hits another.
--    ___   __
--   /   \/   \
--  |          |
--   \___/\___/

local function update_forcefield(pos, meta, active, first)
	local shape = meta:get_int("shape")
	local range = meta:get_int("range")
	local vm = VoxelManip()
	local MinEdge, MaxEdge = vm:read_from_map(vector.subtract(pos, range),
			vector.add(pos, range))
	local area = VoxelArea:new({MinEdge = MinEdge, MaxEdge = MaxEdge})
	local data = vm:get_data()

	local c_air = minetest.get_content_id("air")
	local c_field = minetest.get_content_id("technic:forcefield")

	for z = -range, range do
	for y = -range, range do
	local vi = area:index(pos.x + (-range), pos.y + y, pos.z + z)
	for x = -range, range do
		local relevant
		if shape == 0 then
			local squared = x * x + y * y + z * z
			relevant =
				squared <= range       *  range      +  range and
				squared >= (range - 1) * (range - 1) + (range - 1)
		else
			relevant =
				x == -range or x == range or
				y == -range or y == range or
				z == -range or z == range
		end
		if relevant then
			local cid = data[vi]
			if active and replaceable_cids[cid] then
				data[vi] = c_field
			elseif not active and cid == c_field then
				data[vi] = c_air
			end
		end
		vi = vi + 1
	end
	end
	end

	vm:set_data(data)
	vm:update_liquids()
	vm:write_to_map()
	-- update_map is very slow, but if we don't call it we'll
	-- get phantom blocks on the client.
	if not active or first then
		vm:update_map()
	end
end

local function set_forcefield_formspec(meta)
	local formspec = "size[5,2.25]"..
		"field[0.3,0.5;2,1;range;"..S("Range")..";"..meta:get_int("range").."]"
	-- The names for these toggle buttons are explicit about which
	-- state they'll switch to, so that multiple presses (arising
	-- from the ambiguity between lag and a missed press) only make
	-- the single change that the user expects.
	if meta:get_int("shape") == 0 then
		formspec = formspec.."button[3,0.2;2,1;shape1;"..S("Sphere").."]"
	else
		formspec = formspec.."button[3,0.2;2,1;shape0;"..S("Cube").."]"
	end
	if meta:get_int("mesecon_mode") == 0 then
		formspec = formspec.."button[0,1;5,1;mesecon_mode_1;"..S("Ignoring Mesecon Signal").."]"
	else
		formspec = formspec.."button[0,1;5,1;mesecon_mode_0;"..S("Controlled by Mesecon Signal").."]"
	end
	if meta:get_int("enabled") == 0 then
		formspec = formspec.."button[0,1.75;5,1;enable;"..S("%s Disabled"):format(S("%s Forcefield Emitter"):format("HV")).."]"
	else
		formspec = formspec.."button[0,1.75;5,1;disable;"..S("%s Enabled"):format(S("%s Forcefield Emitter"):format("HV")).."]"
	end
	meta:set_string("formspec", formspec)
end

local forcefield_receive_fields = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local range = nil
	if fields.range then
		range = tonumber(fields.range) or 0
		-- Smallest field is 5. Anything less is asking for trouble.
		-- Largest is 20. It is a matter of pratical node handling.
		-- At the maximim range updating the forcefield takes about 0.2s
		range = math.max(range, 5)
		range = math.min(range, 20)
		if range == meta:get_int("range") then range = nil end
	end
	if fields.shape0 or fields.shape1 or range then
		update_forcefield(pos, meta, false)
	end
	if range then meta:set_int("range", range) end
	if fields.shape0 then meta:set_int("shape", 0) end
	if fields.shape1 then meta:set_int("shape", 1) end
	if fields.enable then meta:set_int("enabled", 1) end
	if fields.disable then meta:set_int("enabled", 0) end
	if fields.mesecon_mode_0 then meta:set_int("mesecon_mode", 0) end
	if fields.mesecon_mode_1 then meta:set_int("mesecon_mode", 1) end
	set_forcefield_formspec(meta)
end

local mesecons = {
	effector = {
		action_on = function(pos, node)
			minetest.get_meta(pos):set_int("mesecon_effect", 1)
		end,
		action_off = function(pos, node)
			minetest.get_meta(pos):set_int("mesecon_effect", 0)
		end
	}
}

local function run(pos, node)
	local meta = minetest.get_meta(pos)
	local eu_input   = meta:get_int("HV_EU_input")
	local enabled = meta:get_int("enabled") ~= 0 and (meta:get_int("mesecon_mode") == 0 or meta:get_int("mesecon_effect") ~= 0)
	local machine_name = S("%s Forcefield Emitter"):format("HV")

	local range = meta:get_int("range")
	local power_requirement
	if meta:get_int("shape") == 0 then
		power_requirement = math.floor(4 * math.pi * range * range)
	else
		power_requirement = 24 * range * range
	end
	power_requirement = power_requirement * forcefield_power_drain

	if not enabled then
		if node.name == "technic:forcefield_emitter_on" then
			update_forcefield(pos, meta, false)
			technic.swap_node(pos, "technic:forcefield_emitter_off")
			meta:set_string("infotext", S("%s Disabled"):format(machine_name))
		end
		meta:set_int("HV_EU_demand", 0)
		return
	end
	meta:set_int("HV_EU_demand", power_requirement)
	if eu_input < power_requirement then
		meta:set_string("infotext", S("%s Unpowered"):format(machine_name))
		if node.name == "technic:forcefield_emitter_on" then
			update_forcefield(pos, meta, false)
			technic.swap_node(pos, "technic:forcefield_emitter_off")
		end
	elseif eu_input >= power_requirement then
		local first = false
		if node.name == "technic:forcefield_emitter_off" then
			first = true
			technic.swap_node(pos, "technic:forcefield_emitter_on")
			meta:set_string("infotext", S("%s Active"):format(machine_name))
		end
		update_forcefield(pos, meta, true, first)
	end
end

minetest.register_node("technic:forcefield_emitter_off", {
	description = S("%s Forcefield Emitter"):format("HV"),
	tiles = {"technic_forcefield_emitter_off.png"},
	groups = {cracky = 1, technic_machine = 1, technic_hv = 1},
	on_receive_fields = forcefield_receive_fields,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_int("HV_EU_input", 0)
		meta:set_int("HV_EU_demand", 0)
		meta:set_int("range", 10)
		meta:set_int("enabled", 0)
		meta:set_int("mesecon_mode", 0)
		meta:set_int("mesecon_effect", 0)
		meta:set_string("infotext", S("%s Forcefield Emitter"):format("HV"))
		set_forcefield_formspec(meta)
	end,
	mesecons = mesecons,
	technic_run = run,
})

minetest.register_node("technic:forcefield_emitter_on", {
	description = S("%s Forcefield Emitter"):format("HV"),
	tiles = {"technic_forcefield_emitter_on.png"},
	groups = {cracky = 1, technic_machine = 1, technic_hv = 1,
			not_in_creative_inventory=1},
	drop = "technic:forcefield_emitter_off",
	on_receive_fields = forcefield_receive_fields,
	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
		update_forcefield(pos, meta, false)
	end,
	mesecons = mesecons,
	technic_run = run,
	technic_on_disable = function (pos, node)
		local meta = minetest.get_meta(pos)
		update_forcefield(pos, meta, false)
		technic.swap_node(pos, "technic:forcefield_emitter_off")
	end,
})

minetest.register_node("technic:forcefield", {
	description = S("%s Forcefield"):format("HV"),
	sunlight_propagates = true,
	drawtype = "glasslike",
	groups = {not_in_creative_inventory=1},
	paramtype = "light",
        light_source = 15,
	diggable = false,
	drop = '',
	tiles = {{
		name = "technic_forcefield_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1.0,
		},
	}},
})


if minetest.get_modpath("mesecons_mvps") then
	mesecon.register_mvps_stopper("technic:forcefield")
end

technic.register_machine("HV", "technic:forcefield_emitter_on",  technic.receiver)
technic.register_machine("HV", "technic:forcefield_emitter_off", technic.receiver)

