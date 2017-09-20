--Before starting a new game write 6 or 7 in order to regulate the spawns (7 works also with flat and fractal).

local mymapgenis = nssm.mymapgenis
local mm = nssm.multimobs

if (mymapgenis~=6) and (mymapgenis~=7) then
	mymapgenis = 7
end
-- Spawning parameters

if mm ~= 0 then
	if mymapgenis == 6 then

	    -- ANTS
	    mobs:spawn_specific("nssm:ant_queen", {"nssm:ant_dirt"}, {"air"}, 0, 20, 60, 200000/mm, 1, -31000, 31000)
	    mobs:spawn_specific("nssm:ant_soldier", {"nssm:ant_dirt"}, {"air"}, 0, 20, 7, 30000/mm, 4, -31000, 31000)
	    mobs:spawn_specific("nssm:ant_worker", {"nssm:ant_dirt"}, {"air"}, 0, 20, 5, 10000/mm, 5, -31000, 31000)

	    -- SPIDERS
	    mobs:spawn_specific("nssm:black_widow", {"default:jungle_grass", "default:jungletree", "nssm:web" }, {"air"}, 0, 20, 20, 1200000/mm, 2, -31000, 31000)
	    mobs:spawn_specific("nssm:daddy_long_legs", {"default:jungle_grass", "default:jungletree", "nssm:web" }, {"air"}, 0, 20, 10, 1200000/mm, 2, -31000, 31000)
	    mobs:spawn_specific("nssm:tarantula", {"default:jungle_grass", "default:jungletree", "nssm:web" }, {"air"}, 0, 14, 120, 5000000/mm, 1, -31000, 31000)
	    mobs:spawn_specific("nssm:uloboros", {"default:jungle_grass", "default:jungletree", "nssm:web" }, {"air"}, 0, 20, 20, 1200000/mm, 1, -31000, 31000)

	    -- DUCKS
	    mobs:spawn_specific("nssm:duck", {"default:dirt_with_grass"}, {"group:flora"}, 10, 20, 20, 350000/mm, 1, -31000, 20)
	    mobs:spawn_specific("nssm:duckking", {"default:dirt_with_grass"}, {"group:flora"}, 10, 20, 300, 5000000/mm, 1, -31000, 20)
	    mobs:spawn_specific("nssm:enderduck", {"default:dirt_with_grass"}, {"group:flora"}, 0, 10, 45, 900000/mm, 1, -31000, 20)
	    mobs:spawn_specific("nssm:flying_duck", {"air"}, {"group:leaves"}, 10, 20, 120, 24000000/mm, 1, 1, 25)
		mobs:spawn_specific("nssm:flying_duck", {"air"}, {"group:flora"}, 10, 20, 120, 6000000/mm, 1, 1, 25)
	    mobs:spawn_specific("nssm:spiderduck", {"default:dirt_with_grass"}, {"group:flora"}, 0, 10, 45, 850000/mm, 1, -31000, 20)
	    mobs:spawn_specific("nssm:swimming_duck", {"default:water_source"}, {"default:water_source"}, 0, 20, 60, 45000000/mm, 1, -31000, 20)

	    -- MOUNTAINS
	    mobs:spawn_specific("nssm:echidna", {"default:dirt_with_grass"}, {"default:dirt_with_grass"}, 0, 20, 200, 100000000/mm, 1, 22, 31000)
	    mobs:spawn_specific("nssm:manticore", {"default:dirt_with_grass"}, {"default:dirt_with_grass"}, 10, 20, 60, 12000000/mm, 1, 20, 31000)
	    mobs:spawn_specific("nssm:werewolf", {"default:dirt_with_grass"}, {"default:dirt_with_grass"}, 0, 10, 60, 12000000/mm, 1, 20, 31000)

	    -- ICE
	    mobs:spawn_specific("nssm:icelamander", {"default:snowblock", "default:ice"}, {"default:snowblock", "default:ice"}, 0, 20, 120, 25000000/mm, 1, -31000, 31000)
	    mobs:spawn_specific("nssm:icesnake", {"default:snowblock", "default:ice", "default:dirt_with_snow"}, {"default:snowblock", "default:ice", "default:dirt_with_snow"}, 0, 20, 30, 6000000/mm, 1, -31000, 31000)
	    mobs:spawn_specific("nssm:white_werewolf", {"default:dirt_with_snow","default:snowblock"}, {"air"}, 0, 20, 60, 9000000/mm, 1, 20, 31000)
	    mobs:spawn_specific("nssm:snow_biter", {"default:snowblock", "default:ice", "default:dirt_with_snow"}, {"default:snowblock", "default:ice", "default:dirt_with_snow"}, 0, 20, 30, 6000000/mm, 1, -31000, 31000)

	    -- FOREST
	    mobs:spawn_specific("nssm:larva", {"default:dirt_with_grass"}, {"default:tree","default:aspen_tree"}, 0, 20, 40, 200000/mm, 1, -31000, 140)
	    mobs:spawn_specific("nssm:masticone", {"default:dirt_with_grass"}, {"default:tree","default:aspen_tree"}, 0, 20, 120, 5000000/mm, 2, -31000, 140)

	    -- PINE FOREST
	    mobs:spawn_specific("nssm:pumpboom_small", {"default:dirt_with_grass", "default:dirt_with_snow","default:snowblock"}, {"default:pine_tree"}, 0, 20, 30, 600000/mm, 1, -31000, 31000)
	    mobs:spawn_specific("nssm:pumpboom_medium", {"default:dirt_with_grass", "default:dirt_with_snow","default:snowblock"}, {"default:pine_tree"}, 0, 20, 30, 800000/mm, 1, -31000, 31000)
	    mobs:spawn_specific("nssm:pumpboom_large", {"default:dirt_with_grass", "default:dirt_with_snow","default:snowblock"}, {"default:pine_tree"}, 0, 20, 30, 1000000/mm, 1, -31000, 31000)
	    mobs:spawn_specific("nssm:pumpking", {"default:dirt_with_grass", "default:dirt_with_snow","default:snowblock"}, {"default:pine_needles", "default:pine_tree"}, 0, 12, 120, 8000000/mm, 1, -31000, 31000)

	else

	    -- SPIDERS
	    mobs:spawn_specific("nssm:black_widow", {"default:jungle_grass", "default:jungletree", "nssm:web" }, {"air"}, 0, 20, 30, 4400000/mm, 2, -31000, 31000)
	    mobs:spawn_specific("nssm:daddy_long_legs", {"default:jungle_grass", "default:jungletree", "nssm:web" }, {"air"}, 0, 30, 10, 4400000/mm, 2, -31000, 31000)
	    mobs:spawn_specific("nssm:tarantula", {"default:jungle_grass", "default:jungletree", "nssm:web" }, {"air"}, 0, 14, 120, 50000000/mm, 1, -31000, 31000)
	    mobs:spawn_specific("nssm:uloboros", {"default:jungle_grass", "default:jungletree", "nssm:web" }, {"air"}, 0, 20, 30, 4400000/mm, 1, -31000, 31000)

	    -- DUCKS
	    mobs:spawn_specific("nssm:duck", {"default:dirt_with_grass"}, {"group:flora"}, 10, 20, 50, 1500000/mm, 1, -31000, 40)
	    mobs:spawn_specific("nssm:duckking", {"default:dirt_with_grass"}, {"group:flora"}, 10, 20, 400, 120000000/mm, 1, -31000, 40)
	    mobs:spawn_specific("nssm:enderduck", {"default:dirt_with_grass"}, {"group:flora"}, 0, 10, 120, 5000000/mm, 1, -31000, 40)
	    mobs:spawn_specific("nssm:flying_duck", {"air"}, {"group:leaves"}, 10, 20, 120, 8000000/mm, 1, 1, 40)
		mobs:spawn_specific("nssm:flying_duck", {"air"}, {"group:flora"}, 10, 20, 120, 25000000/mm, 1, 1, 40)
	    mobs:spawn_specific("nssm:spiderduck", {"default:dirt_with_grass"}, {"group:flora"}, 0, 10, 120, 5000000/mm, 1, -31000, 45)
	    mobs:spawn_specific("nssm:swimming_duck", {"default:water_source"}, {"default:water_source"}, 0, 20, 60, 45000000/mm, 1, -31000, 40)
		mobs:spawn_specific("nssm:swimming_duck", {"default:river_water_source"}, {"default:sand","default:river_water_source"}, 0, 20, 60, 3000000/mm, 1, -31000, 300)

	    -- MOUNTAINS
	    mobs:spawn_specific("nssm:echidna", {"default:dirt_with_grass"}, {"default:dirt_with_grass"}, 0, 20, 200, 100000000/mm, 1, 50, 31000)
	    mobs:spawn_specific("nssm:manticore", {"default:dirt_with_grass"}, {"default:dirt_with_grass"}, 10, 20, 60, 13000000/mm, 1, 40, 31000)
	    mobs:spawn_specific("nssm:werewolf", {"default:dirt_with_grass"}, {"default:dirt_with_grass"}, 0, 10, 60, 13000000/mm, 1, 40, 31000)

	    -- ICE
	    mobs:spawn_specific("nssm:icelamander", {"default:snowblock", "default:ice"}, {"default:snowblock", "default:ice"}, 0, 20, 180, 120000000/mm, 1, -31000, 31000)
	    mobs:spawn_specific("nssm:icesnake", {"default:snowblock", "default:ice", "default:dirt_with_snow"}, {"default:snowblock", "default:ice", "default:dirt_with_snow"}, 0, 20, 40, 20000000/mm, 1, -31000, 31000)
	    mobs:spawn_specific("nssm:white_werewolf", {"default:dirt_with_snow","default:snowblock"}, {"air"}, 0, 20, 35, 22000000/mm, 1, 50, 31000)
	    mobs:spawn_specific("nssm:snow_biter", {"default:snowblock", "default:ice", "default:dirt_with_snow"}, {"default:snowblock", "default:ice", "default:dirt_with_snow"}, 0, 20, 40, 20000000/mm, 1, -31000, 31000)

	    -- FOREST
	    mobs:spawn_specific("nssm:larva", {"default:dirt_with_grass"}, {"default:tree","default:aspen_tree"}, 0, 20, 40, 800000/mm, 1, -31000, 140)
	    mobs:spawn_specific("nssm:masticone", {"default:dirt_with_grass"}, {"default:tree","default:aspen_tree"}, 0, 20, 180, 6000000/mm, 2, -31000, 140)

	    -- PINE FOREST
	    mobs:spawn_specific("nssm:pumpboom_small", {"default:dirt_with_grass", "default:dirt_with_snow","default:snowblock"}, {"default:pine_tree"}, 0, 20, 80, 1400000/mm, 1, -31000, 31000)
	    mobs:spawn_specific("nssm:pumpboom_medium", {"default:dirt_with_grass", "default:dirt_with_snow","default:snowblock"}, {"default:pine_tree"}, 0, 20, 80, 1600000/mm, 1, -31000, 31000)
	    mobs:spawn_specific("nssm:pumpboom_large", {"default:dirt_with_grass", "default:dirt_with_snow","default:snowblock"}, {"default:pine_tree"}, 0, 20, 80, 1800000/mm, 1, -31000, 31000)
	    mobs:spawn_specific("nssm:pumpking", {"default:dirt_with_grass", "default:dirt_with_snow","default:snowblock"}, {"default:pine_needles", "default:pine_tree"}, 0, 12, 120, 8000000/mm, 1, -31000, 31000)

	    -- SAVANNA
		mobs:spawn_specific("nssm:felucco", {"default:dirt_with_dry_grass"}, {"default:dirt_with_dry_grass"}, 0, 20, 80, 20000000/mm, 1, -200, 31000)

	end

	-- NSSB SPECIAL
	if minetest.get_modpath("nssb") then
		mobs:spawn_specific("nssm:xgaloctopus", {"default:water_source"}, {"nssb:marine_brick"}, 0, 20, 20, 800000/mm, 1, -31000, 0)
	end

	-- CAVES
	mobs:spawn_specific("nssm:bloco", {"default:stone", "default:desert_stone"}, {"default:stone", "default:desert_stone"}, 0, 20, 30, 500000/mm, 3, -31000, -20)
	mobs:spawn_specific("nssm:lava_titan", {"default:stone", "default:desert_stone"}, {"air"}, 0, 120, 12, 22000000/mm, 1, -31000, -100)
	mobs:spawn_specific("nssm:stone_eater", {"default:stone", "default:desert_stone"}, {"default:stone", "default:desert_stone"}, 0, 20, 40, 700000/mm, 2, -31000, -20)
	mobs:spawn_specific("nssm:signosigno", {"default:stone", "default:desert_stone"}, {"default:stone", "default:desert_stone"}, 0, 10, 20, 400000/mm, 2, -31000, -20)
	mobs:spawn_specific("nssm:signosigno", {"bones:bones"}, {"air"}, 0, 15, 20, 5000/mm, 5, -31000, 31000)

	-- SEA
	mobs:spawn_specific("nssm:crab", {"default:sand"}, {"default:water_source"}, 0, 20, 60, 4000000/mm, 1, -31000, 31000)
	mobs:spawn_specific("nssm:crocodile", {"default:sand","default:water_source"}, {"default:water_source"}, 0, 20, 100, 35000000/mm, 1, -31000, 31000)
	mobs:spawn_specific("nssm:crocodile", {"default:sand","default:river_water_source"}, {"default:river_water_source"}, 0, 20, 60, 12000000/mm, 1, -31000, 31000)
	mobs:spawn_specific("nssm:dolidrosaurus", {"default:water_source"}, {"default:water_source"}, 0, 20, 100, 35000000/mm, 1, -31000, -1)
	mobs:spawn_specific("nssm:kraken", {"default:water_source"}, {"default:water_source"}, 0, 20, 400, 500000000/mm, 1, -31000, 0)
	mobs:spawn_specific("nssm:octopus", {"default:water_source"}, {"default:water_source"}, 0, 20, 80, 38000000/mm, 1, -31000, 0)

	-- DESERT
	mobs:spawn_specific("nssm:sandworm", {"default:desert_sand", "default:desert_stone"}, {"air"}, 0, 20, 100, 28000000/mm, 1, -31000, 31000)
	mobs:spawn_specific("nssm:giant_sandworm", {"default:desert_sand", "default:desert_stone"}, {"air"}, 0, 20, 400, 600000000/mm, 1, -31000, 31000)
	mobs:spawn_specific("nssm:sand_bloco", {"default:desert_sand", "default:desert_stone"}, {"air"}, 0, 20, 90, 20000000/mm, 1, -31000, 31000)

	-- SKY
	mobs:spawn_specific("nssm:moonheron", {"air"}, {"air"}, 0, 10, 110, 950000000/mm, 1, 10, 180)
	mobs:spawn_specific("nssm:night_master", {"air"}, {"air"}, 0, 7, 400, 4500000000/mm, 2, 10, 180)
	mobs:spawn_specific("nssm:phoenix", {"air"}, {"air"}, 10, 20, 400, 10000000000/mm, 1, 10, 180)
	mobs:spawn_specific("nssm:scrausics", {"air"}, {"air"}, 10, 20, 110, 950000000/mm, 1, 10, 180)
end
