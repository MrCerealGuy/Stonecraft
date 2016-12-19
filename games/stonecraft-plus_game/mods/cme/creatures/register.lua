--= Creatures MOB-Engine (cme) =--
-- Copyright (c) 2015-2016 BlockMen <blockmen2015@gmail.com>
--
-- register.lua
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


local allow_hostile = core.setting_getbool("only_peaceful_mobs") ~= true

local function translate_def(def)
  local new_def = {
  	physical = true,
  	visual = "mesh",
    stepheight = 0.6, -- ensure we get over slabs/stairs
    automatic_face_movement_dir = def.model.rotation or 0.0,

  	mesh = def.model.mesh,
  	textures = def.model.textures,
  	collisionbox = def.model.collisionbox or {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
  	visual_size = def.model.scale or {x = 1, y = 1},
    backface_culling = def.model.backface_culling or false,
    collide_with_objects = def.model.collide_with_objects or true,
    makes_footstep_sound = true,

    stats = def.stats,
    model = def.model,
    sounds = def.sounds,
    combat = def.combat,
    modes = {},
    drops = def.drops,
  }

  -- Tanslate modes to better accessable format
  for mn,def in pairs(def.modes) do
    local name = tostring(mn)
    if name ~= "update_time" then
      new_def.modes[name] = def
      --if name == "attack" then new_def.modes[name].chance = 0 end
    end
  end
  -- insert special mode "_run" which is used when in panic
  if def.stats.can_panic then
    if def.modes.walk then
      local new = table.copy(new_def.modes["walk"])
      new.chance = 0
      new.duration = 3
      new.moving_speed = new.moving_speed * 2
      if def.modes.panic and def.modes.panic.moving_speed then
        new.moving_speed = def.modes.panic.moving_speed
      end
      new.update_yaw = 0.7
      new_def.modes["_run"] = new
      local new_anim = def.model.animations.panic
      if not new_anim then
        new_anim = table.copy(def.model.animations.walk)
        new_anim.speed = new_anim.speed * 2
      end
      new_def.model.animations._run = new_anim
    end
  end

  if def.stats.can_jump and type(def.stats.can_jump) == "number" then
    if def.stats.can_jump > 0 then
      new_def.stepheight = def.stats.can_jump + 0.1
    end
  end

  if def.stats.sneaky or def.stats.can_fly then
    new_def.makes_footstep_sound = false
  end


  new_def.get_staticdata = function(self)
    local main_tab = creatures.get_staticdata(self)
    -- is own staticdata function defined? If so, merge results
    if def.get_staticdata then
      local data = def.get_staticdata(self)
      if data and type(data) == "table" then
        for s,w in pairs(data) do
          main_tab[s] = w
        end
      end
    end

    -- return data serialized
    return core.serialize(main_tab)
  end

  new_def.on_activate = function(self, staticdata)

    -- Add everything we need as basis for the engine
    self.mob_name = def.name
    self.hp = def.stats.hp
    self.hostile = def.stats.hostile
    self.mode = ""
    self.stunned = false -- if knocked back or hit do nothing else

    self.has_kockback = def.stats.has_kockback
    self.has_falldamage = def.stats.has_falldamage
    self.can_swim = def.stats.can_swim
    self.can_fly = def.stats.can_fly
    self.can_burn = def.stats.can_burn
    self.can_panic = def.stats.can_panic == true and def.modes.walk ~= nil
    --self.is_tamed = nil
    --self.target = nil
    self.dir = {x = 0, z = 0}

    --self.last_pos = nil (was nullVec)
    --self.last_node = nil
    --self.last_llvl = 0
    self.fall_dist = 0
    self.air_cnt = 0


    -- Timers
    self.lifetimer = 0
    self.modetimer = math.random()--0
    self.soundtimer = math.random()
    self.nodetimer = 2 -- ensure we get the first step
    self.yawtimer = math.random() * 2--0
    self.followtimer = 0
    if self.can_swim then
      self.swimtimer = 2 -- ensure we get the first step
      -- self.in_water = nil
    end
    if self.hostile then
      self.attacktimer = 0
    end
    if self.hostile or def.modes.follow then
      self.searchtimer = 0
    end
    if self.can_burn or not def.stats.can_swim or self.has_falldamage then
      self.env_damage = true
      self.envtimer = 0
    end

    -- Other things


    if staticdata then
      local tab = core.deserialize(staticdata)
      if tab and type(tab) == "table" then
        for s,w in pairs(tab) do
          self[tostring(s)] = w
        end
      end
    end

    -- check we got a valid mode
    if not new_def.modes[self.mode] or (new_def.modes[self.mode].chance or 0) <= 0 then
      self.mode = "idle"
    end

    if not self.can_fly then
      if not self.in_water then
        self.object:setacceleration({x = 0, y = -15, z = 0})
      end
    end

    -- check if falling and set velocity only 0 when not falling
    if self.fall_dist == 0 then
      self.object:setvelocity(nullVec)
    end

    self.object:set_hp(self.hp)

    if not core.setting_getbool("enable_damage") then
      self.hostile = false
    end

    -- immortal is needed to disable clientside smokepuff shit
    self.object:set_armor_groups({fleshy = 100, immortal = 1})

    -- call custom on_activate if defined
    if def.on_activate then
      def.on_activate(self, staticdata)
    end
  end

  new_def.on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
    if def.on_punch and def.on_punch(self, puncher, time_from_last_punch, tool_capabilities, dir) == true then
      return
    end

    creatures.on_punch(self, puncher, time_from_last_punch, tool_capabilities, dir)
  end

  new_def.on_rightclick = function(self, clicker)
    if def.on_rightclick and def.on_rightclick(self, clicker) == true then
      return
    end

    creatures.on_rightclick(self, clicker)
  end

  new_def.on_step = function(self, dtime)
    if def.on_step and def.on_step(self, dtime) == true then
      return
    end

    creatures.on_step(self, dtime)
  end

  return new_def
end

function creatures.register_mob(def) -- returns true if sucessfull
  if not def or not def.name then
    throw_error("Can't register mob. No name or Definition given.")
    return false
  end

  local mob_def = translate_def(def)

  core.register_entity(":" .. def.name, mob_def)

  -- register spawn
  if def.spawning and not (def.stats.hostile and not allow_hostile) then
    local spawn_def = def.spawning
    spawn_def.mob_name = def.name
    spawn_def.mob_size = def.model.collisionbox
    if creatures.register_spawn(spawn_def) ~= true then
      throw_error("Couldn't register spawning for '" .. def.name .. "'")
    end

    if spawn_def.spawn_egg then
      local egg_def = def.spawning.spawn_egg
      egg_def.mob_name = def.name
      egg_def.box = def.model.collisionbox
      creatures.register_egg(egg_def)
    end

    if spawn_def.spawner then
      local spawner_def = def.spawning.spawner
      spawner_def.mob_name = def.name
      spawner_def.range = spawner_def.range or 4
      spawner_def.number = spawner_def.number or 6
      spawner_def.model = def.model
      creatures.register_spawner(spawner_def)
    end
  end

  return true
end


local function inRange(min_max, value)
  if not value or not min_max or not min_max.min or not min_max.max then
    return false
  end
  if (value >= min_max.min and value <= min_max.max) then
    return true
  end
  return false
end

local function checkSpace(pos, height)
  for i = 0, height do
    local n = core.get_node_or_nil({x = pos.x, y = pos.y + i, z = pos.z})
    if not n or n.name ~= "air" then
      return false
    end
  end
  return true
end

local time_taker = 0
local function step(tick)
  core.after(tick, step, tick)
  time_taker = time_taker + tick
end
step(0.5)

local function stopABMFlood()
  if time_taker == 0 then
    return true
  end
  time_taker = 0
end

local function groupSpawn(pos, mob, group, nodes, range, max_loops)
  local cnt = 0
  local cnt2 = 0

  local nodes = core.find_nodes_in_area({x = pos.x - range, y = pos.y - range, z = pos.z - range},
    {x = pos.x + range, y = pos.y, z = pos.z + range}, nodes)
  local number = #nodes - 1
  if max_loops and type(max_loops) == "number" then
    number = max_loops
  end
  while cnt < group and cnt2 < number do
    cnt2 = cnt2 + 1
    local p = nodes[math.random(1, number)]
    p.y = p.y + 1
    if checkSpace(p, mob.size) == true then
      cnt = cnt + 1
      core.add_entity(p, mob.name)
    end
  end
  if cnt < group then
    return false
  end
end

function creatures.register_spawn(spawn_def)
  if not spawn_def or not spawn_def.abm_nodes then
    throw_error("No valid definition for given.")
    return false
  end

  if not spawn_def.abm_nodes.neighbors then
    spawn_def.abm_nodes.neighbors = {}
  end
  table.insert(spawn_def.abm_nodes.neighbors, "air")

  core.register_abm({
    nodenames = spawn_def.abm_nodes.spawn_on,
    neighbors = spawn_def.abm_nodes.neighbors,
    interval = spawn_def.abm_interval or 44,
    chance = spawn_def.abm_chance or 7000,
    catch_up = false,
    action = function(pos, node, active_object_count, active_object_count_wider)
      -- prevent abm-"feature"
      if stopABMFlood() == true then
        return
      end

      -- time check
      local tod = core.get_timeofday() * 24000
      if spawn_def.time_range then
        local wanted_res = false
        local range = table.copy(spawn_def.time_range)
        if range.min > range.max and range.min <= tod then
          wanted_res = true
        end
        if inRange(range, tod) == wanted_res then
          return
        end
      end

      -- position check
      if spawn_def.height_limit and not inRange(spawn_def.height_limit, pos.y) then
        return
      end

      -- light check
      pos.y = pos.y + 1
      local llvl = core.get_node_light(pos)
      if spawn_def.light and not inRange(spawn_def.light, llvl) then
        return
      end
      -- creature count check
      local max
      if active_object_count_wider > (spawn_def.max_number or 1) then
        local mates_num = #creatures.findTarget(nil, pos, 16, "mate", spawn_def.mob_name, true)
        if (mates_num or 0) >= spawn_def.max_number then
          return
        else
          max = spawn_def.max_number - mates_num
        end
      end

      -- ok everything seems fine, spawn creature
      local height_min = (spawn_def.mob_size[5] or 2) - (spawn_def.mob_size[2] or 0)
      height_min = math.ceil(height_min)

      local number = 0
      if type(spawn_def.number) == "table" then
        number = math.random(spawn_def.number.min, spawn_def.number.max)
      else
        number = spawn_def.number or 1
      end

      if max and number > max then
        number = max
      end

      if number > 1 then
        groupSpawn(pos, {name = spawn_def.mob_name, size = height_min}, number, spawn_def.abm_nodes.spawn_on, 5)
      else
      -- space check
        if not checkSpace(pos, height_min) then
          return
        end
        core.add_entity(pos, spawn_def.mob_name)
      end
    end,
  })

  return true
end

local function eggSpawn(itemstack, placer, pointed_thing, egg_def)
  if pointed_thing.type == "node" then
    local pos = pointed_thing.above
    pos.y = pos.y + 0.5
    local height = (egg_def.box[5] or 2) - (egg_def.box[2] or 0)
    if checkSpace(pos, height) == true then
      core.add_entity(pos, egg_def.mob_name)
      if core.setting_getbool("creative_mode") ~= true then
        itemstack:take_item()
      end
    end
    return itemstack
  end
end

function creatures.register_egg(egg_def)
  if not egg_def or not egg_def.mob_name or not egg_def.box then
    throw_error("Can't register Spawn-Egg. Not enough parameters given.")
    return false
  end

  core.register_craftitem(":" .. egg_def.mob_name .. "_spawn_egg", {
    description = egg_def.description or egg_def.mob_name .. " spawn egg",
    inventory_image = egg_def.texture or "creatures_spawn_egg.png",
    liquids_pointable = false,
    on_place = function(itemstack, placer, pointed_thing)
      return eggSpawn(itemstack, placer, pointed_thing, egg_def)
    end,
  })
  return true
end


local function makeSpawnerEntiy(mob_name, model)
  core.register_entity(":" .. mob_name .. "_spawner_dummy", {
    hp_max = 1,
    physical = false,
    collide_with_objects = false,
    collisionbox = nullVec,
    visual = "mesh",
    visual_size = {x = 0.42, y = 0.42},
    mesh = model.mesh,
    textures = model.textures,
    makes_footstep_sound = false,
    automatic_rotate = math.pi * -2.9,
    mob_name = "_" .. mob_name .. "_dummy",

    on_activate = function(self)
      self.timer = 0
		  self.object:setvelocity(nullVec)
		  self.object:setacceleration(nullVec)
		  self.object:set_armor_groups({immortal = 1})
      --self.object:set_bone_position("Root", nullVec, {x=45,y=0,z=0})
	   end,

     on_step = function(self, dtime)
       self.timer = self.timer + dtime
       if self.timer > 30 then
         self.timer = 0
         local n = core.get_node_or_nil(self.object:getpos())
         if n and n.name and n.name ~= mob_name .. "_spawner" then
           self.object:remove()
         end
       end
     end
    })
end

local function spawnerSpawn(pos, spawner_def)
  local mates = creatures.findTarget(nil, pos, spawner_def.range, "mate", spawner_def.mob_name, true) or {}
  if #mates >= spawner_def.number then
    return false
  end
  local number_max = spawner_def.number - #mates

  local rh = math.floor(spawner_def.range/2)
  local area = {
    min = {x = pos.x - rh, y=pos.y - rh, z = pos.z - rh},
    max = {x = pos.x + rh, y=pos.y + rh - spawner_def.height - 1, z = pos.z + rh}
  }

  local height = area.max.y - area.min.y
  local cnt = 0
  for i = 0, height do
    if cnt >= number_max then
      break
    end
    local p = {x = math.random(area.min.x, area.max.x), y = area.min.y + i, z = math.random(area.min.z, area.max.z)}
    local n = core.get_node_or_nil(p)
    if n and n.name then
      local walkable = core.registered_nodes[n.name].walkable or false
      p.y = p.y + 1
      if walkable and checkSpace(p, spawner_def.height) == true then
        local llvl = core.get_node_light(p)
        if not spawner_def.light or (spawner_def.light and inRange(spawner_def.light, llvl)) then
          cnt = cnt + 1
          core.add_entity(p, spawner_def.mob_name)
        end
      end
    end
  end
end


local spawner_timers = {}
function creatures.register_spawner(spawner_def)
  if not spawner_def or not spawner_def.mob_name or not spawner_def.model then
    throw_error("Can't register Spawn-Egg. Not enough parameters given.")
    return false
  end

  makeSpawnerEntiy(spawner_def.mob_name, spawner_def.model)

  core.register_node(":" .. spawner_def.mob_name .. "_spawner", {
    description = spawner_def.description or spawner_def.mob_name .. " spawner",
  	paramtype = "light",
  	tiles = {"creatures_spawner.png"},
  	is_ground_content = true,
  	drawtype = "glasslike",
  	groups = {cracky = 1, level = 1},
  	drop = "",
  	on_construct = function(pos)
  			pos.y = pos.y - 0.3
  			core.add_entity(pos, spawner_def.mob_name .. "_spawner_dummy")
  	end,
  	on_destruct = function(pos)
  		for _,obj in ipairs(core.get_objects_inside_radius(pos, 1)) do
        local entity = obj:get_luaentity()
  			if obj and entity and entity.mob_name == "_" .. spawner_def.mob_name .. "_dummy" then
  				obj:remove()
  			end
  		end
  	end
  })

  local box = spawner_def.model.collisionbox
  local height = (box[5] or 2) - (box[2] or 0)
  spawner_def.height = height

  if spawner_def.player_range and type(spawner_def.player_range) == "number" then
    core.register_abm({
      nodenames = {spawner_def.mob_name .. "_spawner"},
		  interval = 2,
		  chance = 1,
		  catch_up = false,
		  action = function(pos)
        local id = core.pos_to_string(pos)
        if not spawner_timers[id] then
          spawner_timers[id] = os.time()
        end
        local time_from_last_call = os.time() - spawner_timers[id]
        local mobs,player_near = creatures.findTarget(nil, pos, spawner_def.player_range, "player", nil, true, true)
        if player_near == true and time_from_last_call > 10 and (math.random(1, 5) == 1 or (time_from_last_call ) > 27) then
          spawner_timers[id] = os.time()

          spawnerSpawn(pos, spawner_def)
        end
      end
    })
  else
    core.register_abm({
      nodenames = {spawner_def.mob_name .. "_spawner"},
		  interval = 10,
		  chance = 3,
		  action = function(pos)

        spawnerSpawn(pos, spawner_def)
			end
    })
  end

  return true
end
