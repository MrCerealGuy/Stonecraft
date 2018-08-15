
-- This code is used to read Minecraft schematic files.
--
-- The .schematic file format is described here:
--   http://minecraft.gamepedia.com/Schematic_file_format?cookieSetup=true
-- It is based on the NBT format, which is described here:
--   http://minecraft.gamepedia.com/NBT_Format?cookieSetup=true


-- position in the decompressed string data_stream
local curr_index = 1;

-- helper arry so that the values do not have to be calculated anew each time
local pot256 = { 1 };
for i=1,8 do
	pot256[ #pot256+1 ] = pot256[ #pot256 ] * 256;
end

-- read length bytes from data_stream and turn it into an integer value
local read_signed = function( data_stream, length)
	local res = 0;
	for i=length,1,-1 do
		res = res + (string.byte( data_stream, curr_index )* pot256[ i ]);
		-- move one further
		curr_index = curr_index+1;
	end
	return res;
end

-- this table will collect the few tags we're actually intrested in
local mc_schematic_data = {};

-- this will be a recursive function
local read_tag;

-- needs to be defined now because it will contain a recursive function
local read_one_tag;

-- read payload of one tag (= a data element in a NBT data structure)
read_one_tag = function( data_stream, tag, title_tag )
	if(     tag<= 0 or not(data_stream)) then
		return;
	elseif( tag==1 ) then -- TAG_BYTE: 1 byte
		return read_signed( data_stream, 1 );
	elseif( tag==2 ) then -- TAG_SHORT: 2 bytes
		return read_signed( data_stream, 2 );
	elseif( tag==3 ) then -- TAG_INT:   4 bytes
		return read_signed( data_stream, 4 );
	elseif( tag==4 ) then -- TAG_LONG:   8 bytes
		return read_signed( data_stream, 8 );
	elseif( tag==5 ) then -- TAG_FLOAT: 4 bytes
		return read_signed( data_stream, 4 ); -- the float values are unused here 
	elseif( tag==6 ) then -- TAG_DOUBLE: 8 bytes
		return read_signed( data_stream, 8 ); -- the float values are unused here
	elseif( tag==7 ) then -- TAG_Byte_Array
		local size = read_signed( data_stream, 4 ); -- TAG_INT
		local res = {};
		for i=1,size do
			-- a Byte_Array does not contain any sub-tags
			res[i] = read_one_tag( data_stream, 1, nil ); -- read TAG_BYTE 
		end
		return res;

	elseif( tag==8 ) then -- TAG_String
		local size = read_signed( data_stream, 2);
		local res = string.sub( data_stream, curr_index, curr_index+size-1 );
		-- move on in the data stream
		curr_index = curr_index + size;
		return res;

	elseif( tag==9 ) then -- TAG_List
		-- these exact values are not particulary intresting
		local tagtyp = read_signed( data_stream, 1 ); -- TAG_BYTE
		local size   = read_signed( data_stream, 4 ); -- TAG_INT
		local res = {};
		for i=1,size do
			-- we need to pass title_tag on to the "child"
			res[i] = read_one_tag( data_stream, tagtyp, title_tag );	
		end
		return res;

	elseif( tag==10 ) then -- TAG_Compound
		return read_tag( data_stream, title_tag );

	elseif( tag==11 ) then -- TAG_Int_Array
		local size = read_signed( data_stream, 4 ); -- TAG_INT
		local res = {};
		for i=1,size do
			-- a Int_Array does not contain any sub-tags
			res[i] = read_one_tag( data_stream, 3, nil ); -- TAG_INT
		end
		return res;
	end
end


-- read tag type, tag name and call read_one_tag to get the payload;
read_tag = function( data_stream, title_tag )
	local schematic_data = {};
	while( data_stream ) do
		local tag = string.byte( data_stream, curr_index);
		-- move on in the data stream
		curr_index = curr_index + 1;
		if( not( tag ) or tag <= 0 ) then
			return;
		end
		local tag_name_length = string.byte( data_stream, curr_index ) * 256 + string.byte(data_stream, curr_index + 1);
		-- move 2 further
		curr_index = curr_index + 2;
		local tag_name        = string.sub( data_stream, curr_index, curr_index+tag_name_length-1 );
		-- move on...
		curr_index = curr_index + tag_name_length;
		local res = read_one_tag( data_stream, tag, tag_name );

		--if( tag_name ~= "pos" and tag_name ~= "state" ) then
		--	print('[analyze_mc_schematic_file] Found: Tag '..tostring( tag )..' <'..tostring( tag_name )..'> '..minetest.serialize( res ));
		--end

		-- Entities and TileEntities are ignored
		-- this is for the .schematic format
		if( title_tag == 'Schematic' ) then
			if(( tag_name == 'Width'
			     or tag_name == 'Height'
			     or tag_name == 'Length'
			     or tag_name == 'Materials' -- "Classic" or "Alpha" (=Survival)
			     or tag_name == 'Blocks'
			     or tag_name == 'Data'
			)) then
				mc_schematic_data[ tag_name ] = res;
			end

		-- ..and this for .nbt
		elseif( tag_name == 'size' and res and res[1] and res[2] and res[3]) then
			schematic_data.Width  = res[1]; -- TODO: no idea if the dimensions are truely arranged like this
			schematic_data.Height = res[2];
			schematic_data.Length = res[3];
			schematic_data.Data      = {};
			schematic_data.Materials = {};
			schematic_data.Blocks    = {};
		elseif( title_tag == 'blocks' and tag_name == 'pos' ) then
			schematic_data.last_pos = pos;
		elseif( title_tag == 'blocks' and tag_name == 'state' ) then
			schematic_data.last_state = state;
		end

		if( schematic_data.last_pos and schematic_data.last_state ) then
			local p = schematic_data.last_pos;
			local size = {x=schematic_data.Width, y=schematic_data.Height, z=schematic_data.Length};
			mc_schematic_data.Blocks[ ((p[2]-1)*size.z + (p[3]-1) )*size.x + (size.x-p[4]) +1] = schematic_data.last_state;
			schematic_data.last_pos   = nil;
			schematic_data.last_state = nil;
		end
	end
	return;
end


handle_schematics.analyze_mc_schematic_file = function( path )
	-- these files are usually compressed; there is no point to start if the
	-- decompress function is missing
	if( minetest.decompress == nil) then
		return nil; 
	end

	local file, err = save_restore.file_access(path..'.schematic', "rb")
	if (file == nil) then
--		print('[analyze_mc_schematic_file] ERROR: NO such file: '..tostring( path..'.schematic'));
		return nil
	end

	local compressed_data = file:read( "*all" );
	file.close(file)
	--print('FILE SIZE: '..tostring( string.len( compressed_data )));
	--local data_string = minetest.decompress(compressed_data, "deflate" );
	local data_string = compressed_data; -- TODO


	-- we use this (to this file) global variable to store gathered information;
	-- doing so inside the recursive functions proved problematic
	mc_schematic_data = {};
	-- this index will iterate through the schematic data
	curr_index = 1;
	-- actually analyze the data
	read_tag( data_string, nil );

	if(  not( mc_schematic_data.Width )
	  or not( mc_schematic_data.Height )
	  or not( mc_schematic_data.Length )
	  or not( mc_schematic_data.Blocks )
	  or not( mc_schematic_data.Data )) then
		print('[analyze_mc_schematic_file] ERROR: Failed to analyze '..tostring( path..'.schematic'));
		return nil;
	end

	local translation_function = handle_schematics.findMC2MTConversion;
	if( minetest.get_modpath('mccompat')) then
		translation_function = mccompat.findMC2MTConversion;
	end

	local bed_count = 0;
	local bed_list = {};

	local max_msg = 40; -- just for error handling
	local size = {x=mc_schematic_data.Width,  y=mc_schematic_data.Height, z=mc_schematic_data.Length};
	local scm = {};
	local nodenames = {};
	local nodenames_id = {};
	for y=1,size.y do
		scm[y] = {};
		for x=1,size.x do
			scm[y][x] = {};
			for z =1,size.z do
				local new_node = translation_function(
						-- (Y×length + Z)×width + X.
						mc_schematic_data.Blocks[ ((y-1)*size.z + (z-1) )*size.x + (size.x-x) +1],
						mc_schematic_data.Data[   ((y-1)*size.z + (z-1) )*size.x + (size.x-x) +1] );
				-- some MC nodes store the information about a node in TWO block and data fields (doors, large flowers, ...)
				if( new_node[3] and new_node[3]~=0 ) then
					new_node = translation_function( 
						-- (Y×length + Z)×width + X.
						mc_schematic_data.Blocks[ ((y-1)*size.z + (z-1) )*size.x + (size.x-x) +1],
						mc_schematic_data.Data[   ((y-1)*size.z + (z-1) )*size.x + (size.x-x) +1],
						mc_schematic_data.Blocks[ ((y-1+new_node[3])*size.z + (z-1) )*size.x + (size.x-x) +1],
						mc_schematic_data.Data[   ((y-1+new_node[3])*size.z + (z-1) )*size.x + (size.x-x) +1] );
				end
				if( not( nodenames_id[ new_node[1]] )) then
					nodenames_id[ new_node[1] ] = #nodenames + 1;
					nodenames[ nodenames_id[ new_node[1] ]] = new_node[1];
				end
				-- print a few warning messages in case something goes wrong - but do not exaggerate
				if( not( new_node[2] and max_msg>0)) then
--					print('[handle_schematics:schematic] MISSING param2: '..minetest.serialize( new_node ));
					new_node[2]=0;
					max_msg=max_msg-1;
				end
				if( handle_schematics.bed_node_names[ new_node[1]] ) then
					bed_count = bed_count + 1;
					table.insert( bed_list, {x=x, y=y, z=z, p2, minetest.get_content_id( new_node[1])});
				end
				-- save some space by not saving air
				if( new_node[1] ~= 'air' ) then
					scm[y][x][z] = { nodenames_id[ new_node[1]], new_node[2]};
				end
			end
		end
	end
	return { size = { x=size.x, y=size.y, z=size.z}, nodenames = nodenames, on_constr = {}, after_place_node = {}, rotated=90, burried=0, scm_data_cache = scm, metadata = {}, bed_count = bed_count, bed_list = bed_list};
end

