throwing = {}

throwing.arrows = {}

throwing.target_object = 1
throwing.target_node = 2
throwing.target_both = 3

throwing.modname = minetest.get_current_modname()
local S = minetest.get_translator("throwing")
local use_toolranks = minetest.get_modpath("toolranks") and minetest.settings:get_bool("throwing.toolranks", true)

--------- Arrows functions ---------
function throwing.is_arrow(itemstack)
	return throwing.arrows[ItemStack(itemstack):get_name()]
end

function throwing.spawn_arrow_entity(pos, arrow, player)
	if throwing.is_arrow(arrow) then
		return minetest.add_entity(pos, arrow.."_entity")
	elseif minetest.registered_items[arrow].throwing_entity then
		if type(minetest.registered_items[arrow].throwing_entity) == "string" then
			return minetest.add_entity(pos, minetest.registered_items[arrow].throwing_entity)
		else -- Type is a function
			return minetest.registered_items[arrow].throwing_entity(pos, player)
		end
	else
		return minetest.add_entity(pos, "__builtin:item", arrow)
	end
end

local function apply_realistic_acceleration(obj, mass)
	if not minetest.settings:get_bool("throwing.realistic_trajectory", false) then
		return
	end

	local vertical_acceleration = tonumber(minetest.settings:get("throwing.vertical_acceleration")) or -10
	local friction_coef = tonumber(minetest.settings:get("throwing.frictional_coefficient")) or -3

	local velocity = obj:get_velocity()
	obj:set_acceleration({
		x = friction_coef * velocity.x / mass,
		y = friction_coef * velocity.y / mass + vertical_acceleration,
		z = friction_coef * velocity.z / mass
	})
end

local function shoot_arrow(def, toolranks_data, player, bow_index, throw_itself, new_stack)
	local inventory = player:get_inventory()
	local arrow_index
	if throw_itself then
		arrow_index = bow_index
	else
		if bow_index >= player:get_inventory():get_size("main") then
			return false
		end
		arrow_index = bow_index + 1
	end
	local arrow_stack = inventory:get_stack("main", arrow_index)
	local arrow = arrow_stack:get_name()

	local playerpos = player:get_pos()
	local pos = {x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}
	local obj = (def.spawn_arrow_entity or throwing.spawn_arrow_entity)(pos, arrow, player)

	local luaentity = obj:get_luaentity()

	-- Set custom data in the entity
	luaentity.player = player:get_player_name()
	if not luaentity.item then
		luaentity.item = arrow
	end
	luaentity.data = {}
	luaentity.timer = 0
	luaentity.toolranks = toolranks_data -- May be nil if toolranks is disabled

	if luaentity.on_throw then
		if luaentity:on_throw(pos, player, arrow_stack, arrow_index, luaentity.data) == false then
			obj:remove()
			return false
		end
	end

	local dir = player:get_look_dir()
	local vertical_acceleration = tonumber(minetest.settings:get("throwing.vertical_acceleration")) or -10
	local velocity_factor = tonumber(minetest.settings:get("throwing.velocity_factor")) or 19
	local velocity_mode = minetest.settings:get("throwing.velocity_mode") or "strength"

	local velocity
	if velocity_mode == "simple" then
		velocity = velocity_factor
	elseif velocity_mode == "momentum" then
		velocity = def.strength * velocity_factor / luaentity.mass
	else
		velocity = def.strength * velocity_factor
	end

	obj:set_velocity({
		x = dir.x * velocity,
		y = dir.y * velocity,
		z = dir.z * velocity
	})
	obj:set_acceleration({x = 0, y = vertical_acceleration, z = 0})
	obj:set_yaw(player:get_look_horizontal()-math.pi/2)

	apply_realistic_acceleration(obj, luaentity.mass)

	if luaentity.on_throw_sound ~= "" then
		minetest.sound_play(luaentity.on_throw_sound or "throwing_sound", {pos=playerpos, gain = 0.5})
	end

	if not minetest.settings:get_bool("creative_mode") then
		inventory:set_stack("main", arrow_index, new_stack)
	end

	return true
end

function throwing.arrow_step(self, dtime)
	if not self.timer or not self.player then
		self.object:remove()
		return
	end

	self.timer = self.timer + dtime
	local pos = self.object:get_pos()
	local node = minetest.get_node(pos)

	local logging = function(message, level)
		minetest.log(level or "action", "[throwing] Arrow "..(self.item or self.name).." throwed by player "..self.player.." "..tostring(self.timer).."s ago "..message)
	end

	local hit = function(pos1, node1, obj)
		if obj then
			if obj:is_player() then
				if obj:get_player_name() == self.player then -- Avoid hitting the hitter
					return false
				end
			end
		end

		local player = minetest.get_player_by_name(self.player)
		if not player then -- Possible if the player disconnected
			return
		end

		local function hit_failed()
			if not minetest.settings:get_bool("creative_mode") and self.item then
				player:get_inventory():add_item("main", self.item)
			end
			if self.on_hit_fails then
				self:on_hit_fails(pos1, player, self.data)
			end
		end

		if not self.last_pos then
			logging("hitted a node during its first call to the step function")
			hit_failed()
			return
		end

		if node1 and minetest.is_protected(pos1, self.player) and not self.allow_protected then -- Forbid hitting nodes in protected areas
			minetest.record_protection_violation(pos1, self.player)
			logging("hitted a node into a protected area")
			return
		end

		if self.on_hit then
			local ret, reason = self:on_hit(pos1, self.last_pos, node1, obj, player, self.data)
			if ret == false then
				if reason then
					logging(": on_hit function failed for reason: "..reason)
				else
					logging(": on_hit function failed")
				end

				hit_failed()
				return
			end
		end

		if self.on_hit_sound then
			minetest.sound_play(self.on_hit_sound, {pos = pos1, gain = 0.8})
		end

		local identifier
		if node1 then
			identifier = "node " .. node1.name
		elseif obj then
			if obj:get_luaentity() then
				identifier = "luaentity " .. obj:get_luaentity().name
			elseif obj:is_player() then
				identifier = "player " .. obj:get_player_name()
			else
				identifier = "unknown object"
			end
		end
		if identifier then
			logging("collided with " .. identifier .. " at " .. minetest.pos_to_string(pos1) .. ")")
		end

		-- Toolranks support: update bow uses
		if self.toolranks then
			local inventory = player:get_inventory()
			-- Check that the player did not move the bow
			local current_stack = inventory:get_stack("main", self.toolranks.index)
			if current_stack:get_name() == self.toolranks.name then
				local new_itemstack = toolranks.new_afteruse(current_stack, player, nil, {wear = self.toolranks.wear})
				inventory:set_stack("main", self.toolranks.index, new_itemstack)
			end
		end
	end

	-- Collision with a node
	if node.name == "ignore" then
		self.object:remove()
		logging("reached ignore. Removing.")
		return
	elseif (minetest.registered_items[node.name] or {}).drawtype ~= "airlike" then
		if self.target ~= throwing.target_object then -- throwing.target_both, nil, throwing.target_node, or any invalid value
			if hit(pos, node, nil) ~= false then
				self.object:remove()
			end
		else
			self.object:remove()
		end
		return
	end

	-- Collision with an object
	local objs = minetest.get_objects_inside_radius(pos, 1)
	for k, obj in pairs(objs) do
		if obj:get_luaentity() then
			if obj:get_luaentity().name ~= self.name and obj:get_luaentity().name ~= "__builtin:item" then
				if self.target ~= throwing.target_node then -- throwing.target_both, nil, throwing.target_object, or any invalid value
					if hit(pos, nil, obj) ~= false then
						self.object:remove()
					end
				else
					self.object:remove()
				end
			end
		else
			if self.target ~= throwing.target_node then -- throwing.target_both, nil, throwing.target_object, or any invalid value
				if hit(pos, nil, obj) ~= false then
					self.object:remove()
				end
			else
				self.object:remove()
			end
		end
	end

	-- Support for shining items using wielded light
	if minetest.global_exists("wielded_light") and self.object then
		wielded_light.update_light_by_item(self.item, self.object:get_pos())
	end

	apply_realistic_acceleration(self.object, self.mass) -- Physics: air friction

	self.last_pos = pos -- Used by the build arrow
end

-- Backwards compatibility
function throwing.make_arrow_def(def)
	def.on_step = throwing.arrow_step
	return def
end

--[[
on_hit(pos, last_pos, node, object, hitter)
Either node or object is nil, depending whether the arrow collided with an object (luaentity or player) or with a node.
No log message is needed in this function (a generic log message is automatically emitted), except on error or warning.
Should return false or false, reason on failure.

on_throw(pos, hitter)
Unlike on_hit, it is optional.
]]
function throwing.register_arrow(name, def)
	throwing.arrows[name] = true

	local registration_name = name
	if name:sub(1,9) == "throwing:" then
		registration_name = ":"..name
	end

	if not def.groups then
		def.groups = {}
	end
	if not def.groups.dig_immediate then
		def.groups.dig_immediate = 3
	end

	def.inventory_image = def.tiles[1]
	def.on_place = function(itemstack, placer, pointed_thing)
		if minetest.settings:get_bool("throwing.allow_arrow_placing") and pointed_thing.above then
			local playername = placer:get_player_name()
			if not minetest.is_protected(pointed_thing.above, playername) then
				minetest.log("action", "Player "..playername.." placed arrow "..name.." at "..minetest.pos_to_string(pointed_thing.above))
				minetest.set_node(pointed_thing.above, {name = name})
				itemstack:take_item()
				return itemstack
			else
				minetest.log("warning", "Player "..playername.." tried to place arrow "..name.." into a protected area at "..minetest.pos_to_string(pointed_thing.above))
				minetest.record_protection_violation(pointed_thing.above, playername)
				return itemstack
			end
		else
			return itemstack
		end
	end
	def.drawtype = "nodebox"
	def.paramtype = "light"
	def.node_box = {
		type = "fixed",
		fixed = {
			-- Shaft
			{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
			-- Spitze
			{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
			{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
			-- Federn
			{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
			{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
			{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
			{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},

			{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
			{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
			{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
			{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
		}
	}
	minetest.register_node(registration_name, def)

	minetest.register_entity(registration_name.."_entity", {
		physical = false,
		visual = "wielditem",
		visual_size = {x = 0.125, y = 0.125},
		textures = {name},
		collisionbox = {0, 0, 0, 0, 0, 0},
		on_hit = def.on_hit,
		on_hit_sound = def.on_hit_sound,
		on_throw_sound = def.on_throw_sound,
		on_throw = def.on_throw,
		allow_protected = def.allow_protected,
		target = def.target,
		on_hit_fails = def.on_hit_fails,
		on_step = throwing.arrow_step,
		item = name,
		mass = def.mass or 1,
	})
end


---------- Bows -----------
if use_toolranks and minetest.get_modpath("toolranks_extras") and toolranks_extras.register_tool_type then
	toolranks_extras.register_tool_type("bow", S("bow"), S("Arrows thrown"))
end

function throwing.register_bow(name, def)
	local enable_toolranks = use_toolranks and not def.no_toolranks

	def.name = name

	if not def.allow_shot then
		def.allow_shot = function(player, itemstack, index)
			if index >= player:get_inventory():get_size("main") and not def.throw_itself then
				return false
			end
			return throwing.is_arrow(itemstack) or def.throw_itself
		end
	end

	if not def.inventory_image then
		def.inventory_image = def.texture
	end

	if not def.strength then
		def.strength = 20
	end

	def.on_use = function(itemstack, user, pointed_thing)
		-- Cooldown
		local meta = itemstack:get_meta()
		local cooldown = def.cooldown or tonumber(minetest.settings:get("throwing.bow_cooldown")) or 0.2

		if cooldown > 0 and meta:get_int("cooldown") > os.time()
				or meta:get_int("delay") > os.time() then
			return
		end

		local bow_index = user:get_wield_index()
		local arrow_index = (def.throw_itself and bow_index) or bow_index+1
		local res, new_stack = def.allow_shot(user, user:get_inventory():get_stack("main", arrow_index), arrow_index, false)
		if not res then
			return (def.throw_itself and new_stack) or itemstack
		end

		-- Sound
		if def.sound then
			minetest.sound_play(def.sound, {to_player=user:get_player_name()})
		end

		meta:set_int("delay", os.time() + (def.delay or 0))
		minetest.after(def.delay or 0, function()
			-- Re-check that the arrow can be thrown. Overwrite the new_stack
			local old_new_stack = new_stack

			local arrow_stack = user:get_inventory():get_stack("main", arrow_index)

			res, new_stack = def.allow_shot(user, arrow_stack, arrow_index, true)
			if not res then
				return
			end

			if not new_stack then
				new_stack = old_new_stack
			end
			if not new_stack then
				arrow_stack:take_item()
				new_stack = arrow_stack
			end

			-- Shoot arrow
			local uses = 65535 / (def.uses or 50)
			local toolranks_data
			if enable_toolranks then
				toolranks_data = {
					name = itemstack:get_name(),
					index = bow_index,
					wear = uses
				}
			end
			if shoot_arrow(def, toolranks_data, user, bow_index, def.throw_itself, new_stack) then
				if not minetest.settings:get_bool("creative_mode") then
					itemstack:add_wear(uses)
				end
			end


			if def.throw_itself then
				-- This is a bug. If we return ItemStack(nil), the player punches the entity,
				-- and if the entity is a __builtin:item, it gets back to his inventory.
				minetest.after(0.1, function()
					user:get_inventory():remove_item("main", itemstack)
				end)
			elseif cooldown > 0 then
				meta:set_int("cooldown", os.time() + cooldown)
			end
			user:get_inventory():set_stack("main", bow_index, itemstack)
		end)
		return itemstack
	end

	if enable_toolranks then
		def.original_description = def.original_description or def.description
		def.description = toolranks.create_description(def.description)
	end

	minetest.register_tool(name, def)
end
