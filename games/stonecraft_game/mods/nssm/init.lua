--[[


2016-05-03 modified by MrCerealGuy <mrcerealguy@gmx.de>
	removed flying_duck

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-09-04 modified by MrCerealGuy <mrcerealguy@gmx.de>
	added advanced mod control

--]]

if core.skip_mod("nssm") then return end

local path = minetest.get_modpath("nssm")

nssm = {
	mymapgenis = tonumber(minetest.settings:get('mymapgenis')) or 7,
	multimobs = tonumber(minetest.settings:get('multimobs')) or 1000
}

dofile(path.."/spawn.lua")

--Mobs
if core.get_mod_setting("nssm_ant_queen")		~= "false" then dofile(path.."/mobs/ant_queen.lua") end
if core.get_mod_setting("nssm_ant_soldier")		~= "false" then dofile(path.."/mobs/ant_soldier.lua") end
if core.get_mod_setting("nssm_ant_worker") 		~= "false" then dofile(path.."/mobs/ant_worker.lua") end
if core.get_mod_setting("nssm_black_widow") 	~= "false" then dofile(path.."/mobs/black_widow.lua") end
if core.get_mod_setting("nssm_bloco") 			~= "false" then dofile(path.."/mobs/bloco.lua") end
if core.get_mod_setting("nssm_crab") 			~= "false" then dofile(path.."/mobs/crab.lua") end
if core.get_mod_setting("nssm_crocodile") 		~= "false" then dofile(path.."/mobs/crocodile.lua") end
if core.get_mod_setting("nssm_daddy_long_legs") ~= "false" then dofile(path.."/mobs/daddy_long_legs.lua") end
if core.get_mod_setting("nssm_dolidrosaurus") 	~= "false" then dofile(path.."/mobs/dolidrosaurus.lua") end
if core.get_mod_setting("nssm_duck") 			~= "false" then dofile(path.."/mobs/duck.lua") end
if core.get_mod_setting("nssm_duckking") 		~= "false" then dofile(path.."/mobs/duckking.lua") end
if core.get_mod_setting("nssm_echidna") 		~= "false" then dofile(path.."/mobs/echidna.lua") end
if core.get_mod_setting("nssm_enderduck") 		~= "false" then dofile(path.."/mobs/enderduck.lua") end
if core.get_mod_setting("nssm_flying_duck") 	~= "false" then dofile(path.."/mobs/flying_duck.lua") end
if core.get_mod_setting("nssm_felucco") 		~= "false" then dofile(path.."/mobs/felucco.lua") end
if core.get_mod_setting("nssm_giant_sandworm") 	~= "false" then dofile(path.."/mobs/giant_sandworm.lua") end
if core.get_mod_setting("nssm_icelamander") 	~= "false" then dofile(path.."/mobs/icelamander.lua") end
if core.get_mod_setting("nssm_icesnake") 		~= "false" then dofile(path.."/mobs/icesnake.lua") end
if core.get_mod_setting("nssm_kraken") 			~= "false" then dofile(path.."/mobs/kraken.lua") end
if core.get_mod_setting("nssm_larva") 			~= "false" then dofile(path.."/mobs/larva.lua") end
if core.get_mod_setting("nssm_lava_titan") 		~= "false" then dofile(path.."/mobs/lava_titan.lua") end
if core.get_mod_setting("nssm_manticore") 		~= "false" then dofile(path.."/mobs/manticore.lua") end
if core.get_mod_setting("nssm_mantis_beast") 	~= "false" then dofile(path.."/mobs/mantis_beast.lua") end
if core.get_mod_setting("nssm_mantis") 			~= "false" then dofile(path.."/mobs/mantis.lua") end
if core.get_mod_setting("nssm_masticone") 		~= "false" then dofile(path.."/mobs/masticone.lua") end
if core.get_mod_setting("nssm_moonheron") 		~= "false" then dofile(path.."/mobs/moonheron.lua") end
if core.get_mod_setting("nssm_mordain") 		~= "false" then dofile(path.."/mobs/mordain.lua") end
if core.get_mod_setting("nssm_morgre") 			~= "false" then dofile(path.."/mobs/morgre.lua") end
if core.get_mod_setting("nssm_morde") 			~= "false" then dofile(path.."/mobs/morde.lua") end
if core.get_mod_setting("nssm_morgut") 			~= "false" then dofile(path.."/mobs/morgut.lua") end
if core.get_mod_setting("nssm_morlu") 			~= "false" then dofile(path.."/mobs/morlu.lua") end
if core.get_mod_setting("nssm_morvalar") 		~= "false" then dofile(path.."/mobs/morvalar.lua") end
if core.get_mod_setting("nssm_morvy") 			~= "false" then dofile(path.."/mobs/morvy.lua") end
if core.get_mod_setting("nssm_morwa") 			~= "false" then dofile(path.."/mobs/morwa.lua") end
if core.get_mod_setting("nssm_night_master") 	~= "false" then dofile(path.."/mobs/night_master.lua") end
if core.get_mod_setting("nssm_octopus") 		~= "false" then dofile(path.."/mobs/octopus.lua") end
if core.get_mod_setting("nssm_phoenix") 		~= "false" then dofile(path.."/mobs/phoenix.lua") end
if core.get_mod_setting("nssm_pumpboom") 		~= "false" then dofile(path.."/mobs/pumpboom.lua") end
if core.get_mod_setting("nssm_pumpking") 		~= "false" then dofile(path.."/mobs/pumpking.lua") end
if core.get_mod_setting("nssm_sandworm") 		~= "false" then dofile(path.."/mobs/sandworm.lua") end
if core.get_mod_setting("nssm_scrausics") 		~= "false" then dofile(path.."/mobs/scrausics.lua") end
if core.get_mod_setting("nssm_sand_bloco") 		~= "false" then dofile(path.."/mobs/sand_bloco.lua") end
if core.get_mod_setting("nssm_signosigno") 		~= "false" then dofile(path.."/mobs/signosigno.lua") end
if core.get_mod_setting("nssm_snow_biter") 		~= "false" then dofile(path.."/mobs/snow_biter.lua") end
if core.get_mod_setting("nssm_spiderduck") 		~= "false" then dofile(path.."/mobs/spiderduck.lua") end
if core.get_mod_setting("nssm_stone_eater") 	~= "false" then dofile(path.."/mobs/stone_eater.lua") end
if core.get_mod_setting("nssm_swimming_duck") 	~= "false" then dofile(path.."/mobs/swimming_duck.lua") end
if core.get_mod_setting("nssm_tarantula") 		~= "false" then dofile(path.."/mobs/tarantula.lua") end
if core.get_mod_setting("nssm_uloboros") 		~= "false" then dofile(path.."/mobs/uloboros.lua") end
if core.get_mod_setting("nssm_werewolf") 		~= "false" then dofile(path.."/mobs/werewolf.lua") end
if core.get_mod_setting("nssm_white_werewolf") 	~= "false" then dofile(path.."/mobs/white_werewolf.lua") end

--Final Boss
if core.get_mod_setting("nssm_mese_dragon") 	~= "false" then dofile(path.."/mobs/mese_dragon.lua") end

--Others
dofile(path.."/darts.lua")
dofile(path.."/nssm_materials.lua")
dofile(path.."/nssm_spears.lua")
dofile(path.."/nssm_api.lua")
dofile(path.."/nssm_weapons.lua")

if minetest.registered_nodes["nyancat:nyancat_rainbow"] then
	dofile(path.."/rainbow_staff.lua") ; print ("NYAN!!!!!")
end

if minetest.get_modpath("3d_armor") then
	dofile(path.."/nssm_armor.lua")
end

--Spawn settings
dofile(path.."/spawn.lua")

print("[MOD] NSSM loaded")
