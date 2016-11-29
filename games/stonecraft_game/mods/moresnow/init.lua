
moresnow = {}

--------------------------------------------------------------------------------
-- Configuration
--------------------------------------------------------------------------------
-- if set to true, fallen autum leaves will be supported just like snow
-- The txture and idea for them came from LazyJ.
moresnow.enable_autumnleaves = true
-- wool is useful for covering stairs; turns them into benches;
-- change this if you want the wool functionality only for a few nodes (i.e. only white - or none at all)
moresnow.wool_dyes           =  {"white", "grey", "black", "red", "yellow", "green", "cyan", "blue",
                                "magenta", "orange", "violet", "brown", "pink", "dark_grey", "dark_green"};
-- the snow cannon allows to create snow
moresnow.enable_snow_cannon  = true
-- with this set, the snow cannon can *shoot* snowballs - which will fly a long way;
-- on servers, set this to false
moresnow.crazy_mode          = true 
-- end of configuration
--------------------------------------------------------------------------------

-- defines the on_construct function for falling/placed snow(balls)
dofile(minetest.get_modpath("moresnow")..'/snow_on_construct.lua');
-- which snow node equivals which leaves node?
moresnow.nodetypes = {'snow','autumnleaves'};
-- devines the 8 types of snow covers: general nodebox snow cover, stairs, slabs,
-- outer edge stair, inner edge stair, 3x homedecor shingles/technic cnc shapes
dofile(minetest.get_modpath("moresnow")..'/snow_cover_nodes.lua');
moresnow.build_translation_table();

-- some defines which fascilitate identification of nodes
moresnow.c_ignore           = minetest.get_content_id( 'ignore' );
moresnow.c_air              = minetest.get_content_id( 'air' );
moresnow.c_snow             = minetest.get_content_id( 'default:snow' );
moresnow.c_snow_top         = minetest.get_content_id( 'moresnow:snow_top' );
moresnow.c_snow_fence       = minetest.get_content_id( 'moresnow:snow_fence_top' );
moresnow.c_snow_stair       = minetest.get_content_id( 'moresnow:snow_stair_top' );
moresnow.c_snow_slab        = minetest.get_content_id( 'moresnow:snow_slab_top' );
moresnow.c_snow_panel       = minetest.get_content_id( 'moresnow:snow_panel_top' );
moresnow.c_snow_micro       = minetest.get_content_id( 'moresnow:snow_micro_top' );
moresnow.c_snow_outer_stair = minetest.get_content_id( 'moresnow:snow_outer_stair_top' );
moresnow.c_snow_inner_stair = minetest.get_content_id( 'moresnow:snow_inner_stair_top' );
moresnow.c_snow_ramp_top    = minetest.get_content_id( 'moresnow:snow_ramp_top' );
moresnow.c_snow_ramp_outer  = minetest.get_content_id( 'moresnow:snow_ramp_outer_top' );
moresnow.c_snow_ramp_inner  = minetest.get_content_id( 'moresnow:snow_ramp_inner_top' );

-- takes a look at all defined nodes after startup and stores which shape they are;
-- this is important for finding the right snow cover to put on the shape below
dofile(minetest.get_modpath("moresnow")..'/snow_analyze_shapes.lua');
-- a snow cannon that shoots snow around
if( moresnow.enable_snow_cannon ) then
	dofile(minetest.get_modpath("moresnow")..'/snow_cannon.lua');
end

