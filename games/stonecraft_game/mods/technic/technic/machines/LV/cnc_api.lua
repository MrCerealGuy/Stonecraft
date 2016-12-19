-- API for the technic CNC machine
-- Again code is adapted from the NonCubic Blocks MOD v1.4 by yves_de_beck

local S = technic.getter

technic.cnc = {}

-- REGISTER NONCUBIC FORMS, CREATE MODELS AND RECIPES:
------------------------------------------------------

-- Define slope boxes for the various nodes
-------------------------------------------
technic.cnc.programs = {
	{ suffix  = "technic_cnc_stick",
		model = {-0.15, -0.5, -0.15, 0.15, 0.5, 0.15},
		desc  = S("Stick")
	},

	{ suffix  = "technic_cnc_element_end_double",
		model = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.5},
		desc  = S("Element End Double")
	},

	{ suffix  = "technic_cnc_element_cross_double",
		model = {
			{0.3, -0.5, -0.3, 0.5, 0.5, 0.3},
			{-0.3, -0.5, -0.5, 0.3, 0.5, 0.5},
			{-0.5, -0.5, -0.3, -0.3, 0.5, 0.3}},
		desc  = S("Element Cross Double")
	},

	{ suffix  = "technic_cnc_element_t_double",
		model = {
			{-0.3, -0.5, -0.5, 0.3, 0.5, 0.3},
			{-0.5, -0.5, -0.3, -0.3, 0.5, 0.3},
			{0.3, -0.5, -0.3, 0.5, 0.5, 0.3}},
		desc  = S("Element T Double")
	},

	{ suffix  = "technic_cnc_element_edge_double",
		model = {
			{-0.3, -0.5, -0.5, 0.3, 0.5, 0.3},
			{-0.5, -0.5, -0.3, -0.3, 0.5, 0.3}},
		desc  = S("Element Edge Double")
	},

	{ suffix  = "technic_cnc_element_straight_double",
		model = {-0.3, -0.5, -0.5, 0.3, 0.5, 0.5},
		desc  = S("Element Straight Double")
	},

	{ suffix  = "technic_cnc_element_end",
		model = {-0.3, -0.5, -0.3, 0.3, 0, 0.5},
		desc  = S("Element End")
	},

	{ suffix  = "technic_cnc_element_cross",
		model = {
			{0.3, -0.5, -0.3, 0.5, 0, 0.3},
			{-0.3, -0.5, -0.5, 0.3, 0, 0.5},
			{-0.5, -0.5, -0.3, -0.3, 0, 0.3}},
		desc  = S("Element Cross")
	},

	{ suffix  = "technic_cnc_element_t",
		model = {
			{-0.3, -0.5, -0.5, 0.3, 0, 0.3},
			{-0.5, -0.5, -0.3, -0.3, 0, 0.3},
			{0.3, -0.5, -0.3, 0.5, 0, 0.3}},
		desc  = S("Element T")
	},

	{ suffix  = "technic_cnc_element_edge",
		model = {
			{-0.3, -0.5, -0.5, 0.3, 0, 0.3},
			{-0.5, -0.5, -0.3, -0.3, 0, 0.3}},
		desc  = S("Element Edge")
	},

	{ suffix  = "technic_cnc_element_straight",
		model = {-0.3, -0.5, -0.5, 0.3, 0, 0.5},
		desc  = S("Element Straight")
	},

	{ suffix  = "technic_cnc_oblate_spheroid",
		model = "technic_oblate_spheroid.obj",
		desc  = S("Oblate spheroid"),
		cbox  = {
			type = "fixed",
			fixed = {
				{ -6/16,  4/16, -6/16, 6/16,  8/16, 6/16 },
				{ -8/16, -4/16, -8/16, 8/16,  4/16, 8/16 },
				{ -6/16, -8/16, -6/16, 6/16, -4/16, 6/16 }
			}
		}
	},

	{ suffix  = "technic_cnc_sphere",
		model = "technic_sphere.obj",
		desc  = S("Sphere")
	},

	{ suffix  = "technic_cnc_cylinder_horizontal",
		model = "technic_cylinder_horizontal.obj",
		desc  = S("Horizontal Cylinder")
	},

	{ suffix  = "technic_cnc_cylinder",
		model = "technic_cylinder.obj",
		desc  = S("Cylinder")
	},

	{ suffix  = "technic_cnc_twocurvededge",
		model = "technic_two_curved_edge.obj",
		desc  = S("Two Curved Edge/Corner Block")
	},

	{ suffix  = "technic_cnc_onecurvededge",
		model = "technic_one_curved_edge.obj",
		desc  = S("One Curved Edge Block")
	},

	{ suffix  = "technic_cnc_spike",
		model = "technic_pyramid_spike.obj",
		desc  = S("Spike"),
		cbox    = {
			type = "fixed",
			fixed = {
				{ -2/16,  4/16, -2/16, 2/16,  8/16, 2/16 },
				{ -4/16,     0, -4/16, 4/16,  4/16, 4/16 },
				{ -6/16, -4/16, -6/16, 6/16,     0, 6/16 },
				{ -8/16, -8/16, -8/16, 8/16, -4/16, 8/16 }
			}
		}
	},

	{ suffix  = "technic_cnc_pyramid",
		model = "technic_pyramid.obj",
		desc  = S("Pyramid"),
		cbox  = {
			type = "fixed",
			fixed = {
				{ -2/16, -2/16, -2/16, 2/16,     0, 2/16 },
				{ -4/16, -4/16, -4/16, 4/16, -2/16, 4/16 },
				{ -6/16, -6/16, -6/16, 6/16, -4/16, 6/16 },
				{ -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 }
			}
		}
	},

	{ suffix  = "technic_cnc_slope_inner_edge_upsdown",
		model = "technic_innercorner_upsdown.obj",
		desc  = S("Slope Upside Down Inner Edge/Corner"),
		sbox  = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }
		},
		cbox  = {
			type = "fixed",
			fixed = {
				{  0.25, -0.25, -0.5,  0.5, -0.5,   0.5  },
				{ -0.5,  -0.25,  0.25, 0.5, -0.5,   0.5  },
				{  0,     0,    -0.5,  0.5, -0.25,  0.5  },
				{ -0.5,   0,     0,    0.5, -0.25,  0.5  },
				{ -0.25,  0.25, -0.5,  0.5,  0,    -0.25 },
				{ -0.5,   0.25, -0.25, 0.5,  0,     0.5  },
				{ -0.5,   0.5,  -0.5,  0.5,  0.25,  0.5  }
			}
		}
	},

	{ suffix  = "technic_cnc_slope_edge_upsdown",
		model = "technic_outercorner_upsdown.obj",
		desc  = S("Slope Upside Down Outer Edge/Corner"),
		cbox  = {
			type = "fixed",
			fixed = {
				{ -8/16,  8/16, -8/16, 8/16,  4/16, 8/16 },
				{ -4/16,  4/16, -4/16, 8/16,     0, 8/16 },
				{     0,     0,     0, 8/16, -4/16, 8/16 },
				{  4/16, -4/16,  4/16, 8/16, -8/16, 8/16 }
			}
		}
	},

	{ suffix  = "technic_cnc_slope_inner_edge",
		model = "technic_innercorner.obj",
		desc  = S("Slope Inner Edge/Corner"),
		sbox  = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }
		},
		cbox  = {
			type = "fixed",
			fixed = {
				{ -0.5,  -0.5,  -0.5,  0.5, -0.25,  0.5  },
				{ -0.5,  -0.25, -0.25, 0.5,  0,     0.5  },
				{ -0.25, -0.25, -0.5,  0.5,  0,    -0.25 },
				{ -0.5,   0,     0,    0.5,  0.25,  0.5  },
				{  0,     0,    -0.5,  0.5,  0.25,  0.5  },
				{ -0.5,   0.25,  0.25, 0.5,  0.5,   0.5  },
				{  0.25,  0.25, -0.5,  0.5,  0.5,   0.5  }
			}
		}
	},

	{ suffix  = "technic_cnc_slope_edge",
		model = "technic_outercorner.obj",
		desc  = S("Slope Outer Edge/Corner"),
		cbox  = {
			type = "fixed",
			fixed = {
				{  4/16,  4/16,  4/16, 8/16,  8/16, 8/16 },
				{     0,     0,     0, 8/16,  4/16, 8/16 },
				{ -4/16, -4/16, -4/16, 8/16,     0, 8/16 },
				{ -8/16, -8/16, -8/16, 8/16, -4/16, 8/16 }
			}
		}
	},

	{ suffix  = "technic_cnc_slope_upsdown",
		model = "technic_slope_upsdown.obj",
		desc  = S("Slope Upside Down"),
		cbox  = {
			type = "fixed",
			fixed = {
				{ -8/16,  8/16, -8/16, 8/16,  4/16, 8/16 },
				{ -8/16,  4/16, -4/16, 8/16,     0, 8/16 },
				{ -8/16,     0,     0, 8/16, -4/16, 8/16 },
				{ -8/16, -4/16,  4/16, 8/16, -8/16, 8/16 }
			}
		}
	},

	{ suffix  = "technic_cnc_slope_lying",
		model = "technic_slope_horizontal.obj",
		desc  = S("Slope Lying"),
		cbox  = {
			type = "fixed",
			fixed = {
				{  4/16, -8/16,  4/16,  8/16, 8/16, 8/16 },
				{     0, -8/16,     0,  4/16, 8/16, 8/16 },				
				{ -4/16, -8/16, -4/16,     0, 8/16, 8/16 },
				{ -8/16, -8/16, -8/16, -4/16, 8/16, 8/16 }
			}
		}
	},

	{ suffix  = "technic_cnc_slope",
		model = "technic_slope.obj",
		desc  = S("Slope"),
		cbox  = {
			type = "fixed",
			fixed = {
				{ -8/16,  4/16,  4/16, 8/16,  8/16, 8/16 },
				{ -8/16,     0,     0, 8/16,  4/16, 8/16 },
				{ -8/16, -4/16, -4/16, 8/16,     0, 8/16 },
				{ -8/16, -8/16, -8/16, 8/16, -4/16, 8/16 }
			}
		}
	},
	
}

-- Allow disabling certain programs for some node. Default is allowing all types for all nodes
technic.cnc.programs_disable = {
	-- ["default:brick"] = {"technic_cnc_stick"}, -- Example: Disallow the stick for brick
	-- ...
	["default:dirt"] = {"technic_cnc_oblate_spheroid", "technic_cnc_slope_upsdown", "technic_cnc_edge",
	                    "technic_cnc_inner_edge", "technic_cnc_slope_edge_upsdown",
	                    "technic_cnc_slope_inner_edge_upsdown", "technic_cnc_stick",
	                    "technic_cnc_cylinder_horizontal"}
}

-- Generic function for registering all the different node types
function technic.cnc.register_program(recipeitem, suffix, model, groups, images, description, cbox, sbox)

	local dtype
	local nodeboxdef
	local meshdef

	if type(model) ~= "string" then -- assume a nodebox if it's a table or function call
		dtype = "nodebox"
		nodeboxdef = {
			type  = "fixed",
			fixed = model
		}
	else
		dtype = "mesh"
		meshdef = model
	end

	if cbox and not sbox then sbox = cbox end

	minetest.register_node(":"..recipeitem.."_"..suffix, {
		description   = description,
		drawtype      = dtype,
		node_box      = nodeboxdef,
		mesh          = meshdef,
		tiles         = images,
		paramtype     = "light",
		paramtype2    = "facedir",
		walkable      = true,
		groups        = groups,
		selection_box = sbox,
		collision_box = cbox
	})
end

-- function to iterate over all the programs the CNC machine knows
function technic.cnc.register_all(recipeitem, groups, images, description)
	for _, data in ipairs(technic.cnc.programs) do
		-- Disable node creation for disabled node types for some material
		local do_register = true
		if technic.cnc.programs_disable[recipeitem] ~= nil then
			for __, disable in ipairs(technic.cnc.programs_disable[recipeitem]) do
				if disable == data.suffix then
					do_register = false
				end
			end
		end
		-- Create the node if it passes the test
		if do_register then
			technic.cnc.register_program(recipeitem, data.suffix, data.model,
			    groups, images, description.." "..data.desc, data.cbox, data.sbox)
		end
	end
end


-- REGISTER NEW TECHNIC_CNC_API's PART 2: technic.cnc..register_element_end(subname, recipeitem, groups, images, desc_element_xyz)
-----------------------------------------------------------------------------------------------------------------------
function technic.cnc.register_slope_edge_etc(recipeitem, groups, images, desc_slope, desc_slope_lying, desc_slope_upsdown, desc_slope_edge, desc_slope_inner_edge, desc_slope_upsdwn_edge, desc_slope_upsdwn_inner_edge, desc_pyramid, desc_spike, desc_onecurvededge, desc_twocurvededge, desc_cylinder, desc_cylinder_horizontal, desc_spheroid, desc_element_straight, desc_element_edge, desc_element_t, desc_element_cross, desc_element_end)

         technic.cnc.register_slope(recipeitem, groups, images, desc_slope)
         technic.cnc.register_slope_lying(recipeitem, groups, images, desc_slope_lying)
         technic.cnc.register_slope_upsdown(recipeitem, groups, images, desc_slope_upsdown)
         technic.cnc.register_slope_edge(recipeitem, groups, images, desc_slope_edge)
         technic.cnc.register_slope_inner_edge(recipeitem, groups, images, desc_slope_inner_edge)
         technic.cnc.register_slope_edge_upsdown(recipeitem, groups, images, desc_slope_upsdwn_edge)
         technic.cnc.register_slope_inner_edge_upsdown(recipeitem, groups, images, desc_slope_upsdwn_inner_edge)
         technic.cnc.register_pyramid(recipeitem, groups, images, desc_pyramid)
         technic.cnc.register_spike(recipeitem, groups, images, desc_spike)
         technic.cnc.register_onecurvededge(recipeitem, groups, images, desc_onecurvededge)
         technic.cnc.register_twocurvededge(recipeitem, groups, images, desc_twocurvededge)
         technic.cnc.register_cylinder(recipeitem, groups, images, desc_cylinder)
         technic.cnc.register_cylinder_horizontal(recipeitem, groups, images, desc_cylinder_horizontal)
         technic.cnc.register_spheroid(recipeitem, groups, images, desc_spheroid)
         technic.cnc.register_element_straight(recipeitem, groups, images, desc_element_straight)
         technic.cnc.register_element_edge(recipeitem, groups, images, desc_element_edge)
         technic.cnc.register_element_t(recipeitem, groups, images, desc_element_t)
         technic.cnc.register_element_cross(recipeitem, groups, images, desc_element_cross)
         technic.cnc.register_element_end(recipeitem, groups, images, desc_element_end)
end

-- REGISTER STICKS: noncubic.register_xyz(recipeitem, groups, images, desc_element_xyz)
------------------------------------------------------------------------------------------------------------
function technic.cnc.register_stick_etc(recipeitem, groups, images, desc_stick)
         technic.cnc.register_stick(recipeitem, groups, images, desc_stick)
end

function technic.cnc.register_elements(recipeitem, groups, images, desc_element_straight_double, desc_element_edge_double, desc_element_t_double, desc_element_cross_double, desc_element_end_double)
         technic.cnc.register_element_straight_double(recipeitem, groups, images, desc_element_straight_double)
         technic.cnc.register_element_edge_double(recipeitem, groups, images, desc_element_edge_double)
         technic.cnc.register_element_t_double(recipeitem, groups, images, desc_element_t_double)
         technic.cnc.register_element_cross_double(recipeitem, groups, images, desc_element_cross_double)
         technic.cnc.register_element_end_double(recipeitem, groups, images, desc_element_end_double)
end

