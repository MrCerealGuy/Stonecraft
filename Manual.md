# Welcome to Stonecraft

An InfiniMiner/Minecraft inspired game.

Copyright © 2016-2017 Andreas "MrCerealGuy" Zahnleiter [mrcerealguy@gmx.de](mailto:mrcerealguy@gmx.de)

Like in other block sandbox games, you can build and destroy blocks everywhere in a near infinite world. There are two game modes, in survival mode you can loose your life, so you have to fight against many creatures and hunger in a dangerous world with many dungeons and woods of spiders. In creative mode you have access to all blocks, items and tools to build all you can imagine. Choose if you want to play either as singleplayer or multiplayer on servers with your friends. If you like, you can run your own Stonecraft server.

Stonecraft is open-source and free, released under the GNU Lesser General Public License (LGPL).

**Table of contents**

1. [First steps](#first-steps)
    1. [Creating a world](#creating-a-world)
    2. [Basic Controls](#basic-controls)
    3. [Using blocks/items](#using-blocksitems)
        1. [Taking](#taking)
        2. [Dropping](#dropping)
        3. [Exchanging](#exchanging)
        4. [Throwing away](#throwing-away)
        5. [Automatic transfer](#automatic-transfer)
    4. [Changing your skin](#changing-your-skin)
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
5. [Chat](#chat)
    1. [Sending messages](#sending-messages)
6. [Experienced players](#experienced-players)
    1. [Area protection](#area-protection)
    2. [Teleporters](#teleporters)
    3. [Special Controls](#special-controls)
    4. [Server commands](#server-commands)
        1. [Issuing a commands](#issuing-a-command)
        2. [General syntax](#general-syntax)
        3. [Command reference of built-in commands](#command-reference-of-built-in-commands)
    5. [Privilegs](#privileges)
        1. [Built-in privileges](#built-in-privileges)
        2. [Privileges from mods](#privileges-from-mods)
        3. [Server configuration](#server-configuration)
    6. [Create and import a schematic file (.mts)](#create-and-import-a-schematic-file-mts)
7. [Setting up a server](#setting-up-a-server)
    1. [Running a Server](#running-a-server)
        1. [Linux](#linux)
        2. [Windows](#windows)
8. [Modding Stonecraft](#modding-stonecraft)
    1. [Installing mods](#installing-mods)
    2. [Installing texture packs](#installing-texture-packs)
        1. [Server texture pack](#server-texture-pack)

# First steps

## Creating a world

First, before you can play, you have to create a world. In the world creation dialog you can select optional world generation settings.

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/createworld4.png)

Note: Some settings need huge cpu consumption so it can be laggy for most players.

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

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/inventory.png)

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

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/skins1.png)

You see your current skin. Now click on "Change".

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/skins2.png)

Choose your desired skin.

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/skins3.png)

Congratulations! Press 'F7' to switch in third person mode to see your new skin!

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/skins4.png)

# Crafting

## Crafting grid and output slot

To be able to craft anything at all, you need a crafting grid. A crafting grid consists of a number of inventory slots and you can place and move and remove items from it like you can with an inventory. To craft, the items have to be arranged somehow in the crafting grid. Next to a crafting grid there is one output slot, in which the craft appears if you arranged the items in a valid way. Click on this symbol with the left mouse button to make this craft once. The needed items in the crafting grid will be used up. Click on the output slot with the middle mouse button to make this craft up to ten times (depending on how much items are left in the crafting grid). Crafting generally takes no time and you can use the resulting items immediately.

Crafting grids generally work like inventories. So a crafting grid found in your inventory menu can be used/abused as an extension of the player inventory.

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/craftingslot.png)

## Shaped and shapeless recipes

There are are two kinds of crafting recipes, _shaped ones_ and _shapeless ones_.

For a shaped recipe, the items have to be arranged into an exact pattern. If a crafting recipe takes up a smaller rectangle than the crafting grid, it can be moved on any part of the crafting grid. For example, a 2x2 recipe can be arranged on the top left, top right, bottom left or bottom right on a 3x3 crafting grid. If a crafting recipe uses more space than available in the crafting grid, you are unable to craft this item with it. You need a larger one.

For a _shapeless recipe_, the necessary items just have to be placed on any available slots of the crafting grid. Stacking items does not work, however.

Most crafting recipes are _shaped recipes_. If not noted otherwise, it is assumed that a crafting recipe is shaped.

## Example recipes

### Shapeless recipes

| Item | Ingredients | Grid |
| ------------- | ------------- | ------------- |
| Bronze Ingot | Steel Ingot + Copper ingot | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/shapeless1.jpg) |
| Bronze Ingot | Steel Ingot + Copper ingot | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/shapeless2.jpg) |
| Bronze Ingot | Steel Ingot + Copper ingot | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/shapeless3.jpg) |

### Shaped recipes

| Item | Ingredients | Grid |
| ------------- | ------------- | ------------- |  
| Paper | Papyrus | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/shaped1.jpg) |
| Paper | Papyrus | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/shaped2.jpg) |
| Paper | Papyrus | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/shaped3.jpg) |
  
 
## Smelting

### Fuel
 
|  | Block | Burning time in seconds | Items smelted for fuel |
| ------------- | ------------- | ------------- | ------------- |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Coal_block.png) | Coal Block | 370 | 123⅓ |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Bucket_lava.png) | Lava Bucket | 60 | 20 |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Coal.png) | Coal Lump | 40 | 13⅓ |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Jungle_Tree.png) | Jungle Tree | 38 | 12⅔​​ |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Acacia_Tree.png) | Acacia Tree | 34 | 11⅓ |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Tree.png) | Tree | 30 | 10 |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Pine_Tree.png) | Pine Tree | 26 | 8​⅔ |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Aspen_Tree.png) | Aspen Tree | 22 | 7​⅓ |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Cactus.png) | Cactus | 15 | 5 |
  
And many more…

### Recipes

|  | Input |  | Output | Smelting time | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Flour.png) | Flour | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Bread.png) | Bread | 15s | Can be eaten to restore health. |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Cobblestone.png) | Cobblestone | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Stone.png) | Stone | 3s | Used as decoration. |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Mossy_Cobblestone.png) | Mossy Cobblestone | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Stone.png) | Stone | 3s | Used as decoration. |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Desert_Cobblestone.png) | Desert Cobblestone | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Desert_stone.png) | Desert Stone | 3s | Used as decoration. |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Clay_Lump.png) | Clay Lump | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Clay_Brick.png) | Clay Brick | 3s | Used to craft bricks. |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Copper_lump.png) | Copper Lump | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Copper_Ingot.png) | Copper Ingot | 3s | Can be combined with a steel ingot to make a bronze ingot. |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Gold_lump.png) | Gold Lump | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Gold_ingot.png) | Gold Ingot | 3s | Used for crafting Gold Block and Skeleton Key. |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Skeleton_Key.png) | Skeleton Key | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Gold_ingot.png) | Gold Ingot | 5s | Used for crafting Gold Block and Skeleton Key. |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Iron_lump.png) | Iron Lump | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Steel_Ingot.png) | Steel Ingot | 3s | Used for crafting several items. |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Steel_bottle.png) | Heavy Steel Bottle | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Steel_Ingot.png) | Steel Ingot | 3s | Used for crafting several items. |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Group_sand.png) | Sand/Desert sand | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Glass.png) | Glass | 3s | Used as decoration or a building material. |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Pile_of_Glass_Fragments.png) | Pile of Glass Fragments | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Glass.png) | Glass | 3s | Used as decoration or a building material. |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Obsidian_shard.png) | Obsidian Shard | ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/48px-Obsidian_glass.png) | Obsidian Glass | 3s | Used as decoration or a building material. |
  
And many more…

# Mobs

## Simple mobs

A few simple creatures in Stonecraft, not all are bad.

| Mob | Description | Health/Armor/Damage | Drops |
| ------------- | ------------- | ------------- | ------------- |
| Zombie<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/90px-CME_Zombie.png) | Zombies can spawn at every time of day in the world as long there is not too much light. So you will find some in caves, dark forests and of cause a lot at night. If they notice you they will attack. Zombies have 20 HP (like players) and drop sometimes rotten flesh on death. On day Zombies die because of the sunlight. | 20![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Rotten flesh |
| Ghost<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/118px-CME_Ghost.png) | Ghosts only spawn at night-time and they don't spawn underground. They are flying in the world and attack you aswell if they notice you. Ghosts have 15 HP and don't drop any items atm (might be changed in future).They can't harm you in your house. If it becomes day Ghosts will take damage by the sunlight, so they will die after a while. | 15![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | - |
| Sheep<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/111px-CME_Sheep.png) | Sheep spawn only at day-time and are friendly mobs. They remain around 5 minutes in the world unless they are tamed with 5 wheat (rightclick). There are four different wool colors: white, grey, brown and black. If there is grass (dirt with grass) they eat the grass and make new wool that way. Sheep have 8 HP and drop 1-2 wool when punched or sheared with shears. They need to eat grass until they can give wool again. | 8![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | 1-2 wool |
| Chicken<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-CME_Chicken.png) | Chicken are friendly and spawn only at day-time too. They drop randomly eggs and remain 5 minutes. Currently you can't tame or breed them. They drop chicken meat and feather(s) on death. Eggs can be thrown to spawn (rarely) new chicken, or cooked in furnace to gain fried eggs, which are eatable. | -![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Chicken meat<br>Feather(s) |
| Oerrki<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/62px-CME_Oerki1.png) | Oerrki spawn only at night on stone or dirt like blocks. They attack players and make more damage than Zombies or Ghosts. Daylight can't harm them. | -![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | - |

## Not So Simple Mobs

**Not So Simple Mobs** are more complex mobs in Stonecraft, for the purpose of increasing the difficulty of playing. There are more than 50 different mobs. They are divided in groups, each one who lives in a different biome.

They all drop life energies. With life energies you can craft tools and special powerful weapons to defend yourself from the monsters.

| Mob | Description | Health/Armor/Damage | Drops |
| ------------- | ------------- | ------------- | ------------- |
| Black Widow<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Nssm_black_widow.png) | A black widow is a hostile medium sized spider with a big abdomen. They attack with small but powerful chelicerae. | 10![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/1½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Spider Leg<br>Web |
| Stone Bloco<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Nssm_Stone_bloco.png) | A Bloco is a hostile mob made of stone with a little head, short arms and legs. Bloco Is a little clumsy in walking and he chases his enemies rolling like a ball, a cubic ball obviously!<br><br>He is a true Rolling Stones fan. | 7½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/1![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Stone |
| Crab<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Nssm_crab.png) | Crab is a hostile mob that lives on the beach and they don't float in water, they prefer walking on the sand pinching their enemies with their powerful chelas. Crabs have two possible colors of their carapace, red and light orange. | 17![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/1½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Surimi<br>Crab Chela |
| Crocodile<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/108px-Nssm_crocodile.png) | A Crocodile is a hostile mob. | 10![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/1![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/1½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Crocodile Tail |
| Daddy Long Legs<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Nssm_daddy_long_legs.png) | A Daddy Long Legs is a spiderlike hostile mob with a small body and obviously, long legs! | 9½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/1½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Spider Leg |
| Dolidrosaurus<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/98px-Nssm_dolidrosaurus.png) | A Dolidrosaurus is an aquatic reptile hostile mob with a long tail and a fin at the end. They're fully adapted to living in water and they have two others fins on the side which allow them to swim faster and more precisely. Dolidrosaurus derives from greek, Dolicolos means long, Hydor water and Sauros lizard. Dolidrosauruses have five possible variations of their skin: Dark green, green, light green, blue-green and blue-pink. | 13![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/2![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/2![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy |
| Duck<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/61px-Nssm_duck.png) | A Duck is cute but evil hostile mob. Walks around the plains with nothing better to do than pecking the players foot. It Is quite small and can survive Minetest cruel world only with the help of her big brothers and sisters that attack the bad players who wants to eat their delicious duck legs. | 5![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)| Life Energy<br>Duck Legs<br>Duck Beak |
| Echidna<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/68px-Nssm_echidna.png) | An Echidna is a beautiful human hostile mob. It's skin is pale, sick-green and they have black hair. They're half naked but you probably won't care, the one who looses himself in thoose evil, but beautiful, eyes is dead. When you are to close she will slash you with her tail. She emits poison to blocks nearby which does not go away, it causes half heart of damage each game tick and you can drown in it like you would in water. | 45![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/5![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Snake Scute |
| Enderduck<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/69px-Nssm_enderduck.png) | An Enderduck is tall and very dark hostile mob that spawns at night and hunts poor miners chasing them with high speed and brilliant eyes that allow them to see in the darker night. | 10![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/1½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Duck Legs<br>Duck Beak |
| Felucco<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Felucco_nssm.png) | The Felucco is one of the most fierce carnivores of nssm. It is very fast and attacks anyone with its mighty horns. His name derives form italian: "fel" stands for "felino", feline, because of its similarity with leopards. "Ucc" stands for "mucca", cow, because of his peculiar horns and "o" is the desinence for male in italian.<br><br>With the fur it is possible to craft a strong armor, but not so durable. Felucco steaks are very nutritious after been cooked. Felucco horns are good raw materials to craft weapons and tools, it is possible to craft a hoe, a knife and a spear. | 16![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/3![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/2½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Felucco Fur<br>Felucco Steak<br>Felucco Horn |
| Giant Sandworm<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/74px-Nssm_Giant_sandworm.png) | A Giant Sandworm is a huge hostile mob that likes to stay in one place and damages players when they get within a 7 block range. | 65![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Worm Flesh<br>Black Sand |
| Icelamander<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Nssm_icelamander.png) | The Icelamander is the boss of ice biomes. Nearly nothing could defeat this dangerous mob. Taller than a normal Sam, the Icelamanders have even more frightening jaws than Snow Biters! They have a long tail that helps them to keep the balance on their two legs. The Icelamanders are so cold that they frost everything while walking, not only water! Their frosting power is so strong that they can freeze you in an ice column even from a great distance! Not the simple default ice, but the Coldest Ice, so cold that can freeze the souls of the unlucky creatues trapped in it.<br><br>Icelamander eats their with their horrible fangs that can damage really bad their preys. You have now certainly understood that Icelamanders are really really dangerous. | 230![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/6![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/6![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Ice Tooth<br>Little Ice Tooth<br>Frosted Amphibian Heart<br>Amphibian Ribs |
| Icesnake<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/111px-Nssm_icesnake.png) | An Icesnake is an amphibian that live in ice plains and mountains. Long ago its body has been adapted to cold biomes using ice and cold in order to preserve the water content in cells. In fact the heat produced by the frosting of ice in the environment allows the Icesnake and the others ice amphibians as Snow Biters, Icelamanders and Icelizards to keep in the liquid form their body fluids.<br><br>Icesnakes aren't very big or evil but they attack enemies with their fangs very rapidly. | 13½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/3![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/2![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Ice Tooth<br>Little Ice Tooth<br>Frosted Amphibian Heart<br>Amphibian Ribs |
| Kraken<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/65px-Nssm_kraken.png) | A Kraken is the king of the sea hostile gigantic octopus mob with long tentacles. There attack with tentacles is devastating but there dimensions doesn't allow them to go fast. Females are red-rose as Octpuses, on the other side the males are dark green. Kraken can produce ink in the water which make seeing in water even more difficult. | 75![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/3![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Tentacle<br>Tentacle Curly |
| Larva<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/108px-Nssm_larva.png) | A Larva is a hostile mob. It is the first stadium of Mantis and Mantis Beasts development. Their body is white and the head is brown. After around half a minute they become Mantis or Mantis Beasts! So be careful and slay all of them before it is too late. | 5![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy |
| Lava Titan<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/90px-Nssm_lava_titan.png) | A Lava Titan is a hostile mob that turns nearby blocks into lava and has two attack styles.<br>- Lava titan hits the ground with his fist, kneels and summons lava blocks diagonaly around players.<br>- Lava titan marches straight toward you rushing through blocks and destroying every block he touches. | 40![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/6![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/3½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Lava Bucket<br>Lava Titan Eye |
| Manticore<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/84px-Nssm_manticore.png) | A Manticore is a strong, fast hostile mob. It attacks either with projectiles from a far or with the scorpion sting on it's tail when you're too near.<br><br>Appearence<br>With face like a man's, a skin red as cinnabar, and is as large as a lion. It has three rows of teeth, ears and light-blue eyes like those of a man; its tail is like that of a land scorpion, containing a sting more than a cubit long at the end. It has other stings on each side of its tail. | 12½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/2![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Manticore Spine |
| Mantis<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/80px-Nssm_mantis.png) | A Mantis is a tall and humanlike hostile mob that has two possible colors and attacks with two powerful kung fu moves with its 4 arms! It walks on two legs looking for fresh meat: you! | 7½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/1![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Mantis Claw |
| Mantis Beast<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Nssm_mantis_beast.png) | A Mantis Beast is a hostile mob that is Very similar to their relatives that walk on only two legs, Mantis Beasts are faster thanks to their 6 claws used in running and their position is more "beastly"! | 10![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/1½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Mantis Claw |
| Masticone<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Nssm_masticone.png) | A Masticone is a hostile mob that alone isn't a real danger, but when you kill one of them two others come to venge their friend. Kill as many as you can then run as fast as you can! | 7½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/2½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Masticone Fang<br>Masticone Skull<br>Fragments |
| Mese Dragon<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/95px-Nssm_messe_dragon.png) | A Mese Dragon is a massive hostile boss mob with midas touch that turns nearby blocks into mese blocks and has meele and firebreath attack. Mese dragon is not damaged by sunlight, water or lava. | 166½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/8![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Energy Globe<br>Rainbow Staff |
| Night Master<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Nssm_moonherontrio.png) | A Night Master is a hostile mob that is a special kind of Moonheron that has three heads. | 15![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/3![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Heron Leg<br>Night Feather |
| Octopus<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/106px-Nssm_octopus.png) | An octopus is a hostile mob that is weaker brother of Kraken, they're not able to produce ink and they are all red-rose. | 11![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/-![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/1½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Tentacle |
| Phoenix<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Nssm_phoenix.png) | A Phoenix is a hostile mob made of fire and energy. Nobody, unless the sun, is brighter than this beatiful bird in the sky. | 30![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/1![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Sun Feather<br>Phoenix Tear<br>Phoenix Nuggets |
| Pumpking<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/98px-Nssm_pumpking.png) | A Pumpking is a hostile mob king of the pumbooms it is tall creepy creature with a humanlike black thin bodies covered with the blood of their victims, their head is very similar to a Pumpboom and their body to Signosigno. On their death they have a little explosive surprise for the unlucky warrior able enough to defeat them... | 50![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/5![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/4½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Cursed Pumpkin Seed |
| Scrausics<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Scrausics_nssm.png) | A scrausics is a hostile mob. | 15![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/2![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/2![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Raw Scrausics Wing |
| Snowbiter<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Snowbiter_nssm.png) | A Snow Biter is a hostile mob. | 15![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/2![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/2![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Frosted Amphibian Heart<br>Amphibian Ribs<br>Little Ice Tooth |
| Spiderduck<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Spiderduck_nssm.png) | Spiderducks have evolved from Enderducks to become more similar to the spiders. They have a dark skin and 8 legs, but the body is the one of a duck.<br><br>Even if they are not bosses they are extremely dangerous! In fact if you don't know what to expect from a spiderduck you can easily fall in its web and become a tasteful snack! Spiderducks spawn only at night and because of their dark color they are able to easily blend with the environment. If a spiderduck sees you it starts shooting at you web projectiles. When they hit the target a sticky web covers the soil trapping the victims. And if you have been trapped then expect the spiderduck to come at you and to eat you! | 24-35![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/2![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/6![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Duck legs<br>Life Energy<br>Web<br>Duck beak |
| Stone Eater<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Stone_Eater_nssm.png) | A Stone Eater is a hostile mob that is imune to any sword weapon. When under attack he bites back while eating stone that is around. | 14![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/6![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/2½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Stoneater Mandible<br>Stone |
| Swimming Duck<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Swiming_Duck_nssm.png) | A Swimming Duck is a hostile mob. | 12½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/2![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/1½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Duck Legs<br>Duck Beak<br>Duck Feather |
| Tarantula<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Tarantula_nssm.png) | A Tarantula is a hostile mob that can either bite or slow down your movement trapping you inside a cocon. After killing it Tarantula Propower appears. | 25![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Super Silk Gland |
| Mordain<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Mordain_nssm.png) | A Mordain is a hostile mob that likes teleporting. | 16![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/2![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/3![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Slothful Soul Fragment |
| Morde<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Morde_nssm.png) | A Morde is a hostile mob that has an ability to heal himself. | 23½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/3![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Proud Soul Fragment |
| Morgre<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Morgre_nssm.png) | A Morgre is a hostile mob that likes to explode. | 17![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Greedy Soul Fragment |
| Morgut<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Morgut_nssm.png) | Dont let it get to close to you or else it will steal your precious food. You can get your food back by slaying Morgut.<br><br>With the Gluttonous soul fragment it is possible to craft a strong weapon Sword of Gluttony and Food Bomb | 18![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/3![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/2![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Gluttonous soul fragment |
| Morlu<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Morlu_nssm.png) | Dont let it get to close to you or else it will steal your precious equipped armor. You can get your armor back by slaying Morlu.<br><br>With the Lustful Soul Fragment it is possible to craft strong Morlu armor and Cage Bomb | 28![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/5![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Wrathful Soul Fragment |
| Morvy<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Morvy_nssm.png) | A Morvy is a hostile mob that likes summoning. | 19½![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/2![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Envious Soul Fragment |
| Morwa<br>![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/120px-Morwa_nssm.png) | A Morwa is a hostile mob that can either range you from afar or smash you when your close enough. | 28![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png)/5![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/Armor.png)/4![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/16px-Heart.png) | Life Energy<br>Wrathful Soul Fragment |

# Farming

Farmable blocks will spawn either new blocks or yield new items, when mined. All farmable blocks have to be on top of another certain kind of block to grow. Some farmable blocks also need light. The “Maximum profit” column shows the maximum possible outcome a single block will yield, including itself. Please notice: Light level 13 on a farmable crop cannot be achieved at night!

| Block | Grows on | Needs light? | Maximum profit | Theorical growth speed (evolution) | Expected growth speed (full) | Number of growth stages |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Cotton_8.png) Cotton (plant) | Wet Soil, Wet Desert Sand Soil | Yes, 13 or higher | 3 ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Cotton.png) Strings and 3 ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Cotton_Seed.png) Cotton Seeds | 1/2 chance to grow every 80 seconds = about 160 seconds per stage | 160 × 7 = 1120 seconds ≈ 19 minutes | 8 |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Wheat_8.png) Wheat (plant) | Wet Soil | Yes, 13 or higher | 2 ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Wheat.png) Wheat (items) and 2 ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Wheat_Seed.png)Wheat Seeds | 1/2 chance to grow every 90 seconds = about 180 seconds per stage | 180 × 7 = 1260 seconds = 21 minutes | 8 |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Jungle_Sapling.png) Jungle Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | About 20 ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Jungle_Tree.png) Jungle Trees and many ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Jungle_Leaves.png) Jungle Leaves | 1/50 chance every 10 seconds | 10 × 50 = 500 seconds ≈ 8 minutes | 2 |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Sapling.png) Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | 5 ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Tree.png) Trees, many ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Leaves.png) Leaves and some ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Apple.png) Apples | 1/50 chance every 10 seconds | 10 × 50 = 500 seconds ≈ 8 minutes | 2 |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Acacia_Tree_Sapling.png) Acacia Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | 13 ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Acacia_Tree.png) Acacia Trees and ca. 75 ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Acacia_Leaves.png) Acacia Leaves | 1/50 chance every 10 seconds | 10 × 50 = 500 seconds ≈ 8 minutes | 2 |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Pine_Sapling.png) Pine Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | Some ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Pine_Tree.png) Pine Trees and many ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Pine_Needles.png) Pine Needles | 1/50 chance every 10 seconds | 10 × 50 = 500 seconds ≈ 8 minutes | 2 |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Cactus.png) Cactus | Any kind of sand | No | 4 ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Cactus.png) Cacti | 1/20 chance every 50 seconds | 50 × 20 = 1000 seconds ≈ 17 minutes | 4 |
| ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Papyrus.png) Papyrus | Dirt, Dirt with Grass. (Water must be to 3 blocks away) | No | 4 ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Papyrus.png) Papyri | 1/20 chance every 50 seconds | 50 × 20 = 1000 seconds ≈ 17 minutes | 4 |
| Group:flora | Dirt with Grass | Yes, 13 or higher | 4 flora blocks of the same kind | 1/25 chance every 50 seconds | 50 × 25 = 1250 seconds ≈ 21 minutes | 1 |
| Group:flora | Desert Sand | No | 1 ![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/32px-Dry_Shrub.png) Dry Shrub | 1/25 chance every 50 seconds | 50 × 25 = 1250 seconds ≈ 21 minutes | 1 |

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

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/areapos1.jpg)

Now select the second corner in opposite direction of the first corner above the ground and set the marker with the command **/area_pos2**.

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/areapos2.jpg)

Now it's time to protect your area with **/protect &lt;description&gt;**, eg. /protect "My Home".

## Teleporters

A teleporter pad teleports players, or items to the linked receiver pad. A teleporter must be linked to a receiver first, before you can use it. One teleporter pad can only be linked to one receiver pad, you have to unlink it first, before using a new receiver. A receiver pad can accessed by many teleporter pads.

Example:

If you find an interesting location, then you can place a receiver pad.

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/teleporter1.jpg)

Do a right-click on the pad. You have enter a name and a optional description for your receiver pad. For servers you can make your receiver pad public for other players.

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/teleporter2.jpg)

Now your receiver pad is placed. At home you can place a teleporter pad.

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/teleporter3.jpg)

Do a right-click on the pad and select your receiver pad.

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/teleporter4.jpg)

Now you have linked the teleporter with the receiver pad.

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/teleporter5.jpg)

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

## Create and import a schematic file (.mts)

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
4. To see how to run a server, please read the section below
5. Let your friends know your external IP
6. Add _server_announce = 1_ to your _stonecraft.conf_ to announce it to a public server list.

## Running a Server

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
