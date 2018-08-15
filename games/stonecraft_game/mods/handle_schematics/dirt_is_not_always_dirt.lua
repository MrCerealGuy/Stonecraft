
-- "dirt" stands as a placeholder for "some ground node; can be stone or dirt or something similar";
handle_schematics.also_acceptable = {};

handle_schematics.add_also_acceptable = function( name1, name2 )
	-- only add entry if both nodes exist
	if(  not( name1 ) or not( name2 ) or name1==name2
	  or not( handle_schematics.node_defined( name1 ))
	  or not( handle_schematics.node_defined( name2 ))
	  or handle_schematics.direct_instead_of_drop[ name1 ]
	  or handle_schematics.direct_instead_of_drop[ name2 ]) then
		return;
	end
	-- the table works by content_id for faster lookup at the time of placement
	local id1 = minetest.get_content_id( name1 );
	local id2 = minetest.get_content_id( name2 );
	if( not( id1 ) or not( id2 ) or ( id1==id2 )) then
		return;
	end

	-- make sure the entry exists so that we can add to the table
	if( not( handle_schematics.also_acceptable[ id1 ])) then
		handle_schematics.also_acceptable[ id1 ] = { is_ok = {}};
	end
	handle_schematics.also_acceptable[ id1 ].is_ok[ id2 ] = 1;
	--print ("[handle_schematics] Accepting "..tostring( name2 ).." instead of "..tostring( name1 ));
end


-- This function fills the table handle_schematics.also_acceptable with data.
-- The general assumption is that dirt nodes in schematics are most of the time just placeholders
-- and could as well be other nodes - like i.e. stone, stone with ore, other variants of dirt
-- etc.
-- This also applies to default:dirt_with_grass. There are very few situations where it *does*
-- have to be dirt_with_grass. Most of the time it will look much better if what was placed
-- there by mapgen is taken instead (i.e. the local dirt type, sand, gravel, ...)
handle_schematics.enable_use_dirt_as_placeholder = function()
	local fill_nodes = {"default:stone","default:stone_with_coal","default:stone_with_iron",
		"default:stone_with_copper","default:stone_with_mese","default:stone_with_diamond",
		"default:stone_with_gold","default:stone_with_tin",
		"default:desert_stone","default:mese",
		"default:cobble","default:mossycobble","default:sandstone","default:silver_sandstone",
		-- falling nodes would be too problematic in this case;
		-- diffrent dirt types
		"default:dirt_with_dry_grass","default:dirt_with_grass","default:dirt_with_rainforest_litter",
		"default:dirt_with_coniferous_litter",
		"default:dirt_with_snow", "default:snowblock","default:ice"};
	for i,v in ipairs( fill_nodes ) do
		handle_schematics.add_also_acceptable( "default:dirt", v )
	end

	-- it does not always have to be dirt_with_grass
	fill_nodes = {
		-- falling nodes...but may still be ok in this context
		"default:gravel","default:sand","default:desert_sand","default:silver_sand",
		-- diffrent dirt types
		"default:dirt_with_dry_grass","default:dirt_with_grass","default:dirt_with_rainforest_litter",
		"default:dirt_with_coniferous_litter",
		"default:dirt_with_snow","default:dirt","default:snowblock","default:ice"};
	for i,v in ipairs( fill_nodes ) do
		handle_schematics.add_also_acceptable( "default:dirt_with_grass", v )
	end
end


-- doors and gates tend to be diffrent nodes in their open state
-- TODO: this also covers soil
handle_schematics.enable_doors_open_closed = function()
	for k,v in pairs(minetest.registered_nodes) do
		if( v.drop
		  and v.drop
		  and type( v.drop )=='string'
		  and v.drop ~= k ) then

			if( handle_schematics.node_defined( v.drop )
			  -- stone and desert_stone need to be handled diffrently;
			  -- some dirt and grass types etc. are also handled
			  and not(handle_schematics.direct_instead_of_drop[ k ])) then
				handle_schematics.add_also_acceptable( k, v.drop );
				handle_schematics.add_also_acceptable( v.drop, k );
			elseif( minetest.registered_items[ v.drop ]
			  and ( k==v.drop.."_a" or k==v.drop.."_b" or k==v.drop.."_open" or k==v.drop.."_closed")) then
				local namen = { v.drop.."_a", v.drop.."_b", v.drop.."_open", v.drop.."_closed"};
				for i,name1 in ipairs( namen ) do
					for j,name2 in ipairs( namen ) do
						handle_schematics.add_also_acceptable( name1, name2 );
					end
				end
			end
		end
	end
end
