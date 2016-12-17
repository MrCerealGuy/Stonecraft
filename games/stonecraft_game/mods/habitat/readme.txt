 __   __  _______  _______  ___   _______  _______  _______ 
|  | |  ||   _   ||  _    ||   | |       ||   _   ||       |
|  |_|  ||  |_|  || |_|   ||   | |_     _||  |_|  ||_     _|
|       ||       ||       ||   |   |   |  |       |  |   |  
|       ||       ||  _   | |   |   |   |  |       |  |   |  
|   _   ||   _   || |_|   ||   |   |   |  |   _   |  |   |  
|__| |__||__| |__||_______||___|   |___|  |__| |__|  |___|  

BY:             bas080
DESCRIPTION:    Adds the function to spawn nodes near certain nodes and away from others on world generate
VERSION:        0.5
LICENCE:        WTFPL
FORUM:          http://forum.minetest.net/viewtopic.php?id=4612

Instructions

habitat:generate(node, surfaces, minp, maxp, height_min, height_max, spread, habitat_size, habitat_nodes, antitat_size, antitat_nodes)

* height is the altitude between the node spawns
* spawn near habitat nodes
* avoids antitat nodes
* spread determines how near they spawn next to eachother

Example (from plants mod)

habitat:generate("plants:lavender_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 60, 4, 4, {"default:sand",})

TODO

1.1
* Make node string argument nodes array that spawns random nodes in array

Changelog

1.0
* Reduce amount of loops even more by changing surfaces array to surface string

0.5
* changed function definition (name)
* Improved for loop. Less looping and node checking

0.1
* Spawn plants on generate
