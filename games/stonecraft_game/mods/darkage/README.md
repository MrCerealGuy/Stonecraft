=== DarkAge MOD for MINETEST-C55 ===
by Master Gollum

Introduction:
  This mod adds a few new blocks that allows to create new buildings in a
  pre industrial landscape. Of course, feel free to use them in any other 
  construction :P

  It also provides more layers of stones. I tried not to turn mining in
  a rainbow, so don't expect to find them easily. There are two kinds of
  materials, stones, that spawns in layers at different deep and clay
  like materials (silt and mud) that you will find in water places.
  Silt and Mud are more easy to find than stone layers, but if you find
  one it will be a real mine, with all probability with hundreds of blocks.

  I used mainly 4 square recipes to avoid collisions with other MODs, 
  anyway I have not checked all them, so it is possible that another 
  person is already using one or more of this combinations.

  I also used Desert Sand and Desert Stone, because they almost are not
  used in the default version. Probably I will change this recipes in 
  next releases.

  

Release Notes

  Version 0.3
    * 29 Nodes + 3 Craft Items
    * Furniture and building decoration
    * Stone layers

  Version 0.2
    * 13 Nodes
    * Sedimentary stones

  Version 0.1
    * 6 Nodes

PS: This document has been structured as the README.txt of PilzAdam in 
    his Bed MOD.

How to install:
  Unzip the archive an place it in minetest-base-directory/mods/minetest/
  if you have a windows client or a linux run-in-place client. If you 
  have a linux system-wide instalation place it in 
  ~/.minetest/mods/minetest/.
  If you want to install this mod only in one world create the folder
  worldmods/ in your worlddirectory.
  For further information or help see:
    http://wiki.minetest.com/wiki/Installing_Mods

Tunning:
  Comments the following lines to remove what you don't like:
  (To comment them just add -- at the beginning of their lines)

  Stone Layers
    dofile(minetest.get_modpath("darkage").."/mapgen.lua")
    The stones will not spawn in the map.
  
  Furniture Nodes
    dofile(minetest.get_modpath("darkage").."/furniture.lua")
    Only pure stones will be provided.


  BUILDING NODES

  Adobe: Sand and Clay mixture with Straw to build houses or walls
         Used from historical times, one of the first bricks 
         invented. I have to improve this texture, it is ugly :P
     CRAFT -> 4
     [Sand] [Sand]
     [Clay Lumb] [Straw]

  Basalt: a darken version of the default Stone
     COOKING
     [Basalt Cobble]

  Basalt Cobble: A darken version of the default Cobble
     CRAFT -> 4
     [Cobble] [Cobble]
     [Coal Lump] [Coal Lump]

  Chalk: a soft, white and porous sedimentary rock. It becomes
     Chalk Powder when digged. Can't be craft, only found as
     stratum.

  Chalk Powder: pile of chalk from digging Chalk stones. Can
     be used to prepare plaster. See Cobblestone with Plaster.

  Cobblestone with Plaster: Cobbles where has been applied a
     layer of white plaster.
     When digged it lost the plaster layer!
     CRAFT -> 2
     [Cobblestone] [Chalk Powder]
     [Cobblestone] [Chalk Powder]

  Dark Dirt: A darken version of the Dirt where the grass doesn't
     grown, perfect for create a path in a forest. I was using
     Gravel, but the noise walking was annoying to me (like
     walking over iron coal with the nude feet :P), for this I
     created this node.
     CRAFT -> 4
     [Dirt] [Dirt]
     [Gravel] [Gravel]

  Desert Stone Cobble: To add more uses to the Desert Stones.
     I suppossed they are harder than regular Stones so it
     cracks at 50% and releases the Cobbles or just regular
     Desert Stones.
     From dig Desert Stone

  Desert Iron Ore: I know that others MODs add ores to the 
     Desert Stones, mine also does it, but just Iron, I supposed
     the red color is because of the iron, so it goes with more
     high probability than regular Stones and it doesn't add
     Coal to them. It will not be a lot so you can keep it with
     another MOD that does the same or just comment the lines that
     does it.

  Dry Leaves: Just a cube of Leaves toasted :P Well I found the
     Leaves unuseful, so I thought to turn them into Straw, ok
     it is not the same, but well, why not? Just dry them in a
     Furnace and then put together to create the Straw
     COOKING
     [Leaves]

  Gneiss: high grade metamorphic rock formed from Schist, very
     common, and used in construction. It sometimes brokes in
     Gneiss Cobble when being digged.
     COOKING
     [Schist]

  Gneiss Cobble: brick version of the gneiss.
     From dig gneiss

  Mud: mixture of water and some combination of soil, silt, and
     clay. Used for build houses, specially in desertic regions.
     It brokes in 4 Mud Lumps when digged.
     CRAFT -> 3
     [Dirt] [Dirt]
     [Clay Lump] [Silt Lump]
     CRAFT -> 1
     [Mud Lump] [Mud Lump]
     [Mud Lump] [Mud Lump]

  Old Red Sandstone: a light red sandstone, in fact it's
     sandstone with iron that gives it this color.
     CRAFT -> 4
     [Sandstone] [Sandstone]
     [Iron Lumb] [Sandstone]
     COOKING
     [Old Red Sandstone Cobble]

  Old Red Sandstone Cobble: Cobbles of Old Red Sandstone.
     CRAFT -> 4
     [Sandstone Cobble] [Sandstone Cobble]
     [Iron Lumb] [Sandstone Cobble]
     COOKING
     [Desert Stone] --> I think I will change it in the future
                        release with its own Cobbles.

  Reinforced Cobble: brick with crossed wooden.
     CRAFT -> 1
     [Stick] [] [Stick]
     [] [Cobble] []
     [Stick] [] [Stick]
  
  Sandstone Cobble: brick version of the Sandstone, good for
     buildings with a pale color.
     COOKING
     [Sandstone]

  Schist: medium grade metamorphic rock from Slate.
     COOKING
     [Slate]

  Silt: granular material of a size somewhere between sand and clay.
     It brokes in 4 Silt Lumps.
     CRAFT -> 1
     [Silt Lump] [Silt Lump]
     [Silt Lump] [Silt Lump]

  Slate: fine-grained, foliated, homogeneous metamorphic rock
     derived from an original shale-type sedimentary rock through
     low-grade regional metamorphism. It is used to build roof.
     COOKING
     [Shale]
     COOKING
     [Slate Cobble]

 

  Slate Cobble: Cobble obtained from Slate
     From dig Slate

  Slate Tale: Nice blue slate tales for roofs. They has been used
     as building traditional building material in zones where
     slate is easy to find.
     Note: It has stairs and slabs.
     CRAFT -> 2
     [Slate Cobble] [Slate Cobble]
     [Slate Cobble] [Slate Cobble]

  Straw: a cube of yellish straw, try them in the roofs they will
     be very nice. Used also as traditional building material
     from ancient times.
     CRAFT -> 2
     [Shrub] [Shrub]
     [Shrub] [Shrub]
     CRAFT -> 2
     [Dry Leaves] [Dry Leaves]
     [Dry Leaves] [Dry Leaves]

  Straw Bale: a decoration item, looks great for a farm or a 
     country side house.
     CRAFT -> 1
     [Straw] [Straw]
     [Straw] [Straw]
 
  Desert Stone: just the default block, it can be obtained now
     from Desert Sand. The idea is that Desert Sand is stonner
     than regular Sand, so it takes less to create a Desert
     Stone than a Sandstone.
     CRAFT -> 2
     [Sandstone] [Sandstone]
     [Sandstone] [Sandstone]


  FURNITURE NODES
  Just started so they are few ones

  Box: a more smaller container than the Chest, but it requires
     less wood. As cheep as 4 woods and have 16 slots. The craft
     is a little weird but I think it makes sense and avoids
     collision with the recipe of Hardwood of the MOD 
     building_blocks.
     CRAFT -> 2
     [Wood] [] [Wood]
     [] [] []
     [Wood] [] [Wood]

  Chain: climbable chain.
     CRAFT -> 2
     [Steel Ingot]
     [Steel Ingot]
     [Steel Ingot]

  Iron Bars: alternative window for the Glass.
     CRAFT -> 3
     [Steel Ingot] [] [Steel Ingot]
     [Steel Ingot] [] [Steel Ingot]
     [Steel Ingot] [] [Steel Ingot]

  Iron Grille: alternative window for the Glass.
     CRAFT -> 3
     []          [Iron Bars]      []
     [Iron Bars]     []       [Iron Bars]
     []          [Iron Bars]      []

  Wood Bars: alternative window for the Glass.
     CRAFT -> 3
     [Stick] [] [Stick]
     [Stick] [] [Stick]
     [Stick] [] [Stick]

  Wood Frame: alternative window for the Glass.
     CRAFT -> 1
     [Stick] [Stick]  [Stick]
     [Stick] [Glass]  [Stick]
     [Stick] [Stick]  [Stick]


License:
Sourcecode: WTFPL (see below)
Graphics: WTFPL (see below)

See also:
http://minetest.net/

         DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO. 





