
-- a place to store our functions
mob_world_interaction = {};

local modpath = minetest.get_modpath( minetest.get_current_modname());

-- misc functions like set_animation(..)
dofile( modpath.."/mob_misc.lua")

-- allow mobs to operate doors, gates and trapdoors
-- requires a pathfinding algorithm which is aware of that
dofile( modpath.."/mob_door_handling.lua")

-- there may not be enough room to stand on beds, benches etc; thus: find
-- a place next to it where the mob can stand
dofile( modpath.."/mob_standing.lua")

-- sleep on a bed
dofile( modpath.."/mob_sleeping.lua");

-- pathfinder from burli; it is able to find paths through doors etc.
dofile( modpath.."/pathfinder.lua");

-- populate the mob_world_interaction.door_type table
-- other mods can add to the table if they have further door-like nodes
mob_world_interaction.initialize_door_types();

-- default:snow may often pose a considerable obstacle. It is a lot easier (and not at all
-- unrealistic) if the mob can walk through it. Snow is soft after all
-- -> allow mobs to walk through snow (not snowblocks; just normal snow)
minetest.override_item("default:snow", {walkable=false});
