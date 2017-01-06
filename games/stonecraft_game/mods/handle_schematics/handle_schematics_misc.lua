
-- helper function; sorts by the second element of the table
local function handle_schematics_comp(a,b)
	if (a[2] > b[2]) then
		return true;
	end
end

-- create a statistic about how frequent each node name occoured
handle_schematics.count_nodes = function( data )
	local statistic = {};
	-- make sure all node names are counted (air may sometimes be included without occouring)
	for id=1, #data.nodenames do
		statistic[ id ] = { id, 0};
	end

	for z = 1, data.size.z do
	for y = 1, data.size.y do
	for x = 1, data.size.x do

		local a = data.scm_data_cache[y][x][z];
		if( a ) then
			local id = 0;
			if( type( a )=='table' ) then
				id = a[1];
			else
				id = a;
			end
			if( statistic[ id ] and statistic[ id ][ 2 ] ) then
				statistic[ id ] = { id, statistic[ id ][ 2 ]+1 };
			end
		end
	end
	end
	end
	table.sort( statistic, handle_schematics_comp );
	return statistic;
end


-- this function makes sure that the building will always extend to the right and in front of the build chest
handle_schematics.translate_param2_to_rotation = function( param2, mirror, start_pos, orig_max, rotated, burried, orients, yoff )

	-- mg_villages stores available rotations of buildings in orients={0,1,2,3] format
	if( orients and #orients and orients[1]~=0) then
		-- reset rotated - else we'd apply it twice
		rotated = 0;
		if(     orients[1]==1 ) then
			rotated = rotated + 90;
		elseif( orients[1]==2 ) then
			rotated = rotated + 180;
		elseif( orients[1]==3 ) then
			rotated = rotated + 270;
		end
		if( rotated >= 360 ) then
			rotated = rotated % 360;
		end
	end

	local max = {x=orig_max.x, y=orig_max.y, z=orig_max.z};
	-- if the schematic has been saved in a rotated way, swapping x and z may be necessary
	if( rotated==90 or rotated==270) then
		max.x = orig_max.z;
		max.z = orig_max.x;
	end

	-- the building may have a cellar or something alike
	if( burried and burried ~= 0 and yoff == nil ) then
		start_pos.y = start_pos.y - burried;
	end

	-- make sure the building always extends forward and to the right of the player
	local rotate = 0;
	if(     param2 == 0 ) then rotate = 270; if( mirror==1 ) then start_pos.x = start_pos.x - max.x + max.z; end -- z gets larger
	elseif( param2 == 1 ) then rotate =   0;    start_pos.z = start_pos.z - max.z; -- x gets larger  
	elseif( param2 == 2 ) then rotate =  90;    start_pos.z = start_pos.z - max.x;
	                       if( mirror==0 ) then start_pos.x = start_pos.x - max.z; -- z gets smaller 
	                       else                 start_pos.x = start_pos.x - max.x; end
	elseif( param2 == 3 ) then rotate = 180;    start_pos.x = start_pos.x - max.x; -- x gets smaller 
	end

	if(     param2 == 1 or param2 == 0) then
		start_pos.z = start_pos.z + 1;
	elseif( param2 == 1 or param2 == 2 ) then
		start_pos.x = start_pos.x + 1;
	end
	if( param2 == 1 ) then
		start_pos.x = start_pos.x + 1;
	end

	rotate = rotate + rotated;
	-- make sure the rotation does not reach or exceed 360 degree
	if( rotate >= 360 ) then
		rotate = rotate - 360;
	end
	-- rotate dimensions when needed
	if( param2==0 or param2==2) then
		local tmp = max.x;
		max.x = max.z;
		max.z = tmp;
	end

	return { rotate=rotate, start_pos = {x=start_pos.x, y=start_pos.y, z=start_pos.z},
				end_pos   = {x=(start_pos.x+max.x-1), y=(start_pos.y+max.y-1), z=(start_pos.z+max.z-1) },
				max       = {x=max.x, y=max.y, z=max.z}};
end

