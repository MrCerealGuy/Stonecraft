--[[

2017-01-16 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("surprise") then return end

--[[ registers the desert stone tools ]]
treasurer.register_treasure("desert_uses:pick_desert_stone",0.018,3)
treasurer.register_treasure("desert_uses:axe_desert_stone",0.019,3)
treasurer.register_treasure("desert_uses:shovel_desert_stone",0.05,3)
treasurer.register_treasure("desert_uses:sword_desert_stone",0.016,3)
