
-----------------------------------------------------------------------------------------------------------
-- These nodes are all like doors in a way:
--  * window shutters (they open on right-click and when it turns day; they close at night)
--  * a half-door where the top part can be opened seperately from the bottom part
--  * a gate that drops to the floor when opened
--
-----------------------------------------------------------------------------------------------------------
-- IMPORTANT NOTICE: If you have a very slow computer, it might be wise to increase the rate at which the
--                   abm that opens/closes the window shutters is called. Anything less than 10 minutes
--                   (600 seconds) ought to be ok.
-----------------------------------------------------------------------------------------------------------
local S = cottages.S

-----------------------------------------------------------------------------------------------------------
-- small window shutters for single-node-windows; they open at day and close at night if the abm is working
-----------------------------------------------------------------------------------------------------------

-- propagate shutting/closing of window shutters to window shutters below/above this one
cottages_window_sutter_operate = function( pos, old_node_state_name, new_node_state_name )
   
   local offsets   = {-1,1,-2,2,-3,3};
   local stop_up   = 0;
   local stop_down = 0;

   for i,v in ipairs(offsets) do

      local node = minetest.get_node_or_nil( {x=pos.x, y=(pos.y+v), z=pos.z } );
      if( node and node.name and node.name==old_node_state_name 
        and ( (v > 0 and stop_up   == 0 ) 
           or (v < 0 and stop_down == 0 ))) then

         minetest.swap_node({x=pos.x, y=(pos.y+v), z=pos.z }, {name = new_node_state_name, param2 = node.param2})

      -- found a diffrent node - no need to search further up
      elseif( v > 0 and stop_up   == 0 ) then
         stop_up   = 1; 

      elseif( v < 0 and stop_down == 0 ) then
         stop_down = 1; 
      end
   end
end

-- window shutters - they cover half a node to each side
minetest.register_node("cottages:window_shutter_open", {
		description = S("opened window shutters"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
                -- larger than one node but slightly smaller than a half node so that wallmounted torches pose no problem
		node_box = {
			type = "fixed",
			fixed = {
				{-0.90, -0.5,  0.4, -0.45, 0.5,  0.5},
				{ 0.45, -0.5,  0.4,  0.9, 0.5,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.9, -0.5,  0.4,  0.9, 0.5,  0.5},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    minetest.swap_node(pos, {name = "cottages:window_shutter_closed", param2 = node.param2})
                    cottages_window_sutter_operate( pos, "cottages:window_shutter_open", "cottages:window_shutter_closed" );
                end,
		is_ground_content = false,
})

minetest.register_node("cottages:window_shutter_closed", {
		description = S("closed window shutters"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5,  -0.5,  0.4, -0.05, 0.5,  0.5},
				{ 0.05, -0.5,  0.4,  0.5,  0.5,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5,  0.4,  0.5, 0.5,  0.5},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    minetest.swap_node(pos, {name = "cottages:window_shutter_open", param2 = node.param2})
                    cottages_window_sutter_operate( pos, "cottages:window_shutter_closed", "cottages:window_shutter_open" );
                end,
		is_ground_content = false,
		drop = "cottages:window_shutter_open",
})


-- open shutters in the morning
minetest.register_abm({
   nodenames = {"cottages:window_shutter_closed"},
   interval = 20, -- change this to 600 if your machine is too slow
   chance = 3, -- not all people wake up at the same time!
   action = function(pos)

        -- at this time, sleeping in a bed is not possible
        if( not(minetest.get_timeofday() < 0.2 or minetest.get_timeofday() > 0.805)) then
           local old_node = minetest.get_node( pos );
           minetest.swap_node(pos, {name = "cottages:window_shutter_open", param2 = old_node.param2})
           cottages_window_sutter_operate( pos, "cottages:window_shutter_closed", "cottages:window_shutter_open" );
       end
   end
})


-- close them at night
minetest.register_abm({
   nodenames = {"cottages:window_shutter_open"},
   interval = 20, -- change this to 600 if your machine is too slow
   chance = 2,
   action = function(pos)

        -- same time at which sleeping is allowed in beds
        if( minetest.get_timeofday() < 0.2 or minetest.get_timeofday() > 0.805) then
           local old_node = minetest.get_node( pos );
           minetest.swap_node(pos, {name = "cottages:window_shutter_closed", param2 = old_node.param2})
           cottages_window_sutter_operate( pos, "cottages:window_shutter_open", "cottages:window_shutter_closed" );
        end
   end
})


------------------------------------------------------------------------------------------------------------------------------
-- a half door; can be combined to a full door where the upper part can be operated seperately; usually found in barns/stables
------------------------------------------------------------------------------------------------------------------------------
minetest.register_node("cottages:half_door", {
		description = S("half door"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5,  0.4,  0.48, 0.5,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5,  0.4,  0.48, 0.5,  0.5},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    local node2 = minetest.get_node( {x=pos.x,y=(pos.y+1),z=pos.z});

                    local param2 = node.param2;
                    if(     param2%4 == 1) then param2 = param2+1; --2;
                    elseif( param2%4 == 2) then param2 = param2-1; --1;
                    elseif( param2%4 == 3) then param2 = param2-3; --0;
                    elseif( param2%4 == 0) then param2 = param2+3; --3;
                    end;
                    minetest.swap_node(pos, {name = "cottages:half_door", param2 = param2})
                    -- if the node above consists of a door of the same type, open it as well
                    -- Note: doors beneath this one are not opened! It is a special feature of these doors that they can be opend partly
                    if( node2 ~= nil and node2.name == node.name and node2.param2==node.param2) then
                       minetest.swap_node( {x=pos.x,y=(pos.y+1),z=pos.z}, {name = "cottages:half_door", param2 = param2})
                    end
                end,
		is_ground_content = false,
})



minetest.register_node("cottages:half_door_inverted", {
		description = S("half door inverted"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5,  0.48, 0.5, -0.4},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5,  0.48, 0.5, -0.4},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    local node2 = minetest.get_node( {x=pos.x,y=(pos.y+1),z=pos.z});

                    local param2 = node.param2;
                    if(     param2%4 == 1) then param2 = param2-1; --0;
                    elseif( param2%4 == 0) then param2 = param2+1; --1;
                    elseif( param2%4 == 2) then param2 = param2+1; --3;
                    elseif( param2%4 == 3) then param2 = param2-1; --2;
                    end;
                    minetest.swap_node(pos, {name = "cottages:half_door_inverted", param2 = param2})
                    -- open upper parts of this door (if there are any)
                    if( node2 ~= nil and node2.name == node.name and node2.param2==node.param2) then
                       minetest.swap_node( {x=pos.x,y=(pos.y+1),z=pos.z}, {name = "cottages:half_door_inverted", param2 = param2})
                    end
                end,
		is_ground_content = false,
})




------------------------------------------------------------------------------------------------------------------------------
-- this gate for fences solves the "where to store the opened gate" problem by dropping it to the floor in optened state
------------------------------------------------------------------------------------------------------------------------------
minetest.register_node("cottages:gate_closed", {
		description = S("closed fence gate"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {cottages.texture_furniture},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.85, -0.25, -0.02,  0.85, -0.05,  0.02},
				{ -0.85,  0.15, -0.02,  0.85,  0.35,  0.02},

				{ -0.80, -0.05, -0.02, -0.60,  0.15,  0.02},
				{  0.60, -0.05, -0.02,  0.80,  0.15,  0.02},
				{ -0.15, -0.05, -0.02,  0.15,  0.15,  0.02},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.85, -0.25, -0.1,  0.85,  0.35,  0.1},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    minetest.swap_node(pos, {name = "cottages:gate_open", param2 = node.param2})
                end,
		is_ground_content = false,
})


minetest.register_node("cottages:gate_open", {
		description = S("opened fence gate"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {cottages.texture_furniture},
		paramtype = "light",
		paramtype2 = "facedir",
		drop = "cottages:gate_closed",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.85, -0.5, -0.25,  0.85, -0.46, -0.05},
				{ -0.85, -0.5,  0.15,  0.85, -0.46,  0.35},

				{ -0.80, -0.5, -0.05, -0.60, -0.46,  0.15},
				{  0.60, -0.5, -0.05,  0.80, -0.46,  0.15},
				{ -0.15, -0.5, -0.05,  0.15, -0.46,  0.15},

			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.85, -0.5, -0.25, 0.85, -0.3, 0.35},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    minetest.swap_node(pos, {name = "cottages:gate_closed", param2 = node.param2})
                end,
		is_ground_content = false,
		drop = "cottages:gate_closed",
})



-----------------------------------------------------------------------------------------------------------
-- a hatch; nodebox definition taken from realtest
-----------------------------------------------------------------------------------------------------------

-- hatches rotate around their axis
--  old facedir:  0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20,21,22,23
new_facedirs = { 10,19, 4,13, 2,18,22,14,20,16, 0,12,11, 3, 7,21, 9,23, 5, 1, 8,15, 6,17};


cottages.register_hatch = function( nodename, description, texture, receipe_item )

	minetest.register_node( nodename, {
		description = S(description), -- not that there are any other...
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = { texture }, 
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},

                node_box = {
                        type = "fixed",
                        fixed = {
                                {-0.49, -0.55, -0.49, -0.3, -0.45, 0.45},
--                                {-0.5, -0.55, 0.3, 0.3, -0.45, 0.5},
                                {0.3, -0.55, -0.3, 0.49, -0.45, 0.45},
                                {0.49, -0.55, -0.49, -0.3, -0.45, -0.3},
                                {-0.075, -0.55, -0.3, 0.075, -0.45, 0.3},
                                {-0.3, -0.55, -0.075, -0.075, -0.45, 0.075},
                                {0.075, -0.55, -0.075, 0.3, -0.45, 0.075},

                                {-0.3, -0.55, 0.3, 0.3, -0.45, 0.45},

				-- hinges
      				{-0.45,-0.530, 0.45, -0.15,-0.470, 0.525}, 
      				{ 0.15,-0.530, 0.45,  0.45,-0.470, 0.525}, 

				-- handle
      				{-0.05,-0.60,-0.35, 0.05,-0.40,-0.45}, 
                        },
                },
                selection_box = {
                        type = "fixed",
                        fixed = {-0.5, -0.55, -0.5, 0.5, -0.45, 0.5},
                },
                on_rightclick = function(pos, node, puncher)

                    minetest.swap_node(pos, {name = node.name, param2 = new_facedirs[ node.param2+1 ]})
                end,
		is_ground_content = false,
		on_place = minetest.rotate_node,
	})

	minetest.register_craft({
		output = nodename,
		recipe = {
			{ '',           '',              receipe_item },
			{ receipe_item, cottages.craftitem_stick, ''           },
			{ '',           '',              ''           },
		}
	})
end


-- further alternate hatch materials: wood, tree, copper_block
cottages.register_hatch( 'cottages:hatch_wood',  'wooden hatch', 'cottages_minimal_wood.png',  cottages.craftitem_slab_wood );
cottages.register_hatch( 'cottages:hatch_steel', 'metal hatch',  'cottages_steel_block.png',   cottages.craftitem_steel );




-----------------------------------------------------------------------------------------------------------
-- and now the crafting receipes:
-----------------------------------------------------------------------------------------------------------

-- transform opend and closed shutters into each other for convenience
minetest.register_craft({
	output = "cottages:window_shutter_open",
	recipe = {
		{"cottages:window_shutter_closed" },
	}
})

minetest.register_craft({
	output = "cottages:window_shutter_closed",
	recipe = {
		{"cottages:window_shutter_open" },
	}
})

minetest.register_craft({
	output = "cottages:window_shutter_open",
	recipe = {
		{cottages.craftitem_wood, "", cottages.craftitem_wood },
	}
})

-- transform one half door into another
minetest.register_craft({
	output = "cottages:half_door",
	recipe = {
		{"cottages:half_door_inverted" },
	}
})

minetest.register_craft({
	output = "cottages:half_door_inverted",
	recipe = {
		{"cottages:half_door" },
	}
})

minetest.register_craft({
	output = "cottages:half_door 2",
	recipe = {
		{"", cottages.craftitem_wood, "" },
		{"", cottages.craftitem_door, "" },
	}
})


-- transform open and closed versions into into another for convenience
minetest.register_craft({
	output = "cottages:gate_closed",
	recipe = {
		{"cottages:gate_open" },
	}
})

minetest.register_craft({
	output = "cottages:gate_open",
	recipe = {
		{"cottages:gate_closed"},
	}
})

minetest.register_craft({
	output = "cottages:gate_closed",
	recipe = {
		{cottages.craftitem_stick, cottages.craftitem_stick, cottages.craftitem_wood },
	}
})

