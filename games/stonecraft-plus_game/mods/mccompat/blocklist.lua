
--local SHADE_GRASS = "77AB2F:64";
local SHADE_GRASS   = "66CC11:128"; --96";
local SHADE_FOILAGE = SHADE_GRASS;

local TEXTURE_GRASS      = "grass_top.png^[colorize:#"..SHADE_GRASS;
-- for the grass side,  grass_side_overlay.png plus colorization might be used
local TEXTURE_GRASS_SIDE = "grass_side.png";
local TEXTURE_FOILAGE = "^[colorize:#"..SHADE_FOILAGE;
local TEXTURE_LEAVES  = TEXTURE_FOILAGE;

-- unused textures which would need colorization:
--grass_side_overlay.png
--double_plant_top.png
--double_plant_bottom.png
--melon_stem_disconnected.png
--pumpkin_stem_disconnected.png


-- a normal block; nothing special
local NORMAL = 0;
-- #blockdata selects one of the listed subtypes
local SELECT = 1;
-- it is a plant
local PLANT  = 2;
-- a stair; ALWAYS include facedir; 0: east; 1: west; 2: south; 3: north
local STAIR  = 3;
-- a slab; facedir is not relevant
local SLAB   = 4;
-- gates
local GATE   = 5;
-- doors are..complicated
local DOOR   = 6;
-- a trapdoor
local TRAPDOOR = 7;
-- glass panes, iron bars etc.
local GPANE    = 8;
-- pressure plates, snow, carpets, ..
local CARPET   = 9;
-- facedir needs to be translated
local FACEDIR= 10;
-- beds are special..
local BED    = 11;
-- implace facedir; 0x8 indicates if the button is active (irrelevant for us)
--local BUTTON = 12;
local WALL   = 13;


-- basic node definitions for the diffrent types
local mccompat_typ_normal = {
	is_ground_content = false,
	groups = {cracky=3,oddly_breakable_by_hand=1},
}

local mccompat_typ_facedir = {
	paramtype2 = "facedir",
	groups = {cracky=2,oddly_breakable_by_hand=1},
--	legacy_facedir_simple = true,
	is_ground_content = false,
}


local mccompat_typ_plant = {
	is_ground_content = false,
	drawtype = "plantlike",
--	waving = 1,
	visual_scale = 1.0,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy=3},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        }};

local mccompat_typ_leaves = {	
	description = "Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	paramtype = "light",
	groups = {snappy=3, leaves=1},
	sounds = default.node_sound_leaves_defaults(),
}

local mccompat_typ_glass = {
	drawtype = "glasslike_framed_optional",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	use_texture_alpha = true,
	is_ground_content = false,
}

local mccompat_typ_fence = {
	description = "Fence",
	drawtype = "fencelike",
--	tiles = {"default_wood.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults()
}

local mccompat_typ_carpet = {
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5,  0.5, -0.5+2/16, 0.5},
		},
	},
	groups = {choppy=2,oddly_breakable_by_hand=2},
}


local mccompat_typ_torch = {
        paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
                	{-1/16, -0.5, -1/16, 1/16, 1/16, 1/16},
		},
	},
        sunlight_propagates = true,
        walkable = false,
        light_source = 13,
        groups = {choppy=2, dig_immediate=3, not_in_creative_inventory=1, torch=1},
	is_ground_content = false,
}

-- fire
local mccompat_typ_fire = {
	drawtype = "firelike",
	tiles = {{
			name="fire_layer_0.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1},
		}},
	inventory_image = "fire_basic_flame.png",
	light_source = 14,
	groups = {igniter=2,dig_immediate=3},
	drop = '',
	walkable = false,
	buildable_to = true,
}

local mccompat_typ_button = {
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	node_box = {
		type = "fixed",
			fixed = {
				{ -3/16,-2/16,0.5-2/16, 3/16,2/16,0.5 },
			},
		},
	is_ground_content = false,
}

-- there's only one anvil, but it's better to have more complex node definitions in one place
local mccompat_typ_anvil = {
    	description = "Anvil",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = { -6/16, -8/16, -8/16, 6/16,  8/16, 8/16 },
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -6/16, -8/16, -6/16, 6/16, -4/16, 6/16 },
			{ -5/16, -4/16, -4/16, 5/16, -3/16, 4/16 },
			{ -4/16, -3/16, -2/16, 4/16,  2/16, 2/16 },
			{ -6/16,  2/16, -8/16, 6/16,  8/16, 8/16 },
		}
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3},
}

-- the ladder has its own definition as well
local mccompat_typ_ladder = {
	description = "Ladder",
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {choppy=2,oddly_breakable_by_hand=3,flammable=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_wood_defaults(),
}

local mccompat_typ_sign_wall = {
	description = "Sign wall",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -8/16, -8/16,   3/16, 8/16, 8/16, 8/16  },
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -4/16,   15/32, 8/16, 4/16,  6/16 },
		}
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3},
}

local mccompat_typ_sign_standing = {
	description = "Sign",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -8/16, -8/16, -4/16, 8/16, 18/32, 4/16 },
	},
	node_box = {
		type = "fixed",
		fixed = {
			-- sign
			{ -8/16, -3/32, -1/16, 8/16, 18/32, 1/16 },
			-- post
			{ -1/32, -8/16, -1/32, 1/32, -3/32, 1/32 },
		}
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3},
}

-- mc uses a different system here...but that of mt is nicer
-- (mc has no t-crossings or crossing, but instead sloped curves)
local mccompat_typ_rail = {
	drawtype = "raillike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy=2,dig_immediate=2,attached_node=1,connect_to_raillike=minetest.raillike_group("rail")}
}


-- texture order: top, bottom, sides
local blocks_and_textures = {
--	  [0] = {NORMAL, "air",				""},
	-- IMPORTANT: for reasons unkown, using [1] in this case does *not* work
--[[
	  [1] = {SELECT,{
		[0] = {"mccompat:stone",		"stone.png"},
		[1] = {"mccompat:granite",		"stone_granite.png"},
		[2] = {"mccompat:polished_granite",	"stone_granite_smooth.png"},
		[3] = {"mccompat:diorite",		"stone_diorite.png"},
		[4] = {"mccompat:polished_diorite",	"stone_diorite_smooth.png"},
		[5] = {"mccompat:andesite",		"stone_andesite.png"},
		[6] = {"mccompat:polished_andesite",	"stone_andesite_smooth.png"},
		}},
--]]
	  [2] = {NORMAL, "mccompat:grass",		{TEXTURE_GRASS,"dirt.png",TEXTURE_GRASS_SIDE}},
	  [3] = {SELECT,{
		[0] = {"mccompat:dirt",			"dirt.png"},
		[1] = {"mccompat:coarse_dirt",		"coarse_dirt.png"},
		[2] = {"mccompat:podzol",		{"dirt_podzol_top.png","dirt.png", "dirt_podzol_side.png"}},
		}},
	  [4] = {NORMAL,"mccompat:cobblestone",	"cobblestone.png"},
	  [5] = {SELECT,{
		[0] = {"mccompat:planks_oak",		"planks_oak.png"},
		[1] = {"mccompat:planks_spruce",	"planks_spruce.png"},
		[2] = {"mccompat:planks_birch",		"planks_birch.png"},
		[3] = {"mccompat:planks_jungle",	"planks_jungle.png"},
		[4] = {"mccompat:planks_acacia",	"planks_acacia.png"},
		[5] = {"mccompat:planks_big_oak",	"planks_big_oak.png"},
		}},
	  [6] = {PLANT, {
		[0] = {"mccompat:sapling_oak",		"sapling_oak.png"},
		[1] = {"mccompat:sapling_spruce",	"sapling_spruce.png"},
		[2] = {"mccompat:sapling_birch",	"sapling_birch.png"},
		[3] = {"mccompat:sapling_jungle",	"sapling_jungle.png"},
		[4] = {"mccompat:sapling_acacia",	"sapling_acacia.png"},
		[5] = {"mccompat:sapling_roofed_oak",	"sapling_roofed_oak.png"},
		[128] = {"mccompat:sapling_oak",	"sapling_oak.png"},
		[129] = {"mccompat:sapling_spruce",	"sapling_spruce.png"},
		[130] = {"mccompat:sapling_birch",	"sapling_birch.png"},
		[131] = {"mccompat:sapling_jungle",	"sapling_jungle.png"},
		[132] = {"mccompat:sapling_acacia",	"sapling_acacia.png"},
		[133] = {"mccompat:sapling_roofed_oak","sapling_roofed_oak.png"},
		-- bit 0x8: set if ready to grow into a tree - irrelevant for us
		}},
	  [7] = {NORMAL, "mccompat:bedrock",		"bedrock.png"},
	  [8] = {NORMAL, "mccompat:water_flowing",	"water_flow.png"},
	  [9] = {NORMAL, "mccompat:water_source",	"water_still.png"},
	 [10] = {NORMAL, "mccompat:lava_flowing",	"lava_flow.png"},
 	 [11] = {NORMAL, "mccompat:lava_source",	"lava_still.png"},
	 [12] = {SELECT,{
		[0] = {"mccompat:sand",			"sand.png"},
		[1] = {"mccompat:red_sand",			"red_sand.png"},
		}},
	 [13] = {NORMAL, "mccompat:gravel",			"gravel.png"},
	 [14] = {NORMAL, "mccompat:gold_ore",			"gold_ore.png"},
	 [15] = {NORMAL, "mccompat:iron_ore",			"iron_ore.png"},
	 [16] = {NORMAL, "mccompat:coal_ore",			"coal_ore.png"},
	 [17] = {SELECT,{
		[0] = {"mccompat:log_oak",		{"log_oak_top.png","log_oak_top.png","log_oak.png"}},
		[1] = {"mccompat:log_spruce",		{"log_spruce_top.png","log_spruce_top.png","log_spruce.png"}},
		[2] = {"mccompat:log_birch",		{"log_birch_top.png","log_birch_top.png","log_birch.png"}},
		[3] = {"mccompat:log_jungle",		{"log_jungle_top.png","log_jungle_top.png","log_jungle.png"}},

		-- only bark; needs special handling!
		[8] = {"mccompat:log_oak",		{"log_oak.png"}},
		[9] = {"mccompat:log_spruce",		{"log_spruce.png"}},
		[10] = {"mccompat:log_birch",		{"log_birch.png"}},
		[11] = {"mccompat:log_jungle",		{"log_jungle.png"}},
		},
		mccompat_typ_facedir},

	
	 [18] = {SELECT,{
		 [0] = {"mccompat:leaves_oak",		"leaves_oak.png"..TEXTURE_LEAVES},
		 [1] = {"mccompat:leaves_spruce",	"leaves_spruce.png"..TEXTURE_LEAVES},
		 [2] = {"mccompat:leaves_birch",	"leaves_birch.png"..TEXTURE_LEAVES},
		 [3] = {"mccompat:leaves_jungle",	"leaves_jungle.png"..TEXTURE_LEAVES},
		 [4] = {"mccompat:leaves_oak",		"leaves_oak.png"..TEXTURE_LEAVES},
		 [5] = {"mccompat:leaves_spruce",	"leaves_spruce.png"..TEXTURE_LEAVES},
		 [6] = {"mccompat:leaves_birch",	"leaves_birch.png"..TEXTURE_LEAVES},
		 [7] = {"mccompat:leaves_jungle",	"leaves_jungle.png"..TEXTURE_LEAVES},
		 [8] = {"mccompat:leaves_oak",		"leaves_oak.png"..TEXTURE_LEAVES},
		 [9] = {"mccompat:leaves_spruce",	"leaves_spruce.png"..TEXTURE_LEAVES},
		[10] = {"mccompat:leaves_birch",	"leaves_birch.png"..TEXTURE_LEAVES},
		[11] = {"mccompat:leaves_jungle",	"leaves_jungle.png"..TEXTURE_LEAVES},
		[12] = {"mccompat:leaves_oak",		"leaves_oak.png"..TEXTURE_LEAVES},
		[13] = {"mccompat:leaves_spruce",	"leaves_spruce.png"..TEXTURE_LEAVES},
		[14] = {"mccompat:leaves_birch",	"leaves_birch.png"..TEXTURE_LEAVES},
		[15] = {"mccompat:leaves_jungle",	"leaves_jungle.png"..TEXTURE_LEAVES},
		-- there are duplicates due to decay/check decay, which is not relevant here
		},
		mccompat_typ_leaves },
	 [19] = {SELECT,{
		[0] = {"mccompat:sponge",		"sponge.png"},
		[1] = {"mccompat:sponge_wet",		"sponge_wet.png"},
		}},
	 [20] = {NORMAL, "mccompat:glass",		"glass.png",
		mccompat_typ_glass},
	 [21] = {NORMAL, "mccompat:lapis_ore",		"lapis_ore.png"},
	 [22] = {NORMAL, "mccompat:lapis_block",	"lapis_block.png"},
	 [23] = {FACEDIR,"mccompat:dispenser",		{"dispenser_front_vertical.png","dispenser_front_vertical.png","dispenser_front_horizontal.png"}},
	 [24] = {SELECT,{
		[0] = {"mccompat:sandstone_normal",	{"sandstone_top.png","sandstone_bottom.png","sandstone_normal.png"}},
		[1] = {"mccompat:sandstone_carved",	{"sandstone_top.png","sandstone_bottom.png","sandstone_carved.png"}},
		[2] = {"mccompat:sandstone_smooth",	{"sandstone_top.png","sandstone_bottom.png","sandstone_smooth.png"}},
		}},
	 [25] = {NORMAL, "mccompat:noteblock",		"noteblock.png"},
	 [26] = {BED,{
		[0] = {"mccompat:bed_feet",		{"bed_feet_top.png","planks_oak.png","bed_feet_side.png","bed_feet_end.png","bed_feet_side.png","bed_feet_end.png"}},
		[128] = {"mccompat:bed_head",		{"bed_head_top.png","planks_oak.png","bed_head_side.png","bed_head_end.png","bed_head_side.png","bed_head_end.png"}},
		}},
	 [27] = {RAIL,  "mccompat:golden_rail",		"rail_golden.png",
		mccompat_typ_rail},
	 [28] = {RAIL,  "mccompat:detector_rail",	"rail_detector.png",
		mccompat_typ_rail},
	 [29] = {FACEDIR,"mccompat:sticky_piston",	{"piston_top_sticky.png","piston_bottom.png","piston_side.png"}},
		-- TODO: 0x6, 0x7: 6-sided piston
		-- TODO: 0x8: when 1, piston is extended
	 [30] = {GPANE,  "web",				"web.png"},
	 [31] = {PLANT,{
		[0] = {"mccompat:shrub",		"deadbush.png"},
		[1] = {"mccompat:tallgrass",		"tallgrass.png"..TEXTURE_FOILAGE},
		[2] = {"mccompat:fern",     		"fern.png"..TEXTURE_FOILAGE},
		},
		{waving = 1}},
	 [32] = {PLANT,  "mccompat:deadbush",		"deadbush.png"},
	 [33] = {FACEDIR,"mccompat:piston",		{"piston_top_normal.png","piston_bottom.png","piston_side.png"}},
		-- TODO: special values same as for sticky piston
	 [34] = {CARPET, "mccompat:piston_head",	"piston_top_normal.png"},
		-- 0x8: 1: sticky head; 0: normal head
		-- TODO: this needs a nodebox
	 [35] = {SELECT,{
		 [0] = {"mccompat:wool_white",		"wool_colored_white.png"},
		 [1] = {"mccompat:wool_orange",		"wool_colored_orange.png"},
		 [2] = {"mccompat:wool_magenta",	"wool_colored_magenta.png"},
		 [3] = {"mccompat:wool_light_blue",	"wool_colored_light_blue.png"},
		 [4] = {"mccompat:wool_yellow",		"wool_colored_yellow.png"},
		 [5] = {"mccompat:wool_lime",		"wool_colored_lime.png"},
		 [6] = {"mccompat:wool_pink",		"wool_colored_pink.png"},
		 [7] = {"mccompat:wool_gray",		"wool_colored_gray.png"},
		 [8] = {"mccompat:wool_silver",		"wool_colored_silver.png"},
		 [9] = {"mccompat:wool_cyan",		"wool_colored_cyan.png"},
		[10] = {"mccompat:wool_purple",		"wool_colored_purple.png"},
		[11] = {"mccompat:wool_blue",		"wool_colored_blue.png"},
		[12] = {"mccompat:wool_brown",		"wool_colored_brown.png"},
		[13] = {"mccompat:wool_green",		"wool_colored_green.png"},
		[14] = {"mccompat:wool_red",		"wool_colored_red.png"},
		[15] = {"mccompat:wool_black",		"wool_colored_black.png"},
		}},
-- 	  36    block moved by piston extension
	 [37] = {PLANT, "mccompat:yellow_flower",	"flower_dandelion.png"},
	 [38] = {PLANT, {
		[0] = { "mccompat:flower_rose",	"flower_rose.png"},
		[1] = { "mccompat:flower_blue_orchid",	"flower_blue_orchid.png"},
		[2] = { "mccompat:flower_allium",	"flower_allium.png"},
		[3] = { "mccompat:flower_houstonia",	"flower_houstonia.png"},
		[4] = { "mccompat:flower_tulip_red",	"flower_tulip_red.png"},
		[5] = { "mccompat:flower_tulip_orange","flower_tulip_orange.png"},
		[6] = { "mccompat:flower_tulip_white",	"flower_tulip_white.png"},
		[7] = { "mccompat:flower_tulip_pink",	"flower_tulip_pink.png"},
		[8] = { "mccompat:flower_oxeye_daisy",	"flower_oxeye_daisy.png"},
		}},
	 [39] = {PLANT, "mccompat:brown_mushroom",	"mushroom_brown.png"},
	 [40] = {PLANT, "mccompat:red_mushroom",	"mushroom_red.png"},
	 [41] = {NORMAL, "mccompat:gold_block",	"gold_block.png"},
	 [42] = {NORMAL, "mccompat:iron_block",	"iron_block.png"},
	 [43] = {SELECT,{
		 [0] = {"mccompat:double_stone_slab",	{"stone_slab_top.png","stone_slab_top.png","stone_slab_side.png"}},
		 [1] = {"mccompat:sandstone_carved",	{"sandstone_top.png","sandstone_bottom.png","sandstone_carved.png"}},
		 [2] = {"mccompat:planks_oak",		"planks_oak.png"},
		 [3] = {"mccompat:cobblestone",	"cobblestone.png"},
	 	 [4] = {"mccompat:brick_block",	"brick.png"},
	 	 [5] = {"mccompat:stonebrick",		"stonebrick.png"},
		 [6] = {"mccompat:nether_brick",	"nether_brick.png"},
		 [7] = {"mccompat:quartz_block",	{"quartz_block_top.png","quartz_block_top.png","quartz_block_side.png"}},
		 [8] = {"mccompat:double_stone_slab_smooth",	"stone_slab_top.png"},
		 [9] = {"mccompat:sandstone_smooth",	{"sandstone_top.png","sandstone_bottom.png","sandstone_smooth.png"}},
		}},
		-- many of these are duplicates of existing blocks
	 [44] = {SLAB,{
		 [0] = {"stone",			"stone_slab_side_TODO.png"},
		 [1] = {"sandstone_carved",		{"sandstone_top.png","sandstone_bottom.png","sandstone_carved.png"}},
		 [2] = {"planks_oak",			"planks_oak.png"},
		 [3] = {"cobblestone",			"cobblestone.png"},
	 	 [4] = {"brick_block",			"brick.png"},
	 	 [5] = {"stonebrick",			"stonebrick.png"},
		 [6] = {"nether_brick",			"nether_brick.png"},
		 [7] = {"quartz_block",			{"quartz_block_top.png","quartz_block_top.png","quartz_block_side.png"}},
		 [8] = {"stoneupside_down",		"stone_slab_side_TODO.png"},
		 [9] = {"sandstone_carvedupside_down",	{"sandstone_top.png","sandstone_bottom.png","sandstone_carved.png"}},
		[10] = {"planks_oakupside_down",	"planks_oak.png"},
		[11] = {"cobblestoneupside_down",	"cobblestone.png"},
	 	[12] = {"brick_blockupside_down",	"brick.png"},
	 	[13] = {"stonebrickupside_down",	"stonebrick.png"},
		[14] = {"nether_brickupside_down",	"nether_brick.png"},
		[15] = {"quartz_blockupside_down",	{"quartz_block_top.png","quartz_block_top.png","quartz_block_side.png"}},
		}},
	 [45] = {NORMAL, "mccompat:brick_block",	"brick.png"},
	 [46] = {FACEDIR,"mccompat:tnt",		{"tnt_top.png","tnt_bottom.png","tnt_side.png"}},
	 [47] = {NORMAL, "mccompat:bookshelf",		{"planks_oak.png","planks_oak.png","bookshelf.png"}},
	 [48] = {NORMAL, "mccompat:mossy_cobblestone",	"cobblestone_mossy.png"},
	 [49] = {NORMAL, "mccompat:obsidian",		"obsidian.png"},
	 [50] = {NORMAL, "mccompat:torch",		{"torch_on.png","torch_on.png","torch_on.png","torch_on.png"},
		mccompat_typ_torch},
	 [51] = {PLANT,  "mccompat:fire",		"fire_layer_0.png",
		mccompat_typ_fire},
	 [52] = {NORMAL, "mccompat:mob_spawner",	"mob_spawner.png",
		mccompat_typ_glass},
	 [53] = {STAIR, "planks_oak",			"planks_oak.png"},
	 [54] = {FACEDIR, "mccompat:chest",		{"default_chest_top.png","default_chest_top.png","default_chest_side.png","default_chest_side.png","default_chest_side.png","default_chest_front.png"}},
		-- TODO: the chest texture is stored elsewhere
		-- TODO: there do not seem to be curves or t-sections or anything
	 [55] = {NORMAL, "mccompat:redstone_wire",	{"redstone_dust_line.png^[transform1","redstone_dust_cross.png","redstone_dust_cross.png","redstone_dust_cross.png"},
		mccompat_typ_rail},
	 [56] = {NORMAL, "mccompat:diamond_ore",	"diamond_ore.png"},
	 [57] = {NORMAL, "mccompat:diamond_block",	"diamond_block.png"},
	 [58] = {FACEDIR,"mccompat:crafting_table",	{"crafting_table_top.png","crafting_table_top.png","crafting_table_side.png","crafting_table_side.png","crafting_table_side.png","crafting_table_front.png"}},
	 [59] = {PLANT,{
		[0] = {"mccompat:wheat_0",		"wheat_stage_0.png"},
		[1] = {"mccompat:wheat_1",		"wheat_stage_1.png"},
		[2] = {"mccompat:wheat_2",		"wheat_stage_2.png"},
		[3] = {"mccompat:wheat_3",		"wheat_stage_3.png"},
		[4] = {"mccompat:wheat_4",		"wheat_stage_4.png"},
		[5] = {"mccompat:wheat_5",		"wheat_stage_5.png"},
		[6] = {"mccompat:wheat_6",		"wheat_stage_6.png"},
		[7] = {"mccompat:wheat_7",		"wheat_stage_7.png"},
		},
		{waving = 1}},
	 [60] = {SELECT,{
		[0] = {"mccompat:farmland_dry",	{"farmland_dry.png","dirt.png"}},
		[1] = {"mccompat:farmland_dry",	{"farmland_dry.png","dirt.png"}},
		[2] = {"mccompat:farmland_dry",	{"farmland_dry.png","dirt.png"}},
		[3] = {"mccompat:farmland_dry",	{"farmland_dry.png","dirt.png"}},
		[4] = {"mccompat:farmland_dry",	{"farmland_dry.png","dirt.png"}},
		[5] = {"mccompat:farmland_dry",	{"farmland_dry.png","dirt.png"}},
		[6] = {"mccompat:farmland_dry",	{"farmland_dry.png","dirt.png"}},
		[7] = {"mccompat:farmland_wet",	{"farmland_wet.png","dirt.png"}},
		}},
	 [61] = {FACEDIR,"mccompat:furnace",		{"furnace_top.png","furnace_top.png","furnace_side.png","furnace_side.png","furnace_side.png","furnace_front_off.png"}},
	 [62] = {FACEDIR,"mccompat:lit_furnace",	{"furnace_top.png","furnace_top.png","furnace_side.png","furnace_side.png","furnace_side.png","furnace_front_on.png"},
		{
			light_source = 7
		}},
	-- TODO: needs 1.8.7.jar/assets/minecraft/textures/entity/sign.png
	 [63] = {FACEDIR,"mccompat:standing_sign",	"planks_oak.png",
		mccompat_typ_sign_standing},
		-- here, we take the normal sign
	 [64] = {DOOR,   "wooden_door",			"door_wood"},
	 [65] = {FACEDIR,"mccompat:ladder",		"ladder.png",
		mccompat_typ_ladder},
	 [66] = {RAIL,   "mccompat:rail",		"rail_normal.png",
		mccompat_typ_rail},
	 [67] = {STAIR,  "cobblestone",			"cobblestone.png"},
	-- TODO: needs 1.8.7.jar/assets/minecraft/textures/entity/sign.png
	 [68] = {FACEDIR,"mccompat:wall_sign",		"planks_oak.png", 
		mccompat_typ_sign_wall},
		-- again: normal sign wall
--	 [69] = {TODO, "mccompat:lever",			"lever.png"}, 
		-- no idea what that is good for
	 [70] = {CARPET, "mccompat:stone_pressure_plate", "stone.png"},
	 [71] = {DOOR,   "iron_door",			"door_iron"},
	 [72] = {CARPET, "mccompat:wooden_pressure_plate","planks_oak.png"},
	 [73] = {NORMAL, "mccompat:redstone_ore",	"redstone_ore.png"},
	 [74] = {NORMAL, "mccompat:lit_redstone_ore",	"redstone_ore.png",
		{
			light_source = 15
		}},
	 [75] = {NORMAL, "mccompat:unlit_redstone_torch",	"redstone_torch_off.png",
		mccompat_typ_torch},
	 [76] = {NORMAL, "mccompat:redstone_torch",		"redstone_torch_on.png",
		mccompat_typ_torch},
	 [77] = {NORMAL, "mccompat:stone_button",	"stone.png",
		mccompat_typ_button},
	 [78] = {CARPET, "mccompat:snow_layer",	"snow.png"},
		-- the snow is not really a pressure plate; it just has a similar shape
		-- TODO: use default:snow ?
	 [79] = {NORMAL, "mccompat:ice",		"ice.png"},
	 [80] = {NORMAL, "mccompat:snow",		"snow.png"},
	 [81] = {NORMAL, "mccompat:cactus",		{"cactus_top.png","cactus_bottom.png","cactus_side.png"}},
	 [82] = {NORMAL, "mccompat:clay",		"clay.png"},
	 [83] = {PLANT,  "mccompat:reeds",		"reeds.png"},
	 [84] = {FACEDIR,"mccompat:jukebox",		{"jukebox_top.png","jukebox_top.png","jukebox_side.png"}},
	 [85] = {NORMAL, "mccompat:fence",		"planks_oak.png",
		mccompat_typ_fence},
	 [86] = {FACEDIR, "mccompat:pumpkin",		{"pumpkin_top.png","pumpkin_top.png","pumpkin_face_off.png","pumpkin_side.png"}},
	 [87] = {NORMAL, "mccompat:netherrack",	"netherrack.png"},
	 [88] = {NORMAL, "mccompat:soul_sand",		"soul_sand.png"},
	 [89] = {NORMAL,  "mccompat:glowstone",	"glowstone.png",
		{
			light_source = 15
		}},
	 [90] = {"mccompat:portal",			"portal.png"},
	 [91] = {FACEDIR, "mccompat:lit_pumpkin",	{"pumpkin_top.png","pumpkin_top.png","pumpkin_face_on.png","pumpkin_side.png"},
		{
			light_source = 15
		}},
--	 [92] = {"mccompat:cake",			"cake_side_TODO.png"},
	 [93] = {FACEDIR, "mccompat:unpowered_repeater","repeater_off.png"},
	 [94] = {FACEDIR, "mccompat:powered_repeater",	"repeater_on.png"},
		-- TODO: both repeaters are nodeboxes
	 [95] = {SELECT,{
		 [0] = {"mccompat:stained_glass_white",	"glass_white.png"},
		 [1] = {"mccompat:stained_glass_orange",	"glass_orange.png"},
		 [2] = {"mccompat:stained_glass_magenta",	"glass_magenta.png"},
		 [3] = {"mccompat:stained_glass_light_blue",	"glass_light_blue.png"},
		 [4] = {"mccompat:stained_glass_yellow",	"glass_yellow.png"},
		 [5] = {"mccompat:stained_glass_lime",		"glass_lime.png"},
		 [6] = {"mccompat:stained_glass_pink",		"glass_pink.png"},
		 [7] = {"mccompat:stained_glass_gray",		"glass_gray.png"},
		 [8] = {"mccompat:stained_glass_silver",	"glass_silver.png"},
		 [9] = {"mccompat:stained_glass_cyan",		"glass_cyan.png"},
		[10] = {"mccompat:stained_glass_purple",	"glass_purple.png"},
		[11] = {"mccompat:stained_glass_blue",		"glass_blue.png"},
		[12] = {"mccompat:stained_glass_brown",	"glass_brown.png"},
		[13] = {"mccompat:stained_glass_green",	"glass_green.png"},
		[14] = {"mccompat:stained_glass_red",		"glass_red.png"},
		[15] = {"mccompat:stained_glass_black",	"glass_black.png"},
		},
		mccompat_typ_glass},
	 [96] = {TRAPDOOR, "wood",				"trapdoor.png"},
	 [97] = {SELECT,{
		[0] = {"mccompat:monster_egg_stone",		"stone.png"},
		[1] = {"mccompat:monster_egg_cobblestone",	"cobblestone.png"},
		[2] = {"mccompat:monster_egg_stonebrick",	"stonebrick.png"},
		[3] = {"mccompat:monster_egg_mossystonebrick", "stonebrick_mossy.png"},
		[4] = {"mccompat:monster_egg_stonebrickcracked","stonebrick_cracked.png"},
		[5] = {"mccompat:monster_egg_stonebrickcarved","stonebrick_carved.png"},
		}},
	 [98] = {SELECT,{
		[0] = {"mccompat:stonebrick",			"stonebrick.png"},
		[1] = {"mccompat:stonebrick_mossy",		"stonebrick_mossy.png"},
		[2] = {"mccompat:stonebrick_cracked",		"stonebrick_cracked.png"},
		[3] = {"mccompat:stonebrick_chiseled",		"stonebrick_carved.png"}
		}},
	 [99] = {SELECT, {
		[0] = {"mccompat:brown_mushroom_block_0",	"mushroom_block_inside.png"},
		[1] = {"mccompat:brown_mushroom_block_1",	{"mushroom_block_skin_brown.png","mushroom_block_inside.png","mushroom_block_skin_brown.png","mushroom_block_inside.png","mushroom_block_skin_brown.png","mushroom_block_inside.png"}},
		[2] = {"mccompat:brown_mushroom_block_2",	{"mushroom_block_skin_brown.png","mushroom_block_inside.png","mushroom_block_skin_brown.png","mushroom_block_inside.png"}},
		[3] = {"mccompat:brown_mushroom_block_3",	{"mushroom_block_skin_brown.png","mushroom_block_inside.png","mushroom_block_skin_brown.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_brown.png"}},
		[4] = {"mccompat:brown_mushroom_block_4",	{"mushroom_block_skin_brown.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_brown.png","mushroom_block_inside.png"}},
		[5] = {"mccompat:brown_mushroom_block_5",	{"mushroom_block_skin_brown.png","mushroom_block_inside.png"}},
		[6] = {"mccompat:brown_mushroom_block_6",	{"mushroom_block_skin_brown.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_brown.png"}},
		[7] = {"mccompat:brown_mushroom_block_7",	{"mushroom_block_skin_brown.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_brown.png","mushroom_block_skin_brown.png"}},
		[8] = {"mccompat:brown_mushroom_block_8",	{"mushroom_block_skin_brown.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_brown.png","mushroom_block_inside.png"}},
		[9] = {"mccompat:brown_mushroom_block_9",	{"mushroom_block_skin_brown.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_brown.png","mushroom_block_inside.png","mushroom_block_skin_brown.png"}},
		[10] = {"mccompat:brown_mushroom_block_10",	{"mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_stem.png"}},
		[14] = {"mccompat:brown_mushroom_block_14",	"mushroom_block_skin_brown.png"},

		[15] = {"mccompat:brown_mushroom_block_15",	"mushroom_block_skin_stem.png"},
		}},
	[100] = {SELECT,{
		[0] = {"mccompat:red_mushroom_block_0",	"mushroom_block_inside.png"},
		[1] = {"mccompat:red_mushroom_block_1",	{"mushroom_block_skin_red.png","mushroom_block_inside.png","mushroom_block_skin_red.png","mushroom_block_inside.png","mushroom_block_skin_red.png","mushroom_block_inside.png"}},
		[2] = {"mccompat:red_mushroom_block_2",	{"mushroom_block_skin_red.png","mushroom_block_inside.png","mushroom_block_skin_red.png","mushroom_block_inside.png"}},
		[3] = {"mccompat:red_mushroom_block_3",	{"mushroom_block_skin_red.png","mushroom_block_inside.png","mushroom_block_skin_red.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_red.png"}},
		[4] = {"mccompat:red_mushroom_block_4",	{"mushroom_block_skin_red.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_red.png","mushroom_block_inside.png"}},
		[5] = {"mccompat:red_mushroom_block_5",	{"mushroom_block_skin_red.png","mushroom_block_inside.png"}},
		[6] = {"mccompat:red_mushroom_block_6",	{"mushroom_block_skin_red.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_red.png"}},
		[7] = {"mccompat:red_mushroom_block_7",	{"mushroom_block_skin_red.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_red.png","mushroom_block_skin_red.png"}},
		[8] = {"mccompat:red_mushroom_block_8",	{"mushroom_block_skin_red.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_red.png","mushroom_block_inside.png"}},
		[9] = {"mccompat:red_mushroom_block_9",	{"mushroom_block_skin_red.png","mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_red.png","mushroom_block_inside.png","mushroom_block_skin_red.png"}},
		[10] = {"mccompat:red_mushroom_block_10",	{"mushroom_block_inside.png","mushroom_block_inside.png","mushroom_block_skin_stem.png"}},
		[14] = {"mccompat:red_mushroom_block_14",	"mushroom_block_skin_red.png"},

		[15] = {"mccompat:red_mushroom_block_15",	"mushroom_block_skin_stem.png"},
		}},
	[101] = {GPANE,  "iron_bars",			"iron_bars.png"},
	[102] = {GPANE,  "glass_pane",			"glass.png"},
	[103] = {NORMAL, "mccompat:melon_block",	{"melon_top.png","melon_top.png","melon_side.png"}},
	[104] = {PLANT,  "mccompat:pumpkin_stem",	"pumpkin_stem_connected.png"..TEXTURE_FOILAGE},
	[105] = {PLANT,  "mccompat:melon_stem",		"melon_stem_connected.png"..TEXTURE_FOILAGE},
	[106] = {PLANT,  "mccompat:vine",		"vine.png"},
	[107] = {GATE,   "planks_oak",			"planks_oak.png"},
	[108] = {STAIR,  "brick_block",			"brick.png"},
	[109] = {STAIR,  "stonebrick",			"stone_brick.png"},
	[110] = {NORMAL, "mccompat:mycelium",		{"mycelium_top.png","dirt.png","dirt.png^mycelium_side.png"}},
	-- the waterlily is a rather flat plant
	[111] = {PLANT,  "mccompat:waterlily",		"waterlily.png"..TEXTURE_FOILAGE,
		{ drawtype = "signlike"}},
	[112] = {NORMAL, "mccompat:nether_brick",	"nether_brick.png"},
	[113] = {NORMAL, "mccompat:nether_brick_fence","nether_brick.png",
		mccompat_typ_fence},
	[114] = {STAIR,  "nether_brick",		"nether_brick.png"},
	[115] = {PLANT,{
		[0] = {"mccompat:nether_wart_0",	"nether_wart_stage_0.png"},
		[1] = {"mccompat:nether_wart_1",	"nether_wart_stage_1.png"},
		[2] = {"mccompat:nether_wart_2",	"nether_wart_stage_2.png"},
		}},
	[116] = {NORMAL, "mccompat:enchanting_table",	{"enchanting_table_top.png","enchanting_table_bottom.png","enchanting_table_side.png"}},
	[117] = {NORMAL, "mccompat:brewing_stand",	{"brewing_stand_base.png","brewing_stand_base.png","brewing_stand.png"}},
	[118] = {NORMAL, "mccompat:cauldron",		{"cauldron_top.png","cauldron_bottom.png","cauldron_side.png"}},
--	[119] = {TODO,   "mccompat:end_portal",			"End_Portal_TODO.png"},
--	[120] = {TODO,   "mccompat:end_portal_frame",			"End_Portal_Frame_TODO.png"},
	[121] = {NORMAL, "mccompat:end_stone",		"end_stone.png"},
	[122] = {NORMAL, "mccompat:dragon_egg",	"dragon_egg.png"},
	[123] = {NORMAL, "mccompat:redstone_lamp",	"redstone_lamp_off.png"},
	[124] = {NORMAL, "mccompat:lit_redstone_lamp",	"redstone_lamp_on.png",
		{
			light_source = 15
		}},
	[125] = {SELECT, {
		[0] = {"mccompat:planks_oak",		"planks_oak.png"},
		[1] = {"mccompat:planks_spruce",	"planks_spruce.png"},
		[2] = {"mccompat:planks_birch",	"planks_birch.png"},
		[3] = {"mccompat:planks_jungle",	"planks_jungle.png"},
		[4] = {"mccompat:planks_acacia",	"planks_acacia.png"},
		[5] = {"mccompat:planks_big_oak",	"planks_big_oak.png"},
		}},
		-- the double versions are equivalent to the normal ones
	[126] = {SLAB,{
		 [0] = {"planks_oak",			"planks_oak.png"},
		 [1] = {"planks_spruce",		"planks_spruce.png"},
	 	 [2] = {"planks_birch",			"planks_birch.png"},
	 	 [3] = {"planks_jungle",		"planks_jungle.png"},
		 [4] = {"planks_acacia",		"planks_acacia.png"},
		 [5] = {"planks_big_oak",		"planks_big_oak.png"},
		 [8] = {"planks_oakupside_down",	"planks_oak.png"},
		 [9] = {"planks_spruceupside_down",	"planks_spruce.png"},
		[10] = {"planks_birchupside_down",	"planks_birch.png"},
		[11] = {"planks_jungleupside_down",	"planks_jungle.png"},
	 	[12] = {"planks_acaciaupside_down",	"planks_acacia.png"},
	 	[13] = {"planks_big_oakupside_down",	"planks_big_oak.png"},
		}},
	[127] = {FACEDIR,"mccompat:cocoa",		"cocoa_stage_2.png",
		{
			drawtype = "plantlike",
			visual_scale = 1.0,
			paramtype = "light",
			sunlight_propagates = true,
			walkable = false,
		}},
		-- the growth stage is ignored here as it is less relevant than the facedir
	[128] = {STAIR,  "sandstone",	{"sandstone_top.png","sandstone_bottom.png","sandstone_normal.png"}},
	[129] = {NORMAL, "mccompat:emerald_ore",	"emerald_ore.png"},
--	[130] = {TODO, "mccompat:ender_chest",	"Ender_Chest_TODO.png"},
--	[131] = {TODO, "mccompat:tripwire_hook",	"trip_wire_TODO.png"},
--	[132] = {TODO, "mccompat:tripwire",		"trip_wire.png"},
	[133] = {NORMAL, "mccompat:emerald_block",	"emerald_block.png"},
	[134] = {STAIR,  "planks_spruce",		"planks_spruce.png"},
	[135] = {STAIR,  "planks_birch",		"planks_birch.png"},
	[136] = {STAIR,  "planks_jungle",		"planks_jungle.png"},
	[137] = {NORMAL, "mccompat:command_block",	"command_block.png"},
	[138] = {NORMAL, "mccompat:beacon",		"beacon.png"},
		-- looks as if it might require a complex nodebox
	[139] = {WALL,{
		 [0] = {"mccompat:wall",		"cobblestone.png"},
		 [1] = {"mccompat:mossy_wall",		"cobblestone_mossy.png"},
		},
		mccompat_typ_normal},
		-- they would require a suitable nodebox
	[140] = {PLANT,{ 
		 [0] = {"mccompat:flower_pot_empty",	"flower_pot.png"},
		 [1] = {"mccompat:flower_pot_poppy",	"flower_pot.png^flower_rose.png"}, 
		 [2] = {"mccompat:flower_pot_dandelion","flower_pot.png^flower_dandelion.png"},
		 [3] = {"mccompat:flower_pot_oak",	"flower_pot.png^sapling_oak.png"},
		 [4] = {"mccompat:flower_pot_spruce",	"flower_pot.png^sapling_spruce.png"},
		 [5] = {"mccompat:flower_pot_birch",	"flower_pot.png^sapling_birch.png"},
		 [6] = {"mccompat:flower_pot_jungle",	"flower_pot.png^sapling_jungle.png"},
		 [7] = {"mccompat:flower_pot_red",	"flower_pot.png^mushroom_red.png"},
		 [8] = {"mccompat:flower_pot_brown",	"flower_pot.png^mushroom_brown.png"},
		 [9] = {"mccompat:flower_pot_cactus",	"flower_pot.png^cactus_side.png"},
		[10] = {"mccompat:flower_pot_deadbush","flower_pot.png^deadbush.png"},
		[11] = {"mccompat:flower_pot_fern",	"flower_pot.png^fern.png"},
		[12] = {"mccompat:flower_pot_acacia",	"flower_pot.png^sapling_acacia.png"},
		[13] = {"mccompat:flower_pot_dark_oak","flower_pot.png^sapling_roofed_oak.png"},
		}},
	[141] = {PLANT,{
		[0] = {"mccompat:carrots_0",	"carrots_stage_0.png"},
		[1] = {"mccompat:carrots_0",	"carrots_stage_0.png"},
		[2] = {"mccompat:carrots_1",	"carrots_stage_1.png"},
		[3] = {"mccompat:carrots_1",	"carrots_stage_1.png"},
		[4] = {"mccompat:carrots_2",	"carrots_stage_2.png"},
		[5] = {"mccompat:carrots_2",	"carrots_stage_2.png"},
		[6] = {"mccompat:carrots_3",	"carrots_stage_3.png"},
		[7] = {"mccompat:carrots_3",	"carrots_stage_3.png"},
		},
		{waving = 1}},
	[142] = {PLANT,{
		[0] = {"mccompat:potatoes_0",	"potatoes_stage_0.png"},
		[1] = {"mccompat:potatoes_0",	"potatoes_stage_0.png"},
		[2] = {"mccompat:potatoes_1",	"potatoes_stage_1.png"},
		[3] = {"mccompat:potatoes_1",	"potatoes_stage_1.png"},
		[4] = {"mccompat:potatoes_2",	"potatoes_stage_2.png"},
		[5] = {"mccompat:potatoes_2",	"potatoes_stage_2.png"},
		[6] = {"mccompat:potatoes_3",	"potatoes_stage_3.png"},
		[7] = {"mccompat:potatoes_3",	"potatoes_stage_3.png"},
		},
		{waving = 1}},
	[143] = {NORMAL, "mccompat:wooden_button",	"planks_oak.png",
		mccompat_typ_button},
--	[144] = {TODO, "mccompat:skull",			"Skeleton_Skull_TODO.png"},
	[145] = {NORMAL, "mccompat:anvil", 		"anvil_base.png",
		mccompat_typ_anvil},
--	[146] = {TODO, "mccompat:trapped_chest",			"Trapped_Chest_TODO.png"},
	[147] = {CARPET, "mccompat:light_weighted_pressure_plate",	"gold_block.png"},
	[148] = {CARPET, "mccompat:heavy_weighted_pressure_plate",	"iron_block.png"},
--	[149] = {TODO, "mccompat:unpowered_comparator",	"comparator_off.png"},
--	[150] = {TODO, "mccompat:powered_comparator",	"comparator_on.png"},
--	[151] = {TODO, "mccompat:daylight_detector",	"daylight_detector_side_TODO.png"},
	[152] = {NORMAL, "mccompat:redstone_block",	"redstone_block.png"},
	[153] = {NORMAL, "mccompat:quartz_ore",	"quartz_ore.png"},
--	[154] = {TODO,   "mccompat:hopper",			"hopper_outside_TODO.png"},
		-- requires a nodebox
	[155] = {NORMAL, "mccompat:quartz_block",	{"quartz_block_top.png","quartz_block_top.png","quartz_block_side.png"}},
	[156] = {STAIR,  "quartz_block",		{"quartz_block_top.png","quartz_block_top.png","quartz_block_side.png"}},
	[157] = {RAIL,   "mccompat:activator_rail",	"rail_activator.png",
		mccompat_typ_rail},
	[158] = {FACEDIR,"mccompat:dropper",		{"dropper_front_vertical.png","dropper_front_vertical.png","dropper_front_horizontal.png"}},
	[159] = {SELECT,{
		 [0] = {"mccompat:stained_clay_white",	"hardened_clay_stained_white.png"},
		 [1] = {"mccompat:stained_clay_orange","hardened_clay_stained_orange.png"},
		 [2] = {"mccompat:stained_clay_magenta","hardened_clay_stained_magenta.png"},
		 [3] = {"mccompat:stained_clay_light_blue",	"hardened_clay_stained_light_blue.png"},
		 [4] = {"mccompat:stained_clay_yellow","hardened_clay_stained_yellow.png"},
		 [5] = {"mccompat:stained_clay_lime",	"hardened_clay_stained_lime.png"},
		 [6] = {"mccompat:stained_clay_pink",	"hardened_clay_stained_pink.png"},
		 [7] = {"mccompat:stained_clay_gray",	"hardened_clay_stained_gray.png"},
		 [8] = {"mccompat:stained_clay_silver","hardened_clay_stained_silver.png"},
		 [9] = {"mccompat:stained_clay_cyan",	"hardened_clay_stained_cyan.png"},
		[10] = {"mccompat:stained_clay_purple","hardened_clay_stained_purple.png"},
		[11] = {"mccompat:stained_clay_blue",	"hardened_clay_stained_blue.png"},
		[12] = {"mccompat:stained_clay_brown",	"hardened_clay_stained_brown.png"},
		[13] = {"mccompat:stained_clay_green",	"hardened_clay_stained_green.png"},
		[14] = {"mccompat:stained_clay_red",	"hardened_clay_stained_red.png"},
		[15] = {"mccompat:stained_clay_black",	"hardened_clay_stained_black.png"},
		}},
	[160] = {GPANE, {
		 [0] = {"stained_glass_pane_white",	"glass_white.png"},
		 [1] = {"stained_glass_pane_orange",	"glass_orange.png"},
		 [2] = {"stained_glass_pane_magenta",	"glass_magenta.png"},
		 [3] = {"stained_glass_pane_light_blue","glass_light_blue.png"},
		 [4] = {"stained_glass_pane_yellow",	"glass_yellow.png"},
		 [5] = {"stained_glass_pane_lime",	"glass_lime.png"},
		 [6] = {"stained_glass_pane_pink",	"glass_pink.png"},
		 [7] = {"stained_glass_pane_gray",	"glass_gray.png"},
		 [8] = {"stained_glass_pane_silver",	"glass_silver.png"},
		 [9] = {"stained_glass_pane_cyan",	"glass_cyan.png"},
		[10] = {"stained_glass_pane_purple",	"glass_purple.png"},
		[11] = {"stained_glass_pane_blue",	"glass_blue.png"},
		[12] = {"stained_glass_pane_brown",	"glass_brown.png"},
		[13] = {"stained_glass_pane_green",	"glass_green.png"},
		[14] = {"stained_glass_pane_red",	"glass_red.png"},
		[15] = {"stained_glass_pane_black",	"glass_black.png"},
		}},
		-- those are glasspanes
	[161] = {SELECT,{
		 [0] = {"mccompat:leaves_acacia",	"leaves_acacia.png"..TEXTURE_LEAVES},
		 [1] = {"mccompat:leaves_big_oak",	"leaves_big_oak.png"..TEXTURE_LEAVES},
		 [4] = {"mccompat:leaves_acacia",	"leaves_acacia.png"..TEXTURE_LEAVES},
		 [5] = {"mccompat:leaves_big_oak",	"leaves_big_oak.png"..TEXTURE_LEAVES},
		 [8] = {"mccompat:leaves_acacia",	"leaves_acacia.png"..TEXTURE_LEAVES},
		 [9] = {"mccompat:leaves_big_oak",	"leaves_big_oak.png"..TEXTURE_LEAVES},
		 [12] = {"mccompat:leaves_acacia",	"leaves_acacia.png"..TEXTURE_LEAVES},
		 [13] = {"mccompat:leaves_big_oak",	"leaves_big_oak.png"..TEXTURE_LEAVES},
		},
		mccompat_typ_leaves },
		-- there are duplicates due to decay/check decay, which is not relevant here
	[162] = {SELECT,{
		[0] = {"mccompat:log2_acacia",		{"log_acacia_top.png","log_acacia_top.png","log_acacia.png"}},
		[1] = {"mccompat:log2_big_oak",		{"log_big_oak_top.png","log_big_oak_top.png","log_big_oak.png"}},
		-- only bark; needs special handling!
		[8] = {"mccompat:log2_acacia",		{"log_acacia.png"}},
		[9] = {"mccompat:log2_big_oak",		{"log_big_oak.png"}},
		},
		mccompat_typ_facedir},
	[163] = {STAIR,  "planks_acacia",		"planks_acacia.png"},
	[164] = {STAIR,  "planks_big_oak",		"planks_big_oak.png"},
	[165] = {NORMAL, "mccompat:slime",		"slime.png"},
--	[166] = {TODO, "mccompat:barrier",			"Barrier_TODO.png"},
	[167] = {TRAPDOOR, "iron",			"iron_trapdoor.png"},
	[168] = {SELECT,{
		[0] = {"mccompat:prismarine",		"prismarine_rough.png"},
		[1] = {"mccompat:prismarine_bricks",	"prismarine_bricks.png"},
		[2] = {"mccompat:prismarine_dark",	"prismarine_dark.png"},
		}},
	[169] = {NORMAL,"mccompat:sea_lantern",	"sea_lantern.png",
		{
			light_source = 15
		}},
	[170] = {NORMAL, "mccompat:hay_block",	{"hay_block_top.png","hay_block_top.png","hay_block_side.png"}},
	[171] = {CARPET,{
		 [0] = {"mccompat:carpet_white",	"wool_colored_white.png"},
		 [1] = {"mccompat:carpet_orange",	"wool_colored_orange.png"},
		 [2] = {"mccompat:carpet_magenta",	"wool_colored_magenta.png"},
		 [3] = {"mccompat:carpet_light_blue",	"wool_colored_light_blue.png"},
		 [4] = {"mccompat:carpet_yellow",	"wool_colored_yellow.png"},
		 [5] = {"mccompat:carpet_lime",	"wool_colored_lime.png"},
		 [6] = {"mccompat:carpet_pink",	"wool_colored_pink.png"},
		 [7] = {"mccompat:carpet_gray",	"wool_colored_gray.png"},
		 [8] = {"mccompat:carpet_silver",	"wool_colored_silver.png"},
		 [9] = {"mccompat:carpet_cyan",	"wool_colored_cyan.png"},
		[10] = {"mccompat:carpet_purple",	"wool_colored_purple.png"},
		[11] = {"mccompat:carpet_blue",	"wool_colored_blue.png"},
		[12] = {"mccompat:carpet_brown",	"wool_colored_brown.png"},
		[13] = {"mccompat:carpet_green",	"wool_colored_green.png"},
		[14] = {"mccompat:carpet_red",		"wool_colored_red.png"},
		[15] = {"mccompat:carpet_black",	"wool_colored_black.png"},
		}},
	[172] = {SELECT,{
		 [0] = {"mccompat:stained_clay_white",	"hardened_clay_stained_white.png"},
		 [1] = {"mccompat:stained_clay_orange","hardened_clay_stained_orange.png"},
		 [2] = {"mccompat:stained_clay_magenta","hardened_clay_stained_magenta.png"},
		 [3] = {"mccompat:stained_clay_light_blue",	"hardened_clay_stained_light_blue.png"},
		 [4] = {"mccompat:stained_clay_yellow","hardened_clay_stained_yellow.png"},
		 [5] = {"mccompat:stained_clay_lime",	"hardened_clay_stained_lime.png"},
		 [6] = {"mccompat:stained_clay_pink",	"hardened_clay_stained_pink.png"},
		 [7] = {"mccompat:stained_clay_gray",	"hardened_clay_stained_gray.png"},
		 [8] = {"mccompat:stained_clay_silver","hardened_clay_stained_silver.png"},
		 [9] = {"mccompat:stained_clay_cyan",	"hardened_clay_stained_cyan.png"},
		[10] = {"mccompat:stained_clay_purple","hardened_clay_stained_purple.png"},
		[11] = {"mccompat:stained_clay_blue",	"hardened_clay_stained_blue.png"},
		[12] = {"mccompat:stained_clay_brown",	"hardened_clay_stained_brown.png"},
		[13] = {"mccompat:stained_clay_green",	"hardened_clay_stained_green.png"},
		[14] = {"mccompat:stained_clay_red",	"hardened_clay_stained_red.png"},
		[15] = {"mccompat:stained_clay_black",	"hardened_clay_stained_black.png"},
		}},
		-- hardened clay seems to be the same as stained one?
	[173] = {NORMAL, "mccompat:coal_block",	"coal_block.png"},
	[174] = {NORMAL, "mccompat:packed_ice",	"ice_packed.png"},
	[175] = {PLANT,{
		[0] = {"mccompat:double_plant_sunflower","double_plant_sunflower_bottom.png"},
		[1] = {"mccompat:double_plant_syringa","double_plant_syringa_bottom.png"},
		[2] = {"mccompat:double_plant_grass",	"double_plant_grass_bottom.png"..TEXTURE_FOILAGE},
		[3] = {"mccompat:double_plant_fern",	"double_plant_fern_bottom.png"..TEXTURE_FOILAGE},
		[4] = {"mccompat:double_plant_rose",	"double_plant_rose_bottom.png"},
		[5] = {"mccompat:double_plant_paeonia","double_plant_paeonia_bottom.png"},
		[128] = {"mccompat:double_plant_tsunflower",	"double_plant_sunflower_top.png"},
		[129] = {"mccompat:double_plant_tsyringa",	"double_plant_syringa_top.png"},
		[130] = {"mccompat:double_plant_tgrass",	"double_plant_grass_top.png"..TEXTURE_FOILAGE},
		[131] = {"mccompat:double_plant_tfern",		"double_plant_fern_top.png"..TEXTURE_FOILAGE},
		[132] = {"mccompat:double_plant_trose",		"double_plant_rose_top.png"},
		[133] = {"mccompat:double_plant_tpaeonia",	"double_plant_paeonia_top.png"},
		}},
		-- 0x8: Top Half of any Large Plant; low three bits 0x7 are derived from the block below.
--	[176] = {TODO, "mccompat:standing_banner",			"Free-standing_Banner_Small.png"},
--	[177] = {TODO, "mccompat:wall_banner",			"Wall-mounted_Banner_Small.png"},
--	[178] = {TODO, "mccompat:daylight_detector_inverted",			"daylight_detector_inverted_top.png"},
	[179] = {"mccompat:red_sandstone",			"red_sandstone_normal.png"},
	[180] = {STAIR,  "red_sandstone",		{"red_sandstone_top.png","red_sandstone_bottom.png","red_sandstone_normal.png"}},
	[181] = {SELECT,{
		[0] = {"mccompat:double_red_sandstone_slab",		{"red_sandstone_top.png","red_sandstone_bottom.png","red_sandstone_normal.png"}},
		[1] = {"mccompat:double_red_sandstone_slab_smooth",	{"red_sandstone_top.png","red_sandstone_bottom.png","red_sandstone_smooth.png"}},
		}},
	[182] = {SLAB,{
		[0] = {"red_sandstone",			{"red_sandstone_top.png","red_sandstone_bottom.png","red_sandstone_normal.png"}},
		[8] = {"red_sandstoneupside_down",	{"red_sandstone_top.png","red_sandstone_bottom.png","red_sandstone_normal.png"}},
		}},
	[183] = {GATE,  "planks_spruce",	"planks_spruce.png"},
	[184] = {GATE,  "planks_birch",		"planks_birch.png"},
	[185] = {GATE,  "planks_jungle",	"planks_jungle.png"},
	[186] = {GATE,  "planks_dark_oak",	"planks_big_oak.png"},
	[187] = {GATE,  "planks_acacia",	"planks_acacia.png"},
	[188] = {NORMAL,"mccompat:planks_spruce",	"planks_spruce.png",
		mccompat_typ_fence},
	[189] = {NORMAL,"mccompat:birch_fence",		"planks_birch.png",
		mccompat_typ_fence},
	[190] = {NORMAL,"mccompat:jungle_fence",	"planks_jungle.png",
		mccompat_typ_fence},
	[191] = {NORMAL,"mccompat:dark_oak_fence",	"planks_big_oak.png",
		mccompat_typ_fence},
	[192] = {NORMAL,"mccompat:acacia_fence",	"planks_acacia.png",
		mccompat_typ_fence},
	[193] = {DOOR,   "spruce_door",		"door_spruce"},
	[194] = {DOOR,   "birch_door",		"door_birch"},
	[195] = {DOOR,   "jungle_door",		"door_jungle"},
	[196] = {DOOR,   "acacia_door",		"door_acacia"},
	[197] = {DOOR,   "dark_oak_door",	"door_dark_oak"},
}

-- we need to define the first one here because the table seems to be broken otherwise
blocks_and_textures[1] = {SELECT,{
		[0] = {"mccompat:stone",		"stone.png"},
		[1] = {"mccompat:granite",		"stone_granite.png"},
		[2] = {"mccompat:polished_granite",	"stone_granite_smooth.png"},
		[3] = {"mccompat:diorite",		"stone_diorite.png"},
		[4] = {"mccompat:polished_diorite",	"stone_diorite_smooth.png"},
		[5] = {"mccompat:andesite",		"stone_andesite.png"},
		[6] = {"mccompat:polished_andesite",	"stone_andesite_smooth.png"}}};





local mc_add_node = function( mc_node_name, defs_typ, defs_node, tiles )
--print('ADDING '..tostring( mc_node_name ));
	-- if the node already exists, abort;
	-- this may be caused by multiple block ids used for the same node,
	-- or for stairs/slabs that are already defined, or for default nodes
	if( minetest.registered_nodes[ mc_node_name ] ) then
		return;
	end

	local new_def = {};
	-- some basic definitions each node ought to have
	new_def.description       = 'MC compatibility node '..mc_node_name;
	if( type( tiles )=='table' ) then
		new_def.tiles             = tiles;
	else
		new_def.tiles             = {tiles};
	end
	new_def.is_ground_content = false;
	-- we do not aim for usable nodes with fitting groups - this is for
	-- spawning buildings only, not for gathering ressources
        new_def.groups = {cracky=2,oddly_breakable_by_hand=1};

			
	-- general typ definitions, i.e. plantlike drawtype, nodeboxes and such
	for k,v in pairs( defs_typ ) do
		new_def[ k ] = v;
	end
	-- additional special definitions for a node
	if( defs_node ) then
		for k,v in pairs( defs_node ) do
			new_def[ k ] = v;
		end
	end
	-- actually register the new node
	minetest.register_node( mc_node_name, new_def );
end



local blocknames = {};

for i=1,256 do
	blocknames[i] = { name='minecraft:blockid_'..tostring(i), typ=0};
end

for i,v in pairs(blocks_and_textures) do
	local typ = v[1];
	local mc_node_add_defs = {};
	local list = {};
	-- multiple nodes defined
	if(     v[2] and type(v[2])=='table' ) then
		blocknames[i].multi = 1;
		list = v[2];
		if( v[3] and type(v[3])=='table') then
			mc_node_add_defs = v[3];
		end
	-- only one node defined
	elseif( v[2] and type(v[2])=='string' ) then
		blocknames[i].multi = 0;
		list = {{v[2], v[3]}};
		if( v[4] and type(v[4])=='table') then
			mc_node_add_defs = v[4];
		end
	else
		list = {};
		print( '[mccompat] ERROR: Cannot handle BlockID '..tostring(i)..' with values '..minetest.serialize( v ));
	end

	local new_list = {};
	-- for each subtype (some entries contain subtypes)
	for j,subtyp in pairs( list ) do
		local mc_node_name  = subtyp[1];
		local mc_node_tiles = subtyp[2];

		new_list[j] = mc_node_name;

		if(     typ==NORMAL or typ==SELECT) then
			mc_add_node( mc_node_name, mccompat_typ_normal, mc_node_add_defs, mc_node_tiles );	
	
		elseif( typ==PLANT ) then
			mc_add_node( mc_node_name, mccompat_typ_plant,  mc_node_add_defs, mc_node_tiles );

		-- carpets are thin layers and use a nodebox
		elseif( typ==CARPET ) then
			mc_add_node( mc_node_name, mccompat_typ_carpet, mc_node_add_defs, mc_node_tiles );

		elseif( typ==FACEDIR ) then
			mc_add_node( mc_node_name, mccompat_typ_facedir,mc_node_add_defs, mc_node_tiles );
			-- TODO: facedir needs to be actually handled
			blocknames[i].facedir = 1;

		-- register stairs and slabs when needed
		elseif( typ==STAIR or typ==SLAB) then
			if( not( minetest.registered_nodes[ "stairs:stair_"..mc_node_name ])) then
				-- creates
				-- ":stairs:stair_" .. subname
				-- ":stairs:stair_" .. subname.."upside_down
				-- ":stairs:slab_" .. subname
				-- ":stairs:slab_" .. subname.."upside_down"
				if( type( mc_node_tiles )=='string' ) then
					mc_node_tiles = {mc_node_tiles};
				end
				stairs.register_stair_and_slab(mc_node_name, "mccompat:"..mc_node_name,
					{snappy=2,choppy=2,oddly_breakable_by_hand=2},
					mc_node_tiles,
					"Stair "..mc_node_name,
					"Slab "..mc_node_name,
					default.node_sound_wood_defaults());
			end
			-- upside_down-variants already carry the necessary postfix
			if(     typ==STAIR ) then
				new_list[j] = "stairs:stair_"..mc_node_name;
			elseif( typ==SLAB ) then
				new_list[j] = "stairs:slab_"..mc_node_name;
			end
			if( typ==STAIR ) then
				blocknames[i].stair = 1;
			end

		elseif( typ==GATE ) then
			-- row needs to contain:  {gate_name, description, texture, node_name_craft_indigrent}
			mccompat.register_gate( {mc_node_name, mc_node_name..' Gate', mc_node_tiles, 'mccompat:'..mc_node_name} )
			new_list[j] = "mccompat:"..mc_node_name.."gate_closed";
			blocknames[i].gate = 1;

		elseif( typ==DOOR ) then
			-- if the door does not exist, register it
			if( not( minetest.registered_nodes[ "mccompat:door_"..mc_node_name..'_t_1' ])) then
				doors.register_door("mccompat:door_"..mc_node_name, {
					description = mc_node_name.." Door",
					groups = {snappy=1,cracky=1,oddly_breakable_by_hand=3,door=1},
					tiles_bottom = {mc_node_tiles.."_lower.png^[transformFX", mc_node_tiles.."_lower.png"},
					tiles_top =    {mc_node_tiles.."_upper.png^[transformFX", mc_node_tiles.."_upper.png",},
					sounds = default.node_sound_glass_defaults(),
					sunlight = true,
				})
			end
			new_list[j] = "mccompat:door_"..mc_node_name;
			blocknames[i].door = 1;

		elseif( typ==TRAPDOOR ) then
			-- if the trapdoor does not exist, register it
			if( not( minetest.registered_nodes[ "mccompat:trapdoor_"..mc_node_name ])) then
				doors.register_trapdoor("mccompat:trapdoor_"..mc_node_name, {
				        description = "Trapdoor "..mc_node_name,
				        tile_front = mc_node_tiles,
				        tile_side = mc_node_tiles,
				        groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, door=1},
				        sounds = default.node_sound_wood_defaults(),
				        sound_open = "doors_door_open",
				        sound_close = "doors_door_close"
				})
			end
			new_list[j] = "mccompat:trapdoor_"..mc_node_name;
			blocknames[i].trapdoor = 1;

		-- diffrent panes
		elseif( typ==GPANE ) then
			xconnected.register_pane( "mccompat:"..mc_node_name, mc_node_tiles );
			new_list[j] = "mccompat:"..mc_node_name..'_c4';

		elseif( typ==WALL ) then
			xconnected.register_wall( mc_node_name, mc_node_tiles );
			new_list[j] = mc_node_name.."_c4";

		elseif( typ==RAIL ) then
			local add_defs = {
				inventory_image = mc_node_tiles,
				wield_image     = mc_node_tiles
			};
			local tiles_rail = {
				mc_node_tiles,
				"default_rail_curved.png",
				mc_node_tiles.."^default_rail_curved.png",
				mc_node_tiles.."^[transform1^"..mc_node_tiles
			};
			mc_add_node( mc_node_name, mccompat_typ_rail, add_defs, tiles_rail );
		end

		blocknames[i].list = new_list;
	end
end


local get_bits = function( blockdata, bits )
	local bit2value = { 1, 2, 4, 8, 16, 32, 64, 128, 256 };
	local res = 0;
	for i, bit_nr in ipairs( bits ) do
		local bit_value = blockdata % (bit_nr + bit_nr) >= bit_nr;      
		if( bit_value ) then
			res = res + bit2value[ i ];
		end
	end
	return res;
end

-- mc2mtstairs is suitable for stairs and even returns the correct name
local mc2mtFacedir = function(blockdata)
--      #Minetest
--      # x+ = 2
--      # x- = 3
--      # z+ = 1
--      # z- = 0
--      #Minecraft
--      # x+ = 3
--      # x- = 1
--      # z+ = 0
--      # z- = 2
	local tbl = {
		[3]= 2,
	[1]= 1,
	[0]= 3,
	[2]= 0,
	}
	if( tbl[ blockdata ] ) then
		return tbl[ blockdata ];
	-- this happens with i.e. wallmounted torches...
	else
		return blockdata;
	end
end

-- for ladder, furnace, chest, trapped chest
local mc2mtFacedir3 = function( dir )
	if(     dir==3 ) then return 2; -- south
	elseif( dir==4 ) then return 0; -- west
	elseif( dir==5 ) then return 1; -- east
	-- Invalid values default to 2.
	else return 3; end -- north
end


local mc2mtstairs = function( name, blockdata)
	if blockdata >= 4 then
		return {name.. "upside_down", mc2mtFacedir(blockdata - 4)}
	else
		return {name, mc2mtFacedir(blockdata)}
	end
end



-- returns {translated_node_name, translated_param2}
mccompat.findMC2MTConversion = function(blockid, blockdata, blockid2, blockdata2)
	if(     blockid== 0) then
		return {"air", 0};

	-- fallback
        elseif( not( blocknames[ blockid ]) or not( blocknames[ blockid ].list)) then
		return { "minecraft:fallback_"..tostring( blockid )..'_'..tostring( blockdata ), 0};
        
	-- logs
	elseif( blockid==17 or blockid==162 ) then
		local selection = get_bits( blockdata, {1, 2} );
		local dir       = get_bits( blockdata, {4, 8} );
		if(     dir==0 ) then -- 0 up/down -> normal orientation
			return { blocknames[blockid].list[ selection   ],  0};
		elseif( dir==2 ) then -- 1 east/west
			return { blocknames[blockid].list[ selection   ],  4};
		elseif( dir==1 ) then -- 2 north/south
			return { blocknames[blockid].list[ selection   ], 12};
		elseif( dir==3 ) then -- only bark -> specical node
			return { blocknames[blockid].list[ selection+8 ], 0};
		else -- fallback
			return { blocknames[blockid].list[ selection   ], 0};
		end

	elseif( blockid==26 ) then -- bed
		-- bit 0x4: empty/occupied (irrelevant for us)
		local dir = 0;
		dir = get_bits( blockdata, {1,2} );
		local param2 = 0;
		if(     dir==0 ) then param2 = 2;
		elseif( dir==1 ) then param2 = 3;
		elseif( dir==2 ) then param2 = 0;
		elseif( dir==3 ) then param2 = 1;
		end
		-- bit 0x8: when 0, foot of the bed; when 1, head of the bed
		if( get_bits( blockdata, {8} )==0 ) then
			return {"beds:bed_top",    param2 }; --mc2mtFacedir(dir) };
		else
			return {"beds:bed_bottom", param2 }; --mc2mtFacedir(dir) };
		end

	-- large plants require two blocks
	elseif( blockid==175 ) then
		-- 0x8: Top Half of any Large Plant; low three bits 0x7 are derived from the block below.
		if( get_bits( blockdata, {8} )>0 ) then
			-- we need the data below in order to figure out what flower this actually is;
			-- request the data
			if( not(blockid2) or not( blockdata2 )) then
				return { nil, nil, -1 };
			end
			-- this is the upper part...
			return { blocknames[ blockid ].list[ blockdata2 + 128 ], 0 };
		end
		-- the lower part of the flower is easy
		return { blocknames[ blockid ].list[ blockdata ], 0 };


	-- doors need to be handled specially
	elseif( blocknames[ blockid ].door ) then

		-- we need to request additional information
		if( not( blockid2 ) or not( blockdata2 )) then
			-- top half of the door?
			if( get_bits( blockdata, {8})>0 ) then
				return { nil, nil, -1 };
			else
				return { nil, nil,  1 };
			end
		end
		-- both have to be the same door
		if( blockid ~= blockid2 ) then
			return {"error:wrong_other_node",0};
		end
		local name = blocknames[ blockid ].list[ 1 ];
		local dir   = 0;
		local hinge = 0;
		local open  = 0;
		-- 0x8: If this bit is set, this is the top half of a door (else the lower half).
		if( get_bits( blockdata, {8})>0 ) then
			name  = name..'_t';
			-- the node below knows about facedir
			dir   = get_bits( blockdata2, {1,2} );
			-- hinge to the right or left?
			hinge = get_bits( blockdata,  {1} );
			-- the node below knows if the door is open
			open  = get_bits( blockdata2, {4} );
		else
			name = name..'_b';
			-- this node knows which facedir it has
			dir   = get_bits( blockdata,  {1,2} );
			-- ..but the node above knows where the hinge is...
			hinge = get_bits( blockdata2,  {1} );
			-- this node knows if the door is open
			open = get_bits( blockdata,    {4} );
		end


--		-- TODO: open? 0x4: If this bit is set, the door has swung counterclockwise around its hinge.
		if(hinge>0 ) then
			name = name..'_2';
		else
			name = name..'_1';
		end

		local param2 = 0;
		if( dir==0 ) then
			param2 = 3;
		elseif( dir==1 ) then
			param2 = 0;
		elseif( dir==2 ) then
			param2 = 1;
		elseif( dir==3 ) then
			param2 = 2;
		end
		
		return { name, param2 };

	-- TRAPDOOR
	elseif( blockid==96 or blockid==167) then

		-- all these values are needed in order to actually determine the facedir value
		local dir    = get_bits( blockdata, {1,2} );
		-- TODO: this is not really handled by the trapdoor from default
		local on_top = get_bits( blockdata, {8});

		local param2 = dir;
		if(     dir==0 ) then -- on west side
			param2 = 0; 
		elseif( dir==1 ) then -- on south side
			param2 = 2;
		elseif( dir==2 ) then -- on east side
			param2 = 3;
		elseif( dir==3 ) then -- on north side
			param2 = 1;
		end
		-- the opened version is another type
		if( get_bits( blockdata, {4} )) then
			return { blocknames[ blockid ].list[1]..'_open', param2 };
		else
			return { blocknames[ blockid ].list[1], param2 };
		end

	-- BUTTON
	elseif( blockid==77 or blockid==143 ) then
		
		local dir = get_bits( blockdata, {1,2,4} );
		local param2 = 0;
		if(     dir==0 ) then -- facing down
			param2 = 6;
		elseif( dir==5 ) then -- facing up
			param2 = 4;
		elseif( dir==1 ) then -- facing east
			param2 = 1;
		elseif( dir==2 ) then -- facing west
			param2 = 3;
		elseif( dir==3 ) then -- facing south
			param2 = 2;
		elseif( dir==4 ) then -- facing north
			param2 = 0;
		end

		-- TODO: 0x8: if set, the button is active
		return { blocknames[ blockid ].list[1], param2 };

	-- anvil
	elseif( blockid==145 ) then
		-- the anvil can have north/south or east/west direction;
		-- the damage states of the anvil are ignored as those are of no
		-- relevance to the import
		local dir = get_bits( blockdata, {1} );
		return { blocknames[ blockid ].list[1], dir };

	-- ladder
	elseif( blockid==65 ) then

		local dir = get_bits( blockdata, {1,2,4} );
		local param2 = 0;
		if(     dir==3 ) then -- facing south
			param2 = 5;
		elseif( dir==4 ) then -- facing west
			param2 = 3;
		elseif( dir==5 ) then -- facing east
			param2 = 2;
		else -- facing north; default state
			param2 = 4;
		end
		return { blocknames[ blockid ].list[1], param2 };

	-- wall_sign
	elseif( blockid==68 ) then
		local dir = get_bits( blockdata, {1,2,4} );
		local param2 = 0;
		if(     dir==2 ) then -- facing north
			param2 = 0;
		elseif( dir==3 ) then -- facing south
			param2 = 2;
		elseif( dir==4 ) then -- facing west
			param2 = 3;
		elseif( dir==5 ) then -- facing east
			param2 = 1;
		end
		return { blocknames[ blockid ].list[1], param2 };

	elseif( blockid == 63 ) then
		local dir = get_bits( blockdata, {1,2,4,8} );

		-- Important: MC supports signs rotated by 45 degrees; the nodebox used in
		-- mccompat does not support that; thus, the signs are rotated as seems fit
		if(     dir==7  or dir==8  or dir==9 or dir==10) then -- north...
			param2 = 0;
		elseif( dir==15 or dir==0  or dir==1 or dir==2 ) then -- south...
			param2 = 2;
		elseif( dir==3  or dir==4  or dir==5 or dir==6) then -- west
			param2 = 3;
		elseif( dir==11 or dir==12 or dir==13 or dir==14) then -- east
			param2 = 1;
		end
		return { blocknames[ blockid ].list[1], param2 };

	else
		local conv = blocknames[ blockid ];

--		if(     conv[1]==NORMAL or conv[1]==DOOR or conv[1]==GPANE) then
--			return { conv.list[1], 0 };

		-- stairs are translated using a special routine
		if(     conv.stair ) then
                	return mc2mtstairs(conv.list[1], blockdata);

		-- gates never have subtypes
		elseif( conv.gate ) then
			-- 0x4 	0 if the gate is closed, 1 if open; we can ignore that
			return { conv.list[1], get_bits( blockdata, {1,2} )};

		-- the two trapdoors do not have subtypes
		elseif( conv.trapdoor ) then
			-- TODO: not very exact...
			return { conv.list[1], get_bits( blockdata, {1,2} )};

		-- translate facedir...
		elseif( conv.facedir ) then
			return { conv.list[1], mc2mtFacedir3( get_bits( blockdata, {1,2,4})) };


		elseif( conv.multi or #conv.list>1) then
			--local i =  blockdata % (#conv[2]);
			if( conv.list[blockdata] ) then
				return { conv.list[blockdata], 0 };
			elseif( conv.list[0] ) then
				return { conv.list[0], 0 };
			else
				return { conv.list[1], 0 };
			end

		elseif( conv.list and conv.list[1] ) then
			return { conv.list[1], 0 };

		end
	end
	-- fallback
	return {"air", 0};
end
