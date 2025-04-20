-- get current skin
local storage = minetest.get_mod_storage()

function skins.get_player_skin(player)
	local player_name = player:get_player_name()
	local meta = player:get_meta()
	if meta:get("skinsdb:skin_key") then
		-- Move player data prior July 2018 to mod storage
		storage:set_string(player_name, meta:get_string("skinsdb:skin_key"))
		meta:set_string("skinsdb:skin_key", "")
	end

	local skin_name = storage:get_string(player_name)
	local skin = skins.get(skin_name)
	if #skin_name > 0 and not skin then
		-- Migration step to convert `_`-delimited skins to `.` (if possible)
		skin = skins.__fuzzy_match_skin_name(player_name, skin_name, true)
		if skin then
			storage:set_string(player_name, skin:get_key())
		else
			storage:set_string(player_name, "")
		end
	end
	return skin or skins.get(skins.default)
end

-- Assign skin to player
function skins.assign_player_skin(player, skin)
	local skin_obj
	if type(skin) == "string" then
		skin_obj = skins.get(skin)
	else
		skin_obj = skin
	end

	if not skin_obj then
		return false
	end

	if skin_obj:is_applicable_for_player(player:get_player_name()) then
		local skin_key = skin_obj:get_key()
		if skin_key == skins.default then
			skin_key = ""
		end
		storage:set_string(player:get_player_name(), skin_key)
	else
		return false
	end
	return true, skin_obj
end

-- update visuals
function skins.update_player_skin(player)
	if skins.armor_loaded then
		-- all needed is wrapped and implemented in 3d_armor mod
		armor:set_player_armor(player)
	else
		-- do updates manually without 3d_armor
		skins.get_player_skin(player):apply_skin_to_player(player)
		if minetest.global_exists("sfinv") and sfinv.enabled then
			sfinv.set_player_inventory_formspec(player)
		end
	end
end

-- Assign and update - should be used on selection externally
function skins.set_player_skin(player, skin)
	local success, skin_obj = skins.assign_player_skin(player, skin)
	if success then
		skins.get_player_skin(player):set_skin(player)
		skins.update_player_skin(player)
		minetest.log("action", player:get_player_name().." set skin to "..skin_obj:get_key(""))
	end
	return success
end

-- Check Skin format (code stohlen from stu's multiskin)
function skins.get_skin_format(file)
	file:seek("set", 1)
	if file:read(3) == "PNG" then
		file:seek("set", 16)
		local ws = file:read(4)
		local hs = file:read(4)
		local w = ws:sub(3, 3):byte() * 256 + ws:sub(4, 4):byte()
		local h = hs:sub(3, 3):byte() * 256 + hs:sub(4, 4):byte()
		if w >= 64 then
			if w == h then
				return "1.8"
			elseif w == h * 2 then
				return "1.0"
			end
		end
	end
end
