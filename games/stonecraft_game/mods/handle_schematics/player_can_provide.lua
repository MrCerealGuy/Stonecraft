-- if the player builds a house manually, there are some nodes the players cannot
-- supply as the nodes are not obtainable (only their drop) - thus, in most cases,
-- the drop is what we ask for; except for these nodes where the origianl node
-- can be obtained through smelting/crafting:
handle_schematics.direct_instead_of_drop = {};
handle_schematics.direct_instead_of_drop[ "default:stone" ] = true;
handle_schematics.direct_instead_of_drop[ "default:desert_stone" ] = true;
handle_schematics.direct_instead_of_drop[ "default:clay" ] = true;


-- stores a table of node names and what the player can provide instead
-- of the very node; this is necessary as i.e. default:grass_5 cannot
-- be obtained without creative (it drops default:grass_1 or sometimes
-- wheat seeds); same applies for farming plants
handle_schematics.player_can_provide = {};
for i=1,5 do
	handle_schematics.player_can_provide[ "default:grass_"..i ] = "default:grass_1";
end
-- neither can partly grown wheat or cotton plants be obtained
for i=1,8 do
	handle_schematics.player_can_provide[ "farming:wheat_"..i ] = "farming:seed_wheat";
end
for i=1,8 do
	handle_schematics.player_can_provide[ "farming:cotton_"..i ] = "farming:seed_cotton";
end
handle_schematics.player_can_provide[ "default:water_source" ] = "bucket:bucket_water";
handle_schematics.player_can_provide[ "default:river_water_source" ] = "bucket:bucket_river_water";
handle_schematics.player_can_provide[ "default:lava_source" ] = "bucket:bucket_lava";

-- makes use of handle_schematics.player_can_provide; but also takes
-- the drop into account (for i.e. doors or other open/closed nodes)
handle_schematics.get_what_player_can_provide = function( node_wanted )

	-- stone, desert_stone, clay and perhaps some other nodes can be obtained even
	-- though they drop something diffrent
	if( handle_schematics.direct_instead_of_drop[ node_wanted ] ) then
		return node_wanted;
	end

	-- the player can i.e. provide seeds for a plant or the harvested grass_1
	if( handle_schematics.player_can_provide[ node_wanted ]) then
		return handle_schematics.player_can_provide[ node_wanted ];
	end

	-- some nodes like i.e. dirt with grass or stone with coal cannot be obtained;
	-- in such a case we ask for the drop; this is also useful for doors etc.
	local node_def = handle_schematics.node_defined( node_wanted );
	if(   node_def
	  -- provided the drop actually exists
	  and node_def.drop
	  and minetest.registered_items[ node_def.drop ]) then

		return node_def.drop;
	end

	-- the player ought to be able to come up with this node (or we need to define more exceptions)
	return node_wanted;
end

-- store the IDs as well (for faster access in generate_building)
for node_name, player_provides in pairs(handle_schematics.player_can_provide) do
	if(   minetest.registered_nodes[ node_name ]
	  and minetest.registered_nodes[ player_provides ]) then
		handle_schematics.player_can_provide[ minetest.get_content_id( node_name )] =
			minetest.get_content_id( player_provides );
		handle_schematics.player_can_provide[ minetest.get_content_id( player_provides )] =
			minetest.get_content_id( player_provides );
	end
end
