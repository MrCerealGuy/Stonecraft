LuaCmd Minetest Mod
===================

This mod adds the useful debugging command /lua which executes its parameter
string as a Lua chunk, as if it were being run in the body of a function inside
some mod file.  Errors are reported to the player via in-game chat, as is
anything sent to the print() function.  For example, entering the command:

   /lua print("Hello self");

will result in the following output in the in-game chat console:

   issued command: /lua print("Hello self");
   Hello self

whereas entering the (erroneous) command:

   /lua ^

will result in the following output:

   issued command: /lua ^
   Server -!- ERROR: [string "/lua command"]:1: unexpected symbol near '^'

A slightly more useful example might be the command (note: though shown here
with line wrapping, it must actually be done on a single line):

   /lua for _, player in ipairs(minetest.get_connected_players()) do
        print(player:get_player_name()); end

Any player executing this command must have the new "lua" permission, as it is
about the most dangerous thing you could allow a player to do.  Also not
recommended for public servers.  Use at your own risk!

Required Minetest Version: (tested in 0.4.9)

Dependencies: (none)

Commands:
   * /lua <luaStatement>
   * /luaclear

Privileges: lua

Git Repo: https://github.com/prestidigitator/minetest-mod-luacmd

Change History
--------------

Version 1.0

* Released 2014-07-04
* First working version

Version 1.1

* Release 2014-07-04
* Variable 'me': reference to current player object
* Variable 'myname': current player's name
* Variable 'here': current player's position as a printable vector
* Made the print(...) function a little more useful: converts args to strings

Try the following commands:

   /lua me:set_physics_override({ jump = 10.0 });
   /lua print(myname);
   /lua print(here);

Version 1.2

* Release 2014-07-04
* Keeps "global" variables set by commands in a player-local context.
* Prevents setting of special variables (e.g. me, myname, here, print).
* Added /luaclear command to clear the player-local context.

To set true globals visible to mods and other players, use "_G.var = ...".  Can
also be used to get any globals hidden by specials and player-local variables.

Copyright and Licensing
-----------------------

All contents are the original creations of the mod author (prestidigitator).

Author: prestidigitator (as registered on forum.minetest.net)
License: WTFPL (all content)
