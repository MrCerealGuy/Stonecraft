--[[

2017-10-18 modified by MrCerealGuy <mrcerealguy@gmx.de>
	added advanced mod control

--]]

--This file contains configuration options for riesenpilz mod.

riesenpilz.enable_mapgen = true

--Generate giant mushroom biomes everywhere
if core.get_mod_setting("giantmushrooms_always_generate") ~= nil then riesenpilz.always_generate = core.get_mod_setting("giantmushrooms_always_generate") else riesenpilz.always_generate = false end

--Enables smooth transition of biomes.
if core.get_mod_setting("giantmushrooms_smooth") ~= nil then riesenpilz.smooth = core.get_mod_setting("giantmushrooms_smooth") else riesenpilz.smooth = true end

--rarity in %
if core.get_mod_setting("giantmushrooms_mapgen_rarity") ~= nil then riesenpilz.mapgen_rarity = core.get_mod_setting("giantmushrooms_mapgen_rarity") else riesenpilz.mapgen_rarity = 0.4 end

--size of the generated... (has an effect to the rarity, too)
riesenpilz.mapgen_size = 200

--approximate size of smooth transitions
riesenpilz.smooth_trans_size = 2

--says some information.
riesenpilz.info = true

--informs the players too
riesenpilz.inform_all = false--minetest.is_singleplayer()

--1:<a bit of information> 2:<acceptable amount of information> 3:<lots of text>
riesenpilz.max_spam = 2

--3d apple
riesenpilz.change_apple = true

--disallows growing a mushroom if it not every node would have a free place
riesenpilz.giant_restrict_area = false
