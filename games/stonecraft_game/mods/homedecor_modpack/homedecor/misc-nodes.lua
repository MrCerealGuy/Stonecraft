
local S = homedecor_i18n.gettext

local function N_(x) return x end

homedecor.register("ceiling_paint", {
	description = S("Textured Ceiling Paint"),
	drawtype = 'signlike',
	tiles = { 'homedecor_ceiling_paint.png' },
	inventory_image = 'homedecor_ceiling_paint_roller.png',
	wield_image = 'homedecor_ceiling_paint_roller.png',
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = { type = "wallmounted" },
})

homedecor.register("ceiling_tile", {
	description = S("Drop-Ceiling Tile"),
	drawtype = 'signlike',
	tiles = { 'homedecor_ceiling_tile.png' },
	wield_image = 'homedecor_ceiling_tile.png',
	inventory_image = 'homedecor_ceiling_tile.png',
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = { type = "wallmounted" },
})

local rug_types = {
	{ N_("small"),   "homedecor_small_rug.obj"    },
	{ N_("large"),   homedecor.box.slab_y(0.0625) },
	{ N_("persian"), homedecor.box.slab_y(0.0625) },
}

for _, rt in ipairs(rug_types) do
	local s, m = unpack(rt)

	local mesh = m
	local nodebox = nil
	local tiles = { "homedecor_rug_"..s..".png", "wool_grey.png" }

	if type(m) == "table" then
		mesh = nil
		nodebox = {
			type = "fixed",
			fixed = m
		}
		tiles = {
			"homedecor_rug_"..s..".png",
			"wool_grey.png",
			"homedecor_rug_"..s..".png"
		}
	end

	homedecor.register("rug_"..s, {
		description = S("Rug (@1)", S(s)),
		mesh = mesh,
		tiles = tiles,
		node_box = nodebox,
		paramtype2 = "wallmounted",
		walkable = false,
		groups = {snappy = 3},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = { type = "wallmounted" },
	})
end

local pot_colors = { N_("black"), N_("green"), N_("terracotta") }

for _, p in ipairs(pot_colors) do
homedecor.register("flower_pot_"..p, {
	description = S("Flower Pot (@1)", S(p)),
	mesh = "homedecor_flowerpot.obj",
	tiles = {
		"homedecor_flower_pot_"..p..".png",
		{ name = "default_dirt.png", color = 0xff505050 },
	},
	groups = { snappy = 3, potting_soil=1 },
	sounds = default.node_sound_stone_defaults(),
})
end

local flowers_list = {
	{ S("Rose"),				"rose",				"flowers:rose" },
	{ S("Tulip"),				"tulip",			"flowers:tulip" },
	{ S("Yellow Dandelion"),	"dandelion_yellow",	"flowers:dandelion_yellow" },
	{ S("White Dandelion"), 	"dandelion_white",	"flowers:dandelion_white" },
	{ S("Blue Geranium"),		"geranium",			"flowers:geranium" },
	{ S("Viola"),				"viola",			"flowers:viola" },
	{ S("Cactus"),				"cactus",			"default:cactus" },
	{ S("Bonsai"),				"bonsai",			"default:sapling" }
}

for _, f in ipairs(flowers_list) do
	local flowerdesc, flower, craftwith = unpack(f)

	homedecor.register("potted_"..flower, {
		description = S("Potted flower (@1)", flowerdesc),
		mesh = "homedecor_potted_plant.obj",
		tiles = {
			"homedecor_flower_pot_terracotta.png",
			{ name = "default_dirt.png", color = 0xff303030 },
			"flowers_"..flower..".png"
		},
		walkable = false,
		groups = {snappy = 3},
		sounds = default.node_sound_glass_defaults(),
		selection_box = {
			type = "fixed",
			fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 }
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:potted_"..flower,
		recipe = { craftwith, "homedecor:flower_pot_small" }
	})

	minetest.register_alias("flowers:flower_"..flower.."_pot", "homedecor:potted_"..flower)
	minetest.register_alias("flowers:potted_"..flower, "homedecor:potted_"..flower)
	minetest.register_alias("flowers:flower_pot", "homedecor:flower_pot_small")
end

homedecor.register("pole_brass", {
    description = S("Brass Pole"),
	mesh = "homedecor_round_pole.obj",
    tiles = {"homedecor_generic_metal_brass.png^homedecor_generic_metal_lines_overlay.png",},
    inventory_image = "homedecor_pole_brass_inv.png",
    wield_image = "homedecor_pole_brass_inv.png",
    selection_box = {
            type = "fixed",
            fixed = { -0.125, -0.5, -0.125, 0.125, 0.5, 0.125 },
    },
    collision_box = {
            type = "fixed",
            fixed = { -0.125, -0.5, -0.125, 0.125, 0.5, 0.125 },
    },
    groups = {snappy=3},
    sounds = default.node_sound_wood_defaults(),
})

homedecor.register("pole_wrought_iron", {
    description = S("Wrought Iron Pole"),
    tiles = { "homedecor_generic_metal_wrought_iron.png^homedecor_generic_metal_lines_overlay.png" },
    inventory_image = "homedecor_pole_wrought_iron_inv.png",
    wield_image = "homedecor_pole_wrought_iron_inv.png",
    selection_box = {
            type = "fixed",
            fixed = {-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}
    },
	node_box = {
		type = "fixed",
                fixed = {-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}
	},
    groups = {snappy=3},
    sounds = default.node_sound_wood_defaults(),
})

local ft_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.375, 0.5, 0.3125, 0.375 }
}

homedecor.register("fishtank", {
	description = S("Fishtank"),
	mesh = "homedecor_fishtank.obj",
	tiles = {
		{ name = "homedecor_generic_plastic.png", color = homedecor.color_black },
		"homedecor_fishtank_filter.png",
		"homedecor_fishtank_fishes.png",
		"homedecor_fishtank_gravel.png",
		"homedecor_fishtank_water_top.png",
		"homedecor_fishtank_sides.png",
	},
	use_texture_alpha = true,
	selection_box = ft_cbox,
	collision_box = ft_cbox,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.set_node(pos, {name = "homedecor:fishtank_lighted", param2 = node.param2})
		return itemstack
	end
})

homedecor.register("fishtank_lighted", {
	description = S("Fishtank (lighted)"),
	mesh = "homedecor_fishtank.obj",
	tiles = {
		{ name = "homedecor_generic_plastic.png", color = homedecor.color_black },
		"homedecor_fishtank_filter.png",
		"homedecor_fishtank_fishes_lighted.png",
		"homedecor_fishtank_gravel_lighted.png",
		"homedecor_fishtank_water_top_lighted.png",
		"homedecor_fishtank_sides_lighted.png",
	},
	light_source = default.LIGHT_MAX-4,
	use_texture_alpha = true,
	selection_box = ft_cbox,
	collision_box = ft_cbox,
	groups = {cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.set_node(pos, {name = "homedecor:fishtank", param2 = node.param2})
		return itemstack
	end,
	drop = "homedecor:fishtank",
})

homedecor.register("cardboard_box_big", {
	description = S("Cardboard box (big)"),
	tiles = {
		'homedecor_cardbox_big_tb.png',
		'homedecor_cardbox_big_tb.png',
		'homedecor_cardbox_big_sides.png',
	},
	groups = { snappy = 3 },
	infotext=S("Cardboard box"),
	inventory = {
		size=24,
	},
})

homedecor.register("cardboard_box", {
	description = S("Cardboard box"),
	tiles = {
		'homedecor_cardbox_tb.png',
		'homedecor_cardbox_tb.png',
		'homedecor_cardbox_sides.png',
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.3125, 0.3125, 0, 0.3125},
		}
	},
	groups = { snappy = 3 },
	infotext=S("Cardboard box"),
	inventory = {
		size=8,
	},
})

homedecor.register("dvd_cd_cabinet", {
	description = S("DVD/CD cabinet"),
	mesh = "homedecor_dvd_cabinet.obj",
	tiles = {
		"default_wood.png",
		"homedecor_dvdcd_cabinet_front.png",
		"homedecor_dvdcd_cabinet_back.png"
	},
	selection_box = homedecor.nodebox.slab_z(-0.5),
	groups = {choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
})

local pooltable_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 0.5, 0.3125, 1.5 }
}

homedecor.register("pool_table", {
	mesh = "homedecor_pool_table.obj",
	tiles = {
		"homedecor_pool_table_cue.png",
		"homedecor_pool_table_baize.png",
		"homedecor_pool_table_pockets.png",
		"homedecor_pool_table_balls.png",
		homedecor.lux_wood,
	},
	description = S("Pool Table"),
	inventory_image = "homedecor_pool_table_inv.png",
	groups = {snappy=3},
	selection_box = pooltable_cbox,
	collision_box = pooltable_cbox,
	expand = { forward="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	on_rotate = screwdriver.disallow
})

minetest.register_alias("homedecor:pool_table_2", "air")

local piano_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.125, 1.5, 0.5, 0.5 }
}

homedecor.register("piano", {
	mesh = "homedecor_piano.obj",
	tiles = {
		{ name = "homedecor_generic_wood_luxury.png", color = homedecor.color_black },
		"homedecor_piano_keys.png",
		"homedecor_generic_metal_brass.png",
	},
	inventory_image = "homedecor_piano_inv.png",
	description = S("Piano"),
	groups = { snappy = 3 },
	selection_box = piano_cbox,
	collision_box = piano_cbox,
	expand = { right="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	on_rotate = screwdriver.disallow
})

minetest.register_alias("homedecor:piano_left", "homedecor:piano")
minetest.register_alias("homedecor:piano_right", "air")

local tr_cbox = {
	type = "fixed",
	fixed = { -0.3125, -0.5, -0.1875, 0.3125, 0.125, 0.1875 }
}

homedecor.register("trophy", {
	description = S("Trophy"),
	mesh = "homedecor_trophy.obj",
	tiles = {
		"default_wood.png",
		"homedecor_generic_metal_gold.png"
	},
	inventory_image = "homedecor_trophy_inv.png",
	groups = { snappy=3 },
	walkable = false,
	selection_box = tr_cbox,
})

local sb_cbox = {
	type = "fixed",
	fixed = { -0.4, -0.5, -0.5, 0.4, 0.375, 0.5 }
}

homedecor.register("sportbench", {
	description = S("Sport bench"),
	mesh = "homedecor_sport_bench.obj",
	tiles = {
		"homedecor_generic_metal_wrought_iron.png",
		"homedecor_generic_metal_bright.png",
		{ name = "homedecor_generic_metal.png", color = homedecor.color_black },
		"wool_black.png"
	},
	inventory_image = "homedecor_sport_bench_inv.png",
	groups = { snappy=3 },
	selection_box = sb_cbox,
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
})

local skate_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.15, 0.5, -0.3, 0.15 }
}

homedecor.register("skateboard", {
	drawtype = "mesh",
	mesh = "homedecor_skateboard.obj",
	tiles = { "homedecor_skateboard.png" },
	inventory_image = "homedecor_skateboard_inv.png",
	description = S("Skateboard"),
	groups = {snappy=3},
	selection_box = skate_cbox,
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

homedecor.register("tool_cabinet", {
	description = S("Metal tool cabinet and work table"),
	mesh = "homedecor_tool_cabinet.obj",
	tiles = {
		{ name = "homedecor_generic_metal.png", color = 0xffd00000 },
		"homedecor_tool_cabinet_drawers.png",
		{ name = "homedecor_generic_metal.png", color = 0xff006000 },
		{ name = "homedecor_generic_metal.png", color = homedecor.color_med_grey },
		"homedecor_generic_metal_bright.png",
		"homedecor_tool_cabinet_misc.png",
	},
	inventory_image = "homedecor_tool_cabinet_inv.png",
	on_rotate = screwdriver.rotate_simple,
	groups = { snappy=3 },
	selection_box = homedecor.nodebox.slab_y(2),
	expand = { top="placeholder" },
	inventory = {
		size=24,
	}
})

minetest.register_alias("homedecor:tool_cabinet_bottom", "homedecor:tool_cabinet")
minetest.register_alias("homedecor:tool_cabinet_top", "air")

local pframe_cbox = {
	type = "fixed",
	fixed = { -0.18, -0.5, -0.08, 0.18, -0.08, 0.18 }
}
local n = { 1, 2 }

for _, i in ipairs(n) do
	homedecor.register("picture_frame"..i, {
		description = S("Picture Frame"),
		mesh = "homedecor_picture_frame.obj",
		tiles = {
			"homedecor_picture_frame_image"..i..".png",
			homedecor.lux_wood,
			"homedecor_picture_frame_back.png",
		},
		inventory_image = "homedecor_picture_frame"..i.."_inv.png",
		wield_image = "homedecor_picture_frame"..i.."_inv.png",
		groups = {snappy = 3},
		selection_box = pframe_cbox,
		walkable = false,
		sounds = default.node_sound_glass_defaults()
	})
end

local p_cbox = {
	type = "fixed",
	fixed = {
		{ -0.5, -0.5, 0.4375, 0.5, 0.5, 0.5 }
	}
}

for i = 1,20 do
	homedecor.register("painting_"..i, {
		description = S("Decorative painting #@1", i),
		mesh = "homedecor_painting.obj",
		tiles = {
			"default_wood.png",
			"homedecor_blank_canvas.png",
			"homedecor_painting"..i..".png"
		},
		selection_box = p_cbox,
		walkable = false,
		groups = {snappy=3},
		sounds = default.node_sound_wood_defaults(),
	})
end

homedecor.banister_materials = {
	{	"wood",
		S("wood"),
		"default_wood.png",
		"default_wood.png",
		"group:wood",
		"group:stick",
		"",
		""
	},
	{	"white_dark",
		S("dark topped"),
		homedecor.white_wood,
		homedecor.dark_wood,
		"group:wood",
		"group:stick",
		"dye:brown",
		"dye:white"
	},
	{	"brass",
		S("brass"),
		homedecor.white_wood,
		"homedecor_generic_metal_brass.png",
		"technic:brass_ingot",
		"group:stick",
		"",
		"dye:white"
	},
	{	"wrought_iron",
		S("wrought iron"),
		"homedecor_generic_metal_wrought_iron.png",
		"homedecor_generic_metal_wrought_iron.png",
		"homedecor:pole_wrought_iron",
		"homedecor:pole_wrought_iron",
		"",
		""
	}
}

for _, side in ipairs({"diagonal_left", "diagonal_right", "horizontal"}) do

	local sidedesc = side:match("^diagonal") and S("diagonal") or S("horizontal")

	for _, mat in ipairs(homedecor.banister_materials) do

		local name, matdesc, tile1, tile2 = unpack(mat)
		local nodename = "banister_"..name.."_"..side

		local groups = { snappy = 3, not_in_creative_inventory = 1 }
		local cbox = {
			type = "fixed",
			fixed = { -9/16, -3/16, 5/16, 9/16, 24/16, 8/16 }
		}

		if side == "horizontal" then
			groups = { snappy = 3 }
			cbox = {
				type = "fixed",
				fixed = { -8/16, -8/16, 5/16, 8/16, 8/16, 8/16 }
			}
		else
			minetest.register_alias(string.gsub("homedecor:"..nodename, "diagonal_", ""), "homedecor:"..nodename)
		end

		homedecor.register(nodename, {
			description = S("Banister for Stairs (@1, @2)", matdesc, sidedesc),
			mesh = "homedecor_banister_"..side..".obj",
			tiles = {
				tile1,
				tile2,
			},
			inventory_image = "homedecor_banister_"..name.."_inv.png",
			groups = groups,
			selection_box = cbox,
			collision_box = cbox,
			on_place = homedecor.place_banister,
			drop = "homedecor:banister_"..name.."_horizontal",
		})
	end
end

homedecor.register("spiral_staircase", {
	description = "Spiral Staircase",
	mesh = "homedecor_spiral_staircase.obj",
	wield_scale = { x=0.4, y=0.4, z=0.4 },
	tiles = {
		"homedecor_generic_metal_wrought_iron.png",
	},
	selection_box = {
		type = "fixed",
		fixed = { -1.5, -0.5, -1.5, 0.5, 2.5, 0.5 }
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5625, -0.5, -0.5625, -0.4375, 2.5, -0.4375}, -- NodeBox9
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0}, -- NodeBox14
			{-0.5, -0.125, -0.5, -0.25, -0.0625, 0.5}, -- NodeBox15
			{-0.25, -0.125, -0.0625, 0, -0.0625, 0.5}, -- NodeBox16
			{-1, 0.25, -0.5, -0.5, 0.3125, 0.5}, -- NodeBox17
			{-1.5, 0.625, -0.5, -0.5, 0.6875, -0.25}, -- NodeBox18
			{-1.5, 0.625, -0.25, -0.9375, 0.6875, 0}, -- NodeBox19
			{-1.5, 1, -1, -0.5, 1.0625, -0.5}, -- NodeBox20
			{-0.75, 1.375, -1.5, -0.5, 1.4375, -0.5}, -- NodeBox21
			{-1, 1.375, -1.5, -0.75, 1.4375, -1}, -- NodeBox22
			{-0.5, 1.75, -1.5, 0.0625, 1.8125, -0.5}, -- NodeBox23
			{-0.5, 2.125, -0.8125, 0.5, 2.1875, -0.5}, -- NodeBox24
			{-0.0625, 2.125, -1.0625, 0.5, 2.1875, -0.75}, -- NodeBox25
			{-1.5, -0.125, 0.4375, 0.5, 1.625, 0.5}, -- NodeBox26
			{-1.5, 1.5625, -1.5, -1.4375, 2.875, 0.5}, -- NodeBox27
			{-1.5, 1.75, -1.5, 0.5, 3.3125, -1.4375}, -- NodeBox28
			{0.4375, -0.5, -0.5, 0.5, 0.875, 0.5}, -- NodeBox29
			{0.4375, 2.125, -1.5, 0.5, 3.3125, 0.5}, -- NodeBox30
		}
	},
	groups = {cracky = 1},
	sounds = default.node_sound_wood_defaults(),
	on_rotate = screwdriver.rotate_simple,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		local leftx =  homedecor.fdir_to_left[fdir+1][1]
		local leftz =  homedecor.fdir_to_left[fdir+1][2]
		local revx  = -homedecor.fdir_to_fwd[fdir+1][1]
		local revz  = -homedecor.fdir_to_fwd[fdir+1][2]

		local corner1 = { x = pos.x + leftx + revx, y = pos.y, z = pos.z + leftz + revz}
		local corner2 = { x = pos.x, y = pos.y + 2, z = pos.z }

		local minp = { x = math.min(corner1.x, corner2.x),
		               y = math.min(corner1.y, corner2.y),
		               z = math.min(corner1.z, corner2.z) }

		local maxp = { x = math.max(corner1.x, corner2.x),
		               y = math.max(corner1.y, corner2.y),
		               z = math.max(corner1.z, corner2.z) }

		if #minetest.find_nodes_in_area(minp, maxp, "air") < 11 then
			minetest.set_node(pos, {name = "air"})
			minetest.chat_send_player(placer:get_player_name(), S("not enough space"))
			return true
		end

		local belownode = minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })

		if belownode and belownode.name == "homedecor:spiral_staircase" then
			local newpos = { x = pos.x, y = pos.y + 2, z = pos.z }
			minetest.set_node(pos, { name = "air" })
			minetest.set_node(newpos, { name = "homedecor:spiral_staircase", param2 = belownode.param2 })
		end
	end
})

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
	local belownode = minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })

	if newnode.name ~= "homedecor:spiral_staircase"
	  and belownode
	  and belownode.name == "homedecor:spiral_staircase" then
		minetest.set_node(pos, { name = "air" })

		local newpos = { x = pos.x, y = pos.y + 2, z = pos.z }
		local checknode = minetest.get_node(newpos)

		if checknode and checknode.name == "air" then
			local fdir = minetest.dir_to_facedir(placer:get_look_dir())
			minetest.set_node(newpos, { name = newnode.name, param2 = fdir })
		else
			return true
		end
	end
end)
