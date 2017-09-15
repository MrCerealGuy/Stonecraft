
-- reserve the namespace
save_restore = {}

-- TODO: if this gets more versatile, add sanity checks for filename
-- TODO: apart from allowing filenames,  schems/<filename> also needs to be allowed

-- TODO: save and restore ought to be library functions and not implemented in each individual mod!
save_restore.save_data = function( filename, data )

	local path = minetest.get_worldpath()..'/'..filename;
	
	local file = io.open( path, 'w' );
	if( file ) then
		file:write( minetest.serialize( data ));
		file:close();
	else
		print("[save_restore] Error: Savefile '"..tostring( path ).."' could not be written.");
	end
end


save_restore.restore_data = function( filename )
	local file = io.open(  minetest.get_worldpath()..'/'..filename, 'r' );
	if( file ) then
		local data = file:read("*all");
		file:close();
		return minetest.deserialize( data );
	else
		print("[save_restore] Error: Savefile '"..tostring( filename ).."' not found.");
		return {}; -- return empty table
	end
end



save_restore.file_exists = function( filename )

	local file = save_restore.file_access( filename, 'r' );
	if( file ) then
		file:close();
		return true;
	end
	return;
end


save_restore.create_schems_directory = function()

	local directory = minetest.get_worldpath()..'/schems';

	if( not( save_restore.file_exists( directory ))) then
		if( minetest.mkdir ) then
			minetest.mkdir( directory );
		else
			os.execute("mkdir \""..directory.. "\"");
		end
	end
end


-- we only need the function io.open in a version that can read schematic files from diffrent places,
-- even if a secure environment is enforced; this does require an exception for the mod
local ie_io_open = io.open;
--[[ does not work anyway
if( minetest.request_insecure_environment ) then
	local ie, req_ie = _G, minetest.request_insecure_environment
	if req_ie then ie = req_ie() end
	if ie then
		ie_io_open = ie.io.open;
	end
end
--]]

-- only a certain type of files can be read and written
save_restore.file_access = function( path, params )
	if( (params=='r' or params=='rb')
	  and ( string.find( path, '.mts',  -4 )
	     or string.find( path, '.schematic', -11 )
	     or string.find( path, '.we',   -3 )
	     or string.find( path, '.wem',  -4 ) )) then
		return ie_io_open( path, params );
	elseif( (params=='w' or params=='wb')
	  and ( string.find( path, '.mts',  -4 )
	     or string.find( path, '.schematic', -11 )
	     or string.find( path, '.we',   -3 )
	     or string.find( path, '.wem',  -4 ) )) then
		return ie_io_open( path, params );
	end
end
