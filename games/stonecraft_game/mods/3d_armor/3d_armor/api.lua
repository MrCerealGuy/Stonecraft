
--- 3D Armor API
--
--  @topic api


local transparent_armor = minetest.settings:get_bool("armor_transparent", false)


--- Tables
--
--  @section tables

--- Armor definition table used for registering armor.
--
--  @table ArmorDef
--  @tfield string description Human-readable name/description.
--  @tfield string inventory_image Image filename used for icon.
--  @tfield table groups See: `ArmorDef.groups`
--  @tfield table armor_groups See: `ArmorDef.armor_groups`
--  @tfield table damage_groups See: `ArmorDef.damage_groups`
--  @see ItemDef
--  @usage local def = {
--    description = "Wood Helmet",
--    inventory_image = "3d_armor_inv_helmet_wood.png",
--    groups = {armor_head=1, armor_heal=0, armor_use=2000, flammable=1},
--    armor_groups = {fleshy=5},
--    damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
--  }

--- Groups table.
--
--  General groups defining item behavior.
--
--  Some commonly used groups: ***armor\_&lt;type&gt;***, ***armor\_heal***, ***armor\_use***
--
--  @table ArmorDef.groups
--  @tfield int armor_type The armor type. "head", "torso", "hands", "shield", etc.
--  (**Note:** replace "type" with actual type).
--  @tfield int armor_heal Healing value of armor when equipped.
--  @tfield int armor_use Amount of uses/damage before armor "breaks".
--  @see groups
--  @usage groups = {
--    armor_head = 1,
--    armor_heal = 5,
--    armor_use = 2000,
--    flammable = 1,
--  }

--- Armor groups table.
--
--  Groups that this item is effective against when taking damage.
--
--  Some commonly used groups: ***fleshy***
--
--  @table ArmorDef.armor_groups
--  @usage armor_groups = {
--    fleshy = 5,
--  }

--- Damage groups table.
--
--  Groups that this item is effective on when used as a weapon/tool.
--
--  Some commonly used groups: ***cracky***, ***snappy***, ***choppy***, ***crumbly***, ***level***
--
--  @table ArmorDef.damage_groups
--  @see entity_damage_mechanism
--  @usage damage_groups = {
--    cracky = 3,
--    snappy = 2,
--    choppy = 3,
--    crumbly = 2,
--    level = 1,
--  }

--- @section end


-- support for i18n
local S = minetest.get_translator(minetest.get_current_modname())

local skin_previews = {}
local use_player_monoids = minetest.global_exists("player_monoids")
local use_armor_monoid = minetest.global_exists("armor_monoid")
local use_pova_mod = minetest.get_modpath("pova")
local armor_def = setmetatable({}, {
	__index = function()
		return setmetatable({
			groups = setmetatable({}, {
				__index = function()
					return 0
				end})
			}, {
			__index = function()
				return 0
			end
		})
	end,
})
local armor_textures = setmetatable({}, {
	__index = function()
		return setmetatable({}, {
			__index = function()
				return "blank.png"
			end
		})
	end
})

armor = {
	timer = 0,
	elements = {"head", "torso", "legs", "feet"},
	physics = {"jump", "speed", "gravity"},
	attributes = {"heal", "fire", "water", "feather"},
	formspec = "image[2.5,0;2,4;armor_preview]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		default.get_hotbar_bg(0, 4.7)..
		"list[current_player;main;0,4.7;8,1;]"..
		"list[current_player;main;0,5.85;8,3;8]",
	def = armor_def,
	textures = armor_textures,
	default_skin = "character",
	materials = {
		wood = "group:wood",
		cactus = "default:cactus",
		steel = "default:steel_ingot",
		bronze = "default:bronze_ingot",
		diamond = "default:diamond",
		gold = "default:gold_ingot",
		mithril = "moreores:mithril_ingot",
		crystal = "ethereal:crystal_ingot",
		nether = "nether:nether_ingot",
	},
	fire_nodes = {
		{"nether:lava_source",      5, 8},
		{"default:lava_source",     5, 8},
		{"default:lava_flowing",    5, 8},
		{"fire:basic_flame",        3, 4},
		{"fire:permanent_flame",    3, 4},
		{"ethereal:crystal_spike",  2, 1},
		{"ethereal:fire_flower",    2, 1},
		{"nether:lava_crust",       2, 1},
		{"default:torch",           1, 1},
		{"default:torch_ceiling",   1, 1},
		{"default:torch_wall",      1, 1},
	},
	registered_groups = {["fleshy"]=100},
	registered_callbacks = {
		on_update = {},
		on_equip = {},
		on_unequip = {},
		on_damage = {},
		on_destroy = {},
	},
	migrate_old_inventory = true,
  version = "0.4.13",
  get_translator = S
}

armor.config = {
	init_delay = 2,
	bones_delay = 1,
	update_time = 1,
	drop = minetest.get_modpath("bones") ~= nil,
	destroy = false,
	level_multiplier = 1,
	heal_multiplier = 1,
	material_wood = true,
	material_cactus = true,
	material_steel = true,
	material_bronze = true,
	material_diamond = true,
	material_gold = true,
	material_mithril = true,
	material_crystal = true,
	material_nether = true,
	set_elements = "head torso legs feet shield",
	set_multiplier = 1.1,
	water_protect = true,
	fire_protect = minetest.get_modpath("ethereal") ~= nil,
	fire_protect_torch = minetest.get_modpath("ethereal") ~= nil,
	feather_fall = true,
	punch_damage = true,
}


--- Methods
--
--  @section methods

--- Registers a new armor item.
--
--  @function armor:register_armor
--  @tparam string name Armor item technical name (ex: "3d\_armor:helmet\_gold").
--  @tparam ArmorDef def Armor definition table.
--  @usage armor:register_armor("3d_armor:helmet_wood", {
--    description = "Wood Helmet",
--    inventory_image = "3d_armor_inv_helmet_wood.png",
--    groups = {armor_head=1, armor_heal=0, armor_use=2000, flammable=1},
--    armor_groups = {fleshy=5},
--    damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
--  })
armor.register_armor = function(self, name, def)
	def.on_secondary_use = function(itemstack, player)
		return armor:equip(player, itemstack)
	end
	def.on_place = function(itemstack, player, pointed_thing)
		if pointed_thing.type == "node" and player and not player:get_player_control().sneak then
			local node = minetest.get_node(pointed_thing.under)
			local ndef = minetest.registered_nodes[node.name]
			if ndef and ndef.on_rightclick then
				return ndef.on_rightclick(pointed_thing.under, node, player, itemstack, pointed_thing)
			end
		end
		return armor:equip(player, itemstack)
	end
	-- The below is a very basic check to try and see if a material name exists as part
	-- of the item name. However this check is very simple and just checks theres "_something"
	-- at the end of the item name and logging an error to debug if not.
	local check_mat_exists = string.match(name, "%:.+_(.+)$")
	if check_mat_exists == nil then
		minetest.log("warning:[3d_armor] Registered armor "..name..
		" does not have \"_material\" specified at the end of the item registration name")
	end
	minetest.register_tool(name, def)
end

--- Registers a new armor group.
--
--  @function armor:register_armor_group
--  @tparam string group Group ID.
--  @tparam int base Base armor value.
armor.register_armor_group = function(self, group, base)
	base = base or 100
	self.registered_groups[group] = base
	if use_armor_monoid then
		armor_monoid.register_armor_group(group, base)
	end
end

--- Armor Callbacks Registration
--
--  @section callbacks

--- Registers a callback for when player visuals are update.
--
--  @function armor:register_on_update
--  @tparam function func Function to be executed.
--  @see armor:update_player_visuals
--  @usage armor:register_on_update(function(player, index, stack)
--    -- code to execute
--  end)
armor.register_on_update = function(self, func)
	if type(func) == "function" then
		table.insert(self.registered_callbacks.on_update, func)
	end
end

--- Registers a callback for when armor is equipped.
--
--  @function armor:register_on_equip
--  @tparam function func Function to be executed.
--  @usage armor:register_on_equip(function(player, index, stack)
--    -- code to execute
--  end)
armor.register_on_equip = function(self, func)
	if type(func) == "function" then
		table.insert(self.registered_callbacks.on_equip, func)
	end
end

--- Registers a callback for when armor is unequipped.
--
--  @function armor:register_on_unequip
--  @tparam function func Function to be executed.
--  @usage armor:register_on_unequip(function(player, index, stack)
--    -- code to execute
--  end)
armor.register_on_unequip = function(self, func)
	if type(func) == "function" then
		table.insert(self.registered_callbacks.on_unequip, func)
	end
end

--- Registers a callback for when armor is damaged.
--
--  @function armor:register_on_damage
--  @tparam function func Function to be executed.
--  @see armor:damage
--  @usage armor:register_on_damage(function(player, index, stack)
--    -- code to execute
--  end)
armor.register_on_damage = function(self, func)
	if type(func) == "function" then
		table.insert(self.registered_callbacks.on_damage, func)
	end
end

--- Registers a callback for when armor is destroyed.
--
--  @function armor:register_on_destroy
--  @tparam function func Function to be executed.
--  @see armor:damage
--  @usage armor:register_on_destroy(function(player, index, stack)
--    -- code to execute
--  end)
armor.register_on_destroy = function(self, func)
	if type(func) == "function" then
		table.insert(self.registered_callbacks.on_destroy, func)
	end
end

--- @section end


--- Methods
--
--  @section methods

--- Runs callbacks.
--
--  @function armor:run_callbacks
--  @tparam function callback Function to execute.
--  @tparam ObjectRef player First parameter passed to callback.
--  @tparam int index Second parameter passed to callback.
--  @tparam ItemStack stack Callback owner.
armor.run_callbacks = function(self, callback, player, index, stack)
	if stack then
		local def = stack:get_definition() or {}
		if type(def[callback]) == "function" then
			def[callback](player, index, stack)
		end
	end
	local callbacks = self.registered_callbacks[callback]
	if callbacks then
		for _, func in pairs(callbacks) do
			func(player, index, stack)
		end
	end
end

--- Updates visuals.
--
--  @function armor:update_player_visuals
--  @tparam ObjectRef player
armor.update_player_visuals = function(self, player)
	if not player then
		return
	end
	local name = player:get_player_name()
	if self.textures[name] then
		player_api.set_textures(player, {
			self.textures[name].skin,
			self.textures[name].armor,
			self.textures[name].wielditem,
		})
	end
	self:run_callbacks("on_update", player)
end

--- Sets player's armor attributes.
--
--  @function armor:set_player_armor
--  @tparam ObjectRef player
armor.set_player_armor = function(self, player)
	local name, armor_inv = self:get_valid_player(player, "[set_player_armor]")
	if not name then
		return
	end
	local state = 0
	local count = 0
	local preview = armor:get_preview(name)
	local texture = "blank.png"
	local physics = {}
	local attributes = {}
	local levels = {}
	local groups = {}
	local change = {}
	local set_worn = {}
	local armor_multi = 0
	local worn_armor = armor:get_weared_armor_elements(player)
	for _, phys in pairs(self.physics) do
		physics[phys] = 1
	end
	for _, attr in pairs(self.attributes) do
		attributes[attr] = 0
	end
	for group, _ in pairs(self.registered_groups) do
		change[group] = 1
		levels[group] = 0
	end
	local list = armor_inv:get_list("armor")
	if type(list) ~= "table" then
		return
	end
	for i, stack in pairs(list) do
		if stack:get_count() == 1 then
			local def = stack:get_definition()
			for _, element in pairs(self.elements) do
				if def.groups["armor_"..element] then
					if def.armor_groups then
						for group, level in pairs(def.armor_groups) do
							if levels[group] then
								levels[group] = levels[group] + level
							end
						end
					else
						local level = def.groups["armor_"..element]
						levels["fleshy"] = levels["fleshy"] + level
					end
					break
				end
				-- DEPRECATED, use armor_groups instead
				if def.groups["armor_radiation"] and levels["radiation"] then
					levels["radiation"] = levels["radiation"] + def.groups["armor_radiation"]
				end
			end
			local item = stack:get_name()
			local tex = def.texture or item:gsub("%:", "_")
			tex = tex:gsub(".png$", "")
			local prev = def.preview or tex.."_preview"
			prev = prev:gsub(".png$", "")
			if not transparent_armor then
				texture = texture.."^"..tex..".png"
			end
			preview = preview.."^"..prev..".png"
			state = state + stack:get_wear()
			count = count + 1
			for _, phys in pairs(self.physics) do
				local value = def.groups["physics_"..phys] or 0
				physics[phys] = physics[phys] + value
			end
			for _, attr in pairs(self.attributes) do
				local value = def.groups["armor_"..attr] or 0
				attributes[attr] = attributes[attr] + value
			end
		end
	end
	-- The following code compares player worn armor items against requirements
	-- of which armor pieces are needed to be worn to meet set bonus requirements
	for loc,item in pairs(worn_armor) do
		local item_mat = string.match(item, "%:.+_(.+)$")
		local worn_key = item_mat or "unknown"

		-- Perform location checks to ensure the armor is worn correctly
		for k,set_loc in pairs(armor.config.set_elements)do
			if set_loc == loc then
				if set_worn[worn_key] == nil then
					set_worn[worn_key] = 0
					set_worn[worn_key] = set_worn[worn_key] + 1
				else
					set_worn[worn_key] = set_worn[worn_key] + 1
				end
			end
		end
	end

	-- Apply the armor multiplier only if the player is wearing a full set of armor
	for mat_name,arm_piece_num in pairs(set_worn) do
		if arm_piece_num == #armor.config.set_elements then
			armor_multi = armor.config.set_multiplier
		end
	end
	for group, level in pairs(levels) do
		if level > 0 then
			level = level * armor.config.level_multiplier
			if armor_multi ~= 0 then
				level = level * armor.config.set_multiplier
			end
		end
		local base = self.registered_groups[group]
		self.def[name].groups[group] = level
		if level > base then
			level = base
		end
		groups[group] = base - level
		change[group] = groups[group] / base
	end
	for _, attr in pairs(self.attributes) do
		local mult = attr == "heal" and self.config.heal_multiplier or 1
		self.def[name][attr] = attributes[attr] * mult
	end
	for _, phys in pairs(self.physics) do
		self.def[name][phys] = physics[phys]
	end
	if use_armor_monoid then
		armor_monoid.monoid:add_change(player, change, "3d_armor:armor")
	else
		-- Preserve immortal group (damage disabled for player)
		local player_groups = player:get_armor_groups()
		local immortal = player_groups.immortal
		if immortal and immortal ~= 0 then
			groups.immortal = 1
		end
		-- Preserve fall_damage_add_percent group (fall damage modifier)
		groups.fall_damage_add_percent = player_groups.fall_damage_add_percent
		player:set_armor_groups(groups)
	end
	if use_player_monoids then
		player_monoids.speed:add_change(player, physics.speed,
			"3d_armor:physics")
		player_monoids.jump:add_change(player, physics.jump,
			"3d_armor:physics")
		player_monoids.gravity:add_change(player, physics.gravity,
			"3d_armor:physics")
	elseif use_pova_mod then
		-- only add the changes, not the default 1.0 for each physics setting
		pova.add_override(name, "3d_armor", {
			speed = physics.speed - 1,
			jump = physics.jump - 1,
			gravity = physics.gravity - 1,
		})
		pova.do_override(player)
	else
		local player_physics_locked = player:get_meta():get_int("player_physics_locked")
		if player_physics_locked == nil or player_physics_locked == 0 then
			player:set_physics_override(physics)
		end
	end
	self.textures[name].armor = texture
	self.textures[name].preview = preview
	self.def[name].level = self.def[name].groups.fleshy or 0
	self.def[name].state = state
	self.def[name].count = count
	self:update_player_visuals(player)
end

--- Action when armor is punched.
--
--  @function armor:punch
--  @tparam ObjectRef player Player wearing the armor.
--  @tparam ObjectRef hitter Entity attacking player.
--  @tparam[opt] int time_from_last_punch Time in seconds since last punch action.
--  @tparam[opt] table tool_capabilities See `entity_damage_mechanism`.
armor.punch = function(self, player, hitter, time_from_last_punch, tool_capabilities)
	local name, armor_inv = self:get_valid_player(player, "[punch]")
	if not name then
		return
	end
	local set_state
	local set_count
	local state = 0
	local count = 0
	local recip = true
	local default_groups = {cracky=3, snappy=3, choppy=3, crumbly=3, level=1}
	local list = armor_inv:get_list("armor")
	for i, stack in pairs(list) do
		if stack:get_count() == 1 then
			local itemname = stack:get_name()
			local use = minetest.get_item_group(itemname, "armor_use") or 0
			local damage = use > 0
			local def = stack:get_definition() or {}
			if type(def.on_punched) == "function" then
				damage = def.on_punched(player, hitter, time_from_last_punch,
					tool_capabilities) ~= false and damage == true
			end
			if damage == true and tool_capabilities then
				local damage_groups = def.damage_groups or default_groups
				local level = damage_groups.level or 0
				local groupcaps = tool_capabilities.groupcaps or {}
				local uses = 0
				damage = false
				if next(groupcaps) == nil then
					damage = true
				end
				for group, caps in pairs(groupcaps) do
					local maxlevel = caps.maxlevel or 0
					local diff = maxlevel - level
					if diff == 0 then
						diff = 1
					end
					if diff > 0 and caps.times then
						local group_level = damage_groups[group]
						if group_level then
							local time = caps.times[group_level]
							if time then
								local dt = time_from_last_punch or 0
								if dt > time / diff then
									if caps.uses then
										uses = caps.uses * math.pow(3, diff)
									end
									damage = true
									break
								end
							end
						end
					end
				end
				if damage == true and recip == true and hitter and
						def.reciprocate_damage == true and uses > 0 then
					local item = hitter:get_wielded_item()
					if item and item:get_name() ~= "" then
						item:add_wear(65535 / uses)
						hitter:set_wielded_item(item)
					end
					-- reciprocate tool damage only once
					recip = false
				end
			end
			if damage == true and hitter == "fire" then
				damage = minetest.get_item_group(itemname, "flammable") > 0
			end
			if damage == true then
				self:damage(player, i, stack, use)
				set_state = self.def[name].state
				set_count = self.def[name].count
			end
			state = state + stack:get_wear()
			count = count + 1
		end
	end
	if set_count and set_count ~= count then
		state = set_state or state
		count = set_count or count
	end
	self.def[name].state = state
	self.def[name].count = count
end

--- Action when armor is damaged.
--
--  @function armor:damage
--  @tparam ObjectRef player
--  @tparam int index Inventory index where armor is equipped.
--  @tparam ItemStack stack Armor item receiving damaged.
--  @tparam int use Amount of wear to add to armor item.
armor.damage = function(self, player, index, stack, use)
	local old_stack = ItemStack(stack)
	local worn_armor = armor:get_weared_armor_elements(player)
	if not worn_armor then
		return
	end
	local armor_worn_cnt = 0
	for k,v in pairs(worn_armor) do
		armor_worn_cnt = armor_worn_cnt + 1
	end
	use = math.ceil(use/armor_worn_cnt)
	stack:add_wear(use)
	self:run_callbacks("on_damage", player, index, stack)
	self:set_inventory_stack(player, index, stack)
	if stack:get_count() == 0 then
		self:run_callbacks("on_unequip", player, index, old_stack)
		self:run_callbacks("on_destroy", player, index, old_stack)
		self:set_player_armor(player)
	end
end

--- Get elements of equipped armor.
--
--  @function armor:get_weared_armor_elements
--  @tparam ObjectRef player
--  @treturn table List of equipped armors.
armor.get_weared_armor_elements = function(self, player)
    local name, inv = self:get_valid_player(player, "[get_weared_armor]")
	local weared_armor = {}
	if not name then
		return
	end
    for i=1, inv:get_size("armor") do
        local item_name = inv:get_stack("armor", i):get_name()
        local element = self:get_element(item_name)
        if element ~= nil then
            weared_armor[element] = item_name
        end
	end
	return weared_armor
end

--- Equips a piece of armor to a player.
--
--  @function armor:equip
--  @tparam ObjectRef player Player to whom item is equipped.
--  @tparam ItemStack itemstack Armor item to be equipped.
--  @treturn ItemStack Leftover item stack.
armor.equip = function(self, player, itemstack)
    local name, armor_inv = self:get_valid_player(player, "[equip]")
    local armor_element = self:get_element(itemstack:get_name())
	if name and armor_element then
		local index
		for i=1, armor_inv:get_size("armor") do
			local stack = armor_inv:get_stack("armor", i)
			if self:get_element(stack:get_name()) == armor_element then
				--prevents equiping an armor that would unequip a cursed armor.
				if minetest.get_item_group(stack:get_name(), "cursed") ~= 0 then
					return itemstack
				end
				index = i
				self:unequip(player, armor_element)
				break
			elseif not index and stack:is_empty() then
				index = i
			end
		end
		local stack = itemstack:take_item()
		armor_inv:set_stack("armor", index, stack)
		self:run_callbacks("on_equip", player, index, stack)
		self:set_player_armor(player)
		self:save_armor_inventory(player)
	end
	return itemstack
end

--- Unequips a piece of armor from a player.
--
--  @function armor:unequip
--  @tparam ObjectRef player Player from whom item is removed.
--  @tparam string armor_element Armor type identifier associated with the item
--  to be removed ("head", "torso", "hands", "shield", "legs", "feet", etc.).
armor.unequip = function(self, player, armor_element)
    local name, armor_inv = self:get_valid_player(player, "[unequip]")
	if not name then
		return
	end
	for i=1, armor_inv:get_size("armor") do
		local stack = armor_inv:get_stack("armor", i)
		if self:get_element(stack:get_name()) == armor_element then
			armor_inv:set_stack("armor", i, "")
			minetest.after(0, function()
				local pplayer = minetest.get_player_by_name(name)
				if pplayer then -- player is still online
					local inv = pplayer:get_inventory()
					if inv:room_for_item("main", stack) then
						inv:add_item("main", stack)
					else
						minetest.add_item(pplayer:get_pos(), stack)
					end
				end
			end)
			self:run_callbacks("on_unequip", player, i, stack)
			self:set_player_armor(player)
			self:save_armor_inventory(player)
			return
		end
	end
end

--- Removes all armor worn by player.
--
--  @function armor:remove_all
--  @tparam ObjectRef player
armor.remove_all = function(self, player)
    local name, inv = self:get_valid_player(player, "[remove_all]")
	if not name then
		return
    end
	inv:set_list("armor", {})
	self:set_player_armor(player)
	self:save_armor_inventory(player)
end

local skin_mod

--- Retrieves player's current skin.
--
--  @function armor:get_player_skin
--  @tparam string name Player name.
--  @treturn string Skin filename.
armor.get_player_skin = function(self, name)
	if (skin_mod == "skins" or skin_mod == "simple_skins") and skins.skins[name] then
		return skins.skins[name]..".png"
	elseif skin_mod == "u_skins" and u_skins.u_skins[name] then
		return u_skins.u_skins[name]..".png"
	elseif skin_mod == "wardrobe" and wardrobe.playerSkins and wardrobe.playerSkins[name] then
		return wardrobe.playerSkins[name]
	end
	return armor.default_skin..".png"
end

--- Updates skin.
--
--  @function armor:update_skin
--  @tparam string name Player name.
armor.update_skin = function(self, name)
	minetest.after(0, function()
		local pplayer = minetest.get_player_by_name(name)
		if pplayer then
			self.textures[name].skin = self:get_player_skin(name)
			self:set_player_armor(pplayer)
		end
	end)
end

--- Adds preview for armor inventory.
--
--  @function armor:add_preview
--  @tparam string preview Preview image filename.
armor.add_preview = function(self, preview)
	skin_previews[preview] = true
end

--- Retrieves preview for armor inventory.
--
--  @function armor:get_preview
--  @tparam string name Player name.
--  @treturn string Preview image filename.
armor.get_preview = function(self, name)
	local preview = string.gsub(armor:get_player_skin(name), ".png", "_preview.png")
	if skin_previews[preview] then
		return preview
	end
	return "character_preview.png"
end

--- Retrieves armor formspec.
--
--  @function armor:get_armor_formspec
--  @tparam string name Player name.
--  @tparam[opt] bool listring Use `listring` formspec element (default: `false`).
--  @treturn string Formspec formatted string.
armor.get_armor_formspec = function(self, name, listring)
	local formspec = armor.formspec..
		"list[detached:"..name.."_armor;armor;0,0.5;2,3;]"
	if listring == true then
		formspec = formspec.."listring[current_player;main]"..
			"listring[detached:"..name.."_armor;armor]"
	end
	formspec = formspec:gsub("armor_preview", armor.textures[name].preview)
	formspec = formspec:gsub("armor_level", armor.def[name].level)
	for _, attr in pairs(self.attributes) do
		formspec = formspec:gsub("armor_attr_"..attr, armor.def[name][attr])
	end
	for group, _ in pairs(self.registered_groups) do
		formspec = formspec:gsub("armor_group_"..group,
			armor.def[name].groups[group])
	end
	return formspec
end

--- Retrieves element.
--
--  @function armor:get_element
--  @tparam string item_name
--  @return Armor element.
armor.get_element = function(self, item_name)
	for _, element in pairs(armor.elements) do
		if minetest.get_item_group(item_name, "armor_"..element) > 0 then
			return element
		end
	end
end

--- Serializes armor inventory.
--
--  @function armor:serialize_inventory_list
--  @tparam table list Inventory contents.
--  @treturn string
armor.serialize_inventory_list = function(self, list)
	local list_table = {}
	for _, stack in ipairs(list) do
		table.insert(list_table, stack:to_string())
	end
	return minetest.serialize(list_table)
end

--- Deserializes armor inventory.
--
--  @function armor:deserialize_inventory_list
--  @tparam string list_string Serialized inventory contents.
--  @treturn table
armor.deserialize_inventory_list = function(self, list_string)
	local list_table = minetest.deserialize(list_string)
	local list = {}
	for _, stack in ipairs(list_table or {}) do
		table.insert(list, ItemStack(stack))
	end
	return list
end

--- Loads armor inventory.
--
--  @function armor:load_armor_inventory
--  @tparam ObjectRef player
--  @treturn bool
armor.load_armor_inventory = function(self, player)
	local _, inv = self:get_valid_player(player, "[load_armor_inventory]")
	if inv then
		local meta = player:get_meta()
		local armor_list_string = meta:get_string("3d_armor_inventory")
		if armor_list_string then
			inv:set_list("armor",
				self:deserialize_inventory_list(armor_list_string))
			return true
		end
	end
end

--- Saves armor inventory.
--
--  Inventory is stored in `PlayerMetaRef` string "3d\_armor\_inventory".
--
--  @function armor:save_armor_inventory
--  @tparam ObjectRef player
armor.save_armor_inventory = function(self, player)
	local _, inv = self:get_valid_player(player, "[save_armor_inventory]")
	if inv then
		local meta = player:get_meta()
		meta:set_string("3d_armor_inventory",
			self:serialize_inventory_list(inv:get_list("armor")))
	end
end

--- Updates inventory.
--
--  DEPRECATED: Legacy inventory support.
--
--  @function armor:update_inventory
--  @param player
armor.update_inventory = function(self, player)
	-- DEPRECATED: Legacy inventory support
end

--- Sets inventory stack.
--
--  @function armor:set_inventory_stack
--  @tparam ObjectRef player
--  @tparam int i Armor inventory index.
--  @tparam ItemStack stack Armor item.
armor.set_inventory_stack = function(self, player, i, stack)
	local _, inv = self:get_valid_player(player, "[set_inventory_stack]")
	if inv then
		inv:set_stack("armor", i, stack)
		self:save_armor_inventory(player)
	end
end

--- Checks for a player that can use armor.
--
--  @function armor:get_valid_player
--  @tparam ObjectRef player
--  @tparam string msg Additional info for log messages.
--  @treturn list Player name & armor inventory.
--  @usage local name, inv = armor:get_valid_player(player, "[equip]")
armor.get_valid_player = function(self, player, msg)
	msg = msg or ""
	if not player then
		minetest.log("warning", ("3d_armor%s: Player reference is nil"):format(msg))
		return
	end
	if type(player) ~= "userdata" then
		-- Fake player, fail silently
		return
	end
	local name = player:get_player_name()
	if not name then
		minetest.log("warning", ("3d_armor%s: Player name is nil"):format(msg))
		return
	end
	local inv = minetest.get_inventory({type="detached", name=name.."_armor"})
	if not inv then
		-- This check may fail when called inside `on_joinplayer`
		-- in that case, the armor will be initialized/updated later on
		minetest.log("warning", ("3d_armor%s: Detached armor inventory is nil"):format(msg))
		return
	end
	return name, inv
end

--- Drops armor item at given position.
--
--  @tparam vector pos
--  @tparam ItemStack stack Armor item to be dropped.
armor.drop_armor = function(pos, stack)
	local node = minetest.get_node_or_nil(pos)
	if node then
		local obj = minetest.add_item(pos, stack)
		if obj then
			obj:set_velocity({x=math.random(-1, 1), y=5, z=math.random(-1, 1)})
		end
	end
end

--- Allows skin mod to be set manually.
--
--  Useful for skin mod forks that do not use the same name.
--
--  @tparam string mod Name of skin mod. Recognized names are "simple\_skins", "u\_skins", & "wardrobe".
armor.set_skin_mod = function(mod)
	skin_mod = mod
end
