--============
--Snowballs
--============

-- Snowballs were destroying nodes if the snowballs landed just right.
-- Quite a bit of trial-and-error learning here and it boiled down to a
-- small handful of code lines making the difference. ~ LazyJ

local creative_mode = minetest.settings:get_bool"creative_mode"


local snowball_velocity, entity_attack_delay
local function update_snowball_vel(v)
	snowball_velocity = v
	local walkspeed = tonumber(minetest.settings:get"movement_speed_walk") or 4
	entity_attack_delay = (walkspeed+1)/v
end
update_snowball_vel(snow.snowball_velocity)

local snowball_gravity = snow.snowball_gravity
snow.register_on_configuring(function(name, v)
	if name == "snowball_velocity" then
		update_snowball_vel(v)
	elseif name == "snowball_gravity" then
		snowball_gravity = v
	end
end)

local function get_gravity()
	local grav = tonumber(minetest.settings:get"movement_gravity") or 9.81
	return grav*snowball_gravity
end

local someone_throwing, just_acitvated

--Shoot snowball
function snow.shoot_snowball(item, player)
	local addp = {y = 1.625} -- + (math.random()-0.5)/5}
	local dir = player:get_look_dir()
	local dif = 2*math.sqrt(dir.z*dir.z+dir.x*dir.x)
	addp.x = dir.z/dif -- + (math.random()-0.5)/5
	addp.z = -dir.x/dif -- + (math.random()-0.5)/5
	local pos = vector.add(player:get_pos(), addp)
	local obj = minetest.add_entity(pos, "snow:snowball_entity")
	obj:set_velocity(vector.multiply(dir, snowball_velocity))
	obj:set_acceleration({x=dir.x*-3, y=-get_gravity(), z=dir.z*-3})
	obj:get_luaentity().thrower = player:get_player_name()
	if creative_mode then
		if not someone_throwing then
			someone_throwing = true
			just_acitvated = true
		end
		return
	end
	item:take_item()
	return item
end

if creative_mode then
	local function update_step()
		local active
		for _,player in pairs(minetest.get_connected_players()) do
			if player:get_player_control().LMB then
				local item = player:get_wielded_item()
				local itemname = item:get_name()
				if itemname == "default:snow" then
					snow.shoot_snowball(nil, player)
					active = true
					break
				end
			end
		end

		-- disable the function if noone currently throws them
		if not active then
			someone_throwing = false
		end
	end

	-- do automatic throwing using minetest.after
	local function do_step()
		local timer
		-- only if one holds left click
		if someone_throwing
		and not just_acitvated then
			update_step()
			timer = 0.006
		else
			timer = 0.5
			just_acitvated = false
		end
		minetest.after(timer, do_step)
	end
	minetest.after(3, do_step)
end

--The snowball Entity
local snow_snowball_ENTITY = {
	physical = false,
	timer = 0,
	collisionbox = {-5/16,-5/16,-5/16, 5/16,5/16,5/16},
}

function snow_snowball_ENTITY.on_activate(self)
	self.object:set_properties({textures = {"default_snowball.png^[transform"..math.random(0,7)}})
	self.object:set_acceleration({x=0, y=-get_gravity(), z=0})
	self.lastpos = self.object:get_pos()
	minetest.after(0.1, function(obj)
		if not obj then
			return
		end
		local vel = obj:get_velocity()
		if vel
		and vel.y ~= 0 then
			return
		end
		minetest.after(0, function(object)
			if not object then
				return
			end
			local vel_obj = object:get_velocity()
			if not vel_obj
			or vel_obj.y == 0 then
				object:remove()
			end
		end, obj)
	end, self.object)
end

--Snowball_entity.on_step()--> called when snowball is moving.
function snow_snowball_ENTITY.on_step(self, dtime)
	self.timer = self.timer + dtime
	if self.timer > 10 then
		-- 10 seconds is too long for a snowball to fly somewhere
		self.object:remove()
		return
	end

	if self.physical then
		local vel = self.object:get_velocity()
		local fell = vel.y == 0
		if not fell then
			if self.probably_stuck then
				self.probably_stuck = nil
			end
			return
		end
		if self.probably_stuck
		and vel.x == 0
		and vel.z == 0 then
			-- add a small velocity to move it from the corner
			vel.x = math.random() - 0.5
			vel.z = math.random() - 0.5
			self.object:set_velocity(vel)
			self.probably_stuck = nil
			return
		end
		local pos = vector.round(self.object:get_pos())
		if minetest.get_node(pos).name == "air" then
			pos.y = pos.y-1
			if minetest.get_node(pos).name == "air" then
				if vel.x == 0
				and vel.z == 0 then
					self.probably_stuck = true
				end
				return
			end
		end
		snow.place(pos)
		self.object:remove()
		return
	end

	local pos = vector.round(self.object:get_pos())
	if vector.equals(pos, self.lastpos) then
		return
	end
	if minetest.get_node(pos).name ~= "air" then
		self.object:set_acceleration({x=0, y=-get_gravity(), z=0})
		--self.object:set_velocity({x=0, y=0, z=0})
		pos = self.lastpos
		self.object:setpos(pos)
		minetest.sound_play("default_snow_footstep", {pos=pos, gain=vector.length(self.object:get_velocity())/30})
		self.object:set_properties({physical = true})
		self.physical = true
		return
	end
	self.lastpos = vector.new(pos)

	if self.timer < entity_attack_delay then
		return
	end
	for _,v in pairs(minetest.get_objects_inside_radius(pos, 1.73)) do
		local entity = v:get_luaentity()
		if v ~= self.object
		and entity then
			local entity_name = entity.name
			if v:is_player()
			or (entity_name ~= "snow:snowball_entity"
			and entity_name ~= "__builtin:item"
			and entity_name ~= "gauges:hp_bar") then
				local vvel = v:get_velocity() or v:get_player_velocity()
				local veldif = self.object:get_velocity()
				if vvel then
					veldif = vector.subtract(veldif, vvel)
				end
				local gain = vector.length(veldif)/20
				v:punch(
					(self.thrower and minetest.get_player_by_name(self.thrower))
						or self.object,
					1,
					{full_punch_interval=1, damage_groups = {fleshy=math.ceil(gain)}}
				)
				minetest.sound_play("default_snow_footstep", {pos=pos, gain=gain})

				-- spawn_falling_node
				local obj = minetest.add_entity(pos, "__builtin:falling_node")
				if obj then
					obj:get_luaentity():set_node{name = "default:snow"}
				else
					minetest.log("error", "Couldn't spawn falling node")
				end

				self.object:remove()
				return
			end
		end
	end
end



minetest.register_entity("snow:snowball_entity", snow_snowball_ENTITY)



-- Snowball and Default Snowball Merged

-- They both look the same, they do basically the same thing (except one is a leftclick throw
-- and the other is a rightclick drop),... Why not combine snow:snowball with default:snow and
-- benefit from both? ~ LazyJ, 2014_04_08

--[[ Save this for reference and occasionally compare to the default code for any updates.

minetest.register_node(":default:snow", {
	description = "Snow",
	tiles = {"default_snow.png"},
	inventory_image = "default_snowball.png",
	wield_image = "default_snowball.png",
	is_ground_content = true,
	paramtype = "light",
	buildable_to = true,
	leveled = 7,
	drawtype = "nodebox",
	freezemelt = "default:water_flowing",
	node_box = {
		type = "leveled",
		fixed = {
			{-0.5, -0.5, -0.5,  0.5, -0.5+2/16, 0.5},
		},
	},
	groups = {crumbly=3,falling_node=1, melts=1, float=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.25},
		dug = {name="default_snow_footstep", gain=0.75},
	}),
	on_construct = function(pos)
		if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		== "default:dirt_with_grass"
		or minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "default:dirt" then
			minetest.set_node({x=pos.x, y=pos.y-1, z=pos.z}, {name="default:dirt_with_snow"})
		end
		-- Now, let's turn the snow pile into a snowblock. ~ LazyJ
		if minetest.get_node({x=pos.x, y=pos.y-2, z=pos.z}).name == "default:snow"
		and -- Minus 2 because at the end of this, the layer that triggers
		--the change to a snowblock is the second layer more than a full block,
		--starting into a second block (-2) ~ LazyJ, 2014_04_11
			minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "default:snow" then
			minetest.set_node({x=pos.x, y=pos.y-2, z=pos.z}, {name="default:snowblock"})
		end
	end,
	on_use = snow_shoot_snowball  -- This line is from the 'Snow' mod, the reset is default Minetest.
})
--]]



--[[
A note about default torches, melting, and "buildable_to = true" in default snow.

On servers where buckets are disabled, snow and ice stuff is used to set water for crops and
water stuff like fountains, pools, ponds, ect.. It is a common practice to set a default torch on
the snow placed where the players want water to be.

If you place a default torch *on* default snow to melt it, instead of melting the snow is
*replaced* by the torch. Using "buildable_to = false" would fix this but then the snow would no
longer pile-up in layers; the snow would stack like thin shelves in a vertical column.

I tinkered with the default torch's code (see below) to check for snow at the position and one
node above (layered snow logs as the next y position above) but default snow's
"buildable_to = true" always happened first. An interesting exercise to better learn how Minetest
works, but otherwise not worth it. If you set a regular torch near snow, the snow will melt
and disappear leaving you with nearly the same end result anyway. I say "nearly the same"
because if you set a default torch on layered snow, the torch will replace the snow and be
lit on the ground. If you were able to set a default torch *on* layered snow, the snow would
melt and the torch would become a dropped item.

~ LazyJ

--]]


-- Some of the ideas I tried. ~ LazyJ
--[[
local can_place_torch_on_top = function(pos)
			if minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "default:snow"
			or minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "default:snow" then
				minetest.override_item("default:snow", {buildable_to = false,})
			end
		end
--]]


--[[
minetest.override_item("default:torch", {
	--on_construct = function(pos)
	on_place = function(itemstack, placer, pointed_thing)
		--if minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "default:snow"
			-- Even though layered snow doesn't look like it's in the next position above (y+1)
			-- it registers in that position. Check the terminal's output to see the coord change.
		--or minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "default:snow"
		if pointed_thing.name == "default:snow"
		then minetest.set_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="default:torch"})
		end
	end
})
--]]
