--= Oerkki for Creatures MOB-Engine (cme) =--
-- Copyright (c) 2016 BlockMen <blockmen2015@gmail.com>
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


local def = {
  name = "creatures:oerkki",
  stats = {
    hp = 13,
    lifetime = 540, -- 9 Minutes
    can_jump = 1,
    can_swim = true,
    can_burn = true,
    can_panic = true,
    has_falldamage = true,
    has_kockback = true,
    sneaky = true,
    hostile = true,
  },

  model = {
    mesh = "creatures_oerkki.b3d",
    textures = {"creatures_oerkki.png"},
    collisionbox = {-0.22, -0.01, -0.22, 0.22, 1.65, 0.22},
    rotation = -90.0,
    animations = {
      idle = {start = 1, stop = 23, speed = 15},
      walk = {start = 24, stop = 31, speed = 8, loop = false},
      walk_long = {start = 24, stop = 31, speed = 8, loop = false},
      attack = {start = 37, stop = 49, speed = 18},
      death = {start = 50, stop = 76, speed = 32, loop = false, duration = 2.52},
    },
  },

  sounds = {
      on_damage = {name = "creatures_oerkki_hit", gain = 1.0, distance = 10},
      on_death = {name = "creatures_oerkki_hit", gain = 1.0, distance = 10},
      swim = {name = "creatures_splash", gain = 1.0, distance = 10},
      random = {
        idle = {name = "creatures_oerkki_idle", gain = 1.0, distance = 25},
        attack = {name = "creatures_oerkki_attack", gain = 1.0, distance = 20},
      },
  },

  modes = {
    idle = {chance = 0.59, duration = 3, update_yaw = 8},
    walk = {chance = 0.3, duration = 5.5, moving_speed = 1.5},
    walk_long = {chance = 0.11, duration = 8, moving_speed = 1.3, update_yaw = 5},

    -- special modes
    attack = {chance = 0, moving_speed = 2.9},
    panic = {duration = 4, moving_speed = 3.2},
  },

  combat = {
    attack_damage = 2,
    attack_speed = 0.6,
    attack_radius = 1.2,

    search_enemy = true,
    search_timer = 1.6,
    search_radius = 15,
    search_type = "player",
  },

  spawning = {
    abm_nodes = {
      spawn_on = {"default:dirt_with_grass", "default:dirt", "default:stone"},
    },
    abm_interval = 55,
    abm_chance = 7800,
    max_number = 1,
    number = {min = 1, max = 3},
    time_range = {min = 18500, max = 5100},
    light = {min = 0, max = 8},
    height_limit = {min = -200, max = 50},

    spawn_egg = {
      description = "Oerkki Spawn-Egg",
      texture = "creatures_egg_oerkki.png",
    },

    spawner = {
      description = "Oerkki Spawner",
      range = 8,
      player_range = 20,
      number = 6,
      light = {min = 0, max = 8},
    }
  },
}

creatures.register_mob(def)

-- Convert "Oerrki's" (caused by typo)
creatures.register_alias("creatures:oerrki", "creatures:oerkki")
