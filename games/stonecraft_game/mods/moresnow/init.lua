
moresnow = {}

--------------------------------------------------------------------------------
-- Configuration
--------------------------------------------------------------------------------
-- if set to true, fallen autum leaves will be supported just like snow
-- The txture and idea for them came from LazyJ.
moresnow.enable_autumnleaves = true
-- wool is useful for covering stairs; turns them into benches;
-- no need to define so many - we use multicolor now for new worlds:
moresnow.wool_dyes           = {}
moresnow.enable_wool_cover   = true
-- change this if you want the wool functionality only for a few nodes (i.e. only white - or none at all)
moresnow.enable_legacy_wool  = false
-- the snow cannon allows to create snow
moresnow.enable_snow_cannon  = true
-- with this set, the snow cannon can *shoot* snowballs - which will fly a long way;
-- on servers, set this to false
moresnow.crazy_mode          = true 
-- end of configuration
--------------------------------------------------------------------------------

-- those are many nodes. enable_legacy_wool only on old servers where players have built with these
-- nodes. All others are better off with just enable_wool_cover:
if(moresnow.enable_legacy_wool) then
	moresnow.wool_dyes =  {"white", "grey", "black", "red", "yellow", "green", "cyan", "blue",
                               "magenta", "orange", "violet", "brown", "pink", "dark_grey", "dark_green"}
end
-- one colored wool layer that comes in 64 colors (uses color4dir):
if(moresnow.enable_wool_cover) then
	table.insert(moresnow.wool_dyes, "multicolor")
end

-- which shapes can we cover?
moresnow.shapes = {'top', 'fence', 'stair', 'slab',
			'panel', 'micro', 'outer_stair', 'inner_stair',
			'ramp', 'ramp_outer', 'ramp_inner', 'ramp_half', 'ramp_half_raised',
			'ramp_inner_half', 'ramp_inner_half_raised',
			'ramp_outer_half', 'ramp_outer_half_raised'}

-- which snow node equivals which leaves node?
moresnow.nodetypes = {'snow','autumnleaves'}

-- adjustment for an annoying breaking change in the lua api
moresnow.get_cid = function(node_name)
	if(not(node_name)
	  or (not(minetest.registered_nodes[node_name]) and not(minetest.registered_aliases[node_name]))) then
		return nil
	end
	return minetest.get_content_id(node_name)
end

local modpath = minetest.get_modpath("moresnow")..DIR_DELIM

-- defines the on_construct function for falling/placed snow(balls)
dofile(modpath..'snow_on_construct.lua');
-- devines the 8 types of snow covers: general nodebox snow cover, stairs, slabs,
-- outer edge stair, inner edge stair, 3x homedecor shingles/technic cnc shapes
dofile(modpath..'snow_cover_nodes.lua');
moresnow.build_translation_table();

-- some defines which fascilitate identification of nodes
moresnow.c_ignore           = moresnow.get_cid( 'ignore' );
moresnow.c_air              = moresnow.get_cid( 'air' );
moresnow.c_snow             = moresnow.get_cid( 'default:snow' );
-- create some suitable aliases
for _, v in ipairs(moresnow.shapes) do
	local suffix = '_top'
	if(v == 'top') then
		suffix = ''
	end
	moresnow['c_snow_'..v] = moresnow.get_cid('moresnow:snow_'..v..suffix)
end


-- takes a look at all defined nodes after startup and stores which shape they are;
-- this is important for finding the right snow cover to put on the shape below
dofile(modpath..'snow_analyze_shapes.lua');
-- a snow cannon that shoots snow around
if( moresnow.enable_snow_cannon ) then
	dofile(modpath..'snow_cannon.lua');
end

-- crafting
dofile(modpath..'crafts.lua')


-- make sure default:snow does not crush plants
minetest.registered_nodes["default:snow"].groups.soft_falling = 1

dofile(modpath..'soft_falling.lua')

--[[
-- remove the "attached_node" value from farming plants;
-- uncomment this if you dislike plants being replaced with nodes placed on top of them
for node_name, def in pairs(minetest.registered_nodes) do
	if(def and def.groups and def.groups.plant and def.groups.plant > 0) then
		minetest.registered_nodes[node_name].buildable_to = nil
	end
end
--]]
