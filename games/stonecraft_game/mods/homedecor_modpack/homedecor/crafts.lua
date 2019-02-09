-- Crafting for homedecor mod (includes folding) by Vanessa Ezekowitz
--
-- Mostly my own code; overall template borrowed from game default

local S = homedecor_i18n.gettext

-- misc craftitems

minetest.register_craftitem("homedecor:roof_tile_terracotta", {
        description = S("Terracotta Roof Tile"),
        inventory_image = "homedecor_roof_tile_terracotta.png",
})

minetest.register_craftitem("homedecor:drawer_small", {
        description = S("Small Wooden Drawer"),
        inventory_image = "homedecor_drawer_small.png",
})

minetest.register_craftitem("homedecor:blank_canvas", {
	description = S("Blank Canvas"),
	inventory_image = "homedecor_blank_canvas.png"
})

minetest.register_craftitem("homedecor:vcr", {
	description = S("VCR"),
	inventory_image = "homedecor_vcr.png"
})

minetest.register_craftitem("homedecor:dvd_player", {
	description = S("DVD Player"),
	inventory_image = "homedecor_dvd_player.png"
})

minetest.register_craftitem("homedecor:speaker_driver", {
	description = S("Speaker driver"),
	inventory_image = "homedecor_speaker_driver_inv.png"
})

minetest.register_craftitem("homedecor:fan_blades", {
	description = S("Fan blades"),
	inventory_image = "homedecor_fan_blades.png"
})

minetest.register_craftitem("homedecor:soda_can", {
	description = S("Soda Can"),
	inventory_image = "homedecor_soda_can.png",
	on_use = minetest.item_eat(2),
})

-- the actual crafts

minetest.register_craft( {
    output = "homedecor:fan_blades 2",
    recipe = {
		{ "", "basic_materials:plastic_sheet", "" },
		{ "", "default:steel_ingot", "" },
		{ "basic_materials:plastic_sheet", "", "basic_materials:plastic_sheet" }
    },
})

minetest.register_craft({
        type = "cooking",
        output = "homedecor:roof_tile_terracotta",
        recipe = "basic_materials:terracotta_base",
})

minetest.register_craft( {
        output = "homedecor:shingles_terracotta",
        recipe = {
                { "homedecor:roof_tile_terracotta", "homedecor:roof_tile_terracotta"},
                { "homedecor:roof_tile_terracotta", "homedecor:roof_tile_terracotta"},
        },
})

minetest.register_craft( {
        output = "homedecor:roof_tile_terracotta 8",
        recipe = {
			{ "homedecor:shingles_terracotta", "homedecor:shingles_terracotta" }
		}
})

minetest.register_craft( {
        output = "homedecor:flower_pot_terracotta",
        recipe = {
                { "homedecor:roof_tile_terracotta", "default:dirt", "homedecor:roof_tile_terracotta" },
                { "homedecor:roof_tile_terracotta", "homedecor:roof_tile_terracotta", "homedecor:roof_tile_terracotta" },
        },
})

--

minetest.register_craft( {
        output = "homedecor:flower_pot_green",
        recipe = {
                { "", "dye:dark_green", "" },
                { "basic_materials:plastic_sheet", "default:dirt", "basic_materials:plastic_sheet" },
                { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
        },
})

minetest.register_craft( {
        output = "homedecor:flower_pot_black",
        recipe = {
                { "dye:black", "dye:black", "dye:black" },
                { "basic_materials:plastic_sheet", "default:dirt", "basic_materials:plastic_sheet" },
                { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
        },
})

--

minetest.register_craft( {
        output = "homedecor:projection_screen 3",
        recipe = {
		{ "", "default:glass", "" },
                { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
                { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "homedecor:projection_screen",
        burntime = 30,
})

--

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:ceiling_paint 20",
        recipe = {
                "dye:white",
                "dye:white",
                "default:sand",
		"bucket:bucket_water",
        },
	replacements = { { "bucket:bucket_water","bucket:bucket_empty" } }
})

minetest.register_craft( {
        output = "homedecor:ceiling_tile 10",
        recipe = {
                { "", "dye:white", "" },
                { "default:steel_ingot", "default:stone", "default:steel_ingot" },

        },
})

minetest.register_craft( {
        output = "homedecor:glass_table_small_round_b 15",
        recipe = {
                { "", "default:glass", "" },
                { "default:glass", "default:glass", "default:glass" },
                { "", "default:glass", "" },
        },
})

minetest.register_craft( {
        output = "homedecor:glass_table_small_square_b 2",
        recipe = {
		{"homedecor:glass_table_small_round", "homedecor:glass_table_small_round" },
	}
})

minetest.register_craft( {
        output = "homedecor:glass_table_large_b 2",
        recipe = {
		{ "homedecor:glass_table_small_square", "homedecor:glass_table_small_square" },
	}
})

--

minetest.register_craft( {
        output = "homedecor:wood_table_small_round_b 15",
        recipe = {
                { "", "group:wood", "" },
                { "group:wood", "group:wood", "group:wood" },
                { "", "group:wood", "" },
        },
})

minetest.register_craft( {
        output = "homedecor:wood_table_small_square_b 2",
        recipe = {
		{ "homedecor:wood_table_small_round","homedecor:wood_table_small_round" },
	}
})

minetest.register_craft( {
        output = "homedecor:wood_table_large_b 2",
        recipe = {
		{ "homedecor:wood_table_small_square", "homedecor:wood_table_small_square" },
	}
})

--

minetest.register_craft({
        type = "fuel",
        recipe = "homedecor:wood_table_small_round_b",
        burntime = 30,
})

minetest.register_craft({
        type = "fuel",
        recipe = "homedecor:wood_table_small_square_b",
        burntime = 30,
})

minetest.register_craft({
        type = "fuel",
        recipe = "homedecor:wood_table_large_b",
        burntime = 30,
})

--

minetest.register_craft( {
        output = "homedecor:shingles_asphalt 6",
        recipe = {
                { "building_blocks:gravel_spread", "dye:black", "building_blocks:gravel_spread" },
                { "group:sand", "dye:black", "group:sand" },
                { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
        },
})

--

minetest.register_craft( {
        output = "homedecor:shingles_wood 12",
        recipe = {
                { "group:stick", "group:wood"},
                { "group:wood", "group:stick"},
        },
})

minetest.register_craft( {
        output = "homedecor:shingles_wood 12",
        recipe = {
                { "group:wood", "group:stick"},
                { "group:stick", "group:wood"},
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "homedecor:shingles_wood",
        burntime = 30,
})

--

minetest.register_craft( {
        output = "homedecor:skylight 4",
        recipe = {
		{ "homedecor:glass_table_large", "homedecor:glass_table_large" },
		{ "homedecor:glass_table_large", "homedecor:glass_table_large" },
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:skylight_frosted",
        recipe = {
			"dye:white",
			"homedecor:skylight"
		},
})

minetest.register_craft({
        type = "cooking",
        output = "homedecor:skylight",
        recipe = "homedecor:skylight_frosted",
})

minetest.register_craft( {
	output = "homedecor:shutter 2",
	recipe = {
		{ "group:stick", "group:stick" },
		{ "group:stick", "group:stick" },
		{ "group:stick", "group:stick" },
	},
})

unifieddyes.register_color_craft({
	output = "homedecor:shutter_colored",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "homedecor:shutter",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft({
        type = "fuel",
        recipe = "homedecor:shutter_oak",
        burntime = 30,
})

minetest.register_craft( {
        output = "homedecor:drawer_small",
        recipe = {
                { "group:wood", "default:steel_ingot", "group:wood" },
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "homedecor:drawer_small",
        burntime = 30,
})

--

minetest.register_craft( {
        output = "homedecor:nightstand_oak_one_drawer",
        recipe = {
                { "homedecor:drawer_small" },
                { "group:wood" },
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "homedecor:nightstand_oak_one_drawer",
        burntime = 30,
})

minetest.register_craft( {
        output = "homedecor:nightstand_oak_two_drawers",
        recipe = {
                { "homedecor:drawer_small" },
                { "homedecor:drawer_small" },
                { "group:wood" },
        },
})

minetest.register_craft( {
        output = "homedecor:nightstand_oak_two_drawers",
        recipe = {
                { "homedecor:nightstand_oak_one_drawer" },
                { "homedecor:drawer_small" },
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "homedecor:nightstand_oak_two_drawers",
        burntime = 30,
})

--

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:nightstand_mahogany_one_drawer",
        recipe = {
                "homedecor:nightstand_oak_one_drawer",
                "dye:brown",
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "homedecor:nightstand_mahogany_one_drawer",
        burntime = 30,
})

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:nightstand_mahogany_two_drawers",
        recipe = {
                "homedecor:nightstand_oak_two_drawers",
                "dye:brown",
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "homedecor:nightstand_mahogany_two_drawers",
        burntime = 30,
})

-- Table legs

minetest.register_craft( {
        output = "homedecor:table_legs_wrought_iron 3",
        recipe = {
                { "", "default:iron_lump", "" },
                { "", "default:iron_lump", "" },
                { "default:iron_lump", "default:iron_lump", "default:iron_lump" },
        },
})

minetest.register_craft( {
        output = "homedecor:table_legs_brass 3",
	recipe = {
		{ "", "basic_materials:brass_ingot", "" },
		{ "", "basic_materials:brass_ingot", "" },
		{ "basic_materials:brass_ingot", "basic_materials:brass_ingot", "basic_materials:brass_ingot" }
	},
})

minetest.register_craft( {
        output = "homedecor:utility_table_legs",
        recipe = {
                { "group:stick", "group:stick", "group:stick" },
                { "group:stick", "", "group:stick" },
                { "group:stick", "", "group:stick" },
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "homedecor:utility_table_legs",
        burntime = 30,
})

-- vertical poles/lampposts

minetest.register_craft( {
        output = "homedecor:pole_brass 4",
	recipe = {
		{ "", "basic_materials:brass_ingot", "" },
		{ "", "basic_materials:brass_ingot", "" },
		{ "", "basic_materials:brass_ingot", "" }
	},
})

minetest.register_craft( {
        output = "homedecor:pole_wrought_iron 4",
        recipe = {
                { "default:iron_lump", },
                { "default:iron_lump", },
                { "default:iron_lump", },
        },
})

-- Home electronics

minetest.register_craft( {
	output = "basic_materials:ic 4",
	recipe = {
		{ "basic_materials:silicon", "basic_materials:silicon" },
		{ "basic_materials:silicon", "default:copper_ingot" },
	},
})

minetest.register_craft( {
	output = "homedecor:television",
	recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "moreblocks:glow_glass", "basic_materials:plastic_sheet" },
		{ "basic_materials:ic", "basic_materials:ic", "basic_materials:ic" },
	},
})

minetest.register_craft( {
	output = "homedecor:television",
	recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "default:glass", "basic_materials:plastic_sheet" },
		{ "basic_materials:ic", "basic_materials:energy_crystal_simple", "basic_materials:ic" },
	},
})

minetest.register_craft( {
	output = "homedecor:stereo",
	recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "basic_materials:ic", "basic_materials:plastic_sheet" },
		{ "default:steel_ingot", "basic_materials:ic", "default:steel_ingot" },
	},
})

-- ===========================================================
-- Recipes that require materials from wool (cotton alternate)

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:rug_small 8",
	recipe = {
			"wool:red",
			"wool:yellow",
			"wool:blue",
			"wool:black"
	},
})

minetest.register_craft( {
	output = "homedecor:rug_persian 8",
	recipe = {
		{ "", "wool:yellow", "" },
		{ "wool:red", "wool:blue", "wool:red" },
		{ "", "wool:yellow", "" }
	},
})

-- cotton versions:

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:rug_small 8",
	recipe = {
			"cotton:red",
			"cotton:yellow",
			"cotton:blue",
			"cotton:black"
	},
})

minetest.register_craft( {
	output = "homedecor:rug_persian 8",
	recipe = {
		{ "", "cotton:yellow", "" },
		{ "cotton:red", "cotton:blue", "cotton:red" },
		{ "", "cotton:yellow", "" }
	},
})

-- fuel recipes for same

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:rug_small",
	burntime = 30,
})

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:rug_large 2",
	recipe = {
		"homedecor:rug_small",
		"homedecor:rug_small",
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:rug_large",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:rug_persian",
	burntime = 30,
})

-- Speakers

minetest.register_craft( {
        output = "homedecor:speaker_driver 2",
		recipe = {
		{ "", "default:steel_ingot", "" },
		{ "default:paper", "basic_materials:copper_wire", "default:iron_lump" },
		{ "", "default:steel_ingot", "" },
	},
})

minetest.register_craft( {
        output = "homedecor:speaker_small",
		recipe = {
		{ "wool:black", "homedecor:speaker_driver", "group:wood" },
	},
})

minetest.register_craft( {
        output = "homedecor:speaker",
		recipe = {
		{ "wool:black", "homedecor:speaker_driver", "group:wood" },
		{ "wool:black", "homedecor:speaker_driver", "group:wood" },
		{ "wool:black", "group:wood", "group:wood" },
	},
})

-- cotton version

minetest.register_craft( {
        output = "homedecor:speaker_small",
		recipe = {
		{ "cotton:black", "homedecor:speaker_driver", "group:wood" },
	},
})

minetest.register_craft( {
        output = "homedecor:speaker",
		recipe = {
		{ "cotton:black", "homedecor:speaker_driver", "group:wood" },
		{ "cotton:black", "homedecor:speaker_driver", "group:wood" },
		{ "cotton:black", "group:wood", "group:wood" },
	},
})

-- Curtains

minetest.register_craft( {
	output = "homedecor:curtain_closed 4",
		recipe = {
		{ "wool:white", "", ""},
		{ "wool:white", "", ""},
		{ "wool:white", "", ""},
	},
})

minetest.register_craft( {
	output = "homedecor:curtain_closed 4",
		recipe = {
		{ "cottages:wool", "", ""},
		{ "cottages:wool", "", ""},
		{ "cottages:wool", "", ""},
	},
})

unifieddyes.register_color_craft({
	output = "homedecor:curtain_closed",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "homedecor:curtain_closed",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

unifieddyes.register_color_craft({
	output = "homedecor:curtain_open",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "homedecor:curtain_open",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

local mats = {
	{ "brass", "homedecor:pole_brass" },
	{ "wrought_iron", "homedecor:pole_wrought_iron" },
	{ "wood", "group:stick" }
}

for i in ipairs(mats) do
	local material = mats[i][1]
	local ingredient = mats[i][2]
	minetest.register_craft( {
		output = "homedecor:curtainrod_"..material.." 3",
		recipe = {
			{ ingredient, ingredient, ingredient },
		},
	})
end

-- Recycling recipes

-- Some glass objects recycle via the glass fragments item/recipe in the Vessels mod.

minetest.register_craft({
        type = "shapeless",
        output = "vessels:glass_fragments",
        recipe = {
		"homedecor:glass_table_small_round",
		"homedecor:glass_table_small_round",
		"homedecor:glass_table_small_round"
	}
})

minetest.register_craft({
        type = "shapeless",
        output = "vessels:glass_fragments",
        recipe = {
		"homedecor:glass_table_small_square",
		"homedecor:glass_table_small_square",
		"homedecor:glass_table_small_square"
	}
})

minetest.register_craft({
        type = "shapeless",
        output = "vessels:glass_fragments",
        recipe = {
		"homedecor:glass_table_large",
		"homedecor:glass_table_large",
		"homedecor:glass_table_large"
	}
})

minetest.register_craft({
        type = "shapeless",
        output = "vessels:glass_fragments 2",
        recipe = {
		"homedecor:skylight",
		"homedecor:skylight",
		"homedecor:skylight",
		"homedecor:skylight",
		"homedecor:skylight",
		"homedecor:skylight"
	}
})

-- Wooden tabletops can turn into sticks

minetest.register_craft({
        type = "shapeless",
        output = "default:stick 4",
        recipe = {
		"homedecor:wood_table_small_round",
		"homedecor:wood_table_small_round",
		"homedecor:wood_table_small_round"
	}
})

minetest.register_craft({
        type = "shapeless",
        output = "default:stick 4",
        recipe = {
		"homedecor:wood_table_small_square",
		"homedecor:wood_table_small_square",
		"homedecor:wood_table_small_square"
	}
})

minetest.register_craft({
        type = "shapeless",
        output = "default:stick 4",
        recipe = {
		"homedecor:wood_table_large",
		"homedecor:wood_table_large",
		"homedecor:wood_table_large"
	}
})

-- Kitchen stuff

minetest.register_craft({
        output = "homedecor:oven_steel",
        recipe = {
		{"basic_materials:heating_element", "default:steel_ingot", "basic_materials:heating_element", },
		{"default:steel_ingot", "moreblocks:iron_glass", "default:steel_ingot", },
		{"default:steel_ingot", "basic_materials:heating_element", "default:steel_ingot", },
	}
})

minetest.register_craft({
        output = "homedecor:oven_steel",
        recipe = {
		{"basic_materials:heating_element", "default:steel_ingot", "basic_materials:heating_element", },
		{"default:steel_ingot", "default:glass", "default:steel_ingot", },
		{"default:steel_ingot", "basic_materials:heating_element", "default:steel_ingot", },
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "homedecor:oven",
	recipe = {
		"homedecor:oven_steel",
		"dye:white",
		"dye:white",
	}
})

minetest.register_craft({
        output = "homedecor:microwave_oven 2",
        recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", },
		{"default:steel_ingot", "moreblocks:iron_glass", "basic_materials:ic", },
		{"default:steel_ingot", "default:copper_ingot", "basic_materials:energy_crystal_simple", },
	}
})

minetest.register_craft({
        output = "homedecor:microwave_oven 2",
        recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", },
		{"default:steel_ingot", "default:glass", "basic_materials:ic", },
		{"default:steel_ingot", "default:copper_ingot", "basic_materials:energy_crystal_simple", },
	}
})

minetest.register_craft({
	output = "homedecor:refrigerator_steel",
	recipe = {
		{"default:steel_ingot", "homedecor:glowlight_small_cube", "default:steel_ingot", },
		{"default:steel_ingot", "default:copperblock", "default:steel_ingot", },
		{"default:steel_ingot", "default:clay", "default:steel_ingot", },
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "homedecor:refrigerator_white",
	recipe = {
		"homedecor:refrigerator_steel",
		"dye:white",
		"dye:white",
		"dye:white",
	}
})

minetest.register_craft({
        output = "homedecor:kitchen_cabinet",
        recipe = {
		{"group:wood", "group:stick", "group:wood", },
		{"group:wood", "group:stick", "group:wood", },
		{"group:wood", "group:stick", "group:wood", },
	}
})

minetest.register_craft({
        output = "homedecor:kitchen_cabinet_steel",
        recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"", "homedecor:kitchen_cabinet", ""},
	}
})

minetest.register_craft({
        output = "homedecor:kitchen_cabinet_steel",
        recipe = {
			{"moreblocks:slab_steelblock_1"},
			{ "homedecor:kitchen_cabinet" },
	}
})

minetest.register_craft({
        output = "homedecor:kitchen_cabinet_marble",
        recipe = {
			{"building_blocks:slab_marble"},
			{"homedecor:kitchen_cabinet"},
	}
})

minetest.register_craft({
        output = "homedecor:kitchen_cabinet_marble",
        recipe = {
			{"technic:slab_marble_1"},
			{"homedecor:kitchen_cabinet"},
	}
})

minetest.register_craft({
        output = "homedecor:kitchen_cabinet_granite",
        recipe = {
			{"technic:slab_granite_1"},
			{"homedecor:kitchen_cabinet"},
	}
})

minetest.register_craft({
	type = "shapeless",
        output = "homedecor:kitchen_cabinet_half 2",
        recipe = { "homedecor:kitchen_cabinet" }
})

minetest.register_craft({
        output = "homedecor:kitchen_cabinet_with_sink",
        recipe = {
		{"group:wood", "default:steel_ingot", "group:wood", },
		{"group:wood", "default:steel_ingot", "group:wood", },
		{"group:wood", "group:stick", "group:wood", },
	}
})

------- Lighting

-- candles

minetest.register_craft({
	output = "homedecor:candle_thin 4",
	recipe = {
		{"farming:string" },
		{"basic_materials:paraffin" }
	}
})

minetest.register_craft({
	output = "homedecor:candle 2",
	recipe = {
		{"farming:string" },
		{"basic_materials:paraffin" },
		{"basic_materials:paraffin" }
	}
})

minetest.register_craft({
	output = "homedecor:wall_sconce 2",
	recipe = {
		{"default:iron_lump", "", ""},
		{"default:iron_lump", "homedecor:candle", ""},
		{"default:iron_lump", "", ""},
	}
})

minetest.register_craft({
	output = "homedecor:candlestick_wrought_iron",
	recipe = {
		{""},
		{"homedecor:candle_thin"},
		{"default:iron_lump"},
	}
})

minetest.register_craft({
	output = "homedecor:candlestick_brass",
	recipe = {
		{""},
		{"homedecor:candle_thin"},
		{"basic_materials:brass_ingot"},
	}
})

minetest.register_craft({
	output = "homedecor:oil_lamp",
	recipe = {
		{ "", "vessels:glass_bottle", "" },
		{ "", "farming:string", "" },
		{ "default:steel_ingot", "basic_materials:oil_extract", "default:steel_ingot" }
	}
})

minetest.register_craft({
	output = "homedecor:oil_lamp_tabletop",
	recipe = {
		{ "", "vessels:glass_bottle", "" },
		{ "", "farming:string", "" },
		{ "default:iron_lump", "basic_materials:oil_extract", "default:iron_lump" }
	}
})

-- Wrought-iron wall latern

minetest.register_craft({
	output = "homedecor:ground_lantern",
	recipe = {
		{ "default:iron_lump", "default:iron_lump", "default:iron_lump" },
		{ "default:iron_lump", "default:torch", "default:iron_lump" },
		{ "", "default:iron_lump", "" }
	}
})

-- wood-lattice lamps

if minetest.get_modpath("darkage") then
	minetest.register_craft( {
		output = "homedecor:lattice_lantern_small 8",
		recipe = {
			{ "darkage:lamp" },
		},
	})

	minetest.register_craft( {
		output = "darkage:lamp",
		type = "shapeless",
		recipe = {
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
		},
	})
else
	minetest.register_craft( {
			output = "homedecor:lattice_lantern_large 2",
			recipe = {
				{ "dye:black", "dye:yellow", "dye:black" },
				{ "group:stick", "building_blocks:woodglass", "group:stick" },
				{ "group:stick", "basic_materials:energy_crystal_simple", "group:stick" }
			},
	})

	minetest.register_craft( {
		output = "homedecor:lattice_lantern_small 8",
		recipe = {
			{ "homedecor:lattice_lantern_large" },
		},
	})

	minetest.register_craft( {
		output = "homedecor:lattice_lantern_large",
		type = "shapeless",
		recipe = {
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
			"homedecor:lattice_lantern_small",
		},
	})
end

-- glowlights

minetest.register_craft({
	output = "homedecor:glowlight_half 6",
	recipe = {
		{ "default:glass", "basic_materials:energy_crystal_simple", "default:glass", },
	}
})

minetest.register_craft({
        output = "homedecor:glowlight_half 6",
        recipe = {
		{"moreblocks:super_glow_glass", "moreblocks:glow_glass", "moreblocks:super_glow_glass", },
	}
})

minetest.register_craft({
        output = "homedecor:glowlight_half",
        recipe = {
		{"homedecor:glowlight_small_cube","homedecor:glowlight_small_cube"},
		{"homedecor:glowlight_small_cube","homedecor:glowlight_small_cube"}
	}
})

minetest.register_craft({
		output = "homedecor:glowlight_half",
		type = "shapeless",
		recipe = {
		"homedecor:glowlight_quarter",
		"homedecor:glowlight_quarter"
	}
})

unifieddyes.register_color_craft({
	output = "homedecor:glowlight_half",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "homedecor:glowlight_half",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft({
        output = "homedecor:glowlight_quarter 6",
        recipe = {
		{"homedecor:glowlight_half", "homedecor:glowlight_half", "homedecor:glowlight_half", },
	}
})

unifieddyes.register_color_craft({
	output = "homedecor:glowlight_quarter",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "homedecor:glowlight_quarter",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft({
	output = "homedecor:glowlight_small_cube 8",
	recipe = {
		{ "dye:white" },
		{ "default:glass" },
		{ "basic_materials:energy_crystal_simple" },
	}
})

minetest.register_craft({
        output = "homedecor:glowlight_small_cube 8",
        recipe = {
		{"dye:white" },
		{"moreblocks:super_glow_glass" },
	}
})

minetest.register_craft({
        output = "homedecor:glowlight_small_cube 4",
        recipe = {
		{"homedecor:glowlight_half" },
	}
})

unifieddyes.register_color_craft({
	output = "homedecor:glowlight_small_cube",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "homedecor:glowlight_small_cube",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

----

minetest.register_craft({
    output = "homedecor:plasma_lamp",
    recipe = {
		{"", "default:glass", ""},
		{"default:glass", "basic_materials:energy_crystal_simple", "default:glass"},
		{"", "default:glass", ""}
	}
})

minetest.register_craft({
    output = "homedecor:plasma_ball 2",
    recipe = {
		{"", "default:glass", ""},
		{"default:glass", "default:copper_ingot", "default:glass"},
		{"basic_materials:plastic_sheet", "basic_materials:energy_crystal_simple", "basic_materials:plastic_sheet"}
	}
})

-- Brass/wrought iron fences


minetest.register_craft( {
        output = "homedecor:fence_brass 6",
	recipe = {
		{ "basic_materials:brass_ingot", "basic_materials:brass_ingot", "basic_materials:brass_ingot" },
		{ "basic_materials:brass_ingot", "basic_materials:brass_ingot", "basic_materials:brass_ingot" },
	},
})

minetest.register_craft( {
	output = "homedecor:fence_wrought_iron 6",
	recipe = {
		{ "default:iron_lump","default:iron_lump","default:iron_lump" },
		{ "default:iron_lump","default:iron_lump","default:iron_lump" },
	},
})

-- other types of fences

minetest.register_craft( {
	output = "homedecor:fence_wrought_iron_2 4",
	recipe = {
		{ "homedecor:pole_wrought_iron", "default:iron_lump" },
		{ "homedecor:pole_wrought_iron", "default:iron_lump" },
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "homedecor:fence_wrought_iron_2_corner",
	recipe = {
		"homedecor:fence_wrought_iron_2",
		"homedecor:fence_wrought_iron_2"
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "homedecor:fence_wrought_iron_2 2",
	recipe = {
		"homedecor:fence_wrought_iron_2_corner",
	},
})

--

minetest.register_craft( {
	output = "homedecor:fence_picket 6",
	recipe = {
		{ "group:stick", "group:stick", "group:stick" },
		{ "group:stick", "", "group:stick" },
		{ "group:stick", "group:stick", "group:stick" }
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "homedecor:fence_picket_corner",
	recipe = {
		"homedecor:fence_picket",
		"homedecor:fence_picket"
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "homedecor:fence_picket 2",
	recipe = {
		"homedecor:fence_picket_corner"
	},
})

--


minetest.register_craft( {
	output = "homedecor:fence_picket_white 6",
	recipe = {
		{ "group:stick", "group:stick", "group:stick" },
		{ "group:stick", "dye:white", "group:stick" },
		{ "group:stick", "group:stick", "group:stick" }
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "homedecor:fence_picket_corner_white",
	recipe = {
		"homedecor:fence_picket_white",
		"homedecor:fence_picket_white"
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "homedecor:fence_picket_white 2",
	recipe = {
		"homedecor:fence_picket_corner_white"
	},
})

--


minetest.register_craft( {
	output = "homedecor:fence_privacy 6",
	recipe = {
		{ "group:wood", "group:stick", "group:wood" },
		{ "group:wood", "", "group:wood" },
		{ "group:wood", "group:stick", "group:wood" }
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "homedecor:fence_privacy_corner",
	recipe = {
		"homedecor:fence_privacy",
		"homedecor:fence_privacy"
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "homedecor:fence_privacy 2",
	recipe = {
		"homedecor:fence_privacy_corner"
	},
})

--


minetest.register_craft( {
	output = "homedecor:fence_barbed_wire 6",
	recipe = {
		{ "group:stick", "basic_materials:steel_wire", "group:stick" },
		{ "group:stick", "", "group:stick" },
		{ "group:stick", "basic_materials:steel_wire", "group:stick" }
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "homedecor:fence_barbed_wire_corner",
	recipe = { "homedecor:fence_barbed_wire", "homedecor:fence_barbed_wire" },
})

minetest.register_craft( {
	type = "shapeless",
	output = "homedecor:fence_barbed_wire 2",
	recipe = { "homedecor:fence_barbed_wire_corner" },
})

--


minetest.register_craft( {
	output = "homedecor:fence_chainlink 9",
	recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "basic_materials:steel_wire", "basic_materials:steel_wire", "default:steel_ingot" },
		{ "basic_materials:steel_wire", "basic_materials:steel_wire", "default:steel_ingot" }
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "homedecor:fence_chainlink_corner",
	recipe = { "homedecor:fence_chainlink", "homedecor:fence_chainlink" },
})

minetest.register_craft( {
	type = "shapeless",
	output = "homedecor:fence_chainlink 2",
	recipe = { "homedecor:fence_chainlink_corner" },
})


-- Gates

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:gate_picket_white_closed",
        recipe = {
			"homedecor:fence_picket_white"
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:fence_picket_white",
        recipe = {
			"homedecor:gate_picket_white_closed"
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:gate_picket_closed",
        recipe = {
			"homedecor:fence_picket"
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:fence_picket",
        recipe = {
			"homedecor:gate_picket_closed"
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:gate_barbed_wire_closed",
        recipe = {
			"homedecor:fence_barbed_wire"
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:fence_barbed_wire",
        recipe = {
			"homedecor:gate_barbed_wire_closed"
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:gate_chainlink_closed",
        recipe = {
			"homedecor:fence_chainlink"
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:fence_chainlink",
        recipe = {
			"homedecor:gate_chainlink_closed"
        },
})

------ Doors

-- plain wood, non-windowed

minetest.register_craft( {
        output = "homedecor:door_wood_plain_left 2",
        recipe = {
			{ "group:wood", "group:wood", "" },
			{ "group:wood", "group:wood", "default:steel_ingot" },
			{ "group:wood", "group:wood", "" },
        },
})

-- fancy exterior

minetest.register_craft( {
        output = "homedecor:door_exterior_fancy_left 2",
        recipe = {
			{ "group:wood", "default:glass" },
			{ "group:wood", "group:wood" },
			{ "group:wood", "group:wood" },
        },
})

-- wood and glass (grid style)

-- bare

minetest.register_craft( {
        output = "homedecor:door_wood_glass_oak_left 2",
        recipe = {
			{ "default:glass", "group:wood" },
			{ "group:wood", "default:glass" },
			{ "default:glass", "group:wood" },
        },
})

minetest.register_craft( {
        output = "homedecor:door_wood_glass_oak_left 2",
        recipe = {
			{ "group:wood", "default:glass" },
			{ "default:glass", "group:wood" },
			{ "group:wood", "default:glass" },
        },
})

-- mahogany

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:door_wood_glass_mahogany_left 2",
        recipe = {
			"default:dirt",
			"default:coal_lump",
			"homedecor:door_wood_glass_oak_left",
			"homedecor:door_wood_glass_oak_left"
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:door_wood_glass_mahogany_left 2",
        recipe = {
			"dye:brown",
			"homedecor:door_wood_glass_oak_left",
			"homedecor:door_wood_glass_oak_left"
        },
})

-- white

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:door_wood_glass_white_left 2",
        recipe = {
			"dye:white",
			"homedecor:door_wood_glass_oak_left",
			"homedecor:door_wood_glass_oak_left"
        },
})

-- Closet doors

-- oak

minetest.register_craft( {
        output = "homedecor:door_closet_oak_left 2",
        recipe = {
			{ "", "group:stick", "group:stick" },
			{ "default:steel_ingot", "group:stick", "group:stick" },
			{ "", "group:stick", "group:stick" },
        },
})

-- mahogany

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:door_closet_mahogany_left 2",
        recipe = {
			"homedecor:door_closet_oak_left",
			"homedecor:door_closet_oak_left",
			"default:dirt",
			"default:coal_lump",
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = "homedecor:door_closet_mahogany_left 2",
        recipe = {
			"homedecor:door_closet_oak_left",
			"homedecor:door_closet_oak_left",
			"dye:brown"
        },
})

-- wrought fence-like door

minetest.register_craft( {
        output = "homedecor:door_wrought_iron_left 2",
        recipe = {
			{ "homedecor:pole_wrought_iron", "default:iron_lump" },
			{ "homedecor:pole_wrought_iron", "default:iron_lump" },
			{ "homedecor:pole_wrought_iron", "default:iron_lump" }
        },
})

-- bedroom door

minetest.register_craft( {
	output = "homedecor:door_bedroom_left",
	recipe = {
		{ "dye:white", "dye:white", "" },
		{ "homedecor:door_wood_plain_left", "basic_materials:brass_ingot", "" },
		{ "", "", "" },
	},
})

-- woodglass door

minetest.register_craft( {
	output = "homedecor:door_woodglass_left",
	recipe = {
		{ "group:wood", "default:glass", "" },
		{ "group:wood", "default:glass", "basic_materials:brass_ingot" },
		{ "group:wood", "group:wood", "" },
	},
})

-- woodglass door type 2

minetest.register_craft( {
	output = "homedecor:door_woodglass2_left",
	recipe = {
		{ "default:glass", "default:glass", "" },
		{ "group:wood", "group:wood", "default:iron_lump" },
		{ "group:wood", "group:wood", "" },
	},
})

-- laundry stuff

minetest.register_craft( {
    output = "homedecor:washing_machine",
    recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "basic_materials:ic" },
		{ "default:steel_ingot", "bucket:bucket_water", "default:steel_ingot" },
		{ "default:steel_ingot", "basic_materials:motor", "default:steel_ingot" }
    },
})

minetest.register_craft( {
    output = "homedecor:washing_machine",
    recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "basic_materials:ic" },
		{ "default:steel_ingot", "bucket:bucket_water", "default:steel_ingot" },
		{ "default:steel_ingot", "technic:motor", "default:steel_ingot" }
    },
})

minetest.register_craft( {
    output = "homedecor:dryer",
    recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "basic_materials:ic" },
		{ "default:steel_ingot", "bucket:bucket_empty", "basic_materials:motor" },
		{ "default:steel_ingot", "basic_materials:heating_element", "default:steel_ingot" }
    },
})

minetest.register_craft( {
    output = "homedecor:dryer",
    recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "basic_materials:ic" },
		{ "default:steel_ingot", "bucket:bucket_empty", "technic:motor" },
		{ "default:steel_ingot", "basic_materials:heating_element", "default:steel_ingot" }
    },
})

minetest.register_craft( {
    output = "homedecor:ironing_board",
    recipe = {
		{ "wool:grey", "wool:grey", "wool:grey"},
		{ "", "default:steel_ingot", "" },
		{ "default:steel_ingot", "", "default:steel_ingot" }
    },
})

-- dishwashers

minetest.register_craft( {
    output = "homedecor:dishwasher",
    recipe = {
		{ "basic_materials:ic", "homedecor:fence_chainlink", "default:steel_ingot",  },
		{ "default:steel_ingot", "homedecor:shower_head", "basic_materials:motor" },
		{ "default:steel_ingot", "basic_materials:heating_element", "bucket:bucket_water" }
    },
})

minetest.register_craft( {
    output = "homedecor:dishwasher",
    recipe = {
		{ "basic_materials:ic", "homedecor:fence_chainlink", "default:steel_ingot",  },
		{ "default:steel_ingot", "homedecor:shower_head", "technic:motor" },
		{ "default:steel_ingot", "basic_materials:heating_element", "bucket:bucket_water" }
    },
})

minetest.register_craft( {
    output = "homedecor:dishwasher_wood",
    recipe = {
		{ "stairs:slab_wood" },
		{ "homedecor:dishwasher" },
    },
})

minetest.register_craft( {
    output = "homedecor:dishwasher_wood",
    recipe = {
		{ "moreblocks:slab_wood" },
		{ "homedecor:dishwasher" },
    },
})

minetest.register_craft( {
    output = "homedecor:dishwasher_wood",
    recipe = {
		{ "moreblocks:slab_wood_1" },
		{ "homedecor:dishwasher" },
    },
})

minetest.register_craft( {
    output = "homedecor:dishwasher_steel",
    recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "", "homedecor:dishwasher", "" },
    },
})

minetest.register_craft( {
    output = "homedecor:dishwasher_steel",
    recipe = {
		{ "moreblocks:slab_steelblock_1" },
		{ "homedecor:dishwasher" },
    },
})

minetest.register_craft( {
    output = "homedecor:dishwasher_marble",
    recipe = {
		{ "building_blocks:slab_marble" },
		{ "homedecor:dishwasher" },
    },
})

minetest.register_craft( {
    output = "homedecor:dishwasher_marble",
    recipe = {
		{ "technic:slab_marble_1" },
		{ "homedecor:dishwasher" },
    },
})

minetest.register_craft( {
    output = "homedecor:dishwasher_granite",
    recipe = {
		{ "technic:slab_granite_1" },
		{ "homedecor:dishwasher" },
    },
})

-- paintings

minetest.register_craft({
    output = "homedecor:blank_canvas",
    recipe = {
		{ "", "group:stick", "" },
		{ "group:stick", "wool:white", "group:stick" },
		{ "", "group:stick", "" },
    }
})

local painting_patterns = {
	[1] = {	{ "brown", "red", "brown" },
			{ "dark_green", "red", "green" } },

	[2] = {	{ "green", "yellow", "green" },
			{ "green", "yellow", "green" } },

	[3] = {	{ "green", "pink", "green" },
			{ "brown", "pink", "brown" } },

	[4] = {	{ "black", "orange", "grey" },
			{ "dark_green", "orange", "orange" } },

	[5] = {	{ "blue", "orange", "yellow" },
			{ "green", "red", "brown" } },

	[6] = {	{ "green", "red", "orange" },
			{ "orange", "yellow", "green" } },

	[7] = {	{ "blue", "dark_green", "dark_green" },
			{ "green", "grey", "green" } },

	[8] = {	{ "blue", "blue", "blue" },
			{ "green", "green", "green" } },

	[9] = {	{ "blue", "blue", "dark_green" },
			{ "green", "grey", "dark_green" } },

	[10] = { { "green", "white", "green" },
			 { "dark_green", "white", "dark_green" } },

	[11] = { { "blue", "white", "blue" },
			 { "blue", "grey", "dark_green" } },

	[12] = { { "green", "green", "green" },
			 { "grey", "grey", "green" } },

	[13] = { { "blue", "blue", "grey" },
			 { "dark_green", "white", "white" } },

	[14] = { { "red", "yellow", "blue" },
			 { "blue", "green", "violet" } },

	[15] = { { "blue", "yellow", "blue" },
			 { "black", "black", "black" } },

	[16] = { { "red", "orange", "blue" },
			 { "black", "dark_grey", "grey" } },

	[17] = { { "orange", "yellow", "orange" },
			 { "black", "black", "black" } },

	[18] = { { "grey", "dark_green", "grey" },
			 { "white", "white", "white" } },

	[19] = { { "white", "brown", "green" },
			 { "green", "brown", "brown" } },

	[20] = { { "blue", "blue", "blue" },
			 { "red", "brown", "grey" } }
}

for i,recipe in pairs(painting_patterns) do

	local item1 = "dye:"..recipe[1][1]
	local item2 = "dye:"..recipe[1][2]
	local item3 = "dye:"..recipe[1][3]
	local item4 = "dye:"..recipe[2][1]
	local item5 = "dye:"..recipe[2][2]
	local item6 = "dye:"..recipe[2][3]

	minetest.register_craft({
		output = "homedecor:painting_"..i,
		recipe = {
			{ item1, item2, item3 },
			{ item4, item5, item6 },
			{"", "homedecor:blank_canvas", "" }
		}
	})
end

-- more misc stuff here

minetest.register_craft({
        output = "homedecor:chimney 2",
        recipe = {
			{ "default:clay_brick", "", "default:clay_brick" },
			{ "default:clay_brick", "", "default:clay_brick" },
			{ "default:clay_brick", "", "default:clay_brick" },
        },
})

minetest.register_craft({
        output = "homedecor:fishtank",
        recipe = {
			{ "basic_materials:plastic_sheet", "homedecor:glowlight_small_cube", "basic_materials:plastic_sheet" },
			{ "default:glass", "bucket:bucket_water", "default:glass" },
			{ "default:glass", "building_blocks:gravel_spread", "default:glass" },
        },
	replacements = { {"bucket:bucket_water", "bucket:bucket_empty"} }
})

minetest.register_craft({
    output = "homedecor:towel_rod",
    recipe = {
		{ "group:wood", "group:stick", "group:wood" },
		{ "", "building_blocks:terrycloth_towel", "" },
    },
})

minetest.register_craft({
    output = "homedecor:toilet_paper",
    recipe = {
		{ "", "default:paper", "default:paper" },
		{ "group:wood", "group:stick", "default:paper" },
		{ "", "default:paper", "default:paper" },
    },
})

minetest.register_craft({
    output = "homedecor:medicine_cabinet",
    recipe = {
		{ "group:stick", "default:glass", "group:stick" },
		{ "group:stick", "default:glass", "group:stick" },
		{ "group:stick", "default:glass", "group:stick" }
    },
})

minetest.register_craft({
    output = "homedecor:cardboard_box 2",
    recipe = {
		{ "default:paper", "", "default:paper" },
		{ "default:paper", "default:paper", "default:paper" },
    },
})

minetest.register_craft({
    output = "homedecor:cardboard_box_big 2",
    recipe = {
		{ "default:paper", "", "default:paper" },
		{ "default:paper", "", "default:paper" },
		{ "default:paper", "default:paper", "default:paper" },
    },
})

minetest.register_craft({
    output = "homedecor:desk",
    recipe = {
		{ "stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood" },
		{ "homedecor:drawer_small", "default:wood", "default:wood" },
		{ "homedecor:drawer_small", "", "default:wood" },
    },
})

minetest.register_craft({
    output = "homedecor:desk",
    recipe = {
		{ "moreblocks:slab_wood", "moreblocks:slab_wood", "moreblocks:slab_wood" },
		{ "homedecor:drawer_small", "default:wood", "default:wood" },
		{ "homedecor:drawer_small", "", "default:wood" },
    },
})

minetest.register_craft({
    output = "homedecor:filing_cabinet",
    recipe = {
		{ "", "default:wood", "" },
		{ "default:wood", "homedecor:drawer_small", "default:wood" },
		{ "", "default:wood", "" },
    },
})

minetest.register_craft({
    output = "homedecor:analog_clock_plastic 2",
    recipe = {
		{ "basic_materials:plastic_sheet", "dye:black", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "basic_materials:ic", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "dye:black", "basic_materials:plastic_sheet" },
    },
})

minetest.register_craft({
    output = "homedecor:analog_clock_wood 2",
    recipe = {
		{ "group:stick", "dye:black", "group:stick" },
		{ "group:stick", "basic_materials:ic", "group:stick" },
		{ "group:stick", "dye:black", "group:stick" },
    },
})

minetest.register_craft({
    output = "homedecor:digital_clock 2",
    recipe = {
		{ "basic_materials:plastic_sheet", "default:paper", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "basic_materials:ic", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "basic_materials:energy_crystal_simple", "basic_materials:plastic_sheet" },
    },
})

minetest.register_craft({
    output = "homedecor:alarm_clock",
    recipe = {
		{ "basic_materials:plastic_sheet", "homedecor:speaker_driver", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "homedecor:digital_clock", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "basic_materials:energy_crystal_simple", "basic_materials:plastic_sheet" },
    },
})

minetest.register_craft({
    output = "homedecor:air_conditioner",
    recipe = {
		{ "default:steel_ingot", "building_blocks:grate", "default:steel_ingot" },
		{ "default:steel_ingot", "homedecor:fan_blades", "basic_materials:motor" },
		{ "default:steel_ingot", "basic_materials:motor", "default:steel_ingot" },
    },
})

minetest.register_craft({
    output = "homedecor:air_conditioner",
    recipe = {
		{ "default:steel_ingot", "building_blocks:grate", "default:steel_ingot" },
		{ "default:steel_ingot", "technic:motor", "default:steel_ingot" },
		{ "default:steel_ingot", "technic:motor", "default:steel_ingot" },
    },
})

minetest.register_craft({
    output = "homedecor:ceiling_fan",
    recipe = {
		{ "basic_materials:motor" },
		{ "homedecor:fan_blades" },
		{ "homedecor:glowlight_small_cube" }
	}
})

minetest.register_craft({
    output = "homedecor:ceiling_fan",
    recipe = {
		{ "technic:motor" },
		{ "homedecor:fan_blades" },
		{ "homedecor:glowlight_small_cube" }
	}
})

minetest.register_craft({
    output = "homedecor:welcome_mat_grey 2",
    recipe = {
		{ "", "dye:black", "" },
		{ "wool:grey", "wool:grey", "wool:grey" },
    },
})

minetest.register_craft({
    output = "homedecor:welcome_mat_brown 2",
    recipe = {
		{ "", "dye:black", "" },
		{ "wool:brown", "wool:brown", "wool:brown" },
    },
})

minetest.register_craft({
    output = "homedecor:welcome_mat_green 2",
    recipe = {
		{ "", "dye:white", "" },
		{ "wool:dark_green", "wool:dark_green", "wool:dark_green" },
    },
})

minetest.register_craft({
    output = "homedecor:welcome_mat_green 2",
    recipe = {
		{ "", "dye:white", "" },
		{ "dye:black", "dye:black", "dye:black" },
		{ "wool:green", "wool:green", "wool:green" },
    },
})

minetest.register_craft({
	type = "shapeless",
    output = "homedecor:window_plain 8",
    recipe = {
		"dye:white",
		"dye:white",
		"dye:white",
		"dye:white",
		"building_blocks:woodglass"
    }
})

minetest.register_craft({
	type = "shapeless",
    output = "homedecor:window_quartered",
    recipe = {
		"dye:white",
		"group:stick",
		"group:stick",
		"homedecor:window_plain"
    }
})

minetest.register_craft({
    output = "homedecor:vcr 2",
    recipe = {
		{ "basic_materials:ic", "default:steel_ingot", "basic_materials:plastic_sheet" },
		{ "default:iron_lump", "default:iron_lump", "default:iron_lump" },
		{ "basic_materials:plastic_sheet", "", "basic_materials:plastic_sheet" },
    },
})

minetest.register_craft({
    output = "homedecor:dvd_player 2",
    recipe = {
		{ "", "basic_materials:plastic_sheet", "" },
		{ "default:obsidian_glass", "basic_materials:motor", "basic_materials:motor" },
		{ "default:mese_crystal_fragment", "basic_materials:ic", "basic_materials:energy_crystal_simple" },
    },
})

minetest.register_craft({
    output = "homedecor:dvd_player 2",
    recipe = {
		{ "", "basic_materials:plastic_sheet", "" },
		{ "default:obsidian_glass", "technic:motor", "technic:motor" },
		{ "default:mese_crystal_fragment", "basic_materials:ic", "basic_materials:energy_crystal_simple" },
    },
})

minetest.register_craft({
	type = "shapeless",
    output = "homedecor:dvd_vcr",
    recipe = {
		"homedecor:vcr",
		"homedecor:dvd_player"
    },
})

minetest.register_craft({
    output = "homedecor:blinds_thin",
    recipe = {
		{ "group:stick", "basic_materials:plastic_sheet", "group:stick" },
		{ "farming:string", "basic_materials:plastic_strip", "" },
		{ "", "basic_materials:plastic_strip", "" },
    },
})

minetest.register_craft({
    output = "homedecor:blinds_thick",
    recipe = {
		{ "group:stick", "basic_materials:plastic_sheet", "group:stick" },
		{ "farming:string", "basic_materials:plastic_strip", "basic_materials:plastic_strip" },
		{ "", "basic_materials:plastic_strip", "basic_materials:plastic_strip" },
    },
})

minetest.register_craft( {
        output = "homedecor:openframe_bookshelf",
        recipe = {
			{"group:wood", "", "group:wood"},
			{"default:book", "default:book", "default:book"},
			{"group:wood", "", "group:wood"},
        },
})

minetest.register_craft( {
        output = "homedecor:desk_fan",
        recipe = {
			{"default:steel_ingot", "homedecor:fan_blades", "basic_materials:motor"},
			{"", "default:steel_ingot", ""}
        },
})

minetest.register_craft( {
        output = "homedecor:space_heater",
        recipe = {
			{"basic_materials:plastic_sheet", "basic_materials:heating_element", "basic_materials:plastic_sheet"},
			{"basic_materials:plastic_sheet", "homedecor:fan_blades", "basic_materials:motor"},
			{"basic_materials:plastic_sheet", "basic_materials:heating_element", "basic_materials:plastic_sheet"}
        },
})

minetest.register_craft( {
        output = "homedecor:radiator",
        recipe = {
			{ "default:steel_ingot", "basic_materials:heating_element", "default:steel_ingot" },
			{ "basic_materials:ic", "basic_materials:heating_element", "" },
			{ "default:steel_ingot", "basic_materials:heating_element", "default:steel_ingot" }
        },
})

-- bathroom/kitchen tiles

minetest.register_craft( {
		output = "homedecor:bathroom_tiles_light 4",
		recipe = {
			{ "group:marble", "group:marble", "" },
			{ "group:marble", "group:marble", "dye:white" }
		},
})

unifieddyes.register_color_craft({
	output = "homedecor:bathroom_tiles_light",
	palette = "extended",
	type = "shapeless",
	neutral_node = "homedecor:bathroom_tiles_light",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft( {
		output = "homedecor:bathroom_tiles_medium 4",
		recipe = {
			{ "group:marble", "group:marble", "" },
			{ "group:marble", "group:marble", "dye:grey" }
		},
})

unifieddyes.register_color_craft({
	output = "homedecor:bathroom_tiles_medium",
	palette = "extended",
	type = "shapeless",
	neutral_node = "homedecor:bathroom_tiles_medium",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft( {
		output = "homedecor:bathroom_tiles_dark 4",
		recipe = {
			{ "group:marble", "group:marble", "" },
			{ "group:marble", "group:marble", "dye:dark_grey" }
		},
})

unifieddyes.register_color_craft({
	output = "homedecor:bathroom_tiles_dark",
	palette = "extended",
	type = "shapeless",
	neutral_node = "homedecor:bathroom_tiles_dark",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

-- misc electrical

minetest.register_craft( {
        output = "homedecor:power_outlet",
        recipe = {
			{"basic_materials:plastic_sheet", "basic_materials:copper_strip"},
			{"basic_materials:plastic_sheet", ""},
			{"basic_materials:plastic_sheet", "basic_materials:copper_strip"}
        },
})

minetest.register_craft( {
        output = "homedecor:light_switch",
        recipe = {
			{"", "basic_materials:plastic_sheet", "basic_materials:copper_strip"},
			{"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:copper_strip"},
			{"", "basic_materials:plastic_sheet", "basic_materials:copper_strip"}
        },
})

-- doghouse

minetest.register_craft( {
        output = "homedecor:doghouse",
        recipe = {
			{"homedecor:shingles_terracotta", "homedecor:shingles_terracotta", "homedecor:shingles_terracotta"},
			{"group:wood", "", "group:wood"},
			{"group:wood", "building_blocks:terrycloth_towel", "group:wood"}
        },
})

-- japanese walls and mat

minetest.register_craft( {
        output = "homedecor:japanese_wall_top",
        recipe = {
			{"group:stick", "default:paper"},
			{"default:paper", "group:stick"},
			{"group:stick", "default:paper"}
        },
})

minetest.register_craft( {
        output = "homedecor:japanese_wall_top",
        recipe = {
			{"default:paper", "group:stick"},
			{"group:stick", "default:paper"},
			{"default:paper", "group:stick"}
        },
})

minetest.register_craft( {
        output = "homedecor:japanese_wall_middle",
        recipe = {
			{"homedecor:japanese_wall_top"}
        },
})

minetest.register_craft( {
        output = "homedecor:japanese_wall_bottom",
        recipe = {
			{"homedecor:japanese_wall_middle"}
        },
})

minetest.register_craft( {
        output = "homedecor:japanese_wall_top",
        recipe = {
			{"homedecor:japanese_wall_bottom"}
        },
})

minetest.register_craft( {
        output = "homedecor:tatami_mat",
        recipe = {
			{"farming:wheat", "farming:wheat", "farming:wheat"}
        },
})

minetest.register_craft( {
        output = "homedecor:wardrobe",
        recipe = {
			{ "homedecor:drawer_small", "homedecor:kitchen_cabinet" },
			{ "homedecor:drawer_small", "default:wood" },
			{ "homedecor:drawer_small", "default:wood" }
        },
})

minetest.register_craft( {
        output = "homedecor:pool_table",
        recipe = {
			{ "wool:dark_green", "wool:dark_green", "wool:dark_green" },
			{ "building_blocks:hardwood", "building_blocks:hardwood", "building_blocks:hardwood" },
			{ "building_blocks:slab_hardwood", "", "building_blocks:slab_hardwood" }
        },
})

minetest.register_craft( {
        output = "homedecor:trash_can 3",
        recipe = {
			{ "basic_materials:steel_wire", "", "basic_materials:steel_wire" },
			{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
        },
})

minetest.register_craft( {
        output = "homedecor:telephone",
        recipe = {
			{ "homedecor:speaker_driver", "basic_materials:copper_wire", "homedecor:speaker_driver" },
			{ "basic_materials:plastic_sheet", "default:steel_ingot", "basic_materials:plastic_sheet" },
			{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
        },
})

minetest.register_craft( {
        output = "homedecor:cobweb_corner 5",
        recipe = {
			{ "farming:string", "", "farming:string" },
			{ "", "farming:string", "" },
			{ "farming:string", "", "farming:string" }
        },
})

minetest.register_craft( {
        output = "homedecor:well",
        recipe = {
			{ "homedecor:shingles_wood", "homedecor:shingles_wood", "homedecor:shingles_wood" },
			{ "group:wood", "group:stick", "group:wood" },
			{ "group:stone", "", "group:stone" }
        },
})

minetest.register_craft( {
        output = "homedecor:coat_tree",
        recipe = {
			{ "group:stick", "group:stick", "group:stick" },
			{ "", "group:stick", "" },
			{ "", "group:wood", "" }
        },
})

minetest.register_craft( {
        output = "homedecor:coatrack_wallmount",
        recipe = {
			{ "group:stick", "homedecor:curtainrod_wood", "group:stick" },
        },
})

minetest.register_craft( {
        output = "homedecor:doorbell",
        recipe = {
			{ "homedecor:light_switch", "basic_materials:energy_crystal_simple", "homedecor:speaker_driver" }
        },
})


minetest.register_craft( {
        output = "homedecor:bench_large_1",
        recipe = {
			{ "group:wood", "group:wood", "group:wood" },
			{ "group:wood", "group:wood", "group:wood" },
			{ "homedecor:pole_wrought_iron", "", "homedecor:pole_wrought_iron" }
        },
})

minetest.register_craft( {
        output = "homedecor:bench_large_2_left",
        recipe = {
			{ "homedecor:shutter_oak", "homedecor:shutter_oak", "homedecor:shutter_oak" },
			{ "group:wood", "group:wood", "group:wood" },
			{ "stairs:slab_wood", "", "stairs:slab_wood" }
        },
})

minetest.register_craft( {
        output = "homedecor:bench_large_2_left",
        recipe = {
			{ "homedecor:shutter_oak", "homedecor:shutter_oak", "homedecor:shutter_oak" },
			{ "group:wood", "group:wood", "group:wood" },
			{ "moreblocks:slab_wood", "", "moreblocks:slab_wood" }
        },
})

minetest.register_craft( {
        output = "homedecor:kitchen_faucet",
        recipe = {
			{ "", "default:steel_ingot" },
			{ "default:steel_ingot", "" },
			{ "homedecor:taps", "" }
        },
})

minetest.register_craft( {
        output = "homedecor:cutlery_set",
        recipe = {
			{ "", "vessels:drinking_glass", "" },
			{ "basic_materials:steel_strip", "building_blocks:slab_marble", "basic_materials:steel_strip" },
        },
})

minetest.register_craft( {
        output = "homedecor:cutlery_set",
        recipe = {
			{ "", "vessels:drinking_glass", "" },
			{ "basic_materials:steel_strip", "building_blocks:micro_marble_1", "basic_materials:steel_strip" },
        },
})

minetest.register_craft( {
        output = "homedecor:simple_bench",
        recipe = {
			{ "stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood" },
			{ "stairs:slab_wood", "", "stairs:slab_wood" }
        },
})

minetest.register_craft( {
        output = "homedecor:simple_bench",
        recipe = {
			{ "moreblocks:slab_wood", "moreblocks:slab_wood", "moreblocks:slab_wood" },
			{ "moreblocks:slab_wood", "", "moreblocks:slab_wood" }
        },
})

minetest.register_craft( {
	output = "homedecor:bed_regular",
	recipe = {
		{ "group:stick", "", "group:stick" },
		{ "wool:white", "wool:white", "wool:white" },
		{ "group:wood", "", "group:wood" },
	},
})

unifieddyes.register_color_craft({
	output = "homedecor:bed_regular",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "homedecor:bed_regular",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft( {
	output = "homedecor:bed_kingsize",
	recipe = {
		{ "homedecor:bed_regular", "homedecor:bed_regular" }
	},
})

unifieddyes.register_color_craft({
	output = "homedecor:bed_kingsize",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "homedecor:bed_kingsize",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

unifieddyes.register_color_craft({
	output = "homedecor:bed_kingsize",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "homedecor:bed_regular",
	recipe = {
		"NEUTRAL_NODE",
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft( {
        output = "homedecor:bottle_green",
        recipe = {
			{ "vessels:glass_bottle", "dye:green" }
        },
})

minetest.register_craft( {
        output = "homedecor:bottle_brown",
        recipe = {
			{ "vessels:glass_bottle", "dye:brown" }
        },
})

minetest.register_craft({
	output = "homedecor:coffee_maker",
	recipe = {
	    {"basic_materials:plastic_sheet", "bucket:bucket_water", "basic_materials:plastic_sheet"},
	    {"basic_materials:plastic_sheet", "default:glass", "basic_materials:plastic_sheet"},
	    {"basic_materials:plastic_sheet", "basic_materials:heating_element", "basic_materials:plastic_sheet"}
	},
})

minetest.register_craft({
	output = "homedecor:dartboard",
	recipe = {
	    {"dye:black", "basic_materials:plastic_sheet", "dye:white"},
	    {"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet"},
	    {"dye:dark_green", "basic_materials:plastic_sheet", "dye:red"}
	},
})

minetest.register_craft({
	output = "homedecor:piano",
	recipe = {
		{ "", "basic_materials:steel_wire", "building_blocks:hardwood" },
		{ "basic_materials:plastic_strip", "basic_materials:steel_wire", "building_blocks:hardwood" },
		{ "basic_materials:brass_ingot", "default:steelblock", "building_blocks:hardwood" }
	},
})

minetest.register_craft({
	output = "homedecor:toaster",
	recipe = {
		{ "default:steel_ingot", "basic_materials:heating_element", "default:steel_ingot" },
		{ "default:steel_ingot", "basic_materials:heating_element", "default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "homedecor:deckchair",
	recipe = {
		{ "group:stick", "building_blocks:terrycloth_towel", "group:stick" },
		{ "group:stick", "building_blocks:terrycloth_towel", "group:stick" },
		{ "group:stick", "building_blocks:terrycloth_towel", "group:stick" }
	},
})

minetest.register_craft({
	output = "homedecor:deckchair_striped_blue",
	type = "shapeless",
	recipe = {
		"homedecor:deckchair",
		"dye:blue"
	}
})

minetest.register_craft({
	output = "homedecor:office_chair_basic",
	recipe = {
		{ "", "", "wool:black" },
		{ "", "wool:black", "default:steel_ingot" },
		{ "group:stick", "homedecor:pole_wrought_iron", "group:stick" }
	},
})

minetest.register_craft({
	output = "homedecor:office_chair_upscale",
	recipe = {
		{ "dye:black", "building_blocks:sticks", "group:wool" },
		{ "basic_materials:plastic_sheet", "group:wool", "default:steel_ingot" },
		{ "building_blocks:sticks", "homedecor:pole_wrought_iron", "building_blocks:sticks" }
	},
})

minetest.register_craft({
	output = "homedecor:wall_shelf 2",
	recipe = {
		{ "homedecor:wood_table_small_square", "homedecor:curtainrod_wood", "homedecor:curtainrod_wood" },
	},
})

minetest.register_craft({
	output = "homedecor:trophy 3",
	recipe = {
		{ "default:gold_ingot","","default:gold_ingot" },
		{ "","default:gold_ingot","" },
		{ "group:wood","default:gold_ingot","group:wood" }
	},
})

minetest.register_craft({
	output = "homedecor:grandfather_clock",
	recipe = {
		{ "building_blocks:slab_hardwood","homedecor:analog_clock_wood","building_blocks:slab_hardwood" },
		{ "building_blocks:slab_hardwood","basic_materials:brass_ingot","building_blocks:slab_hardwood" },
		{ "building_blocks:slab_hardwood","basic_materials:brass_ingot","building_blocks:slab_hardwood" }
	},
})

minetest.register_craft({
	output = "homedecor:sportbench",
	recipe = {
		{ "stairs:slab_steelblock","homedecor:pole_wrought_iron","stairs:slab_steelblock" },
		{ "default:steel_ingot","wool:black","default:steel_ingot" },
		{ "default:steel_ingot","wool:black","default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "homedecor:skateboard",
	recipe = {
		{ "dye:yellow","dye:green","dye:blue" },
		{ "homedecor:wood_table_small_square","homedecor:wood_table_small_square","homedecor:wood_table_small_square" },
		{ "default:steel_ingot","","default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "homedecor:copper_pans",
	recipe = {
		{ "basic_materials:copper_strip","","basic_materials:copper_strip" },
		{ "default:copper_ingot","","default:copper_ingot" },
		{ "default:copper_ingot","","default:copper_ingot" }
	},
})

minetest.register_craft( {
        output = "homedecor:window_flowerbox",
        recipe = {
                { "homedecor:roof_tile_terracotta", "default:dirt", "homedecor:roof_tile_terracotta" },
                { "", "homedecor:roof_tile_terracotta", "" },
        },
})

minetest.register_craft({
    output = "homedecor:paper_towel",
    recipe = {
		{ "homedecor:toilet_paper", "homedecor:toilet_paper" }
    },
})

minetest.register_craft({
	output = "homedecor:stonepath 16",
	recipe = {
		{ "stairs:slab_stone","","stairs:slab_stone" },
		{ "","stairs:slab_stone","" },
		{ "stairs:slab_stone","","stairs:slab_stone" }
	},
})

minetest.register_craft({
	output = "homedecor:stonepath 16",
	recipe = {
		{ "moreblocks:slab_stone","","moreblocks:slab_stone" },
		{ "","moreblocks:slab_stone","" },
		{ "moreblocks:slab_stone","","moreblocks:slab_stone" }
	},
})

minetest.register_craft({
	output = "homedecor:stonepath 3",
	recipe = {
		{ "moreblocks:micro_stone_1","","moreblocks:micro_stone_1" },
		{ "","moreblocks:micro_stone_1","" },
		{ "moreblocks:micro_stone_1","","moreblocks:micro_stone_1" }
	},
})

minetest.register_craft({
	output = "homedecor:barbecue",
	recipe = {
		{ "","homedecor:fence_chainlink","" },
		{ "default:steel_ingot","fake_fire:embers","default:steel_ingot" },
		{ "homedecor:pole_wrought_iron","default:steel_ingot","homedecor:pole_wrought_iron" }
	},
})

minetest.register_craft({
	output = "homedecor:beer_tap",
	recipe = {
		{ "group:stick","default:steel_ingot","group:stick" },
		{ "homedecor:kitchen_faucet","default:steel_ingot","homedecor:kitchen_faucet" },
		{ "default:steel_ingot","default:steel_ingot","default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "homedecor:swing",
	recipe = {
		{ "farming:string","","farming:string" },
		{ "farming:string","","farming:string" },
		{ "farming:string","stairs:slab_wood","farming:string" }
	},
})

minetest.register_craft({
	output = "homedecor:swing",
	recipe = {
		{ "farming:string","","farming:string" },
		{ "farming:string","","farming:string" },
		{ "farming:string","moreblocks:slab_wood","farming:string" }
	},
})

minetest.register_craft({
	output = "homedecor:swing",
	recipe = {
		{ "farming:string","","farming:string" },
		{ "farming:string","","farming:string" },
		{ "farming:string","moreblocks:panel_wood_1","farming:string" }
	},
})

local bookcolors = {
	"red",
	"green",
	"blue",
	"violet",
	"grey",
	"brown"
}

for _, color in ipairs(bookcolors) do
	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:book_"..color,
		recipe = {
			"dye:"..color,
			"default:book"
		},
	})
end

minetest.register_craft({
	output = "homedecor:door_japanese_closed",
	recipe = {
		{ "homedecor:japanese_wall_top" },
		{ "homedecor:japanese_wall_bottom" }
	},
})

minetest.register_craft({
	output = "homedecor:calendar",
	recipe = {
		{ "","dye:red","" },
		{ "","dye:black","" },
		{ "","default:paper","" }
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "homedecor:4_bottles_brown",
	recipe = {
		"homedecor:bottle_brown",
		"homedecor:bottle_brown",
		"homedecor:bottle_brown",
		"homedecor:bottle_brown"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "homedecor:4_bottles_green",
	recipe = {
		"homedecor:bottle_green",
		"homedecor:bottle_green",
		"homedecor:bottle_green",
		"homedecor:bottle_green"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "homedecor:4_bottles_multi",
	recipe = {
		"homedecor:bottle_brown",
		"homedecor:bottle_brown",
		"homedecor:bottle_green",
		"homedecor:bottle_green",
	},
})

minetest.register_craft({
	output = "homedecor:wine_rack",
	recipe = {
		{ "homedecor:4_bottles_brown", "group:wood", "homedecor:4_bottles_brown" },
		{ "homedecor:4_bottles_brown", "group:wood", "homedecor:4_bottles_brown" },
		{ "homedecor:4_bottles_brown", "group:wood", "homedecor:4_bottles_brown" },
	},
})

local picture_dyes = {
	{"dye:brown", "dye:green"}, -- the figure sitting by the tree, wielding a pick
	{"dye:green", "dye:blue"}	-- the "family photo"
}

for i in ipairs(picture_dyes) do
	minetest.register_craft({
		output = "homedecor:picture_frame"..i,
		recipe = {
			{ picture_dyes[i][1], picture_dyes[i][2] },
			{ "homedecor:blank_canvas", "group:stick" },
		},
	})
end

minetest.register_craft({
	output = "homedecor:desk_lamp 2",
	recipe = {
		{ "", "default:steel_ingot", "homedecor:glowlight_small_cube" },
		{ "", "basic_materials:steel_strip", "" },
		{ "basic_materials:plastic_sheet", "basic_materials:copper_wire", "basic_materials:plastic_sheet" },
	},
})

unifieddyes.register_color_craft({
	output = "homedecor:desk_lamp",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "homedecor:desk_lamp",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft({
	output = "homedecor:hanging_lantern 2",
	recipe = {
		{ "default:iron_lump", "default:iron_lump", "" },
		{ "default:iron_lump", "homedecor:lattice_lantern_large", "" },
		{ "default:iron_lump", "", "" },
	},
})

minetest.register_craft({
	output = "homedecor:ceiling_lantern 2",
	recipe = {
		{ "default:iron_lump", "default:iron_lump", "default:iron_lump" },
		{ "default:iron_lump", "homedecor:lattice_lantern_large", "default:iron_lump" },
		{ "", "default:iron_lump", "" },
	},
})

minetest.register_craft({
	output = "homedecor:wall_lamp 2",
	recipe = {
		{ "", "homedecor:lattice_lantern_large", "" },
		{ "default:iron_lump", "group:stick", "" },
		{ "default:iron_lump", "group:stick", "" },
	},
})

minetest.register_craft({
	output = "homedecor:desk_globe",
	recipe = {
		{ "group:stick", "basic_materials:plastic_sheet", "dye:green" },
		{ "group:stick", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "group:stick", "stairs:slab_wood", "dye:blue" }
	},
})

minetest.register_craft({
	output = "homedecor:desk_globe",
	recipe = {
		{ "group:stick", "basic_materials:plastic_sheet", "dye:green" },
		{ "group:stick", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "group:stick", "moreblocks:slab_wood", "dye:blue" }
	},
})

minetest.register_craft({
	output = "homedecor:tool_cabinet",
	recipe = {
		{ "basic_materials:motor", "default:axe_steel", "default:pick_steel" },
		{ "default:steel_ingot", "homedecor:drawer_small", "default:steel_ingot" },
		{ "default:steel_ingot", "homedecor:drawer_small", "default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "homedecor:bathroom_set",
	recipe = {
		{ "", "homedecor:glass_table_small_round", "" },
		{ "basic_materials:plastic_sheet", "homedecor:glass_table_small_round", "basic_materials:plastic_sheet" },
		{ "group:stick", "basic_materials:plastic_sheet", "group:stick" }
	},
})

minetest.register_craft({
	output = "homedecor:trash_can_green",
	recipe = {
		{ "basic_materials:plastic_sheet", "", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "dye:green", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
	},
})

minetest.register_craft({
	output = "homedecor:ceiling_lamp",
	recipe = {
		{ "", "basic_materials:brass_ingot", ""},
		{ "", "basic_materials:chainlink_brass", ""},
		{ "default:glass", "homedecor:glowlight_small_cube", "default:glass"}
	},
})

minetest.register_craft({
	output = "homedecor:ceiling_lamp",
	recipe = {
		{ "", "basic_materials:chain_steel_top_brass", ""},
		{ "default:glass", "homedecor:glowlight_small_cube", "default:glass"}
	},
})

minetest.register_craft({
	output = "homedecor:spiral_staircase",
	recipe = {
		{ "default:steelblock", "homedecor:pole_wrought_iron", "" },
		{ "", "homedecor:pole_wrought_iron", "default:steelblock" },
		{ "default:steelblock", "homedecor:pole_wrought_iron", "" }
	},
})

minetest.register_craft({
	output = "homedecor:soda_machine",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "dye:red", "default:steel_ingot"},
		{"default:steel_ingot", "default:copperblock", "default:steel_ingot"},
	},
})

if minetest.settings:get_bool("homedecor.disable_coin_crafting") == false then
	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:coin 5",
		recipe = {"moreblocks:micro_goldblock_1", "default:sword_stone"}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:coin 15",
		recipe = {"default:gold_ingot", "default:sword_steel"}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:coin 50",
		recipe = {"default:goldblock", "default:sword_mese"}
	})
else
	if minetest.settings:get("log_mods") then
		minetest.log("[HomeDecor] " .. S("coin crafting is disabled!"))
	end
end

minetest.register_craft({
	output = "homedecor:lattice_wood 8",
	recipe = {
		{"group:stick", "group:wood", "group:stick"},
		{"group:wood", "", "group:wood"},
		{"group:stick", "group:wood", "group:stick"},
	},
})

minetest.register_craft({
	output = "homedecor:lattice_white_wood 8",
	recipe = {
		{"group:stick", "group:wood", "group:stick"},
		{"group:wood", "dye:white", "group:wood"},
		{"group:stick", "group:wood", "group:stick"},
	},
})

minetest.register_craft({
	output = "homedecor:lattice_wood_vegetal 8",
	recipe = {
		{"group:stick", "group:wood", "group:stick"},
		{"group:wood", "group:leaves", "group:wood"},
		{"group:stick", "group:wood", "group:stick"},
	},
})

minetest.register_craft({
	output = "homedecor:lattice_white_wood_vegetal 8",
	recipe = {
		{"group:stick", "group:wood", "group:stick"},
		{"group:wood", "group:leaves", "group:wood"},
		{"group:stick", "dye:white", "group:stick"},
	},
})

minetest.register_craft({
	output = "homedecor:stained_glass 8",
	recipe = {
		{"", "dye:blue", ""},
		{"dye:red", "default:glass", "dye:green"},
		{"", "dye:yellow", ""},
	},
})

minetest.register_craft({
	output = "homedecor:stained_glass 3",
	recipe = {
		{"", "dye:blue", ""},
		{"dye:red", "xpanes:pane_flat", "dye:green"},
		{"", "dye:yellow", ""},
	},
})

minetest.register_craft({
	output = "homedecor:stained_glass 2",
	recipe = {
		{"", "dye:blue", ""},
		{"dye:red", "cottages:glass_pane_side", "dye:green"},
		{"", "dye:yellow", ""},
	},
})

minetest.register_craft({
	output = "homedecor:stained_glass 2",
	recipe = {
		{"", "dye:blue", ""},
		{"dye:red", "cottages:glass_pane", "dye:green"},
		{"", "dye:yellow", ""},
	},
})

minetest.register_craftitem("homedecor:flower_pot_small", {
	description = S("Small Flower Pot"),
	inventory_image = "homedecor_flowerpot_small_inv.png"
})

minetest.register_craft( {
	output = "homedecor:flower_pot_small",
	recipe = {
	        { "default:clay_brick", "", "default:clay_brick" },
	        { "", "default:clay_brick", "" }
	}
})

minetest.register_craft( {
	output = "homedecor:flower_pot_small 3",
	recipe = { { "homedecor:flower_pot_terracotta" } }
})

minetest.register_craft({
	output = "homedecor:shrubbery_green 3",
	recipe = {
		{ "group:leaves", "group:leaves", "group:leaves" },
		{ "group:leaves", "group:leaves", "group:leaves" },
		{ "group:stick", "group:stick", "group:stick" }
	}
})

for _, color in ipairs(homedecor.shrub_colors) do

	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:shrubbery_large_"..color,
		recipe = {
			"homedecor:shrubbery_"..color
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:shrubbery_"..color,
		recipe = {
			"homedecor:shrubbery_large_"..color
		}
	})

	if color ~= "green" then
		minetest.register_craft({
			type = "shapeless",
			output = "homedecor:shrubbery_large_"..color,
			recipe = {
				"homedecor:shrubbery_large_green",
				"dye:"..color
			}
		})

		minetest.register_craft({
			type = "shapeless",
			output = "homedecor:shrubbery_"..color,
			recipe = {
				"homedecor:shrubbery_green",
				"dye:"..color
			}
		})

	end
end

for i in ipairs(homedecor.banister_materials) do

	local name    = homedecor.banister_materials[i][1]
	local topmat  = homedecor.banister_materials[i][5]
	local vertmat = homedecor.banister_materials[i][6]
	local dye1    = homedecor.banister_materials[i][7]
	local dye2    = homedecor.banister_materials[i][8]

	minetest.register_craft({
		output = "homedecor:banister_"..name.."_horizontal 2",
		recipe = {
			{ topmat,  "",      dye1   },
			{ vertmat, topmat,  ""     },
			{ dye2,    vertmat, topmat }
		},
	})
end

unifieddyes.register_color_craft({
	output = "",
	palette = "split",
	neutral_node = "homedecor:banister_wood_horizontal",
	type = "shapeless",
	output_prefix = "homedecor:banister_wood_horizontal_",
	output_suffix = "",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE",
	}
})

if (minetest.get_modpath("technic") and minetest.get_modpath("dye") and minetest.get_modpath("bees")) then
	technic.register_separating_recipe({ input = {"bees:wax 1"}, output = {"basic_materials:oil_extract 2","dye:yellow 1"} })
end
