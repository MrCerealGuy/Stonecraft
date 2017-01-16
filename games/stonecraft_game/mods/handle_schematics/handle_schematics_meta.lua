

handle_schematics.sort_pos_get_size = function( p1, p2 )
	local res = {x=p1.x, y=p1.y, z=p1.z,
			sizex = math.abs( p1.x - p2.x )+1,
			sizey = math.abs( p1.y - p2.y )+1,
			sizez = math.abs( p1.z - p2.z )+1};
	if( p2.x < p1.x ) then
		res.x = p2.x;
	end
	if( p2.y < p1.y ) then
		res.y = p2.y;
	end
	if( p2.z < p1.z ) then
		res.z = p2.z;
	end
	return res;
end



local handle_schematics_get_meta_table = function( pos, all_meta, start_pos )
	local m = minetest.get_meta( pos ):to_table();
	local empty_meta = true;

	-- the inventory part contains functions and cannot be fed to minetest.serialize directly
	local invlist = {};
	local count_inv = 0;
	local inv_is_empty = true;
	for name, list in pairs( m.inventory ) do
		invlist[ name ] = {};
		count_inv = count_inv + 1;
		for i, stack in ipairs(list) do
			if( not( stack:is_empty())) then
				invlist[ name ][ i ] = stack:to_string();
				empty_meta = false;	
				inv_is_empty = false;
			end
		end
	end
	-- the fields part at least is unproblematic
	local count_fields    = 0;
	if( empty_meta and m.fields ) then
		for k,v in pairs( m.fields ) do
			empty_meta = false;
			count_fields = count_fields + 1;
		end
	end

	-- ignore default:sign_wall without text on it
	if(   count_inv==0
	  and count_fields<=3 and m.fields.formspec and m.fields.infotext 
	  and m.fields.formspec == "field[text;;${text}]"
	  and m.fields.infotext == "\"\"") then
		-- also consider signs empty if their text has been set once and deleted afterwards
		if( not( m.fields.text ) or m.fields.text == "" ) then
print('SKIPPING empty sign AT '..minetest.pos_to_string( pos)..' while saving metadata.');
			empty_meta = true;
		end

	elseif( count_inv > 0 and inv_is_empty
	  and count_fields>0 and m.fields.formspec ) then

		local n = minetest.get_node( pos );
		if( n and n.name
		  and (n.name=='default:chest' or n.name=='default:chest_locked' or n.name=='default:bookshelf'
		    or n.name=='default:furnace' or n.name=='default:furnace_active'
		    or n.name=='cottages:shelf' or n.name=='cottages:anvil' or n.name=='cottages:threshing_floor' )) then
print('SKIPPING empty '..tostring(n.name)..' AT '..minetest.pos_to_string( pos )..' while saving metadata.');
			empty_meta = true;
		end
	end

					
	-- only save if there is something to be saved
	if( not( empty_meta )) then
		-- positions are stored as relative positions
		all_meta[ #all_meta+1 ] = {
			x=pos.x-start_pos.x,
			y=pos.y-start_pos.y,
			z=pos.z-start_pos.z,
			fields = m.fields,
			inventory = invlist};
	end
end

-- reads metadata values from start_pos to end_pos and stores them in a file
handle_schematics.save_meta = function( start_pos, end_pos, filename )
	local all_meta = {};
	local p = handle_schematics.sort_pos_get_size( start_pos, end_pos );

	if( minetest.find_nodes_with_meta ) then
		for _,pos in ipairs( minetest.find_nodes_with_meta( start_pos, end_pos )) do
			handle_schematics_get_meta_table( pos, all_meta, p );
		end
	else
		for x=p.x, p.x+p.sizex do
			for y=p.y, p.y+p.sizey do
				for z=p.z, p.z+p.sizez do
					handle_schematics_get_meta_table( {x=x-p.x, y=y-p.y, z=z-p.z}, all_meta, p );
				end
			end
		end
	end

	if( #all_meta > 0 ) then
		save_restore.save_data( 'schems/'..filename..'.meta', all_meta );
	end
end

-- all metadata values will be deleted when this function is called,
-- making the area ready for new voxelmanip/schematic data
handle_schematics.clear_meta = function( start_pos, end_pos )
	local empty_meta = { inventory = {}, fields = {} };

	if( minetest.find_nodes_with_meta ) then
		for _,pos in ipairs( minetest.find_nodes_with_meta( start_pos, end_pos )) do
			local meta = minetest.get_meta( pos );
			meta:from_table( empty_meta );
		end	
	end
end


-- restore metadata from file
-- TODO: use relative instead of absolute positions (already done for .we files)
-- TODO: handle mirror
handle_schematics.restore_meta = function( filename, all_meta, start_pos, end_pos, rotate, mirror )

	if( not( all_meta ) and filename ) then
		all_meta = save_restore.restore_data( filename..'.meta' );
	end
	for _,pos in ipairs( all_meta ) do
		local p = {};
		if(     rotate == 0 ) then
			p = {x=start_pos.x+pos.x-1, y=start_pos.y+pos.y-1, z=start_pos.z+pos.z-1};
		elseif( rotate == 1 ) then
			p = {x=start_pos.x+pos.z-1, y=start_pos.y+pos.y-1, z=end_pos.z  -pos.x+1};
		elseif( rotate == 2 ) then
			p = {x=end_pos.x  -pos.x+1, y=start_pos.y+pos.y-1, z=end_pos.z  -pos.z+1};
		elseif( rotate == 3 ) then
			p = {x=end_pos.x  -pos.z+1, y=start_pos.y+pos.y-1, z=start_pos.z+pos.x-1};
		end
		local meta = minetest.get_meta( p );
		meta:from_table( {inventory = pos.inventory, fields = pos.fields });
	end
end


-- return true on success; will overwrite existing files
handle_schematics.create_schematic_with_meta = function( p1, p2, base_filename )

	-- create directory for the schematics (same path as WorldEdit uses)
	save_restore.create_schems_directory();
	local complete_filename = minetest.get_worldpath()..'/schems/'..base_filename..'.mts';
	-- actually create the schematic
	minetest.create_schematic( p1, p2, nil, complete_filename, nil);
	-- save metadata; the file will only be created if there is any metadata that is to be saved
	handle_schematics.save_meta( p1, p2, base_filename );

	return save_restore.file_exists( complete_filename );
end
