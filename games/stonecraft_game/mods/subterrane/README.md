# subterrane

This mod was based off of Caverealms by HeroOfTheWinds, which was in turn based off of Subterrain by Paramat.

It is intended as a utility mod for other mods to use when creating a more interesting underground experience in Minetest, primarily through the creation of enormous underground "natural" caverns with biome-based features. Installing this mod by itself will not do anything.

The API has the following methods:

# Cavern registration 

## subterrane:register_cave_layer(cave_layer_def)

cave_layer_def is a table of the form:

```
{
	minimum_depth = -- required, the highest elevation this cave layer will be generated in.
	maximum_depth = -- required, the lowest elevation this cave layer will be generated in.
	cave_threshold = -- optional, Cave threshold. Defaults to 0.5. 1 = small rare caves, 0.5 = 1/3rd ground volume, 0 = 1/2 ground volume
	boundary_blend_range = -- optional, range near ymin and ymax over which caves diminish to nothing. Defaults to 128.
	perlin_cave = -- optional, a 3D perlin noise definition table to define the shape of the caves
	perlin_wave = -- optional, a 3D perlin noise definition table that's averaged with the cave noise to add floor strata (squash its spread on the y axis relative to perlin_cave to accomplish this)
	columns = -- optional, a column_def table for producing truly enormous stalactite and stalagmite formations that often fuse into columnar features
}
```

The column_def table is of the form:

```
{
	max_column_radius = -- Maximum radius for individual columns, defaults to 10
	min_column_radius = -- Minimum radius for individual columns, defaults to 2 (going lower can increase the likelihood of "intermittent" columns with floating sections)
	node = -- node name to build columns out of. Defaults to default:stone
	weight = -- a floating point value (usually in the range of 0.5-1) to modify how strongly the column is affected by the surrounding cave. Lower values create a more variable, tapered stalactite/stalagmite combination whereas a value of 1 produces a roughly cylindrical column. Defaults to 0.5
	maximum_count = -- The maximum number of columns placed in any given column region (each region being a square 4 times the length and width of a map chunk). Defaults to 100
	minimum_count = -- The minimum number of columns placed in a column region. The actual number placed will be randomly selected between this range. Defaults to 25.
}
```


This causes large caverns to be hollowed out during map generation. By default these caverns are just featureless cavities, but you can add extra subterrane-specific properties to biomes and the mapgen code will use them to add features of your choice. Subterrane's biome properties are:

- biome._subterrane_mitigate_lava  -- If this is set to a non-false value, subterrane will try to turn all lava within about 10-20 nodes of the cavern into obsidian. This attempts to prevent lava from spilling into the cavern when the player visits, though it is by no means a perfect solution since it cannot account for non-subterrane-generated caves allowing lava to pour in.
- biome._subterrane_fill_node -- The nodeid that subterrane will fill the excavated cavern with. You could use this to create enormous underground oceans or lava pockets. If not provided, will default to "air"
- biome._subterrane_cave_fill_node -- If this is set to a nodeid, subterrane will use that to replace the air in existing default caves.
- biome._subterrane_ceiling_decor = function (area, data, ai, vi, bi, data_param2)
- biome._subterrane_floor_decor = function (area, data, ai, vi, bi, data_param2)
- biome._subterrane_override_sea_level = -- Optional, the Y coordinate where an underground sea level begins. Biomes' y coordinate cutoffs are unreliable underground, this forces subterrane to take this sea level cutoff into account.
- biome._subterrane_override_under_sea_biome = -- When below the override_sea_level, the biome with this name will be looked up and substituted.
- biome._subterrane_column_node = -- overrides the node type of a cavern layer's column_def, if there are columns here. This can be useful for example to substitute wet flowstone in humid biomes, or obsidian in volcanic biomes.

If defined, these functions will be executed once for each floor or ceiling node in the excavated cavern. "area" is the mapgen voxelarea, data and data_param2 are the voxelmanip's data arrays, "ai" is the index of the node "above" the current node, "vi" is the index of the current node, and "bi" is the index of the node "below" the current node.

The node pointed to by index vi will always start out filled with the cavern's fill node (air by default).

- biome._subterrane_cave_ceiling_decor = function(area, data, ai, vi, bi, data_param2)
- biome._subterrane_cave_floor_decor = function(area, data, ai, vi, bi, data_param2)

These are basically the same as the previous two methods, but these get executed for pre-existing tunnels instead of the caverns excavated by subterrane.

## subterrane:register_cave_decor(minimum_depth, maximum_depth) 

Use this method when you want the following biome methods to be applied to pre-existing caves within a range of y values but don't want to excavate giant caverns there:

- biome._subterrane_cave_fill_node -- If this is set to a nodeid, subterrane will use that to replace the air in existing default caves.
- biome._subterrane_cave_ceiling_decor = function(area, data, ai, vi, bi, data_param2)
- biome._subterrane_cave_floor_decor = function(area, data, ai, vi, bi, data_param2)

It's essentially a trimmed-down version of register_cave_layer.

# Utilities

## subterrane:vertically_consistent_random(vi, area)

Takes a voxelmanip index and the corresponding area object, and returns a pseudorandom float from 0-1 based on the x and z coordinates of the index's location.

This is mainly intended for use when placing stalactites and stalagmites, since in a natural cavern these two features are almost always paired with each other spatially. If you use the following test in both the floor and ceiling decoration methods:

```
if subterrane:vertically_consistent_random(vi, area) > 0.05 then
	--stuff
end
```

then you'll get a random distribution that's identical on the floor and ceiling.

## subterrane:override_biome(biome_def)

Unfortunately there's no easy way to override a single biome, so this method does it by clearing and re-registering all existing biomes.
Not only that, but the decorations also need to be wiped and re-registered - it appears they keep track of the biome they belong to via an internal ID that gets changed when the biomes are re-registered, resulting in them being left assigned to the wrong biomes.

This method is provided in subterrane because the default mod includes and "underground" biome that covers everything below -113 and would be annoying to work around. Any mod using subterrane in conjunction with the default mod should probably override the "underground" biome.

# Common cavern features


## subterrane.register_stalagmite_nodes(base_name, base_node_def, drop_base_name)

This registers a set of four standardized stalactite/stalagmite nodes that can be used with the subterrane:stalagmite function below. "base name" is a string that forms the prefix of the names of the nodes defined, for example the coolcaves mod might use "coolcaves:crystal_stal" and the resulting nodes registered would be "coolcaves:crystal_stal_1" through "coolcaves:crystal_stal_4". "base_node_def" is a node definition table much like is used with the usual node registration function. register_stalagmite_nodes will amend or substitute properties in this definition as needed, so the simplest base_node_def might just define the textures used. "drop_base_name" is an optional string that will substitute the node drops with stalagmites created by another use of register_stalagmite_nodes, for example if you wrote

```
	subterrane.register_stalagmite_nodes("coolcaves:dry_stal", base_dry_node_def)
	subterrane.register_stalagmite_nodes("coolcaves:wet_stal", base_wet_node_def, "coolcaves:dry_stal")
```

then when the player mines a dry stalactite they'll get a dry stalactite node and if they mine a wet stalactite they'll get a corresponding dry stalactite node as the drop instead.

This method returns a table consisting of the content IDs for the four stalactite nodes, which can be used directly in the following method:

## subterrane:stalagmite(vi, area, data, param2_data, param2, height, stalagmite_id)

This method can be used to create a small stalactite or stalagmite, generally no more than 5 nodes tall. Use a negative height to generate a stalactite. The parameter stalagmite_id is a table of four content IDs for the stalagmite nodes, in order from thinnest ("_1") to thickest ("_4"). The register_stalagmite_nodes method returns a table that can be used for this directly.

## subterrane:giant_stalagmite(vi, area, data, min_height, max_height, base_material, root_material, shaft_material)

Generates a very large multi-node stalagmite three nodes in diameter (with a five-node-diameter "root").

## subterrane:giant_stalactite(vi, area, data, min_height, max_height, base_material, root_material, shaft_material)

Similar to above, but generates a stalactite instead.

## subterrane:giant_shroom(vi, area, data, stem_material, cap_material, gill_material, stem_height, cap_radius)

Generates an enormous mushroom. Cap radius works well in the range of around 2-6, larger or smaller than that may look odd.

# Player spawn

## subterrane:register_cave_spawn(cave_layer_def, start_depth)

When the player spawns (or respawns due to death), this method will tell Minetest to attempt to locate a subterrane-generated cavern to place the player in. cave_layer_def is the same format as the cave definition above. Start_depth is the depth at which the game will start searching for a location to place the player. If the game doesn't find a location immediately it may wind up restarting the search for a spawn location at the top of the cave definition, so start_depth is not a guarantee that the player will start at least that deep; he could spawn anywhere within the cave layer's depth range.