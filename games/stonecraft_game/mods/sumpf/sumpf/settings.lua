--[[

2016-05-04 modified by MrCerealGuy <mrcerealguy@gmx.de>
	increased mapgen_rarity

--]]

--This file contains configuration options for the swamp mod.

sumpf.enable_mapgen = true

--Generate swamps everywhere
sumpf.always_generate = false

--Enables smooth transition of biomes.
sumpf.smooth = true

--rarity in %
sumpf.mapgen_rarity = 8

--size of the generated… (has an effect to the rarity, too)
sumpf.mapgen_size = 100

--approximate size of smooth transitions
sumpf.smooth_trans_size = 4

--Disable for testing
sumpf.enable_plants = true

--Enables swampwater - it might be a bit buggy with mapgen v6.
sumpf.swampwater = true

--adds swampwater near sea (different behaviour)
sumpf.wet_beaches = sumpf.swampwater

--chance of spawning a hut in a mapchunk, set to 0 to disable it
sumpf.hut_chance = 50

--habitat stuff
sumpf.spawn_plants = true

--says some information.
sumpf.info = true

--informs the players too
sumpf.inform_all = false--minetest.is_singleplayer()

--1:<a bit of information> 2:<acceptable amount of information> 3:<lots of text>
sumpf.max_spam = 2
