
-- create a backup of the existing landscape and delete metadata;
-- store the name of the backup file in meta
--	meta             the metadata of the node that will store the file name of the backup
--	                 we are about to create here
--	start_pos,
--	end_pos          volume that is to be saved
--	player_name      has to be equal to meta:get_string("owner")
--	force_overwrite  if set to true: overwrite already existing backup
-- Returns the name of the backup file that has been created if successful. Else returns nothing.
handle_schematics.backup_landscape = function(meta, start_pos, end_pos, player_name, force_overwrite)
	local filename = meta:get_string('backup' );

	-- do not overwrite existing backups unless force_overwrite is active
	if( filename and filename ~= "" and not(force_overwrite)) then
		return;
	end

	-- the node has to be owned by the right player
	local owner = meta:get_string("owner");
	if( owner and owner ~= "" and owner ~= player_name and player_name and player_name ~= "") then
		minetest.chat_send_player( player_name,
			"Only the owner, namely "..minetest.tostring( owner )..
			", is allowed to create a backup of this landscape here.");
			return;
	end

	local base_filename = 'backup_'..owner..'_'..
		tostring( start_pos.x )..':'..tostring( start_pos.y )..':'..tostring( start_pos.z )..'_'..
		'0_0';

	-- store a backup of the original landscape
	-- <worldname>/backup_PLAYERNAME_x_y_z_burried_rotation.mts
	handle_schematics.create_schematic_with_meta( start_pos, end_pos, base_filename );
	meta:set_string('backup', base_filename );

	-- clear metadata so that the new building can be placed
	handle_schematics.clear_meta( start_pos, end_pos );

	-- update start_pos and end_pos in metadata
	meta:set_string( "start_pos", minetest.serialize( start_pos ));
	meta:set_string( "end_pos",   minetest.serialize( end_pos   ));

	minetest.chat_send_player( player_name,
		'CREATING backup schematic for this place in \"schems/'..base_filename..'.mts\".');
	return base_filename;
end


-- restore the original landscape from a backup
--      meta          metadata of the node containing information about backup file, start_pos and
--                    end_pos
--      player_name   the name of the player who wants to restore the backup
-- 	force_place   if set: place the landscape from the backup completely (not just scaffolding)
-- 	              even if the player does not have the creative privilege
-- 	pos           position of the node with the metadata
handle_schematics.restore_landscape = function( meta, player_name, force_place, pos)
	local start_pos     = minetest.deserialize( meta:get_string('start_pos'));
	local end_pos       = minetest.deserialize( meta:get_string('end_pos'));
	local backup_file   = meta:get_string( 'backup' );

	if(  not( start_pos   ) or not( end_pos   )
	  or not( start_pos.x ) or not( end_pos.x )
	  or not( backup_file ) or backup_file == "") then
		if( player_name ) then
			minetest.chat_send_player( player_name,
				"Error: Missing data. Restoring of backup of landscape not possible.");
		end
		return;
	end

	-- the node has to be owned by the right player
	local owner = meta:get_string("owner");
	if( owner and owner ~= "" and owner ~= player_name and player_name and player_name ~= ""
	   and not( minetest.check_player_privs(player_name, {protection_bypass=true}))) then
		minetest.chat_send_player( player_name,
			"Only the owner, namely "..minetest.tostring( owner )..
			", or players with the protection_bypass privilege are allowed to restore the backup.");
			return;
	end

	local filename = minetest.get_worldpath()..'/schems/'..backup_file;
	if( not( save_restore.file_exists( filename..'.mts' ))) then
		if( player_name ) then
			minetest.chat_send_player( player_name,
				"Error: Backup of landscape cannot be restored. File not found. Path: "..
				tostring( filename ));
		end
	end

	-- used for indicating which mode (actual project or landscape restauration) we are in; here:
	-- landscape restauration (needed by the build chest for manual restauration)
	meta:set_int('is_restore', 1);

	if( force_place or  minetest.check_player_privs( player_name, {creative=true})) then
		minetest.place_schematic( start_pos, filename..'.mts', "0", {}, true );
		-- no rotation needed - the metadata can be applied as-is (with the offset applied)
		-- restore_meta adds the worldpath automaticly
		handle_schematics.restore_meta( '/schems/'..backup_file, nil, start_pos, end_pos, 0, nil);
		meta:set_string('backup', nil );
		-- we are back to the beginning - no landscape backup present
		meta:set_int('is_restore', 0);
		-- inform the player
		if( player_name ) then
			minetest.chat_send_player( player_name, "Successfully restored backup of landscape.");
		end
	else
		-- players without creative priv have to rebuild the landscape manually
		minetest.chat_send_player( player_name, "New goal: Restore the original landscape.")
		local building_name = meta:get_string('building_name');
		local rotate = meta:get_string('rotate');
		local mirror = meta:get_string('mirror');
		local axis   = build_chest.building[ building_name ].axis;
		local no_plotmarker = true;
		local replacement_list = {};
		local error_msg = handle_schematics.place_building_from_file( start_pos, end_pos, filename, replacement_list, "180", 3, 1, no_plotmarker, false, true, pos );
		if( error_msg ) then
			error_msg = 'Error: '..tostring( error_msg );
			minetest.chat_send_player( player_name, error_msg );
		end
	end
end
	

