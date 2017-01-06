--[[


2016-05-03 modified by MrCerealGuy <mrcerealguy@gmx.de>
	removed flying_duck

--]] 

--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_nssm = world_conf:get("enable_nssm")

if enable_nssm ~= nil and enable_nssm == "false" then
	minetest.log("info", "[nssm] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

local path = minetest.get_modpath("nssm")
dofile(path.."/api.lua")
dofile(path.."/spawn.lua")

--Mobs
dofile(path.."/ant_queen.lua")
dofile(path.."/ant_soldier.lua")
dofile(path.."/ant_worker.lua")
dofile(path.."/black_widow.lua")
dofile(path.."/bloco.lua")
dofile(path.."/crab.lua")
dofile(path.."/crocodile.lua")
dofile(path.."/daddy_long_legs.lua")
dofile(path.."/dolidrosaurus.lua")
dofile(path.."/duck.lua")
dofile(path.."/duckking.lua")
dofile(path.."/echidna.lua")
dofile(path.."/enderduck.lua")
--dofile(path.."/flying_duck.lua")
dofile(path.."/giant_sandworm.lua")
dofile(path.."/icelamander.lua")
dofile(path.."/icesnake.lua")
dofile(path.."/kraken.lua")
dofile(path.."/larva.lua")
dofile(path.."/lava_titan.lua")
dofile(path.."/manticore.lua")
dofile(path.."/mantis_beast.lua")
dofile(path.."/mantis.lua")
dofile(path.."/masticone.lua")
dofile(path.."/moonheron.lua")
dofile(path.."/night_master.lua")
dofile(path.."/octopus.lua")
dofile(path.."/phoenix.lua")
dofile(path.."/pumpboom.lua")
dofile(path.."/pumpking.lua")
dofile(path.."/sandworm.lua")
dofile(path.."/scrausics.lua")
dofile(path.."/sand_bloco.lua")
dofile(path.."/signosigno.lua")
dofile(path.."/snow_biter.lua")
dofile(path.."/spiderduck.lua")
dofile(path.."/stone_eater.lua")
dofile(path.."/swimming_duck.lua")
dofile(path.."/tarantula.lua")
dofile(path.."/uloboros.lua")
dofile(path.."/werewolf.lua")
dofile(path.."/white_werewolf.lua")

--Final Boss
dofile(path.."/mese_dragon.lua")

--Others
dofile(path.."/rainbow_staff.lua")
dofile(path.."/darts.lua")
dofile(path.."/nssm_materials.lua")
dofile(path.."/nssm_spears.lua")
dofile(path.."/nssm_api.lua")
dofile(path.."/nssm_weapons.lua")
