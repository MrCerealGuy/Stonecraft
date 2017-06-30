--= Chicken for Creatures MOB-Engine (cme) =--
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

--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-05-10 added intllib support

--]]

if core.skip_mod("creatures") then return end

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- Egg
dofile(core.get_modpath("chicken") .. "/egg.lua")
local function dropEgg(obj)
  local pos = obj:getpos()
  if pos then
    creatures.dropItems(pos, {{"creatures:egg"}})
  end
end

-- Flesh
core.register_craftitem(":creatures:chicken_flesh", {
	description = S("Raw Chicken Flesh"),
	inventory_image = "creatures_chicken_flesh.png",
	on_use = core.item_eat(1)
})

core.register_craftitem(":creatures:chicken_meat", {
	description = S("Chicken Meat"),
	inventory_image = "creatures_chicken_meat.png",
	on_use = core.item_eat(3)
})

core.register_craft({
	type = "cooking",
	output = "creatures:chicken_meat",
	recipe = "creatures:chicken_flesh",
})

-- Feather
core.register_craftitem(":creatures:feather", {
	description = S("Feather"),
	inventory_image = "creatures_feather.png",
})

local def = {
  -- general
  name = "creatures:chicken",
  stats = {
    hp = 5,
    lifetime = 300, -- 5 Minutes
    can_jump = 1,
    can_swim = true,
    can_burn = true,
    can_panic = true,
    has_kockback = true,
    sneaky = true,
  },

  modes = {
    idle = {chance = 0.25, duration = 5, update_yaw = 3},
    idle2 = {chance = 0.69, duration = 0.8},
    pick = {chance = 0.2, duration = 2},
    walk = {chance = 0.2, duration = 5.5, moving_speed = 0.7, update_yaw = 2},
    panic = {moving_speed = 2.1},
    lay_egg = {chance = 0.01, duration = 1},
  },

  model = {
    mesh = "creatures_chicken.b3d",
    textures = {"creatures_chicken.png"},
    collisionbox = {-0.25, -0.01, -0.3, 0.25, 0.45, 0.3},
    rotation = 90.0,
    collide_with_objects = false,
    animations = {
      idle = {start = 0, stop = 1, speed = 10},
      idle2 = {start = 40, stop = 50, speed = 50},
      pick = {start = 88, stop = 134, speed = 50},
      walk = {start = 4, stop = 36, speed = 50},
      -- special modes
      swim = {start = 51, stop = 87, speed = 40},
      panic = {start = 51, stop = 87, speed = 55},
      death = {start = 135, stop = 160, speed = 28, loop = false, duration = 2.12},
    },
  },

  sounds = {
      on_damage = {name = "creatures_chicken_hit", gain = 0.5, distance = 10},
      on_death = {name = "creatures_chicken_hit", gain = 0.5, distance = 10},
      swim = {name = "creatures_splash", gain = 1.0, distance = 10},
      random = {
        idle = {name = "creatures_chicken", gain = 0.9, distance = 12, time_min = 8, time_max = 50},
      },
  },

  spawning = {
    abm_nodes = {
      spawn_on = {"default:dirt_with_grass", "default:dirt"},
    },
    abm_interval = 55,
    abm_chance = 7800,
    max_number = 1,
    number = 1,
    light = {min = 8, max = 15},
    height_limit = {min = 0, max = 150},

    spawn_egg = {
      description = S("Chicken Spawn-Egg"),
    },
  },

  drops = {
    {"creatures:chicken_flesh"},
    {"creatures:feather", {min = 1, max = 2}, chance = 0.45},
  },

  on_step = function(self, dtime)
    if self.mode == "lay_egg" then
      dropEgg(self.object)
      self.modetimer = 2
    end
  end
}

creatures.register_mob(def)
