--[[

2017-05-17 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local new_flow_logic_register = pipeworks.flowables.register

local polys = ""
if pipeworks.enable_lowpoly then polys = "_lowpoly" end

-- rotation handlers

function pipeworks.fix_after_rotation(pos, node, user, mode, new_param2)

	if string.find(node.name, "spigot") then new_param2 = new_param2 % 4 end

	newnode = string.gsub(node.name, "_on", "_off")
	minetest.swap_node(pos, { name = newnode, param2 = new_param2 })
	pipeworks.scan_for_pipe_objects(pos)

	return true
end

function pipeworks.rotate_on_place(itemstack, placer, pointed_thing)

	local playername = placer:get_player_name()
	if not minetest.is_protected(pointed_thing.under, playername) 
	   and not minetest.is_protected(pointed_thing.above, playername) then

		local node = minetest.get_node(pointed_thing.under)

		if (not placer:get_player_control().sneak)
		  and minetest.registered_nodes[node.name]
		  and minetest.registered_nodes[node.name].on_rightclick then
			minetest.registered_nodes[node.name].on_rightclick(pointed_thing.under, node, placer, itemstack)
		else

			local pitch = placer:get_look_pitch()
			local above = pointed_thing.above
			local under = pointed_thing.under
			local fdir = minetest.dir_to_facedir(placer:get_look_dir())
			local undernode = minetest.get_node(under)
			local abovenode = minetest.get_node(above)
			local uname = undernode.name
			local aname = abovenode.name
			local isabove = (above.x == under.x) and (above.z == under.z) and (pitch > 0)
			local pos1 = above

			-- check if the object should be turned vertically
			if above.x == under.x
				and above.z == under.z
				and (
				  string.find(uname, "pipeworks:pipe_")
				  or string.find(uname, "pipeworks:storage_")
				  or string.find(uname, "pipeworks:expansion_")
				  or ( string.find(uname, "pipeworks:grating") and not isabove )
				  or ( string.find(uname, "pipeworks:pump_") and not isabove )

				  or (
						( string.find(uname, "pipeworks:valve")
						  or string.find(uname, "pipeworks:entry_panel")
						  or string.find(uname, "pipeworks:flow_sensor") )
						and minetest.facedir_to_dir(undernode.param2).y ~= 0 )
					)
			then
				fdir = 17
			end

			if minetest.registered_nodes[uname]
			  and minetest.registered_nodes[uname]["buildable_to"] then
				pos1 = under
			end

			if minetest.registered_nodes[minetest.get_node(pos1).name]
			  and not minetest.registered_nodes[minetest.get_node(pos1).name]["buildable_to"] then return end

			local placednode = string.gsub(itemstack:get_name(), "_loaded", "_empty")
			placednode = string.gsub(placednode, "_on", "_off")

			minetest.swap_node(pos1, {name = placednode, param2 = fdir })
			pipeworks.scan_for_pipe_objects(pos1)

			if not pipeworks.expect_infinite_stacks then
				itemstack:take_item()
			end
		end
	end
	return itemstack
end

-- List of devices that should participate in the autoplace algorithm

local pipereceptor_on = nil
local pipereceptor_off = nil

if minetest.get_modpath("mesecons") and not core.skip_mod("mesecons") then
	pipereceptor_on = {
		receptor = {
			state = mesecon.state.on,
			rules = pipeworks.mesecons_rules
		}
	}

	pipereceptor_off = {
		receptor = {
			state = mesecon.state.off,
			rules = pipeworks.mesecons_rules
		}
	}
end

local pipes_devicelist = {
	"pump",
	"valve",
	"storage_tank_0",
	"storage_tank_1",
	"storage_tank_2",
	"storage_tank_3",
	"storage_tank_4",
	"storage_tank_5",
	"storage_tank_6",
	"storage_tank_7",
	"storage_tank_8",
	"storage_tank_9",
	"storage_tank_10"
}

-- Now define the nodes.

local states = { "on", "off" }
local dgroups = ""

for s in ipairs(states) do

	if states[s] == "off" then
		dgroups = {snappy=3, pipe=1}
	else
		dgroups = {snappy=3, pipe=1, not_in_creative_inventory=1}
	end

	local pumpname = "pipeworks:pump_"..states[s]
	minetest.register_node(pumpname, {
		description = S("Pump/Intake Module"),
		drawtype = "mesh",
		mesh = "pipeworks_pump"..polys..".obj",
		tiles = { "pipeworks_pump_"..states[s]..".png" },
		paramtype = "light",
		paramtype2 = "facedir",
		groups = dgroups,
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		pipe_connections = { top = 1 },
		after_place_node = function(pos)
			pipeworks.scan_for_pipe_objects(pos)
		end,
		after_dig_node = function(pos)
			pipeworks.scan_for_pipe_objects(pos)
		end,
		drop = "pipeworks:pump_off",
		mesecons = {effector = {
			action_on = function (pos, node)
				minetest.swap_node(pos,{name="pipeworks:pump_on", param2 = node.param2})
			end,
			action_off = function (pos, node)
				minetest.swap_node(pos,{name="pipeworks:pump_off", param2 = node.param2})
			end
		}},
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local fdir = node.param2
			minetest.swap_node(pos, { name = "pipeworks:pump_"..states[3-s], param2 = fdir })
		end,
		on_rotate = screwdriver.rotate_simple
	})

	-- FIXME: this currently assumes that pumps can only rotate around the fixed axis pointing Y+.
	new_flow_logic_register.directional_vertical_fixed(pumpname, true)
	local pump_drive = 4
	if states[s] ~= "off" then
		new_flow_logic_register.intake_simple(pumpname, pump_drive)
	end



	local nodename_valve_empty = "pipeworks:valve_"..states[s].."_empty"
	minetest.register_node(nodename_valve_empty, {
		description = S("Valve"),
		drawtype = "mesh",
		mesh = "pipeworks_valve_"..states[s]..polys..".obj",
		tiles = { "pipeworks_valve.png" },
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = {
	             	type = "fixed",
			fixed = { -5/16, -4/16, -8/16, 5/16, 5/16, 8/16 }
		},
		collision_box = {
	             	type = "fixed",
			fixed = { -5/16, -4/16, -8/16, 5/16, 5/16, 8/16 }
		},
		groups = dgroups,
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		on_place = pipeworks.rotate_on_place,
		after_dig_node = function(pos)
			pipeworks.scan_for_pipe_objects(pos)
		end,
		drop = "pipeworks:valve_off_empty",
		mesecons = {effector = {
			action_on = function (pos, node)
				minetest.swap_node(pos,{name="pipeworks:valve_on_empty", param2 = node.param2})
			end,
			action_off = function (pos, node)
				minetest.swap_node(pos,{name="pipeworks:valve_off_empty", param2 = node.param2})
			end
		}},
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local fdir = node.param2
			minetest.swap_node(pos, { name = "pipeworks:valve_"..states[3-s].."_empty", param2 = fdir })
		end,
		on_rotate = pipeworks.fix_after_rotation
	})
	-- only register flow logic for the "on" ABM.
	-- this means that the off state automatically blocks flow by not participating in the balancing operation.
	if states[s] ~= "off" then
		new_flow_logic_register.directional_horizonal_rotate(nodename_valve_empty, true)
	end
end

local nodename_valve_loaded = "pipeworks:valve_on_loaded"
minetest.register_node(nodename_valve_loaded, {
	description = S("Valve"),
	drawtype = "mesh",
	mesh = "pipeworks_valve_on"..polys..".obj",
	tiles = { "pipeworks_valve.png" },
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	selection_box = {
             	type = "fixed",
		fixed = { -5/16, -4/16, -8/16, 5/16, 5/16, 8/16 }
	},
	collision_box = {
             	type = "fixed",
		fixed = { -5/16, -4/16, -8/16, 5/16, 5/16, 8/16 }
	},
	groups = {snappy=3, pipe=1, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	on_place = pipeworks.rotate_on_place,
	after_dig_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	drop = "pipeworks:valve_off_empty",
	mesecons = {effector = {
		action_on = function (pos, node)
			minetest.swap_node(pos,{name="pipeworks:valve_on_empty", param2 = node.param2})
		end,
		action_off = function (pos, node)
			minetest.swap_node(pos,{name="pipeworks:valve_off_empty", param2 = node.param2})
		end
	}},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local fdir = node.param2
		minetest.swap_node(pos, { name = "pipeworks:valve_off_empty", param2 = fdir })
	end,
	on_rotate = pipeworks.fix_after_rotation
})
-- register this the same as the on-but-empty variant, so existing nodes of this type work also.
-- note that as new_flow_logic code does not distinguish empty/full in node states,
-- right-clicking a "loaded" valve (becoming an off valve) then turning it on again will yield a on-but-empty valve,
-- but the flow logic will still function.
-- thus under new_flow_logic this serves as a kind of migration.
new_flow_logic_register.directional_horizonal_rotate(nodename_valve_loaded, true)

-- grating

-- FIXME: should this do anything useful in the new flow logic?
minetest.register_node("pipeworks:grating", {
	description = S("Decorative grating"),
	tiles = {
		"pipeworks_grating_top.png",
		"pipeworks_grating_sides.png",
		"pipeworks_grating_sides.png",
		"pipeworks_grating_sides.png",
		"pipeworks_grating_sides.png",
		"pipeworks_grating_sides.png"
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.49, -0.49, -0.49, 0.49, 0.5, 0.49 }
	},
	sunlight_propagates = true,
	paramtype = "light",
	groups = {snappy=3, pipe=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	pipe_connections = { top = 1 },
	after_place_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	on_rotate = false
})

-- outlet spigot

local nodename_spigot_empty = "pipeworks:spigot"
minetest.register_node(nodename_spigot_empty, {
	description = S("Spigot outlet"),
	drawtype = "mesh",
	mesh = "pipeworks_spigot"..polys..".obj",
	tiles = { "pipeworks_spigot.png" },
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	pipe_connections = { left=1, right=1, front=1, back=1,
						 left_param2 = 3, right_param2 = 1, front_param2 = 2, back_param2 = 0 },
	after_place_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	selection_box = {
		type = "fixed",
		fixed = { -2/16, -6/16, -2/16, 2/16, 2/16, 8/16 }
	},
	collision_box = {
		type = "fixed",
		fixed = { -2/16, -6/16, -2/16, 2/16, 2/16, 8/16 }
	},
	on_rotate = pipeworks.fix_after_rotation
})

local nodename_spigot_loaded = "pipeworks:spigot_pouring"
minetest.register_node(nodename_spigot_loaded, {
	description = ("Spigot outlet"),
	drawtype = "mesh",
	mesh = "pipeworks_spigot_pouring"..polys..".obj",
	tiles = {
		{
			name = "default_water_flowing_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{ name = "pipeworks_spigot.png" }
	},
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	pipe_connections = { left=1, right=1, front=1, back=1,
						 left_param2 = 3, right_param2 = 1, front_param2 = 2, back_param2 = 0 },
	after_place_node = function(pos)
		minetest.set_node(pos, { name = "pipeworks:spigot", param2 = minetest.get_node(pos).param2 })
		pipeworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	selection_box = {
		type = "fixed",
		fixed = { -2/16, -6/16, -2/16, 2/16, 2/16, 8/16 }
	},
	collision_box = {
		type = "fixed",
		fixed = { -2/16, -6/16, -2/16, 2/16, 2/16, 8/16 }
	},
	drop = "pipeworks:spigot",
	on_rotate = pipeworks.fix_after_rotation
})
-- new flow logic does not currently distinguish between these two visual states.
-- register both so existing flowing spigots continue to work (even if the visual doesn't match the spigot's behaviour).
new_flow_logic_register.directional_horizonal_rotate(nodename_spigot_empty, false)
new_flow_logic_register.directional_horizonal_rotate(nodename_spigot_loaded, false)
local spigot_upper = 1.0
local spigot_lower = 1.0
local spigot_neighbours={{x=0, y=-1, z=0}}
new_flow_logic_register.output_simple(nodename_spigot_empty, spigot_upper, spigot_lower, spigot_neighbours)
new_flow_logic_register.output_simple(nodename_spigot_loaded, spigot_upper, spigot_lower, spigot_neighbours)



-- sealed pipe entry/exit (horizontal pipe passing through a metal
-- wall, for use in places where walls should look like they're airtight)

local panel_cbox = {
	type = "fixed",
	fixed = {
		{ -2/16, -2/16, -8/16, 2/16, 2/16, 8/16 },
		{ -8/16, -8/16, -1/16, 8/16, 8/16, 1/16 }
	}
}

local nodename_panel_empty = "pipeworks:entry_panel_empty"
minetest.register_node(nodename_panel_empty, {
	description = S("Airtight Pipe entry/exit"),
	drawtype = "mesh",
	mesh = "pipeworks_entry_panel"..polys..".obj",
	tiles = { "pipeworks_entry_panel.png" },
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	on_place = pipeworks.rotate_on_place,
	after_dig_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	selection_box = panel_cbox,
	collision_box = panel_cbox,
	on_rotate = pipeworks.fix_after_rotation
})

local nodename_panel_loaded = "pipeworks:entry_panel_loaded"
minetest.register_node(nodename_panel_loaded, {
	description = S("Airtight Pipe entry/exit"),
	drawtype = "mesh",
	mesh = "pipeworks_entry_panel"..polys..".obj",
	tiles = { "pipeworks_entry_panel.png" },
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	on_place = pipeworks.rotate_on_place,
	after_dig_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	selection_box = panel_cbox,
	collision_box = panel_cbox,
	drop = "pipeworks:entry_panel_empty",
	on_rotate = pipeworks.fix_after_rotation
})
-- TODO: AFAIK the two panels have no visual difference, so are redundant under new flow logic - alias?
new_flow_logic_register.directional_horizonal_rotate(nodename_panel_empty, true)
new_flow_logic_register.directional_horizonal_rotate(nodename_panel_loaded, true)



local nodename_sensor_empty = "pipeworks:flow_sensor_empty"
minetest.register_node(nodename_sensor_empty, {
	description = S("Flow Sensor"),
	drawtype = "mesh",
	mesh = "pipeworks_flow_sensor"..polys..".obj",
	tiles = { "pipeworks_flow_sensor_off.png" },
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	on_place = pipeworks.rotate_on_place,
	after_dig_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	on_construct = function(pos)
		if mesecon then
			mesecon.receptor_off(pos, rules) 
		end
	end,
	selection_box = {
		type = "fixed",
		fixed = {
			{ -2/16, -2/16, -8/16, 2/16, 2/16, 8/16 },
			{ -3/16, -3/16, -4/16, 3/16, 3/16, 4/16 },
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{ -2/16, -2/16, -8/16, 2/16, 2/16, 8/16 },
			{ -3/16, -3/16, -4/16, 3/16, 3/16, 4/16 },
		}
	},
	mesecons = pipereceptor_off,
	on_rotate = pipeworks.fix_after_rotation
})

local nodename_sensor_loaded = "pipeworks:flow_sensor_loaded"
minetest.register_node(nodename_sensor_loaded, {
	description = S("Flow sensor (on)"),
	drawtype = "mesh",
	mesh = "pipeworks_flow_sensor"..polys..".obj",
	tiles = { "pipeworks_flow_sensor_on.png" },
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	on_place = pipeworks.rotate_on_place,
	after_dig_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	on_construct = function(pos)
		if mesecon then
			mesecon.receptor_on(pos, rules) 
		end
	end,
	selection_box = {
		type = "fixed",
		fixed = {
			{ -2/16, -2/16, -8/16, 2/16, 2/16, 8/16 },
			{ -3/16, -3/16, -4/16, 3/16, 3/16, 4/16 },
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{ -2/16, -2/16, -8/16, 2/16, 2/16, 8/16 },
			{ -3/16, -3/16, -4/16, 3/16, 3/16, 4/16 },
		}
	},
	drop = "pipeworks:flow_sensor_empty",
	mesecons = pipereceptor_on,
	on_rotate = pipeworks.fix_after_rotation
})
new_flow_logic_register.directional_horizonal_rotate(nodename_sensor_empty, true)
new_flow_logic_register.directional_horizonal_rotate(nodename_sensor_loaded, true)
-- activate flow sensor at roughly half the pressure pumps drive pipes
local sensor_pressure_set = { { nodename_sensor_empty, 0.0 }, { nodename_sensor_loaded, 1.0 } }
new_flow_logic_register.transition_simple_set(sensor_pressure_set, { mesecons=pipeworks.mesecons_rules })



-- tanks

-- TODO flow-logic-stub: these don't currently do anything under the new flow logic.
for fill = 0, 10 do
	local filldesc="empty"
	local sgroups = {snappy=3, pipe=1, tankfill=fill+1}
	local image = nil

	if fill ~= 0 then
		filldesc=fill.."0% full"
		sgroups = {snappy=3, pipe=1, tankfill=fill+1, not_in_creative_inventory=1}
		image = "pipeworks_storage_tank_fittings.png"
	end

	minetest.register_node("pipeworks:expansion_tank_"..fill, {
		description = S("Expansion Tank (@1)... You hacker, you.", filldesc),
		tiles = {
			"pipeworks_storage_tank_fittings.png",
			"pipeworks_storage_tank_fittings.png",
			"pipeworks_storage_tank_back.png",
			"pipeworks_storage_tank_back.png",
			"pipeworks_storage_tank_back.png",
			pipeworks.liquid_texture.."^pipeworks_storage_tank_front_"..fill..".png"
		},
		inventory_image = image,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=3, pipe=1, tankfill=fill+1, not_in_creative_inventory=1},
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		drop = "pipeworks:storage_tank_0",
		pipe_connections = { top = 1, bottom = 1},
		after_place_node = function(pos)
			pipeworks.look_for_stackable_tanks(pos)
			pipeworks.scan_for_pipe_objects(pos)
		end,
		after_dig_node = function(pos)
			pipeworks.scan_for_pipe_objects(pos)
		end,
		on_rotate = false
	})

	minetest.register_node("pipeworks:storage_tank_"..fill, {
		description = S("Fluid Storage Tank (@1)", filldesc),
		tiles = {
			"pipeworks_storage_tank_fittings.png",
			"pipeworks_storage_tank_fittings.png",
			"pipeworks_storage_tank_back.png",
			"pipeworks_storage_tank_back.png",
			"pipeworks_storage_tank_back.png",
			pipeworks.liquid_texture.."^pipeworks_storage_tank_front_"..fill..".png"
		},
		inventory_image = image,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = sgroups,
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		drop = "pipeworks:storage_tank_0",
		pipe_connections = { top = 1, bottom = 1},
		after_place_node = function(pos)
			pipeworks.look_for_stackable_tanks(pos)
			pipeworks.scan_for_pipe_objects(pos)
		end,
		after_dig_node = function(pos)
			pipeworks.scan_for_pipe_objects(pos)
		end,
		on_rotate = false
	})
end

-- fountainhead

local nodename_fountain_empty = "pipeworks:fountainhead"
minetest.register_node(nodename_fountain_empty, {
	description = S("Fountainhead"),
	drawtype = "mesh",
	mesh = "pipeworks_fountainhead"..polys..".obj",
	tiles = { "pipeworks_fountainhead.png" },
	sunlight_propagates = true,
	paramtype = "light",
	groups = {snappy=3, pipe=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	pipe_connections = { bottom = 1 },
	after_place_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	on_construct = function(pos)
		if mesecon then
			mesecon.receptor_on(pos, rules) 
		end
	end,
	selection_box = {
		type = "fixed",
		fixed = { -2/16, -8/16, -2/16, 2/16, 8/16, 2/16 }
	},
	collision_box = {
		type = "fixed",
		fixed = { -2/16, -8/16, -2/16, 2/16, 8/16, 2/16 }
	},
	on_rotate = false
})

local nodename_fountain_loaded = "pipeworks:fountainhead_pouring"
minetest.register_node(nodename_fountain_loaded, {
	description = S("Fountainhead"),
	drawtype = "mesh",
	mesh = "pipeworks_fountainhead"..polys..".obj",
	tiles = { "pipeworks_fountainhead.png" },
	sunlight_propagates = true,
	paramtype = "light",
	groups = {snappy=3, pipe=1, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	pipe_connections = { bottom = 1 },
	after_place_node = function(pos)
		minetest.set_node(pos, { name = "pipeworks:fountainhead", param2 = minetest.get_node(pos).param2 })
		pipeworks.scan_for_pipe_objects(pos)
	end,
	after_dig_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	on_construct = function(pos)
		if mesecon then
			mesecon.receptor_on(pos, rules) 
		end
	end,
	selection_box = {
		type = "fixed",
		fixed = { -2/16, -8/16, -2/16, 2/16, 8/16, 2/16 }
	},
	collision_box = {
		type = "fixed",
		fixed = { -2/16, -8/16, -2/16, 2/16, 8/16, 2/16 }
	},
	drop = "pipeworks:fountainhead",
	on_rotate = false
})
new_flow_logic_register.directional_vertical_fixed(nodename_fountain_empty, false)
new_flow_logic_register.directional_vertical_fixed(nodename_fountain_loaded, false)
local fountain_upper = 1.0
local fountain_lower = 1.0
local fountain_neighbours={{x=0, y=1, z=0}}
new_flow_logic_register.output_simple(nodename_fountain_empty, fountain_upper, fountain_lower, fountain_neighbours)
new_flow_logic_register.output_simple(nodename_fountain_loaded, fountain_upper, fountain_lower, fountain_neighbours)

local sp_cbox = {
	type = "fixed",
	fixed = {
		{ -2/16, -2/16, -8/16, 2/16, 2/16, 8/16 }
	}
}

local nodename_sp_empty = "pipeworks:straight_pipe_empty"
minetest.register_node(nodename_sp_empty, {
	description = S("Straight-only Pipe"),
	drawtype = "mesh",
	mesh = "pipeworks_straight_pipe"..polys..".obj",
	tiles = { "pipeworks_straight_pipe_empty.png" },
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	on_place = pipeworks.rotate_on_place,
	after_dig_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	selection_box = sp_cbox,
	collision_box = sp_cbox,
	on_rotate = pipeworks.fix_after_rotation
})

local nodename_sp_loaded = "pipeworks:straight_pipe_loaded"
minetest.register_node(nodename_sp_loaded, {
	description = S("Straight-only Pipe"),
	drawtype = "mesh",
	mesh = "pipeworks_straight_pipe"..polys..".obj",
	tiles = { "pipeworks_straight_pipe_loaded.png" },
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, pipe=1, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	on_place = pipeworks.rotate_on_place,
	after_dig_node = function(pos)
		pipeworks.scan_for_pipe_objects(pos)
	end,
	selection_box = sp_cbox,
	collision_box = sp_cbox,
	drop = "pipeworks:straight_pipe_empty",
	on_rotate = pipeworks.fix_after_rotation
})

new_flow_logic_register.directional_horizonal_rotate(nodename_sp_empty, true)
new_flow_logic_register.directional_horizonal_rotate(nodename_sp_loaded, true)

-- Other misc stuff

minetest.register_alias("pipeworks:valve_off_loaded", "pipeworks:valve_off_empty")
minetest.register_alias("pipeworks:entry_panel", "pipeworks:entry_panel_empty")

minetest.register_lbm({
	name = "pipeworks:rotate_valves_flowsensors",
	label = "Flip pipeworks valves and flow sensors around X/Z",
	run_at_every_load = false,
	nodenames = {
		"pipeworks:flow_sensor_empty",
		"pipeworks:flow_sensor_loaded",
		"pipeworks:valve_off_empty",
		"pipeworks:valve_on_empty",
		"pipeworks:valve_off_loaded",
	},
	action = function(pos, node)
		local dir = minetest.facedir_to_dir(node.param2)
		local newdir = { x=dir.z, y=dir.y, z=dir.x }
		local newfdir = minetest.dir_to_facedir(newdir)
		minetest.swap_node(pos, { name = node.name, param2 = newfdir })
	end
})
