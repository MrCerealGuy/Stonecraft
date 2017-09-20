-- Minetest 0.4.6 mod: technic_chests
-- namespace: technic
-- (c) 2012-2013 by RealBadAngel <mk@realbadangel.pl>

--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("technic") then return end

local modpath = minetest.get_modpath("technic_chests")

technic = rawget(_G, "technic") or {}
technic.chests = {}

dofile(modpath.."/common.lua")
dofile(modpath.."/register.lua")
dofile(modpath.."/iron_chest.lua")
dofile(modpath.."/copper_chest.lua")
dofile(modpath.."/silver_chest.lua")
dofile(modpath.."/gold_chest.lua")
dofile(modpath.."/mithril_chest.lua")

