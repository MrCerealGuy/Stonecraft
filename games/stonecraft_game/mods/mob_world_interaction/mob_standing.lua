

-- there are some nodes the mob cannot really stand in - but where a "real" human would be
-- able to get through (i.e. several benches, climbing in a bed etc.)
mob_world_interaction.can_get_through = {};

-- the mob can use beds even if standing on them would not work
-- value 2: bed; node where the head of the mob rests
-- value 3: something to sit on
mob_world_interaction.can_get_through[ 'beds:bed_top'] = 2;
mob_world_interaction.can_get_through[ 'beds:bed_bottom'] = 1;
mob_world_interaction.can_get_through[ 'beds:bed_fancy_top'] = 2;
mob_world_interaction.can_get_through[ 'beds:bed_fancy_boottom'] = 1;
mob_world_interaction.can_get_through[ 'cottages:bed_head'] = 2;
mob_world_interaction.can_get_through[ 'cottages:bed_foot'] = 1;
mob_world_interaction.can_get_through[ 'cottages:sleeping_mat_head'] = 2;
mob_world_interaction.can_get_through[ 'cottages:sleeping_mat'] = 3;
mob_world_interaction.can_get_through[ 'cottages:straw_mat'] = 3;
-- benches and tables may sometimes be tricky - still the mob ought to be able to use them
mob_world_interaction.can_get_through[ 'cottages:bench'] = 3;
mob_world_interaction.can_get_through[ 'cottages:table'] = 1;

-- helper function; determines weather a mob can stand in a given node or not
mob_world_interaction.can_stand_in_node_type = function( node )
	if( not( node ) or not( node.name ) or not( minetest.registered_nodes[ node.name ])) then
		return false;
	end
end


-- most ceilings will be too low for the mob to successfully jump/walk onto a bed or bench;
-- benches frequently cannot be reached directly either
-- this function finds a position next to the bed/bench/.. where the mob can stand.
-- does a recursive search and may fail to find a position; in that case it will return {iteration == 99}
-- iteration has to be 0 and vector = {x=0,y=0,z=0} at the beginning
mob_world_interaction.find_place_next_to = function( pos, iteration, vector, data)

	-- node where the feet of the mob are
	local n1 = mob_world_interaction.get_node( pos, data );
	-- node where the head of the mob is
	local n2 = mob_world_interaction.get_node( {x=pos.x, y=pos.y+1, z=pos.z}, data);
	-- node below the feet of the mob where he stands on
	local n0 = mob_world_interaction.get_node( {x=pos.x, y=pos.y-1, z=pos.z}, data);
	--print("standing: "..minetest.pos_to_string( pos ).." nodes: "..tostring( n0.name).." "..tostring(n1.name).." "..tostring(n2.name));
	-- can the mob stand at this position? then we are finished
	if(   n1 and not( mob_world_interaction.walkable( n1, 1, 2 )) -- free space for feet
	  and n2 and not( mob_world_interaction.walkable( n2, 2, 2 )) -- free space for head
	  and n0 and    ( mob_world_interaction.walkable( n0, 1, 2 )  -- ground for feet to stand on
	               or mob_world_interaction.climbable( n0 ))) then -- or a ladder
		--print("found!");
		return {x=pos.x, y=pos.y, z =pos.z, iteration=iteration};
	end

--[[
	-- maybe there is a convenient place one node lower
	if(   n1 and not( mob_world_interaction.walkable( n1, 1, 1 ))
	  and n2 and      mob_world_interaction.walkable( n2, 1, 1 )
	  -- no way to move through these nodes *downwards* - just sideways
	  and n1.name and not( mob_world_interaction.can_get_through[ n1.name ])) then
		local n_1 = mob_world_interaction.get_node( {x=pos.x, y=pos.y-1, z=pos.z}, data);
		if( n_1 and not( mob_world_interaction.walkable( n_1, 0, 1 ))
		           and   mob_world_interaction.climbable( n_1 )) then
			return {x=pos.x, y=pos.y-1, z =pos.z, iteration=iteration};
		end
	end
--]]
--[[
	-- ..or one node higher
	if(   n1 and      mob_world_interaction.walkable( n1, 0, 1 )
	  and n2 and not( mob_world_interaction.walkable( n2, 0, 1 ))
	  -- cannot really move through these nodes upward either
	  and n1.name and not( mob_world_interaction.can_get_through[ n1.name ])
	  and n2.name and not( mob_world_interaction.can_get_through[ n2.name ])) then
		local nh1 = mob_world_interaction.get_node( {x=pos.x, y=pos.y+2, z=pos.z}, data);
		if( nh1 and not( mob_world_interaction.walkable( nh1, 1, 1 ))) then
			return {x=pos.x, y=pos.y+1, z =pos.z, iteration=iteration};
		end
	end
--]]

	-- do not search endlessly; allow only 6 iterations
	if( iteration > 6 or not( n1 ) or not( n1.name ) or not(  mob_world_interaction.can_get_through[ n1.name ])) then
		return {iteration=99}; -- we failed to find a suitable position
	end

	-- the mob can be at this place; try to find a position from where it can reach this place
	local p_curr_opt = {iteration=99}; -- current optimum
	local p = {};

	-- avoid going backwards and checking places that are already checked or cannot be reached
	if( vector.x ~= -1 ) then
		p = mob_world_interaction.find_place_next_to( {x=pos.x+1, y=pos.y, z=pos.z  }, iteration+1, {x= 1,y=0,z= 0}, data);
		if( p.iteration < p_curr_opt.iteration ) then
			p_curr_opt = p;
		end
	end
	if( vector.x ~=  1 ) then
		p = mob_world_interaction.find_place_next_to( {x=pos.x-1, y=pos.y, z=pos.z  }, iteration+1, {x=-1,y=0,z= 0}, data);
		if( p.iteration < p_curr_opt.iteration ) then
			p_curr_opt = p;
		end
	end
	if( vector.z ~= -1 ) then
		p = mob_world_interaction.find_place_next_to( {x=pos.x,   y=pos.y, z=pos.z+1}, iteration+1, {x= 0,y=0,z= 1}, data);
		if( p.iteration < p_curr_opt.iteration ) then
			p_curr_opt = p;
		end
	end
	if( vector.z ~=  1 ) then
		p = mob_world_interaction.find_place_next_to( {x=pos.x,   y=pos.y, z=pos.z-1}, iteration+1, {x= 0,y=0,z=-1}, data);
		if( p.iteration < p_curr_opt.iteration ) then
			p_curr_opt = p;
		end
	end
	return p_curr_opt;
end

-- let the entity stand around, facing yaw direction
mob_world_interaction.stand_at = function( entity, pos, yaw )
	if( not( entity ) or not( entity.object ) or not( pos )) then
		return;
	end
	-- rotate the npc in the right direction
	if( yaw ) then
		entity.object:setyaw( math.rad( yaw ));
	end
	-- move to the stand position
	entity.object:setpos( {x=pos.x, y=pos.y+0.55,z=pos.z} );

	mob_world_interaction.set_animation( entity, 'stand' );

-- TODO: this is highly mob-specific and needs to be saved
	entity.trader_uses = nil;
	entity.trader_does = 'stand';

	return pos;
end
