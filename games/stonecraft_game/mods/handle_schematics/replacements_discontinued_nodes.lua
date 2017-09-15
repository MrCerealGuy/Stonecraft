replacements_group['discontinued_nodes'] = {}

replacements_group['discontinued_nodes'].doors = function( repl, door_type)
	if( not( door_type )) then
		return repl;
	end
	-- the upper part is no longer a seperate part
	table.insert( repl, {'doors:door_'..door_type..'_t_1',  'doors:hidden'});
	table.insert( repl, {'doors:door_'..door_type..'_t_2',  'doors:hidden'});
	-- the lower part is now two nodes high
	table.insert( repl, {'doors:door_'..door_type..'_b_1',  'doors:door_'..door_type..'_a'});
	table.insert( repl, {'doors:door_'..door_type..'_b_2',  'doors:door_'..door_type..'_b'});
	return repl;
end

replacements_group['discontinued_nodes'].replace = function( replacements ) 
	
	local repl = {};

	-- doors changed from two nodes for a door to one two-node-high mesh
	replacements_group['discontinued_nodes'].doors( repl, 'wood' );
	replacements_group['discontinued_nodes'].doors( repl, 'steel' ); 
	replacements_group['discontinued_nodes'].doors( repl, 'glass' );
	replacements_group['discontinued_nodes'].doors( repl, 'obsidian_glass');

	for i,v in ipairs( repl ) do
		if( v and v[2] and handle_schematics.node_defined( v[2]) ) then
			local found = false;
			for j,w in ipairs( replacements ) do
				if( w and w[1] and w[1]==v[1] ) then
					w[2] = v[2];
					found = true;
				end
			end
			if( not( found )) then
				table.insert( replacements, {v[1],v[2]} );
			end
		end
	end
	return replacements;
end
		
