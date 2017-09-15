handle_schematics.analyze_we_file = function(scm, we_origin)
	-- this table will contain the nodes read
	local nodes = {}

	-- check if it is a worldedit file
	-- (no idea why reading that is done in such a complicated way; a simple deserialize and iteration over all nodes ought to do as well)
	local f, err = save_restore.file_access( scm..".we", "r")
	if not f then
		f, err = save_restore.file_access( scm..".wem", "r")
		if not f then
--			error("Could not open schematic '" .. scm .. ".we': " .. err)
			return nil;
		end
	end

	local value = f:read("*a")
	f:close()

	local nodes = worldedit_file.load_schematic(value, we_origin)

	-- create a list of nodenames
	local nodenames    = {};
	local nodenames_id = {};
	for i,ent in ipairs( nodes ) do
		if( ent and ent.name and not( nodenames_id[ ent.name ])) then
			nodenames_id[ ent.name ] = #nodenames + 1;
			nodenames[ nodenames_id[ ent.name ] ] = ent.name;
		end
	end

	local bed_count = 0;
	local bed_list = {};

	scm = {}
	local maxx, maxy, maxz = -1, -1, -1
	local all_meta = {};
	for i = 1, #nodes do
		local ent = nodes[i]
		ent.x = ent.x + 1
		ent.y = ent.y + 1
		ent.z = ent.z + 1
		if ent.x > maxx then
			maxx = ent.x
		end
		if ent.y > maxy then
			maxy = ent.y
		end
		if ent.z > maxz then
			maxz = ent.z
		end
		if scm[ent.y] == nil then
			scm[ent.y] = {}
		end
		if scm[ent.y][ent.x] == nil then
			scm[ent.y][ent.x] = {}
		end
		if ent.param2 == nil then
			ent.param2 = 0
		end
		-- metadata is only of intrest if it is not empty
		if( ent.meta and (ent.meta.fields or ent.meta.inventory)) then
			local has_meta = false;
			for _,v in pairs( ent.meta.fields ) do
				has_meta = true;
			end
			for _,v in pairs(ent.meta.inventory) do
				has_meta = true;
			end
			if( has_meta == true ) then
				all_meta[ #all_meta+1 ] = {
					x=ent.x,
					y=ent.y,
					z=ent.z,
					fields    = ent.meta.fields,
					inventory = ent.meta.inventory};
			end
		end


		scm[ent.y][ent.x][ent.z] = { nodenames_id[ ent.name ], ent.param2 };
		if( handle_schematics.bed_node_names[ ent.name ]) then
			bed_count = bed_count + 1;
			table.insert( bed_list, {x=x, y=y, z=z, p2, id});
		end

	end

	for y = 1, maxy do
		if scm[y] == nil then
			scm[y] = {}
		end
		for x = 1, maxx do
			if scm[y][x] == nil then
				scm[y][x] = {}
			end
		end
	end

	local size = {};
	size.y = math.max(maxy,0);
	size.x = math.max(maxx,0);
	size.z = math.max(maxz,0);

	return { size = { x=size.x, y=size.y, z=size.z}, nodenames = nodenames, on_constr = {}, after_place_node = {}, rotated=0, burried=0, scm_data_cache = scm, metadata = all_meta, bed_count = bed_count, bed_list = bed_list };
end
