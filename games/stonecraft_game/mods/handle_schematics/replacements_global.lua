
-- Note: If you are using handle_schematics.global_replacement_table, please also take into
--       account that you might have to add nodes to other tables, in particular:
--          * handle_schematics.direct_instead_of_drop
--          * handle_schematics.player_can_provide
--          * handle_schematics.bed_node_namess
--          * call handle_schematics.add_mirrored_node_type(..) where needed

-- allows to store global replacements (needed for subgames that do not provide a default mod)
handle_schematics.global_replacement_table = {};

handle_schematics.replace_global = function( node_name )
	if( not( node_name )) then
		return;
	end
	if( handle_schematics.global_replacement_table[ node_name ] ) then
		return handle_schematics.global_replacement_table[ node_name ];
	end
	return node_name;
end

handle_schematics.node_defined = function( node_name )
	if( not( node_name ) or node_name == "" ) then
		return;
	end
	if( handle_schematics.global_replacement_table[ node_name ] ) then
		return minetest.registered_nodes[ handle_schematics.global_replacement_table[ node_name ]];
	end
	return minetest.registered_nodes[ node_name ];
end


-- just some examples for testing:
--handle_schematics.global_replacement_table[ 'default:wood' ] = 'default:mese';
--handle_schematics.global_replacement_table[ 'stairs:stair_wood' ] = 'default:diamondblock';

-- many people prefer the new 3d torch even if it will melt some snow
handle_schematics.global_replacement_table[ 'mg_villages:torch' ] = 'default:torch';
