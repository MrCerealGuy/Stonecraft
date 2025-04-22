local S = minetest.get_translator("pipeworks")

-- the minetest.after() calls below can sometimes trigger after a tube
-- breaks, at which point item_exit() is no longer valid, so we have to make
-- sure that there even IS a callback to run, first.

local function after_break(pos)
	local name = minetest.get_node(pos).name
	if minetest.registered_nodes[name].item_exit then
		minetest.registered_nodes[name].item_exit(pos)
	end
end

if minetest.get_modpath("mesecons") and pipeworks.enable_detector_tube then
	local detector_tube_step = 5 * (tonumber(minetest.settings:get("dedicated_server_step")) or 0.09)
	pipeworks.register_tube("pipeworks:detector_tube_on", {
			description = S("Detecting Pneumatic Tube Segment on"),
			inventory_image = "pipeworks_detector_tube_inv.png",
			plain = { "pipeworks_detector_tube_plain.png" },
			node_def = {
				tube = {can_go = function(pos, node, velocity, stack)
						 local meta = minetest.get_meta(pos)
						 local nitems = meta:get_int("nitems")+1
						 meta:set_int("nitems", nitems)
						 local saved_pos = vector.new(pos)
						 minetest.after(detector_tube_step, after_break, saved_pos)
						 return pipeworks.notvel(pipeworks.meseadjlist,velocity)
					end},
				groups = {mesecon = 2, not_in_creative_inventory = 1},
				drop = "pipeworks:detector_tube_off_1",
				mesecons = {receptor = {state = "on", rules = pipeworks.mesecons_rules}},
				item_exit = function(pos)
					local meta = minetest.get_meta(pos)
					local nitems = meta:get_int("nitems")-1
					local node = minetest.get_node(pos)
					local name = node.name
					local fdir = node.param2
					if nitems == 0 then
						 minetest.set_node(pos, {name = string.gsub(name, "on", "off"), param2 = fdir})
						 mesecon.receptor_off(pos, pipeworks.mesecons_rules)
					else
						 meta:set_int("nitems", nitems)
					end
				end,
				on_construct = function(pos)
					 local meta = minetest.get_meta(pos)
					 meta:set_int("nitems", 1)
					 minetest.after(detector_tube_step, after_break, pos)
				end,
			},
	})
	pipeworks.register_tube("pipeworks:detector_tube_off", {
			description = S("Detecting Pneumatic Tube Segment"),
			inventory_image = "pipeworks_detector_tube_inv.png",
			plain = { "pipeworks_detector_tube_plain.png" },
			node_def = {
				tube = {can_go = function(pos, node, velocity, stack)
						local node = minetest.get_node(pos)
						local name = node.name
						local fdir = node.param2
						minetest.set_node(pos,{name = string.gsub(name, "off", "on"), param2 = fdir})
						mesecon.receptor_on(pos, pipeworks.mesecons_rules)
						return pipeworks.notvel(pipeworks.meseadjlist, velocity)
					end},
				groups = {mesecon = 2},
				mesecons = {receptor = {state = "off", rules = pipeworks.mesecons_rules }},
			},
	})

	minetest.register_craft( {
		output = "pipeworks:detector_tube_off_1 2",
		recipe = {
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
			{ "mesecons:mesecon", "mesecons_materials:silicon", "mesecons:mesecon" },
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
		},
	})
end

local digiline_enabled = minetest.get_modpath("digilines") ~= nil
if digiline_enabled and pipeworks.enable_digiline_detector_tube then
	pipeworks.register_tube("pipeworks:digiline_detector_tube", {
			description = S("Digiline Detecting Pneumatic Tube Segment"),
			inventory_image = "pipeworks_digiline_detector_tube_inv.png",
			plain = { "pipeworks_digiline_detector_tube_plain.png" },
			node_def = {
				tube = {can_go = function(pos, node, velocity, stack)
						local meta = minetest.get_meta(pos)

						local setchan = meta:get_string("channel")

						digiline:receptor_send(pos, digiline.rules.default, setchan, stack:to_table())

						return pipeworks.notvel(pipeworks.meseadjlist, velocity)
					end},
				on_construct = function(pos)
					local meta = minetest.get_meta(pos)
					meta:set_string("formspec",
						"size[8.5,2.2]"..
						"image[0.2,0;1,1;pipeworks_digiline_detector_tube_inv.png]"..
						"label[1.2,0.2;"..S("Digiline Detecting Tube").."]"..
						"field[0.5,1.6;4.6,1;channel;"..S("Channel")..";${channel}]"..
						"button[4.8,1.3;1.5,1;set_channel;"..S("Set").."]"..
						"button_exit[6.3,1.3;2,1;close;"..S("Close").."]"
					)
				end,
				on_receive_fields = function(pos, formname, fields, sender)
					if (fields.quit and not fields.key_enter_field)
					or (fields.key_enter_field ~= "channel" and not fields.set_channel)
					or not pipeworks.may_configure(pos, sender) then
						return
					end
					if fields.channel then
						minetest.get_meta(pos):set_string("channel", fields.channel)
					end
				end,
				groups = {},
				digiline = {
					receptor = {},
					effector = {
						action = function(pos,node,channel,msg) end
					},
					wire = {
						rules = pipeworks.digilines_rules
					},
				},
			},
	})

	minetest.register_craft( {
		output = "pipeworks:digiline_detector_tube_1 2",
		recipe = {
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
			{ "digilines:wire_std_00000000", "mesecons_materials:silicon", "digilines:wire_std_00000000" },
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
		},
	})
end

if minetest.get_modpath("mesecons") and pipeworks.enable_conductor_tube then
	pipeworks.register_tube("pipeworks:conductor_tube_off", {
			description = S("Conducting Pneumatic Tube Segment"),
			inventory_image = "pipeworks_conductor_tube_inv.png",
			short = "pipeworks_conductor_tube_short.png",
			plain = { "pipeworks_conductor_tube_plain.png" },
			noctr = { "pipeworks_conductor_tube_noctr.png" },
			ends = { "pipeworks_conductor_tube_end.png" },
			node_def = {
				groups = {mesecon = 2},
				mesecons = {conductor = {state = "off",
							  rules = pipeworks.mesecons_rules,
							  onstate = "pipeworks:conductor_tube_on_#id"}}
			},
	})
	pipeworks.register_tube("pipeworks:conductor_tube_on", {
			description = S("Conducting Pneumatic Tube Segment on"),
			inventory_image = "pipeworks_conductor_tube_inv.png",
			short = "pipeworks_conductor_tube_short.png",
			plain = { "pipeworks_conductor_tube_on_plain.png" },
			noctr = { "pipeworks_conductor_tube_on_noctr.png" },
			ends = { "pipeworks_conductor_tube_on_end.png" },
			node_def = {
				groups = {mesecon = 2, not_in_creative_inventory = 1},
				drop = "pipeworks:conductor_tube_off_1",
				mesecons = {conductor = {state = "on",
							  rules = pipeworks.mesecons_rules,
							  offstate = "pipeworks:conductor_tube_off_#id"}}
			},
	})

	minetest.register_craft({
		type = "shapeless",
		output = "pipeworks:conductor_tube_off_1",
		recipe = {"pipeworks:tube_1", "mesecons:mesecon"}
	})
end

if digiline_enabled and pipeworks.enable_digiline_conductor_tube then
	pipeworks.register_tube("pipeworks:digiline_conductor_tube", {
		description = S("Digiline Conducting Pneumatic Tube Segment"),
		inventory_image = "pipeworks_tube_inv.png^pipeworks_digiline_conductor_tube_inv.png",
		short = "pipeworks_tube_short.png^pipeworks_digiline_conductor_tube_short.png",
		plain = {"pipeworks_tube_plain.png^pipeworks_digiline_conductor_tube_plain.png"},
		noctr = {"pipeworks_tube_noctr.png^pipeworks_digiline_conductor_tube_noctr.png"},
		ends = {"pipeworks_tube_end.png^pipeworks_digiline_conductor_tube_end.png"},
		node_def = {digiline = {wire = {rules = pipeworks.digilines_rules}}},
	})
	minetest.register_craft({
		type = "shapeless",
		output = "pipeworks:digiline_conductor_tube_1",
		recipe = {"pipeworks:tube_1", "digilines:wire_std_00000000"}
	})
end

if digiline_enabled and pipeworks.enable_digiline_conductor_tube and
		pipeworks.enable_conductor_tube then
	pipeworks.register_tube("pipeworks:mesecon_and_digiline_conductor_tube_off", {
		description = S("Mesecon and Digiline Conducting Pneumatic Tube Segment"),
		inventory_image = "pipeworks_conductor_tube_inv.png^pipeworks_digiline_conductor_tube_inv.png",
		short = "pipeworks_conductor_tube_short.png^pipeworks_digiline_conductor_tube_short.png",
		plain = {"pipeworks_conductor_tube_plain.png^pipeworks_digiline_conductor_tube_plain.png"},
		noctr = {"pipeworks_conductor_tube_noctr.png^pipeworks_digiline_conductor_tube_noctr.png"},
		ends = {"pipeworks_conductor_tube_end.png^pipeworks_digiline_conductor_tube_end.png"},
		node_def = {
			digiline = {wire = {rules = pipeworks.digilines_rules}},
			groups = {mesecon = 2},
			mesecons = {conductor = {
				state = "off",
				rules = pipeworks.mesecons_rules,
				onstate = "pipeworks:mesecon_and_digiline_conductor_tube_on_#id"
			}},
		},
	})
	pipeworks.register_tube("pipeworks:mesecon_and_digiline_conductor_tube_on", {
		description = S("Mesecon and Digiline Conducting Pneumatic Tube Segment on"),
		inventory_image = "pipeworks_conductor_tube_inv.png^pipeworks_digiline_conductor_tube_inv.png",
		short = "pipeworks_conductor_tube_short.png^pipeworks_digiline_conductor_tube_short.png",
		plain = {"pipeworks_conductor_tube_on_plain.png^pipeworks_digiline_conductor_tube_plain.png"},
		noctr = {"pipeworks_conductor_tube_on_noctr.png^pipeworks_digiline_conductor_tube_noctr.png"},
		ends = {"pipeworks_conductor_tube_on_end.png^pipeworks_digiline_conductor_tube_end.png"},
		node_def = {
			digiline = {wire = {rules = pipeworks.digilines_rules}},
			groups = {mesecon = 2, not_in_creative_inventory = 1},
			drop = "pipeworks:mesecon_and_digiline_conductor_tube_off_1",
			mesecons = {conductor = {
				state = "on",
				rules = pipeworks.mesecons_rules,
				offstate = "pipeworks:mesecon_and_digiline_conductor_tube_off_#id"}
			},
		},
	})
	minetest.register_craft({
		type = "shapeless",
		output = "pipeworks:mesecon_and_digiline_conductor_tube_off_1",
		recipe = {"pipeworks:tube_1", "mesecons:mesecon", "digilines:wire_std_00000000"}
	})
	minetest.register_craft({
		type = "shapeless",
		output = "pipeworks:mesecon_and_digiline_conductor_tube_off_1",
		recipe = {"pipeworks:conductor_tube_off_1", "digilines:wire_std_00000000"}
	})
	minetest.register_craft({
		type = "shapeless",
		output = "pipeworks:mesecon_and_digiline_conductor_tube_off_1",
		recipe = {"pipeworks:digiline_conductor_tube_1", "mesecons:mesecon"}
	})
end
