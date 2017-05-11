
local S = homedecor_i18n.gettext

homedecor.register("power_outlet", {
	description = S("Power Outlet"),
	tiles = {
		"homedecor_outlet_edges.png",
		"homedecor_outlet_edges.png",
		"homedecor_outlet_edges.png",
		"homedecor_outlet_edges.png",
		"homedecor_outlet_back.png",
		"homedecor_outlet_edges.png"
	},
	inventory_image = "homedecor_outlet_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.125, -0.3125, 0.4375, 0.125, 0, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.1875, -0.375, 0.375, 0.1875, 0.0625, 0.5},
		}
	},
	groups = {cracky=3,dig_immediate=2},
	walkable = false
})

homedecor.register("light_switch", {
	description = S("Light switch"),
	tiles = {
		"homedecor_light_switch_edges.png",
		"homedecor_light_switch_edges.png",
		"homedecor_light_switch_edges.png",
		"homedecor_light_switch_edges.png",
		"homedecor_light_switch_back.png",
		"homedecor_light_switch_front.png"
	},
	inventory_image = "homedecor_light_switch_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.125,   -0.5,    0.4375,  0.125,   -0.1875, 0.5 },
			{ -0.03125, -0.3125, 0.40625, 0.03125, -0.25,   0.5 },

		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.1875,   -0.5625,    0.375,  0.1875,   -0.1250, 0.5 },
		}
	},
	groups = {cracky=3,dig_immediate=2},
	walkable = false
})


homedecor.register("doorbell", {
	tiles = { "homedecor_doorbell.png" },
	inventory_image = "homedecor_doorbell_inv.png",
	description = S("Doorbell"),
    groups = {snappy=3},
    walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, 0, 0.46875, 0.0625, 0.1875, 0.5}, -- NodeBox1
			{-0.03125, 0.0625, 0.45, 0.03125, 0.125, 0.4675}, -- NodeBox2
		}
	},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.sound_play("homedecor_doorbell", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 15
		})
	end
})
