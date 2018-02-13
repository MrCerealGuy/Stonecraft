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
	end
	replacements_group['mineclone2'].replace_one( 'default:torch', 'mcl_torches:torch');
	replacements_group['mineclone2'].replace_one( 'default:torch_wall', 'mcl_torches:torch_wall');
	replacements_group['mineclone2'].replace_one( 'default:furnace', 'mcl_furnaces:furnace');
	replacements_group['mineclone2'].replace_one( 'default:ladder_wood', 'mcl_core:ladder');
	replacements_group['mineclone2'].replace_one( 'default:sign_wall_wood', 'mcl_signs:wall_sign');
	replacements_group['mineclone2'].replace_one( 'default:bookshelf', 'mcl_books:bookshelf');
	replacements_group['mineclone2'].replace_one( 'default:chest', 'mcl_chests:chest');
	-- MineClone2 has no locked chests
	replacements_group['mineclone2'].replace_one( 'default:chest_locked', 'mcl_chests:chest');
end

-- needs to be called once after handle_schematics.is_mineclone2 is set
replacements_group['mineclone2'].setup_global_replacements();
