local modname = minetest.get_current_modname()

local path = minetest.get_modpath(modname) .. "/"

local S = minetest.get_translator and minetest.get_translator(modname) or
		dofile(path .. "intllib.lua")

animalworld = {}

-- Check for custom mob spawn file
local input = io.open(path .. "spawn.lua", "r")
if input then
	mobs.custom_spawn_animalworld = true
	input:close()
	input = nil
end

-- Sounds
animalworld.sounds = {}
if minetest.get_modpath("default") then animalworld.sounds = default end
if minetest.get_modpath("mcl_sounds") then animalworld.sounds = mcl_sounds end


-- Animals
dofile(path .. "seal.lua") -- 
dofile(path .. "hare.lua") -- 
dofile(path .. "moose.lua") -- 
dofile(path .. "crocodile.lua") -- 
dofile(path .. "manatee.lua") -- 
dofile(path .. "tiger.lua") -- 
dofile(path .. "camel.lua") -- 
dofile(path .. "elephant.lua") -- 
dofile(path .. "carp.lua") -- 
dofile(path .. "trout.lua") -- 
dofile(path .. "blackbird.lua") -- 
dofile(path .. "bear.lua") -- 
dofile(path .. "boar.lua") -- 
dofile(path .. "kangaroo.lua") -- 
dofile(path .. "tortoise.lua") -- 
dofile(path .. "hippo.lua") -- 
dofile(path .. "shark.lua") -- 
dofile(path .. "nandu.lua") -- 
dofile(path .. "yak.lua") --
dofile(path .. "spider.lua") --
dofile(path .. "spidermale.lua") --
dofile(path .. "crab.lua") --
dofile(path .. "reindeer.lua") --
dofile(path .. "volverine.lua") --
dofile(path .. "owl.lua") --
dofile(path .. "frog.lua") --
dofile(path .. "monitor.lua") --
dofile(path .. "gnu.lua") --
dofile(path .. "puffin.lua") --
dofile(path .. "anteater.lua") --
dofile(path .. "hyena.lua") --
dofile(path .. "rat.lua") --
dofile(path .. "vulture.lua") --
dofile(path .. "toucan.lua") --
dofile(path .. "snowleopard.lua") --
dofile(path .. "lobster.lua") --
dofile(path .. "squid.lua") --
dofile(path .. "kobra.lua") --
dofile(path .. "bat.lua") --
dofile(path .. "ant.lua") --
dofile(path .. "termite.lua") --
dofile(path .. "wasp.lua") --
dofile(path .. "snail.lua") --
dofile(path .. "locust.lua") --
dofile(path .. "dragonfly.lua") --
dofile(path .. "nymph.lua") --
dofile(path .. "divingbeetle.lua") --
dofile(path .. "olm.lua") --
dofile(path .. "goldenmole.lua") --
dofile(path .. "scorpion.lua") --
dofile(path .. "goby.lua") --
dofile(path .. "treelobster.lua") --
dofile(path .. "notoptera.lua") --
dofile(path .. "seahorse.lua") --
dofile(path .. "polarbear.lua") --
dofile(path .. "muskox.lua") --
dofile(path .. "fox.lua") --
dofile(path .. "beluga.lua") --
dofile(path .. "leopardseal.lua") --
dofile(path .. "stellerseagle.lua") --
dofile(path .. "otter.lua") --
dofile(path .. "monkey.lua") --
dofile(path .. "zebra.lua") --
dofile(path .. "indianrhino.lua") --
dofile(path .. "giraffe.lua") --
dofile(path .. "koala.lua") --
dofile(path .. "clamydosaurus.lua") --
dofile(path .. "echidna.lua") --
dofile(path .. "mosquito.lua") --
dofile(path .. "beaver.lua") --
dofile(path .. "goose.lua") --
dofile(path .. "ibex.lua") --
dofile(path .. "marmot.lua") --
dofile(path .. "wolf.lua") --
dofile(path .. "panda.lua") --
dofile(path .. "hermitcrab.lua") --
dofile(path .. "cockatoo.lua") --
dofile(path .. "parrot.lua") --
dofile(path .. "parrotflying.lua") --
dofile(path .. "stingray.lua") --
dofile(path .. "blackgrouse.lua") --
dofile(path .. "viper.lua") --
dofile(path .. "wildboar.lua") --
dofile(path .. "tapir.lua") --
dofile(path .. "iguana.lua") --
dofile(path .. "oryx.lua") --
dofile(path .. "roadrunner.lua") --
dofile(path .. "cockroach.lua") --
dofile(path .. "robin.lua") --
dofile(path .. "orangutan.lua") --

-- Load tundravegetation
local load_tundra_vegetation = minetest.settings:get_bool("animalworld.tundravegetation") ~= false
if load_tundra_vegetation then
	dofile(path .. "tundravegetation.lua") --
end

-- Load trophies
local load_trophies = minetest.settings:get_bool("animalworld.trophies") ~= false
if load_trophies then
	dofile(path .. "trophies.lua") --
end

-- Load hunger
if minetest.get_modpath("hunger_ng") then
	dofile(path .. "hunger.lua") --
end

-- Load concretecrafting
if minetest.get_modpath("default") then
	dofile(path .. "concretecrafting.lua") --
end

-- Load custom spawning
if mobs.custom_spawn_animalworld then
	dofile(path .. "spawn.lua")
end




print (S("[MOD] Mobs Redo Animals loaded"))
