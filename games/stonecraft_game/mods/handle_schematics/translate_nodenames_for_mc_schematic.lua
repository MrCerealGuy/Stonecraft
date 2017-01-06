
-- based on:
-- # Minecraft to Minetest WE schematic MCEdit filter
-- # by sfan5

-- #blockdata -1 means ignore
local P2_IGNORE = -1;
-- #blockdata -2 means copy without change
local P2_COPY   = -2;
-- #blockdata -3 means copy and convert the mc facedir value to mt facedir
local P2_CONVERT= -3;
-- #blockdata -4 is for stairs to support upside down ones
local P2_STAIR  = -4;
-- #blockdata selects one of the listed subtypes
local P2_SELECT = -5;

-- #Reference MC: http://media-mcw.cursecdn.com/8/8c/DataValuesBeta.png
-- #Reference MT:
-- # https://github.com/minetest/common/blob/master/mods/default/init.lua
-- # https://github.com/minetest/common/blob/master/mods/wool/init.lua
-- # https://github.com/minetest/common/blob/master/mods/stairs/init.lua
local conversionTable = {
	-- #blockid blockdata minetest-nodename

--	[0]  = {P2_IGNORE, "air"},
	[1]  = {P2_IGNORE, "default:stone"}, 
		-- 0: stone; 1: granite; 2: polished granite;
		-- 3: diorite; 4: polished diorite; 5: andesite;
		-- 6: polished andesite
	[2]  = {P2_IGNORE, "default:dirt_with_grass"},
	[3]  = {P2_IGNORE, "default:dirt"}, 
		-- 0: dirt; 1: coarse dirt; 2: podzol
	[4]  = {P2_IGNORE, "default:cobble"},
	[5]  = {P2_SELECT, {	[0]="default:wood",
				[1]="moretrees:spruce_planks",
				[2]="moretrees:birch_planks",
				[3]="default:junglewood",
				[4]="moretrees:acacia_planks",
				[5]="moretrees:oak_planks"}},
	[6]  = {P2_SELECT, {	[0]="default:wood",
				[1]="moretrees:spruce_sapling",
				[2]="moretrees:birch_sapling",
				[3]="default:junglesapling",
				[4]="moretrees:acacia_sapling",
				[5]="moretrees:oak_sapling"}},
	[7]  = {P2_IGNORE, "minecraft:bedrock"}, --# FIXME Bedrock
	[8]  = {P2_IGNORE, "default:water_flowing"},
	[9]  = {P2_IGNORE, "default:water_source"},
	[10] = {P2_IGNORE, "default:lava_flowing"},
	[11] = {P2_IGNORE, "default:lava_source"},
	[12] = {P2_SELECT, {	[0]="default:sand",
				[1]="default:desert_sand"}},
	[13] = {P2_IGNORE, "default:gravel"},
	[14] = {P2_IGNORE, "default:stone_with_gold"},
	[15] = {P2_IGNORE, "default:stone_with_iron"},
	[16] = {P2_IGNORE, "default:stone_with_coal"},
	-- TODO: the trees have facedir
	[17] = {P2_SELECT, {	[0]="default:tree",
				[1]="moretrees:spruce_trunk",
				[2]="moretrees:birch_trunk",
				[3]="default:jungletree",
				[4]="moretrees:acacia_trunk",
				[5]="moretrees:oak_trunk"}},
	[18] = {P2_SELECT, {	[0]="default:leaves",
				[1]="moretrees:spruce_leaves",
				[2]="moretrees:birch_leaves",
				[3]="default:jungleleaves",
				[4]="default:leaves",
				[5]="moretrees:spruce_leaves",
				[6]="moretrees:birch_leaves",
				[7]="default:jungleleaves",
				[8]="default:leaves",
				[9]="moretrees:spruce_leaves",
				[10]="moretrees:birch_leaves",
				[11]="default:jungleleaves",
				[12]="default:leaves",
				[13]="moretrees:spruce_leaves",
				[14]="moretrees:birch_leaves",
				[15]="default:jungleleaves"}},
	[19] = {P2_CONVERT,"minecraft:sponge"},
	[20] = {P2_IGNORE, "default:glass"},
	[21] = {P2_IGNORE, "default:stone_with_copper"}, -- Lapis Lazuli Ore
	[22] = {P2_IGNORE, "default:copperblock"}, -- Lapis Lazuli Block
	[23] = {P2_CONVERT,"minecraft:dispenser"},
	[24] = {P2_SELECT, {	[0]="default:sandstone",
				[1]="default:sandstonebrick",
				[2]="default:sandstone"}},
	[25] = {P2_CONVERT,"minecraft:nodeblock"},
	[26] = {P2_CONVERT,"beds:bed"}, -- TODO: might require special handling?
	[27] = {P2_CONVERT,"minecraft:golden_rail"},
	[28] = {P2_CONVERT,"minecraft:detector_rail"},
-- 29: sticky piston
	[30] = {P2_CONVERT,"minecraft:web"},
	[31] = {P2_SELECT, {	[0]="default:dry_shrub",
			        [1]="default:grass_4",
			        [2]="ferns:fern_02"}},
	[32] = {P2_IGNORE, "default:dry_shrub"},
-- 34: piston head
	[35] = {P2_SELECT, {	[0]="wool:white",
			        [1]="wool:orange",
				[2]="wool:magenta",
				[3]="wool:light_blue",
			        [4]="wool:yellow",
			        [5]="wool:green",
			        [6]="wool:pink",
			        [7]="wool:dark_grey",
			        [8]="wool:grey",
			        [9]="wool:cyan",
			        [10]="wool:violet",
			        [11]="wool:blue",
			        [12]="wool:brown",
			        [13]="wool:dark_green",
			        [14]="wool:red",
			        [15]="wool:black"}},
-- 36: piston extension
	[37] = {P2_IGNORE, "flowers:dandelion_yellow"},
	[38] = {P2_SELECT, {	[0]="flowers:rose",
				[1]="flowers:geranium",
				[2]="flowers:viola",
				[3]="flowers:dandelion_white",
				[4]="tulips:red",
				[5]="flowers:tulip",
				[6]="tulips:white",
				[7]="tulips:pink",
				[8]="tulips:black"}},
	[41] = {P2_IGNORE, "default:goldblock"},
	[42] = {P2_IGNORE, "default:steelblock"},
	-- double stone slabs...full blocks?
	[43] = {P2_SELECT, {	[0]="default:stone",
				[1]="default:sandstonebrick",
			        [2]="default:wood",
			        [3]="default:cobble",
			        [4]="default:brick",
			        [5]="default:stonebrick",
			        [6]="nether:brick",
			        [7]="quartz:quartz",
			        [8]="moreblocks:split_stone_tile",
			        [9]="default:sandstone"}},
	[44] = {P2_SELECT, {	[0]="stairs:slab_stone",
			        [1]="stairs:slab_sandstone",
			        [2]="stairs:slab_wood",
			        [3]="stairs:slab_cobble",
			        [4]="stairs:slab_brick",
			        [5]="stairs:slab_stonebrick",
				[6]="stairs:slab_nether",
				[7]="stairs:slab_quartz", 
			        [8]="stairs:slab_stoneupside_down",
			        [9]="stairs:slab_sandstoneupside_down",
			        [10]="stairs:slab_woodupside_down",
			        [11]="stairs:slab_cobbleupside_down",
			        [12]="stairs:slab_brickupside_down",
			        [13]="stairs:slab_stonebrickupside_down",
			        [14]="stairs:slab_netzerupside_down",
			        [15]="stairs:slab_quartzupside_down"}},
	[45] = {P2_IGNORE, "default:brick"},
	[46] = {P2_CONVERT,"tnt:tnt"},
	[47] = {P2_IGNORE, "default:bookshelf"},
	[48] = {P2_IGNORE, "default:mossycobble"},
	[49] = {P2_IGNORE, "default:obsidian"},
	[50] = {P2_CONVERT,"default:torch"},
	[51] = {P2_IGNORE, "fire:basic_flame"},
	[52] = {P2_CONVERT,"minecraft:mob_spawner"},
	[53] = {P2_STAIR,  "stairs:stair_wood"},
	[54] = {P2_IGNORE, "default:chest"},
	[56] = {P2_IGNORE, "default:stone_with_diamond"},
	[57] = {P2_IGNORE, "default:diamondblock"},
	[58] = {P2_CONVERT,"minecraft:crafting_table"},
	[59] = {P2_IGNORE, "farming:wheat_8"},
	[60] = {P2_IGNORE, "farming:soil_wet"},
	[61] = {P2_IGNORE, "default:furnace"},
	[62] = {P2_IGNORE, "default:furnace_active"},
	[63] = {P2_IGNORE, "default:sign_wall"},
	[64] = {P2_IGNORE, "doors:door_wood_t_1"},
	[65] = {P2_IGNORE, "default:ladder"},
	[66] = {P2_IGNORE, "default:rail"},
	[67] = {P2_STAIR,  "stairs:stair_cobble"},
	[68] = {P2_CONVERT,"default:sign_wall"},
	[71] = {P2_IGNORE, "doors:door_steel_t_1"},
	[78] = {P2_IGNORE, "default:snow"},
	[79] = {P2_IGNORE, "default:ice"},
	[80] = {P2_IGNORE, "default:snowblock"},
	[81] = {P2_IGNORE, "default:cactus"},
	[82] = {P2_IGNORE, "default:clay"},
	[83] = {P2_IGNORE, "default:papyrus"},
	[84] = {P2_CONVERT,"minecraft:jukebox"},
	[85] = {P2_IGNORE, "default:fence_wood"},
	[86] = {P2_CONVERT,"farming:pumpkin"},
	[91] = {P2_CONVERT,"farming:pumpkin_face_light"},
	[92] = {P2_CONVERT,"minecraft:cake"},
	[95] = {P2_IGNORE, "minecraft:stained_glass"}, -- TODO
	[96] = {P2_CONVERT,"doors:trapdoor"},
	[97] = {P2_IGNORE, "minecraft:monster_egg"},
	[98] = {P2_IGNORE, "default:stonebrick"},
	[108]= {P2_STAIR,  "stairs:stair_brick"},
	[109]= {P2_CONVERT,"stairs:stair_stonebrick"},
	-- TODO: double ... wood slab...
	[125]= {P2_SELECT, {	[0]="default:wood",
				[1]="moretrees:spruce_planks",
				[2]="moretrees:birch_planks",
				[3]="default:junglewood",
				[4]="moretrees:acacia_planks",
				[5]="moretrees:oak_planks"}},
	[125]= {P2_IGNORE, "default:wood"},
	[126]= {P2_SELECT, {	[0]="stairs:slab_wood",
				[1]="stairs:slab_spruce_planks",
				[2]="stairs:slab_birch_planks",
				[3]="stairs:slab_junglewood",
				[4]="stairs:slab_acacia_planks",
				[5]="stairs:slab_oak_planks",
				[8]="stairs:slab_woodupside_down",
				[9]="stairs:slab_spruce_planksupside_down",
				[10]="stairs:slab_birch_planksupside_down",
				[11]="stairs:slab_junglewoodupside_down",
				[12]="stairs:slab_acacia_planksupside_down",
				[13]="stairs:slab_oak_planksupside_down"}},
	[126]= {P2_IGNORE, "stairs:slab_wood"},
	[128]= {P2_STAIR,  "stairs:stair_sandstone"},
	[129]= {P2_IGNORE, "default:stone_with_mese"},
	[133]= {P2_IGNORE, "default:mese"},
	[134]= {P2_STAIR,  "stairs:stair_wood"},
	[135]= {P2_STAIR,  "stairs:stair_wood"},
	[136]= {P2_STAIR,  "stairs:stair_junglewood"},

--	#Mesecons section
--	# Reference: https://github.com/Jeija/minetest-mod-mesecons/blob/master/mesecons_alias/init.lua
	[25] = {P2_IGNORE, "mesecons_noteblock:noteblock"},
	[29] = {P2_CONVERT,"mesecons_pistons:piston_sticky_off"},
	[33] = {P2_CONVERT,"mesecons_pistons:piston_normal_off"},
	[55] = {P2_IGNORE, "mesecons:wire_00000000_off"},
	[69] = {P2_CONVERT,"mesecons_walllever:wall_lever_off"},
	[70] = {P2_IGNORE, "mesecons_pressureplates:pressure_plate_stone_off"},
	[72] = {P2_IGNORE, "mesecons_pressureplates:pressure_plate_wood_off"},
	[73] = {P2_IGNORE, "default:stone_with_mese"},
	[74] = {P2_IGNORE, "default:stone_with_mese"},
	[75] = {P2_CONVERT,"mesecons_torch:torch_off"},
	[76] = {P2_CONVERT,"mesecons_torch:torch_on"},
	[77] = {P2_CONVERT,"mesecons_button:button_off"},
	[93] = {P2_CONVERT,"mesecons_delayer:delayer_off_1"},
	[94] = {P2_CONVERT,"mesecons_delayer:delayer_on_1"},
	-- see mod https://github.com/doyousketch2/stained_glass
	[95] = {P2_SELECT, {	[0]="default:glass", -- TODO
			        [1]="stained_glass:orange__",
				[2]="stained_glass:magenta__",
				[3]="stained_glass:skyblue__",
			        [4]="stained_glass:yellow__",
			        [5]="stained_glass:lime__",
			        [6]="stained_glass:redviolet__",
			        [7]="stained_glass:dark_grey__", -- TODO
			        [8]="stained_glass:grey__", -- TODO
			        [9]="stained_glass:cyan__",
			        [10]="stained_glass:violet__",
			        [11]="stained_glass:blue__",
			        [12]="stained_glass:orange_dark_",
			        [13]="stained_glass:green__",
			        [14]="stained_glass:red__",
			        [15]="stained_glass:black__"}}, -- TODO
	[101]= {P2_CONVERT,"xpanes:bar"},
	[102]= {P2_CONVERT,"xpanes:pane"},
	[103]= {P2_IGNORE, "farming:melon"},
	[104]= {P2_IGNORE, "minecraft:pumpkin_stem"},
	[105]= {P2_IGNORE, "minecraft:melon_stem"},
	[106]= {P2_CONVERT,"vines:vine"},
	[107]= {P2_CONVERT,"minecraft:fence_gate"},
	[108]= {P2_STAIR,  "stairs:stair_brick"},
	[109]= {P2_STAIR,  "stairs:stair_stonebrick"},
	[110]= {P2_CONVERT,"minecraft:mycelium"},
	[111]= {P2_CONVERT,"flowers:waterlily"},
	[112]= {P2_CONVERT,"minecraft:nether_brick"},
	[113]= {P2_CONVERT,"minecraft:nether_brick_fence"},
	[114]= {P2_CONVERT,"minecraft:nether_brick_stairs"},
	[115]= {P2_CONVERT,"minecraft:nether_wart"},
	[116]= {P2_CONVERT,"minecraft:enchanting_table"},
	[117]= {P2_CONVERT,"minecraft:brewing_stand"},
	[118]= {P2_CONVERT,"minecraft:cauldron"},
	[119]= {P2_CONVERT,"minecraft:end_portal"},
	[120]= {P2_CONVERT,"minecraft:end_portal_frame"},
	[121]= {P2_CONVERT,"minecraft:end_stone"},
	[122]= {P2_CONVERT,"minecraft:dragon_egg"},
	[123]= {P2_IGNORE, "mesecons_lightstone_red_off"},
	[124]= {P2_IGNORE, "mesecons_lightstone_red_on"},
	[125]= {P2_CONVERT,"minecraft:double_wooden_slab"},
	[126]= {P2_CONVERT,"stairs:slab_wood"},
	[127]= {P2_CONVERT,"farming_plus:cocoa"},
	[137]= {P2_IGNORE, "mesecons_commandblock:commandblock_off"},
	[151]= {P2_IGNORE, "mesecons_solarpanel:solar_panel_off"},
	[152]= {P2_IGNORE, "default:mese"},
	-- see mod https://github.com/tenplus1/bakedclay
	[159] = {P2_SELECT, {	[0]="bakedclay:white",
			        [1]="bakedclay:orange",
				[2]="bakedclay:magenta",
				[3]="bakedclay:light_blue", -- TODO
			        [4]="bakedclay:yellow",
			        [5]="bakedclay:green",
			        [6]="bakedclay:pink",
			        [7]="bakedclay:dark_grey",
			        [8]="bakedclay:grey",
			        [9]="bakedclay:cyan",
			        [10]="bakedclay:violet",
			        [11]="bakedclay:blue",
			        [12]="bakedclay:brown",
			        [13]="bakedclay:dark_green",
			        [14]="bakedclay:red",
			        [15]="bakedclay:black"}},
	-- see mod mccarpet https://forum.minetest.net/viewtopic.php?t=7419
	[171] = {P2_SELECT, {	[0]="mccarpet:white",
			        [1]="mccarpet:orange",
				[2]="mccarpet:magenta",
				[3]="mccarpet:light_blue", -- TODO
			        [4]="mccarpet:yellow",
			        [5]="mccarpet:green",
			        [6]="mccarpet:pink",
			        [7]="mccarpet:dark_grey",
			        [8]="mccarpet:grey",
			        [9]="mccarpet:cyan",
			        [10]="mccarpet:violet",
			        [11]="mccarpet:blue",
			        [12]="mccarpet:brown",
			        [13]="mccarpet:dark_green",
			        [14]="mccarpet:red",
			        [15]="mccarpet:black"}},
	[181] = {P2_SELECT, {	[0]="default:desert_stonebrick",
				[1]="default:desertstone"}},
	
--	#Nether section
--	# Reference: https://github.com/PilzAdam/nether/blob/master/init.lua
	[43] = {P2_IGNORE, "nether:brick"},
	[87] = {P2_IGNORE, "nether:rack"},
	[88] = {P2_IGNORE, "nether:sand"},
	[89] = {P2_IGNORE, "nether:glowstone"},
	[90] = {P2_CONVERT,"nether:portal"},

--	#Riesenpilz Section
--	# Reference: https://github.com/HybridDog/riesenpilz/blob/master/init.lua
	[39] = {P2_IGNORE, "riesenpilz:brown"},
	[40] = {P2_IGNORE, "riesenpilz:red"},
	[99] = {P2_CONVERT,"riesenpilz:head_brown"},
	[100]= {P2_CONVERT,"riesenpilz:head_brown"},
}


local mc2mtFacedir = function(blockdata)
--	#Minetest
--	# x+ = 2
--	# x- = 3
--	# z+ = 1
--	# z- = 0
--	#Minecraft
--	# x+ = 3
--	# x- = 1
--	# z+ = 0
--	# z- = 2
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

local mc2mtstairs = function( name, blockdata)
	if blockdata >= 4 then
		return {name.. "upside_down", mc2mtFacedir(blockdata - 4)}
	else
		return {name, mc2mtFacedir(blockdata)}
	end
end


-- returns {translated_node_name, translated_param2}
handle_schematics.findMC2MTConversion = function(blockid, blockdata)
	if (blockid == 0 ) then
		return {"air",0};
	-- fallback
	elseif( not( conversionTable[ blockid ])) then
		return { "minecraft:"..tostring( blockid )..'_'..tostring( blockdata ), 0};
	end
	local conv = conversionTable[ blockid ];
	if(     conv[1] == P2_IGNORE ) then
		return { conv[2], 0};
	elseif( conv[1] == P2_COPY   ) then
		return { conv[2], blockdata};
	elseif( conv[1] == P2_CONVERT) then
		return { conv[2], mc2mtFacedir(blockdata)};
	elseif( conv[1] == P2_STAIR  ) then
		return mc2mtstairs(conv[2], blockdata);
	elseif( conv[1] == P2_SELECT
	    and conv[2][ blockdata ] ) then
		return { conv[2][ blockdata ], 0};
	elseif( conv[1] == P2_SELECT
	    and not(conv[2][ blockdata ] )) then
		return { conv[2][0], 0};
	else
		return { conv[2], 0 };
	end
	return {air, 0};
end
