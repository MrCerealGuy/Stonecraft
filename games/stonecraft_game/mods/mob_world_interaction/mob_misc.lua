

mob_world_interaction.set_animation = function( entity, anim )
	if( not( entity ) or not( entity.object)) then
		return;
	end
	local a = 0;   -- startframe of animation
	local b = 79;  -- endframe of animation
	local speed = 30; 
	if( anim=='stand' ) then
		a = 0;
		b = 79;
	elseif( anim=='sit' ) then
		a = 81;
		b = 148;
	elseif( anim=='sleep' ) then
		a = 164;
		b = 164;
	end
	entity.object:set_animation({x=a, y=b}, speed)
end

-- also works with virtual data (i.e. as provided by handle_schematics) and not only
-- with minetest.get_node
mob_world_interaction.get_node = function( pos, data )
	if( data and pos and pos.x) then
		-- the data is stored in the way handle_schematic stores it internally
		if( data.scm_data_cache and data.nodenames ) then
			-- the node is contained in the provided data and is not air
			if(   data.scm_data_cache[ pos.y ]
			  and data.scm_data_cache[ pos.y ][ pos.x ]
			  and data.scm_data_cache[ pos.y ][ pos.x ][ pos.z ]) then
				local t = data.scm_data_cache[ pos.y ][ pos.x ][ pos.z ];
				return { name = data.nodenames[ t[1] ], param2 = t[2] };

			-- for nodes outside the defined volume we make the following assumptions:
			-- the building is sourrounded by flat space; thus, only pos.y (height) counts
			elseif( (not( data.yoff ) and pos.y <= 1 )
			  or pos.y <= (data.yoff*-1)+1 ) then
				-- something virtual on which the mob can walk
				return { name = "default:dirt_with_grass", param2 = 0};
			else
				-- virtual air - the mob can walk through
				return { name = "air", param2 = 0};
			end

		end
	end
	-- get the node directly
	return minetest.get_node( pos );
end
