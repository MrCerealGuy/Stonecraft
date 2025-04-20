---------------------------------------------------------------------------------------
-- furniture
---------------------------------------------------------------------------------------
-- contains:
--  * a bed seperated into foot and head reagion so that it can be placed manually; it has
--    no other functionality than decoration!
--  * a sleeping mat - mostly for NPC that cannot afford a bet yet
--  * bench - if you don't have 3dforniture:chair, then this is the next best thing
--  * table - very simple one
--  * shelf - for stroring things; this one is 3d
--  * stovepipe - so that the smoke from the furnace can get away
--  * washing place - put it over a water source and you can 'wash' yourshelf
---------------------------------------------------------------------------------------
-- TODO: change the textures of the bed (make the clothing white, foot path not entirely covered with cloth)

local S = cottages.S

-- a bed without functionality - just decoration
minetest.register_node("cottages:bed_foot", {
	description = S("Bed (foot region)"),
	drawtype = "nodebox",
	tiles = {"cottages_beds_bed_top_bottom.png", cottages.texture_furniture,  "cottages_beds_bed_side.png",  "cottages_beds_bed_side.png",  "cottages_beds_bed_side.png",  "cottages_beds_bed_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = cottages.sounds.wood,
	node_box = {
		type = "fixed",
		fixed = {
					-- bed
					{-0.5, 0.0, -0.5, 0.5, 0.3, 0.5},
					
					-- stützen
					{-0.5, -0.5, -0.5, -0.4, 0.5, -0.4},
					{  0.4,-0.5, -0.5, 0.5,  0.5, -0.4},
                               
                                        -- Querstrebe
					{-0.4,  0.3, -0.5, 0.4, 0.5, -0.4}
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.3, 0.5},
				}
	},
	is_ground_content = false,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
				return cottages.sleep_in_bed( pos, node, clicker, itemstack, pointed_thing );
			end
})

-- the bed is split up in two parts to avoid destruction of blocks on placement
minetest.register_node("cottages:bed_head", {
	description = S("Bed (head region)"),
	drawtype = "nodebox",
	tiles = {"cottages_beds_bed_top_top.png", cottages.texture_furniture,  "cottages_beds_bed_side_top_r.png",  "cottages_beds_bed_side_top_l.png",  cottages.texture_furniture,  "cottages_beds_bed_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = cottages.sounds.wood,
	node_box = {
		type = "fixed",
		fixed = {
					-- bed
					{-0.5, 0.0, -0.5, 0.5, 0.3, 0.5},
					
					-- stützen
					{-0.5,-0.5, 0.4, -0.4, 0.5, 0.5},
					{ 0.4,-0.5, 0.4,  0.5, 0.5, 0.5},

                                        -- Querstrebe
					{-0.4,  0.3,  0.4, 0.4, 0.5,  0.5}
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.3, 0.5},
				}
	},
	is_ground_content = false,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
				return cottages.sleep_in_bed( pos, node, clicker, itemstack, pointed_thing );
			end
})


-- the basic version of a bed - a sleeping mat
-- to facilitate upgrade path straw mat -> sleeping mat -> bed, this uses a nodebox
minetest.register_node("cottages:sleeping_mat", {
        description = S("sleeping mat"),
        drawtype = 'nodebox',
        tiles = { 'cottages_sleepingmat.png' }, -- done by VanessaE
        wield_image = 'cottages_sleepingmat.png',
        inventory_image = 'cottages_sleepingmat.png',
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        walkable = false,
        groups = { snappy = 3 },
	sounds = cottages.sounds.leaves,
        selection_box = {
                        type = "wallmounted",
                        },
        node_box = {
                type = "fixed",
                fixed = {
                                        {-0.48, -0.5,-0.48,  0.48, -0.5+1/16, 0.48},
                        }
        },
        selection_box = {
                type = "fixed",
                fixed = {
                                        {-0.48, -0.5,-0.48,  0.48, -0.5+2/16, 0.48},
                        }
        },
	is_ground_content = false,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
				return cottages.sleep_in_bed( pos, node, clicker, itemstack, pointed_thing );
			end
})


-- this one has a pillow for the head; thus, param2 becomes visible to the builder, and mobs may use it as a bed
minetest.register_node("cottages:sleeping_mat_head", {
        description = S("sleeping mat with pillow"),
        drawtype = 'nodebox',
        tiles = { 'cottages_sleepingmat.png' }, -- done by VanessaE
        wield_image = 'cottages_sleepingmat.png',
        inventory_image = 'cottages_sleepingmat.png',
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        groups = { snappy = 3 },
	sounds = cottages.sounds.leaves,
        node_box = {
                type = "fixed",
                fixed = {
                                        {-0.48, -0.5,-0.48,  0.48, -0.5+1/16, 0.48},
                                        {-0.34, -0.5+1/16,-0.12,  0.34, -0.5+2/16, 0.34},
                        }
        },
        selection_box = {
                type = "fixed",
                fixed = {
                                        {-0.48, -0.5,-0.48,  0.48, -0.5+2/16, 0.48},
                        }
        },
	is_ground_content = false,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
				return cottages.sleep_in_bed( pos, node, clicker, itemstack, pointed_thing );
			end
})


-- furniture; possible replacement: 3dforniture:chair
minetest.register_node("cottages:bench", {
	drawtype = "nodebox",
	description = S("simple wooden bench"),
	tiles = {"cottages_minimal_wood.png", "cottages_minimal_wood.png",  "cottages_minimal_wood.png",  "cottages_minimal_wood.png",  "cottages_minimal_wood.png",  "cottages_minimal_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = cottages.sounds.wood,
	node_box = {
		type = "fixed",
		fixed = {
					-- sitting area
					{-0.5, -0.15, 0.1,  0.5,  -0.05, 0.5},
					
					-- stützen
					{-0.4, -0.5,  0.2, -0.3, -0.15, 0.4},
					{ 0.3, -0.5,  0.2,  0.4, -0.15, 0.4},
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.5, -0.5, 0, 0.5, 0, 0.5},
				}
	},
	is_ground_content = false,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
				return cottages.sit_on_bench( pos, node, clicker, itemstack, pointed_thing );
			end,
})


-- a simple table; possible replacement: 3dforniture:table
local cottages_table_def = {
		description = S("table"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.1, -0.5, -0.1,  0.1, 0.3,  0.1},
				{ -0.5,  0.48, -0.5,  0.5, 0.4,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.4,  0.5},
			},
		},
		is_ground_content = false,
}


-- search for the workbench in AdventureTest
local workbench = minetest.registered_nodes[ "workbench:3x3"];
if( workbench ) then
	cottages_table_def.tiles        = {workbench.tiles[1], cottages_table_def.tiles[1]};
	cottages_table_def.on_rightclick = workbench.on_rightclick;
end
-- search for the workbench from RealTEst
workbench = minetest.registered_nodes[ "workbench:work_bench_birch"];
if( workbench ) then
	cottages_table_def.tiles	= {workbench.tiles[1], cottages_table_def.tiles[1]};
	cottages_table_def.on_construct = workbench.on_construct;
	cottages_table_def.can_dig      = workbench.can_dig;
	cottages_table_def.on_metadata_inventory_take = workbench.on_metadata_inventory_take;
	cottages_table_def.on_metadata_inventory_move = workbench.on_metadata_inventory_move;
	cottages_table_def.on_metadata_inventory_put  = workbench.on_metadata_inventory_put;
end

minetest.register_node("cottages:table", cottages_table_def );

-- looks better than two slabs impersonating a shelf; also more 3d than a bookshelf 
-- the infotext shows if it's empty or not
minetest.register_node("cottages:shelf", {
		description = S("open storage shelf"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {

 				{ -0.5, -0.5, -0.3, -0.4,  0.5,  0.5},
 				{  0.4, -0.5, -0.3,  0.5,  0.5,  0.5},

				{ -0.5, -0.2, -0.3,  0.5, -0.1,  0.5},
				{ -0.5,  0.3, -0.3,  0.5,  0.4,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
			},
		},

		on_construct = function(pos)

                	local meta = minetest.get_meta(pos);

			local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	                meta:set_string("formspec",
                                "size[8,8]"..
                                "list[current_name;main;0,0;8,3;]"..
                                "list[current_player;main;0,4;8,4;]"..
				"listring[nodemeta:" .. spos .. ";main]" ..
				"listring[current_player;main]")
                	meta:set_string("infotext", S("open storage shelf"))
                	local inv = meta:get_inventory();
                	inv:set_size("main", 24);
        	end,

	        can_dig = function( pos,player )
	                local  meta = minetest.get_meta( pos );
	                local  inv = meta:get_inventory();
	                return inv:is_empty("main");
	        end,

                on_metadata_inventory_put  = function(pos, listname, index, stack, player)
	                local  meta = minetest.get_meta( pos );
                        meta:set_string('infotext', S('open storage shelf (in use)'));
                end,
                on_metadata_inventory_take = function(pos, listname, index, stack, player)
	                local  meta = minetest.get_meta( pos );
	                local  inv = meta:get_inventory();
	                if( inv:is_empty("main")) then
                           meta:set_string('infotext', S('open storage shelf (empty)'));
                        end
                end,
		is_ground_content = false,


})

-- so that the smoke from a furnace can get out of a building
minetest.register_node("cottages:stovepipe", {
		description = S("stovepipe"),
		drawtype = "nodebox",
		tiles = {"cottages_steel_block.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{  0.20, -0.5, 0.20,  0.45, 0.5,  0.45},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{  0.20, -0.5, 0.20,  0.45, 0.5,  0.45},
			},
		},
		is_ground_content = false,
})


-- this washing place can be put over a water source (it is open at the bottom)
minetest.register_node("cottages:washing", {
		description = S("washing place"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_clay.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, -0.2, -0.2},

				{ -0.5, -0.5, -0.2, -0.4, 0.2,  0.5},
				{  0.4, -0.5, -0.2,  0.5, 0.2,  0.5},

				{ -0.4, -0.5,  0.4,  0.4, 0.2,  0.5},
				{ -0.4, -0.5, -0.2,  0.4, 0.2, -0.1},

			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.2,  0.5},
			},
		},
                on_rightclick = function(pos, node, player)
                   -- works only with water beneath
                   local node_under = minetest.get_node( {x=pos.x, y=(pos.y-1), z=pos.z} );
		   if( not( node_under ) or node_under.name == "ignore" or (node_under.name ~= 'default:water_source' and node_under.name ~= 'default:water_flowing')) then
                      minetest.chat_send_player( player:get_player_name(), S("Sorry. This washing place is out of water. Please place it above water!"));
		   else
                      minetest.chat_send_player( player:get_player_name(), S("You feel much cleaner after some washing."));
		   end
                end,
		is_ground_content = false,

})


---------------------------------------------------------------------------------------
-- functions for sitting or sleeping
---------------------------------------------------------------------------------------

cottages.allow_sit = function( player )
	-- no check possible
	if( not( player.get_player_velocity )) then
		return true;
	end
	local velo = player:get_player_velocity();
	if( not( velo )) then
		return false;
	end
	local max_velo = 0.0001;
	if(   math.abs(velo.x) < max_velo
	  and math.abs(velo.y) < max_velo
	  and math.abs(velo.z) < max_velo ) then
		return true;
	end
	return false;
end

cottages.sit_on_bench = function( pos, node, clicker, itemstack, pointed_thing )
	if( not( clicker ) or not( default.player_get_animation ) or not( cottages.allow_sit( clicker ))) then
		return;
	end

	local animation = default.player_get_animation( clicker );
	local pname = clicker:get_player_name();

	if( animation and animation.animation=="sit") then
		default.player_attached[pname] = false
		clicker:set_pos({x=pos.x,y=pos.y-0.5,z=pos.z})
		clicker:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
		clicker:set_physics_override(1, 1, 1)
		default.player_set_animation(clicker, "stand", 30)
	else
		-- the bench is not centered; prevent the player from sitting on air
		local p2 = {x=pos.x, y=pos.y, z=pos.z};
		if not( node ) or node.param2 == 0 then
			p2.z = p2.z+0.3;
		elseif node.param2 == 1 then
			p2.x = p2.x+0.3;
		elseif node.param2 == 2 then
			p2.z = p2.z-0.3;
		elseif node.param2 == 3 then
			p2.x = p2.x-0.3;
		end

		clicker:set_eye_offset({x=0,y=-7,z=2}, {x=0,y=0,z=0})
		clicker:set_pos( p2 )
		default.player_set_animation(clicker, "sit", 30)
		clicker:set_physics_override(0, 0, 0)
		default.player_attached[pname] = true
	end
end

cottages.sleep_in_bed = function( pos, node, clicker, itemstack, pointed_thing )
	if( not( clicker ) or not( node ) or not( node.name ) or not( pos ) or not( cottages.allow_sit( clicker))) then
		return;
	end

	local animation = default.player_get_animation( clicker );
	local pname = clicker:get_player_name();

	local p_above = minetest.get_node( {x=pos.x, y=pos.y+1, z=pos.z});
	if( not( p_above) or not( p_above.name ) or p_above.name ~= 'air' ) then
		minetest.chat_send_player( pname, "This place is too narrow for sleeping. At least for you!");
		return;
	end

	local place_name = 'place';
	-- if only one node is present, the player can only sit;
	-- sleeping requires a bed head+foot or two sleeping mats
	local allow_sleep = false;
	local new_animation = 'sit';

	-- let players get back up
	if( animation and animation.animation=="lay" ) then
		default.player_attached[pname] = false
		clicker:set_pos({x=pos.x,y=pos.y-0.5,z=pos.z})
		clicker:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
		clicker:set_physics_override(1, 1, 1)
		default.player_set_animation(clicker, "stand", 30)
		minetest.chat_send_player( pname, 'That was enough sleep for now. You stand up again.');
		return;
	end

	local second_node_pos = {x=pos.x, y=pos.y, z=pos.z};
	-- the node that will contain the head of the player
	local p = {x=pos.x, y=pos.y, z=pos.z};
	-- the player's head is pointing in this direction
	local dir = node.param2;
	-- it would be odd to sleep in half a bed
	if(     node.name=='cottages:bed_head' ) then
		if(     node.param2==0 ) then
			second_node_pos.z = pos.z-1;
		elseif( node.param2==1) then
			second_node_pos.x = pos.x-1;
		elseif( node.param2==2) then
			second_node_pos.z = pos.z+1;
		elseif( node.param2==3) then
			second_node_pos.x = pos.x+1;
		end
		local node2 = minetest.get_node( second_node_pos );
		if( not( node2 ) or not( node2.param2 ) or not( node.param2 )
		   or node2.name   ~= 'cottages:bed_foot'
		   or node2.param2 ~= node.param2 ) then
			allow_sleep = false;
		else
			allow_sleep = true;
		end
		place_name = 'bed';

	-- if the player clicked on the foot of the bed, locate the head
	elseif( node.name=='cottages:bed_foot' ) then
		if(     node.param2==2 ) then
			second_node_pos.z = pos.z-1;
		elseif( node.param2==3) then
			second_node_pos.x = pos.x-1;
		elseif( node.param2==0) then
			second_node_pos.z = pos.z+1;
		elseif( node.param2==1) then
			second_node_pos.x = pos.x+1;
		end
		local node2 = minetest.get_node( second_node_pos );
		if( not( node2 ) or not( node2.param2 ) or not( node.param2 )
		   or node2.name   ~= 'cottages:bed_head'
		   or node2.param2 ~= node.param2 ) then
			allow_sleep = false;
		else
			allow_sleep = true;
		end
		if( allow_sleep==true ) then
			p = {x=second_node_pos.x, y=second_node_pos.y, z=second_node_pos.z};
		end
		place_name = 'bed';

	elseif( node.name=='cottages:sleeping_mat' or node.name=='cottages:straw_mat' or node.name=='cottages:sleeping_mat_head') then
		place_name = 'mat';
		dir = node.param2;
		allow_sleep = false;
		-- search for a second mat right next to this one
		local offset = {{x=0,z=-1}, {x=-1,z=0}, {x=0,z=1}, {x=1,z=0}};
		for i,off in ipairs( offset ) do
			node2 = minetest.get_node( {x=pos.x+off.x, y=pos.y, z=pos.z+off.z} );
			if( node2.name == 'cottages:sleeping_mat' or node2.name=='cottages:straw_mat' or node.name=='cottages:sleeping_mat_head' ) then
				-- if a second mat is found, sleeping is possible
				allow_sleep = true;
				dir = i-1;
			end
		end
	end

	-- set the right height for the bed
	if( place_name=='bed' ) then
		p.y = p.y+0.4;
	end
	if( allow_sleep==true ) then
		-- set the right position (middle of the bed)
		if(     dir==0 ) then
			p.z = p.z-0.5;
		elseif( dir==1 ) then
			p.x = p.x-0.5;
		elseif( dir==2 ) then
			p.z = p.z+0.5;
		elseif( dir==3 ) then
			p.x = p.x+0.5;
		end
	end
	
	if( default.player_attached[pname] and animation.animation=="sit") then
		-- just changing the animation...
		if( allow_sleep==true ) then
			default.player_set_animation(clicker, "lay", 30)
			clicker:set_eye_offset({x=0,y=-14,z=2}, {x=0,y=0,z=0})
			minetest.chat_send_player( pname, 'You lie down and take a nap. A right-click will wake you up.');
			return;
		-- no sleeping on this place
		else
			default.player_attached[pname] = false
			clicker:set_pos({x=pos.x,y=pos.y-0.5,z=pos.z})
			clicker:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
			clicker:set_physics_override(1, 1, 1)
			default.player_set_animation(clicker, "stand", 30)
			minetest.chat_send_player( pname, 'That was enough sitting around for now. You stand up again.');
			return;
		end
	end


	clicker:set_eye_offset({x=0,y=-7,z=2}, {x=0,y=0,z=0})
	clicker:set_pos( p );
	default.player_set_animation(clicker, new_animation, 30)
	clicker:set_physics_override(0, 0, 0)
	default.player_attached[pname] = true

	if( allow_sleep==true) then
		minetest.chat_send_player( pname, 'Aaah! What a comftable '..place_name..'. A second right-click will let you sleep.');
	else
		minetest.chat_send_player( pname, 'Comftable, but not good enough for a nap. Right-click again if you want to get back up.');
	end
end

---------------------------------------------------------------------------------------
-- crafting receipes
---------------------------------------------------------------------------------------
minetest.register_craft({
	output = "cottages:bed_foot",
	recipe = {
		{cottages.craftitem_wool,    "", "", },
		{cottages.craftitem_wood,  "", "", },
		{cottages.craftitem_stick, "", "", }
	}
})

minetest.register_craft({
	output = "cottages:bed_head",
	recipe = {
		{"", "",              cottages.craftitem_wool, },
		{"", cottages.craftitem_stick, cottages.craftitem_wood, },
		{"", "",              cottages.craftitem_stick, }
	}
})

minetest.register_craft({
	output = "cottages:sleeping_mat 3",
	recipe = {
		{"cottages:wool_tent", "cottages:straw_mat","cottages:straw_mat" }
	}
})


minetest.register_craft({
	output = "cottages:sleeping_mat_head",
	recipe = {
		{"cottages:sleeping_mat","cottages:straw_mat" }
	}
})

minetest.register_craft({
	output = "cottages:table",
	recipe = {
		{"", cottages.craftitem_slab_wood, "", },
		{"", cottages.craftitem_stick, "" }
	}
})

minetest.register_craft({
	output = "cottages:bench",
	recipe = {
		{"",              cottages.craftitem_wood, "", },
		{cottages.craftitem_stick, "",             cottages.craftitem_stick, }
	}
})


minetest.register_craft({
	output = "cottages:shelf",
	recipe = {
		{cottages.craftitem_stick,  cottages.craftitem_wood, cottages.craftitem_stick, },
		{cottages.craftitem_stick, cottages.craftitem_wood, cottages.craftitem_stick, },
		{cottages.craftitem_stick, "",             cottages.craftitem_stick}
	}
})

minetest.register_craft({
	output = "cottages:washing 2",
	recipe = {
		{cottages.craftitem_stick, },
		{cottages.craftitem_clay,  },
	}
})

minetest.register_craft({
	output = "cottages:stovepipe 2",
	recipe = {
		{cottages.craftitem_steel, '', cottages.craftitem_steel},
	}
})
