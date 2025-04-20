local default_settings = {
	enable_mapgen = true,
	always_generate = false,
	smooth = true,
	enable_plants = true,
	swampwater = true,
	wet_beaches = true,	--swampwater
	hut_chance = 50,
	spawn_plants = true,
	log_to_chat = false,	--minetest.is_singleplayer()
	log_level = 2,
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
