--= Sheep for Creatures MOB-Engine (cme) =--
-- Copyright (c) 2015-2016 BlockMen <blockmen2015@gmail.com>
--
-- init.lua
--
-- This software is provided 'as-is', without any express or implied warranty. In no
-- event will the authors be held liable for any damages arising from the use of
-- this software.
--
-- Permission is granted to anyone to use this software for any purpose, including
-- commercial applications, and to alter it and redistribute it freely, subject to the
-- following restrictions:
--
-- 1. The origin of this software must not be misrepresented; you must not
-- claim that you wrote the original software. If you use this software in a
-- product, an acknowledgment in the product documentation is required.
-- 2. Altered source versions must be plainly marked as such, and must not
-- be misrepresented as being the original software.
-- 3. This notice may not be removed or altered from any source distribution.
--


-- shears
core.register_tool(":creatures:shears", {
	description = "Shears",
	inventory_image = "creatures_shears.png",
})

core.register_craft({
	output = 'creatures:shears',
	recipe = {
		{'', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:stick'},
	}
})


local function setColor(self)
	if self and self.object then
		local ext = ".png"
		if self.has_wool ~= true then
			ext = ".png^(creatures_sheep_shaved.png^[colorize:" .. self.wool_color:gsub("grey", "gray") .. ":50)"
		end
		self.object:set_properties({textures = {"creatures_sheep.png^creatures_sheep_" .. self.wool_color .. ext}})
	end
end

local function shear(self, drop_count, sound)
	if self.has_wool == true then
		self.has_wool = false
		local pos = self.object:getpos()
		if sound then
			core.sound_play("creatures_shears", {pos = pos, gain = 1, max_hear_distance = 10})
		end

		setColor(self)
		creatures.dropItems(pos, {{"wool:" .. self.wool_color, drop_count}})
	end
end


-- white, grey, brown, black (see wool colors as reference)
local colors = {
	white = {chance = 0.7},
	grey = {chance = 0.1},
	brown = {chance = 0.1},
	black = {chance = 0.1}
}

local def = {
	name = "creatures:sheep",
	stats = {
		hp = 8,
		lifetime = 450, -- 7,5 Minutes
		can_jump = 1,
		can_swim = true,
		can_burn = true,
		can_panic = true,
		has_falldamage = true,
		has_kockback = true,
	},

	model = {
		mesh = "creatures_sheep.b3d",
		textures = {"creatures_sheep.png^creatures_sheep_white.png"},
		collisionbox = {-0.45, -0.01, -0.45, 0.45, 1.06, 0.45},
		rotation = -90.0,
		animations = {
			idle = {start = 1, stop = 60, speed = 15},
			walk = {start = 81, stop = 101, speed = 18},
			walk_long = {start = 81, stop = 101, speed = 18},
			eat = {start = 107, stop = 170, speed = 12, loop = false},
			follow = {start = 81, stop = 101, speed = 15},
			death = {start = 171, stop = 191, speed = 32, loop = false, duration = 2.52},
		},
	},

	sounds = {
		on_damage = {name = "creatures_sheep", gain = 1.0, distance = 10},
		on_death = {name = "creatures_sheep", gain = 1.0, distance = 10},
		swim = {name = "creatures_splash", gain = 1.0, distance = 10,},
		random = {
			idle = {name = "creatures_sheep", gain = 0.6, distance = 10, time_min = 23},
		},
	},

	modes = {
		idle = {chance = 0.5, duration = 10, update_yaw = 8},
		walk = {chance = 0.14, duration = 4.5, moving_speed = 1.3},
		walk_long = {chance = 0.11, duration = 8, moving_speed = 1.3, update_yaw = 5},
		-- special modes
		follow = {chance = 0, duration = 20, radius = 4, timer = 5, moving_speed = 1, items = {"farming:wheat"}},
		eat = {	chance = 0.25,
			duration = 4,
			nodes = {
				"default:grass_1", "default:grass_2", "default:grass_3",
				"default:grass_4", "default:grass_5", "default:dirt_with_grass"
			}
		},
	},

	drops = function(self)
		local items = {{"creatures:flesh"}}
		if self.has_wool then
			table.insert(items, {"wool:" .. self.wool_color, {min = 1, max = 2}})
		end
		creatures.dropItems(self.object:getpos(), items)
	end,

	spawning = {
		abm_nodes = {
			spawn_on = {"default:dirt_with_grass"},
		},
		abm_interval = 55,
		abm_chance = 7800,
		max_number = 1,
		number = {min = 1, max = 3},
		time_range = {min = 5100, max = 18300},
		light = {min = 10, max = 15},
		height_limit = {min = 0, max = 25},

		spawn_egg = {
			description = "Sheep Spawn-Egg",
			texture = "creatures_egg_sheep.png",
		},

		spawner = {
			description = "Sheep Spawner",
			range = 8,
			player_range = 20,
			number = 6,
		}
	},

	on_punch = function(self, puncher)
		shear(self)
	end,

	get_staticdata = function(self)
		return {
			has_wool = self.has_wool,
			wool_color = self.wool_color,
		}
	end,

	on_activate = function(self, staticdata)
		if self.has_wool == nil then
			self.has_wool = true
		end

		if not self.wool_color then
			self.wool_color = creatures.rnd(colors) or "white"
		end
		-- update fur
		setColor(self)
	end,

	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
			if item then
				local name = item:get_name()
				if name == "farming:wheat" then
					self.target = clicker
					self.mode = "follow"
					self.modetimer = 0

					if not self.tamed then
						self.fed_cnt = (self.fed_cnt or 0) + 1
					end

					-- play eat sound?
					item:take_item()
				elseif name == "creatures:shears" and self.has_wool then
					shear(self, math.random(2, 3), true)
					item:add_wear(65535/100)
				end
				if not core.setting_getbool("creative_mode") then
					clicker:set_wielded_item(item)
				end
			end
		return true
	end,

	on_step = function(self, dtime)
		if self.mode == "eat" and self.eat_node then
			self.regrow_wool = true
		end
		if self.last_mode == "eat" and (self.modetimer and self.modetimer == 0) and self.regrow_wool then
			self.has_wool = true
			self.regrow_wool = nil
			setColor(self)
		end
		if self.fed_cnt and self.fed_cnt > 4 then
			self.tamed = true
			self.fed_cnt = nil
		end
	end
}

creatures.register_mob(def)
