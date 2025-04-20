skins.meta = {}

local has_hand_monoid = minetest.get_modpath("hand_monoid")

local skin_class = {}
skin_class.__index = skin_class
skins.skin_class = skin_class
-----------------------
-- Class methods
-----------------------
-- constructor
function skins.new(key, object)
	assert(key, 'Unique skins key required, like "character_1"')
	local self = object or {}
	setmetatable(self, skin_class)
	self.__index = skin_class

	self._key = key
	self._sort_id = 0
	skins.meta[key] = self
	return self
end

-- getter
function skins.get(key)
	return skins.meta[key]
end

-- Skin methods
-- In this implementation it is just access to attrubutes wrapped
-- but this way allow to redefine the functionality for more complex skins provider
function skin_class:get_key()
	return self._key
end

function skin_class:set_meta(key, value)
	self[key] = value
end

function skin_class:get_meta(key)
	return self[key]
end

function skin_class:get_meta_string(key)
	return tostring(self:get_meta(key) or "")
end

function skin_class:set_texture(value)
	self._texture = value
end

--- Retrieves the character texture
function skin_class:get_texture()
	return self._texture
end

--- Assigns an existing hand item (/node) name to this skin
function skin_class:set_hand(hand)
	self._hand = hand
end

function skin_class:get_hand()
	return self._hand
end

--- Registers a new hand item based on the skin meta
local ALPHA_CLIP = minetest.features.use_texture_alpha_string_modes and "clip" or true
function skin_class:set_hand_from_texture()
	local hand = core.get_current_modname()..':'..self._texture:gsub('[%p%c%s]', '')
	local hand_def = {}
	hand_def.tiles = {self:get_texture()}
	hand_def.visual_scale = 1
	hand_def.wield_scale = {x=1,y=1,z=1}
	hand_def.paramtype = "light"
	hand_def.drawtype = "mesh"
	if(self:get_meta("format") == "1.0") then
		hand_def.mesh = "skinsdb_hand.b3d"
	else
		hand_def.mesh = "skinsdb_hand_18.b3d"
	end
	hand_def.use_texture_alpha = ALPHA_CLIP

	core.register_node(hand, table.copy(hand_def))

	self._hand_def = hand_def -- for wieldhand overrides
	self:set_hand(hand)
end

-- creative (and other mods?) may overwrite the wieldhand very late.
-- Grab the most recent definition and use them as default for our skin hands.
core.register_on_mods_loaded(function()
	local default_hand_def = {}
	for k, v in pairs(core.registered_items[""]) do
		if k ~= "mod_origin"
				and k ~= "name"
				and k ~= "type"
				and k ~= "wield_image"
				and string.sub(k, 1, 1) ~= "_" then
			default_hand_def[k] = v
		end
	end
	for _, meta in pairs(skins.meta) do
		local def = core.registered_nodes[meta._hand]
		if def then
			local new_def = table.copy(default_hand_def)
			-- Overwrite the hand with our fields from `set_hand_from_texture`
			for k, v in pairs(meta._hand_def) do
				new_def[k] = v
			end
			core.override_item(meta._hand, new_def)
		end
		meta._hand_def = nil -- no longer needed, free up RAM
	end
end)

function skin_class:set_preview(value)
	self._preview = value
end

function skin_class:get_preview()
	if self._preview then
		return self._preview
	end

	local player_skin = "("..self:get_texture()..")"
	local skin = ""

	-- Consistent on both sizes:
	--Chest
	skin = skin .. "([combine:16x32:-16,-12=" .. player_skin .. "^[mask:skindb_mask_chest.png)^"
	--Head
	skin = skin .. "([combine:16x32:-4,-8=" .. player_skin .. "^[mask:skindb_mask_head.png)^"
	--Hat
	skin = skin .. "([combine:16x32:-36,-8=" .. player_skin .. "^[mask:skindb_mask_head.png)^"
	--Right Arm
	skin = skin .. "([combine:16x32:-44,-12=" .. player_skin .. "^[mask:skindb_mask_rarm.png)^"
	--Right Leg
	skin = skin .. "([combine:16x32:0,0=" .. player_skin .. "^[mask:skindb_mask_rleg.png)^"

	-- 64x64 skins have non-mirrored arms and legs
	local left_arm
	local left_leg

	if self:get_meta("format") == "1.8" then
		left_arm = "([combine:16x32:-24,-44=" .. player_skin .. "^[mask:(skindb_mask_rarm.png^[transformFX))^"
		left_leg = "([combine:16x32:-12,-32=" .. player_skin .. "^[mask:(skindb_mask_rleg.png^[transformFX))^"
	else
		left_arm = "([combine:16x32:-44,-12=" .. player_skin .. "^[mask:skindb_mask_rarm.png^[transformFX)^"
		left_leg = "([combine:16x32:0,0=" .. player_skin .. "^[mask:skindb_mask_rleg.png^[transformFX)^"
	end

	-- Left Arm
	skin = skin .. left_arm
	--Left Leg
	skin = skin .. left_leg

	if self:get_meta("format") == "1.8" then
		-- Add overlays for 64x64 skins. This check is needed to avoid
		-- client-side out-of-bounds "[combine" warnings.

		--Chest Overlay
		skin = skin .. "([combine:16x32:-16,-28=" .. player_skin .. "^[mask:skindb_mask_chest.png)^"
		--Right Arm Overlay
		skin = skin .. "([combine:16x32:-44,-28=" .. player_skin .. "^[mask:skindb_mask_rarm.png)^"
		--Right Leg Overlay
		skin = skin .. "([combine:16x32:0,-16=" .. player_skin .. "^[mask:skindb_mask_rleg.png)^"
		--Left Arm Overlay
		skin = skin .. "([combine:16x32:-40,-44=" .. player_skin .. "^[mask:(skindb_mask_rarm.png^[transformFX))^"
		--Left Leg Overlay
		skin = skin .. "([combine:16x32:4,-32=" .. player_skin .. "^[mask:(skindb_mask_rleg.png^[transformFX))"
	end

	-- Full Preview
	skin = "(((" .. skin .. ")^[resize:64x128)^[mask:skindb_transform.png)"

	return skin
end

function skin_class:apply_skin_to_player(player)

	local function concat_texture(base, ext)
		if base == "blank.png" then
			return ext
		elseif ext == "blank.png" then
			return base
		else
			return	base .. "^" .. ext
		end
	end

	local playername = player:get_player_name()
	local ver = self:get_meta("format") or "1.0"

	player_api.set_model(player, "skinsdb_3d_armor_character_5.b3d")

	local v10_texture = "blank.png"
	local v18_texture = "blank.png"
	local armor_texture = "blank.png"
	local wielditem_texture = "blank.png"

	if ver == "1.8" then
		v18_texture = self:get_texture()
	else
		v10_texture = self:get_texture()
	end

	-- Support for clothing
	if skins.clothing_loaded and clothing.player_textures[playername] then
		local cape = clothing.player_textures[playername].cape
		local layers = {}
		for k, v in pairs(clothing.player_textures[playername]) do
			if k ~= "skin" and k ~= "cape" then
				table.insert(layers, v)
			end
		end
		local overlay = table.concat(layers, "^")
		v10_texture = concat_texture(v10_texture, cape)
		v18_texture = concat_texture(v18_texture, overlay)
	end

	-- Support for armor
	if skins.armor_loaded then
		local armor_textures = armor.textures[playername]
		if armor_textures then
			armor_texture = concat_texture(armor_texture, armor_textures.armor)
			wielditem_texture = concat_texture(wielditem_texture, armor_textures.wielditem)
		end
	end

	player_api.set_textures(player, {
			v10_texture,
			v18_texture,
			armor_texture,
			wielditem_texture,
		})

	player:set_properties({
		visual_size = {
			x = self:get_meta("visual_size_x") or 1,
			y = self:get_meta("visual_size_y") or 1
		}
	})

	local hand = self:get_hand()
	if has_hand_monoid then
		if hand then
			hand_monoid.monoid:add_change(player, {name = hand}, "skinsdb:hand")
		else
			hand_monoid.monoid:del_change(player, "skinsdb:hand")
		end
	else
		if hand then
			player:get_inventory():set_size("hand", 1)
			player:get_inventory():set_stack("hand", 1, hand)
		else
			player:get_inventory():set_stack("hand", 1, "")
		end
	end
end

function skin_class:set_skin(player)
	-- The set_skin is used on skins selection
	-- This means the method could be redefined to start an furmslec
	-- See character_creator for example
end

function skin_class:is_applicable_for_player(playername)
	local assigned_player = self:get_meta("playername")
	return assigned_player == nil or assigned_player == true or
		playername and (minetest.check_player_privs(playername, {server=true}) or
		assigned_player:lower() == playername:lower())
end
