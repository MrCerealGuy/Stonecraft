

moresnow.translation_table = {}

moresnow.build_translation_table = function()
	local shapes    = {'top', 'fence_top', 'stair_top', 'slab_top',
				'panel_top', 'micro_top', 'outer_stair_top', 'inner_stair_top',
				'ramp_top', 'ramp_outer_top', 'ramp_inner_top' };

	for _,t in ipairs(moresnow.nodetypes) do 

		moresnow.translation_table[ t ] = {};

		for _,v in ipairs( shapes ) do
			local id1 = minetest.get_content_id( 'moresnow:snow_'..v );
			local id2 = minetest.get_content_id( 'moresnow:'..t..'_'..v );
			if( id1 ) then 
				moresnow.translation_table[ t ][ id1 ] = id2;
			end
		end

		local id1 = minetest.get_content_id( 'default:snow' );
		local id2 = minetest.get_content_id( 'moresnow:'..t );
		if( id1 ) then
			moresnow.translation_table[ t ][ id1 ] = id2;
		end
	end
end
		

moresnow.on_construct_snow = function( pos, falling_node_name )
	
	if( not( falling_node_name )) then
		falling_node_name = 'default:snow';
	end

	local res = moresnow.on_construct( pos, falling_node_name, 'default:snow', 'snow' );
	if( res ) then
		minetest.swap_node( pos, res );
	end
end



moresnow.on_construct_leaves = function(   pos, falling_node_name )
	if( not( falling_node_name )) then
		falling_node_name = 'moresnow:autumnleaves';
	end

	local res = moresnow.on_construct( pos, falling_node_name, 'moresnow:autumnleaves', 'autumnleaves' );
	if( res ) then
		minetest.swap_node( pos, res );
	end
end


moresnow.on_construct_wool = function(   pos, falling_node_name, color )
	if( not( falling_node_name )) then
		falling_node_name = 'moresnow:wool_'..color;
	end

	local res = moresnow.on_construct( pos, falling_node_name, 'moresnow:wool_'..color, 'wool_'..color );
	if( res ) then
		minetest.swap_node( pos, res );
	end
end


-- this function works with content ids because we want it to call for falling
-- snow nodes AND from mapgen (where content ids are at hand)
moresnow.suggest_snow_type = function( node_content_id, p2 )

	local suggested = moresnow.snow_cover[ node_content_id ];
	-- if it is some solid node, keep the snow cover
	if( node_content_id == moresnow.c_snow or not( suggested ) or suggested == moresnow.c_ignore or suggested == moresnow.c_air) then
		return { new_id = moresnow.c_snow, param2 = 0 };
	end

	if( not( p2 )) then
		p2 = 0;
	end
	-- homedecor and technic have diffrent ideas about param2...
	local p2o = moresnow.snow_param2_offset[ node_content_id ];
	if( p2o ) then
		p2 = (p2 + p2o ) % 4;
	end

	-- if this is a stair or a roof node from homedecor or technics cnc machine;
	-- those nodes are all comparable regarding rotation
	if(     suggested == moresnow.c_snow_stair
	     or suggested == moresnow.c_snow_ramp_top ) then
		if(     p2==5 or p2==7 or p2==9  or p2==11 or p2==12 or p2==14 or p2==16 or p2==18 ) then
			suggested = moresnow.c_snow_top;
		-- stair turned upside down
		elseif( p2==6 or p2==8 or p2==15 or p2==17 or p2==20 or p2==21 or p2==22 or p2==23) then
			suggested = moresnow.c_snow;
		-- all these transform into stairs; however, adding the offset (our snow node lies lower than a normal node) would cause chaos
		elseif( p2 ==19) then
			p2 = 1;
		elseif( p2 ==4 ) then
		        p2 = 2;
		elseif( p2 ==13) then
		        p2 = 3;
		elseif( p2 ==10) then
		        p2 = 0;
		-- else it really is a stiar
		end
	elseif( suggested == moresnow.c_snow_slab ) then
		-- vertical slab; tread as a nodebox
		if(     p2 >= 4  and p2 <= 19 ) then
			suggested = moresnow.c_snow_top;
		-- slab turned upside down
		elseif( p2 >= 20 and p2 <= 24 ) then
			suggested = moresnow.c_snow;
		-- else it's a slab
		end

	elseif( suggested == moresnow.c_snow_panel ) then
		-- vertical panel (mostly); can't be handled well; therefore, treat as a nodebox
		if(     p2 >= 4  and p2 <= 24 ) then
			suggested = moresnow.c_snow_top;
		end
			
	elseif( suggested == moresnow.c_snow_micro ) then
		-- microblocks in diffrent positions from the normal ones are too difficult
		if(     p2 >= 4  and p2 <= 24 ) then
			suggested = moresnow.c_snow_top;
		end
	
	elseif( suggested == moresnow.c_snow_ramp_outer ) then
		-- treat like a nodebox
		if(     p2>=4    and p2 <= 19 ) then
			suggested = moresnow.c_snow_top;
		-- upside-down
		elseif( p2 >= 20 and p2 <= 24 ) then
			suggested = moresnow.c_snow;
		end
	
	elseif( suggested == moresnow.c_snow_ramp_inner ) then
		-- treat like a nodebox
		if(     p2>=4    and p2 <= 19 ) then
			suggested = moresnow.c_snow_top;
		-- upside-down
		elseif( p2 >= 20 and p2 <= 24 ) then
			suggested = moresnow.c_snow;
		end
	end

	-- c_snow_top does not have facedir
	if( suggested == moresnow.c_snow_top ) then
		p2 = 1;
	end
	return { new_id = suggested, param2 = p2 };
end




-- default_name is the name of the node that would be placed in case of a solid underground
-- (usually default:snow)
moresnow.on_construct_select_shape = function( pos, falling_node_name, default_name )
	
	-- get the node one below
	local node1 = minetest.get_node( {x=pos.x, y=pos.y-1, z=pos.z});

	-- no information about that node available; give up
	if( not(node1) or not(node1.name) or not(minetest.registered_nodes[ node1.name ] )) then
		return;
	end

	local res  = moresnow.suggest_snow_type( minetest.get_content_id( node1.name ), node1.param2 );

	-- snow_top is a special node suitable for nodeboxes; BUT: it only looks acceptable if the
	-- node below that nodebox/torch/fence/etc is a solid one
	if( res.new_id == moresnow.c_snow_top ) then

		-- get the node below the node below
		local node2      = minetest.get_node( {x=pos.x, y=pos.y-2, z=pos.z});

		if( node2 and node2.name and node2.name == default_name ) then
			return;
		end
	
		-- no information about the node below available - we don't know what to do
		if( not( node2 ) or node2.name == 'air' or node2.name == 'ignore' ) then
			-- in such a case it helps to drop the snow and let it fall until it hits something
			if( node2 and node2.name == 'air' ) then
				-- let the snow continue to fall
				spawn_falling_node( {x=pos.x, y=pos.y-2, z=pos.z}, {name= default_name})
			end
			return { remove_node = true};
		end
		local new_id2 = moresnow.snow_cover[ minetest.get_content_id( node2.name )];
		-- if the node below this one can't handle a normal snow cover, we can't put a snow top on our node either
		if( not( new_id2 ) or new_id2 ~= moresnow.c_snow) then
			return { remove_node = true};
		end
		-- else continue with c_snow_top
	end 
	return res;
end


-- we need to make sure not to replace the node with the same content
moresnow.on_construct = function( pos, falling_node_name, default_name, node_type )

	-- get the node we're talking about
	local node0 = minetest.get_node( pos );

	local res = moresnow.on_construct_select_shape( pos, falling_node_name, default_name );

	if( res and res.remove_node ) then
		-- check if we're removing the right node
		if( node0 and node0.name and node0.name == falling_node_name) then
			minetest.remove_node( pos );
		end
		return; -- we're finished
	end

	if( not( res ) ) then
		-- will be handled by the engine
		if( falling_node_name == default_name ) then
			return;
		-- the falling node was not default:snow (or an aequivalent); but we need default:snow here
		elseif( node0 and node0.name and node0.name ~= default_name) then
			if( not( minetest.registered_nodes[ default_name ] ) or default_name=='ignore') then
				return;
			end
			return { name = default_name, param2 = 0 };
		-- fallback
		else
			return;
		end
	end

	if( node_type and moresnow.translation_table[ node_type ] ) then
		res.new_id = moresnow.translation_table[ node_type ][ res.new_id ];
		if( not( res.new_id )) then
			return;
		end
	end
	local suggested = minetest.get_name_from_content_id( res.new_id );
	if( node0 and node0.name and (node0.name ~= suggested or ( suggested ~= default_name and node0.param2 and node0.param2 ~= res.param2))) then
		if( not( minetest.registered_nodes[ suggested ] ) or suggested=='ignore') then
			return;
		end
		return { name = suggested, param2 = res.param2};
	end
end

