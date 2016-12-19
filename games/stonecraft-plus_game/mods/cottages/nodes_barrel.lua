
---------------------------------------------------------------------
-- a barrel and a tub - plus a function that makes 'round' objects
---------------------------------------------------------------------
-- IMPORTANT NOTE: The barrel requires a lot of nodeboxes. That may be
--                 too much for weak hardware!
---------------------------------------------------------------------
-- Functionality: right-click to open/close a barrel;
--                punch a barrel to change between vertical/horizontal
---------------------------------------------------------------------
-- Changelog:
-- 24.03.13 Can no longer be opended/closed on rightclick because that is now used for a formspec;
--          instead, it can be filled with liquids.
--          Filled barrels will always be closed, while empty barrels will always be open.

-- pipes: table with the following entries for each pipe-part:
--    f: radius factor; if 1, it will have a radius of half a nodebox and fill the entire nodebox
--    h1, h2: height at witch the nodebox shall start and end; usually -0.5 and 0.5 for a full nodebox
--    b: make a horizontal part/shelf
-- horizontal: if 1, then x and y coordinates will be swapped

-- TODO: option so that it works without nodeboxes

local S = cottages.S

barrel = {};

-- prepare formspec
barrel.on_construct = function( pos )

   local meta = minetest.get_meta(pos);
   local percent = math.random( 1, 100 ); -- TODO: show real filling

   meta:set_string( 'formspec', 
                               "size[8,9]"..
                                "image[2.6,2;2,3;default_sandstone.png^[lowpart:"..
                                                (100-percent)..":default_desert_stone.png]".. -- TODO: better images
                                "label[2.2,0;"..S("Pour:").."]"..
                                "list[current_name;input;3,0.5;1,1;]"..
                                "label[5,3.3;"..S("Fill:").."]"..
                                "list[current_name;output;5,3.8;1,1;]"..
                                "list[current_player;main;0,5;8,4;]");


   meta:set_string( 'liquid_type', '' ); -- which liquid is in the barrel?
   meta:set_int(    'liquid_level', 0 ); -- how much of the liquid is in there?

   local inv = meta:get_inventory()
   inv:set_size("input",     1);  -- to fill in new liquid
   inv:set_size("output",    1);  -- to extract liquid 
end


-- can only be digged if there are no more vessels/buckets in any of the slots
-- TODO: allow digging of a filled barrel? this would disallow stacking of them
barrel.can_dig = function( pos, player )
   local  meta = minetest.get_meta(pos);
   local  inv = meta:get_inventory()

   return ( inv:is_empty('input')
        and inv:is_empty('output'));
end


-- the barrel received input; either a new liquid that is to be poured in or a vessel that is to be filled
barrel.on_metadata_inventory_put = function( pos, listname, index, stack, player )
end


-- right-click to open/close barrel; punch to switch between horizontal/vertical position
        minetest.register_node("cottages:barrel", {
                description = S("barrel (closed)"),
                paramtype = "light",
                drawtype = "mesh",
				mesh = "cottages_barrel_closed.obj",
                tiles = {"cottages_barrel.png" },
                groups = { tree = 1, snappy = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2
                },
		drop = "cottages:barrel",
--                on_rightclick = function(pos, node, puncher)
--                    minetest.add_node(pos, {name = "cottages:barrel_open", param2 = node.param2})
--                end,
-- TODO: on_rightclick is no longer available - maybe open if empty and closed if full?
                on_punch      = function(pos, node, puncher)
                    minetest.add_node(pos, {name = "cottages:barrel_lying", param2 = node.param2})
                end,

                on_construct = function( pos )
                   return barrel.on_construct( pos );
                end,
                can_dig = function(pos,player)
                   return barrel.can_dig( pos, player );
                end,
                on_metadata_inventory_put = function(pos, listname, index, stack, player)
                   return barrel.on_metadata_inventory_put( pos, listname, index, stack, player );
                end,
		is_ground_content = false,

        })

        -- this barrel is opened at the top
        minetest.register_node("cottages:barrel_open", {
                description = S("barrel (open)"),
                paramtype = "light",
                drawtype = "mesh",
				mesh = "cottages_barrel.obj",
                tiles = {"cottages_barrel.png" },
                groups = { tree = 1, snappy = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory=1,
                },
		drop = "cottages:barrel",
--                on_rightclick = function(pos, node, puncher)
--                    minetest.add_node(pos, {name = "cottages:barrel", param2 = node.param2})
--                end,
                on_punch      = function(pos, node, puncher)
                    minetest.add_node(pos, {name = "cottages:barrel_lying_open", param2 = node.param2})
                end,
		is_ground_content = false,
        })

        -- horizontal barrel
        minetest.register_node("cottages:barrel_lying", {
                description = S("barrel (closed), lying somewhere"),
                paramtype = "light",
	            paramtype2 = "facedir",
                drawtype = "mesh",
				mesh = "cottages_barrel_closed_lying.obj",
                tiles = {"cottages_barrel.png" },
                groups = { tree = 1, snappy = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory=1,
                },
		drop = "cottages:barrel",
                on_rightclick = function(pos, node, puncher)
                    minetest.add_node(pos, {name = "cottages:barrel_lying_open", param2 = node.param2})
                end,
                on_punch      = function(pos, node, puncher)
                    if( node.param2 < 4 ) then
                       minetest.add_node(pos, {name = "cottages:barrel_lying", param2 = (node.param2+1)})
                    else
                       minetest.add_node(pos, {name = "cottages:barrel", param2 = 0})
                    end
                end,
		is_ground_content = false,
        })

        -- horizontal barrel, open
        minetest.register_node("cottages:barrel_lying_open", {
                description = S("barrel (opened), lying somewhere"),
                paramtype = "light",
	            paramtype2 = "facedir",
                drawtype = "mesh",
				mesh = "cottages_barrel_lying.obj",
                tiles = {"cottages_barrel.png" },
                groups = { tree = 1, snappy = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory=1,
                },
		drop = "cottages:barrel",
                on_rightclick = function(pos, node, puncher)
                    minetest.add_node(pos, {name = "cottages:barrel_lying", param2 = node.param2})
                end,
                on_punch      = function(pos, node, puncher)
                    if( node.param2 < 4 ) then
                       minetest.add_node(pos, {name = "cottages:barrel_lying_open", param2 = (node.param2+1)})
                    else
                       minetest.add_node(pos, {name = "cottages:barrel_open", param2 = 0})
                    end
                end,
		is_ground_content = false,

        })

        -- let's hope "tub" is the correct english word for "bottich"
        minetest.register_node("cottages:tub", {
                description = S("tub"),
                paramtype = "light",
                drawtype = "mesh",
				mesh = "cottages_tub.obj",
                tiles = {"cottages_barrel.png" },
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5,-0.1, 0.5},
			}},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5,-0.1, 0.5},
			}},
                groups = { tree = 1, snappy = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2
                },
		is_ground_content = false,
        })


minetest.register_craft({
	output = "cottages:barrel",
	recipe = {
		{cottages.craftitem_wood,          "",              cottages.craftitem_wood },
		{cottages.craftitem_steel, "",              cottages.craftitem_steel},
		{cottages.craftitem_wood,          cottages.craftitem_wood,    cottages.craftitem_wood },
	},
})

minetest.register_craft({
	output = "cottages:tub 2",
	recipe = {
		{"cottages:barrel"},
	},
})

minetest.register_craft({
	output = "cottages:barrel",
	recipe = {
		{"cottages:tub"},
		{"cottages:tub"},
	},
})
