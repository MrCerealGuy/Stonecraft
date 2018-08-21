   _____                       __  __           _
  / ____|                     |  \/  |         | |
 | (___  _ __   _____      __ | \  / | ___   __| |
  \___ \| '_ \ / _ \ \ /\ / / | |\/| |/ _ \ / _` |
  ____) | | | | (_) \ V  V /  | |  | | (_) | (_| |
 |_____/|_| |_|\___/ \_/\_/   |_|  |_|\___/ \__,_|

					Version 4.0

By Splizard, HybridDog and LazyJ.

Minetest version:  0.4.16+
Depends: default
License:  GPL v3

Complimentary Mods:
---------------------
*	"More Blocks" by Calinou (2014_05_11 or newer)
*	"Skins" by Zeg9

Install:

Forum post: http://minetest.net/forum/viewtopic.php?id=2290
Github: https://github.com/Splizard/minetest-mod-snow
Website: http://splizard.com/minetest/mods/snow/

INSTALL:
----------
Place this folder in your minetest mods folder.
(http://dev.minetest.net/Installing_Mods)

	* After downloading, unzip the file.
	* Rename the directory "minetest-mod-snow-master" to "snow"
	* Copy the "snow" directory into either
	../minetest/worlds/yourworld'sname/worldmods/
	or
	../minetest/mods/
	* If you put "snow" in the ../minetest/mods/ directory, either
	enable the mod from within Minetest's "Configure" button
	(main menu, bottom right) or by adding this line to the
	world's "world.mt" file:
	load_mod_snow = true

USAGE:
-------
Snow can be picked up and thrown as snowballs or stacked into snow blocks.
Snow and ice melts when near warm blocks such as torches or igniters such as lava.
Snow blocks freeze water source blocks around them.
Moss can be found in the snow, when moss is placed near cobble it spreads.
Christmas trees can be found when digging pine needles.
Sleds allow for faster travel on snow.

CRAFTING:
-----------
Snow Brick:

Snow Block    Snow Block
Snow Block    Snow Block

Sled:
				Stick
Wood	Wood	Wood

Icy Snow:

Snow	Ice
Ice		Snow

Config file:
------------
You can change various settings from the advanced settings in Minetest.


	* Go to the settings tab.
	* Click on Advanced Settings.
	* Click on Mods.
	* Click on snow.
	* Change stuff!

UNINSTALL:
------------
Simply delete the folder snow from the mods folder.


TODO:
— test if the fixed ground_y search works correctly at chunkcorners at ground level
