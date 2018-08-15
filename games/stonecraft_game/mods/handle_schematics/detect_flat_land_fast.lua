
-- works on the heightmap obtained in register.on_generated;
-- returns all places where a flat area with dimensions lookfor_x_dim and
--    lookfor_z_dim exists
-- Returns: { places_x = {array}, places_z = {array}}
--          with places_x: indices in heightmap where the previous
--                         lookfor_x_dim x lookfor_z_dim nodes are flat
--          and  places_z: indices in heightmap where the previous
--                         lookfor_z_dim x lookfor_x_dim nodes are flat
-- minheight and maxheight determine weather places will be acceptable
--   and returned; use it to i.e. get no places under water
-- allow_floating          ships and submarines do not really require the
--                         ground below them to be flat; shipwrecks may sink
--                         partly into the ground; other sunken structures
--                         may need this to be set to false
handle_schematics.find_flat_land_get_candidates_fast = function( heightmap, minp, maxp, lookfor_x_dim, lookfor_z_dim, minheight, maxheight, allow_floating )

	-- return empty result if search is invalid
	if(  lookfor_x_dim < 1
	  or lookfor_z_dim < 1
	  -- we can't handle more than one mapchunk at a time this way
	  or lookfor_x_dim > (maxp.x - minp.x - 2)
	  or lookfor_z_dim > (maxp.z - minp.z - 2)) then
		return {};
	end
	-- the return value; will contain the indices (of heightmap) where the
	-- searched for flat space exists
	local places_x = {}; -- lookfor_x_dim x lookfor_z_dim is flat
	local places_z = {}; -- lookfor_z_dim x lookfor_x_dim is flat

	-- the last zrun[ ax ] blocks in this column all had the same height
	local zrun = {};
	local chunksize = maxp.x-minp.x+1;
	-- the last count blocks in this row had the same height
	local count=1;
	-- how many zrun[ ax ] values (columns) had the right height value
	-- up until now?
	local check_before_x = 0;
	local check_before_z = 0;

	-- last height in x direction
	local lastheight = -1;
        local i = 0;
	local ax = 0;
 	local az = 0;

	-- identify and mark places that are flat areas of the required size
	for az=minp.z,maxp.z do
	for ax=minp.x,maxp.x do
		i = i+1;

		local height = heightmap[ i ];
		-- fallback if no height is provided
		if( not(height)) then
			height = 0;
		end

		-- water just has to be deep enough
		if(( height==lastheight and ax>minp.x)
		   or (allow_floating and height<0 and height<=maxheight and lastheight<=maxheight and ax>minp.x)) then
			count = count+1;
		else
			count = 1;
			-- new height - start new before-check
			check_before_x = 0;
			check_before_z = 0;
		end
		lastheight = height;

		-- count in z direction as well
		local height2 = heightmap[ i-chunksize ];
		if( not(height2)) then
			height2 = 0;
		end
		-- it is enough to remember the last row in zrun
		if(( height==height2 and az>minp.z)
		   or (allow_floating and height<0 and height<=maxheight and height2<=maxheight and az>minp.z)) then
			zrun[ ax ] = zrun[ ax ]+1;
		else
			zrun[ ax ] = 1;
		end

		-- the candidates before this one have to have enough space
		-- as well
		if( zrun[ ax ]    >= lookfor_z_dim ) then
			check_before_z = check_before_z + 1;
		else
			check_before_z = 1;
		end
		if( zrun[ ax ]    >= lookfor_x_dim ) then
			check_before_x = check_before_x + 1;
		else
			check_before_x = 1;
		end

		if(     count       >= lookfor_x_dim
		 and check_before_z >= lookfor_x_dim
		 and height >= minheight
		 and height <= maxheight
		 and height < maxp.y 
		 and height > minp.y) then
			table.insert( places_x, i );
		end
		-- the place might fit if the building is rotated by 90 degree;
		-- a place be suitable for both rotations
		if(  count       >= lookfor_z_dim
		 and check_before_x >= lookfor_z_dim
		 and height >= minheight
		 and height <= maxheight
		 and height < maxp.y
		 and height > minp.y) then
			table.insert( places_z, i );
		end
	end
	end
	return {places_x=places_x, places_z=places_z};
end


-- return just one place suitable for building something of size sizex x sizez
-- at a height no less than minheight and no more than maxheight;
-- find_flat_land_get_candidates_fast is used to find all places suitable for
-- that in this mapchunk. This function here selects a random one of those
-- places and returns a suitable rotation.
-- margin_front, margin_back, margin_right and margin_left are added as it does
--   not look well if there is i.e. just one free space in front of the front
--   door
handle_schematics.find_flat_land_for_building_with_border = function( heightmap, minp, maxp,
	sizex, sizez, minheight, maxheight,
	margin_front, margin_back, margin_right, margin_left,
	initial_rotation,
	allow_floating
	)

	-- handle initial rotation (orients) if our building is rotated by 90 or 270 degree
	if( initial_rotation and initial_rotation%2==1 ) then
		local tmp = sizex;
		sizex = sizez;
		sizez = tmp;
		tmp = nil;
	end

	local sizex_full = sizex + margin_front + margin_back - 1;
	local sizez_full = sizez + margin_right + margin_left - 1;
	-- find candidates
	local res = handle_schematics.find_flat_land_get_candidates_fast( heightmap, minp, maxp,
		sizex_full, sizez_full,
		minheight, maxheight, allow_floating );

	--print("Found normal: "..tostring( #res.places_x ).." and rotated: "..tostring( #res.places_z ));
	-- nothing suitable found? then abort
	if( (#res.places_x + #res.places_z )< 1 ) then
		return;
	end

	-- select a random place - either sizex x sizez or sizez x sizex
	local c = math.random( 1, #res.places_x + #res.places_z );
	local i = 1;
	local rotation = 0;
	-- if the place is part of res.places_z...
	if( c > #res.places_x ) then
		i = res.places_z[ c-#res.places_x ];
		-- swap x and z due to rotation of 90 or 270 degree
		local tmp = sizex;
		sizex = sizez;
		sizez = tmp;
		-- swap sizex_full and sizez_full as well (those include the margins)
		tmp = sizex_full;
		sizex_full = sizez_full;
		sizez_full = tmp;
		tmp = nil;
		if( math.random(1,2)==1 ) then
			rotation = "270";
		else
			rotation =  "90";
		end
	-- or part of res.places_x...
	else
		i = res.places_x[ c ];
		if( math.random(1,2)==1 ) then
			rotation =  "0";
		else
			rotation = "180";
		end
	end

	local chunksize = maxp.x - minp.x + 1;
	-- translate index back into coordinates
	local p = {x=minp.x+(i%chunksize)-1, y=heightmap[ i ], z=minp.z+math.floor(i/chunksize)};

	-- the index in the heightmap
	p.i = i;

	-- p.plot_start and p.plot_end mark the total area of the entire plot,
	-- including building and borders; perhaps this will be of intrest
	-- later on (i.e. for clearing the place in margin_front from trees
	-- etc); p.plot.p1 marks the begining of the plot
	p.plot_end      = { x = p.x,              y = p.y, z = p.z };
	p.plot_start    = { x = p.x - sizex_full, y = p.y, z = p.z - sizez_full };
	p.plot_rotation = rotation;

	-- the actual start and end coordinates for the building;
	-- y is always on the same plane; x and z need to be calculated
	p.build_end     = { y = p.y };
	p.build_start   = { y = p.y };
	-- the building may have been stored in a rotated way in the schematic
	-- file; we need to adjust the rotation when placing it
	p.build_rotation = tostring((p.plot_rotation + (initial_rotation*90))%360);
	-- determine x and z
	if(     p.plot_rotation=="270") then
		p.build_start.z = p.plot_start.z + margin_front;
		p.build_start.x = p.plot_start.x + margin_right;
	elseif( p.plot_rotation== "90") then
		p.build_start.z = p.plot_start.z + margin_back;
		p.build_start.x = p.plot_start.x + margin_right;
	elseif( p.plot_rotation==  "0") then
		p.build_start.x = p.plot_start.x + margin_front;
		p.build_start.z = p.plot_start.z + margin_right;
	elseif( p.plot_rotation=="180") then
		p.build_start.x = p.plot_start.x + margin_back;
		p.build_start.z = p.plot_start.z + margin_left;
	else
		-- error: wrong rotation
		return;
	end
	p.build_end.z = p.build_start.z + sizez - 1;
	p.build_end.x = p.build_start.x + sizex - 1;

	return p;
end



-- Places a schematic read from filename on flat land found somewhere in the
-- current mapchunk (determined by minp, maxp). Rotation and replacements
-- will be random.
--
-- Note: There is no guarantee that a place can be found. If no sufficiently
--       large flat space is found, the schematic will NOT be placed.
--       The larger the schematic (including margins) is, the less likely it
--       will be that such a place can be found (unless you use flat mapgen).
--
-- Parameter:
--   * heghtmap       heightmap of current mapchunk; can be obtained through
--                  minetest.get_mapgen_object('heightmap')
--   * minp, maxp   minimal and maximal coordinates of current mapchunk;
--                  can be obtained in register_on_generated
--   * sizex, sizez length of the schematic in x (resp. z) direction
--   * minheight    schematic will only be placed on flat land with at least a
--                  height of minheigt; negative minheigt means: under water
--   * maxheight    schematic will not be placed at higher locations than this
--   * margin_front added in front of the schematic so that there will be room
--                  to enter and exit the house; otherwise buildings may look
--                  strange (few people want a mountain or deep drop right in 
--                  of their main door)
--   * margin_back, margin_right, margin_left further margins used to let the
--                  house stand out more;
--   * filename     full path to the schematic including .mts extension
--   * replacements will be filled randomly, but can also be provided
--   * yoffset      some schematics may have basements
--   * initial_rotation some schematics need to be rotated first so that their
--                  front shows up at the front. Allowed values: 0,1,2 or 3
-- Returns information about where and how the building was placed.
-- TODO: pass yoffset on to the search-for-place-function as well?
-- TODO: read a larger voxelmanip area for tree modifications?
handle_schematics.place_schematic_on_flat_land = function( heightmap, minp, maxp,
	sizex, sizez, minheight, maxheight,
	margin_front, margin_back, margin_right, margin_left,
	filename, replacements, yoffset, initial_rotation,
	binfo,
	allow_floating
	)

	-- find a flat area of the required size
	local p = handle_schematics.find_flat_land_for_building_with_border( heightmap, minp, maxp,
		sizex, sizez, minheight, maxheight,
		margin_front, margin_back, margin_right, margin_left, initial_rotation, allow_floating );
	if( not( p )) then
		return;
	end

	if( not( binfo.yoff )) then
		binfo.yoff = 0;
	end

	-- ships tend to swim on water
	if( binfo.is_ship ) then
		-- TODO: get water level
		p.y             = 1;
		-- the ship starts below the water surface
		p.build_start.y = 1 + binfo.yoff;
		p.build_end.y   = 1;
		p.plot_start.y  = 1 + binfo.yoff;
		p.plot_end.y    = 1;
	end

	-- shipwrecks need to rest on the ground (more or less); we can also ignore
	-- the border around them
	if( binfo.is_submerged ) then
		-- first step: search for all nodes at the bottom of the schematic
		-- where the shipwreck connects to the ground - and see how deep
		-- we have to go so that each of these nodes rests on a ground node
		local chunksize = maxp.x - minp.x + 1;
		local target_height = 1;
		for x=1, binfo.sizex do
		for z=1, binfo.sizez do
			if(  binfo.scm_data_cache[1][x][z]
			 and binfo.scm_data_cache[1][x][z][1]~=c_air) then
				local nx, nz;
				if(     p.build_rotation=="0" ) then
					nx = p.build_start.x+x-1;
					nz = p.build_start.z+z-1;
				elseif( p.build_rotation=="90") then
					nx = p.build_start.x+z-1;
					nz = p.build_end.z-x+1;
				elseif( p.build_rotation=="180") then
					nx = p.build_end.x-x+1;
					nz = p.build_end.z-z+1;
				else
					nx = p.build_end.x-z+1;
					nz = p.build_start.z+x-1;
				end
				local h = heightmap[ (nz-minp.z)*chunksize + (nx-minp.x)];
				if( h and h>minp.y and h<target_height ) then
					target_height = h;
				end
			end
		end
		end
		-- there will be water or scenery there; no need to clean the area from
		-- trees or leaves
		p.build_start.y = target_height + binfo.yoff;
		p.build_end.y   = target_height;
		p.plot_start.y  = target_height + binfo.yoff;
		p.plot_end.y    = target_height;
		p.y             = target_height;
		p.plot_start    = p.build_start;
		p.plot_end      = p.build_end;
	end


	local vm = minetest.get_voxel_manip()
	local minp2, maxp2 = vm:read_from_map(
		{x=p.plot_start.x-1, y=p.plot_start.y-1, z=p.plot_start.z-1},
		{x=p.plot_end.x+1, y=maxp.y,          z=p.plot_end.z+1});
	local a = VoxelArea:new({MinEdge = minp2, MaxEdge = maxp2})
	local data        = vm:get_data()
	local param2_data = vm:get_param2_data();


	-- wood replacement may be derived from trees in the area
	local materials = {};

	-- identify the tree type and use that as replacement
	-- remove tree trunks; leave the first m of each ex-tree standing
	local tree_trunks = minetest.find_nodes_in_area(
		{x=p.plot_start.x, y=p.y+1,   z=p.plot_start.z},
		-- hopefully covers highest tree
		{x=p.plot_end.x,   y=p.y+1, z=p.plot_end.z },
		{"group:tree"});
	-- identify the tree type and use that as replacement
	if( tree_trunks and #tree_trunks > 0 ) then
		local tree_node = minetest.get_node( tree_trunks[1]);
		if( tree_node and tree_node.name ) then
			for k, wood_data in pairs( replacements_group['wood'].data) do
				if( wood_data and wood_data[4]==tree_node.name ) then
					-- take this wood type
					materials["wood"] = k;
				end
			end
		end
	end
	-- choose random replacements (apart from wood if that is already set)
	replacements = handle_schematics.replace_randomized( replacements, materials );
	local replacements_table = handle_schematics.get_replacement_table( nil, nil, replacements );
	local cid = handle_schematics.get_cid_table( replacements_table );

	-- clear area above ground for buildigns placed there; do not do this
	-- for shipwrecks and the like
	if( not( binfo.is_submerged )) then
		-- remove trees, leaves, snow etc.
		for ax=p.plot_start.x, p.plot_end.x do
		for az=p.plot_start.z, p.plot_end.z do
		for ay=p.y+2,          maxp.y do
			data[ a:index( ax, ay, az )] = cid.c_air;
		end
		end
		end
	end

--[[
	-- place 3 mese lamps so that buildings can be found easier while debugging
	local cid_meselamp = minetest.get_content_id( "default:meselamp" );
	for dy = p.y + 6, p.y + 26 do
		data[ a:index( p.x,dy,p.z )] = cid_meselamp;
	end
	
	local nodename="wool:white;"
	if(     p.plot_rotation=="270") then nodename = "wool:cyan";
	elseif( p.plot_rotation==  "0") then nodename = "wool:yellow";
	elseif( p.plot_rotation== "90") then nodename = "wool:orange";
	elseif( p.plot_rotation=="180") then nodename = "wool:blue";
	end
	local cid_wool = minetest.get_content_id( nodename );

	-- mark the area
	for dx = p.plot_start.x, p.plot_end.x do
		data[ a:index( dx,p.y,p.plot_start.z )] = cid_wool;
		data[ a:index( dx,p.y,p.plot_end.z   )] = cid_wool;
	end
	for dz = p.plot_start.z, p.plot_end.z do
		data[ a:index( p.plot_start.x,p.y,dz )] = cid_wool;
		data[ a:index( p.plot_end.x,  p.y,dz )] = cid_wool;
	end
--]]

	local extranodes = {}
	local extra_calls = { on_constr = {}, trees = {}, chests = {}, signs = {}, traders = {}, door_a = {}, door_b = {}, scaffolding = {}, clear_meta = {}, beds = {}, workplaces = {} };


	local start_pos = {x=p.build_start.x, y=p.y, z=p.build_start.z,
		scm = filename,
		brotate = p.build_rotation/90,
		no_plotmarker = true;
		};

	start_pos.bsizex = math.abs(p.build_end.x - start_pos.x)+1;
	start_pos.bsizez = math.abs(p.build_end.z - start_pos.z)+1;
	p.start_pos = start_pos;
	-- last parameter false -> place dirt nodes instead of trying to keep the ground nodes
	local missing_nodes = handle_schematics.generate_building(start_pos, minp2, maxp2, data, param2_data, a, extranodes, replacements_table, cid, extra_calls, start_pos.building_nr, start_pos.village_id, binfo, cid.c_gravel, keep_ground, scaffolding_only);

	-- store the changed map data
	vm:set_data(data);
	vm:set_param2_data(param2_data);
	vm:write_to_map();
	vm:update_liquids();
	vm:update_map();

	-- do the necessary on_construct calls that mostly affect metadata
	handle_schematics.call_on_construct( extra_calls.on_constr );
	-- set up doors properly (to whatever minetest_game currently demands)
	handle_schematics.call_door_setup( extra_calls.door_b );
	-- players expect chests to be filled with something for them
	if( not( binfo.typ )) then
		binfo.typ = "unkown";
	end
	handle_schematics.fill_chests( extra_calls.chests, nil, binfo.typ);
	return p;
end


-- mark the place where a structure has been spawned as unusable (occupied)
-- by setting it to a height of maxp.y+1
handle_schematics.mark_flat_land_as_used = function(heightmap, minp, maxp, i, sizex, sizez)
	local offset = maxp.x - minp.x - sizex + 1;
	for dz = 1, sizez do
		for dx = 1, sizex do
			heightmap[ i ] = maxp.y+1;
			i = i-1;
		end
		i = i - offset;
	end
	return heightmap;
end
