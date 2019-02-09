-- This file supplies glowlights

local S = homedecor_i18n.gettext

local glowlight_nodebox = {
	half = homedecor.nodebox.slab_y(1/2),
	quarter = homedecor.nodebox.slab_y(1/4),
	small_cube = {
			type = "fixed",
			fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
	},
}

minetest.register_node("homedecor:glowlight_half", {
	description = S("Thick Glowlight"),
	tiles = {
		"homedecor_glowlight_top.png",
		"homedecor_glowlight_bottom.png",
		"homedecor_glowlight_thick_sides.png",
		"homedecor_glowlight_thick_sides.png",
		"homedecor_glowlight_thick_sides.png",
		"homedecor_glowlight_thick_sides.png"
	},
	overlay_tiles = {
		{ name = "homedecor_glowlight_top_overlay.png", color = "white"},
		"",
		{ name = "homedecor_glowlight_thick_sides_overlay.png", color = "white"},
		{ name = "homedecor_glowlight_thick_sides_overlay.png", color = "white"},
		{ name = "homedecor_glowlight_thick_sides_overlay.png", color = "white"},
		{ name = "homedecor_glowlight_thick_sides_overlay.png", color = "white"},
	},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = {
		type = "wallmounted",
		wall_top =    { -0.5,    0, -0.5, 0.5, 0.5, 0.5 },
		wall_bottom = { -0.5, -0.5, -0.5, 0.5,   0, 0.5 },
		wall_side =   { -0.5, -0.5, -0.5,   0, 0.5, 0.5 }
	},
	node_box = glowlight_nodebox.half,
	groups = { snappy = 3, ud_param2_colorable = 1 },
	light_source = default.LIGHT_MAX,
	sounds = default.node_sound_glass_defaults(),
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
	end,
})

minetest.register_node("homedecor:glowlight_quarter", {
	description = S("Thin Glowlight"),
	tiles = {
		"homedecor_glowlight_top.png",
		"homedecor_glowlight_bottom.png",
		"homedecor_glowlight_thin_sides.png",
		"homedecor_glowlight_thin_sides.png",
		"homedecor_glowlight_thin_sides.png",
		"homedecor_glowlight_thin_sides.png"
	},
	overlay_tiles = {
		{ name = "homedecor_glowlight_top_overlay.png", color = "white"},
		"",
		{ name = "homedecor_glowlight_thin_sides_overlay.png", color = "white"},
		{ name = "homedecor_glowlight_thin_sides_overlay.png", color = "white"},
		{ name = "homedecor_glowlight_thin_sides_overlay.png", color = "white"},
		{ name = "homedecor_glowlight_thin_sides_overlay.png", color = "white"},
	},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = {
		type = "wallmounted",
		wall_top =    { -0.5, 0.25, -0.5,   0.5,   0.5, 0.5 },
		wall_bottom = { -0.5, -0.5, -0.5,   0.5, -0.25, 0.5 },
		wall_side =   { -0.5, -0.5, -0.5, -0.25,   0.5, 0.5 }
	},
	node_box = glowlight_nodebox.quarter,
	groups = { snappy = 3, ud_param2_colorable = 1 },
	light_source = default.LIGHT_MAX-1,
	sounds = default.node_sound_glass_defaults(),
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
	end,
})

minetest.register_node("homedecor:glowlight_small_cube", {
	description = S("Small Glowlight Cube"),
	tiles = {
		"homedecor_glowlight_cube_tb.png",
		"homedecor_glowlight_cube_tb.png",
		"homedecor_glowlight_cube_sides.png",
		"homedecor_glowlight_cube_sides.png",
		"homedecor_glowlight_cube_sides.png",
		"homedecor_glowlight_cube_sides.png"
	},
	overlay_tiles = {
		{ name = "homedecor_glowlight_cube_tb_overlay.png", color = "white"},
		{ name = "homedecor_glowlight_cube_tb_overlay.png", color = "white"},
		{ name = "homedecor_glowlight_cube_sides_overlay.png", color = "white"},
		{ name = "homedecor_glowlight_cube_sides_overlay.png", color = "white"},
		{ name = "homedecor_glowlight_cube_sides_overlay.png", color = "white"},
		{ name = "homedecor_glowlight_cube_sides_overlay.png", color = "white"},
	},
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	drawtype = "nodebox",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = {
		type = "wallmounted",
		wall_top =    { -0.25,    0,  -0.25, 0.25,  0.5, 0.25 },
		wall_bottom = { -0.25, -0.5,  -0.25, 0.25,    0, 0.25 },
		wall_side =   {  -0.5, -0.25, -0.25,    0, 0.25, 0.25 }
	},
	node_box = glowlight_nodebox.small_cube,
	groups = { snappy = 3, ud_param2_colorable = 1 },
	light_source = default.LIGHT_MAX-1,
	sounds = default.node_sound_glass_defaults(),
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
	end,
})

homedecor.register("plasma_lamp", {
	description = S("Plasma Lamp"),
	drawtype = "mesh",
	mesh = "plasma_lamp.obj",
	tiles = {
		"default_gold_block.png",
		{
			name="homedecor_plasma_storm.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0},
		}
	},
	use_texture_alpha = true,
	light_source = default.LIGHT_MAX - 1,
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

homedecor.register("plasma_ball", {
	description = S("Plasma Ball"),
	mesh = "homedecor_plasma_ball.obj",
	tiles = {
		{ name = "homedecor_generic_plastic.png", color = homedecor.color_black },
		{
			name = "homedecor_plasma_ball_streamers.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0},
		},
		"homedecor_plasma_ball_glass.png"
	},
	inventory_image = "homedecor_plasma_ball_inv.png",
	selection_box = {
		type = "fixed",
		fixed = { -0.1875, -0.5, -0.1875, 0.1875, 0, 0.1875 }
	},
	walkable = false,
	use_texture_alpha = true,
	light_source = default.LIGHT_MAX - 5,
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

local tc_cbox = {
	type = "fixed",
	fixed = {
		{ -0.1875, -0.5, -0.1875, 0.1875, 0.375, 0.1875 },
	}
}

homedecor.register("candle", {
	description = S("Thick Candle"),
	mesh = "homedecor_candle_thick.obj",
	tiles = {
		'homedecor_candle_sides.png',
		{name="homedecor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
	},
	inventory_image = "homedecor_candle_inv.png",
	selection_box = tc_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-4,
})

local c_cbox = {
	type = "fixed",
	fixed = {
		{ -0.125, -0.5, -0.125, 0.125, 0.05, 0.125 },
	}
}

homedecor.register("candle_thin", {
	description = S("Thin Candle"),
	mesh = "homedecor_candle_thin.obj",
	tiles = {
		'homedecor_candle_sides.png',
		{name="homedecor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
	},
	inventory_image = "homedecor_candle_thin_inv.png",
	selection_box = c_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-4,
})

local cs_cbox = {
	type = "fixed",
	fixed = {
		{ -0.15625, -0.5, -0.15625, 0.15625, 0.3125, 0.15625 },
	}
}

homedecor.register("candlestick_wrought_iron", {
	description = S("Candlestick (wrought iron)"),
	mesh = "homedecor_candlestick.obj",
	tiles = {
		"homedecor_candle_sides.png",
		{name="homedecor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		"homedecor_generic_metal_wrought_iron.png",
	},
	inventory_image = "homedecor_candlestick_wrought_iron_inv.png",
	selection_box = cs_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-4,
})

homedecor.register("candlestick_brass", {
	description = S("Candlestick (brass)"),
	mesh = "homedecor_candlestick.obj",
	tiles = {
		"homedecor_candle_sides.png",
		{name="homedecor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		"homedecor_generic_metal_brass.png",
	},
	inventory_image = "homedecor_candlestick_brass_inv.png",
	selection_box = cs_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-4,
})

homedecor.register("wall_sconce", {
	description = S("Wall sconce"),
	mesh = "homedecor_wall_sconce.obj",
	tiles = {
		'homedecor_candle_sides.png',
		{name="homedecor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		'homedecor_wall_sconce_back.png',
		'homedecor_generic_metal_wrought_iron.png',
	},
	inventory_image = "homedecor_wall_sconce_inv.png",
	selection_box = {
		type = "fixed",
		fixed = { -0.1875, -0.25, 0.3125, 0.1875, 0.25, 0.5 }
	},
	walkable = false,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-4,
})

local ol_cbox = {
	type = "fixed",
	fixed = {
		{ -5/16, -8/16, -3/16, 5/16, 4/16, 3/16 },
	}
}

homedecor.register("oil_lamp", {
	description = S("Oil lamp (hurricane)"),
	mesh = "homedecor_oil_lamp.obj",
	tiles = {
		"homedecor_generic_metal_brass.png",
		{ name = "homedecor_generic_metal.png", color = homedecor.color_black },
		{ name = "homedecor_generic_metal.png", color = 0xffa00000 },
		"homedecor_oil_lamp_wick.png",
		{ name = "homedecor_generic_metal.png", color = 0xffa00000 },
		"homedecor_oil_lamp_glass.png",
	},
	use_texture_alpha = true,
	inventory_image = "homedecor_oil_lamp_inv.png",
	selection_box = ol_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-3,
	sounds = default.node_sound_glass_defaults(),
})

homedecor.register("oil_lamp_tabletop", {
	description = S("Oil Lamp (tabletop)"),
	mesh = "homedecor_oil_lamp_tabletop.obj",
	tiles = {"homedecor_oil_lamp_tabletop.png"},
	inventory_image = "homedecor_oil_lamp_tabletop_inv.png",
	selection_box = ol_cbox,
	collision_box = ol_cbox,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-3,
	sounds = default.node_sound_glass_defaults(),
})

local gl_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.25, 0.25, 0.45, 0.25 },
}

minetest.register_alias("homedecor:wall_lantern", "homedecor:ground_lantern")

homedecor.register("ground_lantern", {
	description = S("Ground Lantern"),
	mesh = "homedecor_ground_lantern.obj",
	tiles = { "homedecor_light.png", "homedecor_generic_metal_wrought_iron.png" },
	use_texture_alpha = true,
	inventory_image = "homedecor_ground_lantern_inv.png",
	wield_image = "homedecor_ground_lantern_inv.png",
	groups = {snappy=3},
	light_source = 11,
	selection_box = gl_cbox,
	walkable = false
})

local hl_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.2, 0.25, 0.5, 0.5 },
}

homedecor.register("hanging_lantern", {
	description = S("Hanging Lantern"),
	mesh = "homedecor_hanging_lantern.obj",
	tiles = { "homedecor_generic_metal_wrought_iron.png", "homedecor_light.png" },
	use_texture_alpha = true,
	inventory_image = "homedecor_hanging_lantern_inv.png",
	wield_image = "homedecor_hanging_lantern_inv.png",
	groups = {snappy=3},
	light_source = 11,
	selection_box = hl_cbox,
	walkable = false
})

local cl_cbox = {
	type = "fixed",
	fixed = { -0.35, -0.45, -0.35, 0.35, 0.5, 0.35 }
}

homedecor.register("ceiling_lantern", {
	drawtype = "mesh",
	mesh = "homedecor_ceiling_lantern.obj",
	tiles = { "homedecor_light.png", "homedecor_generic_metal_wrought_iron.png" },
	use_texture_alpha = true,
	inventory_image = "homedecor_ceiling_lantern_inv.png",
	description = S("Ceiling Lantern"),
	groups = {snappy=3},
	light_source = 11,
	selection_box = cl_cbox,
	walkable = false
})

local sm_light = default.LIGHT_MAX-2

if minetest.get_modpath("darkage") then
	minetest.register_alias("homedecor:lattice_lantern_large", "darkage:lamp")
	sm_light = default.LIGHT_MAX-5
else
	homedecor.register("lattice_lantern_large", {
		description = S("Lattice lantern (large)"),
		tiles = { 'homedecor_lattice_lantern_large.png' },
		groups = { snappy = 3 },
		light_source = default.LIGHT_MAX,
		sounds = default.node_sound_glass_defaults(),
	})
end

homedecor.register("lattice_lantern_small", {
	description = S("Lattice lantern (small)"),
	tiles = {
		'homedecor_lattice_lantern_small_tb.png',
		'homedecor_lattice_lantern_small_tb.png',
		'homedecor_lattice_lantern_small_sides.png'
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
	},
	node_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
	},
	groups = { snappy = 3 },
	light_source = sm_light,
	sounds = default.node_sound_glass_defaults(),
	on_place = minetest.rotate_node
})

local brightness_tab = {
	0xffd0d0d0,
	0xffd8d8d8,
	0xffe0e0e0,
	0xffe8e8e8,
	0xffffffff,
}

-- table lamps and standing lamps

local repl = {
	["off"] ="low",
	["low"] ="med",
	["med"] ="hi",
	["hi"]  ="max",
	["max"] ="off",
}

local lamp_colors = {
	"white",
	"blue",
	"green",
	"pink",
	"red",
	"violet",
}

local tlamp_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.25, 0.25, 0.5, 0.25 }
}

local slamp_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.25, 0.25, 1.5, 0.25 }
}

local function reg_lamp(suffix, nxt, light, brightness)

	local wool_brighten = (light or 0) * 15

	homedecor.register("table_lamp_"..suffix, {
		description = S("Table Lamp"),
		mesh = "homedecor_table_lamp.obj",
		tiles = {
			"wool_grey.png^[colorize:#ffffff:"..wool_brighten,
			{ name = "homedecor_table_standing_lamp_lightbulb.png", color = brightness_tab[brightness] },
			{ name = "homedecor_generic_wood_red.png", color = 0xffffffff },
			{ name = "homedecor_generic_metal.png", color = homedecor.color_black },
		},
		inventory_image = "homedecor_table_lamp_foot_inv.png^homedecor_table_lamp_top_inv.png",
		paramtype = "light",
		paramtype2 = "color",
		palette = "unifieddyes_palette_extended.png",
		walkable = false,
		light_source = light,
		selection_box = tlamp_cbox,
		sounds = default.node_sound_wood_defaults(),
		groups = {cracky=2,oddly_breakable_by_hand=1, ud_param2_colorable = 1,
			not_in_creative_inventory=((light ~= nil) and 1) or nil,
		},
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			node.name = "homedecor:table_lamp_"..repl[suffix]
			minetest.set_node(pos, node)
		end,
		on_construct = unifieddyes.on_construct,
		drop = {
			items = {
				{items = {"homedecor:table_lamp_off"}, inherit_color = true },
			}
		}

	})

	homedecor.register("standing_lamp_"..suffix, {
		description = S("Standing Lamp"),
		mesh = "homedecor_standing_lamp.obj",
		tiles = {
			"wool_grey.png^[colorize:#ffffff:"..wool_brighten,
			{ name = "homedecor_table_standing_lamp_lightbulb.png", color = brightness_tab[brightness] },
			{ name = "homedecor_generic_wood_red.png", color = 0xffffffff },
			{ name = "homedecor_generic_metal.png", color = homedecor.color_black },
		},
		inventory_image = "homedecor_standing_lamp_foot_inv.png^homedecor_standing_lamp_top_inv.png",
		paramtype = "light",
		paramtype2 = "color",
		palette = "unifieddyes_palette_extended.png",
		walkable = false,
		light_source = light,
		groups = {cracky=2,oddly_breakable_by_hand=1, ud_param2_colorable = 1,
			not_in_creative_inventory=((light ~= nil) and 1) or nil,
		},
		selection_box = slamp_cbox,
		sounds = default.node_sound_wood_defaults(),
		on_rotate = screwdriver.rotate_simple,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			node.name = "homedecor:standing_lamp_"..repl[suffix]
			minetest.set_node(pos, node)
		end,
		on_construct = unifieddyes.on_construct,
		--expand = { top="air" },
		drop = {
			items = {
				{items = {"homedecor:standing_lamp_off"}, inherit_color = true },
			}
		}
	})

	-- for old maps that had the original 3dforniture mod
	minetest.register_alias("3dforniture:table_lamp_"..suffix, "homedecor:table_lamp_"..suffix)
end

reg_lamp("off", "low",  nil, 1 )
reg_lamp("low", "med",  3,   2 )
reg_lamp("med", "hi",   7,   3 )
reg_lamp("hi",  "max", 11,   4 )
reg_lamp("max", "off", 14,   5 )

-- "gooseneck" style desk lamps

local dlamp_cbox = {
	type = "wallmounted",
	wall_side = { -0.2, -0.5, -0.15, 0.32, 0.12, 0.15 },
}

homedecor.register("desk_lamp", {
	description = S("Desk Lamp"),
	mesh = "homedecor_desk_lamp.obj",
	tiles = {
		"homedecor_generic_metal.png",
		"homedecor_generic_metal.png",
		{ name = "homedecor_generic_metal.png", color = homedecor.color_med_grey },
		{ name = "homedecor_table_standing_lamp_lightbulb.png", color = brightness_tab[5] },
	},
	inventory_image = "homedecor_desk_lamp_inv.png",
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = dlamp_cbox,
	node_box = dlamp_cbox,
	walkable = false,
	groups = {snappy=3, ud_param2_colorable = 1},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
	end,
	on_rotate = unifieddyes.fix_after_screwdriver_nsew
})

-- "kitchen"/"dining room" ceiling lamp

homedecor.register("ceiling_lamp", {
	description = S("Ceiling Lamp"),
	mesh = "homedecor_ceiling_lamp.obj",
	tiles = {
		"homedecor_generic_metal_brass.png",
		"homedecor_ceiling_lamp_glass.png",
		"homedecor_table_standing_lamp_lightbulb.png",
		{ name = "homedecor_generic_plastic.png", color = 0xff442d04 },
	},
	inventory_image = "homedecor_ceiling_lamp_inv.png",
	light_source = default.LIGHT_MAX,
	groups = {snappy=3},
	walkable = false,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.set_node(pos, {name = "homedecor:ceiling_lamp_off"})
	end,
})

homedecor.register("ceiling_lamp_off", {
	description = S("Ceiling Lamp (off)"),
	mesh = "homedecor_ceiling_lamp.obj",
	tiles = {
		"homedecor_generic_metal_brass.png",
		"homedecor_ceiling_lamp_glass.png",
		{ "homedecor_table_standing_lamp_lightbulb.png", color = 0xffd0d0d0 },
		{ name = "homedecor_generic_plastic.png", color = 0xff442d04 },
	},
	groups = {snappy=3, not_in_creative_inventory=1},
	walkable = false,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.set_node(pos, {name = "homedecor:ceiling_lamp"})
	end,
	drop = "homedecor:ceiling_lamp"
})

-- conversion LBM for param2 coloring

homedecor.old_static_nodes = {
	"homedecor:glowlight_quarter_white",
	"homedecor:glowlight_quarter_yellow",
	"homedecor:glowlight_half_white",
	"homedecor:glowlight_half_yellow",
	"homedecor:glowlight_small_cube_white",
	"homedecor:glowlight_small_cube_yellow"
}

local lamp_power = {"off", "low", "med", "hi", "max"}

for _, power in ipairs(lamp_power) do
	for _, color in ipairs(lamp_colors) do
		table.insert(homedecor.old_static_nodes, "homedecor:table_lamp_"..color.."_"..power)
		table.insert(homedecor.old_static_nodes, "homedecor:standing_lamp_"..color.."_"..power)
	end
end

minetest.register_lbm({
	name = "homedecor:convert_lighting",
	label = "Convert homedecor glowlights, table lamps, and standing lamps to use param2 color",
	run_at_every_load = false,
	nodenames = homedecor.old_static_nodes,
	action = function(pos, node)
		local name = node.name
		local newname
		local color

		if string.find(name, "small_cube") then
			newname = "homedecor:glowlight_small_cube"
		elseif string.find(name, "glowlight_half") then
			newname = "homedecor:glowlight_half"
		elseif string.find(name, "glowlight_quarter") then
			newname = "homedecor:glowlight_quarter"
		end

		local lampname
		if string.find(name, "standing_lamp") then
			lampname = "homedecor:standing_lamp"
		elseif string.find(name, "table_lamp") then
			lampname = "homedecor:table_lamp"
		end
		if lampname then
			newname = lampname
			if string.find(name, "_off") then
				newname = newname.."_off"
			elseif string.find(name, "_low") then
				newname = newname.."_low"
			elseif string.find(name, "_med") then
				newname = newname.."_med"
			elseif string.find(name, "_hi") then
				newname = newname.."_hi"
			elseif string.find(name, "_max") then
				newname = newname.."_max"
			end
		end

		if string.find(name, "red") then
			color = "red"
		elseif string.find(name, "pink") then
			color = "pink"
		elseif string.find(name, "green") then
			color = "green"
		elseif string.find(name, "blue") then
			color = "blue"
		elseif string.find(name, "yellow") then
			color = "yellow"
		elseif string.find(name, "violet") then
			color = "violet"
		else
			color = "white"
		end

		local paletteidx, _ = unifieddyes.getpaletteidx("unifieddyes:"..color, "extended")

		local old_fdir
		local new_node = newname
		local new_fdir = 1
		local param2

		if string.find(name, "glowlight") then
			paletteidx, _ = unifieddyes.getpaletteidx("unifieddyes:"..color, "wallmounted")

			old_fdir = math.floor(node.param2 / 4)

			if old_fdir == 5 then
				new_fdir = 0
			elseif old_fdir == 1 then
				new_fdir = 5
			elseif old_fdir == 2 then
				new_fdir = 4
			elseif old_fdir == 3 then
				new_fdir = 3
			elseif old_fdir == 4 then
				new_fdir = 2
			elseif old_fdir == 0 then
				new_fdir = 1
			end
			param2 = paletteidx + new_fdir
		else
			param2 = paletteidx
		end

		local meta = minetest.get_meta(pos)

		if string.find(name, "table_lamp") or string.find(name, "standing_lamp") then
			meta:set_string("palette", "ext")
		end

		minetest.set_node(pos, { name = new_node, param2 = param2 })
		meta:set_string("dye", "unifieddyes:"..color)
	end
})

-- this one's for the small "gooseneck" desk lamps

homedecor.old_static_desk_lamps = {
	"homedecor:desk_lamp_red",
	"homedecor:desk_lamp_blue",
	"homedecor:desk_lamp_green",
	"homedecor:desk_lamp_violet",
}

minetest.register_lbm({
	name = "homedecor:convert_desk_lamps",
	label = "Convert homedecor desk lamps to use param2 color",
	run_at_every_load = false,
	nodenames = homedecor.old_static_desk_lamps,
	action = function(pos, node)
		local name = node.name
		local color = string.sub(name, string.find(name, "_", -8) + 1)

		if color == "green" then
			color = "medium_green"
		elseif color == "violet" then
			color = "magenta"
		end

		local paletteidx, _ = unifieddyes.getpaletteidx("unifieddyes:"..color, "wallmounted")
		local old_fdir = math.floor(node.param2 % 32)
		local new_fdir = 3

		if old_fdir == 0 then
			new_fdir = 3
		elseif old_fdir == 1 then
			new_fdir = 4
		elseif old_fdir == 2 then
			new_fdir = 2
		elseif old_fdir == 3 then
			new_fdir = 5
		end

		local param2 = paletteidx + new_fdir

		minetest.set_node(pos, { name = "homedecor:desk_lamp", param2 = param2 })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)
	end
})

local chains_sbox = {
	type = "fixed",
	fixed = { -0.1, -0.5, -0.1, 0.1, 0.5, 0.1 }
}

local topchains_sbox = {
	type = "fixed",
	fixed = {
		{ -0.25, 0.35, -0.25, 0.25, 0.5, 0.25 },
		{ -0.1, -0.5, -0.1, 0.1, 0.4, 0.1 }
	}
}

minetest.register_node("homedecor:chain_steel_top", {
	description = S("Hanging chain (ceiling mount, steel)"),
	drawtype = "mesh",
	mesh = "homedecor_chains_top.obj",
	tiles = {"basic_materials_chain_steel.png"},
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	inventory_image = "basic_materials_chain_steel_inv.png",
	groups = {cracky=3},
	selection_box = topchains_sbox,
})

minetest.register_node("homedecor:chain_brass_top", {
	description = S("Hanging chain (ceiling mount, brass)"),
	drawtype = "mesh",
	mesh = "homedecor_chains_top.obj",
	tiles = {"basic_materials_chain_brass.png"},
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	inventory_image = "basic_materials_chain_brass_inv.png",
	groups = {cracky=3},
	selection_box = topchains_sbox,
})

minetest.register_node("homedecor:chandelier_steel", {
	description = S("Chandelier (steel)"),
	paramtype = "light",
	light_source = 12,
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	tiles = {
		"basic_materials_chain_steel.png",
		"homedecor_candle_flat.png",
		{
			name="homedecor_candle_flame.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0
			}
		}
	},
	drawtype = "mesh",
	mesh = "homedecor_chandelier.obj",
	groups = {cracky=3},
	sounds =  default.node_sound_stone_defaults(),
})

minetest.register_node("homedecor:chandelier_brass", {
	description = S("Chandelier (brass)"),
	paramtype = "light",
	light_source = 12,
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	tiles = {
		"basic_materials_chain_brass.png",
		"homedecor_candle_flat.png",
		{
			name="homedecor_candle_flame.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0
			}
		}
	},
	drawtype = "mesh",
	mesh = "homedecor_chandelier.obj",
	groups = {cracky=3},
	sounds =  default.node_sound_stone_defaults(),
})

-- crafts

minetest.register_craft({
	output = 'homedecor:chain_steel_top',
	recipe = {
		{'default:steel_ingot'},
		{'basic_materials:chainlink_steel'},
	},
})

minetest.register_craft({
	output = 'homedecor:chandelier_steel',
	recipe = {
		{'', 'basic_materials:chainlink_steel', ''},
		{'default:torch', 'basic_materials:chainlink_steel', 'default:torch'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

-- brass versions

minetest.register_craft({
	output = 'homedecor:chain_brass_top',
	recipe = {
		{'basic_materials:brass_ingot'},
		{'basic_materials:chainlink_brass'},
	},
})

minetest.register_craft({
	output = 'homedecor:chandelier_brass',
	recipe = {
		{'', 'basic_materials:chainlink_brass', ''},
		{'default:torch', 'basic_materials:chainlink_brass', 'default:torch'},
		{'basic_materials:brass_ingot', 'basic_materials:brass_ingot', 'basic_materials:brass_ingot'},
	}
})

minetest.register_alias("chains:chain_top",        "homedecor:chain_steel_top")
minetest.register_alias("chains:chain_top_brass",  "homedecor:chain_brass_top")

minetest.register_alias("chains:chandelier_steel", "homedecor:chandelier_steel")
minetest.register_alias("chains:chandelier_brass", "homedecor:chandelier_brass")

