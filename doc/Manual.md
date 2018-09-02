% Stonecraft Wiki
% Andreas Zahnleiter
% September 2, 2018

# Welcome to Stonecraft

Copyright © 2016-2018 Andreas "MrCerealGuy" Zahnleiter [mrcerealguy@gmx.de](mailto:mrcerealguy@gmx.de)

Stonecraft is an InfiniMiner/Minecraft inspired game started in 2016 based on the Minetest open-source voxel game engine. It will be kept lightweight enough to run on fairly old hardware.

Stonecraft is open-source and free, released under the GNU General Public License v3.0. Thanks a lot to the Minetest community, to "Notch" the creator of Minecraft and to Linus Torvalds, the creator of the free operating system Linux.

Like in other block sandbox games, you can build and destroy blocks everywhere in a near infinite world. There are two game modes, in survival mode you can loose your life, so you have to fight against many creatures and hunger in a dangerous world with many dungeons and woods of spiders. In creative mode you have access to all blocks, items and tools to build all you can imagine. Choose if you want to play either as singleplayer or multiplayer on servers with your friends. If you like, you can run your own Stonecraft server.

Stonecraft is open-source and free, released under the GNU General Public License v3.0.

**Table of contents**

1. [First steps](#first-steps)
	1. [Creating a world](#creating-a-world)
	2. [Installing additional content](#installing-additional-content)
	3. [Map generator](#map-generator)
	4. [Biomes](#biomes)
	5. [Underground realms](#underground-realms)
		1. [Caverealms](#caverealms)
		2. [Nether](#nether)
		3. [Morlendor](#morlendor)
		4. [Railway corridors](#railway-corridors)
	6. [Basic Controls](#basic-controls)
		1. [Boat](#boat)
	7. [Using blocks/items](#using-blocksitems)
		1. [Taking](#taking)
		2. [Dropping](#dropping)
		3. [Exchanging](#exchanging)
		4. [Throwing away](#throwing-away)
		5. [Automatic transfer](#automatic-transfer)
	7. [Changing your skin](#changing-your-skin)
2. [Crafting](#crafting)
	1. [Crafting grid and output slot](#crafting-grid-and-output-slot)
	2. [Shaped and shapeless recipes](#shaped-and-shapeless-recipes)
	3. [Example recipes](#example-recipes)
		1. [Shapeless recipes](#shapeless-recipes)
		2. [Shaped recipes](#shaped-recipes)
	4. [Smelting](#smelting)
		1. [Fuel](#fuel)
		2. [Recipeshttps](#recipes)
3. [Mobs](#mobs)
	1. [Simple Mobs](#simple-mobs)
	2. [Not So Simple Mobs](#not-so-simple-mobs)
4. [Farming](#farming)
	1. [Saplings](#saplings)
	2. [Plants, Food and Utensils](#plants-food-and-utensils)
5. [Technic](#technic)
	1. [Machines](#machines)
		1. [Machine details](#machine-details)
		2. [Overview](#overview)
		3. [Getting started](#getting-started)
		4. [Consumers](#consumers)
		5. [Generators](#generators)
	2. [Powered machines](#powered-machines)
		1. [Powered machine tiers](#powered-machine-tiers)
		2. [Tubes with powered machines](#tubes-with-powered-machines)
		3. [Battery boxes](#battery-boxes)
		4. [Processing machines](#processing-machines)
		5. [Music player](#music-player)
		6. [CNC machine](#cnc-machine)
		7. [Tool workshop](#tool-workshop)
		8. [Quarry](#quarry)
		9. [Forcefield emitter](#forcefield-emitter)
	3. [Power generators](#power-generators)
		1. [Fuel-fired generators](#fuel-fired-generators)
		2. [Solar generators](#solar-generators)
		3. [Hydro generator](#hydro-generator)
		4. [Geothermal generator](#geothermal-generator)
		5. [Wind generator](#wind-generator)
		6. [Nuclear generator](#nuclear-generator)
		7. [Administrative world anchor](#administrative-world-anchor)
	3. [Other machines](#other-machines)
		1. [Switching station](#switching-station)
		2. [LV/MV/HV Battery Box](#lvmvhv-battery-box)
		3. [Supply Converter](#supply-converter)
	4. [Resources](#resources)
		1. [Ore](#ore)
		2. [Rock](#rock)
		3. [Rubber](#rubber)
		4. [Metal](#metal)
		5. [Iron and its alloys](#iron-and-its-alloys)
		6. [Uranium enrichment](#uranium-enrichment)
		7. [Concrete](#concrete)
		8. [Latex](#latex)
	5. [Industrial processes](#industrial-processes)
		1. [Alloying](#)
		2. [Grinding, extracting, and compressing](#grinding-extracting-and-compressing)
		3. [Centrifuging](#centrifuging)
	6. [Radioactivity](#radioactivity)
	7. [Electrical power](#electrical-power)
	8. [Chests](#chests)
	9. [Tools](#tools)
		1. [Chainsaw](#chainsaw)
		2. [Flashlight](#flashlight)
		3. [Lava can](#lava-can)
		4. [Mining drill](#mining-drill)
		5. [Mining laser](#mining-laser)
		6. [Sonic screwdriver](#sonic-screwdriver)
		7. [Tree tap](#tree-tap)
		8. [Water can](#water-can)
		9. [Wrench](#wrench)
	10. [Digilines](#digilines)
		1. [Switching Station](#switching-station)
		2. [Supply Converter](#supply-converter)
		3. [Battery Boxes](#battery-boxes)
		4. [Forcefield Emitter](#forcefield-emitter)
		5. [Nuclear Reactor Remote Control](#nuclear-reactor-remote-control)
	11. [Reactors](#reactors)
		1. [Nuclear Reactor](#nuclear-reactor)
	12. [Geothermal EU generator](#geothermal-eu-generator)
	13. [Solar array](#solar-array)
	14. [Solar panel](#solar-panel)
	15. [Watermill](#watermill)
6. [Pipeworks](#pipeworks)
	1. [Description](#description)
	2. [Fluid Transport](#fluid-transport)
		1. [Pipes](#pipes)
		2. [Straight-only pipes](#straight-only-pipes)
		3. [Spigots](#spigots)
		4. [Pumps](#pumps)
		5. [Valves](#valves)
		6. [Storage Tanks](#storage-tanks)
		7. [Gratings](#gratings)
		8. [Sealed/Airtight Pipe Entries](#sealedairtight-pipe-entries)
		9. [Flow Sensors](#flow-sensors)
	3. [Item Transport](#item-transport)
		1. [Base materials/items](#base-materialsitems)
		2. [Tubes](#tubes)
		3. [Chests](#chests)
		4. [Furnaces](#furnaces)
		5. [Filters/Injectors](#filtersinjectors)
		6. [Mese Filters/Injectors](#mese-filtersinjectors)
		7. [Mese Sorting Tubes](#mese-sorting-tubes)
		8. [Detector Tubes](#detector-tubes)
		9. [Lua controlled Tubes](#lua-controlled-tubes)
		10. [Accelerator Tubes](#accelerator-tubes)
		11. [Teleporter Tubes](#teleporter-tubes)
		12. [Autocrafters](#autocrafters)
		13. [Deployers](#deployers)
		14. [Node Breakers](#node-breakers)
		15. [Sand Vacuum Tubes](#sand-vacuum-tubes)
		16. [Mese Sand Vacuum Tubes](#mese-sand-vacuum-tubes)
7. [Mesecons](#mesecons)
	1. [Mesecons Basic](#mesecons-basic)
		1. [Wires](#wires)
		2. [Receptors](#receptors)
		3. [Effectors](#effectors)
		4. [Putting it all together](#putting-it-all-together)
8. [Chat](#chat)
	1. [Sending messages](#sending-messages)
9. [Experienced players](#experienced-players)
	1. [Area protection](#area-protection)
	2. [Teleporters](#teleporters)
	3. [Special Controls](#special-controls)
	4. [Server commands](#server-commands)
		1. [Issuing a commands](#issuing-a-command)
		2. [General syntax](#general-syntax)
		3. [Command reference of built-in commands](#command-reference-of-built-in-commands)
	5. [Privileges](#privileges)
		1. [Built-in privileges](#built-in-privileges)
		2. [Privileges from mods](#privileges-from-mods)
		3. [Server configuration](#server-configuration)
	6. [WorldEdit](#worldedit)
		1. [WorldEdit Basics](#worldedit-basics)
		2. [WorldEdit Chat Commands](#worldedit-chat-commands)
	7. [Create and import a schematic file (.mts) with WorldEdit](#create-and-import-a-schematic-file-mts-with-worldedit)
10. [Setting up a server](#setting-up-a-server)
	1. [Running a dedicated server](#running-a-dedicated-server)
		1. [Linux](#linux)
		2. [Windows](#windows)
11. [Modding Stonecraft](#modding-stonecraft)
	1. [Installing mods](#installing-mods)
	2. [Installing texture packs](#installing-texture-packs)
		1. [Server texture pack](#server-texture-pack)
	3. [Profiling mods](#profiling-mods)
12. [Troubleshooting](#troubleshooting)
	1. [Multiplayer/Network issues](#multiplayernetwork-issues)

# First steps

## Creating a world

First, before you can play, you have to create a world. In the world creation dialog you can choose a map generator (default v7) which is responsible for the terrain generation. Then you can add additional biomes and choose other cool stuff.

![](/doc/wiki-images/createworld4.png)

Note: Some settings need huge cpu consumption so it can be laggy for most players.

## Installing additional content

In Stonecraft you can download and install addititonal content like mods or texture packs developed from the Stonecraft/Minetest community.

![](/doc/wiki-images/600px-Mainmenu-Content.png)

In the screenshot below I've installed the mod 'advtrains'. You can rename or uninstall the package if you want.

![](/doc/wiki-images/600px-Mainmenu-Installed-Packages.png)

To enable 'advtrains' you have to select your world, then click the button 'Configure'.

![](/doc/wiki-images/600px-Mainmenu-Enable-Package.png)

Now you can enable 'advtrains' either by double-clicking on it in the list below or by clicking on 'Enable MP'.

Important: On the left side you can see the dependencies for this mod, in this case there are no one. Otherwise you have to ensure that your created world has got the required world options activated like 'Technic', 'Mesecons', 'Pipeworks' and so on.

## Map generator

There are a number of different map generators. It is possible to choose between them when creating a map. Some mods may change them radically, also all map generators allow for a lot of configuration in the advanced settings menu.

**v5**

Generates landscapes based on 3D Perlin noise and is notable for its unique and somewhat strange terrain shape and occasional floating islands. The biomes have to defined by mods first, otherwise it will be a stone-only landscape.

![](/doc/wiki-images/400px-Mapgen_v5.jpg)

**v6**

Generated entirely using 2D Perlin noise and has somewhat more “realistic” terrain than v5. The weirdness of v5 is gone. This map generator has predefined biomes: Grasslands/forest, jungle, desert, taiga, tundra and gravel. The biomes can't be modified by mods. Because of the nature of v6, the biomes are much simpler than in the other map generators, and a couple of blocks found in the other map generators can't be found in v6 maps (for example: Silver Sand, Acacia Tree, Orange Coral)

![](/doc/wiki-images/400px-Mapgen_v6.jpg)

**v7**

Some innovations over v7, uses 2D and 3D Perlin noise. It is the default selection since Minetest 0.4.15. This map generator is notable for many simple broad and deep “rivers” (or “ridges”) at Ocean level, but they can be disabled. Like in v5, the biome have to be defined by mods first

![](/doc/wiki-images/400px-Mapgen_v7.jpg)

**valleys**

Generates a landscape featuring many hills, mountains and valleys. The valleys often contain rivers with River Water. The rivers very different than in v7, since they are not at ocean level and actually flow downhill

![](/doc/wiki-images/400px-Mapgen_valleys.jpg)

**flat**

This generates an (almost) entirely flat world with some biomes like in v7. Caves can still appear underground (if not disabled) and the map generator can be configured to add occasional hills and lakes.

![](/doc/wiki-images/400px-Mapgen_flat.jpg)

**fractal**

Generates a map based on a fractal. It creates by far the weirdest terrain shapes, but its results are mostly predictable. 
It is possible to choose one of many fractals which are based on the Mandelbrot and Julia set, which is chosen in the advanced settings menu (technical setting name “mgfractal_fractal”).

![](/doc/wiki-images/400px-Mapgen_fractals_fractal_1.jpg)

**singlenode**

By default, this produces a world with only air everywhere. To be precise, it produces only one type of block, air by default. 
It is useful for mapgen mods which define their own map generation: first, air is generated, then the mod applies its own functions which generates the terrain.

![](/doc/wiki-images/400px-Mapgen_singlenode.jpg)

**carpathian**

A mapgen featuring a flat base terrain with three types of terrain variation - rolling hills, ridged and step (terraced) mountains. The aim was to create a mapgen with a flat base, somewhere where you can build a village, even a city. But to differentiate it from the flat mapgen, the flat areas are surrounded by hills and various mountain ranges.

Features:

  * Vast plains, average y-level between 5-10
  * Rolling hills - small hills.
  * Ridged mountains - mountains of a similar height will connect with a ridge.
  * Step (terrace) mountains - mountains, sometimes a stair like effect.
  * Fjords - particularly where the larger mountains meet the sea. Rare.
  * Really big mountains - where two or even three mountain noise meet, spectacular and unpredictable peaks form.

![](/doc/wiki-images/400px-Mapgen_Carpathian.jpg)

## Biomes

Biomes are a part of the map generation. Biomes are areas with similar ground and underground and vegetation. The biomes depend on the map generator used. Most map generators have the same biomes, but v6 is different.

### v5, v7, valleys, flat and fractal 

Biomes in these map generators are defined by optional settings in Stonecraft like Ethereal, swamp and cave biomes and so on. If these are not defined, these map generators only generate stone worlds. Biomes in these map generators are not linked to the terrain shape; this means any biome (including grasslands) can form in flat or very mountainous areas. This section shows the biomes used by Stonecraft.

**Grassland**

Grassland has large amounts of Dirt nodes and Dirt with Grass blocks, on which flowers, Grass and bushes may appear naturally in this area. The underground is made of stone.

![](/doc/wiki-images/350px-Minetest_Game_plains_v7.jpg)

**Coniferous forest**

Coniferous forests grow in colder areas and are filled with pine trees. Pine tree forests can also be covered with snow in cold regions.

![](/doc/wiki-images/350px-Pine_forest.jpg)

**Deciduous forest**

Deciduous forests are one of the most common biomes in Stonecraft and form in temperate zones. Trees, apple trees and aspen trees grow here naturally. Generally forests can spawn lakes, ponds, and rivers inside of it. Deciduous forests usually surround plains.

![](/doc/wiki-images/350px-Deciduous_forest_v7.jpg)

**Rainforest**

Rainforests (or jungles) are made of large jungle trees which grow thickly packed together. Jungle Grass and Jungle Trees bearing Jungle Leaves spawn here naturally. On fallen jungle tree logs, brown mushrooms may appear rarely. Jungles near oceans form a swamp with waterlilies.

![](/doc/wiki-images/350px-Minetest_Game_jungle_v7.jpg)
![](/doc/wiki-images/350px-Minetest_Game_jungle_swamp.jpg)

**Savanna**

The savanna is a dry land which is not a desert, it is populated with acacia trees and dry grass. Flat water bordering to savannahs is likely to have waterlilies and papyri.

![](/doc/wiki-images/350px-Savannah.jpg)

**Desert**

Deserts contain large amounts of desert sand and desert stone. Cacti and dry shrubs also spawn here naturally on desert sand. Cacti can form in two different shapes. Deserts form in hot and dry areas.

![](/doc/wiki-images/350px-Minetest_Game_desert.jpg)

**Sandstone desert**

Sandstone deserts are large barren areas covered by sand with sandstone below. They form in temperate and dry climates.

![](/doc/wiki-images/350px-Minetest_Game_sandstone_desert.jpg)

**Cold desert**

Cold deserts are large barren areas covered by large amounts of silver sand on top of stone. They form in cold and dry areas.

![](/doc/wiki-images/350px-Minetest_Game_cold_desert.jpg)

**Snowy grassland**

The snowy grassland biome usually borders grasslands and is completely covered by a thin layer snow on top of dirt with snow. A few snow-covered bushes can be found here.

![](/doc/wiki-images/350px-Snow_biome.jpg)

**Taiga**

Taigas are cold snow-covered biomes with rich vegetation with snow and dirt with snow as surface. They are populated with snow-covered pine trees. In pine tree forests, mushrooms may appear rarely on fallen pine tree logs.

![](/doc/wiki-images/350px-Minetest_Game_taiga.jpg)

**Tundra**

Tundras are barren biomes in very cold climates with no vegetation and a single layer of snow blocks on top of stone. They are usually found between taigas, snowy grass lands and glaciers. This is one of the few biomes where snow blocks (rather than just snow) generates.

![](/doc/wiki-images/350px-Minetest_Game_tundra.jpg)

**Glacier**

Glaciers form only in the coldest regions and are made of large amounts of ice, covered by a thick layer of snow blocks without any vegetation. Glacier biomes can be either mountain-like as in the screenshot or very flat. Glacier biomes generally border ice sheet biomes near oceans.

![](/doc/wiki-images/350px-Glacier.jpg)

**Ice sheet**

Ice sheets form only in te coldest regions on top of oceans and generally border glacier biomes. Ice sheets are very flat and consist of a single layer of snow blocks with up to 10 layers of ice beneath, “floating” above water in deep oceans.

![](/doc/wiki-images/350px-Ice_sheet_v6.jpg)

### v6

The v6 map generator has a predefined set of biomes which can't be changed by mods directly. The outcome in different subgames will generally be very similar. Biomes in v6 also somewhat determine the terrain shape. In general, v6 biomes are a lot simpler than the biomes of the other map generators.

**Plains**

Plains are a quite flat biome. Large amounts of Dirt nodes and Dirt with Grass blocks, on which flowers and Grass may appear naturally (since 0.4.7). There are no bushes. The underground is made of stone.

![](/doc/wiki-images/350px-Large_plains.png)

**Forest**

Forests are one of the most common biomes in v6 and form in temperate zones. Trees and apple trees grow here naturally, but no aspen trees. Forests usually surround plains. There are no fallen tree logs either.

![](/doc/wiki-images/350px-Mapgen_v6_0_4_9.jpg)

**Desert**

Deserts contain large amounts of desert sand and desert stone and often form large cliffs or canyons. Cacti and dry shrubs also spawn here naturally in clusters on desert sand. Deserts spawn underground rivers and lakes which can be over 200 blocks deep. In v6, cacti only form in a “column” shape of up to 4 blocks high.

![](/doc/wiki-images/350px-Desert_at_sunset_0.4.7.png)

**Jungle**

Jungles contains large trees which grow thickly packed together. Jungle Grass and Jungle Trees bearing Jungle Leaves spawn here naturally. Jungles in v6 very similar to the jungles in the other map generators, but there are no fallen tree logs, mushrooms or swamps.

![](/doc/wiki-images/350px-Jungle_v6.jpg)

**Taiga**

The surface is covered with snow blocks on top of dirt with snow. Snow-covered pine tree forests are common in this biome.

![](/doc/wiki-images/350px-Mapgen_v6_taiga.jpg)

**Tundra**

Tundras are large open fields with thin layers of snow and are populated by dry shrubs. There are two variations of this biome.

![](/doc/wiki-images/350px-Mapgen_v6_dirt_with_snow.jpg)

**Ice sheet**

Ice sheets are two layers of ice on top of ocean water. They generate bordering directly to taigas and tundras.

![](/doc/wiki-images/350px-Minetest_Game_ice_sheet.jpg)

**Gravel**

Very rarely, unusually large areas of gravel can appear on the surface. These areas consist of nothing but gravel.

![](/doc/wiki-images/350px-Mapgen_v6_gravel_biome.png)

### Technical biomes

**Beach**

Beaches are made out of sand and form at at height of Y=2 and below, which is near the sea level by default. Beaches often extend deep into the ocean, which can easily turn a large part of the ocean floor into sand. The sand replaces the floor of other biomes. Depending on the terrain shape, beaches can be short or very long and wide (as seen in the screenshot). Clay can be found in the sand and form in small to medium-sized blobs underwater.
Beaches are generated based on height and noise; they technically form independent of the water of oceans. This effect can be noted if the water level (with the setting water_level) has been reduced.

![](/doc/wiki-images/350px-Mapgen_v6_beach.jpg)

**Ocean**

This biome is just a large body of water that can be up to 250 blocks deep. Oceans are commonly referred to as lakes, but are called oceans because they can be so huge, sometimes even 200-350 blocks across. The natural ocean floor is dirt, but sand is also common because of the beach biomes.

![](/doc/wiki-images/350px-Mapgen_v6_ocean.jpg)

**Island**

Not classifiable as a biome, but still frequent enough to be classified as a technical biome, islands occur many times in oceans. These could even be referred to as a sub-biome, being a product of another biome. Islands usually raise out of the ground 3-10 blocks, but can get as large as 40-80 blocks tall.

![](/doc/wiki-images/350px-Island_0.4.7.jpg)

**Mountain**

Mountains are the most treacherous to scale. Trees and apple trees spawn here naturally. It is quite easy to be killed in a mountain biome if you don't pay attention to where you are going.

![](/doc/wiki-images/350px-Mountain.png)

**Plateau**

A giant structure, plateaus are very common around mountain biomes as well as deserts. Plateaus can even float above ground and generate miniature biomes on top of it.

![](/doc/wiki-images/350px-Plateau_0.4.7_alternative.png)

**Water caves**

Water caves are caves that only occur at sea level, which turn into a huge underground river or lake. These caves can lead thousands of blocks down and are extremely easily to get lost in.

![](/doc/wiki-images/350px-Water_cave_0.4.7_alternative.png)

## Underground realms

There are three big underground realms:

  * Caverealms
  * Nether
  * Morlendor ([Not So Simple Mobs](#not-so-simple-mobs) must be enabled)

Here is an overview where the realms are located in the depth:

![](/doc/wiki-images/Underground_Realms.png)

No worry, you don't have to dig to Nether or Morlendor, there are special portals for them.

### Caverealms

Caverealms are huge underground caverns that extend for hundreds of blocks. Within these caverns lie stalagmites of glowing crystals, small glowing gems littering the floor, and variable terrain. . Not to mention plentiful lava and even water springs. Caves spawn between y = -700 and -15.000, and can be quite extensive.

![](/doc/wiki-images/600px-caverealms.png)

### Nether

You can go into the nether by either digging deep down or build a obsidian portal as seen in the screenshots below. To activate the portal, rightclick it with a mese crystal fragment.
When you go into the portal it will teleport you directly into the nether. A new portal is generated at your spawning point, and it will bring you back to your first portal (Note: the genration of the portal in the nether might take some time (up to 4 seconds)).
If one of the portals get destroyed (i.e. an obisidan block gets dug) the connection is destroyed. New portals that are build in the nether will bring you near the surface again.

Rare materials like glowstone, nethersand and netherbricks can be found in the nether. Netherbricks only appear in nether dungeons, and are not craftable.

![](/doc/wiki-images/600px-nether_portal.png)

![](/doc/wiki-images/600px-nether_portal_2.png)

![](/doc/wiki-images/600px-nether.png)

### Morlendor

The Morlendor dimension can be reached by a Morlendor portal. The Morlendor dimension spawns only if you have activated [Not So Simple Mobs](#not-so-simple-mobs) in the world settings.

![](/doc/wiki-images/600px-Morlendor.png)

### Railway corridors

Simple underground railway corridors with a few treasure chests. Cobwebs are added if the [Simple Mobs](#simple-mobs) world option is activated.

Use the advanced settings to finetune the railway corridors.

![](/doc/wiki-images/Railwaycorridors.png)

## Basic Controls

Most of these can be changed in the "Change Keys" menu. The default and most important controls are:

| Control | Description |
| ------------- | ------------- |
|**W/A/S/D**| move|
|**Space**| jump|
|**Left mouse button**| Punch, mine blocks, move an item stack in an inventory|
|**Right mouse button**| use (e.g. open chest or furnace), place blocks, move one item or split items in an inventory|
|**Shift+Right mouse button**| place blocks|
|**Middle mouse button**| move 10 items in an inventory|
|**Mouse wheel**| select item in the hotbar|
|**0-9**| select item in the hotbar|
|**Q**| drop block, item or tool in hand|
|**I**| open or close the inventory menu|
|**T**| open the chat window|
|**Strg**| descend on ladders or sneak (walk slower, prevents falling off ledges)|
|**F9**| Cycle through minimap modes|
|**Shift + F9**| Change minimap orientation|
|**F12**| Take screenshot|
|**Esc**| Pause menu/abort/exit (pauses only singleplayer game)|

### Boat

A boat is a wooden vehicle which floats on any water and can be used to travel on the surface of any water. Travelling by boat is slightly faster than walking.

**Usage**

To set the boat up, place it on top of water. After is has been placed, use (right-click) it to enter it. You are now on the boat. On the boat, the movement controls are slightly different than usual:

  * **Forwards key**: Increase speed
  * **Backwards key**: Decrease speed (you can have negative speed, meaning you can go backwards)
  * **Left key**: Turn boat counter-clockwise
  * **Right key**: Turn boat clockwise
  * To leave the boat, simply use it again.

![](/doc/wiki-images/600px-Riding_a_boat.jpg)


## Using blocks/items

Using refers to a specific activity with a block. The kind of activity depends on the block. Not all blocks can be used. By default, using is done by clicking with the right mouse button on the block that shall be used. 

By using, you can:

  * open and close Doors, Trapdoors and Fence Gates,
  * access a Chest's, Locked Chest's or Bones' inventory,
  * access a Furnace's menu,
  * access a Sign's menu to edit its text,
  * access a Book's menu to edit its text,
  * access the inventory of a Bookshelf or Vessels Shelf,
  * skip the night by sleeping in a Simple Bed or Fancy Bed,
  * make fire with Flint and Steel,
  * eat food, such as Apples or Bread.

![](/doc/wiki-images/inventory.png)

### Taking

You can take items from an occupied slot if the cursor holds nothing.

  * Left click: take entire item stack
  * Right click: take half from the item stack (rounding up if uneven)
  * Middle click: take 10 items from the item stack

### Dropping

You can drop items onto a slot if the cursor holds 1 or more items and the slot is either empty or contains an item stack of the same item type.

  * Left click: drop entire item stack
  * Right click: drop 1 item of the item stack
  * Middle click: drop 10 items of the item stack

### Exchanging

You can exchange items if the cursor holds 1 or more items and the destination slot is occupied by a different item type.

  * Left, middle and right click: exchange item stacks from cursor and from selected item slot

### Throwing away

If you hold an item stack and click with it somewhere outside the menu, the item stack gets thrown away into the environment.

### Automatic Transfer

You can automatically transfer an item stack to/from the player inventory to/from another item's inventory slot like a furnace, chest, or any other item with an inventory slot when that item's inventory is accessed. When transferring items to/from the furnace, items that can be smelted will automatically go to the input slot. Items in the furnace output slot will automatically go to the player inventory.

  * Shift+Left click: Automatically transfer item stack.

# Changing your skin

If you want to change the default skin, you can do this in your inventory. Just click on the "Skin"-button below.

![](/doc/wiki-images/skins1.png)

You see your current skin. Now click on "Change".

![](/doc/wiki-images/skins2.png)

Choose your desired skin.

![](/doc/wiki-images/skins3.png)

Congratulations! Press 'F7' to switch in third person mode to see your new skin!

![](/doc/wiki-images/skins4.png)

# Crafting

## Crafting grid and output slot

To be able to craft anything at all, you need a crafting grid. A crafting grid consists of a number of inventory slots and you can place and move and remove items from it like you can with an inventory. To craft, the items have to be arranged somehow in the crafting grid. Next to a crafting grid there is one output slot, in which the craft appears if you arranged the items in a valid way. Click on this symbol with the left mouse button to make this craft once. The needed items in the crafting grid will be used up. Click on the output slot with the middle mouse button to make this craft up to ten times (depending on how much items are left in the crafting grid). Crafting generally takes no time and you can use the resulting items immediately.

Crafting grids generally work like inventories. So a crafting grid found in your inventory menu can be used/abused as an extension of the player inventory.

![](/doc/wiki-images/craftingslot.png)

## Shaped and shapeless recipes

There are are two kinds of crafting recipes, _shaped ones_ and _shapeless ones_.

For a shaped recipe, the items have to be arranged into an exact pattern. If a crafting recipe takes up a smaller rectangle than the crafting grid, it can be moved on any part of the crafting grid. For example, a 2x2 recipe can be arranged on the top left, top right, bottom left or bottom right on a 3x3 crafting grid. If a crafting recipe uses more space than available in the crafting grid, you are unable to craft this item with it. You need a larger one.

For a _shapeless recipe_, the necessary items just have to be placed on any available slots of the crafting grid. Stacking items does not work, however.

Most crafting recipes are _shaped recipes_. If not noted otherwise, it is assumed that a crafting recipe is shaped.

## Example recipes

### Shapeless recipes

| Item | Ingredients | Grid |
| ------------- | ------------- | ------------- |
| Bronze Ingot | Steel Ingot + Copper ingot | ![](/doc/wiki-images/shapeless1.jpg) |
| Bronze Ingot | Steel Ingot + Copper ingot | ![](/doc/wiki-images/shapeless2.jpg) |
| Bronze Ingot | Steel Ingot + Copper ingot | ![](/doc/wiki-images/shapeless3.jpg) |

### Shaped recipes

| Item | Ingredients | Grid |
| ------------- | ------------- | ------------- |
| Paper | Papyrus | ![](/doc/wiki-images/shaped1.jpg) |
| Paper | Papyrus | ![](/doc/wiki-images/shaped2.jpg) |
| Paper | Papyrus | ![](/doc/wiki-images/shaped3.jpg) |


## Smelting

### Fuel

|  | Block | Burning time in seconds | Items smelted for fuel |
| ------------- | ------------- | ------------- | ------------- |
| ![](/doc/wiki-images/48px-Coal_block.png) | Coal Block | 370 | 123 1/3 |
| ![](/doc/wiki-images/48px-Bucket_lava.png) | Lava Bucket | 60 | 20 |
| ![](/doc/wiki-images/48px-Coal.png) | Coal Lump | 40 | 13 1/3 |
| ![](/doc/wiki-images/48px-Jungle_Tree.png) | Jungle Tree | 38 | 12 2/3 |
| ![](/doc/wiki-images/48px-Acacia_Tree.png) | Acacia Tree | 34 | 11 1/3 |
| ![](/doc/wiki-images/48px-Tree.png) | Tree | 30 | 10 |
| ![](/doc/wiki-images/48px-Pine_Tree.png) | Pine Tree | 26 | 8 2/3 |
| ![](/doc/wiki-images/48px-Aspen_Tree.png) | Aspen Tree | 22 | 7 1/3 |
| ![](/doc/wiki-images/48px-Cactus.png) | Cactus | 15 | 5 |

And many more…

### Recipes

|  | Input |  | Output | Smelting time | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| ![](/doc/wiki-images/48px-Flour.png) | Flour | ![](/doc/wiki-images/48px-Bread.png) | Bread | 15s | Can be eaten to restore health. |
| ![](/doc/wiki-images/48px-Cobblestone.png) | Cobblestone | ![](/doc/wiki-images/48px-Stone.png) | Stone | 3s | Used as decoration. |
| ![](/doc/wiki-images/48px-Mossy_Cobblestone.png) | Mossy Cobblestone | ![](/doc/wiki-images/48px-Stone.png) | Stone | 3s | Used as decoration. |
| ![](/doc/wiki-images/48px-Desert_Cobblestone.png) | Desert Cobblestone | ![](/doc/wiki-images/48px-Desert_stone.png) | Desert Stone | 3s | Used as decoration. |
| ![](/doc/wiki-images/48px-Clay_Lump.png) | Clay Lump | ![](/doc/wiki-images/48px-Clay_Brick.png) | Clay Brick | 3s | Used to craft bricks. |
| ![](/doc/wiki-images/48px-Copper_lump.png) | Copper Lump | ![](/doc/wiki-images/48px-Copper_Ingot.png) | Copper Ingot | 3s | Can be combined with a steel ingot to make a bronze ingot. |
| ![](/doc/wiki-images/48px-Gold_lump.png) | Gold Lump | ![](/doc/wiki-images/48px-Gold_ingot.png) | Gold Ingot | 3s | Used for crafting Gold Block and Skeleton Key. |
| ![](/doc/wiki-images/Skeleton_Key.png) | Skeleton Key | ![](/doc/wiki-images/48px-Gold_ingot.png) | Gold Ingot | 5s | Used for crafting Gold Block and Skeleton Key. |
| ![](/doc/wiki-images/48px-Iron_lump.png) | Iron Lump | ![](/doc/wiki-images/48px-Steel_Ingot.png) | Steel Ingot | 3s | Used for crafting several items. |
| ![](/doc/wiki-images/48px-Steel_bottle.png) | Heavy Steel Bottle | ![](/doc/wiki-images/48px-Steel_Ingot.png) | Steel Ingot | 3s | Used for crafting several items. |
| ![](/doc/wiki-images/48px-Group_sand.png) | Sand/Desert sand | ![](/doc/wiki-images/48px-Glass.png) | Glass | 3s | Used as decoration or a building material. |
| ![](/doc/wiki-images/48px-Pile_of_Glass_Fragments.png) | Pile of Glass Fragments | ![](/doc/wiki-images/48px-Glass.png) | Glass | 3s | Used as decoration or a building material. |
| ![](/doc/wiki-images/48px-Obsidian_shard.png) | Obsidian Shard | ![](/doc/wiki-images/48px-Obsidian_glass.png) | Obsidian Glass | 3s | Used as decoration or a building material. |

And many more…

# Mobs

## Simple mobs

A few simple creatures in Stonecraft, not all are bad.

| Mob | Description | Health/Armor/Damage | Drops |
| ------------- | ------------- | ------------- | ------------- |
| Zombie<br>![](/doc/wiki-images/90px-CME_Zombie.png) | Zombies can spawn at every time of day in the world as long there is not too much light. So you will find some in caves, dark forests and of cause a lot at night. If they notice you they will attack. Zombies have 20 HP (like players) and drop sometimes rotten flesh on death. On day Zombies die because of the sunlight. | 20![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/-![](/doc/wiki-images/16px-Heart.png) | Rotten flesh |
| Ghost<br>![](/doc/wiki-images/118px-CME_Ghost.png) | Ghosts only spawn at night-time and they don't spawn underground. They are flying in the world and attack you aswell if they notice you. Ghosts have 15 HP and don't drop any items atm (might be changed in future).They can't harm you in your house. If it becomes day Ghosts will take damage by the sunlight, so they will die after a while. | 15![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/-![](/doc/wiki-images/16px-Heart.png) | - |
| Sheep<br>![](/doc/wiki-images/111px-CME_Sheep.png) | Sheep spawn only at day-time and are friendly mobs. They remain around 5 minutes in the world unless they are tamed with 5 wheat (rightclick). There are four different wool colors: white, grey, brown and black. If there is grass (dirt with grass) they eat the grass and make new wool that way. Sheep have 8 HP and drop 1-2 wool when punched or sheared with shears. They need to eat grass until they can give wool again. | 8![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/-![](/doc/wiki-images/16px-Heart.png) | 1-2 wool |
| Chicken<br>![](/doc/wiki-images/120px-CME_Chicken.png) | Chicken are friendly and spawn only at day-time too. They drop randomly eggs and remain 5 minutes. Currently you can't tame or breed them. They drop chicken meat and feather(s) on death. Eggs can be thrown to spawn (rarely) new chicken, or cooked in furnace to gain fried eggs, which are eatable. | -![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/-![](/doc/wiki-images/16px-Heart.png) | Chicken meat<br>Feather(s) |
| Oerrki<br>![](/doc/wiki-images/62px-CME_Oerki1.png) | Oerrki spawn only at night on stone or dirt like blocks. They attack players and make more damage than Zombies or Ghosts. Daylight can't harm them. | -![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/-![](/doc/wiki-images/16px-Heart.png) | - |

## Not So Simple Mobs

**Not So Simple Mobs** are more complex mobs in Stonecraft, for the purpose of increasing the difficulty of playing. There are more than 50 different mobs. They are divided in groups, each one who lives in a different biome.

They all drop life energies. With life energies you can craft tools and special powerful weapons to defend yourself from the monsters.

| Mob | Description | Health/Armor/Damage | Drops |
| ------------- | ------------- | ------------- | ------------- |
| Black Widow<br>![](/doc/wiki-images/120px-Nssm_black_widow.png) | A black widow is a hostile medium sized spider with a big abdomen. They attack with small but powerful chelicerae. | 10![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/1 1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Spider Leg<br>Web |
| Stone Bloco<br>![](/doc/wiki-images/120px-Nssm_Stone_bloco.png) | A Bloco is a hostile mob made of stone with a little head, short arms and legs. Bloco Is a little clumsy in walking and he chases his enemies rolling like a ball, a cubic ball obviously!<br><br>He is a true Rolling Stones fan. | 7 1/2![](/doc/wiki-images/16px-Heart.png)/4![](/doc/wiki-images/Armor.png)/1![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Stone |
| Crab<br>![](/doc/wiki-images/120px-Nssm_crab.png) | Crab is a hostile mob that lives on the beach and they don't float in water, they prefer walking on the sand pinching their enemies with their powerful chelas. Crabs have two possible colors of their carapace, red and light orange. | 17![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/1 1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Surimi<br>Crab Chela |
| Crocodile<br>![](/doc/wiki-images/108px-Nssm_crocodile.png) | A Crocodile is a hostile mob. | 10![](/doc/wiki-images/16px-Heart.png)/1![](/doc/wiki-images/Armor.png)/1 1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Crocodile Tail |
| Daddy Long Legs<br>![](/doc/wiki-images/120px-Nssm_daddy_long_legs.png) | A Daddy Long Legs is a spiderlike hostile mob with a small body and obviously, long legs! | 9 1/2![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/1 1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Spider Leg |
| Dolidrosaurus<br>![](/doc/wiki-images/98px-Nssm_dolidrosaurus.png) | A Dolidrosaurus is an aquatic reptile hostile mob with a long tail and a fin at the end. They're fully adapted to living in water and they have two others fins on the side which allow them to swim faster and more precisely. Dolidrosaurus derives from greek, Dolicolos means long, Hydor water and Sauros lizard. Dolidrosauruses have five possible variations of their skin: Dark green, green, light green, blue-green and blue-pink. | 13![](/doc/wiki-images/16px-Heart.png)/2![](/doc/wiki-images/Armor.png)/2![](/doc/wiki-images/16px-Heart.png) | Life Energy |
| Duck<br>![](/doc/wiki-images/61px-Nssm_duck.png) | A Duck is cute but evil hostile mob. Walks around the plains with nothing better to do than pecking the players foot. It Is quite small and can survive Stonecraft cruel world only with the help of her big brothers and sisters that attack the bad players who wants to eat their delicious duck legs. | 5![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/1/2![](/doc/wiki-images/16px-Heart.png)| Life Energy<br>Duck Legs<br>Duck Beak |
| Echidna<br>![](/doc/wiki-images/68px-Nssm_echidna.png) | An Echidna is a beautiful human hostile mob. It's skin is pale, sick-green and they have black hair. They're half naked but you probably won't care, the one who looses himself in thoose evil, but beautiful, eyes is dead. When you are to close she will slash you with her tail. She emits poison to blocks nearby which does not go away, it causes half heart of damage each game tick and you can drown in it like you would in water. | 45![](/doc/wiki-images/16px-Heart.png)/4![](/doc/wiki-images/Armor.png)/5![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Snake Scute |
| Enderduck<br>![](/doc/wiki-images/69px-Nssm_enderduck.png) | An Enderduck is tall and very dark hostile mob that spawns at night and hunts poor miners chasing them with high speed and brilliant eyes that allow them to see in the darker night. | 10![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/1 1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Duck Legs<br>Duck Beak |
| Felucco<br>![](/doc/wiki-images/120px-Felucco_nssm.png) | The Felucco is one of the most fierce carnivores of nssm. It is very fast and attacks anyone with its mighty horns. His name derives form italian: "fel" stands for "felino", feline, because of its similarity with leopards. "Ucc" stands for "mucca", cow, because of his peculiar horns and "o" is the desinence for male in italian.<br><br>With the fur it is possible to craft a strong armor, but not so durable. Felucco steaks are very nutritious after been cooked. Felucco horns are good raw materials to craft weapons and tools, it is possible to craft a hoe, a knife and a spear. | 16![](/doc/wiki-images/16px-Heart.png)/3![](/doc/wiki-images/Armor.png)/2 1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Felucco Fur<br>Felucco Steak<br>Felucco Horn |
| Giant Sandworm<br>![](/doc/wiki-images/74px-Nssm_Giant_sandworm.png) | A Giant Sandworm is a huge hostile mob that likes to stay in one place and damages players when they get within a 7 block range. | 65![](/doc/wiki-images/16px-Heart.png)/4![](/doc/wiki-images/Armor.png)/4![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Worm Flesh<br>Black Sand |
| Icelamander<br>![](/doc/wiki-images/120px-Nssm_icelamander.png) | The Icelamander is the boss of ice biomes. Nearly nothing could defeat this dangerous mob. Taller than a normal Sam, the Icelamanders have even more frightening jaws than Snow Biters! They have a long tail that helps them to keep the balance on their two legs. The Icelamanders are so cold that they frost everything while walking, not only water! Their frosting power is so strong that they can freeze you in an ice column even from a great distance! Not the simple default ice, but the Coldest Ice, so cold that can freeze the souls of the unlucky creatues trapped in it.<br><br>Icelamander eats their with their horrible fangs that can damage really bad their preys. You have now certainly understood that Icelamanders are really really dangerous. | 230![](/doc/wiki-images/16px-Heart.png)/6![](/doc/wiki-images/Armor.png)/6![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Ice Tooth<br>Little Ice Tooth<br>Frosted Amphibian Heart<br>Amphibian Ribs |
| Icesnake<br>![](/doc/wiki-images/111px-Nssm_icesnake.png) | An Icesnake is an amphibian that live in ice plains and mountains. Long ago its body has been adapted to cold biomes using ice and cold in order to preserve the water content in cells. In fact the heat produced by the frosting of ice in the environment allows the Icesnake and the others ice amphibians as Snow Biters, Icelamanders and Icelizards to keep in the liquid form their body fluids.<br><br>Icesnakes aren't very big or evil but they attack enemies with their fangs very rapidly. | 13 1/2![](/doc/wiki-images/16px-Heart.png)/3![](/doc/wiki-images/Armor.png)/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Ice Tooth<br>Little Ice Tooth<br>Frosted Amphibian Heart<br>Amphibian Ribs |
| Kraken<br>![](/doc/wiki-images/65px-Nssm_kraken.png) | A Kraken is the king of the sea hostile gigantic octopus mob with long tentacles. There attack with tentacles is devastating but there dimensions doesn't allow them to go fast. Females are red-rose as Octpuses, on the other side the males are dark green. Kraken can produce ink in the water which make seeing in water even more difficult. | 75![](/doc/wiki-images/16px-Heart.png)/3![](/doc/wiki-images/Armor.png)/4![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Tentacle<br>Tentacle Curly |
| Larva<br>![](/doc/wiki-images/108px-Nssm_larva.png) | A Larva is a hostile mob. It is the first stadium of Mantis and Mantis Beasts development. Their body is white and the head is brown. After around half a minute they become Mantis or Mantis Beasts! So be careful and slay all of them before it is too late. | 5![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy |
| Lava Titan<br>![](/doc/wiki-images/90px-Nssm_lava_titan.png) | A Lava Titan is a hostile mob that turns nearby blocks into lava and has two attack styles.<br>- Lava titan hits the ground with his fist, kneels and summons lava blocks diagonaly around players.<br>- Lava titan marches straight toward you rushing through blocks and destroying every block he touches. | 40![](/doc/wiki-images/16px-Heart.png)/6![](/doc/wiki-images/Armor.png)/3 1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Lava Bucket<br>Lava Titan Eye |
| Manticore<br>![](/doc/wiki-images/84px-Nssm_manticore.png) | A Manticore is a strong, fast hostile mob. It attacks either with projectiles from a far or with the scorpion sting on it's tail when you're too near.<br><br>Appearence<br>With face like a man's, a skin red as cinnabar, and is as large as a lion. It has three rows of teeth, ears and light-blue eyes like those of a man; its tail is like that of a land scorpion, containing a sting more than a cubit long at the end. It has other stings on each side of its tail. | 12 1/2![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Manticore Spine |
| Mantis<br>![](/doc/wiki-images/80px-Nssm_mantis.png) | A Mantis is a tall and humanlike hostile mob that has two possible colors and attacks with two powerful kung fu moves with its 4 arms! It walks on two legs looking for fresh meat: you! | 7 1/2![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/1![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Mantis Claw |
| Mantis Beast<br>![](/doc/wiki-images/120px-Nssm_mantis_beast.png) | A Mantis Beast is a hostile mob that is Very similar to their relatives that walk on only two legs, Mantis Beasts are faster thanks to their 6 claws used in running and their position is more "beastly"! | 10![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/1 1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Mantis Claw |
| Masticone<br>![](/doc/wiki-images/120px-Nssm_masticone.png) | A Masticone is a hostile mob that alone isn't a real danger, but when you kill one of them two others come to venge their friend. Kill as many as you can then run as fast as you can! | 7 1/2![](/doc/wiki-images/16px-Heart.png)/4![](/doc/wiki-images/Armor.png)/2 1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Masticone Fang<br>Masticone Skull<br>Fragments |
| Mese Dragon<br>![](/doc/wiki-images/95px-Nssm_messe_dragon.png) | A Mese Dragon is a massive hostile boss mob with midas touch that turns nearby blocks into mese blocks and has meele and firebreath attack. Mese dragon is not damaged by sunlight, water or lava. | 166 1/2![](/doc/wiki-images/16px-Heart.png)/4![](/doc/wiki-images/Armor.png)/8![](/doc/wiki-images/16px-Heart.png) | Energy Globe<br>Rainbow Staff |
| Night Master<br>![](/doc/wiki-images/120px-Nssm_moonherontrio.png) | A Night Master is a hostile mob that is a special kind of Moonheron that has three heads. | 15![](/doc/wiki-images/16px-Heart.png)/3![](/doc/wiki-images/Armor.png)/4![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Heron Leg<br>Night Feather |
| Octopus<br>![](/doc/wiki-images/106px-Nssm_octopus.png) | An octopus is a hostile mob that is weaker brother of Kraken, they're not able to produce ink and they are all red-rose. | 11![](/doc/wiki-images/16px-Heart.png)/-![](/doc/wiki-images/Armor.png)/1 1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Tentacle |
| Phoenix<br>![](/doc/wiki-images/120px-Nssm_phoenix.png) | A Phoenix is a hostile mob made of fire and energy. Nobody, unless the sun, is brighter than this beatiful bird in the sky. | 30![](/doc/wiki-images/16px-Heart.png)/4![](/doc/wiki-images/Armor.png)/1![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Sun Feather<br>Phoenix Tear<br>Phoenix Nuggets |
| Pumpking<br>![](/doc/wiki-images/98px-Nssm_pumpking.png) | A Pumpking is a hostile mob king of the pumbooms it is tall creepy creature with a humanlike black thin bodies covered with the blood of their victims, their head is very similar to a Pumpboom and their body to Signosigno. On their death they have a little explosive surprise for the unlucky warrior able enough to defeat them... | 50![](/doc/wiki-images/16px-Heart.png)/5![](/doc/wiki-images/Armor.png)/4 1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Cursed Pumpkin Seed |
| Scrausics<br>![](/doc/wiki-images/120px-Scrausics_nssm.png) | A scrausics is a hostile mob. | 15![](/doc/wiki-images/16px-Heart.png)/2![](/doc/wiki-images/Armor.png)/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Raw Scrausics Wing |
| Snowbiter<br>![](/doc/wiki-images/120px-Snowbiter_nssm.png) | A Snow Biter is a hostile mob. | 15![](/doc/wiki-images/16px-Heart.png)/2![](/doc/wiki-images/Armor.png)/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Frosted Amphibian Heart<br>Amphibian Ribs<br>Little Ice Tooth |
| Spiderduck<br>![](/doc/wiki-images/120px-Spiderduck_nssm.png) | Spiderducks have evolved from Enderducks to become more similar to the spiders. They have a dark skin and 8 legs, but the body is the one of a duck.<br><br>Even if they are not bosses they are extremely dangerous! In fact if you don't know what to expect from a spiderduck you can easily fall in its web and become a tasteful snack! Spiderducks spawn only at night and because of their dark color they are able to easily blend with the environment. If a spiderduck sees you it starts shooting at you web projectiles. When they hit the target a sticky web covers the soil trapping the victims. And if you have been trapped then expect the spiderduck to come at you and to eat you! | 24-35![](/doc/wiki-images/16px-Heart.png)/2![](/doc/wiki-images/Armor.png)/6![](/doc/wiki-images/16px-Heart.png) | Duck legs<br>Life Energy<br>Web<br>Duck beak |
| Stone Eater<br>![](/doc/wiki-images/120px-Stone_Eater_nssm.png) | A Stone Eater is a hostile mob that is imune to any sword weapon. When under attack he bites back while eating stone that is around. | 14![](/doc/wiki-images/16px-Heart.png)/6![](/doc/wiki-images/Armor.png)/2 1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Stoneater Mandible<br>Stone |
| Swimming Duck<br>![](/doc/wiki-images/120px-Swiming_Duck_nssm.png) | A Swimming Duck is a hostile mob. | 12 1/2![](/doc/wiki-images/16px-Heart.png)/2![](/doc/wiki-images/Armor.png)/1 1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Duck Legs<br>Duck Beak<br>Duck Feather |
| Tarantula<br>![](/doc/wiki-images/120px-Tarantula_nssm.png) | A Tarantula is a hostile mob that can either bite or slow down your movement trapping you inside a cocon. After killing it Tarantula Propower appears. | 25![](/doc/wiki-images/16px-Heart.png)/4![](/doc/wiki-images/Armor.png)/4![](/doc/wiki-images/16px-Heart.png) | Super Silk Gland |
| Mordain<br>![](/doc/wiki-images/120px-Mordain_nssm.png) | A Mordain is a hostile mob that likes teleporting. | 16![](/doc/wiki-images/16px-Heart.png)/2![](/doc/wiki-images/Armor.png)/3![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Slothful Soul Fragment |
| Morde<br>![](/doc/wiki-images/120px-Morde_nssm.png) | A Morde is a hostile mob that has an ability to heal himself. | 23 1/2![](/doc/wiki-images/16px-Heart.png)/4![](/doc/wiki-images/Armor.png)/3![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Proud Soul Fragment |
| Morgre<br>![](/doc/wiki-images/120px-Morgre_nssm.png) | A Morgre is a hostile mob that likes to explode. | 17![](/doc/wiki-images/16px-Heart.png)/4![](/doc/wiki-images/Armor.png)/1/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Greedy Soul Fragment |
| Morgut<br>![](/doc/wiki-images/120px-Morgut_nssm.png) | Dont let it get to close to you or else it will steal your precious food. You can get your food back by slaying Morgut.<br><br>With the Gluttonous soul fragment it is possible to craft a strong weapon Sword of Gluttony and Food Bomb | 18![](/doc/wiki-images/16px-Heart.png)/3![](/doc/wiki-images/Armor.png)/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Gluttonous soul fragment |
| Morlu<br>![](/doc/wiki-images/120px-Morlu_nssm.png) | Dont let it get to close to you or else it will steal your precious equipped armor. You can get your armor back by slaying Morlu.<br><br>With the Lustful Soul Fragment it is possible to craft strong Morlu armor and Cage Bomb | 28![](/doc/wiki-images/16px-Heart.png)/5![](/doc/wiki-images/Armor.png)/4![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Wrathful Soul Fragment |
| Morvy<br>![](/doc/wiki-images/120px-Morvy_nssm.png) | A Morvy is a hostile mob that likes summoning. | 19 1/2![](/doc/wiki-images/16px-Heart.png)/4![](/doc/wiki-images/Armor.png)/2![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Envious Soul Fragment |
| Morwa<br>![](/doc/wiki-images/120px-Morwa_nssm.png) | A Morwa is a hostile mob that can either range you from afar or smash you when your close enough. | 28![](/doc/wiki-images/16px-Heart.png)/5![](/doc/wiki-images/Armor.png)/4![](/doc/wiki-images/16px-Heart.png) | Life Energy<br>Wrathful Soul Fragment |

# Farming

Farmable blocks will spawn either new blocks or yield new items, when mined. All farmable blocks have to be on top of another certain kind of block to grow. Some farmable blocks also need light. The “Maximum profit” column shows the maximum possible outcome a single block will yield, including itself. Please notice: Light level 13 on a farmable crop cannot be achieved at night!

![](/doc/wiki-images/Farming_redo.jpg)

## Saplings

Saplings are a group of blocks which grow into trees. They are dropped by leaf-type blocks with a chance of 1 in 20 for each leaf block. The sapling drop “replaces” the leaf block drop—you do not get the leaf block if you get a sapling.

All saplings can be can be placed on any block.

**Growth**

Saplings will, provided they are under sunlight and are on placed on any dirt or another block that supports growth, will grow into trees after a while. They instantly go from sapling to full tree, there are no intermediate growth stages.

Specifically, all saplings only grow on the following blocks:

  * Dirt
  * Dirt with Grass
  * Dirt with Grass and Footsteps
  * Dirt with Rainforest Litter
  * Dirt with Dry Grass
  * Soil
  * Wet Soil
  * Desert Sand (!)
  * Desert Sand Soil
  * Wet Desert Sand Soil

**Types**

There are different saplings, each sapling grows into a different tree.

| Block | Grows on | Needs light? | Drops | Stages |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| ![](/doc/wiki-images/32px-Sapling.png) Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | ![](/doc/wiki-images/32px-Tree.png) Trees, ![](/doc/wiki-images/32px-Leaves.png) Leaves and ![](/doc/wiki-images/32px-Apple.png) Apples | 2 |
| ![](/doc/wiki-images/32px-Jungle_Sapling.png) Jungle Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | ![](/doc/wiki-images/32px-Jungle_Tree.png) Jungle Trees and ![](/doc/wiki-images/32px-Jungle_Leaves.png) Jungle Leaves | 2 |
| ![](/doc/wiki-images/32px-Acacia_Tree_Sapling.png) Acacia Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | ![](/doc/wiki-images/32px-Acacia_Tree.png) Acacia Trees and ![](/doc/wiki-images/32px-Acacia_Leaves.png) Acacia Leaves | 2 |
| ![](/doc/wiki-images/32px-Pine_Sapling.png) Pine Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | ![](/doc/wiki-images/32px-Pine_Tree.png) Pine Trees and ![](/doc/wiki-images/32px-Pine_Needles.png) Pine Needles | 2 |
| ![](/doc/wiki-images/32px-Aspen_Tree_Sapling.png) Aspen Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | ![](/doc/wiki-images/32px-Aspen_Tree.png) Aspen Trees and ![](/doc/wiki-images/32px-Aspen_Leaves.png) Aspen Leaves | 2 |
| ![](/doc/wiki-images/32px-Cactus.png) Cactus | Any kind of sand | No | ![](/doc/wiki-images/32px-Cactus.png) Cacti | 4 |
| ![](/doc/wiki-images/32px-Papyrus.png) Papyrus | Dirt, Dirt with Grass. (Water must be to 3 blocks away) | No | ![](/doc/wiki-images/32px-Papyrus.png) Papyri | 4 |
| Group:flora | Dirt with Grass | Yes, 13 or higher | Flora blocks of the same kind | 1 |
| Group:flora | Desert Sand | No | ![](/doc/wiki-images/32px-Dry_Shrub.png) Dry Shrub | 1 |

## Plants, Food and Utensils

**Plants and their Products**

  * Barley; Barley Seed
  * Green Beans; Bean Pole (place on soil before planting beans)
  * Beetroot; Beetroot Soup
  * Blueberries; Blueberry Muffin, Blueberry Pie
  * Carrot; Golden Carrot
  * Chili; Chili Pepper, Bowl of Chili
  * Cocoa; Cocoa Beans, Cookie, Bar of Dark Chocolate
  * Coffee; Coffee Beans, Drinking Cup (empty), Cold Cup of Coffee, Hot Cup of Coffee
  * Corn; Corn on the Cob, Bottle of Ethanol
  * Cotton; Cotton Seed
  * Cucumber
  * Donut; Chocolate Donut, Apple Donut
  * Garlic; Garlic clove, Garlic Braid
  * Grapes; Trellis (place on soil before planting grapes)
  * Hemp; Hemp Seed, Hemp Leaf, Bottle of Hemp Oil, Hemp Fibre, Hemp Rope
  * Melon; Melon Slice
  * Onion
  * Peas; Pea Pod, Pea Soup
  * Pepper; Peppercorn, Ground Pepper
  * Pinapple; Pineapple Top, Pineapple Ring, Pineapple Juice
  * Potato; Baked Potato, Potato Salad
  * Pumpkin; Pumpkin Slice, Jack 'O Lantern, Pumpkin Bread, Pumpkin Dough
  * Raspberries; Raspberry Smoothie
  * Rhubarb, Rhubarb Pie
  * Sugar (from Papyrus), Salt (from cooking water)
  * Tomato
  * Wheat; Wheat Seed, Straw, Flour, Bread

**Utensils**

  * Wooden Bowl
  * Sauce Pan
  * Cooking Pot
  * Backing Tray
  * Skillet
  * Mortar and Pestle
  * Cutting Board
  * Juicer
  * Glass mixing Bowl

**Other**

  * overides to Soil, Wet Soil, Grass
  * Hoes; Wooden Hoe, Stone Hoe, Steel Hoe, Bronze Hoe, Mese Hoe, Diamond Hoe
  * Seed

| Plant | Name | Stages | Item | Itemstring |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| ![](/doc/wiki-images/40px-Farming_barley_7_(farming_redo).png) | Barley | 7 | ![](/doc/wiki-images/40px-Farming_barley.png) | farming:barley |
| ![](/doc/wiki-images/40px-Farming_beanpole_5_(farming_redo).png) | Beans (green) | 5 | ![](/doc/wiki-images/40px-Farming_beans_(farming_redo).png) | farming:beans |
| ![](/doc/wiki-images/40px-Farming_beetroot_5_(farming_redo).png) | Beetroot | 5 | ![](/doc/wiki-images/40px-Farming_beetroot_(farming_redo).png) | farming:beetroot |
| ![](/doc/wiki-images/40px-Farming_blueberry_4_(farming_redo).png) | Blueberries | 4 | ![](/doc/wiki-images/40px-Farming_blueberries_(farming_redo).png) | farming:blueberry |
| ![](/doc/wiki-images/40px-Farming_carrot_8_(farming_redo).png) | Carrot | 8 | ![](/doc/wiki-images/40px-Farming_carrot_(farming_redo).png) | farming:carrot |
| ![](/doc/wiki-images/40px-Farming_chili_8_(farming_redo).png) | Chili | 8 | ![](/doc/wiki-images/40px-Farming_chili_pepper_(farming_redo).png) | farming:chili |
| ![](/doc/wiki-images/40px-Farming_cocoa_4_(farming_redo).png) | Cocoa | 4 | ![](/doc/wiki-images/40px-Farming_cocoa_beans_(farming_redo).png) | farming:cocoa |
| ![](/doc/wiki-images/40px-Farming_coffee_5_(farming_redo).png) | Coffee | 5 | ![](/doc/wiki-images/40px-Farming_coffee_beans_(farming_redo).png) | farming:coffee |
| ![](/doc/wiki-images/40px-Farming_corn_8_(farming_redo).png) | Corn | 8 | ![](/doc/wiki-images/40px-Farming_corn_(farming_redo).png) | farming:corn |
| ![](/doc/wiki-images/40px-Farming_cotton_8_(farming_redo).png) | Cotton | 8 | ![](/doc/wiki-images/40px-Farming_cotton_(farming_redo).png) | farming:cotton |
| ![](/doc/wiki-images/40px-Farming_cucumber_4_(farming_redo).png) | Cucumber | 4 | ![](/doc/wiki-images/40px-Farming_cucumber_(farming_redo)r.png) | farming:cucumber |
| ![](/doc/wiki-images/40px-Crops_garlic_plant_5_(farming_redo).png) | Garlic | 5 | ![](/doc/wiki-images/40px-Crops_garlic_(farming_redo).png) | farming:garlic |
| ![](/doc/wiki-images/40px-Farming_grapes_8_(farming_redo).png) | Grapes | 8 | ![](/doc/wiki-images/40px-Farming_grapes_(farming_redo).png) | farming:grapes |
| ![](/doc/wiki-images/40px-Farming_hemp_8_(farming_redo).png) | Hemp | 8 | ![](/doc/wiki-images/40px-Farming_hemp_leaf_(farming_redo).png) | farming:hemp |
| ![](/doc/wiki-images/40px-Farming_melon_top_(farming_redo).png) | Melon | 8 | ![](/doc/wiki-images/40px-Farming_melon_slice_(farming_redo).png) | farming:melon |
| ![](/doc/wiki-images/40px-Crops_onion_plant_5_(farming_redo).png) | Onion | 5 | ![](/doc/wiki-images/40px-Crops_onion_(farming_redo).png) | farming:onion |
| ![](/doc/wiki-images/40px-Crops_pepper_plant_5_(farming_redo).png) | Pepper | 5 | ![](/doc/wiki-images/40px-Crops_pepper_(farming_redo).png) | farming:pepper |
| ![](/doc/wiki-images/40px-Farming_pineapple_8_(farming_redo).png) | Pineapple | 8 | ![](/doc/wiki-images/40px-Farming_pineapple_(farming_redo).png) | farming:pineapple |
| ![](/doc/wiki-images/40px-Farming_potato_4_(farming_redo).png) | Potato | 4 | ![](/doc/wiki-images/40px-Farming_potato_(farming_redo).png) | farming:potato |
| ![](/doc/wiki-images/40px-Farming_pea_5_(farming_redo).png) | Peas | 5 | ![](/doc/wiki-images/40px-Farming_pea_peas_(farming_redo).png) | farming:peas |
| ![](/doc/wiki-images/40px-Farming_pumpkin_8_(farming_redo).png) | Pumpkin | 8 | ![](/doc/wiki-images/40px-Farming_pumpkin_top_(farming_redo).png) | farming:pumpkin |
| ![](/doc/wiki-images/40px-Farming_raspberry_4_(farming_redo).png) | Raspberries | 4 | ![](/doc/wiki-images/40px-Farming_raspberries_(farming_redo).png) | farming:raspberry |
| ![](/doc/wiki-images/40px-Farming_rhubarb_3_(farming_redo).png) | Rhubarb | 3 | ![](/doc/wiki-images/40px-Farming_rhubarb_(farming_redo).png) | farming:rhubarb |
| ![](/doc/wiki-images/40px-Farming_tomato_(farming_redo).png) | Tomato | 8 | ![](/doc/wiki-images/40px-Farming_tomato_8_(farming_redo).png) | farming:tomato |
| ![](/doc/wiki-images/40px-Farming_wheat_8_(farming_redo).png) | Wheat | 8 | ![](/doc/wiki-images/40px-Farming_wheat_(farming_redo).png) | farming:wheat |

# Technic

Become an engineer in Stonecraft! From simple water-wheel ore proccessing centers, to massive nuclear-powered force-field networks!

![](/doc/wiki-images/Technic_Screenshot.png)

* ![](/doc/wiki-images/technic_mv_alloy_furnace_front.png) [Machines](#machines)
* ![](/doc/wiki-images/technic_mv_compressor_front.png) [Consumers](#consumers)
* ![](/doc/wiki-images/technic_hv_generator_front.png) [Generators](#generators)
* ![](/doc/wiki-images/technic_mithril_chest_front.png) [Chests](#chests)
* ![](/doc/wiki-images/technic_uranium_ingot.png) [Resources](#resources)
* ![](/doc/wiki-images/technic_mining_laser_mk3.png) [Tools](#tools)

## Machines

### Machine details

* [Generators](#generators)
* [Consumers](#consumers)
* [Other machines](#other-machines)

### Overview

Many of the important machines in Technic run on electricity, using wires to connect generators with the consuming machines. These electric circuits consist of a generator, a consumer, wiring, and a switching station. Every independent circuit requires all 4 of these elements to function. In general the machines are all connected on the bottom by wire. Machines should be placed first and then the wire placed under and around them. The wiring should automatically adjust itself to connect to each machine and adjacent wires. If the wiring looks incorrect, it's likely that it won't work so be sure to check this!

Circuits are also grouped into 3 different categories based on how much power they transfer and the corresponding voltage: low voltage (LV), medium voltage (MV), and high voltage (HV). The base level for all electronics is low voltage, so if voltage isn't specified for a electrical component, you may safely assume it's low voltage. Most low-voltage components are upgradable to medium- and high-voltage through further crafting. To get started, you won't need to worry about any MV or HV components, and the basic low-voltage components are fine.

### Getting started

The first step to working with the more advanced machines are to get a basic electrical circuit set up for converting coal into power for other machines. This will rely on the following:

![](/doc/wiki-images/LV_Fuel_Fired_Generator_Crafting.png)
1x LV Fuel Fired Generator

![](/doc/wiki-images/Switching_station_crafting.png)
1x Switching station

![](/doc/wiki-images/LV_cable_Crafting.png)
2x LV Cable

The generator and switching station should be placed side-by-side with the wire underneath connecting both of them. Once this is done, additional consumers can be added to the network. A grinder or extractor are both good choices to expand the capabilities of the coal-fired smelter and coal-fired alloy furnace that you already have.

### Consumers

Consumer is a machine which consume energy to do something.

This is the list of all consumers avaible in Technic:

* Alloy furnace
* MV Alloy furnace
* Grinder
* Electric Furnace
* MV - Electric Furnace
* Force field emitter
* CNC machine
* Power radiator
* Tool workshop

### Generators

This is list of all generators available in Technic:

* Coal generator 
* [Geothermal EU generator](#geothermal-eu-generator) 
* [Watermill](#watermill) 
* [Solar-panel](#solar-panel) 
* LV [solar-array](#solar-array) 
* MV [solar-array](#solar-array) 
* HV [solar-array](#solar-array) 

## Powered machines

### Powered machine tiers

Each powered machine takes its power in some specific form, being either fuel-fired (burning fuel directly) or electrically powered at some specific voltage. There is a general progression through the game from using fuel-fired machines to electrical machines, and to higher electrical voltages. The most important kinds of machine come in multiple variants that are powered in different ways, so the earlier ones can be superseded. However, some machines are only available for a specific power tier, so the tier can't be entirely superseded.

Powered machine upgrades

Some machines have inventory slots that are used to upgrade them in some way. Generally, machines of MV and HV tiers have two upgrade slots, and machines of lower tiers (fuel-fired and LV) do not. Any item can be placed in an upgrade slot, but only specific items will have any upgrading effect. It is possible to have multiple upgrades of the same type, but this can't be achieved by stacking more than one upgrade item in one slot: it is necessary to put the same kind of item in more than one upgrade slot. The ability to upgrade machines is therefore very limited. Two kinds of upgrade are currently possible: an energy upgrade and a tube upgrade.

An energy upgrade consists of a battery item, the same kind of battery that serves as a mobile energy store. The effect of an energy upgrade is to improve in some way the machine's use of electrical energy, most often by making it use less energy. The upgrade effect has no relation to energy stored in the battery: the battery's charge level is irrelevant and will not be affected.

A tube upgrade consists of a control logic unit item. The effect of a tube upgrade is to make the machine able, or more able, to eject items it has finished with into pneumatic tubes. The machines that can take this kind of upgrade are in any case capable of accepting inputs from pneumatic tubes. These upgrades are essential in using powered machines as components in larger automated systems.

### Tubes with powered machines

Generally, powered machines of MV and HV tiers can work with pneumatic tubes, and those of lower tiers cannot. (As an exception, the fuel-fired furnace from the basic Stonecraft game can accept inputs through tubes, but can't output into tubes.)

If a machine can accept inputs through tubes at all, then this is a capability of the basic machine, not requiring any upgrade. Most item-processing machines take only one kind of input, and in that case they will accept that input from any direction. This doesn't match how tubes visually connect to the machines: generally tubes will visually connect to any face except the front, but an item passing through a tube in front of the machine will actually be accepted into the machine.

A minority of machines take more than one kind of input, and in that case the input slot into which an arriving item goes is determined by the direction from which it arrives. In this case the machine may be picky about the direction of arriving items, associating each input type with a single face of the machine and not accepting inputs at all through the remaining faces. Again, the visual connection of tubes doesn't match: generally tubes will still visually connect to any face except the front, thus connecting to faces that neither accept inputs nor emit outputs.

Machines do not accept items from tubes into non-input inventory slots: the output slots or upgrade slots. Output slots are normally filled only by the processing operation of the machine, and upgrade slots must be filled manually.

Powered machines generally do not eject outputs into tubes without an upgrade. One tube upgrade will make them eject outputs at a slow rate; a second tube upgrade will increase the rate. Whether the slower rate is adequate depends on how it compares to the rate at which the machine produces outputs, and on how the machine is being used as part of a larger construct. The machine always ejects its outputs through a particular face, usually a side. Due to a bug, the side through which outputs are ejected is not consistent: when the machine is rotated one way, the direction of ejection is rotated the other way. This will probably be fixed some day, but because a straightforward fix would break half the machines already in use, the fix may be tied to some larger change such as free selection of the direction of ejection.

### Battery boxes

The primary purpose of battery boxes is to temporarily store electrical energy to let an electrical network cope with mismatched supply and demand. They have a secondary purpose of charging and discharging powered tools. They are thus a mixture of electrical infrastructure, powered machine, and generator. Battery boxes connect to cables only from the bottom.

MV and HV battery boxes have upgrade slots. Energy upgrades increase the capacity of a battery box, each by 10% of the un-upgraded capacity. This increase is far in excess of the capacity of the battery that forms the upgrade.

For charging and discharging of power tools, rather than having input and output slots, each battery box has a charging slot and a discharging slot. A fully charged/discharged item stays in its slot. The rates at which a battery box can charge and discharge increase with voltage, so it can be worth building a battery box of higher tier before one has other infrastructure of that tier, just to get access to faster charging.

MV and HV battery boxes work with pneumatic tubes. An item can be input to the charging slot through the sides or back of the battery box, or to the discharging slot through the top. With a tube upgrade, fully charged/discharged tools (as appropriate for their slot) will be ejected through a side.

### Processing machines
The furnace, alloy furnace, grinder, extractor, compressor, and centrifuge have much in common. Each implements some industrial process that transforms items into other items, and the manner in which they present these processes as powered machines is essentially identical.

Most of the processing machines operate on inputs of only a single type at a time, and correspondingly have only a single input slot. The alloy furnace is an exception: it operates on inputs of two distinct types at once, and correspondingly has two input slots. It doesn't matter which way round the alloy furnace's inputs are placed in the two slots.

The processing machines are mostly available in variants for multiple tiers. The furnace and alloy furnace are each available in fuel-fired, LV, and MV forms. The grinder, extractor, and compressor are each available in LV and MV forms. The centrifuge is the only single-tier processing machine, being only available in MV form. The higher-tier machines process items faster than the lower-tier ones, but also have higher power consumption, usually taking more energy overall to perform the same amount of processing. The MV machines have upgrade slots, and energy upgrades reduce their energy consumption.

The MV machines can work with pneumatic tubes. They accept inputs via tubes from any direction. For most of the machines, having only a single input slot, this is perfectly simple behavior. The alloy furnace is more complex: it will put an arriving item in either input slot, preferring to stack it with existing items of the same type. It doesn't matter which slot each of the alloy furnace's inputs is in, so it doesn't matter that there's no direct control over that, but there is a risk that supplying a lot of one item type through tubes will result in both slots containing the same type of item, leaving no room for the second input.

The MV machines can be given a tube upgrade to make them automatically eject output items into pneumatic tubes. The items are always ejected through a side, though which side it is depends on the machine's orientation, due to a bug. Output items are always ejected singly. For some machines, such as the grinder, the ejection rate with a single tube upgrade doesn't keep up with the rate at which items can be processed. A second tube upgrade increases the ejection rate.

The LV and fuel-fired machines do not work with pneumatic tubes, except that the fuel-fired furnace (actually part of the basic Stonecraft game) can accept inputs from tubes. Items arriving through the bottom of the furnace go into the fuel slot, and items arriving from all other directions go into the input slot.

### Music player

The music player is an LV powered machine that plays audio recordings. It offers a selection of up to nine tracks. Technic doesn't include specific music tracks for this purpose; they have to be installed separately.

The music player gives the impression that the music is being played in the Stonecraft world. The music only plays as long as the music player is in place and is receiving electrical power, and the choice of music is controlled by interaction with the machine. The sound also appears to emanate specifically from the music player: the ability to hear it depends on the player's distance from the music player. However, the game engine doesn't currently support any other positional cues for sound, such as attenuation, panning, or HRTF. The impression of the sound being located in the Stonecraft world is also compromised by the subjective nature of track choice: the specific music that is played to a player depends on what media the player has installed.

### CNC machine

The CNC machine is an LV powered machine that cuts building blocks into a variety of sub-block shapes that are not covered by the crafting recipes of the stairs mod and its variants. Most of the target shapes are not rectilinear, involving diagonal or curved surfaces.

Only certain kinds of building material can be processed in the CNC machine.

### Tool workshop

The tool workshop is an MV powered machine that repairs mechanically-worn tools, such as pickaxes and the other ordinary digging tools. It has a single slot for a tool to be repaired, and gradually repairs the tool while it is powered. For any single tool, equal amounts of tool wear, resulting from equal amounts of tool use, take equal amounts of repair effort. Also, all repairable tools currently take equal effort to repair equal percentages of wear. The amount of tool use enabled by equal amounts of repair therefore depends on the tool type.

The mechanical wear that the tool workshop repairs is always indicated in inventory displays by a colored bar overlaid on the tool image. The bar can be seen to fill and change color as the tool workshop operates, eventually disappearing when the repair is complete. However, not every item that shows such a wear bar is using it to show mechanical wear. A wear bar can also be used to indicate charging of a power tool with stored electrical energy, or filling of a container, or potentially for all sorts of other uses. The tool workshop won't affect items that use wear bars to indicate anything other than mechanical wear.

The tool workshop has upgrade slots. Energy upgrades reduce its power consumption.

It can work with pneumatic tubes. Tools to be repaired are accepted via tubes from any direction. With a tube upgrade, the tool workshop will also eject fully-repaired tools via one side, the choice of side depending on the machine's orientation, as for processing machines. It is safe to put into the tool workshop a tool that is already fully repaired: assuming the presence of a tube upgrade, the tool will be quickly ejected. Furthermore, any item of unrepairable type will also be ejected as if fully repaired.

### Quarry

The quarry is an HV powered machine that automatically digs out a large area. The region that it digs out is a cuboid with a square horizontal cross section, located immediately behind the quarry machine. The quarry's action is slow and energy-intensive, but requires little player effort.

The size of the quarry's horizontal cross section is configurable through the machine's interaction form. A setting referred to as "radius" is an integer number of meters which can vary from 2 to 8 inclusive. The horizontal cross section is a square with side length of twice the radius plus one meter, thus varying from 5 to 17 inclusive. Vertically, the quarry always digs from 3 m above the machine to 100 m below it, inclusive, a total vertical height of 104 m.

Whatever the quarry digs up is ejected through the top of the machine, as if from a pneumatic tube. Normally a tube should be placed there to convey the material into a sorting system, processing machines, or at least chests. A chest may be placed directly above the machine to capture the output without sorting, but is liable to overflow.

If the quarry encounters something that cannot be dug, such as a liquid, a locked chest, or a protected area, it will skip past that and attempt to continue digging. However, anything remaining in the quarry area after the machine has attempted to dig there will prevent the machine from digging anything directly below it, all the way to the bottom of the quarry. An undiggable block therefore casts a shadow of undug blocks below it. If liquid is encountered, it is quite likely to flow across the entire cross section of the quarry, preventing all digging. The depth at which the quarry is currently attempting to dig is reported in its interaction form, and can be manually reset to the top of the quarry, which is useful to do if an undiggable obstruction has been manually removed.

The quarry consumes 10 kEU per block dug, which is quite a lot of energy. With most of what is dug being mere stone, it is usually not economically favorable to power a quarry from anything other than solar power. In particular, one cannot expect to power a quarry by burning the coal that it digs up.

Given sufficient power, the quarry digs at a rate of one block per second. This is rather tedious to wait for. Unfortunately, leaving the quarry unattended normally means that the Stonecraft server won't keep the machine running: it needs a player nearby. This can be resolved by using a world anchor. The digging is still quite slow, and independently of whether a world anchor is used the digging can be speeded up by placing multiple quarry machines with overlapping digging areas. Four can be placed to dig identical areas, one on each side of the square cross section.

### Forcefield emitter

The forcefield emitter is an HV powered machine that generates a forcefield remeniscent of those seen in many science-fiction stories.

The emitter can be configured to generate a forcefield of either spherical or cubical shape, in either case centered on the emitter. The size of the forcefield is configured using a radius parameter that is an integer number of meters which can vary from 5 to 20 inclusive. For a spherical forcefield this is simply the radius of the forcefield; for a cubical forcefield it is the distance from the emitter to the center of each square face.

The power drawn by the emitter is proportional to the surface area of the forcefield being generated. A spherical forcefield is therefore the cheapest way to enclose a specified volume of space with a forcefield, if the shape of the space doesn't matter. A cubical forcefield is less efficient at enclosing volume, but is cheaper than the larger spherical forcefield that would be required if it is necessary to enclose a cubical space.

The emitter is normally controlled merely through its interaction form, which has an enable/disable toggle. However, it can also (via the form) be placed in a mesecon-controlled mode. If mesecon control is enabled, the emitter must be receiving a mesecon signal in addition to being manually enabled, in order for it to generate the forcefield.

The forcefield itself behaves largely as if solid, despite being immaterial: it cannot be traversed, and prevents access to blocks behind it. It is transparent, but not totally invisible. It cannot be dug. Some effects can pass through it, however, such as the beam of a mining laser, and explosions. In fact, explosions as currently implemented by the tnt mod actually temporarily destroy the forcefield itself; the tnt mod assumes too much about the regularity of node types.

The forcefield occupies space that would otherwise have been air, but does not replace or otherwise interfere with materials that are solid, liquid, or otherwise not just air. If such an object blocking the forcefield is removed, the forcefield will quickly extend into the now-available space, but it does not do so instantly: there is a brief moment when the space is air and can be traversed.

It is possible to have a doorway in a forcefield, by placing in advance, in space that the forcefield would otherwise occupy, some non-air blocks that can be walked through. For example, a door suffices, and can be opened and closed while the forcefield is in place.

## Power generators

### Fuel-fired generators

The fuel-fired generators are electrical power generators that generate power by the combustion of fuel. Versions of them are available for all three voltages (LV, MV, and HV). These are all capable of burning any type of combustible fuel, such as coal. They are relatively easy to build, and so tend to be the first kind of generator used to power electrical machines. In this role they form an intermediate step between the directly fuel-fired machines and a more mature electrical network powered by means other than fuel combustion. They are also, by virtue of simplicity and controllability, a useful fallback or peak load generator for electrical networks that normally use more sophisticated generators.

The MV and HV fuel-fired generators can accept fuel via pneumatic tube, from any direction.

Keeping a fuel-fired generator fully fuelled is usually wasteful, because it will burn fuel as long as it has any, even if there is no demand for the electrical power that it generates. This is unlike the directly fuel-fired machines, which only burn fuel when they have work to do. To satisfy intermittent demand without waste, a fuel-fired generator must only be given fuel when there is either demand for the energy or at least sufficient battery capacity on the network to soak up the excess energy.

The higher-tier fuel-fired generators get much more energy out of a fuel item than the lower-tier ones. The difference is much more than is needed to overcome the inefficiency of supply converters, so it is worth operating fuel-fired generators at a higher tier than the machines being powered.

### Solar generators
The solar generators are electrical power generators that generate power from sunlight. Versions of them are available for all three voltages (LV, MV, and HV). There are four types in total, two LV and one each of MV and HV, forming a sequence of four tiers. The higher-tier ones are each built mainly from three solar generators of the next tier down, and their outputs scale in rough accordance, tripling at each tier.

To operate, an arrayed solar generator must be at elevation +1 or above and have a transparent block (typically air) immediately above it. It will generate power only when the block above is well lit during daylight hours. It will generate more power at higher elevation, reaching maximum output at elevation +36 or higher when sunlit. The small solar generator has similar rules with slightly different thresholds. These rules are an attempt to ensure that the generator will only operate from sunlight, but it is actually possible to fool them to some extent with light sources such as meselamps.

### Hydro generator

The hydro generator is an LV power generator that generates a respectable amount of power from the natural motion of water. To operate, the generator must be horizontally adjacent to flowing water. The power produced is dependent on how much flow there is across any or all four sides, the most flow of course coming from water that's flowing straight down.

### Geothermal generator

The geothermal generator is an LV power generator that generates a small amount of power from the temperature difference between lava and water. To operate, the generator must be horizontally adjacent to both lava and water. It doesn't matter whether the liquids consist of source blocks or flowing blocks.

Beware that if lava and water blocks are adjacent to each other then the lava will be solidified into stone or obsidian. If the lava adjacent to the generator is thus destroyed, the generator will stop producing power. Currently, in the default Stonecraft game, lava is destroyed even if it is only diagonally adjacent to water. Under these circumstances, the only way to operate the geothermal generator is with it adjacent to one lava block and one water block, which are on opposite sides of the generator. If diagonal adjacency doesn't destroy lava, such as with the gloopblocks mod, then it is possible to have more than one lava or water block adjacent to the geothermal generator. This increases the generator's output, with the maximum output achieved with two adjacent blocks of each liquid.

### Wind generator

The wind generator is an MV power generator that generates a moderate amount of energy from wind. To operate, the generator must be placed atop a column of at least 20 wind mill frame blocks, and must be at an elevation of +30 or higher. It generates more at higher elevation, reaching maximum output at elevation +50 or higher. Its surroundings don't otherwise matter; it doesn't actually need to be in open air.

### Nuclear generator

The nuclear generator (nuclear reactor) is an HV power generator that generates a large amount of energy from the controlled fission of uranium-235. It must be fuelled, with uranium fuel rods, but consumes the fuel quite slowly in relation to the rate at which it is likely to be mined. The operation of a nuclear reactor poses radiological hazards to which some thought must be given. Economically, the use of nuclear power requires a high capital investment, and a secure infrastructure, but rewards the investment well.

Nuclear fuel is made from uranium. Natural uranium doesn't have a sufficiently high proportion of U-235, so it must first be enriched via centrifuge. Producing one unit of 3.5%-fissile uranium requires the input of five units of 0.7%-fissile (natural) uranium, and produces four units of 0.0%-fissile (fully depleted) uranium as a byproduct. It takes five ingots of 3.5%-fissile uranium to make each fuel rod, and six rods to fuel a reactor. It thus takes the input of the equivalent of 150 ingots of natural uranium, which can be obtained from the mining of 75 blocks of uranium ore, to make a full set of reactor fuel.

The nuclear reactor is a large multi-block structure. Only one block in the structure, the reactor core, is of a type that is truly specific to the reactor; the rest of the structure consists of blocks that have mainly non-nuclear uses. The reactor core is where all the generator-specific action happens: it is where the fuel rods are inserted, and where the power cable must connect to draw off the generated power.

The reactor structure consists of concentric layers, each a cubical shell, around the core. Immediately around the core is a layer of water, representing the reactor coolant; water blocks may be either source blocks or flowing blocks. Around that is a layer of stainless steel blocks, representing the reactor pressure vessel, and around that a layer of blast-resistant concrete blocks, representing a containment structure. It is customary, though no longer mandatory, to surround this with a layer of ordinary concrete blocks. The mandatory reactor structure makes a 7×7×7 cube, and the full customary structure a 9×9×9 cube.

The layers surrounding the core don't have to be absolutely complete. Indeed, if they were complete, it would be impossible to cable the core to a power network. The cable makes it necessary to have at least one block missing from each surrounding layer. The water layer is only permitted to have one water block missing of the 26 possible. The steel layer may have up to two blocks missing of the 98 possible, and the blast-resistant concrete layer may have up to two blocks missing of the 218 possible. Thus it is possible to have not only a cable duct, but also a separate inspection hole through the solid layers. The separate inspection hole is of limited use: the cable duct can serve double duty.

Once running, the reactor core is significantly radioactive. The layers of reactor structure provide quite a lot of shielding, but not enough to make the reactor safe to be around, in two respects. Firstly, the shortest possible path from the core to a player outside the reactor is sufficiently short, and has sufficiently little shielding material, that it will damage the player. This only affects a player who is extremely close to the reactor, and close to a face rather than a vertex. The customary additional layer of ordinary concrete around the reactor adds sufficient distance and shielding to negate this risk, but it can also be addressed by just keeping extra distance (a little over two meters of air).

The second radiological hazard of a running reactor arises from shine paths; that is, specific paths from the core that lack sufficient shielding. The necessary cable duct, if straight, forms a perfect shine path, because the cable itself has no radiation shielding effect. Any secondary inspection hole also makes a shine path, along which the only shielding material is the water of the reactor coolant. The shine path aspect of the cable duct can be ameliorated by adding a kink in the cable, but this still yields paths with reduced shielding. Ultimately, shine paths must be managed either with specific shielding outside the mandatory structure, or with additional no-go areas.

The radioactivity of an operating reactor core makes starting up a reactor hazardous, and can come as a surprise because the non-operating core isn't radioactive at all. The radioactive damage is survivable, but it is normally preferable to avoid it by some care around the startup sequence. To start up, the reactor must have a full set of fuel inserted, have all the mandatory structure around it, and be cabled to a switching station. Only the fuel insertion requires direct access to the core, so irradiation of the player can be avoided by making one of the other two criteria be the last one satisfied. Completing the cabling to a switching station is the easiest to do from a safe distance.

Once running, the reactor will generate 100 kEU/s for a week (168 hours, 604800 seconds), a total of 6.048 GEU from one set of fuel. After the week is up, it will stop generating and no longer be radioactive. It can then be refuelled to run for another week. It is not really intended to be possible to pause a running reactor, but actually disconnecting it from a switching station will have the effect of pausing the week. This will probably change in the future. A paused reactor is still radioactive, just not generating electrical power.

A running reactor can't be safely dismantled, and not only because dismantling the reactor implies removing the shielding that makes it safe to be close to the core. The mandatory parts of the reactor structure are not just mandatory in order to start the reactor; they're mandatory in order to keep it intact. If the structure around the core gets damaged, and remains damaged, the core will eventually melt down. How long there is before meltdown depends on the extent of the damage; if only one mandatory block is missing, meltdown will follow in 100 seconds. While the structure of a running reactor is in a damaged state, heading towards meltdown, a siren built into the reactor core will sound. If the structure is rectified, the siren will signal all-clear. If the siren stops sounding without signalling all-clear, then it was stopped by meltdown.

If meltdown is imminent because of damaged reactor structure, digging the reactor core is not a way to avert it. Digging the core of a running reactor causes instant meltdown. The only way to dismantle a reactor without causing meltdown is to start by waiting for it to finish the week-long burning of its current set of fuel. Once a reactor is no longer operating, it can be dismantled by ordinary means, with no special risks.

Meltdown, if it occurs, destroys the reactor and poses a major environmental hazard. The reactor core melts, becoming a hot, highly radioactive liquid known as "corium". A single meltdown yields a single corium source block, where the core used to be. Corium flows, and the flowing corium is very destructive to whatever it comes into contact with. Flowing corium also randomly solidifies into a radioactive solid called "Chernobylite". The random solidification and random destruction of solid blocks means that the flow of corium is constantly changing. This combined with the severe radioactivity makes corium much more challenging to deal with than lava. If a meltdown is left to its own devices, it gets worse over time, as the corium works its way through the reactor structure and starts to flow over a variety of paths. It is best to tackle a meltdown quickly; the priority is to extinguish the corium source block, normally by dropping gravel into it. Only the most motivated should attempt to pick up the corium in a bucket.

### Administrative world anchor

A world anchor is an object in the Stonecraft world that causes the server to keep surrounding parts of the world running even when no players are nearby. It is mainly used to allow machines to run unattended: normally machines are suspended when not near a player. Technic supplies a form of world anchor, as a placable block, but it is not straightforwardly available to players. There is no recipe for it, so it is only available if explicitly spawned into existence by someone with administrative privileges. In a single-player world, the single player normally has administrative privileges, and can obtain a world anchor by entering the chat command "/give singleplayer technic:admin_anchor".

The world anchor tries to force a cubical area, centered upon the anchor, to stay loaded. The distance from the anchor to the most distant map nodes that it will keep loaded is referred to as the "radius", and can be set in the world anchor's interaction form. The radius can be set as low as 0, meaning that the anchor only tries to keep itself loaded, or as high as 255, meaning that it will operate on a 511×511×511 cube. Larger radii are forbidden, to avoid typos causing the server excessive work; to keep a larger area loaded, use multiple anchors. Also use multiple anchors if the area to be kept loaded is not well approximated by a cube.

The world is always kept loaded in units of 16×16×16 cubes, confusingly known as "map blocks". The anchor's configured radius takes no account of map block boundaries, but the anchor's effect is actually to keep loaded each map block that contains any part of the configured cube. The anchor's interaction form includes a status note showing how many map blocks this is, and how many of those it is successfully keeping loaded. When the anchor is disabled, as it is upon placement, it will always show that it is keeping no map blocks loaded; this does not indicate any kind of failure.

The world anchor can optionally be locked. When it is locked, only the anchor's owner, the player who placed it, can reconfigure it or remove it. Only the owner can lock it. Locking an anchor is useful if the use of anchors is being tightly controlled by administrators: an administrator can set up a locked anchor and be sure that it will not be set by ordinary players to an unapproved configuration.

The server limits the ability of world anchors to keep parts of the world loaded, to avoid overloading the server. The total number of map blocks that can be kept loaded in this way is set by the server configuration item "max_forceloaded_blocks" (in stonecraft.conf), which defaults to only 16. For comparison, each player normally keeps 125 map blocks loaded (a radius of 32). If an enabled world anchor shows that it is failing to keep all the map blocks loaded that it would like to, this can be fixed by increasing max_forceloaded_blocks by the amount of the shortfall.

The tight limit on force-loading is the reason why the world anchor is not directly available to players. With the limit so low both by default and in common practice, the only feasible way to determine where world anchors should be used is for administrators to decide it directly.

## Other machines

Some machines in Technic can not be classified as producers or consumers.

This is a list of this machines:

* Switching station 
* LV Battery Box 
* MV Battery Box 
* HV Battery Box 
* Constructor 
* Deployer 
* Node Breaker 
* Supply Converter 

### Switching Station

The Switching station is the most important part of any network, since without a switching station, no machine will operate!

### LV/MV/HV Battery Box

These peculiar machines can both generate *and* consume, depending on what's needed. Do note that higher tier machines will charge tools faster!

### Supply Converter

The Supply Converter can convert one voltage to the next highest or lowest. It will pull a load of 10,000 EU, but will waste it if the other side is unable to accept it. The top is the input voltage, and the bottom is the output. Both sides will require their own switching station!

## Resources

Technic provides additional resources for building these machines.

### Ore

Technic makes extensive use of not just the default ores but also some that are added by mods. You will need to mine for all the ore types in the course of the game. Each ore type is found at a specific range of elevations, and while the ranges mostly overlap, some have non-overlapping ranges, so you will ultimately need to mine at more than one elevation to find all the ores. Also, because one of the best elevations to mine at is very deep, you will be unable to mine there early in the game.

Elevation is measured in meters, relative to a reference plane that is not quite sea level. (The standard sea level is at an elevation of about +1.4.) Positive elevations are above the reference plane and negative elevations below. Because elevations are always described this way round, greater numbers when higher, we avoid the word "depth".

The ores that matter in Technic are coal, iron, copper, tin, zinc, chromium, uranium, silver, gold, mithril, mese, and diamond.

Coal is found from elevation +64 downwards, so is available right on the surface at the start of the game, but it is far less abundant above elevation 0 than below. It is initially used as a fuel, driving important machines in the early part of the game. It becomes less important as a fuel once most of your machines are electrically powered, but burning fuel remains a way to generate electrical power. Coal is also used, usually in dust form, as an ingredient in alloying recipes, wherever elemental carbon is required.

Iron is found from elevation +2 downwards, and its abundance increases in stages as one descends, reaching its maximum from elevation -64 downwards. It is a common metal, used frequently as a structural component. In Technic, unlike the basic game, iron is used in multiple forms, mainly alloys based on iron and including carbon (coal).

Copper is found from elevation -16 downwards, but is more abundant from elevation -64 downwards. It is a common metal, used either on its own for its electrical conductivity, or as the base component of alloys. Although common, it is very heavily used, and most of the time it will be the material that most limits your activity.

Tin is found from elevation +8 downwards, with no elevation-dependent variations in abundance beyond that point.
It is a common metal. Its main use in pure form is as a component of electrical batteries. Apart from that its main purpose is as the secondary ingredient in bronze (the base being copper), but bronze is itself little used. Its abundance is well in excess of its usage, so you will usually have a surplus of it.

Zinc is supplied by Technic. It is found from elevation +2 downwards, with no elevation-dependent variations in abundance beyond that point. It is a common metal. Its main use is as the secondary ingredient in brass (the base being copper), but brass is itself little used. Its abundance is well in excess of its usage, so you will usually have a surplus of it.

Chromium is supplied by Technic. It is found from elevation -100 downwards, with no elevation-dependent variations in abundance beyond that point. It is a moderately common metal. Its main use is as the secondary ingredient in stainless steel (the base being iron).

Uranium is supplied by Technic. It is found only from elevation -80 down to -300; using it therefore requires one to mine above elevation -300 even though deeper mining is otherwise more productive. It is a moderately common metal, useful only for reasons related to radioactivity: it forms the fuel for nuclear reactors, and is also one of the best radiation shielding materials available. It is not difficult to find enough uranium ore to satisfy these uses. Beware that the ore is slightly radioactive: it will slightly harm you if you stand as close as possible to it. It is safe when more than a meter away or when mined.

Silver is found from elevation -2 downwards, with no elevation-dependent variations in abundance beyond that point. It is a semi-precious metal. It is little used, being most notably used in electrical items due to its conductivity, being the best conductor of all the pure elements.

Gold is found from elevation -64 downwards, but is more abundant from elevation -256 downwards. It is a precious metal. It is little used, being most notably used in electrical items due to its combination of good conductivity (third best of all the pure elements) and corrosion resistance.

Mithril is found from elevation -512 downwards, the deepest ceiling of any minable substance, with no elevation-dependent variations in abundance beyond that point. It is a rare precious metal, and unlike all the other metals described here it is entirely fictional, being derived from J. R. R. Tolkien's Middle-Earth setting. It is little used.

Mese is found from elevation -64 downwards. The ore is more abundant from elevation -256 downwards, and from elevation -1024 downwards there are also occasional blocks of solid mese (each yielding as much mese as nine blocks of ore). It is a precious gemstone, and unlike diamond it is entirely fictional. It is used in many recipes, though mainly not in large quantities, wherever some magical quality needs to be imparted.

Diamond is found from elevation -128 downwards, but is more abundant from elevation -256 downwards. It is a precious gemstone. It is used moderately, mainly for reasons connected to its extreme hardness.

### Rock

In addition to the ores, there are multiple kinds of rock that need to be mined in their own right, rather than for minerals. The rock types that matter in Technic are standard stone, desert stone, marble, and granite.

Standard stone is extremely common. As in the basic game, when dug it yields cobblestone, which can be cooked to turn it back into standard stone. Cobblestone is used in recipes only for some relatively primitive machines. Standard stone is used in a couple of machine recipes. These rock types gain additional significance with Technic because the grinder can be used to turn them into dirt and sand. This, especially when combined with an automated cobblestone generator, can be an easier way to acquire sand than collecting it where it occurs naturally.

Desert stone is found specifically in desert biomes, and only from elevation +2 upwards. Although it is easily accessible, therefore, its quantity is ultimately quite limited. It is used in a few recipes.

Marble is supplied by Technic. It is found in dense clusters from elevation -50 downwards. It has mainly decorative use, but also appears in one machine recipe.

Granite is supplied by Technic. It is found in dense clusters from elevation -150 downwards. It is much harder to dig than standard stone, so impedes mining when it is encountered. It has mainly decorative use, but also appears in a couple of machine recipes.

### Rubber

Rubber is a biologically-derived material that has industrial uses due to its electrical resistivity and its impermeability. In Technic, it is used in a few recipes, and it must be acquired by tapping rubber trees.

If you have 'More trees' enabled, the rubber trees you need are those defined by that mod. If not, Technic supplies a copy of the 'More trees' rubber tree.

Extracting rubber requires a specific tool, a tree tap. Using the tree tap (by left-clicking) on a rubber tree trunk block extracts a lump of raw latex from the trunk. Each trunk block can be repeatedly tapped for latex, at intervals of several minutes; its appearance changes to show whether it is currently ripe for tapping. Each tree has several trunk blocks, so several latex lumps can be extracted from a tree in one visit.

Raw latex isn't used directly. It must be vulcanized to produce finished rubber. This can be performed by alloying the latex with coal dust.

### Metal

Many of the substances important in Technic are metals, and there is a common pattern in how metals are handled. Generally, each metal can exist in five forms: ore, lump, dust, ingot, and block. With a couple of tricky exceptions in mods outside Technic, metals are only used in dust, ingot, and block forms. Metals can be readily converted between these three forms, but can't be converted from them back to ore or lump forms.

As in the basic Stonecraft game, a "lump" of metal is acquired directly by digging ore, and will then be processed into some other form for use. A lump is thus more akin to ore than to refined metal. (In real life, metal ore rarely yields lumps ("nuggets") of pure metal directly. More often the desired metal is chemically bound into the rock as an oxide or some other compound, and the ore must be chemically processed to yield pure metal.)

Not all metals occur directly as ore. Generally, elemental metals (those consisting of a single chemical element) occur as ore, and alloys (those consisting of a mixture of multiple elements) do not. In fact, if the fictional mithril is taken to be elemental, this pattern is currently followed perfectly. (It is not clear in the Middle-Earth setting whether mithril is elemental or an alloy.) This might change in the future: in real life some alloys do occur as ore, and some elemental metals rarely occur naturally outside such alloys. Metals that do not occur as ore also lack the "lump" form.

The basic Stonecraft game offers a single way to refine metals: cook a lump in a furnace to produce an ingot. With Technic this refinement method still exists, but is rarely used outside the early part of the game, because Technic offers a more efficient method once some machines have been built. The grinder, available only in electrically-powered forms, can grind a metal lump into two piles of metal dust. Each dust pile can then be cooked into an ingot, yielding two ingots from one lump. This doubling of material value means that you should only cook a lump directly when you have no choice, mainly early in the game when you haven't yet built a grinder.

An ingot can also be ground back to (one pile of) dust. Thus it is always possible to convert metal between ingot and dust forms, at the expense of some energy consumption. Nine ingots of a metal can be crafted into a block, which can be used for building. The block can also be crafted back to nine ingots. Thus it is possible to freely convert metal between ingot and block forms, which is convenient to store the metal compactly. Every metal has dust, ingot, and block forms.

Alloying recipes in which a metal is the base ingredient, to produce a metal alloy, always come in two forms, using the metal either as dust or as an ingot. If the secondary ingredient is also a metal, it must be supplied in the same form as the base ingredient. The output alloy is also returned in the same form. For example, brass can be produced by alloying two copper ingots with one zinc ingot to make three brass ingots, or by alloying two piles of copper dust with one pile of zinc dust to make three piles of brass dust. The two ways of alloying produce equivalent results.

### Iron and its alloys

Iron forms several important alloys. In real-life history, iron was the second metal to be used as the base component of deliberately-constructed alloys (the first was copper), and it was the first metal whose working required processes of any metallurgical sophistication. The game mechanics around iron broadly imitate the historical progression of processes around it, rather than the less-varied modern processes.

The two-component alloying system of iron with carbon is of huge importance, both in the game and in real life. The basic Stonecraft game doesn't distinguish between these pure iron and these alloys at all, but Technic introduces a distinction based on the carbon content, and renames some items of the basic game accordingly.

The iron/carbon spectrum is represented in the game by three metal substances: wrought iron, carbon steel, and cast iron. Wrought iron has low carbon content (less than 0.25%), resists shattering, and is easily welded, but is relatively soft and susceptible to rusting. In real-life history it was used for rails, gates, chains, wire, pipes, fasteners, and other purposes. Cast iron has high carbon content (2.1% to 4%), is especially hard, and resists corrosion, but is relatively brittle, and difficult to work. Historically it was used to build large structures such as bridges, and for cannons, cookware, and engine cylinders. Carbon steel has medium carbon content (0.25% to 2.1%), and intermediate properties: moderately hard and also tough, somewhat resistant to corrosion. In real life it is now used for most of the purposes previously satisfied by wrought iron and many of those of cast iron, but has historically been especially important for its use in swords, armor, skyscrapers, large bridges, and machines.

In real-life history, the first form of iron to be refined was wrought iron, which is nearly pure iron, having low carbon content. It was produced from ore by a low-temperature furnace process (the "bloomery") in which the ore/iron remains solid and impurities (slag) are progressively removed by hammering ("working", hence "wrought"). This began in the middle East, around 1800 BCE.

Historically, the next forms of iron to be refined were those of high carbon content. This was the result of the development of a more sophisticated kind of furnace, the blast furnace, capable of reaching higher temperatures. The real advantage of the blast furnace is that it melts the metal, allowing it to be cast straight into a shape supplied by a mould, rather than having to be gradually beaten into the desired shape. A side effect of the blast furnace is that carbon from the furnace's fuel is unavoidably incorporated into the metal. Normally iron is processed twice through the blast furnace: once producing "pig iron", which has very high carbon content and lots of impurities but lower melting point, casting it into rough ingots, then remelting the pig iron and casting it into the final moulds. The result is called "cast iron". Pig iron was first produced in China around 1200 BCE, and cast iron later in the 5th century BCE. Incidentally, the Chinese did not have the bloomery process, so this was their first iron refining process, and, unlike the rest of the world, their first wrought iron was made from pig iron rather than directly from ore.

Carbon steel, with intermediate carbon content, was developed much later, in Europe in the 17th century CE. It required a more sophisticated process, because the blast furnace made it extremely difficult to achieve a controlled carbon content. Tweaks of the blast furnace would sometimes produce an intermediate carbon content by luck, but the first processes to reliably produce steel were based on removing almost all the carbon from pig iron and then explicitly mixing a controlled amount of carbon back in.

In the game, the bloomery process is represented by ordinary cooking or grinding of an iron lump. The lump represents unprocessed ore, and is identified only as "iron", not specifically as wrought iron. This standard refining process produces dust or an ingot which is specifically identified as wrought iron. Thus the standard refining process produces the (nearly) pure metal.

Cast iron is trickier. You might expect from the real-life notes above that cooking an iron lump (representing ore) would produce pig iron that can then be cooked again to produce cast iron. This is kind of the case, but not exactly, because as already noted cooking an iron lump produces wrought iron. The game doesn't distinguish between low-temperature and high-temperature cooking processes: the same furnace is used not just to cast all kinds of metal but also to cook food. So there is no distinction between cooking processes to produce distinct wrought iron and pig iron. But repeated cooking is available as a game mechanic, and is indeed used to produce cast iron: re-cooking a wrought iron ingot produces a cast iron ingot. So pig iron isn't represented in the game as a distinct item; instead wrought iron stands in for pig iron in addition to its realistic uses as wrought iron.

Carbon steel is produced by a more regular in-game process: alloying wrought iron with coal dust (which is essentially carbon). This bears a fair resemblance to the historical development of carbon steel. This alloying recipe is relatively time-consuming for the amount of material processed, when compared against other alloying recipes, and carbon steel is heavily used, so it is wise to alloy it in advance, when you're not waiting for it.

There are additional recipes that permit all three of these types of iron to be converted into each other. Alloying carbon steel again with coal dust produces cast iron, with its higher carbon content. Cooking carbon steel or cast iron produces wrought iron, in an abbreviated form of the bloomery process.

There's one more iron alloy in the game: stainless steel. It is managed in a completely regular manner, created by alloying carbon steel with chromium.

### Uranium enrichment

When uranium is to be used to fuel a nuclear reactor, it is not sufficient to merely isolate and refine uranium metal. It is necessary to control its isotopic composition, because the different isotopes behave differently in nuclear processes.

The main isotopes of interest are U-235 and U-238. U-235 is good at sustaining a nuclear chain reaction, because when a U-235 nucleus is bombarded with a neutron it will usually fission (split) into fragments. It is therefore described as "fissile". U-238, on the other hand, is not fissile: if bombarded with a neutron it will usually capture it, becoming U-239, which is very unstable and quickly decays into semi-stable (and fissile) plutonium-239.

Inconveniently, the fissile U-235 makes up only about 0.7% of natural uranium, almost all of the other 99.3% being U-238. Natural uranium therefore doesn't make a great nuclear fuel. (In real life there are a small number of reactor types that can use it, but Technic doesn't have such a reactor.) Better nuclear fuel needs to contain a higher proportion of U-235.

Achieving a higher U-235 content isn't as simple as separating the U-235 from the U-238 and just using the required amount of U-235. Because U-235 and U-238 are both uranium, and therefore chemically identical, they cannot be chemically separated, in the way that different elements are separated from each other when refining metal. They do differ in atomic mass, so they can be separated by centrifuging, but because their atomic masses are very close, centrifuging doesn't separate them very well. They cannot be separated completely, but it is possible to produce uranium that has the isotopes mixed in different proportions. Uranium with a significantly larger fissile U-235 fraction than natural uranium is called "enriched", and that with a significantly lower fissile fraction is called "depleted".

A single pass through a centrifuge produces two output streams, one with a fractionally higher fissile proportion than the input, and one with a fractionally lower fissile proportion. To alter the fissile proportion by a significant amount, these output streams must be centrifuged again, repeatedly. The usual arrangement is a "cascade", a linear arrangement of many centrifuges. Each centrifuge takes as input uranium with some specific fissile proportion, and passes its two output streams to the two adjacent centrifuges. Natural uranium is input somewhere in the middle of the cascade, and the two ends of the cascade produce properly enriched and depleted uranium.

Fuel for Technic's nuclear reactor consists of enriched uranium of which 3.5% is fissile. (This is a typical value for a real-life light water reactor, a common type for power generation.) To enrich uranium in the game, it must first be in dust form: the centrifuge will not operate on ingots. (In real life uranium enrichment is done with the uranium in the form of a gas.) It is best to grind uranium lumps directly to dust, rather than cook them to ingots first, because this yields twice as much metal dust. When uranium is in refined form (dust, ingot, or block), the name of the inventory item indicates its fissile proportion. Uranium of any available fissile proportion can be put through all the usual processes for metal.

A single centrifuge operation takes two uranium dust piles, and produces as output one dust pile with a fissile proportion 0.1% higher and one with a fissile proportion 0.1% lower. Uranium can be enriched up to the 3.5% required for nuclear fuel, and depleted down to 0.0%. Thus a cascade covering the full range of fissile fractions requires 34 cascade stages. (In real life, enriching to 3.5% uses thousands of cascade stages. Also, centrifuging is less effective when the input isotope ratio is more skewed, so the steps in fissile proportion are smaller for relatively depleted uranium. Zero fissile content is only asymptotically approachable, and natural uranium relatively cheap, so uranium is normally only depleted to around 0.3%. On the other hand, much higher enrichment than 3.5% isn't much more difficult than enriching that far.)

Although centrifuges can be used manually, it is not feasible to perform uranium enrichment by hand. It is a practical necessity to set up an automated cascade, using pneumatic tubes to transfer uranium dust piles between centrifuges. Because both outputs from a centrifuge are ejected into the same tube, sorting tubes are needed to send the outputs in different directions along the cascade. It is possible to send items into the centrifuges through the same tubes that take the outputs, so the simplest version of the cascade structure has a line of 34 centrifuges linked by a line of 34 sorting tube segments.

Assuming that the cascade depletes uranium all the way to 0.0%, producing one unit of 3.5%-fissile uranium requires the input of five units of 0.7%-fissile (natural) uranium, takes 490 centrifuge operations, and produces four units of 0.0%-fissile (fully depleted) uranium as a byproduct. It is possible to reduce the number of required centrifuge operations by using more natural uranium input and outputting only partially depleted uranium, but (unlike in real life) this isn't usually an economical approach. The 490 operations are not spread equally over the cascade stages: the busiest stage is the one taking 0.7%-fissile uranium, which performs 28 of the 490 operations. The least busy is the one taking 3.4%-fissile uranium, which performs 1 of the 490 operations.

A centrifuge cascade will consume quite a lot of energy. It is worth putting a battery upgrade in each centrifuge. (Only one can be accommodated, because a control logic unit upgrade is also required for tube operation.) An MV centrifuge, the only type presently available, draws 7 kEU/s in this state, and takes 5 s for each uranium centrifuging operation. It thus takes 35 kEU per operation, and the cascade requires 17.15 MEU to produce each unit of enriched uranium. It takes five units of enriched uranium to make each fuel rod, and six rods to fuel a reactor, so the enrichment cascade requires 514.5 MEU to process a full set of reactor fuel. This is about 0.85% of the 6.048 GEU that the reactor will generate from that fuel.

If there is enough power available, and enough natural uranium input, to keep the cascade running continuously, and exactly one centrifuge at each stage, then the overall speed of the cascade is determined by the busiest stage, the 0.7% stage. It can perform its 28 operations towards the enrichment of a single uranium unit in 140 s, so that is the overall cycle time of the cascade. It thus takes 70 min to enrich a full set of reactor fuel. While the cascade is running at this full speed, its average power consumption is 122.5 kEU/s. The instantaneous power consumption varies from second to second over the 140 s cycle, and the maximum possible instantaneous power consumption (with all 34 centrifuges active simultaneously) is 238 kEU/s. It is recommended to have some battery boxes to smooth out these variations.

If the power supplied to the centrifuge cascade averages less than 122.5 kEU/s, then the cascade can't run continuously. (Also, if the power supply is intermittent, such as solar, then continuous operation requires more battery boxes to smooth out the supply variations, even if the average power is high enough.) Because it's automated and doesn't require continuous player attention, having the cascade run at less than full speed shouldn't be a major problem. The enrichment work will consume the same energy overall regardless of how quickly it's performed, and the speed will vary in direct proportion to the average power supply (minus any supply lost because battery boxes filled completely).

If there is insufficient power to run both the centrifuge cascade at full speed and whatever other machines require power, all machines on the same power network as the centrifuge will be forced to run at the same fractional speed. This can be inconvenient, especially if use of the other machines is less automated than the centrifuge cascade. It can be avoided by putting the centrifuge cascade on a separate power network from other machines, and limiting the proportion of the generated power that goes to it.

If there is sufficient power and it is desired to enrich uranium faster than a single cascade can, the process can be speeded up more economically than by building an entire second cascade. Because the stages of the cascade do different proportions of the work, it is possible to add a second and subsequent centrifuges to only the busiest stages, and have the less busy stages still keep up with only a single centrifuge each.

Another possible approach to uranium enrichment is to have no fixed assignment of fissile proportions to centrifuges, dynamically putting whatever uranium is available into whichever centrifuges are available. Theoretically all of the centrifuges can be kept almost totally busy all the time, making more efficient use of capital resources, and the number of centrifuges used can be as little (down to one) or as large as desired. The difficult part is that it is not sufficient to put each uranium dust pile individually into whatever centrifuge is available: they must be input in matched pairs. Any odd dust pile in a centrifuge will not be processed and will prevent that centrifuge from accepting any other input.

### Concrete

Concrete is a synthetic building material. Technic implements it in the game.

Two forms of concrete are available as building blocks: ordinary "concrete" and more advanced "blast-resistant concrete". Despite its name, the latter has no special resistance to explosions or to any other means of destruction.

Concrete can also be used to make fences. They act just like wooden fences, but aren't flammable. Confusingly, the item that corresponds to a wooden "fence" is called "concrete post". Posts placed adjacently will implicitly create fence between them. Fencing also appears between a post and adjacent concrete block.

### Latex ![](/doc/wiki-images/technic_raw_latex.png)

Latex is used for manufacturing rubber, which is heavily used for the medium- and high-voltage components within Technic. Latex can be harvested directly from rubber trees (look for the pale green/seafoam leaves) using the tree tap like any other tool. Rubber trees regenerate their latex supplies after about a day.

## Industrial processes

### Alloying

In Technic, alloying is a way of combining items to create other items, distinct from standard crafting. Alloying always uses inputs of exactly two distinct types, and produces a single output. Like cooking, which takes a single input, it is performed using a powered machine, known generically as an "alloy furnace". An alloy furnace always has two input slots, and it doesn't matter which way round the two ingredients are placed in the slots. Many alloying recipes require one or both slots to contain a stack of more than one of the ingredient item: the quantity required of each ingredient is part of the recipe.

As with the furnaces used for cooking, there are multiple kinds of alloy furnace, powered in different ways. The most-used alloy furnaces are electrically powered. There is also an alloy furnace that is powered by directly burning fuel, just like the basic cooking furnace. Building almost any electrical machine, including the electrically-powered alloy furnaces, requires a machine casing component, one ingredient of which is brass, an alloy. It is therefore necessary to use the fuel-fired alloy furnace in the early part of the game, on the way to building electrical machinery.

Alloying recipes are mainly concerned with metals. These recipes combine a base metal with some other element, most often another metal, to produce a new metal. This is discussed in the section on metal. There are also a few alloying recipes in which the base ingredient is non-metallic, such as the recipe for the silicon wafer.

### Grinding, extracting, and compressing

Grinding, extracting, and compressing are three distinct, but very similar, ways of converting one item into another. They are all quite similar to the cooking found in the basic Stonecraft game. Each uses an input consisting of a single item type, and produces a single output. They are all performed using powered machines, respectively known generically as a "grinder", "extractor", and "compressor". Some compressing recipes require the input to be a stack of more than one of the input item: the quantity required is part of the recipe. Grinding and extracting recipes never require such a stacked input.

There are multiple kinds of grinder, extractor, and compressor. Unlike cooking furnaces and alloy furnaces, there are none that directly burn fuel; they are all electrically powered.

Grinding recipes always produce some kind of dust, loosely speaking, as output. The most important grinding recipes are concerned with metals: every metal lump or ingot can be ground into metal dust. Coal can also be ground into dust, and burning the dust as fuel produces much more energy than burning the original coal lump. There are a few other grinding recipes that make block types from the basic Stonecraft game more interconvertible: standard stone can be ground to standard sand, desert stone to desert sand, cobblestone to gravel, and gravel to dirt.

Extracting is a miscellaneous category, used for a small group of processes that just don't fit nicely anywhere else. (Its name is notably vaguer than those of the other kinds of processing.) It is used for recipes that produce dye, mainly from flowers. (However, for those recipes using flowers, the basic Stonecraft game provides parallel crafting recipes that are easier to use and produce more dye, and those recipes are not suppressed by Technic.) Its main use is to generate rubber from raw latex, which it does three times as efficiently as merely cooking the latex. Extracting was also formerly used for uranium enrichment for use as nuclear fuel, but this use has been superseded by a new enrichment system using the centrifuge.

Compressing recipes are mainly used to produce a few relatively advanced artificial item types, such as the copper and carbon plates used in advanced machine recipes. There are also a couple of compressing recipes making natural block types more interconvertible.

### Centrifuging

Centrifuging is another way of using a machine to convert items. Centrifuging takes an input of a single item type, and produces outputs of two distinct types. The input may be required to be a stack of more than one of the input item: the quantity required is part of the recipe. Centrifuging is only performed by a single machine type, the MV (electrically-powered) centrifuge.

Currently, centrifuging recipes don't appear in the unified_inventory craft guide, because unified_inventory can't yet handle recipes with multiple outputs.

Generally, centrifuging separates the input item into constituent substances, but it can only work when the input is reasonably fluid, and in marginal cases it is quite destructive to item structure. (In real life, centrifuges require their input to be mainly fluid, that is either liquid or gas. Few items in the game are described as liquid or gas, so the concept of the centrifuge is stretched a bit to apply to finely-divided solids.)

The main use of centrifuging is in uranium enrichment, where it separates the isotopes of uranium dust that otherwise appears uniform. Enrichment is a necessary process before uranium can be used as nuclear fuel, and the radioactivity of uranium blocks is also affected by its isotopic composition.

A secondary use of centrifuging is to separate the components of metal alloys. This can only be done using the dust form of the alloy. It recovers both components of binary metal/metal alloys. It can't recover the carbon from steel or cast iron.

## Radioactivity

Technic adds radioactivity to the game, as a hazard that can harm player characters. Certain substances in the game are radioactive, and when placed as blocks in the game world will damage nearby players. Conversely, some substances attenuate radiation, and so can be used for shielding. The radioactivity system is based on reality, but is not an attempt at serious simulation: like the rest of the game, it has many simplifications and deliberate deviations from reality in the name of game balance.

In real life radiological hazards can be roughly divided into three categories based on the time scale over which they act: prompt radiation damage (such as radiation burns) that takes effect immediately; radiation poisoning that becomes visible in hours and lasts weeks; and cumulative effects such as increased cancer risk that operate over decades. The game's version of radioactivity causes only prompt damage, not any delayed effects. Damage comes in the abstracted form of removing the player's hit points, and is immediately visible to the player. As with all other kinds of damage in the game, the player can restore the hit points by eating food items. High-nutrition foods, such as the pie baskets supplied, are a useful tool in dealing with radiological hazards.

Only a small range of items in the game are radioactive. From Technic, the only radioactive items are uranium ore, refined uranium blocks, nuclear reactor cores (when operating), and the materials released when a nuclear reactor melts down. Other mods can plug into the Technic system to make their own block types radioactive. Radioactive items are harmless when held in inventories. They only cause radiation damage when placed as blocks in the game world.

The rate at which damage is caused by a radioactive block depends on the distance between the source and the player. Distance matters because the damaging radiation is emitted equally in all directions by the source, so with distance it spreads out, so less of it will strike a target of any specific size. The amount of radiation absorbed by a target thus varies in proportion to the inverse square of the distance from the source. The game imitates this aspect of real-life radioactivity, but with some simplifications. While in real life the inverse square law is only really valid for sources and targets that are small relative to the distance between them, in the game it is applied even when the source and target are large and close together. Specifically, the distance is measured from the center of the radioactive block to the abdomen of the player character. For extremely close encounters, such as where the player swims in a radioactive liquid, there is an enforced lower limit on the effective distance.

Different types of radioactive block emit different amounts of radiation. The least radioactive of the radioactive block types is uranium ore, which causes 0.25 HP/s damage to a player 1 m away. A block of refined but unenriched uranium, as an example, is nine times as radioactive, and so will cause 2.25 HP/s damage to a player 1 m away. By the inverse square law, the damage caused by that uranium block reduces by a factor of four at twice the distance, that is to 0.5625 HP/s at a distance of 2 m, or by a factor of nine at three times the distance, that is to 0.25 HP/s at a distance of 3 m. Other radioactive block types are far more radioactive than these: the most radioactive of all, the result of a nuclear reactor melting down, is 1024 times as radioactive as uranium ore.

Uranium blocks are radioactive to varying degrees depending on their isotopic composition. An isotope being fissile, and thus good as reactor fuel, is essentially uncorrelated with it being radioactive. The fissile U-235 is about six times as radioactive than the non-fissile U-238 that makes up the bulk of natural uranium, so one might expect that enriching from 0.7% fissile to 3.5% fissile (or depleting to 0.0%) would only change the radioactivity of uranium by a few percent. But actually the radioactivity of enriched uranium is dominated by the non-fissile U-234, which makes up only about 50 parts per million of natural uranium but is about 19000 times more radioactive than U-238. The radioactivity of natural uranium comes just about half from U-238 and half from U-234, and the uranium gets enriched in U-234 along with the U-235. This makes 3.5%-fissile uranium about three times as radioactive as natural uranium, and 0.0%-fissile uranium about half as radioactive as natural uranium.

Radiation is attenuated by the shielding effect of material along the path between the radioactive block and the player. In general, only blocks of homogeneous material contribute to the shielding effect: for example, a block of solid metal has a shielding effect, but a machine does not, even though the machine's ingredients include a metal case. The shielding effect of each block type is based on the real-life resistance of the material to ionising radiation, but for game balance the effectiveness of shielding is scaled down from real life, more so for stronger shield materials than for weaker ones. Also, whereas in real life materials have different shielding effects against different types of radiation, the game only has one type of damaging radiation, and so only one set of shielding values.

Almost any solid or liquid homogeneous material has some shielding value. At the low end of the scale, 5 meters of wooden planks nearly halves radiation, though in that case the planks probably contribute more to safety by forcing the player to stay 5 m further away from the source than by actual attenuation. Dirt halves radiation in 2.4 m, and stone in 1.7 m. When a shield must be deliberately constructed, the preferred materials are metals, the denser the better. Iron and steel halve radiation in 1.1 m, copper in 1.0 m, and silver in 0.95 m. Lead would halve in 0.69 m (its in-game shielding value is 80). Gold halves radiation in 0.53 m (factor of 3.7 per meter), but is a bit scarce to use for this purpose. Uranium halves radiation in 0.31 m (factor of 9.4 per meter), but is itself radioactive. The very best shielding in the game is nyancat material (nyancats and their rainbow blocks), which halves radiation in 0.22 m (factor of 24 per meter), but is extremely scarce. See technic/technic/radiation.lua for the in-game shielding values, which are different from real-life values.

If the theoretical radiation damage from a particular source is sufficiently small, due to distance and shielding, then no damage at all will actually occur. This means that for any particular radiation source and shielding arrangement there is a safe distance to which a player can approach without harm. The safe distance is where the radiation damage would theoretically be 0.25 HP/s. This damage threshold is applied separately for each radiation source, so to be safe in a multi-source situation it is only necessary to be safe from each source individually.

The best way to use uranium as shielding is in a two-layer structure, of uranium and some non-radioactive material. The uranium layer should be nearer to the primary radiation source and the non-radioactive layer nearer to the player. The uranium provides a great deal of shielding against the primary source, and the other material shields against the uranium layer. Due to the damage threshold mechanism, a meter of dirt is sufficient to shield fully against a layer of fully-depleted (0.0%-fissile) uranium. Obviously this is only worthwhile when the primary radiation source is more radioactive than a uranium block.

When constructing permanent radiation shielding, it is necessary to pay attention to the geometry of the structure, and particularly to any holes that have to be made in the shielding, for example to accommodate power cables. Any hole that is aligned with the radiation source makes a "shine path" through which a player may be irradiated when also aligned. Shine paths can be avoided by using bent paths for cables, passing through unaligned holes in multiple shield layers. If the desired shielding effect depends on multiple layers, a hole in one layer still produces a partial shine path, along which the shielding is reduced, so the positioning of holes in each layer must still be considered. Tricky shine paths can also be addressed by just keeping players out of the dangerous area.

## Electrical power

Most machines in Technic are electrically powered. To operate them it is necessary to construct an electrical power network. The network links together power generators and power-consuming machines, connecting them using power cables.

There are three tiers of electrical networking: low voltage (LV), medium voltage (MV), and high voltage (HV). Each network must operate at a single voltage, and most electrical items are specific to a single voltage. Generally, the machines of higher tiers are more powerful, but consume more energy and are more expensive to build, than machines of lower tiers. It is normal to build networks of all three tiers, in ascending order as one progresses through the game, but it is not strictly necessary to do this. Building HV equipment requires some parts that can only be manufactured using electrical machines, either LV or MV, so it is not possible to build an HV network first, but it is possible to skip either LV or MV on the way to HV.

Each voltage has its own cable type, with distinctive insulation. Cable segments connect to each other and to compatible machines automatically. Incompatible electrical items don't connect. All non-cable electrical items must be connected via cable: they don't connect directly to each other. Most electrical items can connect to cables in any direction, but there are a couple of important exceptions noted below.

To be useful, an electrical network must connect at least one power generator to at least one power-consuming machine. In addition to these items, the network must have a "switching station" in order to operate: no energy will flow without one. Unlike most electrical items, the switching station is not voltage-specific: the same item will manage a network of any tier. However, also unlike most electrical items, it is picky about the direction in which it is connected to the cable: the cable must be directly below the switching station.

Hovering over a network's switching station will show the aggregate energy supply and demand, which is useful for troubleshooting. Electrical energy is measured in "EU", and power (energy flow) in EU per second (EU/s). Energy is shifted around a network instantaneously once per second.

In a simple network with only generators and consumers, if total demand exceeds total supply then no energy will flow, the machines will do nothing, and the generators' output will be lost. To handle this situation, it is recommended to add a battery box to the network. A battery box will store generated energy, and when enough has been stored to run the consumers for one second it will deliver it to the consumers, letting them run part-time. It also stores spare energy when supply exceeds demand, to let consumers run full-time when their demand occasionally peaks above the supply. More battery boxes can be added to cope with larger periods of mismatched supply and demand, such as those resulting from using solar generators (which only produce energy in the daytime).

When there are electrical networks of multiple tiers, it can be appealing to generate energy on one tier and transfer it to another. The most direct way to do this is with the "supply converter", which can be directly wired into two networks. It is another tier-independent item, and also particular about the direction of cable connections: it must have the cable of one network directly above, and the cable of another network directly below. The supply converter demands 10000 EU/s from the network above, and when this network gives it power it supplies 9000 EU/s to the network below. Thus it is only 90% efficient, unlike most of the electrical system which is 100% efficient in moving energy around. To transfer more than 10000 EU/s between networks, connect multiple supply converters in parallel.

## Chests

Technic, if activated, replaces the basic Stonecraft's single type of chest with a range of chests that have different sizes and features. The chest types are identified by the materials from which they are made; the better chests are made from more exotic materials. The chest types form a linear sequence, each being (with one exception noted below) strictly more powerful than the preceding one. The sequence begins with the wooden chest from the basic game, and each later chest type is built by upgrading a chest of the preceding type. The chest types are:

* ![](/doc/wiki-images/technic_iron_chest_front.png) Iron chest, 9x10 slots
* ![](/doc/wiki-images/technic_copper_chest_front.png) Copper chest, 10x10 slots
* ![](/doc/wiki-images/technic_silver_chest_front.png) Silver chest, 11x10 slots. Can also be named.
* ![](/doc/wiki-images/technic_gold_chest_front.png) Gold chest, 12x10 slots. Can be named and given a unique color.
* ![](/doc/wiki-images/technic_mithril_chest_front.png) Mithril chest, 13x10 slots. **Note:** The mithril chest is not implemented yet, but when implemented will allow for connecting chests around the world to a shared network.

The iron and later chests have the ability to sort their contents, when commanded by a button in their interaction forms. Item types are sorted in the same order used in the unified_inventory craft guide. The copper and later chests also have an auto-sorting facility that can be enabled from the interaction form. An auto-sorting chest automatically sorts its contents whenever a player closes the chest. The contents will then usually be in a sorted state when the chest is opened, but may not be if pneumatic tubes have operated on the chest while it was closed, or if two players have the chest open simultaneously.

The silver and gold chests, but not the mithril chest, have a built-in sign-like capability. They can be given a textual label, which will be visible when hovering over the chest. The gold chest, but again not the mithril chest, can be further labelled with a colored patch that is visible from a moderate distance.

The mithril chest is currently an exception to the upgrading system. It has only as many inventory slots as the preceding (gold) type, and has fewer of the features. It has no feature that other chests don't have: it is strictly weaker than the gold chest. It is planned that in the future it will acquire some unique features, but for now the only reason to use it is aesthetic.

The size of the largest chests is dictated by the maximum size of interaction form that the game engine can successfully display. If in the future the engine becomes capable of handling larger forms, by scaling them to fit the screen, the sequence of chest sizes will likely be revised.

As with the chest of the basic Stonecraft game, each chest type comes in both locked and unlocked flavors. All of the chests work with the pneumatic tubes of 'Pipeworks'.

## Tools

Tools in Technic fall into two categories: manual and electric. Both sets of tools are unstackable in the inventory. They have limited durability that is reduced during use (they disappear after they hit 0 durability). Manual tools can be regenerated by using the Tool Workshop, so that valuable tools, such as mese or diamond tools can be preserved. Electric tools require charging in Battery Boxes (of any voltage) and will not be destroyed when they reach 0 charge. Higher levels of electric tools are more powerful and contain more charge so they work longer.

### Chainsaw ![](/doc/wiki-images/technic_chainsaw.png)

This electric tool speeds up harvesting of wood by allowing the harvesting of an entire tree in a single click. Just click on any part of a tree, and the wood and leaves of that tree at that point and above will be cut and dropped on the ground as blocks. It has enough charge to cut down about 5 trees before running out of power.

**Note:** If you can't find the drops from using the chainsaw, dig around as they can be buried under neighbouring terrain blocks.

### Flashlight ![](/doc/wiki-images/technic_flashlight.png)

This electric tool illumates the area in front of the player. While it is electric, and so requires charging, to use it one only needs to equip it. Punching with this tool does nothing.

### Lava can ![](/doc/wiki-images/technic_lava_can.png)

The lava can works similarly to the bucket tool and the water can, but instead of carrying water, it can carry lava source blocks (the ones that aren't animated), up to 8 at a time. To use, simply equip and click on lava source blocks (they will highlight in black). Then clicking anywhere where there isn't a lava source block will place them again.

**Warning:** Be careful where you place these source blocks! Since you're placing lava source blocks, lava will flow out of them and may trap or burn you depending on where you are.

### Mining drill ![](/doc/wiki-images/technic_mining_drill.png) ![](/doc/wiki-images/technic_mining_drill_mk2.png) ![](/doc/wiki-images/technic_mining_drill_mk3.png)

This electric tool operates similarly to a pickaxe, though every block takes exactly one click to drill out. While the Mining Laser allows for faster collection of bulk minerals, it's cutting path can sometimes be undesirable, and the mining drill is useful in these instances.

The higher levels of the mining drill allow for drilling more blocks at once, substantially reducing mining time. At mark-2, the mining drill can drill 3 blocks at once, either 3-deep, 3-wide, or 3-tall. At mark-3, the mining drill can drill 9-blocks at once in a 3x3 layout around the block selected. Switching between these modes can be done by shift-clicking.

**Advice:** Since these tools require substantially more diamonds than the mining laser, and yet drills slower, it is suggested that a mining laser be built first.

### Mining laser ![](/doc/wiki-images/technic_mining_laser_mk1.png) ![](/doc/wiki-images/technic_mining_laser_mk2.png) ![](/doc/wiki-images/technic_mining_laser_mk3.png)

This electric tool is a substantial upgrade above the pickaxe that you start mining with. The laser works by drilling directly forward 7 blocks making a path that's roughly 1-block in diameter. The laser is electric, requiring charging in a battery box (any voltage). As soon as an LV electrical system is set up, this is a great next step.

### Sonic screwdriver ![](/doc/wiki-images/technic_sonic_screwdriver.png)

This electric tool is used for rotating nodes, much like the default Screwdriver tool, but loses charge instead of durability. This is useful for any nodes which have a "front" direction, like stairs, machines, furniture, etc. Nodes are rotated around the Y-axes (vertical).

### Tree tap ![](/doc/wiki-images/technic_tree_tap.png)

This manual tool allows for harvesting latex from rubber trees. Extracting latex can be done by hitting rubber trees with it yields for 1 latex. The rubber tree will regenerate its latex supply over the course of a day.

### Water can ![](/doc/wiki-images/technic_water_can.png)

The water can works similarly to the normal bucket tool, but it can hold 16 `water_source` (the water blocks that don't look like they're flowing) blocks instead of 1. To use, simply equip the water can and click on water source blocks (they will highlight in black). Then clicking anywhere where there isn't a `water_source` block with the water can equipped will place them.

**Warning:** Be careful where you place these source blocks! Since you're placing water source blocks, water will flow out of them and may trap or drown you depending on where you are.

### Wrench ![](/doc/wiki-images/technic_wrench.png)

The manual tool allows for moving blocks which contain an inventory, like chests. A shift-right-click on a machine/chest will immediately add it to the inventory.

## Digilines

You can control some machines with the digilines.

### Switching Station

There are two ways getting information from the switching station:

1. Give it a mesecon signal (eg. with a lever) and it will send always when the supply or demand changes. 
2. Send to the switching station `"get"` or `"GET"` and it will send back. 

The sent message is always a table containing the supply and demand.

### Supply Converter

You can send the following to it:

* `"get"`: It will send back a table containing the fields `"enabled"`, `"power"` and `"mesecon_mode"` which are all integers. 
* `"off"`: Deactivate the supply converter. 
* `"on"`: Activate the supply converter. 
* `"toggle"`: Activate or deactivate the supply converter depending on its current state. 
* `"power "..power`: Set the amount of the power, it shall convert. 
* `"mesecon_mode "..<int>`: Set the mesecon mode. 

### Battery Boxes

Send to it `"get"` or `"GET"` and it will send a table back containing:

* `demand`: A number. 
* `supply`: A number. 
* `input`: A number. 
* `charge`: A number. 
* `max_charge`: A number. 
* `src`: Itemstack made to table. 
* `dst`: Itemstack made to table. 
* `upgrade1`: Itemstack made to table. 
* `upgrade2`: Itemstack made to table. 

### Forcefield Emitter

You should send a table to it containing the `command` and for some commands the `value` field.
Some strings will automatically be made to tables:

* `"get"` :arrow_right: `{command = "get"}` 
* `"off"` :arrow_right: `{command = "off"}` 
* `"on"` :arrow_right: `{command = "on"}` 
* `"toggle"` :arrow_right: `{command = "toggle"}` 
* `"range "..range` :arrow_right: `{command = "range", value = range}` 
* `"shape "..shape` :arrow_right: `{command = "shape", value = shape}` 

The commands:

* `"get"`: The forcefield emitter sends back a table containing: 
	* `"enabled"`: `0` is off, `1` is on. 
	* `"range"` 
	* `"shape"`: `0` is spheric, `1` is cubic. 
* `"off"`: Deactivate the forcefield emitter. 
* `"on"`: Activate the forcefield emitter. 
* `"toggle"`: Activate or deactivate the forcefield emitter depending on its current state. 
* `"range"`: Set the range to `value`. 
* `"shape"`: `value` can be a number (`0` or `1`) or a string (`"sphere"` or `"cube"`). 

### Nuclear Reactor Remote Control

Since the nuclear reactor core can't be accessed by digiline wire because the water layer which mustn't have a hole, you need the digiline_remote to control it.
You should send a table to it containing at least the `command` field and for some commands other fields.
Some strings will automatically be made to tables:

* `"get"` :arrow_right: `{command = "get"}` 
* `"self_destruct "..time` :arrow_right: `{command = "self_destruct", timer = time}` 
* `"start"` :arrow_right: `{command = "start"}` 

The commands:

* `"get"`: The nuclear reactor sends back a table containing: 
	* `"burn_time"`: The time in seconds how long the reactor already runs. One week after start, when it reaches 7 * 24 * 60 * 60 (=604800), the fuel is completely used. 
	* `"enabled"`: A bool. 
	* `"siren"`: A bool. 
	* `"structure_accumulated_badness"` 
	* `"rods"`: A table with 6 numbers in it, one for each fuel slot. 
		*  A positive value is the count of fuel rods in the slot. 
		* `0` means the slot is empty. 
		*  A negative value means some other items are in the slot. The absolute value is the count of these items. 
* `"self_destruct"`: A setting has to be enabled to use this. The reactor will melt down after `timer` seconds or instantly. 
* `"start"`: Tries to start the reactor, `"Start successful"` is sent back on success, `"Error"` if something is wrong. 

If the automatic start is enabled, it will always send `"fuel used"` when it uses fuel.

## Reactors

### Nuclear Reactor

If no amount of solar power is enough to sate your hunger for power, why not give reactors a try? Utilising the latest micro-fission technology, you can produce up to 100,000 EU per second!

#### Setup

The standard reactor structure consists of a 9x9x9 cube.

For the reactor to operate and not melt down, it insists on the inner 7x7x7 portion (from the core out to the blast-resistant concrete) being intact. Intactness only depends on the number of nodes of the right type in each layer. The water layer must have water in all but at most one node; the lead and blast-resistant concrete layers must have the right material in all but at most two nodes. The permitted gaps are meant for the cable and man-hole, but can actually be anywhere and contain anything. For the reactor to be useful, a cable must connect to the core, but it can go in any direction. The outer concrete layer of the standard structure is not required for the reactor to operate.

#### Step-by-Step Construction

First we build the first layer consisting of 9x9 concrete blocks. If you don't want use concrete for your reactor, you can start with 7x7 blast-resistant concrete blocks.

![](/doc/wiki-images/Nuclear_Reactor_1.png)

Now we have to build a 7x7 layer consisting of blast-resistant concrete blocks. The outer reactor consists of normale concrete blocks.

![](/doc/wiki-images/Nuclear_Reactor_2.png)

The next inner layer consists of 5x5 lead blocks.

![](/doc/wiki-images/Nuclear_Reactor_3.png)

We fill the bottom of the lead layer with water nodes.

![](/doc/wiki-images/Nuclear_Reactor_4.png)

Now we build the next layer of lead, blast-resistant concrete blocks and normal concrete blocks. It's time to place some HV cable and the reactor core.

![](/doc/wiki-images/Nuclear_Reactor_5.png)

We place a new layer of of lead blocks, blast-resistant concrete blocks and normal concrete blocks and fill it with water nodes.

![](/doc/wiki-images/Nuclear_Reactor_6.png)

Now we can close the lead layer, the permitted gap in the middle is for our man-hole to reach our reactor core.

![](/doc/wiki-images/Nuclear_Reactor_7.png)

In the next stept we use again blast-resistant concrete blocks and normal concrete blocks.

![](/doc/wiki-images/Nuclear_Reactor_8.png)

Last but not least we build a layer of 9x9 concrete blocks. The reactor structure is now complete.

![](/doc/wiki-images/Nuclear_Reactor_9.png)

Now it's time to connect a switching station to our HV cable.

![](/doc/wiki-images/Nuclear_Reactor_10.png)

Through the man-hole we can reach the reactor core.

![](/doc/wiki-images/Nuclear_Reactor_11.png)

We fill the slots with uranium fuel and press the 'Start' button. If we did everything right, the reactor would have to be operational.

![](/doc/wiki-images/Nuclear_Reactor_12.png)

Yes! You can see we have an energy output of 10kEU!

![](/doc/wiki-images/Nuclear_Reactor_13.png)


## Geothermal EU generator

Using hot lava and water this device can create energy from steam

The machine is only producing LV EUs and can thus not drive more advanced equipment

The output is a little more than the coal burning generator (max 300EUs)

## Solar array

The solar array is an assembly of panels into a powerful array

The assembly can deliver more energy than the individual panel because of the transformer unit which converts the panel output variations into a stable supply.

Solar arrays are not able to store large amounts of energy.

The LV arrays are used to make medium voltage arrays.


## Solar Panel

Solar panels are the building blocks of LV solar arrays

They can however also be used separately but with reduced efficiency due to the missing transformer.

Individual panels are less efficient than when the panels are combined into full arrays.

## Watermill

A water mill produces LV EUs by exploiting flowing water across it

It is a LV EU supplyer and fairly low yield (max 120EUs)

It is a little under half as good as the thermal generator.

# Pipeworks

## Description

Pipeworks is used for crafting and usage of pipes and tubes. In addition to providing pipes for transporting liquids and tubes for transporting items, it also contains a number of devices for working with them. Here's what it looks like:

![](/doc/wiki-images/Pipeworks.png)

Mesecons is recommended as well for the best possible experience.

Crafting recipes noted here apply only for plain Pipeworks. If Technic is installed (yes it is in Stonecraft), Pipeworks items use alternate recipes. See the Technic documentation for more details.

### Fluid transport

![](/doc/wiki-images/FluidTransport.png)

#### Pipes

Pipes are round, flanged devices that can transport liquids around - by default, only water. They automatically connect to other pipes and devices that are pipe-compatible, such as valves, flow sensors, pumps and spigots.

Pipes transport liquids at a speed of one meter (node) per second - a run of 30 pipes will take 30 seconds to transport liquid from one end to another.

Digging a pipe carrying liquid drops the empty pipe - the liquid inside is lost.

Pipes "light up" when they contain liquid.

Here's how you craft it:

![](/doc/wiki-images/CraftPipe.png)

#### Straight-only pipes

![](/doc/wiki-images/StraightPipes.png)

In some cases, you may need to run several pipes in parallel, in a confined space.  If you tried to use normal pipes for this purpose, they'd just all connect to one another, which you likely didn't want.  To deal with this, use straight-only pipes.  Aside from only connecting at their ends, their main distinguishing mark is the gray line running the length of the pipe (i.e. a "straight" line).

Here's how you craft it:

![](/doc/wiki-images/CraftStraightPipe.png)

#### Spigots

Spigots output the liquid input via pipe into the world.

Spigots only connect from one side.

Connecting a spigot to a pipe carrying water makes water flow out of the bottom of the spigot.

![](/doc/wiki-images/CraftSpigot.png)

#### Pumps

Pumps can be placed inside or over a water source. They are toggled on and off with a right-click, or you can directly control them via Mesecons.

Pumps can be connected to pipes from above. Pipes do not connect to pumps from the side or bottom.

Here's how you craft it:

![](/doc/wiki-images/CraftPump.png)

#### Valves

Valves control fluid flow. When active, valves allow liquids to flow through them. Otherwise, liquids cannot flow through them. They are toggled on and off with a right-click, or can be directly controlled using Mesecons.

Here's how you craft it:

![](/doc/wiki-images/CraftValve.png)

#### Storage Tanks

Note: currently not working (does not store any liquid).
Storage tanks store liquid in a compact way. Placing multiple storage tanks on top of each other forms one large tank with the same capacity as all the single tanks added together.

Storage tanks can be connected to pipes from above or below. Pipes do not connect to storage tanks from the side.

Here's how you craft it:

![](/doc/wiki-images/CraftStorageTank.png)

#### Gratings

Gratings are decorative items that appear similar to fine metal grids used as barriers.

Here's how you craft it:

![](/doc/wiki-images/CraftGrating.png)

#### Sealed/Airtight Pipe Entries

Sealed/airtight pipe entries act as pipes do, except they fill a full block and therefore are generally used for aesthetic purposes, such as running piping through walls.

Sealed/airtight pipe entries can be connected to pipes from the sides, the top, or the bottom.

Here's how you craft it:

![](/doc/wiki-images/CraftPipeEntry.png)

#### Flow Sensors

Flow sensors output a Mesecons signal when liquid is present in it, and otherwise does not. They can be used to determine when liquid has reached a particular point.

Here's how you craft it:

![](/doc/wiki-images/CraftFlowSensor.png)

### Item Transport

![](/doc/wiki-images/ItemTransport.png)

#### Base materials/items

The various tubes seen below are made from plastic sheeting, which is a three-step process to make and is an essential part of pipeworks.  First, craft some leaves (anything in the "leaves" group) to get oil:

![](/doc/wiki-images/craft-oil.png)

Then cook that into paraffin:

![](/doc/wiki-images/oil-to-paraffin.png)

Finally, cook the paraffin into plastic:

![](/doc/wiki-images/paraffin-to-plastic.png)

A couple of objects in pipeworks require one or more gears. Craft those with steel ingots and stone, like so:

![](/doc/wiki-images/CraftGear.png)

#### Tubes

Tubes are boxy, transparent devices that can transport items around. They can automatically connect to other tubes and devices that are tube-compatible, such as chests and injectors. Certain devices may connect to tubes only from certain sides.

Breaking a tube carrying items simply drops the items onto the ground.

Here's how you craft it:

![](/doc/wiki-images/CraftTube.png)

#### Chests

Ordinary chests found in the default game connect to tubes from every side except the front.

Items can be added to chests using tube-related devices, or removed from them using filters/injectors.

Attempting to add items to a full chest results in the item being dropped onto the ground.

Locked Chests

Locked chests from the default game connect to tubes and recieve items as ordinary chests do, but items cannot be removed from locked chests with filters/injectors.

#### Furnaces

Ordinary furnaces found in the default game connect to tubes from every side except the front.

![](/doc/wiki-images/Furnaces.png)

Fuel items can be added to furnaces from the bottom, and items to be smelted can be added from the back. Smelted items can be removed from them using filters/injectors.

Attempting to add items to a full furnace results in the item being dropped onto the ground.

#### Filters/Injectors

Filters/injectors take items from the node behind them and sends them out in front. They only connect to tubes from the front.

Filters/injectors act only when punched, or when activated via a Mesecons signal.

Right clicking a filter/injector brings up an inventory. If items are added to the inventory, only items matching them will be taken from the node behind it when activated. Items that match the first slot on the filter/injector's inventory are always chosen before items in the second slot, which are always chosen before the third slot, etc.

Filters/injectors cannot be dug if they contain any items in their inventory.

Here's how you craft it:

![](/doc/wiki-images/CraftFilter.png)

#### Mese Filters/Injectors

Mese filters/injectors take entire stacks of items from the node behind them and sends them out in front all at once.

Mese filters/injectors act only when punched, or when activated via a Mesecons signal.

Right clicking a mese filter/injector brings up an inventory. If items are added to the inventory, only stacks of items matching them will be taken from the node behind it when activated. Stacks of items that match the first slot on the mese filter/injector's inventory are always chosen before stacks of items in the second slot, which are always chosen before the third slot, etc.

Mese filters/injectors cannot be dug if they contain any items in their inventory.

Here's how you craft it:

![](/doc/wiki-images/CraftMeseFilter.png)

#### Mese Sorting Tubes

Mese sorting tubes are special tubes that can be used to sort items or force them to move in a certain direction at junctions.

![](/doc/wiki-images/SortingTube.png)

When placed, each direction the tube has a connection to has a distinct color.

Right clicking the tube brings up a form similar to the following:

![](/doc/wiki-images/MeseSortingTubeForm.png)

Each row is associated with the color on the left side.

The far right contains an on/off switch for each row.

When "on", only items that match those in the row associated with the color are allowed to move in that direction. If there are no items in the row, all items are allowed.

When "off", no items will exit through that direction.

If the tube needs to route items directly into a node with an inventory (such as a chest) and that inventory is full, the sorting tube will try one of its other "on" (e.g. enabled) outputs, at that point routing the item as if the sorting tube were just a normal, ordinary tube.  Note that the direction the item cam from may be the first option the item takes.  If that happens, turn that direction "off".  If all connected and otherwise-suitable outputs are "off" and the tube can't route the item, it pops out onto the ground.

When you place an item in these slots, you're placing ghosts only.  That is, only a copy of your item is placed and your inventory remains unchanged.  When you remove an item from these slots, it's simply deleted.

Here's how you craft it:

![](/doc/wiki-images/CraftMeseTube1.png)

Or alternatively:

![](/doc/wiki-images/CraftMeseTube2.png)

#### Detector Tubes

Detector tubes are special tubes that output a Mesecons signal when an item passes through them.

![](/doc/wiki-images/DetectorTube.png)

The tubes turn off again when the item leaves.

Here's how you craft it:

![](/doc/wiki-images/CraftDetectorTube.png)

#### Lua controlled Tubes

The lua controlled tube can be programmed like a lua controller.  
But instead of A, B, C and D, it has the ports blue, red, yellow, green, black and white.  
Also there's an additional event that is called when an item comes through the tube. Return in this event the port, the item shall exit (eg. `return "blue"`). If a wrong value or nothing is returned, the item will go back to where it came from. The `event` table looks like this:
```lua
{
	type = "item",
	pin = {name = <src dir>},
	itemstring = <itemstring>,
	item = <itemstack made to table>,
	velocity = <velocity of the tubed item>,
}
```
You can craft lua controlled tubes with a luacontroller and a sorting tube.

#### Accelerator Tubes

Accelerator tubes are special tubes that transport items significantly faster than normal tubes. They appear similar to normal tubes, except with a greenish-blue tint.

![](/doc/wiki-images/AcceleratorTube.png)

Here's how you craft it:

![](/doc/wiki-images/CraftAcceleratorTube.png)

#### Teleporter Tubes

Teleporter tubes are special tubes that move items to other teleporter tubes, regardless of the distance separating them.

![](/doc/wiki-images/TeleporterTube.png)

Putting items into the tube via tube-related devices causes them to be teleported.

Right clicking a teleporter tube brings up a form allowing entry of a channel string, similar to the following:

![](/doc/wiki-images/TeleporterTubeForm.png)

Only teleporter tubes that have the same channel will be linked together and allow items to pass through.

The switch on the right enables or disables the tube's receiving capability.  When "on", the tube can receive items. Otherwise, items can only be teleported out of the tube, but not into it.

Teleporter tubes with channel names beginning with the name of a player, followed by a colon, are settable only by the specified player. This is useful for making private teleporter tube channels.

Teleporter tubes with channel names beginning with the name of a player, followed by a semicolon, are usable only by the specified player, or by other players if the tube is not "On" (unable to receive items). This allows for mail-like systems where items can be sent into private dropboxes, but can't be taken out except by the recipient.

If an item enters a teleporter tube, and there are multiple possible teleporter tubes that it can go to, a target is chosen at random from the possibilities.

Here's how you craft it:

![](/doc/wiki-images/CraftTeleporterTube.png)

#### Autocrafters

Autocrafters are devices that can automatically follow craft recipes to make new items.

![](/doc/wiki-images/Autocrafter.png)

Right clicking an autocrafter brings up a form similar to the following:

![](/doc/wiki-images/AutocrafterForm.png)

The slots in the top left of the form represent a crafting grid, where items can be arranged in the pattern of a craft recipe. Like the Mese sorting tube, items placed in these slots are ghosts, i.e. copies of what you placed.  Removing an item simply deletes it.

In the middle is a single slot that shows the result of the proposed recipe, same as in your Inventory display.  You can also directly place an item here and the autocrafter will make a guess and fill its recipe slots with the items that should be used to make that item.  Removing the item from this slot deletes it and clears the recipe grid.

Below that is a switch to enable/disable the autocrafter.  Default is disabled.

The slots in the top right of the form are the output from the crafting operations.  That is, items that have been crafted can be found here. These can also be retrieved from the device using filters/injectors.

The slots in the middle of the form, below the craft recipe and result slots, are the autocrafter's internal inventory.  Items added by the user or fed in by tubes are stored here temporarily until the autocrafter can use them.

The slots at the bottom of the form are the player's inventory, as usual.

When sufficient materials are present in the autocrafter's inventory to craft according to its recipe, the device automatically starts crafting them until it runs out of materials.

Here's how you build it:

![](/doc/wiki-images/CraftAutocrafter.png)

#### Deployers

Deployers are devices that place blocks as a player would if one were standing at the exact location of the deployer. They connect to tubes only from the back side.

Deployers act only when activated via a Mesecons signal.  On receipt of a signal, they place the next item in their inventory, and if there's something in the way of the deployer's output, that object gets pushed aside first.

![](/doc/wiki-images/Deployer.png)

Right clicking a deployer brings up a form similar to the following:

![](/doc/wiki-images/DeployerForm.png)

The slots in the top of the form are the deployer's inventory, storing materials that are placed when the deployer activates. They are taken in order from left to right, top to bottom. New items can be added here using tube-related devices.

The slots at the bottom of the form are the player's inventory.

Upon activation, a deployer places a node from its inventory into the space directly adjacent to its front side if and only if the space is air. The front side is the face that is fully orange.

Here's how you craft it:

![](/doc/wiki-images/CraftDeployer.png)

#### Node Breakers

Node breakers are devices that dig blocks as a player would if one were standing at the exact location of the node breaker and dug the target node.  They connect to tubes only from the back side.

Node breakers act only when activated via a Mesecons signal.

![](/doc/wiki-images/NodeBreaker.png)

Upon activation, a node breaker digs the node in the space directly adjacent to its front side if and only if the node is non-liquid, diggable, and not air or unloaded. The front side is the face with the "mouth" with thin interleaved lines resembling a shredder.

When you right-click on it, you get a form similar to the following:

![](/doc/wiki-images/NodeBreaker-form.png)

The single slot at the top is for you to add in a custom digging tool.  By default, the nodebreaker digs "by hand", but you could for example put a pick, shovel, tree tap, or whatever else you want here as long as it's a viable tool.

Here's how you craft it:

![](/doc/wiki-images/CraftNodeBreaker.png)

Note: in the past, one used a mese pick to construct a nodebreaker, which it also used as its default tool.  This is no longer the case.  Old nodebreakers that had nothing in the tool slot will automatically be populated with a mese pick.

#### Sand Vacuum Tubes

Sand tubes are special tubes that vacuum up free items around them. When an item drops near the sand tube, it is sucked up and sent along the tube.

Sand tubes have an effective radius of 2 meters (nodes). Outside of this sphere, items are unaffected.

![](/doc/wiki-images/SandTube.png)

Here's how you craft it:

![](/doc/wiki-images/CraftSandTube.png)

#### Mese Sand Vacuum Tubes

Mese sand tubes pick up items like sand tubes, but they do so in a customizable cubic region rather than a fixed spherical one.

To change the range of a mese sand tube, change the distance specified in the form.

The number entered here can be anywhere from 0 (the default) to 8; it represents a sort of cubic radius from the tube, thus the default is to only pick up items within the tube's 1x1x1 node, but, if one entered "5", the tube would pick up items in an 11x11x11 cube.

![](/doc/wiki-images/MeseSandTubeForm.png)

Crafts are similar to the mese sorting tube:

![](/doc/wiki-images/CraftMeseSandTube1.png)

...or using mese crystal fragments and a regular sand tube:

![](/doc/wiki-images/CraftMeseSandTube2.png)

# Mesecons

## Mesecons Basic

So far we've already looked at a couple of machines, but not at Mesecons itself. That won't do! This is a usage guide for new Mesecon users, including those without Redstone experience.

![](/doc/wiki-images/Mesecons_Basics.png)

Let's look at exactly what Mesecons can do, and how you can use it.

Mesecons is a digital circuitry construction kit that allows players to create circuits that can do nearly anything.

Mesecons resembles real life circuitry in that you have wires that carry information around and various things that affect or are affected by them, but the basic similarities end there.

There are three basic types of things in Mesecons: wires, receptors, and effectors. We'll look at each one in detail below, but for now we'll go through a summary.

Wires conduct signals around, while receptors do the actual creating of those signals. Effectors do things based on those signals. Some things can act as both receptors and effectors, which is useful for doing things like modifying signals.

###	Wires

These are Mesecon wires:

![](/doc/wiki-images/Mesecons_Wires.png)

Left to right: normal wire, insulated wire, T-junction wire, corner wire, vertical wire, MESE block. Rear wires are on, front wires are off.

There are a lot of different wires that have distinct uses, but all of them perform essentially the same task. First of all, Mesecon wire has two states: on and off. The on state is generally brighter or more saturated in color than the off state. Wires are off when you place them down, but they can be turned on by being conducted to.

A Mesecon wire that is on (the wire is in the on state) will cause other wires and effectors adjacent to it to turn on as well, a process known as conduction. Which adjacent ones that turn on are determined by the specific type of wire.

In the pictures below, the black boxes denote where the wire conducts. Other locations are completely unaffected by whether it is on or off.

The normal wire conducts in the four cardinal directions, North-East-South-West, but not diagonally. Looking from the side, it conducts to nodes on the same level, or the level above and below it. However, it does not conduct directly above or below:

![](/doc/wiki-images/Mesecons_NormalWire.png)

The insulated wire, in contrast, conducts only at the ends. The direction is determined by the direction you are facing when you place the wire.

![](/doc/wiki-images/Mesecons_InsulatedWire.png)

The T-junction wire gets its name from the shape it forms and conducts in. The direction is determined by the direction you are facing when you place the wire.

![](/doc/wiki-images/Mesecons_TJunctionWire.png)

The corner wire conducts only at its ends as well, but they are perpendicular to each other. The direction is determined by the direction you are facing when you place the wire.

![](/doc/wiki-images/Mesecons_CornerWire.png)

The vertical wire has caps on each end that conduct only in the cardinal directions on the same vertical level as well as directly above or below. The thin parts without caps only conduct directly above or below. Vertical wires can be stacked on top of each other, and only the top and bottom ones will be capped.

![](/doc/wiki-images/Mesecons_VerticalWire.png)

The MESE block is extended by Mesecons to conduct in the cardinal directions as well as directly above and below.

![](/doc/wiki-images/Mesecons_MESEBlock.png)

Two wires will only conduct between each other if they are adjacent and both conduct to the location of the other:

![](/doc/wiki-images/Mesecons_Rules.png)

###	Receptors

Wires are nice and all, but how do we turn them on if the only way to make one come on is to have something that is already on beside it? That's where receptors come in. Receptors are, in short, things that are not wires, but can also be on and off. Receptors can do things like turning on and off depending on whether there is light, when a player interacts with them, or a lot of things, really. There are far too many types of receptors to describe here, but we'll cover the most important ones.

Power plants are simply always on - they will power anything in the same positions as normal Mesecon wire. Blinky plants behave similarly, but turn on and off every few seconds:

![](/doc/wiki-images/Mesecons_Plants.png)

Switches, buttons, and levers are all player controlled - punching switches and levers toggles them between on and off, while buttons turn on when punched and then turn off again after a little while. Switches conduct to the same positions as normal wire, while buttons and levers only conduct to the back or to the node behind the one to the back:

![](/doc/wiki-images/Mesecons_Switches.png)

Pressure plates come in wood and stone varieties, which differ mainly in appearance. They turn on when someone or something stands on them - this includes players, mobs, and items. Special rules mean that in addition to conducting to the same locations as normal wire, they also conduct to the node below the node directly below themselves:

![](/doc/wiki-images/Mesecons_PressurePlates.png)

###	Effectors

Now that we have a way to create and carry signals, it's time to do something with them. Effectors are made specifically for this purpose. Effectors can do things like giving off light, moving nodes around, playing music, or even running chat commands. There are far too many types of effectors to describe here, but we'll cover the most important ones.

Meselamps and lightstone light up when they have an on signal and don't give off any light otherwise. Meselamps are brighter than lightstones, while lightstones are available in many different colors:

![](/doc/wiki-images/Mesecons_Lighting.png)

Pistons can push a column of nodes and entities by one block, and the sticky piston can also pull the closest one. Entities on top of a stack being pushed horizontally are also moved. Movestones (not shown) do something similar, but can push nodes along a "rail" made of conductive materials:

![](/doc/wiki-images/Mesecons_Pistons.png)

Noteblocks play a certain note when they receive an on signal. The instrument used to play the note is determined by the node it's placed on top of, while the pitch (how high the note is) is changed by punching it. Placing one on wood planks causes it to make a litecrash sound, tree trunks cause a crash sound, chests cause a snare sound, stone causes a kick sound, glass causes a hihat sound, and anything else causes a piano sound:

![](/doc/wiki-images/Mesecons_Noteblocks.png)

Command blocks execute a chat command when they receive an on signal. However, they are not obtainable in survival mode without cheats due to the potential for abuse. Command blocks can only be changed by their owners (the player that placed it) and show a dialog when right clicked, which allows the target, command, and parameters to be set. Certain special commands are also available - more details can be found by using the "/help" chat command:

![](/doc/wiki-images/Mesecons_CommandBlocks.png)

###	Putting it all together

Now that we know how to create, transmit, and cause actions with Mesecon signals, we can look at the area where Mesecons really shines: manipulating signals with digital logic.

Let's say we want to have street lamps that come on only at night. A basic street lamp looks something like the following:

![](/doc/wiki-images/Mesecons_Streetlamp1.png)

At the moment, it's not giving off light. Let's give the lightstone an on signal:

![](/doc/wiki-images/Mesecons_Streetlamp2.png)

Now it's always on. But what about coming on only at night? Let's power it using a solar panel:

![](/doc/wiki-images/Mesecons_Streetlamp3.png)

Just a small problem remains - it only turns on in the day! That's about as useful as a solar powered flashlight. What we need to do is take the opposite of the solar panel's signal.

This is where digital logic comes in. In digital logic, the operation of taking the opposite of a signal is called a "logical NOT". It just so happens that Mesecons has a few devices that can do this operation, as well as many more. In our case, a Mesecon torch does the job very nicely:

![](/doc/wiki-images/Mesecons_StreetlampFinal.png)

The Mesecon torch simply takes the signal on the other side of the node it's attached to, and changes its state so that it's the opposite. That means that when the solar panel is on, the torch is off, and when the solar panel is off, the torch is on. In our case, we use this to detect the absence of light by taking the opposite of the solar panel's light detection.

There are tons of different ways you can manipulate signals like this. In fact, manipulate them enough and there's nothing you can't build - see the Tic-Tac-Toe and Node Detector articles on this site for inspiration. Logic gates can be used just like they are in real life to build many of the electronics we use every day. For the most complex manipulations, there are even Luacontrollers that can be programmed in-game to do just about anything.

# Chat

The in-game chat functionality allows players to communicate with each other with short text messages inside a server.

## Sending messages

First of all, before you can chat anything at all, you require the "shout" privilege. Don't worry, most servers give you this privilege by default.

You can chat either by opening the chat window or the console which can be opened with the keys T or F10, respectively (assuming you use the default key bindings). Use the chat window or the console to enter a chat message. There are two kinds of chat messages, public ones and private ones.

**Public messages**

A public message is a message which is visible to all connected players.

**Ordinary public messages**

Your chat message is a normal public message if it doesn't begin with a "/". It appears like this in the chat log:

```
<player> message
```

Example: If you enter "Hello, how are you?" as MrCerealGuy, then this will appear in the chat log:

```
<MrCerealGuy> Hello, how are you?
```

**/me messages**

This function is more like a gimmick than anything else. A /me message is a special case of a public message. The only real difference from the ordinary one is its appearance in the chat log. A /me message can be entered with:

```
/me <message>
```

Replace "&lt;message&gt;" with the actual message. You will get a message in the chat log which looks like this:

```
* <player> <message>
```

Example: Assume you want to say that you think that Stonecraft is awesome, in the third person. If you enter "/me thinks Stonecraft is awesome.", you get:

```
* MrCerealGuy thinks Stonecraft is awesome.
```

**Private messages**

A private message is a chat message which appears only on the chat logs of the sender and a chosen receiver of the message.

You can send a private message (PM) to someone by using the "/msg" server command. Say something in the form of:

```
/msg <player> <message>
```

Replace "&lt;message&gt;" by your actual message and "&lt;player&gt;" by the name of the player you want to send the message to. The message won't be publicly visible in the chatlog and only appears to you and the other player. Be aware that the messages are not encrypted, so do not transfer really sensitive information using the private message feature.

Example: If your name is "MrCerealGuy" and you entered "/msg MrFr33maN I want to show you my hidden chest.", then this will appear in the chat log of MrFr33maN:

```
PM from MrCerealGuy: I want to show you my hidden chest.
```

# Experienced players

## Area protection

To protect your area from griefing by other player, choose the first corner on the ground of your area you want to protect. Then open the console with F10 and set the marker with **/area_pos1**.

![](/doc/wiki-images/areapos1.jpg)

Now select the second corner in opposite direction of the first corner above the ground and set the marker with the command **/area_pos2**.

![](/doc/wiki-images/areapos2.jpg)

Now it's time to protect your area with **/protect &lt;description&gt;**, eg. /protect "My Home".

## Teleporters

A teleporter pad teleports players, or items to the linked receiver pad. A teleporter must be linked to a receiver first, before you can use it. One teleporter pad can only be linked to one receiver pad, you have to unlink it first, before using a new receiver. A receiver pad can accessed by many teleporter pads.

Example:

If you find an interesting location, then you can place a receiver pad.

![](/doc/wiki-images/teleporter1.jpg)

Do a right-click on the pad. You have enter a name and a optional description for your receiver pad. For servers you can make your receiver pad public for other players.

![](/doc/wiki-images/teleporter2.jpg)

Now your receiver pad is placed. At home you can place a teleporter pad.

![](/doc/wiki-images/teleporter3.jpg)

Do a right-click on the pad and select your receiver pad.

![](/doc/wiki-images/teleporter4.jpg)

Now you have linked the teleporter with the receiver pad.

![](/doc/wiki-images/teleporter5.jpg)

## Special Controls

You don't need these controls to play, but in special situations these controls can be useful.

| Control | Description |
| ------------- | ------------- |
|**Z**| Zoom|
|**/**| Command|
|**R**| Enable/disable full range view|
|**+**| Increase view range|
|**-**| Decrease view range|
|**K**| Enable/disable fly mode (needs fly privilege)|
|**J**| Enable/disable fast mode (needs fast privilege)|
|**H**| Enable/disable noclip mode (needs noclip privilege)|
|**F1**| Hide/show HUD|
|**F2**| Hide/show chat|
|**F3**| Disable/enable fog|
|**F4**| Disable/enable camera update (Mapblocks are not updated anymore when disabled, disabled in release builds)|
|**F5**| Cycle through debug info screens|
|**F6**| Cycle through profiler info screens|
|**F7**| Cycle through camera modes|
|**F8**| Toggle cinematic mode|
|**F10**| Show/hide console|
|**P**| Write stack traces into debug.txt|

## Server commands

Server commands are special commands to the server that can be entered by any player via the chat to cause the server to do something. There are a few commands which can be issued by everyone, but some commands only work if you have certain privileges granted on the server. Use _"/privs"_ to see your own privileges. If not noted otherwise, the commands in this article are assumed to require no privileges.

### Issuing a command

To issue a command, simply type it like a chat message or use the console. Alternatively, you can just press the "/" key (only in default controls) which simply opens a chat window where the "/" has already been typed for you and then type the command right away. The command itself will not appear in the chat. Since every command starts with "/", this means that ordinary chat messages can't start with "/"; they will be interpreted as a command instead, even if such a command does not exist. You can tell whether or not a command was successful by the server's response. If you see something _"-!- Invalid command: /blargh"_ in the chat, you probably misspelled something. The most commands will cause the server to write you something else on the chat log for you, if successful.

### General syntax

All commands start with "/". After that, one word follows which is itself followed by some or none arguments. You"ll find the exact syntax in the command reference. In the following command reference, text enclosed in &lt;&gt; is a placeholder for an actual value. Anything written in [] can be omitted.

### Command reference of built-in commands

**Quick documentation**

Show short documentation of server commands and privileges; it will appear in the chat log, too. In case the help is too long, you can open the console with F10 to view everything again.

  * **/help** - Shows a list of the available commands - depending on your privileges - on the server 
  * **/help &lt;command&gt;** - Shows short description about the given command. You can view the help of a command even if you do   not have the privilege to issue it 
  * **/help all** - Lists the available commands - depending on your privileges - on the server and a short description and syntax reference to each one 
  * **/help privs** - Lists all privileges on the server that could possibly be granted to players and shows a short description about each of them 

**Player-related**
**Informational**

  * **/privs [&lt;player&gt;]** - List of privileges granted to &lt;player&gt;, if not specified, your own privileges 
  * **/last-login [&lt;player&gt;]** - Show the date and time when &lt;player&gt; has logged in the last time into this server (UTC time zone, ISO 8601 format). If not specified, shows your own last login time 

**Chat**

These commands require the "shout" privilege to work.

  * **/msg &lt;player&gt; &lt;message&gt;** - Send a private message &lt;message&gt; to &lt;player&gt; 
  * **/me &lt;action&gt;** - Makes a text in the format "* &lt;your name&gt; &lt;action&gt;" appear in the chat log. E.g. "/me eats pizza." leads to "* Alfred eats pizza." (if your name is "Alfred") 

**Items**

For the /give and /giveme commands, a negative count will count down from 65536. This means for example that giving -1 of an itemstring will give 65535 items of that itemstring, which is also the hard size limit of a stack.

  * **/giveme &lt;itemstring&gt; [&lt;count&gt;]** - Give certain item &lt;count&gt; times (default: 1) to yourself. For a list of items to use this with, see the Itemstrings page. Requires the "give" privilege 
  * **/give &lt;player&gt; &lt;itemstring&gt; [&lt;count&gt;]** - Give certain item &lt;count&gt; times (default: 1) to the player. Requires the "give" privilege 
  * **/pulverize** - Destroys the wielded item. Can be used by any player 

**Teleportation**

Teleportation is the immediate displacement of any player to a given position. All of the following commands require the "teleport" privilege

  * **/teleport &lt;x&gt;,&lt;y&gt;,&lt;z&gt;** - Teleports yourself to given coordinates
  * **/teleport &lt;target_player&gt;** - Teleports yourself to the player with the name &lt;target_player&gt;
  * **/teleport &lt;player&gt; &lt;x&gt;,&lt;y&gt;,&lt;z&gt;** - Teleports &lt;player&gt; to given coordinates. Also requires the "bring" privilege
  * **/teleport &lt;player1&gt; &lt;player2&gt;** - Teleports &lt;player1&gt; to &lt;player2&gt;. Also requires the "bring" privilege

**Moderation**

**Password manipulation**

These commands allow to set and reset the passwords of any player and require the "password" privilege to work.

  * **/setpassword &lt;player&gt; &lt;password&gt;** - Sets password of &lt;player&gt; to &lt;password&gt;
  * **/clearpassword &lt;player&gt;** - Makes password of &lt;player&gt; empty
 
**Privilege manipulation**

All these commands require you to have the "privs" (to manipulate all privileges) or "basic_privs" (to manipulate "interact" and "shout" privileges) privilege.

  * **/grant &lt;player&gt; &lt;privilege&gt;** - Gives the &lt;privilege&gt; to &lt;player&gt;
  * **/grant &lt;player&gt; all** - Give all available privileges to &lt;player&gt;
  * **/grantme &lt;privilege&gt;** - Give &lt;privilege&gt; to yourself
  * **/grantme all** - Gives all privilege to yourself
  * **/revoke &lt;player&gt; &lt;privilege&gt;** - Takes away a &lt;privilege&gt; from &lt;player&gt;
  * **/revoke &lt;player&gt; all** - Takes away as many privileges as possible from &lt;player&gt;

**Excluding players from server**

These commands allow the user to kick, ban and unban players. Kicking a player means to remove a connected player from the server. This requires the "kick" privilege. Banning a player prevents him/her to connect to the server again. The player does not need to be connected at this time. Unbanning means to remove a ban from a player, allowing him/her to connect to the server again. The ban and unban commands require the "ban" privilege.

  * **/kick &lt;player name&gt; [&lt;reason&gt;]** - Kicks the player with the name &lt;player name&gt;. Optionally a &lt;reason&gt; can be provided in text-form. This text is also shown to the kicked player.
  * **/ban** - show list of banned players
  * **/ban &lt;player name&gt;** - Ban IP of player
  * **/unban &lt;player name&gt;** - Remove ban of player with the specified name
  * **/unban &lt;IP address&gt;** - Remove ban of player with the specified IP address

**Server-related**
**Informational**

Request some information from the server; the answer from the server will also be written into the chatlog.

  * **/admin** - Player name of the administrator / server operator of the server you're connected to.
  * **/status** - Server's Stonecraft version, time the server is running in seconds (called "uptime"), list of connected   * players and the message of the day (if it exists).
  * **/mods** - List of mods installed on the server.
  * **/days** - Current game day (counting starts at 0)
  * **/time** - Current game time (24h clock)

**World manipulation**

  * **/time &lt;hours&gt;:&lt;minutes&gt;** - Sets the time of day in the 24-hour format (0:00-23:59). Requires the "settime" privilege
  * **/time &lt;time_of_day&gt;** - Sets the time of day (tod) (number between 0 and 24000). 0 tod and 24000 tod are midnight, 12000 tod is noon, 18600 tod is sunset, 4750 tod is sunrise. (time of day = hour * 1000). Requires the "settime" privilege
  * **/set -n time_speed &lt;speed&gt;** - Sets the speed of day/night cycle where &lt;speed&gt; is the time speed (read as "&lt;speed&gt; times faster than in real life"). 72 is the default, which means a day-night cycle lasts 20 minutes by default. Requires the "server" privilege
  * **/spawnentity &lt;entity&gt; [&lt;X&gt;,&lt;Y&gt;,&lt;Z&gt;]** - Spawns an entity of type &lt;entity&gt; (see List of entity names) near your position or at the X,Y,Z coordinates, if specified. Requires "give" and "interact" privileges

**Server maintenance**

All of these commands require the "server" privilege.

  * **/shutdown** - Shuts down the server
  * **/set &lt;variable&gt;** - Shows the value of the given server &lt;variable&gt;
  * **/set &lt;variable&gt; &lt;new value&gt;** - Sets the existing server &lt;variable&gt; to the given &lt;new value&gt;
  * **/set -n &lt;variable&gt; &lt;initial value&gt;** - Creates a new server variable named &lt;variable&gt; and sets it to &lt;initial value&gt;
  * **/clearobjects [full|quick]** - Clears all objects/entities (removes all dropped items, mobs and possibly more). Note this may crash the server or slow it down to a crawl for 10 to more than 60 seconds
  * **/auth_reload** - Reloads auth.txt, which is the authentication data, containing privileges and Base64-scrambled passwords
  * **/deleteblocks here [&lt;radius&gt;]** - Removes the MapBlock the player is in, from the database. As this triggers mapgen, this might start mechanisms like mud reflow or cavegen which very likely affect mapblocks outside the specified range. 113 blocks are a safe-distance for a server with no interfering mods. &lt;radius&gt; is an optional argument to specify the range in which MapBlocks are deleted
  * **/deleteblocks &lt;pos1&gt; &lt;pos2&gt;** - Removes the MapBlock containing blocks inside the area from pos1 to pos2 from the database. May crash for larger areas. Warnings from above apply

**Rollback**

Allows to use Rollback. Requires the "rollback" privilege.

  * **/rollback_check [&lt;range&gt;] [&lt;seconds&gt;]** - Checks who has last touched a node or near it, max. &lt;seconds&gt; ago (default &lt;range&gt;=0, default &lt;seconds&gt;=86400, which equals 24 hours in real time).
  * **/rollback &lt;player name&gt; [&lt;seconds&gt;]** - Reverts actions of a player; default for &lt;seconds&gt; is 60
  * **/rollback :&lt;actor name&gt; [&lt;seconds&gt;]** - Reverts actions of an actor (not a player); default for &lt;seconds&gt; is 60

## Privileges

Every player has a set of privileges, which differ from server to server. Roughly spoken, one's privileges determine what one is able to do and what not. Each privilege has a name (the meaning is described below). Privileges can be granted and revoked from other players by any player who has the privilege called _"privs"_. On a multiplayer server with a default configuration, new players start with the privileges called "interact, shout" and "zoom". To view one's own privileges, one can issue the server command _"/privs"_.

### Built-in privileges

gameplay-related:

  * **interact** - build, mine or use blocks 
  * **give** - can use the /give and /giveme commands 
  * **zoom** - can zoom (Z key by default) 
  * **teleport** - can use the /teleport command to teleport oneself to certain coordinates or to another player 
  * **bring** - in combination with teleport, can use the /teleport command to teleport any player to certain coordinates or to yet another player 
  * **fast** - allows the player to activate fast mode 
  * **fly** - allows the player to activate fly mode 
  * **noclip** - allows the player to activate "noclip" mode, which allows them to fly through walls 

chat-related:

  * **shout** - can chat with other people

world-manipulation-related:

  * **settime** - can set time of day using /time

moderation-related:

  * **privs** - can set any privileges of players using /grant and /revoke
  * **basic_privs** - can set "interact" and "shout" privileges using /grant and /revoke
  * **kick** - can kick players with /kick
  * **ban** - can ban/unban IPs and names using /ban and /unban
  * **rollback** - can use the rollback functionality
  * **protection_bypass** - can bypass protection of blocks (e.g. can open locked chests or steel doors of everyone)

administration-related:

  * **server** - can do server maintenance stuff such as /shutdown, /clearobjects, /set, …
  * **debug** - can access advanced debug features and informations, such as the wirewrame in the debug screens (F5)

### Privileges from mods

Mods may make additional privileges available on the server. Issue the server command _/help privs_ to receive a full list (and short descriptions) of all possible privileges on the server.

### Server configuration

Using the server's configuration files, a lot of privilege-related stuff can be manipulated.

There is an option in the configuration file for setting the default privileges for new players. _default_privs = interact, shout, zoom_

The player having the name in the _"name" field_ of the configuration has all the privileges.
Privileges are stored in the _auth.txt_ file. The format of every line in that file is _name:hashed_password:privs_. A real example: _mrcerealguy:CcCUjNUDVJxmXmTHj+7WKHvA9Ds:interact,shout,zoom_

The _auth.txt_ file is written periodically and at shutdown, so you should edit it only when the server is not running.

## WorldEdit

WorldEdit is an in-game world editor. Use it to repair griefing, or just create awesome buildings in seconds.

![](/doc/wiki-images/600px-WorldEdit.png)

### WorldEdit Basics

This is a step-by-step tutorial outlining the basic usage of WorldEdit.

**Overview**

WorldEdit has a "region", which is simply a cuboid area defined by two markers, both of which the player can move around. Every player can have their own region with their own two markers.

WorldEdit GUI buttons and chat commands generally work inside the region selected, or around the first marker.

If you are using the chat commands, follow the steps under **Chat Commands**. If you are using the WorldEdit GUI, follow the steps under **WorldEdit GUI**.

#### Step 1: Selecting a region


It is very simple to select a region using the item "WorldEdit Wand Tool". By left-clicking on an existing stone, you can set the first mark, which is then visible as a number "1" on the block. The second mark is set by right-clicking on an existing block. The block then belongs to the marked area, the numbers on the blocks mark the corners of the rectangular area.

Here are two examples:

Left or right-click sets two marks, in which case the area with the sandstones is marked.

![](/doc/wiki-images/600px-MinetestWE1.png)

The marked area is always made visible with a check pattern. In the first example you can not see it, because it is in the ground.

![](/doc/wiki-images/600px-MinetestWE2.png)


**Chat Commands**

In the chat prompt, enter `//p set`. In the chat, you are prompted to punch two nodes to set the positions of the two markers.

Punch a nearby node. Be careful of breakable ones such as torches. A black cube reading "1" will appear around the node. This is the marker for WorldEdit position 1.

Walk away from the node you just punched. Now, punch another node. A black cube reading "2" will appear around the node. This is the marker for WorldEdit position 2.

**WorldEdit GUI**

Open the main WorldEdit GUI from your inventory screen. The icon looks like a globe with a red dot in the center.

Press the "Get/Set Positions" button. On the new screen, press the "Set Position 1" button. The inventory screen should close.

Punch a nearby node. Be careful of breakable ones such as torches. A black cube reading "1" will appear around the node. This is the marker for WorldEdit position 1.

Walk away from the node you just punched. Open your inventory again. It should be on the same page as it was before.

Press the "Set Position 2" button. The inventory screen should close.

Now, punch another node. A black cube reading "2" will appear around the node. This is the marker for WorldEdit position 2.

#### Step 2: Region commands

**Chat Commands**

In the chat prompt, enter `//set mese`. In the chat, you will see a message showing the number of nodes set after a small delay.

Look at the place between the two markers: it is now filled with MESE blocks!

The `//set <node>` command fills the region with whatever node you want. It is a region-oriented command, which means it works inside the WorldEdit region only.

Now, try a few different variations, such as `//set torch`, `//set cobble`, and `//set water`.

**WorldEdit GUI**

Open the main WorldEdit GUI from your inventory screen.

Press the "Set Nodes" button. You should see a new screen with various options for setting nodes.

Enter "mese" in the "Name" field. Press Search if you would like to see what the node you just entered looks like.

Press the "Set Nodes" button on this screen. In the chat, you will see a message showing the number of nodes set after a small delay.

Look at the place between the two markers: it is now filled with MESE blocks!

The "Set Nodes" function fills the region with whatever node you want. It is a region-oriented command, which means it works inside the WorldEdit region only.

Now, try a few different variations on the node name, such as "torch", "cobble", and "water".

#### Step 3: Position commands

**Chat Commands**

In the chat prompt, enter `//hollowdome 30 glass`. In the chat, you will see a message showing the number of nodes set after a small delay.

Look around marker 1: it is now surrounded by a hollow glass dome!

The `//hollowdome <radius> <node>` command creates a hollow dome centered around marker 1, made of any node you want. It is a position-oriented command, which means it works around marker 1 and can go outside the WorldEdit region.

**WorldEdit GUI**

Open the main WorldEdit GUI from your inventory screen.

Press the "Sphere/Dome" button. You should see a new screen with various options for making spheres or domes.

Enter "glass" in the "Name" field. Press Search if you would like to see what the node you just entered looks like.

Enter "30" in the "Radius" field.

Press the "Hollow Dome" button on this screen. In the chat, you will see a message showing the number of nodes added after a small delay.

Look around marker 1: it is now surrounded by a hollow glass dome!

The "Hollow Dome" function creates a hollow dome centered around marker 1, made of any node you want. It is a position-oriented command, which means it works around marker 1 and can go outside the WorldEdit region.

#### Step 4: Other commands

**Chat Commands**

There are many more commands than what is shown here. See the [WorldEdit Chat Commands](#worldedit-chat-commands) for a detailed list of them, along with descriptions and examples for every single one.

If you're in-game and forgot how a command works, just use the `/help <command name>` command, without the first forward slash. For example, to see some information about the `//set <node>` command mentioned earlier, simply use `/help /set`.

A very useful command to check out is the `//save <schematic>` command, which can save everything inside the WorldEdit region to a file, stored on the computer hosting the server (the player's computer, in single player mode). You can then later use `//load <schematic>` to load the data in a file into a world, even another world on another computer.

**WorldEdit GUI**

This only scratches the surface of what WorldEdit is capable of. Most of the functions in the WorldEdit GUI correspond to chat commands, and so the [WorldEdit Chat Commands](#worldedit-chat-commands) may be useful if you get stuck.

It is helpful to explore the various buttons in the interface and check out what they do. Learning the chat command interface is also useful if you use WorldEdit intensively - an experienced chat command user can usually work faster than an experienced WorldEdit GUI user.

### WorldEdit Chat Commands

Many commands also have shorter names that can be typed faster. For example, if we wanted to use `//move ? 5`, we could instead type `//m ? 5`. All shortened names are listed below:

| Short Name | Original Name      |
|:-----------|:-------------------|
| `//i`      | `//inspect`        |
| `//rst`    | `//reset`          |
| `//mk`     | `//mark`           |
| `//umk`    | `//unmark`         |
| `//1`      | `//pos1`           |
| `//2`      | `//pos2`           |
| `//fp`     | `//fixedpos`       |
| `//v`      | `//volume`         |
| `//s`      | `//set`            |
| `//r`      | `//replace`        |
| `//ri`     | `//replaceinverse` |
| `//hcube`  | `//hollowcube`     |
| `//hspr`   | `//hollowsphere`   |
| `//spr`    | `//sphere`         |
| `//hdo`    | `//hollowdome`     |
| `//do`     | `//dome`           |
| `//hcyl`   | `//hollowcylinder` |
| `//cyl`    | `//cylinder`       |
| `//hpyr`   | `//hollowpyramid`  |
| `//pyr`    | `//pyramid`        |

### `//about`

Get information about the mod.

    //about

### `//inspect on/off/1/0/true/false/yes/no/enable/disable/<blank>`

Enable or disable node inspection.

    //inspect on
    //inspect off
    //inspect 1
    //inspect 0
    //inspect true
    //inspect false
    //inspect yes
    //inspect no
    //inspect enable
    //inspect disable
    //inspect

### `//reset`

Reset the region so that it is empty.

    //reset

### `//mark`

Show markers at the region positions.

    //mark

### `//unmark`

Hide markers if currently shown.

    //unmark

### `//pos1`

Set WorldEdit region position 1 to the player's location.

    //pos1

### `//pos2`

Set WorldEdit region position 2 to the player's location.

    //pos2

### `//p set/set1/set2/get`

Set WorldEdit region, WorldEdit position 1, or WorldEdit position 2 by punching nodes, or display the current WorldEdit region.

    //p set
    //p set1
    //p set2
    //p get

### `//fixedpos set1 x y z`

Set a WorldEdit region position to the position at (`<x>`, `<y>`, `<z>`).

    //fixedpos set1 0  0 0
    //fixedpos set1 -30 5 28
    //fixedpos set2 1004 -200 432

### `//volume`

Display the volume of the current WorldEdit region.

    //volume

### `//deleteblocks`

Delete the MapBlocks (16x16x16 units) that contain the selected region. This means that mapgen will be invoked for that area. As only whole MapBlocks get removed, the deleted area is usually larger than the selected one. Also, mapgen can trigger mechanisms like mud reflow or cavegen, which affects nodes (up to 112 nodes away) outside the MapBlock, so dont use this near buildings. Note that active entities are not part of a MapBlock and do not get deleted.

    //deleteblocks

### `//set <node>`

Set the current WorldEdit region to `<node>`.

    //set air
    //set cactus
    //set Blue Lightstone
    //set dirt with grass

### `//param2 <param2>`

Set the param2 value of all nodes in the current WorldEdit region to `<param2>`.

### `//mix <node1> ...`

Fill the current WorldEdit region with a random mix of `<node1>`, `...`.

    //mix air
    //mix cactus stone glass sandstone
    //mix Bronze
    //mix default:cobble air

### `//replace <search node> <replace node>`

Replace all instances of `<search node>` with `<replace node>` in the current WorldEdit region.

    //replace Cobblestone air
    //replace lightstone_blue glass
    //replace dirt Bronze Block
    //replace mesecons:wire_00000000_off flowers:flower_tulip

### `//replaceinverse <search node> <replace node>`

Replace all nodes other than `<search node>` with `<replace node>` in the current WorldEdit region.

    //replaceinverse Cobblestone air
    //replaceinverse flowers:flower_waterlily glass
    //replaceinverse dirt Bronze Block
    //replaceinverse mesecons:wire_00000000_off flowers:flower_tulip

### `//hollowcube <width> <height> <length> <node>`

Adds a hollow cube with its ground level centered at WorldEdit position 1 with dimensions `<width>` x `<height>` x `<length>`, composed of `<node>`.

    //hollowcube 6 5 6 Diamond Block

### `//cube <width> <height> <length> <node>`

Adds a cube with its ground level centered at WorldEdit position 1 with dimensions `<width>` x `<height>` x `<length>`, composed of `<node>`.

    //cube 6 5 6 Diamond Block
    //cube 7 2 1 default:cobble

### `//hollowsphere <radius> <node>`

Add hollow sphere centered at WorldEdit position 1 with radius `<radius>`, composed of `<node>`.

    //hollowsphere 5 Diamond Block
    //hollowsphere 12 glass
    //hollowsphere 17 mesecons:wire_00000000_off

### `//sphere <radius> <node>`

Add sphere centered at WorldEdit position 1 with radius `<radius>`, composed of `<node>`.

    //sphere 5 Diamond Block
    //sphere 12 glass
    //sphere 17 mesecons:wire_00000000_off

### `//hollowdome <radius> <node>`

Add hollow dome centered at WorldEdit position 1 with radius `<radius>`, composed of `<node>`.

    //hollowdome 5 Diamond Block
    //hollowdome -12 glass
    //hollowdome 17 mesecons:wire_00000000_off

### `//dome <radius> <node>`

Add dome centered at WorldEdit position 1 with radius `<radius>`, composed of `<node>`.

    //dome 5 Diamond Block
    //dome -12 glass
    //dome 17 mesecons:wire_00000000_off

### `//hollowcylinder x/y/z/? <length> <radius1> [radius2] <node>`

Add hollow cylinder at WorldEdit position 1 along the x/y/z/? axis with length `<length>`, base radius `<radius1>` (and top radius `[radius2]`), composed of `<node>`.

Despite its name this command allows you to create cones (`radius2` = 0) as well as any shapes inbetween (0 < `radius2` < `radius1`).
Swapping `radius1` and `radius2` will create the same object but upside-down.

    //hollowcylinder x +5 8 Bronze Block
    //hollowcylinder y 28 10 glass
    //hollowcylinder z -12 3 mesecons:wire_00000000_off
    //hollowcylinder ? 2 4 default:stone

    //hollowcylinder y 10 10 0 walls:cobble
    //hollowcylinder x 6 0 5 Dirt
    //hollowcylinder z 20 10 20 default:desert_stone

### `//cylinder x/y/z/? <length> <radius1> [radius2] <node>`

Add cylinder at WorldEdit position 1 along the x/y/z/? axis with length `<length>`, base radius `<radius1>` (and top radius `[radius2]`), composed of `<node>`.
Can also create shapes other than cylinders, e.g. cones (see documentation above).

    //cylinder x +5 8 Bronze Block
    //cylinder y 28 10 glass
    //cylinder z -12 3 mesecons:wire_00000000_off
    //cylinder ? 2 4 default:stone

    //cylinder y 10 10 0 walls:cobble
    //cylinder x 6 0 5 Dirt
    //cylinder z 20 10 20 default:desert_stone

### `//hollowpyramid x/y/z? <height> <node>`

Add hollow pyramid centered at WorldEdit position 1 along the x/y/z/? axis with height `<height>`, composed of `<node>`.

    //hollowpyramid x 8 Diamond Block
    //hollowpyramid y -5 glass
    //hollowpyramid z 2 mesecons:wire_00000000_off
    //hollowpyramid ? 12 mesecons:wire_00000000_off

### `//pyramid x/y/z? <height> <node>`

Add pyramid centered at WorldEdit position 1 along the x/y/z/? axis with height `<height>`, composed of `<node>`.

    //pyramid x 8 Diamond Block
    //pyramid y -5 glass
    //pyramid z 2 mesecons:wire_00000000_off
    //pyramid ? 12 mesecons:wire_00000000_off

### `//spiral <length> <height> <spacer> <node>`

Add spiral centered at WorldEdit position 1 with side length `<length>`, height `<height>`, space between walls `<spacer>`, composed of `<node>`.

    //spiral 20 5 3 Diamond Block
    //spiral 5 2 1 glass
    //spiral 7 1 5 mesecons:wire_00000000_off

### `//copy x/y/z/? <amount>`

Copy the current WorldEdit region along the x/y/z/? axis by `<amount>` nodes.

    //copy x 15
    //copy y -7
    //copy z +4
    //copy ? 8

### `//move x/y/z/? <amount>`

Move the current WorldEdit positions and region along the x/y/z/? axis by `<amount>` nodes.

    //move x 15
    //move y -7
    //move z +4
    //move ? -1

### `//stack x/y/z/? <count>`

Stack the current WorldEdit region along the x/y/z/? axis `<count>` times.

    //stack x 3
    //stack y -1
    //stack z +5
    //stack ? 12

### `//stack2 <count> <x> <y> <z>`

Stack the current WorldEdit region `<count>` times by offset `<x>`, `<y>`, `<z>`.

    //stack2 5 3 8 2
    //stack2 1 -1 -1 -1

### `//stretch <stretchx> <stretchy> <stretchz>`

Scale the current WorldEdit positions and region by a factor of `<stretchx>`, `<stretchy>`, `<stretchz>` along the X, Y, and Z axes, repectively, with position 1 as the origin.

    //scale 2 2 2
    //scale 1 2 1
    //scale 10 20 1

### `//transpose x/y/z/? x/y/z/?`

Transpose the current WorldEdit positions and region along the x/y/z/? and x/y/z/? axes.

    //transpose x y
    //transpose x z
    //transpose y z
    //transpose ? y

### `//flip x/y/z/?`

Flip the current WorldEdit region along the x/y/z/? axis.

    //flip x
    //flip y
    //flip z
    //flip ?

### `//rotate x/y/z/? <angle>`

Rotate the current WorldEdit positions and region along the x/y/z/? axis by angle `<angle>` (90 degree increment).

    //rotate x 90
    //rotate y 180
    //rotate z 270
    //rotate ? -90

### `//orient <angle>`

Rotate oriented nodes in the current WorldEdit region around the Y axis by angle `<angle>` (90 degree increment)

    //orient 90
    //orient 180
    //orient 270
    //orient -90

### `//fixlight`

Fixes the lighting in the current WorldEdit region.

    //fixlight

### `//drain`

Removes any fluid node within the current WorldEdit region.

    //drain

### `//hide`

Hide all nodes in the current WorldEdit region non-destructively.

    //hide

### `//suppress <node>`

Suppress all <node> in the current WorldEdit region non-destructively.

    //suppress Diamond Block
    //suppress glass
    //suppress mesecons:wire_00000000_off

### `//highlight <node>`

Highlight <node> in the current WorldEdit region by hiding everything else non-destructively.

    //highlight Diamond Block
    //highlight glass
    //highlight mesecons:wire_00000000_off

### `//restore`

Restores nodes hidden with WorldEdit in the current WorldEdit region.

    //restore

### `//save <file>`

Save the current WorldEdit region to "(world folder)/schems/`<file>`.we".

    //save some random filename
    //save huge_base

### `//allocate <file>`

Set the region defined by nodes from "(world folder)/schems/`<file>`.we" as the current WorldEdit region.

    //allocate some random filename
    //allocate huge_base

### `//load <file>`

Load nodes from "(world folder)/schems/`<file>`.we" with position 1 of the current WorldEdit region as the origin.

    //load some random filename
    //load huge_base

### `//lua <code>`

Executes `<code>` as a Lua chunk in the global namespace.

    //lua worldedit.pos1["singleplayer"] = {x=0, y=0, z=0}
    //lua worldedit.rotate(worldedit.pos1["singleplayer"], worldedit.pos2["singleplayer"], "y", 90)

### `//luatransform <code>`

Executes `<code>` as a Lua chunk in the global namespace with the variable pos available, for each node in the current WorldEdit region.

    //luatransform minetest.add_node(pos, {name="default:stone"})
    //luatransform if minetest.get_node(pos).name == "air" then minetest.add_node(pos, {name="default:water_source"})

### `//mtschemcreate <file>`

Save the current WorldEdit region using the Minetest Schematic format to "(world folder)/schems/`<file>`.mts".

    //mtschemcreate some random filename
    //mtschemcreate huge_base

### `//mtschemplace <file>`

Load nodes from "(world folder)/schems/`<file>`.mts" with position 1 of the current WorldEdit region as the origin.

    //mtschemplace some random filename
    //mtschemplace huge_base

### `//mtschemprob start/finish/get`

After using `//mtschemprob start` all nodes punched will bring up a text field where a probablity can be entered.
This mode can be left with `//mtschemprob finish`. `//mtschemprob get` will display the probabilities saved for the nodes.

    //mtschemprob get

### `//clearobjects`

Clears all objects within the WorldEdit region.

    //clearobjects
    
### `//shift x/y/z/?/up/down/left/right/front/back [+|-]<amount>`

Shifts the selection area by `[+|-]<amount>` without touching its contents. The shifting axis can be absolute (`x/y/z`) or 
relative (`up/down/left/right/front/back`). 

    //shift left 5

### `//expand [+|-]x/y/z/?/up/down/left/right/front/back <amount> [reverse-amount]`

Expands the selection by `<amount>` in the selected absolute or relative axis. If specified, the selection can be expanded in the
opposite direction over the same axis by `[reverse-amount]`.

    //expand right 7 5

### `//contract [+|-]x/y/z/?/up/down/left/right/front/back <amount> [reverse-amount]`

Contracts the selection by `<amount>` in the selected absolute or relative axis. If specified, the selection can be contracted in the
opposite direction over the same axis by `[reverse-amount]`.

    //expand right 7 5

### `//outset [hv] <amount>`

Expands the selection in all directions by `<amount>`. If specified, the selection can be expanded horizontally in the x and z axes `[h]`
or vertically in the y axis `[v]`.

    //outset v 5

### `//inset [hv] <amount>`

Contracts the selection in all directions by `<amount>`. If specified, the selection can be contracted horizontally in the x and z axes `[h]`
or vertically in the y axis `[v]`.

    //outset v 5

### `//brush none/<command> [parameters]`

Assigns the given `<command>` to the currently held brush item, it will be ran with the first pointed solid node (as determined via raycast) as
WorldEdit position 1 when using that specific brush item.
Passing `none` instead clears the command assigned to the currently held brush item.

    //brush cube 8 8 8 Cobblestone
    //brush spr 12 glass
    //brush none

## Create and import a schematic file (.mts) with WorldEdit

How to create a schematic file: 

1. Enter in your world (with WorldEdit enabled).
2. Grant yourself all privileges : **/grant singleplayer all**. 
3. Press F5 to display the coordinates.
4. Select the area to export with : **//pos1** and **//pos2**.
5. Create your schematic file with : **//mtschemcreate &lt;name of your schematic file&gt;**. Without extension .mts.

Your schematic will appears into the **worlds/&lt;my_world&gt;/schems** folder.

How to import a schematic file: 

1. Enter in your world (with WorldEdit enabled).
2. Grant yourself all privileges : **/grant singleplayer all**. 
3. Move a schematic file into the **worlds/&lt;my_world&gt;/schems** folder.
4. Press F5 to display the coordinates.
5. Select a position with : **//pos1**
6. Import your schematic file from the chosen position with : **//mtschemplace &lt;name of your schematic file&gt;**. Without extension .mts.

# Setting up a server

1. Start your server on your desired port
	* **Note**: It is recommended to leave the port at the default (30000)
2. Find out your internal IP of the computer you are running the server on
	* **Linux**: open a terminal and type ifconfig and hit enter
	* **Windows**: _Start -> Run … -> cmd.exe -> ipconfig_
3. Check the port forwarding settings on your router
	* forward your chosen port for UDP (30000 if you left it default) to the internal IP
	* In addition, alter any firewalls you may have to pass the traffic at that port
4. Let your friends know your external IP
5. Make your server listed in the server list by setting the following settings in stonecraft.conf
	* server_announce = true - makes Stonecraft tell the server list about the server.
	* server_name - set the value of this to your server's name.
	* server_description - set the value of this to a longer description describing your server.
	* server_address - if you have a domain name for your server, then set this to the domain name.
	* server_url - if you have a website for your server, then set this to the website URL.
	* motd - a message that is sent to the player when they join. Use this to welcome them.
	* You should restart the server to make sure any changed settings changed

## Running a dedicated server

### Linux

1. Open a terminal.
2. Type in _&lt;YOUR/STONECRAFT/DIRECTORY&gt;/bin/stonecraftserver_ or just drop the stonecraftserver executable (located in _/Stonecraft/bin/_) into the terminal **(PLEASE READ THE NOTES BELOW!)**
	* If you want to specify a specific game ID, the game ID choices are located in _/Stonecraft/games/_. Add in _--gameid thegameid_ to the end of the command.
	* If you get the error "Multiple worlds are available.", the world choices are located in _/Stonecraft/worlds/_. Add in _--worldname theWorld_ to the end of the command.
3. If your server crashes, then look at the debug.txt in _/Stonecraft/bin/_
4. Enjoy running a Stonecraft server!

For easy use you can create a file named _start-stonecraft.sh_, add the lines below and put it in your _/Stonecraft/bin/_ folder.

```
#!/bin/bash -e

until ./stonecraftserver --worldname ../worlds/<YOUR-WORLD>; do
    echo "Server 'stonecraftserver' crashed with exit code $?. Respawning.." >&2
    sleep 1
done
```

You have to make the script executable with the command

```
chmod +x start-stonecraft.sh
```

To run the server, just execute the script in a terminal with

```
./start-stonecraft.sh
```

Tipp: Add the start script to your /etc/rc.local file to run Stonecraft automatically if your system is rebooting.

```
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

<YOUR/STONECRAFT/DIRECTORY>/bin/start-stonecraft.sh

exit 0
```

### Windows

1. Open command prompt by going in the _/Stonecraft/bin/_ folder, hold Shift, do a right click on _bin_ and click "Open command window here".
2. Type this: _stonecraft.exe --server_.
	* If you get the error "Multiple worlds are available.", use _stonecraft.exe --server --worldname world_name_ instead, where world_name is the name of the world.
3. If your server crashes, then look at the debug.txt in _/Stonecraft/bin/_
4. Enjoy running a Stonecraft server!

If you don't like to start the crashed server, simply start the server out of a batch file which contains the following code:

```
@echo off
:crash
stonecraft.exe --server --worldname world_name
goto crash
```
# Modding Stonecraft

If you wish to make your own mod for Stonecraft, I recommend to learn how the engine works and to become familiar with the Lua API. The following links can be useful:

1. Learn the structure of the **Minetest engine**
http://dev.minetest.net/Main_Page

2. Learn the **Lua programming language**
https://www.lua.org/pil/contents.html

3. Learn the **Lua Mod API**
http://rubenwardy.com/minetest_modding_book/

## Installing mods

You can get mods from the [Minetest community](http://www.minetest.net/customize/), I can give no warranties that they work with Stonecraft. The mods are installed globally and enabled per world.

The common place to install them is _&lt;YOUR/STONECRAFT/DIRECTORY&gt;/mods/_. After extracting the mod there you need to enable it for your world. This can either be done in the GUI by clicking on "Configure" in the world selection, or by adding 

```
load_mod_<modname> = true
```

in the _world.mt_ file in the world directory.

Note that newly installed mods are disabled for all worlds by default, so you explicitly need to enable them.

If you want to use a mod only in a specified world, then you have to extract your mod in _&lt;YOUR/STONECRAFT/DIRECTORY&gt;/worlds/&lt;YOUR-WORLD&gt;/worldmods/_.

## Installing texture packs

You will find a folder called _textures_ in your Stonecraft base folder. Place the texture pack there. Start Stonecraft and select a new style in the _textures tab_.

### Server texture pack

If you create a server and want that the texture pack works not only for you, change the texture pack name to _server_.

## Profiling mods

To activate the profiler simple add to stonecraft.conf following line:

```
profiler.load = true
```

Start a game and make sure you have server privileges. Open the console and type

```
/profiler print
```

to get the current statistics.

Here you see the usage of the profiler command:

```
/profiler print [filter] | dump [filter] | save [format [filter]] | reset
```

Available save formats: txt, csv, lua, json, json_pretty

# Troubleshooting

## Multiplayer/Network issues

Q: There are some online servers that can only run protocol 24 - 32.

A: Please download stonecraft-1.2.4a-XXXX-old-net-proto.zip from https://mrcerealguy.itch.io/stonecraft and extract the binary in _&lt;YOUR/STONECRAFT/DIRECTORY&gt;/bin/_ folder. Start stonecraft-1.2.4a[.exe] and connect to your desired server.

[![Creative Commons License](https://i.creativecommons.org/l/by-nc-sa/4.0/80x15.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)  
This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/).
