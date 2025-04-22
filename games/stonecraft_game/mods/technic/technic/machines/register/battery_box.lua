
local digilines_path = minetest.get_modpath("digilines")

local S = technic.getter
local tube_entry = "^pipeworks_tube_connection_metallic.png"
local cable_entry = "^technic_cable_connection_overlay.png"

technic.register_power_tool("technic:battery", 10000)
technic.register_power_tool("technic:red_energy_crystal", 50000)
technic.register_power_tool("technic:green_energy_crystal", 150000)
technic.register_power_tool("technic:blue_energy_crystal", 450000)

-- Battery recipes:
-- Tin-copper recipe:
minetest.register_craft({
	output = "technic:battery",
	recipe = {
		{"group:wood", "default:copper_ingot", "group:wood"},
		{"group:wood", "default:tin_ingot",    "group:wood"},
		{"group:wood", "default:copper_ingot", "group:wood"},
	}
})
-- Sulfur-lead-water recipes:
-- With sulfur lumps:
-- With water:
minetest.register_craft({
	output = "technic:battery",
	recipe = {
		{"group:wood",         "technic:sulfur_lump", "group:wood"},
		{"technic:lead_ingot", "bucket:bucket_water", "technic:lead_ingot"},
		{"group:wood",         "technic:sulfur_lump", "group:wood"},
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty"}
	}
})
-- With oil extract:
minetest.register_craft({
	output = "technic:battery",
	recipe = {
		{"group:wood",         "technic:sulfur_lump",   "group:wood"},
		{"technic:lead_ingot", "homedecor:oil_extract", "technic:lead_ingot"},
		{"group:wood",         "technic:sulfur_lump",   "group:wood"},
	}
})
-- With sulfur dust:
-- With water:
minetest.register_craft({
	output = "technic:battery",
	recipe = {
		{"group:wood",         "technic:sulfur_dust", "group:wood"},
		{"technic:lead_ingot", "bucket:bucket_water", "technic:lead_ingot"},
		{"group:wood",         "technic:sulfur_dust", "group:wood"},
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty"}
	}
})
-- With oil extract:
minetest.register_craft({
	output = "technic:battery",
	recipe = {
		{"group:wood",         "technic:sulfur_dust",   "group:wood"},
		{"technic:lead_ingot", "homedecor:oil_extract", "technic:lead_ingot"},
		{"group:wood",         "technic:sulfur_dust",   "group:wood"},
	}
})

minetest.register_tool("technic:battery", {
	description = S("RE Battery"),
	inventory_image = "technic_battery.png",
	wear_represents = "technic_RE_charge",
	on_refill = technic.refill_RE_charge,
	tool_capabilities = {
		charge = 0,
		max_drop_level = 0,
		groupcaps = {
			fleshy = {times={}, uses=10000, maxlevel=0}
		}
	}
})

-- x+2 + (z+2)*2
local dirtab = {
	[4] = 2,
	[5] = 3,
	[7] = 1,
	[8] = 0
}

local tube = {
	insert_object = function(pos, node, stack, direction)
		if direction.y == 1
			or (direction.y == 0 and dirtab[direction.x+2+(direction.z+2)*2] == node.param2) then
			return stack
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if direction.y == 0 then
			return inv:add_item("src", stack)
		else
			return inv:add_item("dst", stack)
		end
	end,
	can_insert = function(pos, node, stack, direction)
		if direction.y == 1
			or (direction.y == 0 and dirtab[direction.x+2+(direction.z+2)*2] == node.param2) then
			return false
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if direction.y == 0 then
			return inv:room_for_item("src", stack)
		else
			return inv:room_for_item("dst", stack)
		end
	end,
	connect_sides = {left=1, right=1, back=1, top=1},
}

function technic.register_battery_box(data)
	local tier = data.tier
	local ltier = string.lower(tier)
	local formspec =
		"size[8,9]"..
		"image[1,1;1,2;technic_power_meter_bg.png]"..
		"list[context;src;3,1;1,1;]"..
		"image[4,1;1,1;technic_battery_reload.png]"..
		"list[context;dst;5,1;1,1;]"..
		"label[0,0;"..S("%s Battery Box"):format(tier).."]"..
		"label[3,0;"..S("Charge").."]"..
		"label[5,0;"..S("Discharge").."]"..
		"label[1,3;"..S("Power level").."]"..
		"list[current_player;main;0,5;8,4;]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		(data.upgrade and
			"list[context;upgrade1;3.5,3;1,1;]"..
			"list[context;upgrade2;4.5,3;1,1;]"..
			"label[3.5,4;"..S("Upgrade Slots").."]"..
			"listring[context;upgrade1]"..
			"listring[current_player;main]"..
			"listring[context;upgrade2]"..
			"listring[current_player;main]"
		or "")

	--
	-- Generate formspec with power meter
	--
	local function get_formspec(charge_ratio, channel)
		return formspec .. "image[1,1;1,2;technic_power_meter_bg.png^[lowpart:" ..
			math.floor(charge_ratio * 100) .. ":technic_power_meter_fg.png]" ..
			(digilines_path and
				("field[0.3,4;2.2,1;channel;Digiline channel;%s]button[2,3.7;1,1;setchannel;Set]")
				:format(minetest.formspec_escape(channel))
			or "")

	end

	--
	-- Update fields not affecting internal network calculations and behavior in any way
	--
	local function update_node(pos, update_formspec)
		-- Read metadata and calculate actual values based on upgrades
		local meta = minetest.get_meta(pos)
		local current_charge = meta:get_int("internal_EU_charge")
		local EU_upgrade = 0
		if data.upgrade then
			EU_upgrade = technic.handle_machine_upgrades(meta)
		end
		local max_charge = data.max_charge * (1 + EU_upgrade / 10)
		-- Select node textures
		local charge_ratio = current_charge / max_charge
		local charge_count = math.ceil(charge_ratio * 8)
		charge_count = math.min(charge_count, 8)
		charge_count = math.max(charge_count, 0)
		local last_count = meta:get_float("last_side_shown")
		if charge_count ~= last_count then
			technic.swap_node(pos, "technic:" .. ltier .. "_battery_box" .. charge_count)
			meta:set_float("last_side_shown", charge_count)
		end
		-- Update formspec and infotext
		local eu_input = meta:get_int(tier.."_EU_input")
		local infotext = S("@1 Battery Box: @2 / @3", tier,
			technic.EU_string(current_charge), technic.EU_string(max_charge))
		if eu_input == 0 then
			infotext = S("%s Idle"):format(infotext)
		end
		meta:set_string("infotext", infotext)
		if update_formspec then
			local channel = meta:get_string("channel")
			meta:set_string("formspec", get_formspec(charge_ratio, channel))
		end
	end

	local function get_tool(inventory, listname)
		-- Get itemstack and check if it is registered tool
		if inventory:is_empty(listname) then
			return
		end
		local toolstack = inventory:get_stack(listname, 1)
		local toolname = toolstack:get_name()
		if technic.power_tools[toolname] == nil then
			return
		end
		local tooldef = toolstack:get_definition()
		if not tooldef then
			return
		end
		return toolstack, tooldef
	end

	local function charge_tools(meta, batt_charge, charge_step)
		if batt_charge <= 0 then
			return batt_charge, false
		end
		-- Get tool stack and definition
		local inv = meta:get_inventory()
		local toolstack, tooldef = get_tool(inv, "src")
		if not toolstack then return batt_charge, false end
		-- Do the charging, get and check
		local get_charge = tooldef.technic_get_charge or technic.get_charge
		local tool_charge, max_charge = get_charge(toolstack)
		if tool_charge >= max_charge then
			return batt_charge, true
		end
		-- Do the charging, set charge and replace stack
		local set_charge = tooldef.technic_set_charge or technic.set_charge
		charge_step = math.min(charge_step, batt_charge)
		charge_step = math.min(charge_step, max_charge - tool_charge)
		tool_charge = tool_charge + charge_step
		set_charge(toolstack, tool_charge)
		inv:set_stack("src", 1, toolstack)
		return batt_charge - charge_step, (tool_charge == max_charge)
	end

	local function discharge_tools(meta, batt_charge, charge_step, batt_max_charge)
		if batt_charge >= batt_max_charge then
			return batt_charge, false
		end
		-- Get tool stack and definition
		local inv = meta:get_inventory()
		local toolstack, tooldef = get_tool(inv, "dst")
		if not toolstack then return batt_charge, false end
		-- Do the discharging, get and check
		local get_charge = tooldef.technic_get_charge or technic.get_charge
		local tool_charge = get_charge(toolstack)
		if tool_charge <= 0 then
			return batt_charge, true
		end
		-- Do the discharging, set charge and replace stack
		local set_charge = tooldef.technic_set_charge or technic.set_charge
		charge_step = math.min(charge_step, batt_max_charge - batt_charge)
		charge_step = math.min(charge_step, tool_charge)
		tool_charge = tool_charge - charge_step
		set_charge(toolstack, tool_charge)
		inv:set_stack("dst", 1, toolstack)
		return batt_charge + charge_step, (tool_charge == 0)
	end

	local function run(pos, node, run_state, network)
		local meta  = minetest.get_meta(pos)

		local eu_input       = meta:get_int(tier.."_EU_input")
		local current_charge = meta:get_int("internal_EU_charge")

		local EU_upgrade, tube_upgrade = 0, 0
		if data.upgrade then
			EU_upgrade, tube_upgrade = technic.handle_machine_upgrades(meta)
		end
		local max_charge = data.max_charge * (1 + EU_upgrade / 10)

		-- Charge/discharge the battery with the input EUs
		if eu_input >= 0 then
			current_charge = math.min(current_charge + eu_input, max_charge)
		else
			current_charge = math.max(current_charge + eu_input, 0)
		end

		-- Charging/discharging tools here
		local tool_full, tool_empty
		current_charge, tool_full = charge_tools(meta, current_charge, data.charge_step)
		current_charge, tool_empty = discharge_tools(meta, current_charge, data.discharge_step, max_charge)

		if data.tube and (tool_full or tool_empty) then
			technic.handle_machine_pipeworks(pos, tube_upgrade, function(pos2, x_velocity, z_velocity)
				if tool_full then
					technic.send_items(pos2, x_velocity, z_velocity, "src")
				elseif tool_empty then
					technic.send_items(pos2, x_velocity, z_velocity, "dst")
				end
			end)
		end

		-- We allow batteries to charge on less than the demand
		local supply = math.min(data.discharge_rate, current_charge)
		local demand = math.min(data.charge_rate, max_charge - current_charge)
		network:update_battery(current_charge, max_charge, supply, demand)

		meta:set_int(tier.."_EU_demand", demand)
		meta:set_int(tier.."_EU_supply", supply)
		meta:set_int("internal_EU_charge", current_charge)
		meta:set_int("internal_EU_charge_max", max_charge)

		local timer = minetest.get_node_timer(pos)
		if not timer:is_started() then
			timer:start(2)
		end
	end

	local function on_timer(pos, elapsed)
		if not technic.pos2network(pos) then return end
		update_node(pos)
		return true
	end

	for i = 0, 8 do
		local groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2,
				technic_machine=1, ["technic_"..ltier]=1}
		if i ~= 0 then
			groups.not_in_creative_inventory = 1
		end

		if data.tube then
			groups.tubedevice = 1
			groups.tubedevice_receiver = 1
		end

		local top_tex = "technic_"..ltier.."_battery_box_top.png"..tube_entry
		local front_tex = "technic_"..ltier.."_battery_box_front.png^technic_power_meter"..i..".png"
		local side_tex = "technic_"..ltier.."_battery_box_side.png"..tube_entry
		local bottom_tex = "technic_"..ltier.."_battery_box_bottom.png"..cable_entry

		if ltier == "lv" then
			top_tex = "technic_"..ltier.."_battery_box_top.png"
			front_tex = "technic_"..ltier.."_battery_box_side.png^technic_power_meter"..i..".png"
			side_tex = "technic_"..ltier.."_battery_box_side.png^technic_power_meter"..i..".png"
		end

		minetest.register_node("technic:"..ltier.."_battery_box"..i, {
			description = S("%s Battery Box"):format(tier),
			tiles = {
				top_tex,
				bottom_tex,
				side_tex,
				side_tex,
				side_tex,
				front_tex},
			groups = groups,
			connect_sides = {"bottom"},
			tube = data.tube and tube or nil,
			paramtype2 = "facedir",
			sounds = default.node_sound_wood_defaults(),
			drop = "technic:"..ltier.."_battery_box0",
			on_construct = function(pos)
				local meta = minetest.get_meta(pos)
				meta:set_string("infotext", S("%s Battery Box"):format(tier))
				meta:set_int(tier.."_EU_demand", 0)
				meta:set_int(tier.."_EU_supply", 0)
				meta:set_int(tier.."_EU_input",  0)
				meta:set_float("internal_EU_charge", 0)
				local inv = meta:get_inventory()
				inv:set_size("src", 1)
				inv:set_size("dst", 1)
				inv:set_size("upgrade1", 1)
				inv:set_size("upgrade2", 1)
				update_node(pos, true)
			end,
			can_dig = technic.machine_can_dig,
			allow_metadata_inventory_put = technic.machine_inventory_put,
			allow_metadata_inventory_take = technic.machine_inventory_take,
			allow_metadata_inventory_move = technic.machine_inventory_move,
			technic_run = run,
			on_timer = on_timer,
			on_rightclick = function(pos) update_node(pos, true) end,
			on_rotate = screwdriver.rotate_simple,
			after_place_node = data.tube and pipeworks.after_place,
			after_dig_node = technic.machine_after_dig_node,
			on_receive_fields = function(pos, formname, fields, player)
				local name = player:get_player_name()
				if minetest.is_protected(pos, name) then
					minetest.record_protection_violation(pos, name)
					return
				elseif fields.setchannel then
					local meta = minetest.get_meta(pos)
					meta:set_string("channel", fields.channel or "")
					update_node(pos, true)
				end
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
						local inv = meta:get_inventory()
						digilines.receptor_send(pos, technic.digilines.rules, channel, {
							demand = meta:get_int(tier.."_EU_demand"),
							supply = meta:get_int(tier.."_EU_supply"),
							input  = meta:get_int(tier.."_EU_input"),
							charge = meta:get_int("internal_EU_charge"),
							max_charge = data.max_charge * (1 + technic.handle_machine_upgrades(meta) / 10),
							src      = inv:get_stack("src", 1):to_table(),
							dst      = inv:get_stack("dst", 1):to_table(),
							upgrade1 = inv:get_stack("upgrade1", 1):to_table(),
							upgrade2 = inv:get_stack("upgrade2", 1):to_table()
						})
					end
				},
			},
		})
	end

	-- Register as a battery type
	-- Battery type machines function as power reservoirs and can both receive and give back power
	for i = 0, 8 do
		technic.register_machine(tier, "technic:"..ltier.."_battery_box"..i, technic.battery)
	end

end -- End registration
