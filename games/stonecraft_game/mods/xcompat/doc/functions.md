# Functions API

## `can_interact_with_node(player, pos)`
returns `bool`

checks for the ability to interact with a node via:
* if a player
* owner metadata key
* protection_bypass

supports
* minetest game default if present
* else polyfill