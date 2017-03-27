# Welcome to Stonecraft

An InfiniMiner/Minecraft inspired game.

Copyright © 2016-2017 Andreas "MrCerealGuy" Zahnleiter [mrcerealguy@gmx.de](mailto:mrcerealguy@gmx.de)

Like in other block sandbox games, you can build and destroy blocks everywhere in a near infinite world. There are two game modes, in survival mode you can loose your life, so you have to fight against many creatures and hunger in a dangerous world with many dungeons and woods of spiders. In creative mode you have access to all blocks, items and tools to build all you can imagine. Choose if you want to play either as singleplayer or multiplayer on servers with your friends. If you like, you can run your own Stonecraft server.

Stonecraft is open-source and free, released under the GNU Lesser General Public License (LGPL).

# First steps

## Creating a world

First, before you can play, you have to create a world. In the world creation dialog you can select optional world generation settings.

![](https://mrcerealguy.github.io/stonecraft/gfx/wiki/createworld3.jpg)

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

## Chat

The in-game chat functionality allows players to communicate with each other with short text messages inside a server.

### Sending messages

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

Replace "\<message\>" with the actual message. You will get a message in the chat log which looks like this:

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

Replace "\<message\>" by your actual message and "\<player\>" by the name of the player you want to send the message to. The message won't be publicly visible in the chatlog and only appears to you and the other player. Be aware that the messages are not encrypted, so do not transfer really sensitive information using the private message feature.

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

Now it's time to protect your area with **/protect \<description\>**, eg. /protect "My Home".

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

All commands start with "/". After that, one word follows which is itself followed by some or none arguments. You"ll find the exact syntax in the command reference. In the following command reference, text enclosed in \<\> is a placeholder for an actual value. Anything written in [] can be omitted.

### Command reference of built-in commands

**Quick documentation**

Show short documentation of server commands and privileges; it will appear in the chat log, too. In case the help is too long, you can open the console with F10 to view everything again.

  * **/help** - Shows a list of the available commands - depending on your privileges - on the server
  * **/help \<command\>** - Shows short description about the given command. You can view the help of a command even if you do   not have the privilege to issue it
  * **/help all** - Lists the available commands - depending on your privileges - on the server and a short description and syntax reference to each one
  * **/help privs** - Lists all privileges on the server that could possibly be granted to players and shows a short description about each of them

**Player-related**
**Informational**

  * **/privs [\<player\>]** - List of privileges granted to \<player\>, if not specified, your own privileges
  * **/last-login [\<player\>]** - Show the date and time when \<player\> has logged in the last time into this server (UTC time zone, ISO 8601 format). If not specified, shows your own last login time

**Chat**

These commands require the "shout" privilege to work.

  * **/msg \<player\> \<message\>** - Send a private message \<message\> to \<player\>
  * **/me \<action\>** - Makes a text in the format "* \<your name\> \<action\>" appear in the chat log. E.g. "/me eats pizza." leads to "* Alfred eats pizza." (if your name is "Alfred")

**Items**

For the /give and /giveme commands, a negative count will count down from 65536. This means for example that giving -1 of an itemstring will give 65535 items of that itemstring, which is also the hard size limit of a stack.

  * **/giveme \<itemstring\> [\<count\>]** - Give certain item \<count\> times (default: 1) to yourself. For a list of items to use this with, see the Itemstrings page. Requires the "give" privilege
  * **/give \<player\> \<itemstring\> [\<count\>]** - Give certain item \<count\> times (default: 1) to the player. Requires the "give" privilege
  * **/pulverize** - Destroys the wielded item. Can be used by any player

**Teleportation**

Teleportation is the immediate displacement of any player to a given position. All of the following commands require the "teleport" privilege

  * **/teleport \<x\>,\<y\>,\<z\>** - Teleports yourself to given coordinates
  * **/teleport \<target_player\>** - Teleports yourself to the player with the name \<target_player\>
  * **/teleport \<player\> \<x\>,\<y\>,\<z\>** - Teleports \<player\> to given coordinates. Also requires the "bring" privilege
  * **/teleport \<player1\> \<player2\>** - Teleports \<player1\> to \<player2\>. Also requires the "bring" privilege

**Moderation**

**Password manipulation**

These commands allow to set and reset the passwords of any player and require the "password" privilege to work.

  * **/setpassword \<player\> \<password\>** - Sets password of \<player\> to \<password\>
  * **/clearpassword \<player\>** - Makes password of \<player\> empty
 
**Privilege manipulation**

All these commands require you to have the "privs" (to manipulate all privileges) or "basic_privs" (to manipulate "interact" and "shout" privileges) privilege.

  * **/grant \<player\> \<privilege\>** - Gives the \<privilege\> to \<player\>
  * **/grant \<player\> all** - Give all available privileges to \<player\>
  * **/grantme \<privilege\>** - Give \<privilege\> to yourself
  * **/grantme all** - Gives all privilege to yourself
  * **/revoke \<player\> \<privilege\>** - Takes away a \<privilege\> from \<player\>
  * **/revoke \<player\> all** - Takes away as many privileges as possible from \<player\>

**Excluding players from server**

These commands allow the user to kick, ban and unban players. Kicking a player means to remove a connected player from the server. This requires the "kick" privilege. Banning a player prevents him/her to connect to the server again. The player does not need to be connected at this time. Unbanning means to remove a ban from a player, allowing him/her to connect to the server again. The ban and unban commands require the "ban" privilege.

  * **/kick \<player name\> [\<reason\>]** - Kicks the player with the name \<player name\>. Optionally a \<reason\> can be provided in text-form. This text is also shown to the kicked player.
  * **/ban** - show list of banned players
  * **/ban \<player name\>** - Ban IP of player
  * **/unban \<player name\>** - Remove ban of player with the specified name
  * **/unban \<IP address\>** - Remove ban of player with the specified IP address

**Server-related**
**Informational**

Request some information from the server; the answer from the server will also be written into the chatlog.

  * **/admin** - Player name of the administrator / server operator of the server you're connected to.
  * **/status** - Server's Stonecraft version, time the server is running in seconds (called "uptime"), list of connected   * players and the message of the day (if it exists).
  * **/mods** - List of mods installed on the server.
  * **/days** - Current game day (counting starts at 0)
  * **/time** - Current game time (24h clock)

**World manipulation**

  * **/time \<hours\>:\<minutes\>** - Sets the time of day in the 24-hour format (0:00-23:59). Requires the "settime" privilege
  * **/time \<time_of_day\>** - Sets the time of day (tod) (number between 0 and 24000). 0 tod and 24000 tod are midnight, 12000 tod is noon, 18600 tod is sunset, 4750 tod is sunrise. (time of day = hour * 1000). Requires the "settime" privilege
  * **/set -n time_speed \<speed\>** - Sets the speed of day/night cycle where \<speed\> is the time speed (read as "\<speed\> times faster than in real life"). 72 is the default, which means a day-night cycle lasts 20 minutes by default. Requires the "server" privilege
  * **/spawnentity \<entity\> [\<X\>,\<Y\>,\<Z\>]** - Spawns an entity of type \<entity\> (see List of entity names) near your position or at the X,Y,Z coordinates, if specified. Requires "give" and "interact" privileges

**Server maintenance**

All of these commands require the "server" privilege.

  * **/shutdown** - Shuts down the server
  * **/set \<variable\>** - Shows the value of the given server \<variable\>
  * **/set \<variable\> \<new value\>** - Sets the existing server \<variable\> to the given \<new value\>
  * **/set -n \<variable\> \<initial value\>** - Creates a new server variable named \<variable\> and sets it to \<initial value\>
  * **/clearobjects [full|quick]** - Clears all objects/entities (removes all dropped items, mobs and possibly more). Note this may crash the server or slow it down to a crawl for 10 to more than 60 seconds
  * **/auth_reload** - Reloads auth.txt, which is the authentication data, containing privileges and Base64-scrambled passwords
  * **/deleteblocks here [\<radius\>]** - Removes the MapBlock the player is in, from the database. As this triggers mapgen, this might start mechanisms like mud reflow or cavegen which very likely affect mapblocks outside the specified range. 113 blocks are a safe-distance for a server with no interfering mods. \<radius\> is an optional argument to specify the range in which MapBlocks are deleted
  * **/deleteblocks \<pos1\> \<pos2\>** - Removes the MapBlock containing blocks inside the area from pos1 to pos2 from the database. May crash for larger areas. Warnings from above apply

**Rollback**

Allows to use Rollback. Requires the "rollback" privilege.

  * **/rollback_check [\<range\>] [\<seconds\>]** - Checks who has last touched a node or near it, max. \<seconds\> ago (default \<range\>=0, default \<seconds\>=86400, which equals 24 hours in real time).
  * **/rollback \<player name\> [\<seconds\>]** - Reverts actions of a player; default for \<seconds\> is 60
  * **/rollback :\<actor name\> [\<seconds\>]** - Reverts actions of an actor (not a player); default for \<seconds\> is 60

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
5. Create your schematic file with : **//mtschemcreate \<name of your schematic file\>**. Without extension .mts.

Your schematic will appears into the **worlds/\<my_world\>/schems** folder.

How to import a schematic file: 

1. Enter in your world (with WorldEdit enabled).
2. Grant yourself all privileges : **/grant singleplayer all**. 
3. Move a schematic file into the **worlds/\<my_world\>/schems** folder.
4. Press F5 to display the coordinates.
5. Select a position with : **//pos1**
6. Import your schematic file from the chosen position with : **//mtschemplace \<name of your schematic file\>**. Without extension .mts.

# Setting up a server

1. Start your server on your desired port
  * **Note**: It is recommended to leave the port at the default (30000)
2. Find out your internal IP of the computer you are running the server on
  * **Linux**: open a terminal and type ifconfig and hit enter
  * **Windows**: _Start → Run … → cmd.exe → ipconfig_
3. Check the port forwarding settings on your router
  * forward your chosen port for UDP (30000 if you left it default) to the internal IP
  * In addition, alter any firewalls you may have to pass the traffic at that port
4. To see how to run a server, please read the section below
5. Let your friends know your external IP
6. Add _server_announce = 1_ to your _stonecraft.conf_ to announce it to a public server list.

## Running a Server

### Linux

1. Open a terminal.
2. Type in _YOUR/STONECRAFT/DIRECTORY/bin/stonecraftserver_ or just drop the stonecraftserver executable (located in _/Stonecraft/bin/_) into the terminal **(PLEASE READ THE NOTES BELOW!)**
  * If you want to specify a specific game ID, the game ID choices are located in _/Stonecraft/games/_. Add in _--gameid thegameid_ to the end of the command.
  * If you get the error "Multiple worlds are available.", the world choices are located in _/Stonecraft/worlds/_. Add in _--worldname theWorld_ to the end of the command.
3. If your server crashes, then look at the debug.txt in _/Stonecraft/bin/_
4. Enjoy running a Stonecraft server!

For easy use you can create an file named stonecraftserver.sh, add the lines below and put it in your _/Stonecraft/bin/_ folder. To run the server, just run the file in a terminal.

```
#!/bin/bash -e

until ./stonecraftserver --worldname ../worlds/<YOUR-WORLD>; do
    echo "Server 'stonecraftserver' crashed with exit code $?. Respawning.." >&2
    sleep 1
done
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