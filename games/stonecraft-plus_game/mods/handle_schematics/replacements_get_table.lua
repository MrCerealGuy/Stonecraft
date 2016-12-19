-- mapgen based replacements work best using a table, while minetest.place_schematic(..) based spawning needs a list
handle_schematics.get_replacement_table = function( housetype, pr, replacements )

	local rtable = {};
	local ids    = {};
	if( not( replacements ) and mg_villages and mg_villages.get_replacement_list) then
		replacements = mg_villages.get_replacement_list( housetype, pr );
	end
	-- it is very problematic if the torches on houses melt snow and cause flooding; thus, we use a torch that is not hot
	if( minetest.registered_nodes[ 'mg_villages:torch']) then
		table.insert( replacements, {'default:torch', 'mg_villages:torch'});
	end
	for i,v in ipairs( replacements ) do
		if( v and #v == 2 ) then
			rtable[ v[1] ] = v[2];
			ids[ minetest.get_content_id( v[1] )] = minetest.get_content_id( v[2] );
		end
	end
        return { table = rtable, list = replacements, ids = ids };
end

