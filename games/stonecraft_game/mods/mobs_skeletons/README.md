### MOBS SKELETONS

![](screenshot.png)

**_Adds skeletons._**

**Version:** 0.2.0
**Source code's license:** [EUPL v1.2][1] or later.
**Multimedia files' license:** see subfolders.

**Dependencies:** default (found in [Minetest Game][2], mobs ([Mobs Redo][3])
**Supported:** [bonemeal][4]


### Installation

Unzip the archive, rename the folder to mobs_skeletons and place it in
../minetest/mods/

If you only want this to be used in a single world, place it in
../minetest/worlds/WORLD_NAME/worldmods/

GNU+Linux - If you use a system-wide installation place it in
~/.minetest/mods/

For further information or help see:
https://wiki.minetest.net/Help:Installing_Mods


[1]: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32017D0863
[2]: https://github.com/minetest/minetest_game
[3]: https://forum.minetest.net/viewtopic.php?t=9917
[4]: https://forum.minetest.net/viewtopic.php?t=16446


# Changelog

## [0.1.0] - 2021-05-03

	- Initial release.

## [0.1.1] - 2021-05-03

	- Fixed wrong light damage settings.

## [0.2.0] - 2021-05-05

	- Support for "Bonemeal".

## [0.3.0] - 2023-04-29

	- Refactored code into single file.
	- Arrows use 3d-style "wielditem" with new texture.
	- Added new textures for spawn eggs.
	- Added 'mobs_skeletons.sunlight_kill' setting, when true only sunlight kills.
	- Skeletons now spawn day or night under a max light level of 6.
