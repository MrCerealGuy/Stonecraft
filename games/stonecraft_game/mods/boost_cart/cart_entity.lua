
local HAVE_MESECONS_ENABLED = minetest.global_exists("mesecon")

function boost_cart:on_rail_step(pos)
	-- Play rail sound
	if self.sound_counter <= 0 then
		minetest.sound_play("cart_rail", {
			pos = pos,
			max_hear_distance = 40,
			gain = 0.5
		})
		self.sound_counter = math.random(4, 15)
	end
	self.sound_counter = self.sound_counter - 1

	if HAVE_MESECONS_ENABLED then
		boost_cart:signal_detector_rail(pos)
	end
end

local cart_entity = {
	physical = false,
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	visual = "mesh",
	mesh = "cart.x",
	visual_size = {x=1, y=1},
	textures = {"cart.png"},

	driver = nil,
	punched = false, -- used to re-send velocity and position
	velocity = {x=0, y=0, z=0}, -- only used on punch
	old_dir = {x=1, y=0, z=0}, -- random value to start the cart on punch
	old_pos = nil,
	old_switch = 0,
	sound_counter = 0,
	railtype = nil,
	attached_items = {}
}

-- Model and textures
if boost_cart.mtg_compat then
	cart_entity.mesh = "carts_cart.b3d"
	cart_entity.textures = {"carts_cart.png"}
end

function cart_entity:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	local player_name = clicker:get_player_name()
	if self.driver and player_name == self.driver then
		self.driver = nil
		boost_cart:manage_attachment(clicker, nil)
	elseif not self.driver then
		self.driver = player_name
		boost_cart:manage_attachment(clicker, self.object)
	end
end

function cart_entity:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	self.sound_counter = math.random(4, 15)

	if string.sub(staticdata, 1, string.len("return")) ~= "return" then
		return
	end
	local data = minetest.deserialize(staticdata)
	if not data or type(data) ~= "table" then
		return
	end
	self.railtype = data.railtype
	if data.old_dir then
		self.old_dir = data.old_dir
	end
end

function cart_entity:get_staticdata()
	return minetest.serialize({
		railtype = self.railtype,
		old_dir = self.old_dir
	})
end

function cart_entity:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	local pos = self.object:getpos()
	if not self.railtype then
		local node = minetest.get_node(pos).name
		self.railtype = minetest.get_item_group(node, "connect_to_raillike")
	end

	if not puncher or not puncher:is_player() then
		local cart_dir = boost_cart:get_rail_direction(pos, self.old_dir, nil, nil, self.railtype)
		if vector.equals(cart_dir, {x=0, y=0, z=0}) then
			return
		end
		self.velocity = vector.multiply(cart_dir, 3)
		self.punched = true
		return
	end

	if puncher:get_player_control().sneak then
		-- Pick up cart: Drop all attachments
		if self.driver then
			if self.old_pos then
				self.object:setpos(self.old_pos)
			end
			local player = minetest.get_player_by_name(self.driver)
			boost_cart:manage_attachment(player, nil)
		end
		for _, obj_ in pairs(self.attached_items) do
			if obj_ then
				obj_:set_detach()
			end
		end

		local leftover = puncher:get_inventory():add_item("main", "carts:cart")
		if not leftover:is_empty() then
			minetest.add_item(pos, leftover)
		end

		self.object:remove()
		return
	end

	local vel = self.object:getvelocity()
	if puncher:get_player_name() == self.driver then
		if math.abs(vel.x + vel.z) > boost_cart.punch_speed_max then
			return
		end
	end

	local punch_dir = boost_cart:velocity_to_dir(puncher:get_look_dir())
	punch_dir.y = 0
	local cart_dir = boost_cart:get_rail_direction(pos, punch_dir, nil, nil, self.railtype)
	if vector.equals(cart_dir, {x=0, y=0, z=0}) then
		return
	end

	local punch_interval = 1
	if tool_capabilities and tool_capabilities.full_punch_interval then
		punch_interval = tool_capabilities.full_punch_interval
	end
	time_from_last_punch = math.min(time_from_last_punch or punch_interval, punch_interval)
	local f = 3 * (time_from_last_punch / punch_interval)

	self.velocity = vector.multiply(cart_dir, f)
	self.old_dir = cart_dir
	self.punched = true
end

function cart_entity:on_step(dtime)
	local vel = self.object:getvelocity()
	if self.punched then
		vel = vector.add(vel, self.velocity)
		self.object:setvelocity(vel)
		self.old_dir.y = 0
	elseif vector.equals(vel, {x=0, y=0, z=0}) then
		return
	end

	local pos = self.object:getpos()
	local update = {}

	if self.old_pos and not self.punched then
		local flo_pos = vector.round(pos)
		local flo_old = vector.round(self.old_pos)
		if vector.equals(flo_pos, flo_old) then
			-- Do not check one node multiple times
			return
		end
	end

	local ctrl, player

	-- Get player controls
	if self.driver then
		player = minetest.get_player_by_name(self.driver)
		if player then
			ctrl = player:get_player_control()
		end
	end

	if self.old_pos then
		-- Detection for "skipping" nodes
		local found_path = boost_cart:pathfinder(
			pos, self.old_pos, self.old_dir, ctrl, self.old_switch, self.railtype
		)

		if not found_path then
			-- No rail found: reset back to the expected position
			pos = vector.new(self.old_pos)
			update.pos = true
		end
	end

	local cart_dir = boost_cart:velocity_to_dir(vel)

	-- dir:         New moving direction of the cart
	-- switch_keys: Currently pressed L/R key, used to ignore the key on the next rail node
	local dir, switch_keys = boost_cart:get_rail_direction(
		pos, cart_dir, ctrl, self.old_switch, self.railtype
	)

	local new_acc = {x=0, y=0, z=0}
	if vector.equals(dir, {x=0, y=0, z=0}) then
		vel = {x=0, y=0, z=0}
		pos = vector.round(pos)
		update.pos = true
		update.vel = true
	else
		-- Direction change detected
		if not vector.equals(dir, self.old_dir) then
			vel = vector.multiply(dir, math.abs(vel.x + vel.z))
			update.vel = true
			if dir.y ~= self.old_dir.y then
				pos = vector.round(pos)
				update.pos = true
			end
		end
		-- Center on the rail
		if dir.z ~= 0 and math.floor(pos.x + 0.5) ~= pos.x then
			pos.x = math.floor(pos.x + 0.5)
			update.pos = true
		end
		if dir.x ~= 0 and math.floor(pos.z + 0.5) ~= pos.z then
			pos.z = math.floor(pos.z + 0.5)
			update.pos = true
		end

		-- Calculate current cart acceleration
		local acc = nil

		local acc_meta = minetest.get_meta(pos):get_string("cart_acceleration")
		if acc_meta == "halt" then
			-- Stop rail
			vel = {x=0, y=0, z=0}
			acc = false
			pos = vector.round(pos)
			update.pos = true
			update.vel = true
			mod_found = true
		end
		if acc == nil then
			-- Meta speed modifier
			local speed_mod = tonumber(acc_meta)
			if speed_mod and speed_mod ~= 0 then
				-- Try to make it similar to the original carts mod
				acc = speed_mod * 10
			end
		end
		if acc == nil and boost_cart.mtg_compat then
			-- MTG Cart API adaption
			local rail_node = minetest.get_node(vector.round(pos))
			local railparam = carts.railparams[rail_node.name]
			if railparam and railparam.acceleration then
				acc = railparam.acceleration
			end
		end
		if acc == nil then
			-- Handbrake
			if ctrl and ctrl.down then
				acc = -2
			else
				acc = -0.4
			end
		end

		-- Slow down or speed up, depending on Y direction
		if acc then
			acc = acc + dir.y * -2.5
		else
			acc = 0
		end

		if self.old_dir.y ~= 1 and not self.punched then
			-- Stop the cart swing between two rail parts (handbrake)
			if vector.equals(vector.multiply(self.old_dir, -1), dir) then
				vel = {x=0, y=0, z=0}
				acc = 0
				if self.old_pos then
					pos = vector.new(self.old_pos)
					update.pos = true
				end
				dir = vector.new(self.old_dir)
				update.vel = true
			end
		end

		new_acc = vector.multiply(dir, acc)
	end
	boost_cart.on_rail_step(self, vector.round(pos))

	-- Limits
	local max_vel = boost_cart.speed_max
	for _,v in pairs({"x","y","z"}) do
		if math.abs(vel[v]) > max_vel then
			vel[v] = boost_cart:get_sign(vel[v]) * max_vel
			new_acc[v] = 0
			update.vel = true
		end
	end

	self.object:setacceleration(new_acc)
	self.old_pos = pos
	if not vector.equals(dir, {x=0, y=0, z=0}) then
		self.old_dir = dir
	end
	self.old_switch = switch_keys


	if self.punched then
		-- Collect dropped items
		for _, obj_ in pairs(minetest.get_objects_inside_radius(pos, 1)) do
			if not obj_:is_player() and
					obj_:get_luaentity() and
					not obj_:get_luaentity().physical_state and
					obj_:get_luaentity().name == "__builtin:item" then

				obj_:set_attach(self.object, "", {x=0, y=0, z=0}, {x=0, y=0, z=0})
				self.attached_items[#self.attached_items + 1] = obj_
			end
		end
		self.punched = false
		update.vel = true
	end

	if not (update.vel or update.pos) then
		return
	end

	local yaw = 0
	if self.old_dir.x < 0 then
		yaw = 0.5
	elseif self.old_dir.x > 0 then
		yaw = 1.5
	elseif self.old_dir.z < 0 then
		yaw = 1
	end
	self.object:setyaw(yaw * math.pi)

	local anim = {x=0, y=0}
	if dir.y == -1 then
		anim = {x=1, y=1}
	elseif dir.y == 1 then
		anim = {x=2, y=2}
	end
	self.object:set_animation(anim, 1, 0)

	self.object:setvelocity(vel)
	if update.pos then
		self.object:setpos(pos)
	end
end

minetest.register_entity(":carts:cart", cart_entity)

-- Register item to place the entity
if not boost_cart.mtg_compat then
	minetest.register_craftitem(":carts:cart", {
		description = "Cart (Sneak+Click to pick up)",
		inventory_image = minetest.inventorycube(
			"cart_top.png",
			"cart_side.png",
			"cart_side.png"
		),
		wield_image = "cart_side.png",
		on_place = function(itemstack, placer, pointed_thing)
			if not pointed_thing.type == "node" then
				return
			end
			if boost_cart:is_rail(pointed_thing.under) then
				minetest.add_entity(pointed_thing.under, "carts:cart")
			elseif boost_cart:is_rail(pointed_thing.above) then
				minetest.add_entity(pointed_thing.above, "carts:cart")
			else
				return
			end

			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end,
	})

	minetest.register_craft({
		output = "carts:cart",
		recipe = {
			{"default:steel_ingot", "", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		},
	})
end
