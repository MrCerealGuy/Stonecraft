-------------------------------------------------------------------------------
-- advanced spawning mod
--
--@license WTFP
--@copyright Sapier
--@author Sapier
--@date 2013-12-05
--
-------------------------------------------------------------------------------

local version = "0.0.13"

if adv_spawning ~= nil then
	core.log("error", "MOD: adv_spawning requires adv_spawning variable to be available")
end

--------------------------------------------------------------------------------
-- @type adv_spawning base element for usage of adv_spawning
-- -----------------------------------------------------------------------------
adv_spawning = {}

adv_spawning.debug = core.setting_get("adv_spawning.debug")

local adv_modpath = core.get_modpath("adv_spawning")

dofile (adv_modpath .. "/internal.lua")
dofile (adv_modpath .. "/spawndef_checks.lua")
dofile (adv_modpath .. "/api.lua")
dofile (adv_modpath .. "/spawn_seed.lua")


adv_spawning.initialize()

core.log("action", "Advanced spawning mod version " .. version .. " loaded")
