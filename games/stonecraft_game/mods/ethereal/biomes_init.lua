
-- storage tables

local old_biomes, old_decor = {}, {}

-- backup registered biomes

for key, def in pairs(minetest.registered_biomes) do
	old_biomes[key] = def
end

-- backup registered decorations

for key, def in pairs(minetest.registered_decorations) do
	old_decor[key] = def
end

-- clear current biome data

minetest.clear_registered_biomes()
minetest.clear_registered_decorations()
-- minetest.clear_registered_ores()

-- create list of default biomes to remove

local def_biomes = {
	["rainforest"] = 1,
	["rainforest_swamp"] = 1,
	["rainforest_ocean"] = 1,
	["rainforest_under"] = 1,
	["grassland"] = 1,
	["grassland_dunes"] = 1,
	["grassland_ocean"] = 1,
	["grassland_under"] = 1,
	["taiga"] = 1,
	["taiga_ocean"] = 1,
	["taiga_under"] = 1,
	["icesheet"] = 1,
	["icesheet_ocean"] = 1,
	["icesheet_under"] = 1,
	["snowy_grassland"] = 1,
	["snowy_grassland_ocean"] = 1,
	["snowy_grassland_under"] = 1,
	["desert"] = 1,
	["desert_ocean"] = 1,
	["desert_under"] = 1,
	["tundra"] = 1,
	["tundra_highland"] = 1,
	["tundra_beach"] = 1,
	["tundra_ocean"] = 1,
	["tundra_under"] = 1,
	["sandstone_desert"] = 1,
	["sandstone_desert_ocean"] = 1,
	["sandstone_desert_under"] = 1,
	["savanna"] = 1,
	["savanna_shore"] = 1,
	["savanna_ocean"] = 1,
	["savanna_under"] = 1,
	["cold_desert"] = 1,
	["cold_desert_ocean"] = 1,
	["cold_desert_under"] = 1,
	["coniferous_forest"] = 1,
	["coniferous_forest_dunes"] = 1,
	["coniferous_forest_ocean"] = 1,
	["coniferous_forest_under"] = 1,
	["deciduous_forest"] = 1,
	["deciduous_forest_shore"] = 1,
	["deciduous_forest_ocean"] = 1,
	["deciduous_forest_under"] = 1
}

-- only re-register biomes that aren't on the list

for key, def in pairs(old_biomes) do

	if not def_biomes[key] then minetest.register_biome(def) end
end

-- loop through decorations

for key, def in pairs(old_decor) do

	local can_add = true
	local new_biomes = {}

	if type(def.biomes) == "table" then

		-- loop through decoration biomes, only re-add one's not on above list
		for num, bio in pairs(def.biomes) do

			if not def_biomes[bio] then table.insert(new_biomes, bio) end
		end

		-- if no biomes are left on new list, do not re-add decoration
		if #new_biomes == 0 then can_add = false end

	elseif type(def.biomes) == "string" then

		if def_biomes[def.biomes] then
			can_add = false
		else
			new_biomes = {def.biomes} -- convert to table
		end

	elseif not def.biomes then new_biomes = nil end -- keep it nil for re-adding

	if can_add == true then

		def.biomes = new_biomes

		minetest.register_decoration(def)
	end
end
