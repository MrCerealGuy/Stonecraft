replacements_group['mineclone2'] = {}

-- parameter: replacements, name_in_default, name_in_mineclone2, to_mineclone2=true/false
replacements_group['mineclone2'].replace_one = function( def, mcl2)
	if( handle_schematics.is_mineclone2 ) then
		handle_schematics.global_replacement_table[ def ] = mcl2;
	else
		handle_schematics.global_replacement_table[ mcl2 ] = def;
	end
end

replacements_group['mineclone2'].setup_global_replacements = function() 
	local simple_translation = {"stone","stone_with_coal","stone_with_iron","stone_with_gold",
		"stone_with_diamond", "stonebrick",
		"dirt_with_grass","dirt_with_dry_grass","dirt","gravel","sand","sandstone",
		"clay","cobble","mossycobble","coalblock","ironblock","goldblock","diamondblock",
		"obsidian","ice","cactus","ladder","glass",
		"water_flowing","water_source","lava_flowing","lava_source",

		};
	for i,k in ipairs( simple_translation ) do
		replacements_group['mineclone2'].replace_one( 'default:'..k, 'mcl_core:'..k);
		if( minetest.registered_nodes[ 'stairs:stair_'..k ]) then
			replacements_group['mineclone2'].replace_one( 'stairs:stair_'..k, 'mcl_stairs:stair_'..k);
			replacements_group['mineclone2'].replace_one( 'stairs:stair_inner_'..k, 'mcl_stairs:stair_'..k..'_inner');
			replacements_group['mineclone2'].replace_one( 'stairs:slab_'..k, 'mcl_stairs:slab_'..k);
		end
	end
	replacements_group['mineclone2'].replace_one( 'default:brick', 'mcl_core:brick_block');
	replacements_group['mineclone2'].replace_one( 'stairs:stair_brick', 'mcl_stairs:stair_brick_block');
	replacements_group['mineclone2'].replace_one( 'stairs:stair_inner_brick', 'mcl_stairs:stair_brick_block_inner');
	replacements_group['mineclone2'].replace_one( 'stairs:slab_brick', 'mcl_stairs:slab_brick_block');

	replacements_group['mineclone2'].replace_one( 'default:torch', 'mcl_torches:torch');
	replacements_group['mineclone2'].replace_one( 'default:torch_wall', 'mcl_torches:torch_wall');
	replacements_group['mineclone2'].replace_one( 'default:furnace', 'mcl_furnaces:furnace');
	replacements_group['mineclone2'].replace_one( 'default:ladder_wood', 'mcl_core:ladder');
	replacements_group['mineclone2'].replace_one( 'default:sign_wall_wood', 'mcl_signs:wall_sign');
	replacements_group['mineclone2'].replace_one( 'default:bookshelf', 'mcl_books:bookshelf');
	replacements_group['mineclone2'].replace_one( 'default:meselamp', 'mcl_nether:glowstone');
	-- MineClone2 has no locked chests
	replacements_group['mineclone2'].replace_one( 'default:chest_locked', 'mcl_chests:chest');
	replacements_group['mineclone2'].replace_one( 'default:chest', 'mcl_chests:chest');
	replacements_group['mineclone2'].replace_one( 'default:chest', 'mcl_chests:chest_left');
	replacements_group['mineclone2'].replace_one( 'default:chest', 'mcl_chests:chest_right');
	-- further replacements
	replacements_group['mineclone2'].replace_one( 'doors:trapdoor_open', 'mcl_doors:trapdoor_open');
	replacements_group['mineclone2'].replace_one( 'doors:trapdoor', 'mcl_doors:trapdoor');
	replacements_group['mineclone2'].replace_one( 'doors:trapdoor_steel_open', 'mcl_doors:iron_trapdoor_open');
	replacements_group['mineclone2'].replace_one( 'doors:trapdoor_steel', 'mcl_doors:iron_trapdoor');
	replacements_group['mineclone2'].replace_one( 'xpanes:pane_flat', 'xpanes:pane_natural_flat');
	replacements_group['mineclone2'].replace_one( 'farming:soil_wet', 'mcl_farming:soil_wet');
	replacements_group['mineclone2'].replace_one( 'farming:soil', 'mcl_farming:soil');
	replacements_group['mineclone2'].replace_one( 'farming:wheat_8', 'mcl_farming:wheat');
	replacements_group['mineclone2'].replace_one( 'default:grass_5', 'mcl_flowers:tallgrass');
	replacements_group['mineclone2'].replace_one( 'flowers:dandelion_white', 'mcl_flowers:tulip_white');
	replacements_group['mineclone2'].replace_one( 'flowers:dandelion_yellow', 'mcl_flowers:dandelion');
	replacements_group['mineclone2'].replace_one( 'flowers:dandelion_yellow', 'mcl_flowers:oxeye_daisy');
	replacements_group['mineclone2'].replace_one( 'flowers:geranium', 'mcl_flowers:blue_orchid');
	replacements_group['mineclone2'].replace_one( 'flowers:rose', 'mcl_flowers:tulip_red');
	replacements_group['mineclone2'].replace_one( 'flowers:rose', 'mcl_flowers:poppy');
	replacements_group['mineclone2'].replace_one( 'flowers:viola', 'mcl_flowers:azure_bluet');
	replacements_group['mineclone2'].replace_one( 'flowers:waterlily', 'mcl_flowers:waterlily');
-- TODO: carrot
-- TODO: potato
-- TODO: mcl_flowerpots:flowerpot
	replacements_group['mineclone2'].replace_one( 'carts:rail', 'mcl_minecarts:rail');
	replacements_group['mineclone2'].replace_one( 'beds:bed_bottom', 'mcl_beds:bed_red_bottom');
	replacements_group['mineclone2'].replace_one( 'beds:bed_top', 'mcl_beds:bed_red_top');
	-- no real equivalents...
	replacements_group['mineclone2'].replace_one( 'default:gravel', 'mcl_core:grass_path');
	replacements_group['mineclone2'].replace_one( 'default:dirt_with_coniferous_litter', 'mcl_core:podzol');
	replacements_group['mineclone2'].replace_one( 'default:dirt_with_rainforest_litter', 'mcl_core:coarse_dirt');
	-- TODO
	replacements_group['mineclone2'].replace_one( 'default:fence_wood', 'mcl_fences:fence');
	replacements_group['mineclone2'].replace_one( 'doors:gate_wood_closed', 'mcl_fences:fence_gate');
	-- TODO: mcl_fences:spruce_fence, mcl_fences:gate_aspen_wood_closed, mcl_doors:spruce_door_b_1
	-- TODO: mcl_stairs:slab_wood_top
end

-- needs to be called once after handle_schematics.is_mineclone2 is set
replacements_group['mineclone2'].setup_global_replacements();
