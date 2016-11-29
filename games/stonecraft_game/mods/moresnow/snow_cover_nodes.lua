

-- the general node definition for all these snow tops (only name and nodebox vary)
moresnow.register_snow_top = function( node_name, fixed_nodebox, wool_nodebox )
	minetest.register_node( 'moresnow:snow_'..node_name, {
		description = "Snow",
		tiles = {"default_snow.png"},  
		inventory_image = "default_snowball.png",
		wield_image = "default_snowball.png",
		is_ground_content = true,
		paramtype = "light",
		paramtype2 = "facedir",
		buildable_to = true,
		drawtype = "nodebox",
		freezemelt = "default:water_flowing",
		node_box = {
			-- leveled would not work well in this situation
			type = "fixed",
			fixed = fixed_nodebox,
		},
		drop = "default:snow",
		groups = {crumbly=3,falling_node=1, float=1, melt=1, not_in_creative_inventory=1},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_snow_footstep", gain=0.25},
			dug = {name="default_snow_footstep", gain=0.75},
		}),
		on_construct = function( pos )
			return moresnow.on_construct_snow( pos, 'moresnow:snow_'..node_name );
		end,
	})


	if( moresnow.enable_autumnleaves ) then
	   minetest.register_node( 'moresnow:autumnleaves_'..node_name, {
		description = "fallen leaves",
		tiles = {"moresnow_autumnleaves.png"},
		inventory_image = "moresnow_autumnleaves.png",
		wield_image = "moresnow_autumnleaves.png",
		is_ground_content = true,
		paramtype = "light",
		paramtype2 = "facedir",
		buildable_to = true,
		drawtype = "nodebox",
		node_box = {
			-- leveled would not work well in this situation
			type = "fixed",
			fixed = fixed_nodebox,
		},
		drop = "moresnow:autumnleaves",
		groups = {falling_node=1, float=1, not_in_creative_inventory=1, snappy=3, flammable=2, leaves=1, not_in_creative_inventory=1},
		sounds = default.node_sound_leaves_defaults(),
		on_construct = function( pos )
			return moresnow.on_construct_leaves( pos, 'moresnow:autumnleaves_'..node_name );
		end,
	  })
	end

	if( wool_nodebox and moresnow.wool_dyes and minetest.get_modpath( 'wool' )) then
           for _,v in ipairs( moresnow.wool_dyes ) do
		minetest.register_node( "moresnow:wool_"..v.."_"..node_name, {
			description = "layers of wool ("..v..")",
			tiles = {"wool_"..v..".png"},
--			inventory_image = "moresnow_autumnleaves.png",
--			wield_image = "moresnow_autumnleaves.png",
			is_ground_content = true,
			paramtype = "light",
			paramtype2 = "facedir",
			drawtype = "nodebox",
			node_box = {
					type  = "fixed",
					fixed = wool_nodebox,
			},
			drop =  "moresnow:wool_"..v, 
			groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1, float=1, not_in_creative_inventory=1}, 
			sounds = default.node_sound_defaults(),

			on_construct = function( pos )
				return moresnow.on_construct_wool( pos, "moresnow:wool_"..v.."_"..node_name, v );
			end,
		});
	   end
        end
end

-- define the leaves
if( moresnow.enable_autumnleaves ) then
	minetest.register_node( "moresnow:autumnleaves", {
		description = "fallen leaves",
		tiles = {"moresnow_autumnleaves.png"},
		inventory_image = "moresnow_autumnleaves.png",
		wield_image = "moresnow_autumnleaves.png",
		is_ground_content = true,
		paramtype = "light",
--		drawtype = "allfaces_optional",
		waving = 1,
		buildable_to = true,
		leveled = 7, -- can pile up as well
		drawtype = "nodebox",
		node_box = {
				type = "leveled",
				fixed = {
						{-0.5, -0.5, -0.5,  0.5, -0.5+2/16, 0.5},
				},
		},

		groups = {falling_node=1, float=1, snappy=3, flammable=2, leaves=1},
		sounds = default.node_sound_leaves_defaults(),
		on_construct = function( pos )
			return moresnow.on_construct_leaves( pos, 'moresnow:autumnleaves' );
		end,
	})

	-- craft one leaves block into 9 layers
	minetest.register_craft({
			output = 'moresnow:autumnleaves 9',
			recipe = { {'default:leaves'}
		}});
	-- there is no inverse craft receipe for them as leaves are not particulary rare
end

if( moresnow.wool_dyes and minetest.get_modpath( 'wool' )) then
        for _,v in ipairs( moresnow.wool_dyes ) do
                table.insert( moresnow.nodetypes, 'wool_'..v );
		minetest.register_node( "moresnow:wool_"..v, {
			description = "layers of wool ("..v..")",
			tiles = {"wool_"..v..".png"},
			is_ground_content = true,
			paramtype = "light",
			leveled = 7, -- can pile up as well
			drawtype = "nodebox",
			node_box = {
					type = "leveled",
					fixed = {
							{-0.5, -0.5, -0.5,  0.5, -0.5+2/16, 0.5},
					},
			},
	
			groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1, float=1},
			sounds = default.node_sound_defaults(),

			on_construct = function( pos )
				return moresnow.on_construct_wool( pos, 'moresnow:wool_'..v, v );
			end,
		});

		-- craft one wool block into 9 layers
		minetest.register_craft({
			output = 'moresnow:wool_'..v..' 9',
			recipe = { {'wool:'..v}
			}});

		-- craft the wool layers back to a full wool block
		minetest.register_craft({
			output = 'wool:'..v,
			recipe = {
				{ 'moresnow:wool_'..v, 'moresnow:wool_'..v, 'moresnow:wool_'..v },
				{ 'moresnow:wool_'..v, 'moresnow:wool_'..v, 'moresnow:wool_'..v },
				{ 'moresnow:wool_'..v, 'moresnow:wool_'..v, 'moresnow:wool_'..v },
			}});
        end
end


-- now that on_construct has been defined, we can start creating the actual nodes
minetest.registered_nodes[ 'default:snow' ].on_construct = function( pos )
			return moresnow.on_construct_snow( pos, 'default:snow' );
		end

-- the nodebox for this snow node lies one node DEEPER than the node the snow is in;
-- thus, nodebox-like nodes covered by snow may look less strange
moresnow.register_snow_top( "top", {{-0.5, -1.5, -0.5,  0.5, -1.5+2/16, 0.5}}, 
                                   {{-0.5, -1.5, -0.5,  0.5, -1.5+2/16, 0.5}} ); -- same for wool 
moresnow.register_snow_top( "fence_top", {{-0.5, -1.5, -0.5,  0.5, -1.5+2/16, 0.5},
                                          {-0.12, -0.5, -0.12,  0.12, -0.5+2/16, 0.12}}, -- on top of the fence post 
                                         {{-0.5, -1.5, -0.5,  0.5, -1.5+2/16, 0.5}} ); -- same for wool 
moresnow.register_snow_top( "stair_top", {
				{-0.5,      -1.0,      -0.5,       0.5, -1.0+2/16,  0},
				{-0.5,      -0.5,       0,         0.5, -0.5+2/16,  0.5},
				{-0.5,      -1.0+2/16,    0-1/32,  0.5, -0.5,       0  },
				{-0.5,      -1.5,      -0.5-1/32,  0.5, -1.0,      -0.5},
		},{ -- the wool version does not have the wool covering the legs
				{-0.5,      -1.0,      -0.5,       0.5, -1.0+2/16,  0},
				{-0.5,      -0.5,       0,         0.5, -0.5+2/16,  0.5},
				{-0.5,      -1.0+2/16,    0-1/32,  0.5, -0.5,       0  },
		});
moresnow.register_snow_top( "slab_top", { {-0.5, -1.0, -0.5, 0.5, -1.0+2/16, 0.5}}, 
                                        { {-0.5, -1.0, -0.5, 0.5, -1.0+2/16, 0.5}}); -- same for wool

-- these shapes exist in moreblocks only
if( minetest.get_modpath( 'moreblocks' )) then
	moresnow.register_snow_top( "panel_top", {
				{-0.5,      -1.5,      -0.5,       0.5, -1.5+2/16,  0},
				{-0.5,      -1.0,       0,         0.5, -1.0+2/16,  0.5},
				{-0.5,      -1.5+2/16,    0-1/32,  0.5, -1.0,       0  },
		},{ -- the wool version does not have the wool covering the legs
				{-0.5,      -1.0,       0,         0.5, -1.0+2/16,  0.5},
		});
	moresnow.register_snow_top( "micro_top", {
			        {-0.5, -1.5, -0.5,   0, -1.5+2/16, 0  },
			        {-0.5, -1.0,    0,   0, -1.0+2/16, 0.5},
			        {   0, -1.5, -0.5, 0.5, -1.5+2/16, 0.5},

				{-0.5,      -1.5+2/16,    0-1/32,  0,   -1.0,       0  },
				{0,         -1.5+2/16,    0,    0+1/32, -1.0,       0.5},
		},{ -- the wool version does not have the wool covering the legs
				{-0.5,      -1.0,       0,           0, -1.0+2/16,  0.5},
		});
	moresnow.register_snow_top( "outer_stair_top", {
			        {-0.5, -1.0, -0.5,   0, -1.0+2/16, 0  },
			        {-0.5, -0.5,    0,   0, -0.5+2/16, 0.5},
			        {   0, -1.0, -0.5, 0.5, -1.0+2/16, 0.5},

				{-0.5,      -1.0+2/16,    0-1/32,  0,   -0.5,       0  },
				{-0.5,      -1.5,      -0.5-1/32,  0.5, -1.0,      -0.5},

				{0,         -1.0+2/16,    0,    0+1/32, -0.5,       0.5},
				{0.5,       -1.5,      -0.5,  0.5+1/32, -1.0,       0.5},
		}, { -- the wool version does not cover the lower legs
			        {-0.5, -1.0, -0.5,   0, -1.0+2/16, 0  },
			        {-0.5, -0.5,    0,   0, -0.5+2/16, 0.5},
			        {   0, -1.0, -0.5, 0.5, -1.0+2/16, 0.5},

				{-0.5,      -1.0+2/16,    0-1/32,  0,   -0.5,       0  },
				{0,         -1.0+2/16,    0,    0+1/32, -0.5,       0.5},
		});
	moresnow.register_snow_top( "inner_stair_top", {
			        {   0, -1.0, -0.5, 0.5, -1.0+2/16, 0  },

			        {   0, -0.5,    0, 0.5, -0.5+2/16, 0.5},
			        {-0.5, -0.5, -0.5, 0,   -0.5+2/16, 0.5},

				{   0,      -1.0+2/16,  0-1/32, 0.5,    -0.5,       0 },
				{   0,      -1.0+2/16, -0.5,    0+1/32, -0.5,        0},
		}, { -- the wool version does not cover the lower legs
			        {   0, -1.0, -0.5, 0.5, -1.0+2/16, 0  },

			        {   0, -0.5,    0, 0.5, -0.5+2/16, 0.5},
			        {-0.5, -0.5, -0.5, 0,   -0.5+2/16, 0.5},

				{   0,      -1.0+2/16,  0-1/32, 0.5,    -0.5,       0 },
				{   0,      -1.0+2/16, -0.5,    0+1/32, -0.5,        0},
		});
end


moresnow.register_shape = function( shape, new_name )
	
	local detail = 16;

	local slopeboxedge = {};
	for i = 0, detail-1 do

		if(     shape==1 ) then -- slope; normal roof shingles
			slopeboxedge[i+1]={                      -0.5,  (i/detail)-1.5+(1.25/detail),            (i/detail)-0.5,
			                                          0.5,  (i/detail)-1.5+(1.25/detail)+(1/detail), (i/detail)-0.5+(1/detail)};

		elseif( shape==2 ) then -- outer corner
			slopeboxedge[i+1]={                      -0.5,  (i/detail)-1.5+(1.25/detail),            (i/detail)-0.5,
			                               0.5-(i/detail),  (i/detail)-1.5+(1.25/detail)+(1/detail), (i/detail)-0.5+(1/detail)};

			slopeboxedge[i+detail*1]={     0.5-(i/detail),  (i/detail)-1.5+(1.25/detail)-(1/detail), 0.5,
			                    0.5-(i/detail)+(1/detail),  (i/detail)-1.5+(1.25/detail),            -0.5+(i/detail)           };


		elseif( shape==3 ) then -- inner corner
			local v = detail-i;
			slopeboxedge[i+1]={            (i/detail)-0.5,  (v/detail)-1.5+(1.25/detail)-(1/detail), -0.5+(1/detail-(1/detail)), 
			                    (i/detail)-0.5+(1/detail),  (v/detail)-1.5+(1.25/detail),            0.5-(i/detail)            };

			slopeboxedge[i+detail*1]={                0.5,  (v/detail)-1.5+(1.25/detail),            0.5-(i/detail),
			                              -0.5+(i/detail),  (v/detail)-1.5+(1.25/detail)+(1/detail), 0.5-(i/detail)+(1/detail) };
		end
        end

	moresnow.register_snow_top( new_name, slopeboxedge, nil ); -- no wool version for these
end

-- only add these if either technic (with its cnc machine) or homedecor (with shingles) are installed
if(    minetest.get_modpath( 'homedecor' )
    or minetest.get_modpath( 'technic' )) then
	moresnow.register_shape( 1, 'ramp_top' );
	moresnow.register_shape( 2, 'ramp_outer_top');
	moresnow.register_shape( 3, 'ramp_inner_top');
end


minetest.register_node( 'moresnow:autumnleaves_tree', {
	description = "autumn leaves",
	tiles = {"moresnow_autumnleaves.png"},
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
        sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node( 'moresnow:winterleaves_tree', {
	description = "winter leaves",
	tiles = {"moresnow_winterleaves.png"},
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
        sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("moresnow:snow_soil", {
	description = "Snow on soil",
	tiles = {"default_snow.png^farming_soil_wet.png"},
	is_ground_content = true,
	paramtype = "light",
	buildable_to = true,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5,  0.5, -0.5+2/16, 0.5},
		},
	},
	groups = {crumbly=3,falling_node=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.25},
		dug = {name="default_snow_footstep", gain=0.75},
	}),

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "default:dirt_with_grass" then
			minetest.set_node(pos, {name="default:dirt_with_snow"})
		end
	end,
})

