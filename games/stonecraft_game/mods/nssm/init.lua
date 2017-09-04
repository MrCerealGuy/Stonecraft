--[[


2016-05-03 modified by MrCerealGuy <mrcerealguy@gmx.de>
	removed flying_duck

--]] 

--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-09-04 modified by MrCerealGuy <mrcerealguy@gmx.de>
	added advanced mod control

--]]

if core.skip_mod("nssm") then return end

local path = minetest.get_modpath("nssm")
dofile(path.."/api.lua")
dofile(path.."/spawn.lua")

--Mobs
if core.get_mod_setting("enable_nssm_ants") ~= false then dofile(path.."/ant_queen.lua") end
if core.get_mod_setting("enable_nssm_ants") ~= false then dofile(path.."/ant_soldier.lua") end
if core.get_mod_setting("enable_nssm_ants") ~= false then dofile(path.."/ant_worker.lua") end
if core.get_mod_setting("enable_nssm_black_widow") ~= false then dofile(path.."/black_widow.lua") end
if core.get_mod_setting("enable_nssm_bloco") ~= false then dofile(path.."/bloco.lua") end
if core.get_mod_setting("enable_nssm_crab") ~= false then dofile(path.."/crab.lua") end
if core.get_mod_setting("enable_nssm_crocodile") ~= false then dofile(path.."/crocodile.lua") end
if core.get_mod_setting("enable_nssm_daddy_long_legs") ~= false then dofile(path.."/daddy_long_legs.lua") end
if core.get_mod_setting("enable_nssm_dolidrosaurus") ~= false then dofile(path.."/dolidrosaurus.lua") end
if core.get_mod_setting("enable_nssm_duck") ~= false then dofile(path.."/duck.lua") end
if core.get_mod_setting("enable_nssm_duckking") ~= false then dofile(path.."/duckking.lua") end
if core.get_mod_setting("enable_nssm_echidna") ~= false then dofile(path.."/echidna.lua") end
if core.get_mod_setting("enable_nssm_enderduck") ~= false then dofile(path.."/enderduck.lua") end
if core.get_mod_setting("enable_nssm_lying_duck") ~= false then dofile(path.."/flying_duck.lua") end
if core.get_mod_setting("enable_nssm_giant_sandworm") ~= false then dofile(path.."/giant_sandworm.lua") end
if core.get_mod_setting("enable_nssm_icelamander") ~= false then dofile(path.."/icelamander.lua") end
if core.get_mod_setting("enable_nssm_icesnake") ~= false then dofile(path.."/icesnake.lua") end
if core.get_mod_setting("enable_nssm_kraken") ~= false then dofile(path.."/kraken.lua") end
if core.get_mod_setting("enable_nssm_larva") ~= false then dofile(path.."/larva.lua") end
if core.get_mod_setting("enable_nssm_lava_titan") ~= false then dofile(path.."/lava_titan.lua") end
if core.get_mod_setting("enable_nssm_manticore") ~= false then dofile(path.."/manticore.lua") end
if core.get_mod_setting("enable_nssm_mantis_beast") ~= false then dofile(path.."/mantis_beast.lua") end
if core.get_mod_setting("enable_nssm_mantis") ~= false then dofile(path.."/mantis.lua") end
if core.get_mod_setting("enable_nssm_masticone") ~= false then dofile(path.."/masticone.lua") end
if core.get_mod_setting("enable_nssm_moonheron") ~= false then dofile(path.."/moonheron.lua") end
if core.get_mod_setting("enable_nssm_night_master") ~= false then dofile(path.."/night_master.lua") end
if core.get_mod_setting("enable_nssm_octopus") ~= false then dofile(path.."/octopus.lua") end
if core.get_mod_setting("enable_nssm_phoenix") ~= false then dofile(path.."/phoenix.lua") end
if core.get_mod_setting("enable_nssm_pumpboom") ~= false then dofile(path.."/pumpboom.lua") end
if core.get_mod_setting("enable_nssm_pumpking") ~= false then dofile(path.."/pumpking.lua") end
if core.get_mod_setting("enable_nssm_sandworm") ~= false then dofile(path.."/sandworm.lua") end
if core.get_mod_setting("enable_nssm_scrausics") ~= false then dofile(path.."/scrausics.lua") end
if core.get_mod_setting("enable_nssm_sand_bloco") ~= false then dofile(path.."/sand_bloco.lua") end
if core.get_mod_setting("enable_nssm_signosigno") ~= false then dofile(path.."/signosigno.lua") end
if core.get_mod_setting("enable_nssm_snow_biter") ~= false then dofile(path.."/snow_biter.lua") end
if core.get_mod_setting("enable_nssm_spiderduck") ~= false then dofile(path.."/spiderduck.lua") end
if core.get_mod_setting("enable_nssm_stone_eater") ~= false then dofile(path.."/stone_eater.lua") end
if core.get_mod_setting("enable_nssm_swimming_duck") ~= false then dofile(path.."/swimming_duck.lua") end
if core.get_mod_setting("enable_nssm_tarantula") ~= false then dofile(path.."/tarantula.lua") end
if core.get_mod_setting("enable_nssm_uloboros") ~= false then dofile(path.."/uloboros.lua") end
if core.get_mod_setting("enable_nssm_werewolf") ~= false then dofile(path.."/werewolf.lua") end
if core.get_mod_setting("enable_nssm_white_werewolf") ~= false then dofile(path.."/white_werewolf.lua") end

--Final Boss
if core.get_mod_setting("enable_nssm_mese_dragon") ~= false then dofile(path.."/mese_dragon.lua") end

--Others
dofile(path.."/rainbow_staff.lua")
dofile(path.."/darts.lua")
dofile(path.."/nssm_materials.lua")
dofile(path.."/nssm_spears.lua")
dofile(path.."/nssm_api.lua")
dofile(path.."/nssm_weapons.lua")
