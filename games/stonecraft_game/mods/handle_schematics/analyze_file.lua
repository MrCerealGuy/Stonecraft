-- helper functions for ships submerged below water;
-- this one fills a node with water (or more preceisely: ignore) if it
-- has one water node at one side, or above, or is located at one side
-- on a submerged level
local floodfill_one_spot = function( res, air_id, ignore_table, x, y, z)
	if( res.scm_data_cache[y][x][z]) then
		return;
	end
	-- water flows in from the sides
	if( x==1 or x==res.size.x or z==1 or z==res.size.z) then
		res.scm_data_cache[y][x][z] = ignore_table;
	-- or if there is at least one neighbour filled with water
	elseif( res.scm_data_cache[y+1][x][z] == ignore_table
	     or res.scm_data_cache[y][x+1][z] == ignore_table
	     or res.scm_data_cache[y][x-1][z] == ignore_table
	     or res.scm_data_cache[y][x+1][z] == ignore_table
	     or res.scm_data_cache[y][x][z-1] == ignore_table
	     or res.scm_data_cache[y][x][z+1] == ignore_table) then
		res.scm_data_cache[y][x][z] = ignore_table;
	end
end


-- check which parts of the schematic will have to be ignore due to beeing
-- water flowing around
local floodfill_with_ignore = function( res, air_id, ignore_table )
	-- from water surface level downward
	for y=-1*res.yoff + 1, 1, -1 do
		for x=1, res.size.x do
		for z=1, res.size.z do
			floodfill_one_spot( res, air_id, ignore_table, x, y, z);
		end
		end
	end
	-- and now from the opposite side so that water may reach corners it
	-- didn't reach previously
	for y=-1*res.yoff + 1, 1, -1 do
		for z=res.size.z, 1, -1 do
		for x=res.size.x, 1, -1 do
			floodfill_one_spot( res, air_id, ignore_table, x, y, z);
		end
		end
	end
	-- Note: For a complete fill, more runs would be necessary. With these
	--       calls here, most of the nodes get covered. The small remaining
	--       rest can be handled by real water.
end

-- read .mts (minetest schematic), .we (WorldEdit) and .schematic (MC schematic format) files
-- 	file_name:     file name with full path but without file name exstension
--	origin_offset: .we files may have this defined if their start is not at 0,0,0
--	store_as_mts:  if set to true: convert files of any other types and store them
--	               as .mts files additionally (speeds up usage at later server starts)
--	building_data: Table that may contain additional information about the building; in particular:
--	                     orients:  list of allowed rotations for this schematic; may be {0,1,2,3}
--	                               for a building that looks at a street ok no matter how it is rotated;
--	                               may be set to i.e. {2} if the building is initially rotated by 180
--	                               degree and has a front door
--	                     yoff:     How deep is the building burried? Automaticly determined for .mts
--	                               files created by this mod but otherwise ought to be provided.
--	               Entries of this table are returned in the return value if possible.
--	no_build_chest_entry: If set to true: Do not add an entry for this building in the build_chest.
--	               Useful when manually adding diffrently structured entries (as in i.e. mg_villages)
--	               or when the entry would be temporal only.
-- Returns a table that contains the necessary information for spawning the building.
-- Returns nil if reading of the file failed.
handle_schematics.analyze_file = function( file_name, origin_offset, store_as_mts, building_data,no_build_chest_entry)
	if( not( building_data )) then
		building_data = {};
	end
	-- determine the file_name from building_data if possible
	if( not( file_name ) and building_data.mts_path and building_data.scm ) then
		file_name = building_data.mts_path .. building_data.scm;
	elseif( not( file_name )) then
		print("[handle_schematics] ERROR: No file name given to analyze.");
		return;
	end

	local res  = handle_schematics.analyze_mts_file( file_name ); 
	-- alternatively, read the mts file
	if( not( res )) then
		res = handle_schematics.analyze_we_file( file_name, origin_offset );
		if( not( res )) then
			res = handle_schematics.analyze_mc_schematic_file( file_name );
		end
		-- print error message only if all import methods failed
		if( not( res )) then
			print('[handle_schematics] ERROR: Failed to import file \"'..tostring( file_name )..'\"[.mts|.we|.wem|.schematic]');
			return;
		-- convert to .mts for later usage
                elseif( store_as_mts ) then
			handle_schematics.store_mts_file( store_as_mts, res );
			res  = handle_schematics.analyze_mts_file( file_name );
			if( not( res )) then
				return;
			end
		end

		-- .we and .schematic do not provide on_construct/after_palce_node
		-- (they have metadata instead)
		res.on_constr = {};
		res.after_place_node = {};
		for _, name_text in ipairs(res.nodenames) do
			local node_def = handle_schematics.node_defined( name_text );
			if( node_def and node_def.on_construct) then
				table.insert( res.on_constr, name_text );
			end
			if( node_def and node_def.after_place_node) then
				table.insert( res.after_place_node, name_text );
			end
		end
	end

	-- the building cannot be used if its size remains unknown
	if( not( res ) or not(res.size) or not(res.size.x)) then
		return nil;
	end

	-- the file has to be placed with minetest.place_schematic(...)
	res.is_mts = 1;

	-- the actual functions for placing use these for accessing the size
	res.sizex = res.size.x;
	res.sizez = res.size.z;
	res.ysize = res.size.y;

	-- these values remain unchanged
	-- res.bed_count:        How many beds does the building contain?
	-- res.bed_list:         And where are the beds placed in the original schematic?
	-- res.rotated:          Was the building stored in a rotated way?
	-- res.nodenames:        Which nodes are part of the building?
	-- res.on_constr:        For which nodes (nodenames only) do we need to call on_constuct?
	-- res.after_place_node: For which nodes (nodenames only) do we need to call after_palce_node?
	-- res.door_a:           Where can doors of type _a be found?
	-- res.door_b:           Where can doors of type _b be found?
	-- res.metadata:         Metadata; Only provided by .we files.

	-- some buildings may be rotated
	if( not( building_data.orients ) and res.rotated ) then
		res.orients = {};
		if(     res.rotated == 0 ) then
			res.orients[1] = 0;
		elseif( res.rotated == 90 ) then
			res.axis = 1; -- important when mirroring
			res.orients[1] = 1;
		elseif( res.rotated == 180 ) then
			res.orients[1] = 2;
		elseif( res.rotated == 270 ) then
			res.orients[1] = 3;
			res.axis = 1; -- important when mirroring
		end
	end

	if( not( building_data.yoff ) and res.burried ) then
		res.yoff = 1-res.burried;
	end

	-- the file has been read already
	if( res.scm_data_cache ) then
		res.is_mts = 0;
	end

	-- copy all the values from building_data over to res for later use; that
	-- might i.e. be information of where/how this building can be used by the mod
	-- (mod internal information)
	for k,v in pairs( building_data ) do
		-- do not overwrite any values
		if( not( res[ k ])) then
			res[ k ] = v;
		end
	end

	-- make the building as such available for the build_chest;
	-- cache all data (including res.scm_data_cache)
	-- TODO: what if the building was already stored by another mod?
	-- TODO: really cache all data?
	if( build_chest and build_chest.add_building ) then
		build_chest.add_building( file_name, res );
	end
	-- add the building to the menu list for the build chest
	if( build_chest and build_chest.add_entry and not(no_build_chest_entry) and building_data.scm) then
		local modname = minetest.get_current_modname();
		build_chest.add_entry( {'main', modname, modname, building_data.scm, file_name });
	end

	-- ships need ignore nodes around them so that the water around them doesn't get
	-- replaced when they are put in the sea
	if( (res.is_submerged) or (res.is_ship and res.yoff and res.yoff < 0)) then

		-- we need to find out which node type represents air in this particular schematic
		local air_id = 1;
		local ignore_id = 0;
		for i,n in ipairs( res.nodenames ) do
			if( n == "air") then
				air_id = i;
			end
			if( n == "ignore" or n == "mg:ignore" ) then
				ignore_id = i;
			end
		end
		-- if necessary add an ignore node
		if( ignore_id == 0 ) then
			table.insert( res.nodenames, "mg:ignore" );
			ignore_id = #res.nodenames;
		end

		-- yoff is needed so that we know how far the ship is submerged
		if( not( res.yoff )) then
			res.yoff = 0;
		end

		local ignore = {ignore_id,0};
		if( res.is_submerged) then
			-- set all nodes that are undefined or ignore to ignore
			-- so that the building/shipwreck will replace no water
			-- or sand etc.
			local count_ignore = 0;
			for y=1, res.size.y do
			for x=1, res.size.x do
			for z=1, res.size.z do
				if( not(res.scm_data_cache[y][x][z])
				  or res.scm_data_cache[y][x][z][1]==air_id) then
					res.scm_data_cache[y][x][z] = {ignore_id,0};
					count_ignore = count_ignore + 1;
				end
			end
			end
			end
		else
			-- flood from the outside inward for all levels below/at
			-- water surface level
			floodfill_with_ignore( res, air_id, ignore );
		end
	end

	return res;
end
