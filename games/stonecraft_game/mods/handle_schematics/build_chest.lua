-----------------------------------------------------------------------------------------------------------------
-- interface for manual placement of houses 
-----------------------------------------------------------------------------------------------------------------


-- functions specific to the build_chest are now stored in this table
build_chest = {};

-- scaffolding that will be placed instead of other nodes in order to show
-- how large the building will be
build_chest.SUPPORT = 'build_chest:support';


-- contains information about all the buildings
build_chest.building = {};

-- returns the id under which the building is stored
build_chest.add_building = function( file_name, data )
	if( not( file_name ) or not( data )) then
		return;
	end
	build_chest.building[ file_name ] = data;
end

-- that many options can be shown simultaneously on one menu page
build_chest.MAX_OPTIONS = 24; -- 3 columns with 8 entries each


build_chest.menu = {};
build_chest.menu.main = {};

-- create a tree structure for the menu
build_chest.add_entry = function( path )
	if( not( path ) or #path<1 ) then
		return;
	end

	local sub_menu = build_chest.menu;
	for i,v in ipairs( path ) do
		if( not( sub_menu[ v ] )) then
			sub_menu[ v ] = {};
		end
		sub_menu = sub_menu[ v ];
	end
end

-- add a menu entry that will always be available
build_chest.add_entry( {'save a building'} );

-- needed for saving buildings
build_chest.end_pos_list = {};

--dofile( minetest.get_modpath( minetest.get_current_modname()).."/build_chest_handle_replacements.lua");
--dofile( minetest.get_modpath( minetest.get_current_modname()).."/build_chest_preview_image.lua");
--dofile( minetest.get_modpath( minetest.get_current_modname()).."/build_chest_add_schems.lua");




build_chest.read_building = function( building_name, building_data )
	if( not( building_data )) then
		building_data = {};
	end
	if( not( build_chest.building[ building_name ] )) then
		build_chest.building[ building_name ] = building_data;
	end
	-- read data
	local res = handle_schematics.analyze_file( building_name, nil, nil, build_chest.building[ building_name ]);
	if( not( res )) then
		return;
	end
--[[
	build_chest.building[ building_name ].size           = res.size;	
	build_chest.building[ building_name ].nodenames      = res.nodenames;	
	build_chest.building[ building_name ].rotated        = res.rotated;	
	build_chest.building[ building_name ].burried        = res.burried;	
	build_chest.building[ building_name ].metadata       = res.metadata;
	build_chest.building[ building_name ].bed_count      = res.bed_count;
	-- mobs are very intrested in beds in which they might sleep at night
	build_chest.building[ building_name ].bed_list       = res.bed_list;
	-- scm_data_cache is not stored as that would take up too much storage space
	--build_chest.building[ building_name ].scm_data_cache = res.scm_data_cache;	
--]]
	build_chest.building[ building_name ] = res;
	-- create a statistic about how often each node occours
	build_chest.building[ building_name ].statistic      = handle_schematics.count_nodes( res );

	build_chest.building[ building_name ].preview        = build_chest.preview_image_create_views( res,
									build_chest.building[ building_name ].orients );
	return res;
end



build_chest.get_start_pos = function( pos, building_name, param2 )
	-- rotate the building so that it faces the player
	local node = minetest.get_node( pos );
	local meta = minetest.get_meta( pos );

	if( not( building_name )) then
		building_name = meta:get_string( 'building_name' );
	end
	if( not( building_name )) then
		return "No building_name provided.";
	end
	if( not( build_chest.building[ building_name ] )) then
		return "No data found for this building.";
	end

	if( not( build_chest.building[ building_name ].size )) then
		if( not( build_chest.read_building( building_name ))) then
			return "Unable to read data file of this building.";
		end
	end
	local selected_building = build_chest.building[ building_name ];

	local mirror = 0; -- place_schematic does not support mirroring

	local start_pos = {x=pos.x, y=pos.y, z=pos.z};
	-- yoff(set) from mg_villages (manually given)
	if( selected_building.yoff ) then
		start_pos.y = start_pos.y + selected_building.yoff -1;
	end
	
	if( param2 == nil ) then
		param2 = node.param2;
	end
	-- make sure the building always extends forward and to the right of the player
	local param2_rotated = handle_schematics.translate_param2_to_rotation( param2, mirror, start_pos,
				selected_building.size, selected_building.rotated, selected_building.burried, selected_building.orients,
				selected_building.yoff );

	-- save the data for later removal/improvement of the building in the chest
	meta:set_string( 'start_pos',    minetest.serialize( param2_rotated.start_pos ));
	-- one higher so that there is place for "dig here" indicators
	meta:set_string( 'end_pos',      minetest.serialize( {x=param2_rotated.end_pos.x, y=param2_rotated.end_pos.y+1, z=param2_rotated.end_pos.z} ));
	meta:set_string( 'rotate',       tostring(param2_rotated.rotate ));
	meta:set_int(    'mirror',       mirror );
	-- no replacements yet
	meta:set_string( 'replacements', minetest.serialize( {} ));
	return start_pos;
end
      



build_chest.show_size_data = function( building_name )

	if( not( building_name )
	   or building_name == ''
	   or not( build_chest.building[ building_name ] )
	   or not( build_chest.building[ building_name ].size )) then
		return "";
	end

	local size = build_chest.building[ building_name ].size;
	-- the full path and name of the building is often too long and provides information about the filesystem, which is unsuitable for players
	local shortened_building_name = building_name;
	shortened_building_name = string.sub( building_name, string.len( building_name ) + 2 - string.find( string.reverse(building_name), "/", 1, true ));

	-- show which building has been selected
	return "label[0.3,9.5;Selected building:]"..
		"label[2.3,9.5;"..minetest.formspec_escape(shortened_building_name).."]"..
		-- size of the building
		"label[0.3,9.8;Size ( wide x length x height ):]"..
		"label[4.3,9.8;"..tostring( size.x )..' x '..tostring( size.z )..' x '..tostring( size.y ).."]";
end


-- abort a building project - remove all dig_here-indicators and special scaffolding nodes
handle_schematics.abort_project_remove_indicators = function( meta )
	local start_pos     = minetest.deserialize( meta:get_string('start_pos'));
	local end_pos       = minetest.deserialize( meta:get_string('end_pos'));
	-- find automaticly placed dig-here-indicators and scaffolding nodes
	if( start_pos and end_pos and start_pos.x and end_pos.x) then
		local nodes = minetest.find_nodes_in_area( start_pos, end_pos, {"handle_schematics:dig_here", "handle_schematics:support_setup"});
		for i,v in ipairs( nodes ) do
			minetest.set_node( v, { name = "air", param2 = 0 });
		end
	end
end

-- helper function for update_formspec that handles saving of a building
handle_schematics.update_formspec_save_building = function( formspec, meta, player, fields, pos )
	local saved_as_filename = meta:get_string('saved_as_filename');
	if( saved_as_filename and saved_as_filename ~= "" ) then
		local p1str = meta:get_string('p1');
		local p2str = meta:get_string('p2');
		
		return formspec..
			"label[2.0,3;This area has been saved to the file]"..
			"label[2.5,3.3;"..minetest.formspec_escape( saved_as_filename ).."]"..
			"label[2.0,3.6;The area extends from]"..
			"label[2.5,3.9;"..minetest.formspec_escape( p1str ).."]"..
			"label[2.0,4.2;to the point]"..
			"label[2.5,4.5;"..minetest.formspec_escape( p2str ).."]"..
			"button[5,8.0;3,0.5;back;Back]";
	end

	local end_pos_mark = build_chest.end_pos_list[ player:get_player_name() ];
	if(    end_pos_mark
	   and end_pos_mark.x==pos.x 
	   and end_pos_mark.y==pos.y 
	   and end_pos_mark.z==pos.z ) then

		return formspec..
			"label[2,3.0;This chest marks the end position of your building. Please put another]"..
			"label[2,3.3;build chest in front of your building and save it with that chest.]"..
			"button[5,8.0;3,0.5;back;Back]";
	end
		
	if( end_pos_mark and end_pos_mark.start_pos ) then

		if(    end_pos_mark.start_pos.x == pos.x
		   and end_pos_mark.start_pos.y == pos.y
		   and end_pos_mark.start_pos.z == pos.z ) then
			local p2 = {x=end_pos_mark.x, y=end_pos_mark.y, z=end_pos_mark.z};
			local p1 = {x=end_pos_mark.start_pos.x, y=end_pos_mark.start_pos.y, z=end_pos_mark.start_pos.z};
			local height = math.abs( p1.y - p2.y )+1;
			local width  = 0;
			local length = 0;
			if( end_pos_mark.param2==0 or end_pos_mark.param2==2 ) then
				-- adjust p1 and p2 so that only the area we really care about is marked
				if( p1.z > p2.z ) then
					p1.z = p1.z-1;
					p2.z = p2.z+1;
				else
					p1.z = p1.z+1;
					p2.z = p2.z-1;
				end
				width  = math.abs( p1.x - p2.x )+1;
				length = math.abs( p1.z - p2.z )+1;
			else
				if( p1.x > p2.x ) then
					p1.x = p1.x-1;
					p2.x = p2.x+1;
				else
					p1.x = p1.x+1;
					p2.x = p2.x-1;
				end
				length = math.abs( p1.x - p2.x )+1;
				width  = math.abs( p1.z - p2.z )+1;
			end
			return formspec..
				-- p1 and p2 are passed on as inputs in order to avoid any unwanted future interferences
				-- with any other build chests
				"field[40,40;0.1,0.1;save_as_p1;;"..minetest.pos_to_string(p1).."]"..
				"field[40,40;0.1,0.1;save_as_p2;;"..minetest.pos_to_string(p2).."]"..

				"label[2,2.4;How high is your building? This does *not* include the height offset below. The]"..
				"label[2,2.7;default value is calculated from the height difference between start and end position.]"..
				"label[2,3.15;Total height of your building:]"..
					"field[6,3.5;1,0.5;save_as_height;;"..tostring(height).."]"..

				-- note: in mg_villages, yoff has to be 0 in order to include the ground floor as well;
				-- "1" means the building without floor; here, "1" means a floating building
				"label[2,3.8;The hight offset sets how deep your building will be burried in the ground. Examples:]"..
					"label[2.5,4.1;A value of -4 will include a cellar which extends 4 nodes below this build chest.]"..
					"label[2.5,4.4;A value of -1 will include the floor below the chest, but no cellar.]"..
					"label[2.5,4.7;A positive value will make your building float in the air.]"..
				"label[2,5.15;Add height offset:]"..
					"field[6,5.5;1,0.5;save_as_yoff;;0]"..

				"label[2,5.8;Without the changes entered in the input form above, your building will extend from]"..
					"label[2.5,6.1;"..minetest.formspec_escape(
						minetest.pos_to_string( p1 ).." to "..
						minetest.pos_to_string( p2 ).." and span a volume of "..
						-- x and z are swpapped here if rotated by 90 or 270 degree
						tostring(width )..' (width) x '..
						tostring(length)..' (depth) x '..
						tostring(height)..' (height)').."]"..
						
				"label[2,6.7;Please enter a descriptive filename. Allowed charcters: "..
					minetest.formspec_escape("a-z, A-Z, 0-9, -, _, .").."]"..
				"label[2,7.15;Save schematic as:]"..
					"field[6,7.5;4,0.5;save_as_filename;;]"..

				"button[2,8.0;3,0.5;abort_set_start_pos;Abort]"..
				"button[6,8.0;3,0.5;save_as;Save building now]";
		 else
			return formspec..
				"label[3,3;You have selected another build chest as start position.]"..
				"button[5,8.0;3,0.5;back;Back]"..
				"button[5,5.0;3,0.5;abort_set_start_pos;Reset start position]";
		end
	end

	if( fields.error_msg ) then
		return formspec..
			"label[4,4.5;Error while trying to set the start position:]"..
			"textarea[4,5;6,2;error_msg;;"..
			minetest.formspec_escape( fields.error_msg ).."]"..
			"button[5,8.0;3,0.5;back;Back]";
	end

	return formspec..
		"label[2.5,2.2;First, let us assume that you are facing the front of this build chest.]"..

		"label[2,3.1;Are you looking at the BACKSIDE of your building, and does said backside stretch]"..
		"label[2,3.4;to the right and in front of you? Then click on the button below:]"..
		"button[4,4;5,0.5;set_end_pos;Set this position as new end position]"..

		"label[2,5.2;Have you set the end position with another build chest using the method above]"..
		"label[2,5.5;in the meantime? And are you now looking at the FRONT of your building, which]"..
		"label[2,5.8;streches in front of you and to the right? Then click on Proceed:]"..
		"button[5,6.4;3,0.5;set_start_pos;Proceed with saving]"..

		"label[4,7.4;If this confuses you, you can also abort the process.]"..
		"button[5,8.0;3,0.5;back;Abort]";
end



-- offer diffrent replacement groups
handle_schematics.get_formspec_group_replacement = function( pos, fields, formspec )

	if( fields.set_wood and fields.set_wood ~= "" ) then
		return formspec..
			"label[1,2.2;Select replacement for "..tostring( fields.set_wood )..".]"..
			"label[1,2.5;Trees, saplings and other blocks will be replaced accordingly as well.]"..
			-- invisible field that encodes the value given here
			"field[-20,-20;0.1,0.1;set_wood;;"..minetest.formspec_escape( fields.set_wood ).."]"..
			build_chest.replacements_get_group_list_formspec( pos, 'wood',    'wood_selection' );
	end

	if( fields.set_farming and fields.set_farming ~= "" ) then
		return formspec..
			"label[1,2.5;Select the fruit the farm is going to grow:]"..
			-- invisible field that encodes the value given here
			"field[-20,-20;0.1,0.1;set_farming;;"..minetest.formspec_escape( fields.set_farming ).."]"..
			build_chest.replacements_get_group_list_formspec( pos, 'farming', 'farming_selection' );
	end

	if( fields.set_roof and fields.set_roof ~= "" ) then
		return formspec..
			"label[1,2.5;Select a roof type for the house:]"..
			-- invisible field that encodes the value given here
			"field[-20,-20;0.1,0.1;set_roof;;"..minetest.formspec_escape( fields.set_roof ).."]"..
			build_chest.replacements_get_group_list_formspec( pos, 'roof',    'roof_selection' );
	end
	return nil;
end



build_chest.update_formspec = function( pos, page, player, fields )

	-- information about the village the build chest may belong to and about the owner
	local meta = minetest.get_meta( pos );

	local village_name = meta:get_string( 'village' );
	local village_pos  = minetest.deserialize( meta:get_string( 'village_pos' ));
	local owner_name   = meta:get_string( 'owner' );
	local building_name = meta:get_string('building_name' );

	-- are we dealing with a plotmarker inside a village?
	local village_id   = meta:get_string( 'village_id' );
	local plot_nr      = meta:get_int(    'plot_nr' );
	if(     village_id
	    and village_id~=""
	    and plot_nr
	    and plot_nr>0
	    and mg_villages.all_villages
	    and mg_villages.all_villages[ village_id ]
	    and mg_villages.all_villages[ village_id ].to_add_data.bpos
	    and mg_villages.all_villages[ village_id ].to_add_data.bpos[ plot_nr ]) then

		local v = mg_villages.all_villages[ village_id ];
		village_name  = v.name;
		-- the center of the village
		village_pos   = { x = v.vx, y = v.vh, z = v.vz };
		-- who has bought the plot?
		owner_name    = v.to_add_data.bpos[ plot_nr ].owner;
		building_name = v.to_add_data.bpos[ plot_nr ].btype;
		-- get the name of the blueprint the building was created from
		if( mg_villages.BUILDINGS[ building_name ] ) then
			building_name = tostring( mg_villages.BUILDINGS[ building_name ].scm );
		end
		-- we also know where the building will start and end

		-- TODO: these may need to be set
		--local start_pos     = meta:get_string('start_pos');
		--local end_pos       = minetest.deserialize( meta:get_string('end_pos'));
		--local rotate = meta:get_string('rotate');
		--local mirror = meta:get_string('mirror');
	else
		village_id = "";
		plot_nr    = -1;
	end

	-- distance from village center
	local distance = math.floor( math.sqrt( (village_pos.x - pos.x ) * (village_pos.x - pos.x ) 
					      + (village_pos.y - pos.y ) * (village_pos.y - pos.y )
					      + (village_pos.z - pos.z ) * (village_pos.z - pos.z ) ));

	-- the statistic is needed for all the replacements later on as it also contains the list of nodenames
	if( building_name and building_name~=""and not( build_chest.building[ building_name ].size )) then
		build_chest.read_building( building_name );
	end

	if( page == 'please_remove' ) then
		if( build_chest.stages_formspec_page_please_remove ) then
			return build_chest.stages_formspec_page_please_remove( building_name, owner_name, village_name, village_pos, distance );
		end
	elseif( page == 'finished' ) then
		if( build_chest.stages_formspec_page_finished ) then
			return build_chest.stages_formspec_page_finished(      building_name, owner_name, village_name, village_pos, distance );
		end
	elseif( page ~= 'main' ) then
		-- if in doubt, return the old formspec
		return meta:get_string('formspec');
	end


	-- create the header
	local formspec = "size[13,10]"..
                            "label[3.3,0.0;Building box]"..
                            "label[0.3,0.4;Located at:]"      .."label[3.3,0.4;"..(minetest.pos_to_string( pos ) or '?')..", which is "..tostring( distance ).." m away]"
                                                              .."label[7.3,0.4;from the village center]".. 
                            "label[0.3,0.8;Part of village:]" .."label[3.3,0.8;"..(village_name or "?").."]"
                                                              .."label[7.3,0.8;located at "..(minetest.pos_to_string( village_pos ) or '?').."]"..
                            "label[0.3,1.2;Owned by:]"        .."label[3.3,1.2;"..(owner_name or "- for sale -").."]"..
                            "label[3.3,1.6;Click on a menu entry to select it:]"..
			    build_chest.show_size_data( building_name );

	if( fields.show_materials and fields.show_materials ~= "" ) then
		-- do not allow any changes; just show the materials and their replacements
		return formspec..build_chest.replacements_get_list_formspec( pos, nil, 0, meta, village_id, building_name, -1 );
	end

	-- are we dealing with a plotmarker? if so, we are finished here
	-- (we mostly wanted the header and the option to see the replacements)
	if( village_id and village_id ~= "" ) then
		-- TODO: actually implement the villages_* functions
		return formspec.."button[3,3;3,0.5;villages_create_backup;Create backup of current stage]"..
		                 "button[3,4;3,0.5;show_materials;Show materials used]"..
		                 "button[3,5;3,0.5;villages_reset_building;Reset building]"..
		                 "button[3,3;3,0.5;villages_remove_building;Remove building]";
	end

	-- the building has been placed; offer to restore a backup
	local backup_file   = meta:get_string('backup');
	if( backup_file and backup_file ~= "" ) then

		local is_restore = meta:get_int('is_restore');
		local nodes_to_dig = meta:get_int( "nodes_to_dig" );
		if( fields.abort_project ) then
			return formspec.."label[0,3;Abort this project and select a new one?]"..
				"button[0,4;1.5,0.5;yes_abort_project;Yes]"..
				"button[3,4;1.5,0.5;no_abort;No]";
		elseif( fields.save_file_as ) then
			local shortened_building_name = building_name;
			shortened_building_name = string.sub( building_name, string.len( building_name ) + 2 - string.find( string.reverse(building_name), "/", 1, true ));

			local start_pos     = minetest.deserialize( meta:get_string('start_pos'));
			local end_pos       = minetest.deserialize( meta:get_string('end_pos'));
			-- how deep the building is burried will also become part of the new filename
			local burried = (start_pos.y - pos.y);
			-- the "burried" value will be applied later
			start_pos.y = pos.y;

			return formspec.."label[0,3;Save the current building as..]"..
				"field[40,40;0.1,0.1;save_as_p1;;"..minetest.pos_to_string(start_pos).."]"..
				"field[40,40;0.1,0.1;save_as_p2;;"..minetest.pos_to_string(end_pos).."]"..
				"field[40,40;0.1,0.1;save_as_yoff;;"..burried.."]"..
				"label[0,3.5;New filename:]"..
					"field[4,4;4,0.5;save_as_filename;;"..shortened_building_name.."]"..
				"button[4,5;1.5,0.5;no_abort;Abort]"..
				"button[6,5;1.5,0.5;save_as;Save]";
		elseif( not(is_restore) or is_restore ~= 1 ) then
			return formspec.."button[0.5,3;4,0.5;proceed_with_scaffolding;Check project status/update]"..
				 "button[0.5,4;4,0;restore_backup;Restore original landscape]"..
		                 "button[1,5;3,0.5;show_materials;Show materials used]"..
		                 "button[0.5,8.5;4,0.5;save_file_as;Save current building as..]"..
				 "label[5,2.5;Materails needed to complete project:]"..
				 "label[5,9;"..nodes_to_dig.." blocks need to be digged/removed]"..
				 "list[nodemeta:"..pos.x..","..pos.y..","..pos.z..";needed;5,3;8,6;]";
		else
			return formspec.."button[0,3;5,0.5;restore_backup;Check landscape restauration state/update]"..
				 "button[0,4;5,0.5;proceed_with_scaffolding;Switch back to planned project]"..
		                 "button[1,5;3,0.5;show_materials;Show materials used]"..
		                 "button[0,6;5,0.5;abort_project;Abort this project and select new]"..
		                 "button[0.5,8.5;4,0.5;save_file_as;Save current building as..]"..
				 "label[5,2.5;Materails needed to complete project:]"..
				 "label[5,9;"..nodes_to_dig.." blocks need to be digged/removed]"..
				 "list[nodemeta:"..pos.x..","..pos.y..","..pos.z..";needed;5,3;8,6;]";
		end
	end

	local current_path = minetest.deserialize( meta:get_string( 'current_path' ) or 'return {}' );
	if( #current_path > 0 ) then
		formspec = formspec.."button[9.9,0.4;2,0.5;back;Back]";
	end


	-- offer a menu to set the positions for saving a building
	if( #current_path > 0 and current_path[1]=='save a building' ) then
		return handle_schematics.update_formspec_save_building( formspec, meta, player, fields, pos);
	end


	-- offer diffrent replacement groups
	local formspec_group_replacement = handle_schematics.get_formspec_group_replacement( pos, fields, formspec );
	if( formspec_group_replacement ) then
		return formspec_group_replacement;
	end

	if( fields.preview and building_name ) then
		meta:set_string('preview',fields.preview); -- just so that we know what to do when the back-button is hit
		return formspec..build_chest.preview_image_formspec( building_name,
					build_chest.replacements_get_current( meta, village_id ), fields.preview);
	end


	-- show list of all node names used
	local start_pos     = meta:get_string('start_pos');
	if( building_name and building_name ~= '' and start_pos and start_pos ~= '' and meta:get_string('replacements')) then
		-- allow changes to the replacement list
		return formspec..build_chest.replacements_get_list_formspec( pos, nil, 1, meta, village_id, building_name, meta:get_int('replace_row') );
	end

	-- find out where we currently are in the menu tree
	local menu = build_chest.menu;
	for i,v in ipairs( current_path ) do
		if( menu and menu[ v ] ) then
			menu = menu[ v ];
		end
	end

	-- all submenu points at this menu position are options that need to be shown
	local options = {};
	for k,v in pairs( menu ) do
		table.insert( options, k );
	end

	-- handle if there are multiple files under the same menu point
	if( #options == 0 and build_chest.building[ current_path[#current_path]] ) then
		options = {current_path[#current_path]};
	end

	-- we have found an end-node - a particular building
	if( #options == 1 and options[1] and build_chest.building[ options[1]] ) then
		-- a building has been selected
		meta:set_string( 'building_name', options[1] );
		local start_pos = build_chest.get_start_pos( pos, nil, nil );
		if( type(start_pos)=='table' and start_pos and start_pos.x and build_chest.building[ options[1]].size) then
			-- size information has just been read; we can now display it
			formspec = formspec..build_chest.show_size_data( building_name );

			-- do replacements for realtest where necessary (this needs to be done only once)
			local replacements = {};
			replacements_group['realtest'].replace( replacements );
			-- do replacements for nodes that no longer exist
			replacements_group['discontinued_nodes'].replace( replacements );
			meta:set_string( 'replacements', minetest.serialize( replacements ));

			-- allow changes to be made
			return formspec..build_chest.replacements_get_list_formspec( pos, nil, 1, meta, village_id, building_name, meta:get_int('replace_row') );
		elseif( type(start_pos)=='string' ) then
			return formspec.."label[3,3;Error reading building data:]"..
					 "label[3.5,3.5;"..start_pos.."]";
		else
			return formspec.."label[3,3;Error reading building data.]";
		end
	end
	table.sort( options );

	local page_nr = meta:get_int( 'page_nr' );
	-- if the options do not fit on a single page, split them up
	if( #options > build_chest.MAX_OPTIONS ) then 
		if( not( page_nr )) then
			page_nr = 0;
		end
		local new_options = {};
		local new_index   = build_chest.MAX_OPTIONS*page_nr;
		for i=1,build_chest.MAX_OPTIONS do
			if( options[ new_index+i ] ) then
				new_options[ i ] = options[ new_index+i ];
			end
		end

		-- we need to add prev/next buttons to the formspec
		formspec = formspec.."label[7.5,1.5;"..minetest.formspec_escape(
			"Showing "..tostring( new_index+1 )..
			       '-'..tostring( math.min( new_index+build_chest.MAX_OPTIONS, #options))..
			       '/'..tostring( #options )).."]";
		if( page_nr > 0 ) then
			formspec = formspec.."button[9.5,1.5;1,0.5;prev;prev]";
		end
		if( build_chest.MAX_OPTIONS*(page_nr+1) < #options ) then
			formspec = formspec.."button[11,1.5;1,0.5;next;next]";
		end
		options = new_options;
	end

      
                -- found an end node of the menu graph
--                elseif( build_chest.stages_formspec_page_first_stage ) then
--			return build_chest.stages_formspec_page_first_stage( v.menu_path[( #current_path )], player, pos, meta, );
--                end

	-- show the menu with the next options
	local i = 0;
	local x = 0;
	local y = 0;
	if( #options < 9 ) then
		x = x + 4;
	end
	-- order alphabeticly
	table.sort( options, function(a,b) return a < b end );

	for index,k in ipairs( options ) do

		i = i+1;

		-- new column
		if( y==8 ) then
			x = x+4;
			y = 0;
		end

		formspec = formspec .."button["..(x)..","..(y+2.5)..";4,0.5;selection;"..k.."]"
		y = y+1;
		--x = x+4;
	end

	return formspec;
end



build_chest.on_receive_fields = function(pos, formname, fields, player)

	if( not(pos)) then
		return;
	end
	local meta = minetest.get_meta(pos);

	local owner = meta:get_string('owner');
	local pname = player:get_player_name();

	-- make sure not everyone can mess up the build chest
	if( owner and owner ~= '' and owner ~= pname 
	    and minetest.is_protected( pos, pname )) then
		minetest.chat_send_player( pname,
			"Sorry. This build chest belongs to "..tostring( owner ).." and only "..
			"accepts input from its owner or other players who can build here.");
		return;
	end

	local building_name = meta:get_string('building_name' );
	-- the statistic is needed for all the replacements later on as it also contains the list of nodenames
	if( building_name and building_name~="" and (not( build_chest.building[ building_name ]) or not( build_chest.building[ building_name ].size ))) then
		build_chest.read_building( building_name );
	end

-- general menu handling
	-- back button selected
	if( fields.back ) then

		local preview = meta:get_string('preview');
		if( preview and preview ~= "" ) then
			meta:set_string('preview',"");
		else
			local current_path = minetest.deserialize( meta:get_string( 'current_path' ) or 'return {}' );

			table.remove( current_path ); -- revert latest selection
			meta:set_string( 'current_path', minetest.serialize( current_path ));
			meta:set_string( 'building_name', '');
			meta:set_int(    'replace_row', 0 );
			meta:set_int(    'page_nr',     0 );
			meta:set_string( 'saved_as_filename', nil);
		end

	-- menu entry selected
	elseif( fields.selection ) then

		local current_path = minetest.deserialize( meta:get_string( 'current_path' ) or 'return {}' );
		table.insert( current_path, fields.selection );
		meta:set_string( 'current_path', minetest.serialize( current_path ));

	-- if there are more menu items than can be shown on one page: show previous page
	elseif( fields.prev ) then
		local page_nr = meta:get_int( 'page_nr' );
		if( not( page_nr )) then
			page_nr = 0;
		end
		page_nr = math.max( page_nr - 1 );
		meta:set_int( 'page_nr', page_nr );
     
	-- if there are more menu items than can be shown on one page: show next page
	elseif( fields.next ) then
		local page_nr = meta:get_int( 'page_nr' );
		if( not( page_nr )) then
			page_nr = 0;
		end
		meta:set_int( 'page_nr', page_nr+1 );

-- specific to the build chest
	-- the player has choosen a material from the list; ask for a replacement
	elseif( fields.build_chest_replacements ) then
		local event = minetest.explode_table_event( fields.build_chest_replacements ); 
		local building_name = meta:get_string('building_name');
		if( event and event.row and event.row > 0
		   and building_name
		   and build_chest.building[ building_name ] ) then
	
			meta:set_int('replace_row', event.row );
		end

	-- the player has asked for a particular replacement
	elseif( fields.store_replacement
	    and fields.replace_row_with     and fields.replace_row_with ~= ""
	    and fields.replace_row_material and fields.replace_row_material ~= "") then
   
		build_chest.replacements_apply( pos, meta, fields.replace_row_material, fields.replace_row_with, nil );

	elseif( fields.replace_rest_with_air ) then
		build_chest.replacements_replace_rest_with_air( pos, meta );

	elseif( fields.wood_selection ) then
		build_chest.replacements_apply_for_group( pos, meta, 'wood',    fields.wood_selection,    fields.set_wood,    nil );
		fields.set_wood    = nil;

	elseif( fields.farming_selection ) then
		build_chest.replacements_apply_for_group( pos, meta, 'farming', fields.farming_selection, fields.set_farming, nil );
		fields.set_farming = nil;

	elseif( fields.roof_selection ) then
		build_chest.replacements_apply_for_group( pos, meta, 'roof',    fields.roof_selection,    fields.set_roof,    nil );
		fields.set_roof    = nil;


	elseif( fields.proceed_with_scaffolding ) then
		-- used for indicating which mode (actual project or landscape restauration) we are in; here: actual project
		meta:set_int('is_restore', 0);
		local building_name = meta:get_string('building_name');
		local start_pos     = minetest.deserialize( meta:get_string('start_pos'));
		local end_pos       = minetest.deserialize( meta:get_string('end_pos'));
		-- create a backup of this landscape if none exists yet
		handle_schematics.backup_landscape(meta, start_pos, end_pos, pname, false);
		
		local village_id   = meta:get_string( 'village_id' );
		local replacement_list = build_chest.replacements_get_current( meta, village_id );
		local rotate = meta:get_string('rotate');
		local mirror = meta:get_string('mirror');
		local axis   = build_chest.building[ building_name ].axis;
		local no_plotmarker = 1;
		-- actually place the building
		--minetest.place_schematic( start_pos, building_name..'.mts', rotate, replacement_list, true );
mirror = nil;

		-- players who do not have the creative priv cannot produce nodes out of thin air
		local use_scaffolding = false;
		if( not( minetest.check_player_privs( pname, {creative=true}))) then
			use_scaffolding = true;
		end
		fields.error_msg = handle_schematics.place_building_from_file( start_pos, end_pos, building_name, replacement_list, rotate, axis, mirror, no_plotmarker, false, use_scaffolding, pos );
		if( fields.error_msg ) then
			fields.error_msg = 'Error: '..tostring( fields.error_msg );
		end

	-- restore the original landscape
	elseif( fields.restore_backup ) then
		handle_schematics.restore_landscape( meta, pname, false, pos);

	-- there has to be a way to abort a project and select another building/project elseif( fields.yes_abort_project ) then
	elseif( fields.yes_abort_project ) then
		handle_schematics.abort_project_remove_indicators( meta );

		-- without existing backup it is possible to switch back in the menu
		meta:set_string('backup', nil );


	-- store a new end position
	elseif( fields.set_end_pos ) then
		local node = minetest.get_node( pos );
		if( node and node.param2 ) then
			build_chest.end_pos_list[ pname ] = {x=pos.x, y=pos.y, z=pos.z, param2=node.param2 };
		end


	elseif( fields.set_start_pos ) then
		local error_msg = "";
		local end_pos = build_chest.end_pos_list[ pname ];
		if( not( end_pos )) then
			error_msg = "Please mark the end position of your building first!";
		else
			local node = minetest.get_node( pos );
			if( not( node ) or not( node.param2 )) then
				error_msg = "A strange error happened.";
			elseif( (node.param2 == 0 and end_pos.param2 ~= 2)
			     or (node.param2 == 1 and end_pos.param2 ~= 3)
			     or (node.param2 == 2 and end_pos.param2 ~= 0)
			     or (node.param2 == 3 and end_pos.param2 ~= 1)) then
				error_msg = "One build chest needs to point to the front of your building, and "..
					"the other one to the backside. This does not seem to be the case.";

			elseif( (node.param2 == 2 and ( pos.x < end_pos.x or pos.z < end_pos.z )) -- x and z need to get larger
			     or (node.param2 == 3 and ( pos.x < end_pos.x or pos.z > end_pos.z )) -- x gets larger, z gets smaller
			     or (node.param2 == 0 and ( pos.x > end_pos.x or pos.z > end_pos.z )) -- x and z need to get smaller
			     or (node.param2 == 1 and ( pos.x > end_pos.x or pos.z < end_pos.z )) -- x gets smaller, z gets larger
				) then
				error_msg = "The end position does not fit to the orientation of this build chest.";

			-- the chest takes up one node as well
			elseif( math.abs(pos.x-end_pos.x)<1) then
				error_msg = "Start- and end position share the same x value.";

			elseif( math.abs(pos.z-end_pos.z)<1) then
				error_msg = "Start- and end position share the same z value.";

			-- all ok; we may proceed
			else
				error_msg = "";
				build_chest.end_pos_list[ pname ].start_pos = {x=pos.x, y=pos.y, z=pos.z, param2=node.param2 };
			end
			fields.error_msg = error_msg;
		end 

	-- in case the player selected the wrong chest for the save dialog
	elseif( fields.abort_set_start_pos ) then
		local end_pos = build_chest.end_pos_list[ pname ];
		if( end_pos ) then
			build_chest.end_pos_list[ pname ].start_pos = nil;
		end


	elseif( fields.save_as ) then
		if( fields.save_as_p1 and fields.save_as_p2 and fields.save_as_filename ) then
			-- restore p1 and p2, the positions of the area that is to be saved
			local p1 = minetest.string_to_pos( fields.save_as_p1 );
			local p2 = minetest.string_to_pos( fields.save_as_p2 );

			-- take height changes into account
			if( fields.save_as_height ) then
				local new_height = tonumber( fields.save_as_height );
				-- the new height is measured from the start position as well
				if( new_height and new_height ~= (math.abs(p1.y-p2.y)+1)) then
					p2.y = p1.y+new_height;
				end
			end
				
			local burried = 0;
			if( fields.save_as_yoff ) then
				burried = tonumber( fields.save_as_yoff );
				if( not( burried )) then
					burried = 0;
				end
				-- the yoffset is applied to the start position
				p1.y = p1.y + burried;
				-- TODO: real negative values are not supported by analyze_mts_file
				if( burried ~= 0 ) then
					burried = -1*burried;
				end
			end

			-- create an automatic filename if none is provided
			local filename = fields.save_as_filename;
			-- TODO: check the input if it contains only allowed chars (a-z, A-Z, 0-9, -, _, .)
			if( not( filename )) then
				filename = pname..'_'..tostring( p1 )..'_'..tostring(p2);
			end

			-- param2 needs to be translated inio initial rotation as well
			local node = minetest.get_node( pos );
			if(     node.param2 == 0 ) then
				filename = filename..'_'..burried..'_90';
			elseif( node.param2 == 3 ) then
				filename = filename..'_'..burried..'_180';
			elseif( node.param2 == 1 ) then
				filename = filename..'_'..burried..'_0';
			elseif( node.param2 == 2 ) then
				filename = filename..'_'..burried..'_270';
			end
			-- TODO: forbid overwriting existing files?
			local worldpath = minetest.get_worldpath();
			local filename_complete = worldpath..'/schems/'..filename..'.mts';

			handle_schematics.create_schematic_with_meta( p1, p2, filename );

			-- store that we have saved this area
			meta:set_string('saved_as_filename', filename);
			meta:set_string('p1', minetest.pos_to_string( p1 ));
			meta:set_string('p2', minetest.pos_to_string( p2 ));
			-- forget the end position
			build_chest.end_pos_list[ pname ] = nil;

			-- add this chest to the menu
			local worldnameparts = string.split( worldpath, '/worlds/' );
			if( not( worldnameparts ) or #worldnameparts < 1 ) then
				worldnameparts = {'unkown world'};
			end
			local new_path = {'main','worlds', worldnameparts[ #worldnameparts], 'schems', filename, worldpath..'/schems/'..filename};
			build_chest.add_entry( new_path );
			build_chest.add_building( worldpath..'/schems/'..filename, {scm=filename, typ='nn'});

			meta:set_string( 'current_path',  minetest.serialize( new_path ));
			meta:set_string( 'building_name', worldpath..'/schems/'..filename);
			meta:set_int(    'replace_row', 0 );
			meta:set_int(    'page_nr',     0 );

			minetest.chat_send_player( pname,
				'Created schematic \''..tostring( filename )..'\'. Saved area from '..
				minetest.pos_to_string( p1 )..' to '..
				minetest.pos_to_string( p2 ));
		end
	end
	-- the final build stage may offer further replacements
	if( build_chest.stages_on_receive_fields ) then
		build_chest.stages_on_receive_fields(pos, formname, fields, player, meta);
	end

	local formspec = build_chest.update_formspec( pos, 'main', player, fields );
	-- add the position information so that we can show the formspec directly and still find out
	-- which build chest was responsible
	formspec = formspec.."field[20,20;0.1,0.1;pos2str;Pos;"..minetest.pos_to_string( pos ).."]";
	-- save the formspec data to the chest
	meta:set_string( 'formspec', formspec );
	-- show the formspec directly to the player to make it react more smoothly
	minetest.show_formspec( pname, "handle_schematics:build", formspec );
end



minetest.register_node("handle_schematics:build", { --TODO
	description = "Building-Spawner",
	tiles = {"default_chest_side.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
--        drawtype = 'signlike',
--        paramtype = "light",
--        paramtype2 = "wallmounted",
--        sunlight_propagates = true,
--        walkable = false,
--        selection_box = {
--                type = "wallmounted",
--        },

	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
        after_place_node = function(pos, placer, itemstack)

 -- TODO: check if placement is allowed
      
           local meta = minetest.get_meta( pos );
           meta:set_string( 'current_path', minetest.serialize( {} ));
           meta:set_string( 'village',      'BEISPIELSTADT' ); --TODO
           meta:set_string( 'village_pos',  minetest.serialize( {x=1,y=2,z=3} )); -- TODO
           meta:set_string( 'owner',        placer:get_player_name());

           meta:set_string('formspec', build_chest.update_formspec( pos, 'main', placer, {} ));
        end,
        on_receive_fields = function( pos, formname, fields, player )
           return build_chest.on_receive_fields(pos, formname, fields, player);
        end,
        -- taken from towntest 
        allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
                if from_list=="needed" or to_list=="needed" then return 0 end
                return count
        end,
        allow_metadata_inventory_put = function(pos, listname, index, stack, player)
                if listname=="needed" then return 0 end
                return stack:get_count()
        end,
        allow_metadata_inventory_take = function(pos, listname, index, stack, player)
                if listname=="needed" then return 0 end
--                if listname=="lumberjack" then return 0 end
                return stack:get_count()
        end,

        can_dig = function(pos,player)
            local meta          = minetest.get_meta( pos );
            local inv           = meta:get_inventory();
            local owner_name    = meta:get_string( 'owner' );
            local building_name = meta:get_string( 'building_name' );
            local name          = player:get_player_name();

            if( not( meta ) or not( owner_name )) then
               return true;
            end
            if( owner_name ~= name ) then
               minetest.chat_send_player(name, "This building chest belongs to "..tostring( owner_name )..". You can't take it.");
               return false;
            end
            if( building_name ~= nil and building_name ~= "" ) then
               minetest.chat_send_player(name, "This building chest has been assigned to a building project. You can't take it away now.");
               return false;
            end
            return true;
        end,

        -- have all materials been supplied and the remaining parts removed?
        on_metadata_inventory_take = function(pos, listname, index, stack, player)
            local meta          = minetest.get_meta( pos );
            local inv           = meta:get_inventory();
            local stage         = meta:get_int( 'building_stage' );
            
            if( inv:is_empty( 'needed' ) and inv:is_empty( 'main' )) then
               if( stage==nil or stage < 6 ) then
                  build_chest.update_needed_list( pos, stage+1 ); -- request the material for the very first building step
               else
		  -- TODO: show this update directly to the player via minetest.show_formspec( pname, formname, formspec );
                  meta:set_string( 'formspec', build_chest.update_formspec( pos, 'finished', player, {} ));
               end
            end
        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)
            return build_chest.on_metadata_inventory_put( pos, listname, index, stack, player );
        end,
})


-- a player clicked on something in a formspec he was shown
handle_schematics.form_input_handler = function( player, formname, fields)
	if(formname == "handle_schematics:build" and fields and fields.pos2str) then
		local pos = minetest.string_to_pos( fields.pos2str );
		build_chest.on_receive_fields(pos, formname, fields, player);
	end
end

-- make sure we receive player input; needed for showing formspecs directly (which is in turn faster than just updating the node)
minetest.register_on_player_receive_fields( handle_schematics.form_input_handler );
