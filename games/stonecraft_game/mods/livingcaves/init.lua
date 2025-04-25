--This creates the livingcaves object.
livingcaves = {}

--This creates the livingcaves.settings object, and fills it with either the menu selected choices as defined in settingtypes.txt, or default values, (In this case, false).
livingcaves.settings = {
	clear_biomes			= minetest.settings:get_bool("livingcaves.clear_biomes") or false,
	clear_decos			= minetest.settings:get_bool("livingcaves.clear_decos") or false,
	clear_ores			= minetest.settings:get_bool("livingcaves.clear_ores") or false,
}

if livingcaves.settings.clear_biomes then
	minetest.clear_registered_biomes()
end
if livingcaves.settings.clear_decos then
	minetest.clear_registered_decorations()
end
if livingcaves.settings.clear_ores then
	minetest.clear_registered_ores()
end

local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"

-- plants
dofile(path .. "cavenodes.lua") -- 
dofile(path .. "decor.lua") -- 
dofile(path .. "water.lua") -- 
dofile(path .. "crafting.lua") -- 
dofile(path .. "dye.lua") -- 
dofile(path .. "hunger.lua") -- 



