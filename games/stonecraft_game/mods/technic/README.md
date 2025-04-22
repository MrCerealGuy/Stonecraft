Technic
-----------------

A mod for [minetest](http://www.minetest.net)

![integration-test](https://github.com/mt-mods/technic/workflows/integration-test/badge.svg)
![luacheck](https://github.com/mt-mods/technic/workflows/luacheck/badge.svg)
![mineunit](https://github.com/mt-mods/technic/workflows/mineunit/badge.svg)
![](https://byob.yarr.is/mt-mods/technic/coverage)

[![License](https://img.shields.io/badge/license-LGPLv2.0%2B-purple.svg)](https://www.gnu.org/licenses/old-licenses/lgpl-2.0.en.html)
[![ContentDB](https://content.minetest.net/packages/mt-mods/technic_plus/shields/downloads/)](https://content.minetest.net/packages/mt-mods/technic_plus/)


# Overview

<img src="./technic/doc/images/Technic Screenshot.png"/>

The technic modpack extends the Minetest game with many new elements,
mainly constructable machines and tools.  It is a large modpack, and
tends to dominate gameplay when it is used.  This manual describes how
to use the technic modpack, mainly from a player's perspective.

The technic modpack depends on some other modpacks:

* the basic Minetest game
* mesecons, which supports the construction of logic systems based on
  signalling elements
* pipeworks, which supports the automation of item transport
* moreores, which provides some additional ore types
* basic_materials, which provides some basic craft items

This manual doesn't explain how to use these other modpacks, which have
their own manuals:

* [Minetest Game Documentation](https://wiki.minetest.net/Main_Page)
* [Mesecons Documentation](http://mesecons.net/items.html)
* [Pipeworks Documentation](https://gitlab.com/VanessaE/pipeworks/-/wikis/home)
* [Moreores Forum Post](https://forum.minetest.net/viewtopic.php?t=549)
* [Basic materials Repository](https://gitlab.com/VanessaE/basic_materials)

Recipes for constructable items in technic are generally not guessable,
and are also not specifically documented here.  You should use a
craft guide mod to look up the recipes in-game.  For the best possible
guidance, use the unified\_inventory mod, with which technic registers
its specialised recipe types.

# Documentation

Ingame:

* [Resources](./technic/doc/resources.md)
* [Substances](./technic/doc/substances.md)
* [Processes](./technic/doc/processes.md)
* [Chests](./technic/doc/chests.md)
* [Radioactivity](./technic/doc/radioactivity.md)
* [Electrical power](./technic/doc/power.md)
* [Powered machines](./technic/doc/machines.md)
* [Generators](./technic/doc/generators.md)
* [Forceload anchor](./technic/doc/anchor.md)
* [Digilines](./technic/doc/digilines.md)
* [Mesecons](./technic/doc/mesecons.md)
* [Tools](./technic/doc/tools.md)

Mod development:

* [Api](./technic/doc/api.md)

subjects missing from this manual:

* frames
* templates

## FAQ

1. My technic circuit doesn't work.  No power is distributed.
   * A: Make sure you have a switching station connected.

# Notes

This is a maintained fork of https://github.com/minetest-mods/technic with various enhancements.
Suitable for multiplayer environments.

* Chainsaw and HV Quarry re-implementation (@OgelGames)
* Switching station lag/polyfuse and globalstep execution (@BuckarooBanzay)
* No forceload hacks
* Additional HV machines (@h-v-smacker)
* LV, MV, and HV digiline cables (@S-S-X and @SwissalpS)
* various others...

## Compatibility

This mod is meant as a **drop-in replacement** for the upstream `technic` mod.
It also provides some additional machines and items, notably:

* HV Grinder, Furnace, and Compressor
* LV Lamp
* LV, MV, and HV Digiline cables

# Recommended mods

Dependencies:

* https://github.com/minetest-mods/mesecons
* https://github.com/minetest-mods/moreores
* https://gitlab.com/VanessaE/pipeworks
* https://gitlab.com/VanessaE/basic_materials

Recommended optional Dependencies:

* https://github.com/minetest-mods/digilines

Recommended mods that build on the `technic mod`:

* https://github.com/mt-mods/jumpdrive
* https://github.com/OgelGames/powerbanks

# Settings (worldpath/technic.conf)

| Configuration key                            | Description
|----------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| enable_mining_drill                          |                                                                                                                       |
| enable_mining_laser                          |                                                                                                                       |
| enable_flashlight                            |                                                                                                                       |
| enable_wind_mill                             |                                                                                                                       |
| enable_frames                                |                                                                                                                       |
| enable_corium_griefing                       |                                                                                                                       |
| enable_radiation_protection                  |                                                                                                                       |
| enable_radiation_throttling                  | enable lag- and per-second-trottling of radiation damage                                                              |
| enable_entity_radiation_damage               |                                                                                                                       |
| enable_longterm_radiation_damage             |                                                                                                                       |
| enable_nuclear_reactor_digiline_selfdestruct |                                                                                                                       |
| admin_priv                                   | Privileges required to use administrative chat commands like cache flushing and enabling/disabling machines globally. |
| quarry_max_depth                             | max depth of the quarry.                                                                                              |
| quarry_time_limit                            | max cpu time in μs allowed per quarry step.                                                                           |
| quarry_dig_above_nodes                       | begin digging this many nodes above quarry node.                                                                      |
| network_overload_reset_time                  | After network conflict wait this many seconds before attempting to activate conflicting networks again.               |
| switch_max_range                             | max cable length.                                                                                                     |
| switch_off_delay_seconds                     | switching station off delay.                                                                                          |

See defaults for settings here: [technic/config.lua](https://github.com/mt-mods/technic/blob/master/technic/config.lua)

# Chat commands

* **/technic_flush_switch_cache** clears the switching station cache (stops all unloaded switches)
* **/powerctrl [on|off]** enable/disable technic power distribution globally

# Contributors

* kpoppel
* Nekogloop
* Nore/Ekdohibs
* ShadowNinja
* VanessaE
* BuckarooBanzay
* OgelGames
* int-ua
* S-S-X
* H-V-Smacker
* groxxda
* SwissalpS
* And many others...

# License

Unless otherwise stated, all components of this modpack are licensed under the
LGPL, V2 or later.  See also the individual mod folders for their
secondary/alternate licenses, if any.
