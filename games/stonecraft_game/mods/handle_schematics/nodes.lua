


---------------------------------------------------------------------------------------
-- helper node that is used during construction of a house; scaffolding
---------------------------------------------------------------------------------------

-- this node can be crafted
minetest.register_node("handle_schematics:support", {
        description = "support structure for buildings",
        tiles = {"handle_schematics_support.png"},
	groups = {snappy=3,choppy=3,oddly_breakable_by_hand=3},
	visual_scale = 1.2,
        walkable = false,
        climbable = true,
        paramtype = "light",
        drawtype = "plantlike",
--	-- the small selection box allows the player to dig one or two nodes below
--	selection_box = {
--                type = "fixed",
--                fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 0.5, 2 / 16}
--        },
})


minetest.register_craft({
	output = "handle_schematics:support 4",
	recipe = {
		{"group:stick", "", "group:stick" }
        }
})


-- always handle the bottommost support node first
-- mobs who wish to use this function have to provide the required item in itemstack
handle_schematics.place_node_using_support_setup = function(pos, clicker, itemstack )
	-- TODO: does can_interact_with_node work with mobs?
	if not( default.can_interact_with_node(clicker, pos)) then
		return itemstack;
	end

	-- pass right-clicks on to support nodes below (else some floor nodes may not be reachable)
	local node_below = minetest.get_node( {x=pos.x, y=pos.y-1, z=pos.z} );
	if( node_below and node_below.name and node_below.name == "handle_schematics:support_setup" ) then
		return handle_schematics.place_node_using_support_setup({x=pos.x, y=pos.y-1, z=pos.z}, clicker, itemstack );
	end

	local meta = minetest.get_meta( pos );
	local node_wanted = meta:get_string( "node_wanted" );
	local param2_wanted = meta:get_int( "param2_wanted" );

	if( not(meta) or not(node_wanted) or node_wanted == "" or not(clicker)) then
		-- if metadata is missing: set to air
		minetest.set_node( pos, {name="air"});
		return itemstack;
	end

	local node_really_wanted = node_wanted;

	-- some nodes like i.e. dirt with grass or stone with coal cannot be obtained;
	-- in such a case we ask for the drop
	node_really_wanted = handle_schematics.get_what_player_can_provide( node_wanted );

	-- the player might be wielding the requested item
	if( itemstack and itemstack:get_name() and itemstack:get_name()==node_really_wanted and itemstack:get_count()>0 ) then
		itemstack:take_item();

	-- clicker does not have an inventory; it might be a mob
	elseif( not( clicker.get_inventory )) then
		return itemstack;

	-- ...or it might be found elsewhere in the player's inventory
	elseif(not( clicker:get_inventory():contains_item("main", node_really_wanted ))) then
		if( clicker:is_player()) then
			local descr = "-?-";
			if( minetest.registered_items[ node_really_wanted ] ) then
				descr = minetest.registered_items[ node_really_wanted ].description;
				if( not( descr )) then
					descr = minetest.registered_items[ node_really_wanted ].name;
				end
			end

			minetest.chat_send_player( clicker:get_player_name(),
				"You have no "..( descr or "such node").." ["..node_really_wanted.."].");
		end
		return itemstack;
	end
	-- give the player some feedback (might scroll a bit..)
	local node_def = handle_schematics.node_defined( node_really_wanted );
	if( clicker:is_player()
	   and node_def
	   and node_def.description) then
		minetest.chat_send_player( clicker:get_player_name(),
			"Placed "..( node_def.description or node_really_wanted)..".");
	end
	-- take the item from the player (provided it actually is a player and not a mob)
	if( clicker.get_inventory ) then
		clicker:get_inventory():remove_item("main", node_really_wanted.." 1");

		-- if a bucket:bucket_* was used for placing water: return the empty bucket
		if( node_really_wanted ~= "bucket:bucket_empty"
		  and string.sub( node_really_wanted, 1, 14)=="bucket:bucket_") then
			clicker:get_inventory():add_item("main", "bucket:bucket_empty 1");
		end
		-- if a seed is placed: hoe the ground below if needed (it might have returned
		-- to base or dry state due to water not having been placed yet)
		if( string.sub( node_really_wanted, 1, 13 )=="farming:seed_") then
			local node_below = minetest.get_node( {x=pos.x, y=pos.y-1, z=pos.z});
			if( node_below and node_below.name) then
				local def = minetest.registered_nodes[ node_below.name ];
				if( def and def.soil and def.soil.base and def.soil.base==node_below.name
				  and def.soil.wet) then
					minetest.set_node( {x=pos.x, y=pos.y-1, z=pos.z}, {name=def.soil.wet} );
				end
			end
		end
		-- avoid consuming two beds (because top and bottom both have the same drop)
		if( string.sub( node_wanted, 1, 5 )=="beds:") then
			if( string.sub( node_wanted, -7)=="_bottom") then
				local top_pos = vector.add(pos, minetest.facedir_to_dir(param2_wanted));
				local top_name = string.sub( node_wanted, 1, -8).."_top";
				minetest.set_node(top_pos, {name = top_name, param2 = param2_wanted});
			elseif( string.sub( node_wanted, -4)=="_top") then
				local bot_pos = vector.add(pos, minetest.facedir_to_dir((param2_wanted+2)%4));
				local bot_name = string.sub( node_wanted, 1, -5).."_bottom";
				minetest.set_node(bot_pos, {name = bot_name, param2 = param2_wanted});
			end
		end
	end

	minetest.remove_node( pos );
	minetest.set_node( pos, { name =  node_wanted, param1 = 0, param2 = param2_wanted } );

	return itemstack;
end


-- right-clicking a dig_here-indicator ought to dig the next node below it that needs digging and place appropriate scaffolding
handle_schematics.dig_node_using_dig_here_indicator = function(pos, clicker, itemstack )
	if not( default.can_interact_with_node(clicker, pos)) then
		return itemstack;
	end

	-- TODO: itemstack:get_tool_capabilities() can be used to check and wear down the tool
--if( itemstack ) then minetest.chat_send_player("singleplayer", "You are trying to dig with "..minetest.serialize(itemstack:get_name()).." with tool capabilities: "..minetest.serialize(itemstack:get_tool_capabilities())); end
	local meta = minetest.get_meta( pos );
	local nodes_wanted_str = meta:get_string( "node_wanted_down_there");
	if( not( nodes_wanted_str )) then
		return itemstack;
	end
	local nodes_wanted = minetest.deserialize( nodes_wanted_str );
	local cid_air = minetest.get_content_id("air");

	if( nodes_wanted ) then
	for i=1,table.getn( nodes_wanted ) do
		local p = {x=pos.x, y=pos.y-i, z=pos.z};
		local node = minetest.get_node( p );
		-- found a node that is not yet scaffolding
		if( node and node.name and node.name ~= "handle_schematics:support_setup") then
			for j,v in ipairs( nodes_wanted ) do
				-- get the entry at the right position
				if( v and v[1] == p.y ) then
					-- dig the old node and add it to the inventory
					-- TODO: can mobs dig that way?
					-- TODO: require suitable tools
					-- TODO: tools ought to get dammaged a bit by digging
					if( node.name ~= "air") then
						minetest.node_dig(p, node, clicker);
						-- TODO: if the digged node is the first that is to go into this itemstack it won't end up in the player's inventory
						return itemstack;
					end
					if( v[2] ~= cid_air) then
						-- place the scaffolding node
						minetest.set_node( p, {name="handle_schematics:support_setup"});
						-- configure the scaffolding node
						handle_schematics.setup_scaffolding( { x=p.x, y=p.y, z=p.z, node_wanted=v[2], param2_wanted=v[3] });
						-- we are done
						return itemstack;
					end
				end
			end
		end
	end
	end
	-- we are done; the dig_here-indicator can be removed
	minetest.set_node( pos, {name="air"});
	-- the place where the dig_here indicator used to be may require a scaffolding node
	if( nodes_wanted
	  and nodes_wanted[#nodes_wanted]
	  and nodes_wanted[#nodes_wanted][1]
	  and nodes_wanted[#nodes_wanted][1] == pos.y
	  and nodes_wanted[#nodes_wanted][2] ~= cid_air) then
		local v = nodes_wanted[#nodes_wanted];
		local p = pos;
		minetest.set_node( p, {name="handle_schematics:support_setup"});
		handle_schematics.setup_scaffolding( { x=p.x, y=p.y, z=p.z, node_wanted=v[2], param2_wanted=v[3] });
	end
	return itemstack;
end




-- this node will only be placed by spawning a house with handle_schematics
minetest.register_node("handle_schematics:support_setup", {
        description = "support structure for buildings (configured)",
        tiles = {"handle_schematics_support.png"},
	groups = {snappy=3,choppy=3,oddly_breakable_by_hand=3},
	visual_scale = 1.2,
        walkable = false,
        climbable = true,
        paramtype = "light",
        drawtype = "plantlike",
	-- after it is digged, the node looses its information and becomes a normal, unconfigured one
	-- -> changed to no drop because it is automaticly placed in almost unlimited amount
	drop = "", --"handle_schematics:support",
	-- note: mobs that want to use this function ought to provide "clicker" in a way so that clicker:get_inventory
	--       can get used (at least if they want to have a limited inventory)
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
				return handle_schematics.place_node_using_support_setup(pos, clicker, itemstack );
			end
})


-- no craft receipe for this node as it's only an indicator that the player shall dig here
minetest.register_node("handle_schematics:dig_here", {
	description = "dig the node below this one",
	tiles = {"default_tool_mesepick.png^[colorize:#FF0000^[transformFXR90"},
	inventory_image = "default_tool_mesepick.png^[colorize:#FF0000^[transformFXR90";
	-- falling node; will notice if the node below it is beeing digged; cannot be destroyed the normal way
	groups = {snappy=3,choppy=3,oddly_breakable_by_hand=3}, --{falling_node = 1},
	-- no drop because it is only an indicator and automaticly placed
	drop = "",
	visual_scale = 0.6,
	walkable = false,
	climbable = true,
	paramtype = "light",
	drawtype = "torchlike",
	-- this node's purpose is to indicate that the player shall dig here;
	-- that requires beeing able to actually aim at that node below
	selection_box = {
                type = "fixed",
                fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16}
        },
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
				return handle_schematics.dig_node_using_dig_here_indicator(pos, clicker, itemstack );
			end

})
