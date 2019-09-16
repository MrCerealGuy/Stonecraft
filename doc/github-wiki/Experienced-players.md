1. [Experienced players](#experienced-players)
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

# Experienced players

## Area protection

To protect your area from griefing by other player, choose the first corner on the ground of your area you want to protect. Then open the console with F10 and set the marker with **/area_pos1**.

![](/doc/github-wiki/images/areapos1.jpg)

Now select the second corner in opposite direction of the first corner above the ground and set the marker with the command **/area_pos2**.

![](/doc/github-wiki/images/areapos2.jpg)

Now it's time to protect your area with **/protect &lt;description&gt;**, eg. /protect "My Home".

## Teleporters

A teleporter pad teleports players, or items to the linked receiver pad. A teleporter must be linked to a receiver first, before you can use it. One teleporter pad can only be linked to one receiver pad, you have to unlink it first, before using a new receiver. A receiver pad can accessed by many teleporter pads.

Example:

If you find an interesting location, then you can place a receiver pad.

![](/doc/github-wiki/images/teleporter1.jpg)

Do a right-click on the pad. You have enter a name and a optional description for your receiver pad. For servers you can make your receiver pad public for other players.

![](/doc/github-wiki/images/teleporter2.jpg)

Now your receiver pad is placed. At home you can place a teleporter pad.

![](/doc/github-wiki/images/teleporter3.jpg)

Do a right-click on the pad and select your receiver pad.

![](/doc/github-wiki/images/teleporter4.jpg)

Now you have linked the teleporter with the receiver pad.

![](/doc/github-wiki/images/teleporter5.jpg)

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

![](/doc/github-wiki/images/600px-WorldEdit.png)

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

![](/doc/github-wiki/images/600px-MinetestWE1.png)

The marked area is always made visible with a check pattern. In the first example you can not see it, because it is in the ground.

![](/doc/github-wiki/images/600px-MinetestWE2.png)


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