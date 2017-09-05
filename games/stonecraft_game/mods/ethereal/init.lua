--[[

	Minetest Ethereal Mod (9th August 2016)

	Created by ChinChow

	Updated by TenPlus1

--]]

--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-05-14 MrCerealGuy: added intllib support

2017-09-05 modified by MrCerealGuy <mrcerealguy@gmx.de>
	added advanced mod control

--]]

if core.skip_mod("biomes") then return end

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

ethereal = {}
ethereal.leaftype = 0 -- 0 for 2D plantlike, 1 for 3D allfaces
ethereal.leafwalk = false -- true for walkable leaves, false to fall through
ethereal.cavedirt = true -- caves chop through dirt when true

-- Set following to 1 to enable biome or 0 to disable
if core.get_mod_setting("etheral_biomes_glacier")	~= false then ethereal.glaciers		= 1 else ethereal.glacier   = 0 end -- Ice glaciers with snow
if core.get_mod_setting("etheral_biomes_bamboo")	~= false then ethereal.bamboo 		= 1 else ethereal.bamboo 	= 0 end -- Bamboo with sprouts
if core.get_mod_setting("etheral_biomes_mesa")		~= false then ethereal.mesa 		= 1 else ethereal.mesa 		= 0 end -- Mesa red and orange clay with giant redwood
if core.get_mod_setting("etheral_biomes_alpine")	~= false then ethereal.alpine 		= 1 else ethereal.alpine 	= 0 end -- Snowy grass
if core.get_mod_setting("etheral_biomes_healing")	~= false then ethereal.healing 		= 1 else ethereal.healing 	= 0 end -- Snowy peaks with healing trees
if core.get_mod_setting("etheral_biomes_snowy")		~= false then ethereal.snowy 		= 1 else ethereal.snowy 	= 0 end -- Cold grass with pine trees and snow spots
if core.get_mod_setting("etheral_biomes_frost")		~= false then ethereal.frost 		= 1 else ethereal.frost 	= 0 end -- Blue dirt with blue/pink frost trees
if core.get_mod_setting("etheral_biomes_grassy")	~= false then ethereal.grassy 		= 1 else ethereal.grassy 	= 0 end -- Green grass with flowers and trees
if core.get_mod_setting("etheral_biomes_caves")		~= false then ethereal.caves 		= 1 else ethereal.caves 	= 0 end -- Desert stone ares with huge caverns underneath
if core.get_mod_setting("etheral_biomes_grayness")	~= false then ethereal.grayness 	= 1 else ethereal.grayness 	= 0 end -- Grey grass with willow trees
if core.get_mod_setting("etheral_biomes_grassytwo")	~= false then ethereal.grassytwo 	= 1 else ethereal.grassytwo = 0 end -- Sparse trees with old trees and flowers
if core.get_mod_setting("etheral_biomes_prairie")	~= false then ethereal.prairie 		= 1 else ethereal.prairie 	= 0 end -- Flowery grass with many plants and flowers
if core.get_mod_setting("etheral_biomes_jumble")	~= false then ethereal.jumble 		= 1 else ethereal.jumble 	= 0 end -- Green grass with trees and jungle grass
if core.get_mod_setting("etheral_biomes_junglee")	~= false then ethereal.junglee 		= 1 else ethereal.junglee	= 0 end -- Jungle grass with tall jungle trees
if core.get_mod_setting("etheral_biomes_esert")		~= false then ethereal.esert 		= 1 else ethereal.esert 	= 0 end -- Desert sand with cactus
if core.get_mod_setting("etheral_biomes_grove")		~= false then ethereal.grove 		= 1 else ethereal.grove 	= 0 end -- Banana groves and ferns
if core.get_mod_setting("etheral_biomes_mushroom")	~= false then ethereal.mushroom 	= 1 else ethereal.mushroom 	= 0 end -- Purple grass with giant mushrooms
if core.get_mod_setting("etheral_biomes_sandstone")	~= false then ethereal.sandstone 	= 1 else ethereal.sandstone = 0 end -- Sandstone with smaller cactus
if core.get_mod_setting("etheral_biomes_quicksand")	~= false then ethereal.quicksand 	= 1 else ethereal.quicksand = 0 end -- Quicksand banks
if core.get_mod_setting("etheral_biomes_plains")	~= false then ethereal.plains 		= 1 else ethereal.plains 	= 0 end -- Dry dirt with scorched trees
if core.get_mod_setting("etheral_biomes_savannah")	~= false then ethereal.savannah 	= 1 else ethereal.savannah 	= 0 end -- Dry yellow grass with acacia tree's
if core.get_mod_setting("etheral_biomes_fiery")		~= false then ethereal.fiery		= 1 else ethereal.fiery 	= 0 end -- Red grass with lava craters
if core.get_mod_setting("etheral_biomes_sandclay")	~= false then ethereal.sandclay 	= 1 else ethereal.sandclay 	= 0 end -- Sand areas with clay underneath


local path = minetest.get_modpath("ethereal")

dofile(path .. "/plantlife.lua")
dofile(path .. "/mushroom.lua")
dofile(path .. "/onion.lua")
dofile(path .. "/crystal.lua")
dofile(path .. "/water.lua")
dofile(path .. "/dirt.lua")
dofile(path .. "/leaves.lua")
dofile(path .. "/wood.lua")
dofile(path .. "/sapling.lua")
dofile(path .. "/strawberry.lua")
dofile(path .. "/fishing.lua")
dofile(path .. "/extra.lua")
dofile(path .. "/sealife.lua")
dofile(path .. "/fences.lua")
dofile(path .. "/gates.lua")
dofile(path .. "/mapgen.lua")
dofile(path .. "/food.lua")
dofile(path .. "/bonemeal.lua")
dofile(path .. "/compatibility.lua")
dofile(path .. "/stairs.lua")

if minetest.get_modpath("xanadu") then
	dofile(path .. "/plantpack.lua")
end

print (S("[MOD] Ethereal loaded"))
