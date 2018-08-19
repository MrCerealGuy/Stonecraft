--[[

2016-05-04 modified by MrCerealGuy <mrcerealguy@gmx.de>
	increased mapgen_rarity

2017-09-05 modified by MrCerealGuy <mrcerealguy@gmx.de>
	added advanced mod control

--]]

local default_settings = {
	enable_mapgen = true,
	always_generate = false,
	smooth = true,
	enable_plants = true,
	swampwater = true,
	wet_beaches = true,	--swampwater
	hut_chance = 50,
	spawn_plants = true,
	info = true,
	inform_all = false,	--minetest.is_singleplayer()
	max_spam = 2,
}

for name,dv in pairs(default_settings) do
	local setting
	local setting_name = "sumpf."..name
	if type(dv) == "boolean" then
		setting = minetest.settings:get_bool(setting_name)
	elseif type(dv) == "number" then
		setting = tonumber(minetest.settings:get(setting_name))
	else
		error"[sumpf] only boolean and number settings are available"
	end
	if setting == nil then
		sumpf[name] = dv
	else
		sumpf[name] = setting
	end
end

--Generate swamps everywhere
if core.get_mod_setting("swamp_biome_always_generate") ~= "false" then default_settings.always_generate = true else default_settings.always_generate = false end

--Enables smooth transition of biomes.
if core.get_mod_setting("swamp_biome_smooth") ~= "false" then default_settings.smooth = true else default_settings.smooth = false end

--Enables swampwater - it might be a bit buggy with mapgen v6.
if core.get_mod_setting("swamp_biome_swampwater") ~= "false" then default_settings.swampwater = true else default_settings.swampwater = false end

