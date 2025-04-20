Ambience Redo mod for Minetest
 by TenPlus1

Based on Immersive Sounds .36 mod by Neuromancer and optimized to run on servers with new fire sounds added when Fire Redo mod is detected...

- 0.1 - Initial release
- 0.2 - Code change and new water sounds added
- 0.3 - Works with Fire Redo mod to provide fire sounds
- 0.4 - Code optimized
- 0.5 - Changed to kilbiths smaller sound files and removed canadianloon1, adjusted timings
- 0.6 - Using new find_nodes_in_area features to count nodes and speed up execution (thanks everamzah)
- 0.7 - Code tweaks and added Jungle sounds for day and night time
- 0.8 - Override default water sounds for 0.4.14 dev and above, add separate gain for each sound
- 0.9 - Plays music files on server or local client when found at midnight, files to be named "ambience_music.1.ogg" changing number each up to 9.
- 1.0 - Added icecrack sound when walking on snow/ice flows, also tidied code
- 1.1 - Using newer functions, Minetest 0.4.16 and above needed to run
- 1.2 - Added PlayerPlus compatibility, removed fire sounds, added volume changes
- 1.3 - Added API for use with other mods, code rewrite
- 1.4 - Re-ordered water sets to come before fire and lava, day/night sounds play when leaves around and above ground
- 1.5 - Added 'flame_sound' and fire redo check, code tidy and tweak, added ephemeral flag for background sounds.
- 1.6 - Finding env_sounds disables water and lava sets, added 'ambience_water_move' flag to override water walking sounds, use eye level for head node.
- 1.7 - Music will play every 20-30 minutes if found, use '/mvol 0' to stop playing music or disable in-game.
- 1.8 - Players can set induvidual volume for sound and music which is saved.
- 1.9 - Tidy code, refactor music playing, add biome name to sound_check.
- 2.0 - Add Mineclone support, add ethereal leaf check, remove minetest.after for custom timer, add Polish translation, tweak & tidy code.
- 2.1 - Add ambience.group_total() function for easy counting of group: nodes inside a set.

Code license: MIT
