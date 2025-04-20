
-- translation and mod path

local S = minetest.get_translator("nssm")
local path = minetest.get_modpath("nssm")

nssm = {
	mymapgenis = tonumber(minetest.settings:get("nssm.mymapgenis")) or 7,
	multimobs = tonumber(minetest.settings:get("nssm.multimobs")) or 1000,
	spiders_litter_web = minetest.settings:get_bool("nssm.spiders_litter_web", true),
	classic_rainbow_staff = minetest.settings:get_bool("nssm.classic_rainbow_staff", false),
	S = S
}

-- Mobs

dofile(path .. "/mobs/ant_queen.lua")
dofile(path .. "/mobs/ant_soldier.lua")
dofile(path .. "/mobs/ant_worker.lua")
dofile(path .. "/mobs/black_widow.lua")
dofile(path .. "/mobs/bloco.lua")
dofile(path .. "/mobs/crab.lua")
dofile(path .. "/mobs/crocodile.lua")
dofile(path .. "/mobs/daddy_long_legs.lua")
dofile(path .. "/mobs/dolidrosaurus.lua")
dofile(path .. "/mobs/duck.lua")
dofile(path .. "/mobs/duckking.lua")
dofile(path .. "/mobs/echidna.lua")
dofile(path .. "/mobs/enderduck.lua")
dofile(path .. "/mobs/flying_duck.lua")
dofile(path .. "/mobs/felucco.lua")
dofile(path .. "/mobs/giant_sandworm.lua")
dofile(path .. "/mobs/icelamander.lua")
dofile(path .. "/mobs/icesnake.lua")
dofile(path .. "/mobs/kraken.lua")
dofile(path .. "/mobs/larva.lua")
dofile(path .. "/mobs/lava_titan.lua")
dofile(path .. "/mobs/manticore.lua")
dofile(path .. "/mobs/mantis_beast.lua")
dofile(path .. "/mobs/mantis.lua")
dofile(path .. "/mobs/masticone.lua")
dofile(path .. "/mobs/moonheron.lua")
dofile(path .. "/mobs/mordain.lua")
dofile(path .. "/mobs/morgre.lua")
dofile(path .. "/mobs/morde.lua")
dofile(path .. "/mobs/morgut.lua")
dofile(path .. "/mobs/morlu.lua")
dofile(path .. "/mobs/morvalar.lua")
dofile(path .. "/mobs/morvy.lua")
dofile(path .. "/mobs/morwa.lua")
dofile(path .. "/mobs/night_master.lua")
dofile(path .. "/mobs/octopus.lua")
dofile(path .. "/mobs/phoenix.lua")
dofile(path .. "/mobs/pumpboom.lua")
dofile(path .. "/mobs/pumpking.lua")
dofile(path .. "/mobs/sandworm.lua")
dofile(path .. "/mobs/scrausics.lua")
dofile(path .. "/mobs/sand_bloco.lua")
dofile(path .. "/mobs/signosigno.lua")
dofile(path .. "/mobs/snow_biter.lua")
dofile(path .. "/mobs/spiderduck.lua")
dofile(path .. "/mobs/stone_eater.lua")
dofile(path .. "/mobs/swimming_duck.lua")
dofile(path .. "/mobs/tarantula.lua")
dofile(path .. "/mobs/uloboros.lua")
dofile(path .. "/mobs/werewolf.lua")
dofile(path .. "/mobs/white_werewolf.lua")
dofile(path .. "/mobs/mese_dragon.lua") -- Final Boss

-- Others

dofile(path .. "/darts.lua")
dofile(path .. "/nssm_materials.lua")
dofile(path .. "/nssm_spears.lua")
dofile(path .. "/nssm_api.lua")
dofile(path .. "/nssm_weapons.lua")

if minetest.registered_nodes["nyancat:nyancat_rainbow"] then
	dofile(path .. "/rainbow_staff.lua") ; print ("NYAN!!!!!")
end

if minetest.get_modpath("3d_armor") then
	dofile(path .. "/nssm_armor.lua")
end

-- Spawn settings

dofile(path .. "/spawn.lua")

print("[MOD] Mobs Redo Not So Simple Mobs loaded")
