Version: 2.0
Author: Sokomine
Liscence: GPLv3.0

Snow for stairs, slabs and nodeboxes.
Due to the very nature of nodes in Minetest, the snow cannot
handle all situations. Moresnow is made for roofs (which do look
better with a snow cover in winter), slabs, fences etc.

The texture for the winter leaves (the snowy ones) is taken from Moontest,
which can be found at https://github.com/Amaz1/moontest/tree/master/mods/moontest


*Autum and winter leaves*

Fallen autumn leaves and winter leave blocks for trees can be enabled:
    `moresnow.enable_autumnleaves = true`
They're pretty decorative.


*Wool covers*

The wool covers used to be defined for each wool color seperately. Many
nodes were created. That's not ideal for servers.

If you did use an older version of the moresnow mod *and* players have
used the wool layers for building, please set
    `moresnow.enable_legacy_wool = true`

All others are better off with just setting
    `moresnow.enable_wool_cover = true`

The new version creates nodes of the type `moresnow:wool_multicolor`.
You can craft them like this:
    `wool:white default:stick -`
    `     -          -        -`
    `     -          -        -`

There are 64 colors available.

Note: In the following craft receipes,
      `m` stands for `moresnow:wool_multicolor`, and
      `d` stands for a dye of any color

In order to craft the one approximating wool colors best, craft:
    `m d -`
    `- - -`
In order to get the darker variant, craft:
    `m - d`
    `- - -`
In order to get plain colors (i.e. `red`, `blue`, ...), craft:
    `m - -`
    `- d -`
In order to get pastel colors, craft:
    `m - -`
    `- - d`
As there are 64 colors available and only 15 wool and dye colors, the
extra four colors can be crafted by replacing the dye in the craft
receipe above with `wool:white`.

Usage: Wield `moresnow:wool_multicolor` and place it either on flat
ground for a carpet, on a stair, a slab, an inner or outer stair,
a microblock or a panel. Less shapes than for moresnow are supported.
After you've placed the wool layer and it has adjusted to the shape
below, you can remove the stair or slab etc. that gave the wool its
shape and replace that node with something else to your liking.
Unlike the snow and leaves nodes, the wool is not a falling node and
will stay where it is.


*Snow cannon*

The snow cannon is an easy way to cover an area (usually 8x8) with
snow without having to place it manually. Set
    `moresnow.enable_snow_cannon  = true`
in order to enable the snow cannon as such.

If you set
    `moresnow.crazy_mode          = true`
then the snow cannon can be set into a mode where it shoots snowballs
randomly around. They may land quite far away from the cannon. It is
very fun to watch but perhaps not ideal for servers.


More documentation can be found in the [Minetest forum](https://forum.minetest.net/posting.php?f=9&t=9811&p=149257) and/or
in the [Wiki](https://github.com/Sokomine/moresnow/wiki).
