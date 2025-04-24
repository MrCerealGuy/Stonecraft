local path = minetest.get_modpath("nssm_extra")

-- additional api functions
dofile(path.."/nssm_api.lua")

-- items
dofile(path.."/nssm_materials.lua")

-- darts
dofile(path.."/darts.lua")

-- bow and arrows
dofile(path.."/nssm_bows.lua")

-- tools
dofile(path.."/nssm_tools.lua")

--Mobs
dofile(path.."/mobs/albino_spider.lua")
dofile(path.."/mobs/berinhog.lua")
dofile(path.."/mobs/black_scorpion.lua")
dofile(path.."/mobs/chog.lua")
dofile(path.."/mobs/crystal_slug.lua")
dofile(path.."/mobs/flust.lua")
dofile(path.."/mobs/icelizard.lua")
dofile(path.."/mobs/kele.lua")
dofile(path.."/mobs/pelagia.lua")
dofile(path.."/mobs/pumpkid.lua")
dofile(path.."/mobs/river_lord.lua")
dofile(path.."/mobs/salamander.lua")
dofile(path.."/mobs/silversand_dragon.lua")
dofile(path.."/mobs/silver_sandonisc.lua")
dofile(path.."/mobs/tartacacia.lua")

-- mob spawns
dofile(path.."/spawn.lua")

