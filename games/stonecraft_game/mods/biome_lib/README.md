# Biome Lib

This library's purpose is to allow other mods to add growing things to the map in a straightforward, simple manner. It contains all the core functions needed by mods and modpacks such as More Trees, Tiny Trees, Plantlife, and others. 

Spawning of plants is optionally sensitive to the amount of available light, elevation, nearness to other nodes, plant-to-plant density, water depth, and a whole host of controls. 

All objects spawned or generated using this mod use Perlin noise to stay within simple biomes, rather than just letting everything just spread around the map randomly. 

This library also features a basic temperature map, which should blend in nicely with SPlizard's Snow Biomes mod (the same Perlin settings are used, with the assumption that the edge of a snow biome is 0° Centigrade). 

Both mapgen-based spawning and ABM-based spawning is supported. Growing code is strictly ABM-based. L-system trees can be spawned at mapgen time via the engine's spawn_tree() function and are quite fast.

It is primarily intended for mapgen v6, but it should work fine when used with mapgen v7.

**Dependencies:** nothing, but if you don't use `minetest_game`, you'll need to supply some settings (see API.txt).

**Recommends**: [Plantlife Modpack](https://github.com/mt-mods/plantlife_modpack), 
[More Trees](https://github.com/mt-mods/moretrees)

**API**: This mod supplies a small number of very powerful functions. They are, briefly:

* biome_lib:register_generate_plant()
* biome_lib:spawn_on_surfaces()
* biome_lib:grow_plants()
* biome_lib:find_valid_wall()
* biome_lib:is_node_loaded()

For a complete description of these functions as well as several of the internal variables within the mod, see `API.txt`.

**Configuration:** This mod has several variables you can set in your `minetest.conf` to change things a bit, from the default nodes it uses, to the debug log level and the block queue behavior.  For a list with complete descriptions, see `settingtypes.txt`.
