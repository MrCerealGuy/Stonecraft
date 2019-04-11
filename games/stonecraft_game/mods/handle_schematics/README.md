
This mod is not entirely finished, but may already be very useful.

Type "/giveme handle_schematics:build" to get a build chest.
Place the chest in the world and click through the menue.

The examples/ folder contains some very small saved buildings which
allow you to just spawn them and play with the options even if you
don't have one of your own houses at hand. The example files do
not require much disk space. They are very small.

NOTE: In order to be able to spawn a schematic, you need to copy
the schematic file to your <WORLDNAME>/schems/ folder. With security
enabled in your minetest.conf (in general a very good idea!), mods
cannot even read files from anything that is not stored inside your
world folder or one of its subfolders.

Supported schematic types:
	*.mts		Minetest schematic
	*.we		WorldEdit savefile format
	*.schematic	Used in the Minecraft world

Optional: You can also create a file named
	list_of_schematics.txt
in the folder containing this mod (not the world!).
Each line of the file ought to contain the name and full path to a schematic.
Those will be offered to you in the build chest's menu under "main".
The advantage of this method is low as with security enabled, files can only
be read from the <WORLDNAME>/ folder. You can ignore this option for now.

Author:  Sokomine
License: GPLv3.0
Media:   CC BY-SA 3.0
Last update: 24.03.2019

Textures:
grundriss.png Background texture: default_wood.png by BlockMen (CC BY-SA 3.0);
              Foreground texture: Created by building a floor plan and using this mod (Sokomine);
              Composition of images: NathanS
handle_schematics_support.png Sokomine
