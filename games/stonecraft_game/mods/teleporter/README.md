# MINETEST MOD teleporter #
-----------------------------------------------------------------

This mod makes it possible for players to teleport to other (known) destinations.

## How it Works: ##
This mod adds 2 new blocks (nodes) to the game. These are a teleporter and a receiver.

A teleporter teleports players, or items to the chosen receiver.
A teleporter must be linked to a receiver first, before you can use it.
One teleporter can only link to one receiver, you have to unlink it first, before using a new receiver.
a receiver can accessed by many teleporters.

just stand on a ready teleporter and you'll teleported to the receivers location.
it works with items too!

### Part 1: the receiver ###
Craft the receiver using;

```
copper ingot - steel ingot - copper ingot
steel ingot  - steel ingot - steel ingot
```

![craft_receiver.png](https://bitbucket.org/repo/anzb59/images/685871294-craft_receiver.png)

Or use the chat command `/giveme teleporter:receiver`.

Place the receiver at this destination where you want to teleport to.
You now have to enter a name and a short description

You are maybe allowed to make the receiver public. (read mor at public receiver)
If you want, you can mark this receiver as favorite (that receivers will marked with a ![teleporter_bookmark.png](https://bitbucket.org/repo/anzb59/images/4022584398-teleporter_bookmark.png) in the list)

### Part 2: the teleporter ###
Craft the teleporter using;

```
copper ingot - glass       - copper ingot
steel ingot  - mese block  - copper ingot
steel ingot  - steel ingot - steel ingot
```
![craft_teleporter.png](https://bitbucket.org/repo/anzb59/images/2855559446-craft_teleporter.png)

Or use the chat command `/giveme teleporter:teleporter`.

After you placed the teleporter all known receivers will appear in the list.
just choose one and click `OKAY`.
![setup_teleporter.png](https://bitbucket.org/repo/anzb59/images/1861039821-setup_teleporter.png)
If you are playing on a server there are maybe some public receivers, you can list it by checking `show the public receivers list`.
public receivers can be set by other players, or by server admin, there are maybe some interesting destinations.

----------------------

## Dependencies ##
* [db](https://forum.minetest.net/viewtopic.php?f=11&t=9276)  (download [here](https://bitbucket.org/adrido/db/downloads)).
* default (from minetest_game)
* minetest version 0.4.10 or above
* mesecons (optional)

## Download and installation ##
make sure you have the [db](https://forum.minetest.net/viewtopic.php?f=11&t=9276) mod installed.
you can get it [here](https://bitbucket.org/adrido/db/downloads).


1. visit [the download page](https://bitbucket.org/kingarthursteam/teleporter/downloads)
2. download the zip file or the zip file, that comes with db mod.
3. extract its content to `minetest/mods/`
4. rename the folder to just `teleporter`
5. start Minetest, select the world where you want to use it, and click `configure`
6. select teleporter from the list and click `enabled`

If this does not work, have a look into the [official Minetest Wiki](http://dev.minetest.net/Installing_Mods) how to install mods.

----------------------

## Bug reports/ Feature requests ##
just create a [new ticket](https://bitbucket.org/adrido/arrow_signs/issues/new), or post your question in the [Minetest forum](http://forum.minetest.net/viewtopic.php?f=11&t=2149).

----------------------

## License ##
![CC BY License](https://i.creativecommons.org/l/by/4.0/88x31.png)  
This work is licensed under a [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/).

----------------------

## About: public receivers ##
A public receiver is a receiver which is marked as public by the server admin.
They appear in the public receiver list, and every player is allowed to link a teleporter to it.

## About: the runes ##
The runes on the receiver and teleporter are not magic,or evil they are just `Futhark` (ᚠᚢᚦᚪᚱᛣ)
Futhark derived from their first six letters of the alphabet: ᚠ, ᚢ, Þ, ᚦ, ᚱ, and ᛣ.
Futhark is one of the oldest alphabet used in German and England (3rd Century)
if you are interested, you can look on Wikipedia:
http://en.wikipedia.org/wiki/Elder_Futhark and http://en.wikipedia.org/wiki/Runes
