
-- find out which nodes are stairs and which are slabs (those are handled diffrently by our snow here);
-- this is necessary in order to determine which shape the snow on top of the node will take
-- (of course this only works for a few shapes and does not even take rotation into consideration)
moresnow.snow_cover = {};

-- homedecor and technic did not settle on common param2 interpretation :-(
moresnow.snow_param2_offset = {};

-- homedecor 3d shingles and technic cnc items are handled here
moresnow.identify_special_slopes = function( new_name, homedecor_prefix, technic_postfix, param2_offset )
	-- these nodes are only supported if homedecor and/or technic are installed
	local c_new_snow_node = minetest.get_content_id( new_name );
	if( not( c_new_snow_node )) then
		return;
	end

	local homedecor_materials = {'terracotta','wood','asphalt'};
	local technic_materials   = {'dirt','wood','stone','cobble','brick','sandstone','leaves',
					'tree','steelblock','bronzeblock','stainless_steel','marble','granite'};

	for _,v in ipairs( homedecor_materials ) do
		local id = minetest.get_content_id( homedecor_prefix..v );
		-- the node has to be registered at this point; thus, the soft-dependency on homedecor and technic
		if( id and id ~= moresnow.c_ignore ) then
			moresnow.snow_cover[ id ] = c_new_snow_node;
		end
	end
	for _,v in ipairs( technic_materials ) do
		local prefix = 'default:';
		if( v=='stainless_steel' or v=='marble' or v=='granite' ) then
			prefix = 'technic:';
		end

		local id = minetest.get_content_id( prefix..v..technic_postfix );
		-- the node has to be registered at this point; thus, the soft-dependency on homedecor and technic
		if( id and id ~= moresnow.c_ignore ) then
			moresnow.snow_cover[                 id ] = c_new_snow_node;
			-- homedecor and technic use diffrent param2 for the same shape
			if( param2_offset ) then
				moresnow.snow_param2_offset[ id ] = param2_offset;
			end
		end
	end
end

-- identify stairs and slabs (roughly!) by their nodeboxes
moresnow.identify_stairs_and_slabs = function()

	moresnow.identify_special_slopes( 'moresnow:snow_ramp_top',       'homedecor:shingle_side_',         '_technic_cnc_slope', 0 );
	moresnow.identify_special_slopes( 'moresnow:snow_ramp_outer_top', 'homedecor:shingle_outer_corner_', '_technic_cnc_slope_edge', 1 );
	moresnow.identify_special_slopes( 'moresnow:snow_ramp_inner_top', 'homedecor:shingle_inner_corner_', '_technic_cnc_slope_inner_edge', 1 );

	for n,v in pairs( minetest.registered_nodes ) do

		local id = minetest.get_content_id( n );

		if( not( id ) or moresnow.snow_cover[ id ] ) then

			-- do nothing; the node has been dealt with

		elseif( v.drawtype and v.drawtype == 'fencelike' ) then

			moresnow.snow_cover[ id ] = moresnow.c_snow_fence;


		elseif( n and minetest.registered_nodes[ n ]
		      and minetest.registered_nodes[ n ].drop 
		      and minetest.registered_nodes[ n ].drop == 'default:snow' ) then

			-- no snow on snow
			

		elseif( v and v.drawtype and v.drawtype == 'nodebox' and v.node_box
		      and v.node_box.type and v.node_box.type=='fixed'
		      and v.node_box.fixed ) then

			local nb = v.node_box.fixed;

			-- might be a slab (or something which has a sufficiently similar surface compared to a slab)
			if(    ( #nb == 1
			         and math.max( nb[1][2], nb[1][5])==0 
				 and math.abs( nb[1][4] - nb[1][1] ) >= 0.9
				 and math.abs( nb[1][6] - nb[1][3] ) >= 0.9 )
		
			    or ( type( nb[1] )~='table'
				and #nb == 6
				and math.max( nb[2], nb[5] )==0 
				and math.abs( nb[4]-nb[1] ) >= 0.9 
				and math.abs( nb[6]-nb[3] ) >= 0.9 ))  then

				moresnow.snow_cover[ id ] = moresnow.c_snow_slab;

			-- panels (=half slabs)
			elseif((#nb == 1
			         and math.max( nb[1][2], nb[1][5])==0 
				 and math.abs( nb[1][4] - nb[1][1] ) >= 0.9
				 and math.abs( nb[1][6] - nb[1][3] ) <= 0.5 )
		
			    or ( type( nb[1] )~='table'
				and #nb == 6
				and math.max( nb[2], nb[5] )==0 
				and math.abs( nb[4]-nb[1] ) >= 0.9 
				and math.abs( nb[6]-nb[3] ) <= 0.5 ))  then

				moresnow.snow_cover[ id ] = moresnow.c_snow_panel;

			-- micro(blocks)
			elseif((#nb == 1
			         and math.max( nb[1][2], nb[1][5])==0 
				 and math.abs( nb[1][4] - nb[1][1] ) >= 0.5
				 and math.abs( nb[1][6] - nb[1][3] ) <= 0.5 )
		
			    or ( type( nb[1] )~='table'
				and #nb == 6
				and math.max( nb[2], nb[5] )==0 
				and math.abs( nb[4]-nb[1] ) >= 0.5 
				and math.abs( nb[6]-nb[3] ) <= 0.5 ))  then
				
				moresnow.snow_cover[ id ] = moresnow.c_snow_micro;

			-- might be a stair
			elseif( #nb == 2 ) then
				local c = { math.min( nb[1][1], nb[1][4] ), math.min( nb[1][2], nb[1][5] ), math.min( nb[1][3], nb[1][4] ),
				            math.max( nb[1][1], nb[1][4] ), math.max( nb[1][2], nb[1][5] ), math.max( nb[1][3], nb[1][4] ),
				            math.min( nb[2][1], nb[2][4] ), math.min( nb[2][2], nb[2][5] ), math.min( nb[2][3], nb[2][4] ),
				            math.max( nb[2][1], nb[2][4] ), math.max( nb[2][2], nb[2][5] ), math.max( nb[2][3], nb[2][4] ) };

				if(   ((  c[ 5]==0   and c[11]==0.5)
			            or (  c[ 5]==0.5 and c[11]==0  ))
				      and math.abs( c[ 4]-c[1]) >= 0.9
				      and math.abs( c[10]-c[7]) >= 0.9 ) then

					moresnow.snow_cover[ id ] = moresnow.c_snow_stair;

				-- moreblocks _outer:
				elseif(   nb[1][1]==-0.5 and nb[1][2]==-0.5 and nb[1][3]==-0.5
				      and nb[1][4]== 0.5 and nb[1][5]== 0   and nb[1][6]== 0.5
				      and nb[2][1]==-0.5 and nb[2][2]== 0   and nb[2][3]== 0  
				      and nb[2][4]== 0   and nb[2][5]== 0.5 and nb[2][6]== 0.5 ) then
		
					moresnow.snow_cover[ id ] = moresnow.c_snow_outer_stair;
				else
					moresnow.snow_cover[ id ] = moresnow.c_snow_top;
				end

			-- moreblocks _inner:
			elseif( #nb==3 
				and nb[1][1]==-0.5 and nb[1][2]==-0.5 and nb[1][3]==-0.5 
				and nb[1][4]== 0.5 and nb[1][5]== 0   and nb[1][6]== 0.5 

				and nb[2][1]==-0.5 and nb[2][2]== 0   and nb[2][3]== 0  
				and nb[2][4]== 0.5 and nb[2][5]== 0.5 and nb[2][6]== 0.5 

				and nb[3][1]==-0.5 and nb[3][2]== 0   and nb[3][3]==-0.5
				and nb[3][4]== 0   and nb[3][5]== 0.5 and nb[3][6]== 0 ) then

				moresnow.snow_cover[ id ] = moresnow.c_snow_inner_stair;
			else 
				moresnow.snow_cover[ id ] = moresnow.c_snow_top;
			end

		-- add snow to the bottom of the node below; it will look acceptable, provided there is a solid node below
		elseif( v and v.drawtype
		          and (   v.drawtype == 'fencelike' or v.drawtype=='plantlike'
			       or v.drawtype == 'signlike'  or v.drawtype=='torchlike' )) then

			moresnow.snow_cover[ id ] = moresnow.c_snow_top;
	
		-- nodes where a snow cover would not fit (rails for example would get invisible)
		elseif( v and v.drawtype
		          and (   v.drawtype == 'airlike'   or v.drawtype=='liquid'   
			       or v.drawtype == 'raillike'  or v.drawtype=='flowingliquid' )) then

			moresnow.snow_cover[ id ] = moresnow.c_air;
		else
			moresnow.snow_cover[ id ] = moresnow.c_snow;
		end
	end
end

-- search for stairs and slabs after all nodes have been generated
minetest.after( 0, moresnow.identify_stairs_and_slabs );

-- no snow on lava or flowing water
moresnow.snow_cover[ minetest.get_content_id( 'default:lava_source')        ] = moresnow.c_air;
moresnow.snow_cover[ minetest.get_content_id( 'default:lava_flowing')       ] = moresnow.c_air;
moresnow.snow_cover[ minetest.get_content_id( 'default:water_flowing')      ] = moresnow.c_air;
moresnow.snow_cover[ minetest.get_content_id( 'default:river_water_flowing')] = moresnow.c_air;
