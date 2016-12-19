
Compatibility mod for importing MC schematics.
For more information and discussion, please consult
	https://forum.minetest.net/viewtopic.php?f=9&t=12847

To be used with
	https://github.com/Sokomine/handle_schematics/
for actually placing the schematics in a Minetest world.

In order to get the walls working, use
	https://github.com/Sokomine/xconnected/

Documentation and discussion about xconnected takes place here:
	https://forum.minetest.net/viewtopic.php?f=9&t=12882

Copy the textures from your favorite MC texturepack into the
textures/ folder of this mod. Those textures are NOT included!

In order to get diffrent grass and foilage colors, change
the values for SHADE_GRASS and/or SHADE_FOILAGE at the top of
the file blocklist.lua

If you want to use this in combination with another converter:

	mccompat.findMC2MTConversion(
		blockid, blockdata,
		blockid2, blockdata2)

does the actual translation. The function will usually return

	{ new_node_name, new_node_param2 }

In some cases (doors, double plants), it will return

	{ nil, nil,  y_offset }

This means that the node type and facedir cannot be decided
without further information - namely, blockid2 and blockdata2,
which describe the node at y+y_offset (usually 1 below).


Missing:
* torches are only created in one form
* pistons, piston heads etc. may not look correctly
* water behaves diffrently in MT - beware of spills!
* banners and signs seem to be popular; they ought to be added

Features:
* creates compatibility nodes for many MC nodes
* beds are placed correctly
* doors are placed correctly
* double plants are handled (sunflowers only to a degree)
* trapdoors, walls and a lot of other nodes are handled

License: GPLv3
