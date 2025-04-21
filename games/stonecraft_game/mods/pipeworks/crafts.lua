-- Crafting recipes for pipes
local materials = xcompat.materials

minetest.register_craft( {
	output = "pipeworks:pipe_1_empty 12",
	recipe = {
			{ materials.steel_ingot, materials.steel_ingot, materials.steel_ingot },
			{ "", "", "" },
			{ materials.steel_ingot, materials.steel_ingot, materials.steel_ingot }
	},
})

minetest.register_craft( {
	output = "pipeworks:straight_pipe_empty 3",
	recipe = {
			{ "pipeworks:pipe_1_empty", "pipeworks:pipe_1_empty", "pipeworks:pipe_1_empty" },
	},
})

minetest.register_craft( {
	output = "pipeworks:spigot 3",
	recipe = {
			{ "pipeworks:pipe_1_empty", "" },
			{ "", "pipeworks:pipe_1_empty" },
	},
})

minetest.register_craft( {
output = "pipeworks:entry_panel_empty 2",
recipe = {
	{ "", materials.steel_ingot, "" },
	{ "", "pipeworks:pipe_1_empty", "" },
	{ "", materials.steel_ingot, "" },
},
})

-- Various ancillary pipe devices

minetest.register_craft( {
	output = "pipeworks:pump_off 2",
	recipe = {
			{ materials.stone, materials.steel_ingot, materials.stone },
			{ materials.copper_ingot, materials.mese_crystal_fragment, materials.copper_ingot },
			{ materials.steel_ingot, materials.steel_ingot, materials.steel_ingot }
	},
})

minetest.register_craft( {
	output = "pipeworks:valve_off_empty 2",
	recipe = {
			{ "", "group:stick", "" },
			{ materials.steel_ingot, materials.steel_ingot, materials.steel_ingot },
			{ "", materials.steel_ingot, "" }
	},
})

minetest.register_craft( {
	output = "pipeworks:storage_tank_0 2",
	recipe = {
			{ "", materials.steel_ingot, materials.steel_ingot },
			{ materials.steel_ingot, materials.glass, materials.steel_ingot },
			{ materials.steel_ingot, materials.steel_ingot, "" }
	},
})

minetest.register_craft( {
	output = "pipeworks:grating 2",
	recipe = {
			{ materials.steel_ingot, "", materials.steel_ingot },
			{ "", "pipeworks:pipe_1_empty", "" },
			{ materials.steel_ingot, "", materials.steel_ingot }
	},
})

minetest.register_craft( {
	output = "pipeworks:flow_sensor_empty 2",
	recipe = {
			{ "pipeworks:pipe_1_empty", "mesecons:mesecon", "pipeworks:pipe_1_empty" },
	},
})

minetest.register_craft( {
	output = "pipeworks:fountainhead 2",
	recipe = {
			{ "pipeworks:pipe_1_empty" },
			{ "pipeworks:pipe_1_empty" }
	},
})

-- injectors

minetest.register_craft( {
	output = "pipeworks:filter 2",
	recipe = {
			{ materials.steel_ingot, materials.steel_ingot, "basic_materials:plastic_sheet" },
			{ "group:stick", materials.mese_crystal, "basic_materials:plastic_sheet" },
			{ materials.steel_ingot, materials.steel_ingot, "basic_materials:plastic_sheet" }
	},
})

minetest.register_craft( {
	output = "pipeworks:mese_filter 2",
	recipe = {
			{ materials.steel_ingot, materials.steel_ingot, "basic_materials:plastic_sheet" },
			{ "group:stick", materials.mese, "basic_materials:plastic_sheet" },
			{ materials.steel_ingot, materials.steel_ingot, "basic_materials:plastic_sheet" }
	},
})

if minetest.get_modpath("digilines") then
	minetest.register_craft( {
		output = "pipeworks:digiline_filter 2",
		recipe = {
			{ materials.steel_ingot, materials.steel_ingot, "basic_materials:plastic_sheet" },
			{ "group:stick", "digilines:wire_std_00000000", "basic_materials:plastic_sheet" },
			{ materials.steel_ingot, materials.steel_ingot, "basic_materials:plastic_sheet" }
		},
	})
end

-- other

minetest.register_craft( {
	output = "pipeworks:autocrafter 2",
	recipe = {
			{ materials.steel_ingot, materials.mese_crystal, materials.steel_ingot },
			{ "basic_materials:plastic_sheet", materials.steel_ingot, "basic_materials:plastic_sheet" },
			{ materials.steel_ingot, materials.mese_crystal, materials.steel_ingot }
	},
})

minetest.register_craft( {
	output = "pipeworks:steel_pane_embedded_tube 1",
	recipe = {
		{ "", materials.steel_ingot, "" },
		{ "", "pipeworks:tube_1", "" },
		{ "", materials.steel_ingot, "" }
	},
})

minetest.register_craft({
	output = "pipeworks:trashcan",
	recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ materials.steel_ingot, "", materials.steel_ingot },
		{ materials.steel_ingot, materials.steel_ingot, materials.steel_ingot },
	},
})

minetest.register_craft( {
	output = "pipeworks:teleport_tube_1 2",
	recipe = {
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
			{ materials.desert_stone, materials.mese, materials.desert_stone },
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
	},
})

if pipeworks.enable_priority_tube then
	minetest.register_craft( {
		output = "pipeworks:priority_tube_1 6",
		recipe = {
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
			{ materials.gold_ingot, "", materials.gold_ingot },
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
		},
	})
end

if pipeworks.enable_accelerator_tube then
	minetest.register_craft( {
		output = "pipeworks:accelerator_tube_1 2",
		recipe = {
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
			{ materials.mese_crystal_fragment, materials.steel_ingot, materials.mese_crystal_fragment },
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
		},
	})
end

if pipeworks.enable_crossing_tube then
	minetest.register_craft( {
		output = "pipeworks:crossing_tube_1 5",
		recipe = {
			{ "", "pipeworks:tube_1", "" },
			{ "pipeworks:tube_1", "pipeworks:tube_1", "pipeworks:tube_1" },
			{ "", "pipeworks:tube_1", "" }
		},
	})
end

if pipeworks.enable_one_way_tube then
	minetest.register_craft({
		output = "pipeworks:one_way_tube 2",
		recipe = {
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
			{ "group:stick", materials.mese_crystal, "basic_materials:plastic_sheet" },
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
		},
	})
end

if pipeworks.enable_mese_tube then
	minetest.register_craft( {
		output = "pipeworks:mese_tube_000000 2",
		recipe = {
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
			{ "", materials.mese_crystal, "" },
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
		},
	})

	minetest.register_craft( {
		type = "shapeless",
		output = "pipeworks:mese_tube_000000",
		recipe = {
			"pipeworks:tube_1",
			materials.mese_crystal_fragment,
			materials.mese_crystal_fragment,
			materials.mese_crystal_fragment,
			materials.mese_crystal_fragment,
		},
	})
end

if pipeworks.enable_item_tags and pipeworks.enable_tag_tube then
	minetest.register_craft( {
		output = "pipeworks:tag_tube_000000 2",
		recipe = {
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
			{ materials.book, materials.mese_crystal, materials.book },
			{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
		},
	})

	minetest.register_craft( {
		type = "shapeless",
		output = "pipeworks:tag_tube_000000",
		recipe = {
			"pipeworks:mese_tube_000000",
			materials.book,
		},
	})
end

if pipeworks.enable_sand_tube then
	minetest.register_craft( {
		output = "pipeworks:sand_tube_1 2",
		recipe = {
			{"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet"},
			{"group:sand",                 "group:sand",                 "group:sand"},
			{"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet"}
		},
	})

	minetest.register_craft( {
		output = "pipeworks:sand_tube_1",
		recipe = {
			{"group:sand", "pipeworks:tube_1", "group:sand"},
		},
	})
end

if pipeworks.enable_mese_sand_tube then
	minetest.register_craft( {
		output = "pipeworks:mese_sand_tube_1 2",
		recipe = {
			{"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
			{"group:sand",				 materials.mese_crystal,	   "group:sand" },
			{"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
		},
	})

	minetest.register_craft( {
		type = "shapeless",
		output = "pipeworks:mese_sand_tube_1",
		recipe = {
			"pipeworks:sand_tube_1",
			materials.mese_crystal_fragment,
			materials.mese_crystal_fragment,
			materials.mese_crystal_fragment,
			materials.mese_crystal_fragment,
		},
	})
end

if pipeworks.enable_deployer then
	minetest.register_craft({
		output = "pipeworks:deployer_off",
		recipe = {
			{ "group:wood",	materials.chest,	"group:wood"	},
			{ materials.stone, "mesecons:piston",  materials.stone },
			{ materials.stone, "mesecons:mesecon", materials.stone },
		}
	})
end

if pipeworks.enable_dispenser then
	minetest.register_craft({
		output = "pipeworks:dispenser_off",
		recipe = {
			{ materials.desert_sand, materials.chest,	materials.desert_sand },
			{ materials.stone,	   "mesecons:piston",  materials.stone	   },
			{ materials.stone,	   "mesecons:mesecon", materials.stone	  },
		}
	})
end

if pipeworks.enable_node_breaker then
	minetest.register_craft({
		output = "pipeworks:nodebreaker_off",
		recipe = {
			{ "basic_materials:gear_steel", "basic_materials:gear_steel",   "basic_materials:gear_steel"	},
			{ materials.stone, "mesecons:piston",   materials.stone },
			{ "group:wood",	"mesecons:mesecon",  "group:wood" },
		}
	})
end
