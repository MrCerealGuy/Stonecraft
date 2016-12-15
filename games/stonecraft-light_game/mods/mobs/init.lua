local path = minetest.get_modpath("mobs")

-- Mob Api

dofile(path.."/api.lua")

-- Animals

dofile(path.."/chicken.lua") -- JKmurray
dofile(path.."/cow.lua") -- KrupnoPavel
dofile(path.."/rat.lua") -- PilzAdam
dofile(path.."/sheep.lua") -- PilzAdam
dofile(path.."/warthog.lua") -- KrupnoPavel
dofile(path.."/bee.lua") -- KrupnoPavel
dofile(path.."/bunny.lua") -- ExeterDad
dofile(path.."/kitten.lua") -- Jordach/BFD

-- Monsters

dofile(path.."/dirtmonster.lua") -- PilzAdam
dofile(path.."/dungeonmaster.lua")
dofile(path.."/oerkki.lua")
dofile(path.."/sandmonster.lua")
dofile(path.."/stonemonster.lua")
dofile(path.."/treemonster.lua")
dofile(path.."/lava_flan.lua") -- Zeg9
dofile(path.."/mese_monster.lua")
dofile(path.."/spider.lua") -- AspireMint

-- NPC
dofile(path.."/npc.lua") -- TenPlus1

-- Mob Items
dofile(path.."/crafts.lua")

-- Spawner
dofile(path.."/spawner.lua")

print ("[MOD] Mobs Redo loaded")