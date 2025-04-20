# MOBS REDO for MINETEST

Built from PilzAdam's original Simple Mobs with additional mobs by KrupnoPavel,
Zeg9, ExeterDad and AspireMint.

This mod contains the API only for adding your own mobs into the world, so
please use the additional modpacks to add animals, monsters, and npcs.

https://forum.minetest.net/viewtopic.php?f=11&t=9917

## Crafts

- **Nametag**. Can be crafted by paper, black dye, and string. Can be used
  to right-click on a tamed mob to give them a name.
- **Net**. Used to right-click tamed mobs to pick them up and place inside
  inventory as a spawn egg.
- **Magic lasso**. Similar to nets but with a better chance of picking up
  larger mobs.
- **Shears**. Used to right-click sheep and return 1-3 wool.
- **Protection Rune**. Protects tamed mobs from being harmed by other players.
- **Mob Fence and Fence Top**. Stops mobs escaping or glitching throughfences.
- Add mobs:mob_repellent block to stop mobs spawning within 16 node radius.

**Lucky Blocks**: 13

## Changelog

### Version 1.62

* Added ability for mobs to hear using self.on_sound() function
* Added 'mobs_can_hear' setting to turn above feature on/off
* Added {eatable} group to food items and HP in description
* Fixed timer bug when attacking
* Fixed fall damage check when riding mob
* Calculate damage before do_punch function called
* Add function to check for dropped items and for mob to do something with them

### Version 1.61

* Fixed mob damage when riding mobs
* Added entity:is_inside(itemtable) function (thx cora)
* Added self.attack_patience value so mobs stop attacking unseen players
* Added self.homing so that arrows follow player when visible
* Added support for Visual Harm 1ndicators mod to show health bars
* Added self.node_damage flag which is true by default to enable damage_per_second node damage
* Added check for on_death() function before using mob api's own on_die() one
* Added mobs:fallback_node for when current [game] hasn't defined mapgen_dirt node

### Version 1.60

* Move mob and arrow entities to use initial_properties
* Spawn eggs check if mob is available when creating
* Used get/set_properties() within API for mob properties
* Moved nametag variable to self._nametag
* Tidied breeding function
* Better MineClone2 / MineClonia support added
* Tweaked and tidied code in places

### Version 1.57

* Added 'injured' animation when mob hurt
* Fixed yaw clamping to stop spinning mobs
* Added 'mob_node_timer_interval' and 'mob_main_timer_interval' settings
* Added ability for mobs to die only in natural daylight
* Refactored do_jump and added get_nodes function
* Many bug fixes and tweaks to improve performance
* Added 'mobs_attack_creatura' setting so that monsters can attack Creatura mobs
* Nodes can be added to 'runaway_from' table
* Better Mineclone2 compatibility with api, items and recipes
* Added 'mob_log_spawn' setting to log spawning of mobs and position

### Version 1.56

* Added `arrow_override` function to mob definition to tweak arrow entity settings
* Added injured animation and mob hit effect
* Tamed monsters no longer despawn when outside loaded map area
* `looting_level` can be read from tool definition or tool meta to add extra
  drops when mob killed

### Version 1.55

* Added `peaceful_player` privilege and setting so mobs don't attack specific
  players (thanks sfence)
* Added support for MarkBu's `pathfinder` mod, remove need for default mod

### Version 1.54

* **New support for swimming mobs**
  - `on_flop` (for mobs not in water)
  - `air_damage` added
* Added editable settings (thanks Wuzzy)
* Simplified animal breeding function
* Child mobs now take twenty minutes to grow up
* Reverted to simple mob spawning with setting to use area checks

### Version 1.53

* Added `on_map_load` settings to `mobs:spawn` so that mobs will only spawn
  when new areas of map are loaded.

### Version 1.52

* Added `mob_active_limit` in settings to set number of mobs in game. The
  default is 0, for unlimited mobs.
* Removed `{immortal}` from mob armor
* Fluid viscocity slows mobs (for example, water)

### Version 1.51

* Added node checks for dangerous nodes
* Add `mob_nospawn_range` setting
* Jumping and falling tweaks
* Spawn area check (thanks for idea wuzzy)
* Re-enabled mob suffocation

### Version 1.50

* Added new `line_of_sight` function that uses raycasting if Minetest 5.0 is
  found, (thanks Astrobe)
* Added Chinese local
* Removed ability to spawn mobs if world anchor nearby (`technic` or
  `simple_anchor` mods)

### Version 1.49

* Added `mobs:force_capture(self, player)` function
* API functions now use metatables thanks to bell07

### Version 1.48

* Added `mobs:set_velocity(self, velocity)` global function [deprecated]

### Version 1.47

* Added minimum and maximum light level for damage
* Mob damage changes
* Ignition sources checked for lava damage

### Version 1.46

* Mobs only drop rare items when killed by player. You can make change the
  drops to rare items by using `drops.min = 0`
* Pathfinding no longer sees through walkable nodes

### Version 1.45

* Added fence top to add on top of any fence to stop mobs escaping
* New `line_of_sight` tweaked by `Astrobe`

### Version 1.44

* Added `ToolRanks` support for swords when attacking mobs

### Version 1.43

* Added general attack function and settings
* Better Minetest 0.4.16 compatibility

### Version 1.42

* Added `"all"` option to `immune_to` definition table
* Tidied floating mobs to be less intensive

### Version 1.41

* Mob pathfinding has been updated thanks to `Elkien3`

### Version 1.40

* Updated to use newer functions, requires Minetest 0.4.16+ to work

### Version 1.39

* **New custom functions**:
  - `on_breed` (called when mobs have just been bred)
  - `on_grown` (called when baby mobs have grown up)
  - `do_punch` (called when the mob has been punched or damaged by another mob)

### Version 1.38

* Better entity checking
* Nametag setting
* `on_spawn` function added to mob registry
* Tweaked light damage

### Version 1.37

* Added support for `Raymoo`'s CMI (common mob interface) mod. See
  https://forum.minetest.net/viewtopic.php?f=9&t=15448 for details

### Version 1.36

* Added death check. If the mob dies in fire/lava/with lava pick, then drops
  are cooked

### Version 1.35

* Added `owner_loyal` flag for owned mobs to attack player enemies
* Fixed `group_attack`

### Version 1.34

* Added function to fly mob using directional movement (thanks D00Med for
  flying code)

### Version 1.33

* Added functions to mount ride mobs:
  - `mobs.attach`
  - `mobs.detach`
  - `mobs.drive`. Many thanks to `Blert2112`

### Version 1.32

* Added new spawn check to count specific mobs AND new `minetest.conf` setting
  to chance spawn chance and numbers
* Added ability to protect tamed mobs

### Version 1.31

* Added `attack_animals` and `specific_attack` flags for custom monster
  attacks
* Added 'mob_difficulty' .conf setting to make mobs harder

### Version 1.30

* Added support for `invisibility` mod
* Tweaked and tidied code

### Version 1.29

* Split original Mobs Redo into a modpack to make it easier to disable mob sets
  (animal, monster, npc) or simply use the API itself for your own mod

### Version 1.28

* Added new damage system with ability for mob to be immune to weapons or
  healed by them :)

### Version 1.27

* Added new sheep, lava flan and spawn egg textures
* New Lava Pick tool smelts what you dig
* New `atan` checking function

### Version 1.26

* Pathfinding feature added thanks to rnd
* When monsters attack they become scary smart in finding you :)
* Beehive produces honey now :)

### Version 1.25

* Mobs no longer spawn within 12 blocks of player or despawn within same
  range
* Spawners now have player detection
* Tidy and tweak code

### Version 1.24

* Added feature where certain animals run away when punched
  (`runaway = true` in mob definition)

### Version 1.23

* Added mob spawner block for admin to setup spawners in-game (place and
  right-click to enter settings)

### Version 1.22

* Added ability to name tamed animals and NPCs using nametags
* NPCs will attack anyone who punches them apart from owner

### Version 1.21

* Added some more error checking to reduce `serialize.h` error and added height
  checks for falling off cliffs (thanks `cmdskp`)

### Version 1.20

* Error checking added to remove bad mobs
* Out of map limit mobs and stop `serialize.h` error

### Version 1.19

* Chickens now drop egg items instead of placing the egg
* Throwing eggs result in ⅛ chance of spawning chick

### Version 1.18

* Added `docile_by_day` flag so that monsters will not attack automatically
  during daylight hours unless hit first

### Version 1.17

* Added `dogshoot` attack type. Mobs now shoot when out of reach
* Melee attack when in reach, also API tweaks and `self.reach` added

### Version 1.16

* Mobs follow multiple items now
* NPCs can now breed

### Version 1.15

* Added feeding, taming, and breeding function
* Right-click to pick up any sheep with X mark on them and replace with new one
  to fix compatibility.

### Version 1.14

* All variables saved in staticdata
* Fixed health bug

### Version  1.13

* Added capture function (thanks `blert2112`) chance of picking up mob with a
  hand, a net, or a magic lasso
* Replaced some `.x` models with newer `.b3d` ones

### Version 1.12

* Added animal ownership so that players cannot steal your tamed animals

### Version 1.11

* Added flying and swimming mobs
* `fly=true` and `fly_in="air"` or `"default:water_source"` for fishy

### Version 1.10

* Added explosion routine for exploding mob
* Footstep removed (use replace)

### Version 1.09


* Added mob rotation value
* Added footstep feature
* Added jumping mobs with sounds feature
* Aadded magic lasso for picking up animals
* Reworked breeding routine

### Version 1.08

* Added drops that appear when mob is killed
* New custom function: `on_die` function
* Mob throwing attack has been rehauled so that they can damage one another,

### Version 1.07

* NPCs can now be set to follow player or stand by using `order` and `owner`
  variables

* BETA: Npc mob added. They kill monsters (maybe as guards) and attack players
  when punched by them. Right-clicking them with food will heal them, and
  giving them gold lump will make them drop a random item.

### Version 1.06

* Changed recovery times after breeding. Time taken to grow up can be sped up
  by feeding the baby animal.

### Version 1.05

* Added `ExeterDad`'s bunniess which can be picked up and tamed with four carrots from `farming_redo` or `farming_plus`
* Added shears to get wool from sheep
* Added Jordach/BSD's kitten

### Version 1.04

* Added mating for sheep, cows and hogs
* Added feature to feed animals to make horny and hope for a baby which is half
  size, they will grow up quick though :)

### Version 1.03

* Added mob drop/replace feature so that chickens can drop eggs and cow/sheep
  can eat grass/wheat etc.

### Version 1.02

* Sheared sheep are remembered and spawn shaven
* Warthogs will attack when threatened
* API additions

### Version 1.01

* Mobs that suffer fall damage or die in water/lava/sunlight will now drop
  items

### Version 1.0

* More work on API so that certain mobs can float in water while some sink like
  a brick :)

### Version 0.9

* Spawn eggs added for all mobs (admin only, cannot be placed in protected
  areas)
* Tweaked API

### Version 0.8

* Added sounds to monster mobs (thanks `Cyberpangolin` for the `sfx`)
* Added chicken sound
### Version 0.7

* `mobs.protected` switch added to `api.lua`. When set to 1 mobs no longer
  spawn in protected areas
* Minor bugfixes

### Version 0.6

* API now supports multi-textured mobs, e.g oerkki, dungeon master, rats and
  chickens have random skins when spawning (sheep fix TODO)
* Added new Honey block

### Version 0.5

* Mobs now float in water, die from falling
* Minor code improvements

### Version 0.4

* Added new sheep sound :)
* Dungeon Masters and Mese Monsters have much better aim due to `shoot_offset`
* They can both shoot through nodes that aren't walkable (flowers, grass, etc.)

### Version 0.3

* Added `LOTT`'s Spider mob
* Added Cobwebs
* Added KPavel's Bee with Honey and Beehives (made texture)
* Warthogs now have sound and can be tamed
* Taming of shaved sheep or milked cow with 8 wheat so it will not despawn
* Multiple bug fixes :)

### Version 0.2

* Cooking bucket of milk into cheese now returns empty bucket

### Version 0.1

* Initial Release
