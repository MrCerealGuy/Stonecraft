local build_chest_add_files_to_menu_from_directory = function( schem, path, entry_name, backup_name, menu_path_list)
	-- we need the filename without extension (*.mts, *.we, *.wem)
	local schemname = schem;
	local i = string.find(           schem, '.mts',  -4 );
	if( i ) then
		schemname = string.sub( schem, 1, i-1 );
	else
		i = string.find(         schem, '.we',   -3 );
		if( i ) then
			schemname = string.sub( schem, 1, i-1 );
		else
			i = string.find( schem, '.wem',  -4 );
			if( i ) then
				schemname = string.sub( schem, 1, i-1 );
			else
				i = string.find( schem, '.schematic', -10 );
				if( i ) then
					schemname = string.sub( schem, 1, i-1 );
				else
					return;
				end
			end
		end
	end

	-- only add known file types
	if( not( schemname )) then
		return;
	end

	i = string.find( schemname, 'backup_' );
	menu_path_list[ #menu_path_list+1 ] = schemname;
	menu_path_list[ #menu_path_list+1 ] = path..schemname;
	-- probably one of those automatic backups of the landscape
	if( i and i==1 and backup_name) then
		menu_path_list[1] = backup_name;
	-- normal entry
	else
		menu_path_list[1] = entry_name;
	end
	build_chest.add_entry(    menu_path_list);
	build_chest.add_building( path..schemname, {scm=schemname, typ='nn'});
end


-- search for mods and modpacks containing schematics in any form
local build_chest_check_all_directories_mods_and_modpacks = function( path, menu_title, gamename )
	local d2 = minetest.get_dir_list( path..'/mods', true );
	for _,modname in ipairs( d2 ) do
		local d3 = minetest.get_dir_list( path..'/mods/'..modname, true );
		for _,subdir in ipairs( d3 ) do
			if( subdir ~= 'textures' and subdir ~= 'sounds' and subdir ~= 'models' and subdir ~= '.git' and subdir ~= 'locale') then
				local d4 = minetest.get_dir_list( path..'/mods/'..modname..'/'..subdir, false );
				for _,filename in ipairs( d4 ) do
					build_chest_add_files_to_menu_from_directory(
						filename,
						path..'/mods/'..modname..'/'..subdir..'/',
						menu_title,
						nil,
						{'OVERWRITE THIS', gamename, modname} );
				end
				-- it might be a modpack
				d4 = minetest.get_dir_list( path..'/mods/'..modname..'/'..subdir, true );
				for _,subsubdir in ipairs( d4 ) do
					if( subsubdir ~= 'textures' and subsubdir ~= 'sounds' and subsubdir ~= 'models' and subsubdir ~= '.git' and subsubdir ~= 'locale') then
						local d5 = minetest.get_dir_list( path..'/mods/'..modname..'/'..subdir..'/'..subsubdir, false );
						for _,filename in ipairs( d5 ) do
							build_chest_add_files_to_menu_from_directory(
								filename,
								path..'/mods/'..modname..'/'..subdir..'/'..subsubdir..'/',
								menu_title,
								nil,
								-- folders from modpacks get marked with a *..*
								{'OVERWRITE THIS', gamename, '*'..subdir..'*'} );
						end
					end
				end
			end
		end
	end
end

build_chest.add_files_from_path = function( worldpath, worldname )
	-- get list of subdirectories
	local path = worldpath..'/'..worldname;
	local subdir_list = minetest.get_dir_list( path, true );
	if( not( subdir_list )) then
		return;
	end
	for _,subdir in ipairs( subdir_list ) do
		if( subdir=='schems' ) then
			local file_list = minetest.get_dir_list( path..'/schems', false );
			for _,filename in ipairs( file_list ) do
				build_chest_add_files_to_menu_from_directory(
					filename,
					path..'/schems/',
					'import from world',
					'landscape backups',
					{'OVERWRITE THIS', worldname });
			end
		end
	end
end


local build_chest_check_all_directories = function()
	-- find the name of the directory directly above the current worldpath
	local worldpath = minetest.get_worldpath();

	local p = 1;
	local last_found = 1;
	while( last_found ) do
		p =         last_found;
		last_found = string.find( worldpath, '/', last_found+1 );
	end 
	-- abort on Windows
	if( p == 1 ) then
		return;
	end
	worldpath = string.sub( worldpath, 1, p );	
		
--[[
	local p = 1;
	while( not( string.find( worldpath, '/', -1*p ))) do
		p = p+1;
	end
	local found = 1;
	for p=string.len( worldpath ),1,-1 do
		if(  p>found
		  and (string.byte( worldpath, p )=='/'
		    or string.byte( worldpath, p )=='\\')) then
			found = p;
		end
	end
--]]
--	worldpath = string.sub( worldpath, 1, string.len( worldpath )-p );

	-- locate .mts, .wem and .we files in the worlds/WORLDNAME/schems/* folders
	local d1 = minetest.get_dir_list( worldpath, true );
	for _,worldname in ipairs( d1 ) do
		build_chest.add_files_from_path( worldpath, worldname );
	end

	local main_path = string.sub( worldpath, 1, string.len(worldpath)-string.len('/worlds'));

	-- search in MODS/* subfolder
	build_chest_check_all_directories_mods_and_modpacks( main_path, 'import from mod', 'mods' );

	-- search in all GAMES/* folders for mods containing schematics
	local game_path = main_path..'/games';
	d1 = minetest.get_dir_list( game_path, true );
	for _,gamename in ipairs( d1 ) do
		build_chest_check_all_directories_mods_and_modpacks( game_path..'/'..gamename, 'import from game', gamename );
	end
end


-- TODO: hopfefully, security will get more relaxed regarding reading directories in the future
-- if security is enabled, our options to get schematics are a bit limited
--if( minetest.settings:get( 'secure.enable_security' )) then
if( minetest.get_dir_list ) then
	local worldpath = minetest.get_worldpath();
	local d3 = minetest.get_dir_list( worldpath..'/schems', false );
	if( d3 ) then
		for _,filename in ipairs( d3 ) do
			build_chest_add_files_to_menu_from_directory(
						filename,
						worldpath..'/schems/',
						'import from world',
						'landscape backups',
						{'OVERWRITE THIS', '-current world-' });
		end
	end
else
	-- check worlds, mods and games folders for schematics and add them to the menu
	build_chest_check_all_directories()
end
