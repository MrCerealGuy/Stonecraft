--This creates the marinara object.
marinara = {}

--This creates the marinara.settings object, and fills it with either the menu selected choices as defined in settingtypes.txt, or default values, (In this case, false).
marinara.settings = {
	clear_biomes			= minetest.settings:get_bool("marinara.clear_biomes") or false,
	clear_decos			= minetest.settings:get_bool("marinara.clear_decos") or false,
	clear_ores			= minetest.settings:get_bool("marinara.clear_ores") or false,
}

if marinara.settings.clear_biomes then
	minetest.clear_registered_biomes()
end
if marinara.settings.clear_decos then
	minetest.clear_registered_decorations()
end
if marinara.settings.clear_ores then
	minetest.clear_registered_ores()
end

local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"

-- plants
dofile(path .. "coralnodes.lua") -- 
dofile(path .. "plants.lua") -- 
dofile(path .. "reefstuff.lua") -- 
dofile(path .. "crafting.lua") -- 
dofile(path .. "spawn.lua") -- 
dofile(path .. "hunger.lua") -- 




