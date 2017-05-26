--[[


2016-05-03 modified by MrCerealGuy <mrcerealguy@gmx.de>
	removed flying_duck

--]] 

-- Spawning parameters

-- ANTS
nssm:spawn_specific("nssm:ant_queen", {"nssm:ant_dirt"}, {"air"}, 0, 20, 60, 200, 1, -31000, 31000)
nssm:spawn_specific("nssm:ant_soldier", {"nssm:ant_dirt"}, {"air"}, 0, 20, 7, 30, 4, -31000, 31000)
nssm:spawn_specific("nssm:ant_worker", {"nssm:ant_dirt"}, {"air"}, 0, 20, 5, 10, 5, -31000, 31000)

-- SPIDERS
nssm:spawn_specific("nssm:black_widow", {"default:jungle_grass", "default:jungletree", "nssm:web" }, {"air"}, 0, 20, 20, 1000, 2, -31000, 31000)
nssm:spawn_specific("nssm:daddy_long_legs", {"default:jungle_grass", "default:jungletree", "nssm:web" }, {"air"}, 0, 20, 10, 1000, 2, -31000, 31000)
nssm:spawn_specific("nssm:tarantula", {"default:jungle_grass", "default:jungletree", "nssm:web" }, {"air"}, 0, 14, 120, 5000, 1, -31000, 31000)
nssm:spawn_specific("nssm:uloboros", {"default:jungle_grass", "default:jungletree", "nssm:web" }, {"air"}, 0, 20, 20, 1000, 1, -31000, 31000)

-- CAVES
nssm:spawn_specific("nssm:bloco", {"default:stone"}, {"default:stone"}, 0, 20, 30, 500, 3, -31000, -20)
nssm:spawn_specific("nssm:lava_titan", {"default:stone"}, {"air"}, 0, 120, 12, 8000, 1, -31000, -50)
nssm:spawn_specific("nssm:stone_eater", {"default:stone"}, {"default:stone"}, 0, 20, 40, 700, 2, -31000, -20)
nssm:spawn_specific("nssm:signosigno", {"default:stone"}, {"default:stone"}, 0, 10, 20, 400, 2, -31000, -20)
nssm:spawn_specific("nssm:signosigno", {"bones:bones"}, {"air"}, 0, 15, 3, 1, 5, -31000, 31000)

-- SEA
nssm:spawn_specific("nssm:crab", {"default:sand"}, {"default:water_source"}, 0, 20, 20, 3000, 1, -31000, 31000)
nssm:spawn_specific("nssm:crocodile", {"default:sand","default:water_source"}, {"default:water_source"}, 0, 20, 60, 35000, 1, -31000, 31000)
nssm:spawn_specific("nssm:dolidrosaurus", {"default:water_source"}, {"default:water_source"}, 0, 20, 60, 35000, 1, -31000, -1)
nssm:spawn_specific("nssm:kraken", {"default:water_source"}, {"default:water_source"}, 0, 20, 120, 90000, 1, -31000, 0)
nssm:spawn_specific("nssm:octopus", {"default:water_source"}, {"default:water_source"}, 0, 20, 60, 40000, 1, -31000, 0)

-- DESERT
nssm:spawn_specific("nssm:sandworm", {"default:desert_sand", "default:desert_stone"}, {"air"}, 0, 20, 20, 30000, 1, -31000, 31000)
nssm:spawn_specific("nssm:giant_sandworm", {"default:desert_sand", "default:desert_stone"}, {"air"}, 0, 20, 1200, 40000, 1, -31000, 31000)
nssm:spawn_specific("nssm:sand_bloco", {"default:desert_sand", "default:desert_stone"}, {"air"}, 0, 20, 20, 30000, 1, -31000, 31000)

-- DUCKS
nssm:spawn_specific("nssm:duck", {"default:dirt_with_grass"}, {"group:flora"}, 10, 20, 20, 200, 1, -31000, 31000)
nssm:spawn_specific("nssm:duckking", {"default:dirt_with_grass"}, {"group:flora"}, 10, 20, 120, 3000, 1, -31000, 31000)
nssm:spawn_specific("nssm:enderduck", {"default:dirt_with_grass"}, {"group:flora"}, 0, 10, 45, 900, 1, -31000, 31000)
--nssm:spawn_specific("nssm:flying_duck", {"air"}, {"group:flora"}, 10, 20, 60, 550, 1, 1, 31000)
nssm:spawn_specific("nssm:spiderduck", {"default:dirt_with_grass"}, {"group:flora"}, 0, 10, 45, 850, 1, -31000, 31000)
nssm:spawn_specific("nssm:swimming_duck", {"default:water_source"}, {"default:water_source"}, 0, 20, 60, 45000, 1, -31000, 31000)

-- MOUNTAINS
nssm:spawn_specific("nssm:echidna", {"default:dirt_with_grass"}, {"default:dirt_with_grass"}, 0, 20, 120, 45000, 1, 22, 31000)
nssm:spawn_specific("nssm:manticore", {"default:dirt_with_grass"}, {"default:dirt_with_grass"}, 10, 20, 30, 15000, 1, 20, 31000)
nssm:spawn_specific("nssm:werewolf", {"default:dirt_with_grass"}, {"default:dirt_with_grass"}, 0, 10, 30, 20000, 1, 20, 31000)

-- ICE
nssm:spawn_specific("nssm:icelamander", {"default:snowblock", "default:ice"}, {"default:snowblock", "default:ice"}, 0, 20, 120, 10000, 1, -31000, 31000)
nssm:spawn_specific("nssm:icesnake", {"default:snowblock", "default:ice", "default:dirt_with_snow"}, {"default:snowblock", "default:ice", "default:dirt_with_snow"}, 0, 20, 30, 5000, 1, -31000, 31000)
nssm:spawn_specific("nssm:white_werewolf", {"default:dirt_with_snow","default:snowblock"}, {"air"}, 0, 20, 60, 20000, 1, -31000, 31000)
nssm:spawn_specific("nssm:snow_biter", {"default:snowblock", "default:ice", "default:dirt_with_snow"}, {"default:snowblock", "default:ice", "default:dirt_with_snow"}, 0, 20, 30, 5000, 1, -31000, 31000)


-- FOREST
nssm:spawn_specific("nssm:larva", {"default:dirt_with_grass"}, {"default:tree"}, 0, 20, 40, 200, 1, -31000, 22)
nssm:spawn_specific("nssm:masticone", {"default:dirt_with_grass"}, {"default:tree"}, 0, 20, 120, 4000, 2, -31000, 22)

-- SKY
-- MERGEINFO: MrCerealGuy; these mobs are too strong, changed intervall time to 3600
nssm:spawn_specific("nssm:moonheron", {"air"}, {"air"}, 0, 10, 3600, 750000, 1, 10, 40)
nssm:spawn_specific("nssm:night_master", {"air"}, {"air"}, 0, 7, 3600, 5200000, 2, 10, 40)
nssm:spawn_specific("nssm:phoenix", {"air"}, {"air"}, 10, 20, 3600, 5200000, 1, 10, 40)
nssm:spawn_specific("nssm:scrausics", {"air"}, {"air"}, 10, 20, 3600, 750000, 1, 10, 40)

-- PINE FOREST
nssm:spawn_specific("nssm:pumpboom_small", {"default:dirt_with_grass", "default:dirt_with_snow","default:snowblock"}, {"default:pine_tree"}, 0, 20, 30, 300, 1, -31000, 31000)
nssm:spawn_specific("nssm:pumpboom_medium", {"default:dirt_with_grass", "default:dirt_with_snow","default:snowblock"}, {"default:pine_tree"}, 0, 20, 30, 400, 1, -31000, 31000)
nssm:spawn_specific("nssm:pumpboom_large", {"default:dirt_with_grass", "default:dirt_with_snow","default:snowblock"}, {"default:pine_tree"}, 0, 20, 30, 500, 1, -31000, 31000)
nssm:spawn_specific("nssm:pumpking", {"default:dirt_with_grass", "default:dirt_with_snow","default:snowblock"}, {"default:pine_needles", "default:pine_tree"}, 0, 12, 120, 10000, 1, -31000, 31000)

-- NSSB SPECIAL
if minetest.get_modpath("nssb") then
nssm:spawn_specific("nssm:xgaloctopus", {"default:water_source"}, {"nssb:marine_brick"}, 0, 20, 20, 800, 1, -31000, 0)
end
