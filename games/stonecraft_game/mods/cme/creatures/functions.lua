--= Creatures MOB-Engine (cme) =--
-- Copyright (c) 2015-2016 BlockMen <blockmen2015@gmail.com>
--
-- functions.lua
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


-- Localizations
local rnd = math.random


local function knockback(selfOrObject, dir, old_dir, strengh)
  local object = selfOrObject
  if selfOrObject.mob_name then
    object = selfOrObject.object
  end
  local current_fmd = object:get_properties().automatic_face_movement_dir or 0
  object:set_properties({automatic_face_movement_dir = false})
  object:setvelocity(vector.add(old_dir, {x = dir.x * strengh, y = 3.5, z = dir.z * strengh}))
  old_dir.y = 0
  core.after(0.4, function()
    object:set_properties({automatic_face_movement_dir = current_fmd})
    object:setvelocity(old_dir)
    selfOrObject.falltimer = nil
    if selfOrObject.stunned == true then
      selfOrObject.stunned = false
      if selfOrObject.can_panic == true then
        selfOrObject.target = nil
        selfOrObject.mode = "_run"
        selfOrObject.modetimer = 0
      end
    end
  end)
end

local function on_hit(me)
  core.after(0.1, function()
    me:settexturemod("^[colorize:#c4000099")
  end)
  core.after(0.5, function()
		me:settexturemod("")
	end)
end

local hasMoved = creatures.compare_pos

local function getDir(pos1, pos2)
  local retval
  if pos1 and pos2 then
    retval = {x = pos2.x - pos1.x, y = pos2.y - pos1.y, z = pos2.z - pos1.z}
  end
  return retval
end

local function getDistance(vec, fly_offset)
  if not vec then
    return -1
  end
  if fly_offset then
    vec.y = vec.y + fly_offset
  end
	return math.sqrt((vec.x)^2 + (vec.y)^2 + (vec.z)^2)
end

local findTarget = creatures.findTarget

local function update_animation(obj_ref, mode, anim_def)
  if anim_def and obj_ref then
    obj_ref:set_animation({x = anim_def.start, y = anim_def.stop}, anim_def.speed, 0, anim_def.loop)
  end
end

local function update_velocity(obj_ref, dir, speed, add)
  local velo = obj_ref:getvelocity()
  if not dir.y then
    dir.y = velo.y/speed
  end
  local new_velo = {x = dir.x * speed, y = dir.y * speed or velo.y , z = dir.z * speed}
  if add then
    new_velo = vector.add(velo, new_velo)
  end
  obj_ref:setvelocity(new_velo)
end

local function getYaw(dirOrYaw)
  local yaw = 360 * rnd()
  if dirOrYaw and type(dirOrYaw) == "table" then
    yaw = math.atan(dirOrYaw.z / dirOrYaw.x) + math.pi^2 - 2
    if dirOrYaw.x > 0 then
      yaw = yaw + math.pi
    end
  elseif dirOrYaw and type(dirOrYaw) == "number" then
    -- here could be a value based on given yaw
  end

  return yaw
end

local dropItems = creatures.dropItems

local function killMob(me, def)
  if not def then
    if me then
      me:remove()
    end
  end
  local pos = me:getpos()
  me:setvelocity(nullVec)
  me:set_properties({collisionbox = nullVec})
  me:set_hp(0)

  if def.sounds and def.sounds.on_death then
    local death_snd = def.sounds.on_death
    core.sound_play(death_snd.name, {pos = pos, max_hear_distance = death_snd.distance or 5, gain = death_snd.gain or 1})
  end

  if def.model.animations.death then
    local dur = def.model.animations.death.duration or 0.5
    update_animation(me, "death", def.model.animations["death"])
    core.after(dur, function()
      me:remove()
    end)
  else
    me:remove()
  end
  if def.drops then
    if type(def.drops) == "function" then
      def.drops(me:get_luaentity())
    else
      dropItems(pos, def.drops)
    end
  end
end

local function limit(value, min, max)
  if value < min then
    return min
  end
  if value > max then
    return max
  end
  return value
end

local function calcPunchDamage(obj, actual_interval, tool_caps)
  local damage = 0
  if not tool_caps or not actual_interval then
    return 0
  end
  local my_armor = obj:get_armor_groups() or {}
  for group,_ in pairs(tool_caps.damage_groups) do
    damage = damage + (tool_caps.damage_groups[group] or 0) * limit(actual_interval / tool_caps.full_punch_interval, 0.0, 1.0) * ((my_armor[group] or 0) / 100.0)
  end
  return damage or 0
end

local function onDamage(self, hp)
  local me = self.object
  local def = core.registered_entities[self.mob_name]
  hp = hp or me:get_hp()

  if hp <= 0 then
    self.stunned = true
      killMob(me, def)
  else
    on_hit(me) -- red flashing
    if def.sounds and def.sounds.on_damage then
      local dmg_snd = def.sounds.on_damage
      core.sound_play(dmg_snd.name, {pos = me:getpos(), max_hear_distance = dmg_snd.distance or 5, gain = dmg_snd.gain or 1})
    end
  end
end

local function changeHP(self, value)
  local me = self.object
  local hp = me:get_hp()
  hp = hp + math.floor(value)
  me:set_hp(hp)
  if value < 0 then
    onDamage(self, hp)
  end
end

local function checkWielded(wielded, itemList)
  for s,w in pairs(itemList) do
    if w == wielded then
      return true
    end
  end
  return false
end

local tool_uses = {0, 30, 110, 150, 280, 300, 500, 1000}
local function addWearout(player, tool_def)
	if not core.setting_getbool("creative_mode") then
		local item = player:get_wielded_item()
		if tool_def and tool_def.damage_groups and tool_def.damage_groups.fleshy then
			local uses = tool_uses[tool_def.damage_groups.fleshy] or 0
			if uses > 0 then
				local wear = 65535/uses
				item:add_wear(wear)
				player:set_wielded_item(item)
			end
		end
	end
end

local function spawnParticles(...)
end
if core.setting_getbool("creatures_enable_particles") == true then
  spawnParticles = function(pos, velocity, texture_str)
    local vel = vector.multiply(velocity, 0.5)
    vel.y = 0
    core.add_particlespawner({
      amount = 8,
      time = 1,
      minpos = vector.add(pos, -0.7),
      maxpos = vector.add(pos, 0.7),
      minvel = vector.add(vel, {x = -0.1, y = -0.01, z = -0.1}),
      maxvel = vector.add(vel, {x = 0.1,  y = 0,  z = 0.1}),
      minacc = vector.new(),
      maxacc = vector.new(),
      minexptime = 0.8,
      maxexptime = 1,
      minsize = 1,
      maxsize = 2.5,
      texture = texture_str,
    })
  end
end



-- --
-- Default entity functions
-- --

creatures.on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
  if self.stunned == true then
    return
  end

  local me = self.object
  local mypos = me:getpos()

  changeHP(self, calcPunchDamage(me, time_from_last_punch, tool_capabilities) * -1)
  if puncher then
    if self.hostile then
      self.mode = "attack"
      self.target = puncher
    end
    if time_from_last_punch >= 0.45 and self.stunned == false then
      if self.has_kockback == true then
        local v = me:getvelocity()
        v.y = 0
        if not self.can_fly then
          me:setacceleration({x = 0, y = -15, z = 0})
        end
        knockback(self, dir, v, 5)
        self.stunned = true
      end

      -- add wearout to weapons/tools
      addWearout(puncher, tool_capabilities)
    end
  end
end

creatures.on_rightclick = function(self, clicker)
end

creatures.on_step = function(self, dtime)
  -- first get the relevant specs; exit if we don't know anything (1-3ms)
  local def = core.registered_entities[self.mob_name]
  if not def then
    throw_error("Can't load creature-definition")
    return
  end

  -- timer updates
  self.lifetimer = self.lifetimer + dtime
  self.modetimer = self.modetimer + dtime
  self.soundtimer = self.soundtimer + dtime
  self.yawtimer = self.yawtimer + dtime
  self.nodetimer = self.nodetimer + dtime
  self.followtimer = self.followtimer + dtime
  if self.envtimer then
    self.envtimer = self.envtimer + dtime
  end
  if self.falltimer then
    self.falltimer = self.falltimer + dtime
  end
  if self.searchtimer then
    self.searchtimer = self.searchtimer + dtime
  end
  if self.attacktimer then
    self.attacktimer = self.attacktimer + dtime
  end
  if self.swimtimer then
    self.swimtimer = self.swimtimer + dtime
  end

  -- main
  if self.stunned == true then
    return
  end

  if self.lifetimer > def.stats.lifetime and not (self.mode == "attack" and self.target) then
    self.lifetimer = 0
    if not self.tamed or (self.tamed and def.stats.dies_when_tamed) then
      killMob(self.object, def)
    end
  end


  -- localize some things
  local modes = def.modes
  local current_mode = self.mode
  local me = self.object
  local current_pos = me:getpos()
  current_pos.y = current_pos.y + 0.5
  local moved = hasMoved(current_pos, self.last_pos) or false
  local fallen = false

  -- Update pos and current node if necessary
  if moved == true or not self.last_pos then
    -- for falldamage
    if self.has_falldamage and self.last_pos and not self.in_water then
      local dist = math.abs(current_pos.y - self.last_pos.y)
      if dist > 0 then
        self.fall_dist = self.fall_dist - dist
        if not self.falltimer then
          self.falltimer = 0
        end
      end
    end

    self.last_pos = current_pos
    if self.nodetimer > 0.2 then
      self.nodetimer = 0
      local current_node = core.get_node_or_nil(current_pos)
      self.last_node = current_node
      if def.stats.light then
        local wtime = core.get_timeofday()
        local llvl = core.get_node_light({x = current_pos.x, y = current_pos.y + 0.5, z = current_pos.z}) or 0
        self.last_llvl = llvl
      end
    end
  else
    if (modes[current_mode].moving_speed or 0) > 0 then
      update_velocity(me, nullVec, 0)
      if modes["idle"] and not (current_mode == "attack" or current_mode == "follow") then
        current_mode = "idle"
        self.modetimer = 0
      end
    end
    if self.fall_dist < 0 then
      fallen = true
    end
  end

  if fallen then
    local falltime = tonumber(self.falltimer) or 0
    local dist = math.abs(self.fall_dist) or 0
    self.falltimer = 0
    self.fall_dist = 0
    fallen = false

    local damage = 0
    if dist > 3 and not self.in_water and falltime/dist < 0.2 then
      damage = dist - 3
    end

    -- damage by calced value
    if damage > 0 then
      changeHP(self, damage * -1)
    end
  end


  -- special mode handling
  -- check distance to target
  if self.target and self.followtimer > 0.6 then
    self.followtimer = 0
    local p2 = self.target:getpos()
    local dir = getDir(current_pos, p2)
    local offset
    if self.can_fly then
      offset = modes["fly"].target_offset
    end
    local dist = getDistance(dir, offset)
    local radius
    if self.hostile and def.combat then
      radius = def.combat.search_radius
    elseif modes["follow"] then
      radius = modes["follow"].radius
    end
    if dist == -1 or dist > (radius or 5) then
      self.target = nil
      current_mode = ""
    elseif dist > -1 and self.hostile and dist < def.combat.attack_radius then
      -- attack
      if self.attacktimer > def.combat.attack_speed then
        self.attacktimer = 0
        if core.line_of_sight(current_pos, p2) == true then
          self.target:punch(me, 1.0,  {
            full_punch_interval = def.combat.attack_speed,
            damage_groups = {fleshy = def.combat.attack_damage}
          })
	      end
        update_velocity(me, self.dir, 0)
      end
    else
      if current_mode == "attack" or current_mode == "follow" then
        self.dir = vector.normalize(dir)
        me:setyaw(getYaw(dir))
        if self.in_water then
          self.dir.y = me:getvelocity().y
        end
        update_velocity(me, self.dir, modes[current_mode].moving_speed or 0)
      end
    end
  end

  -- search a target (1-2ms)
  if not self.target and ((self.hostile and def.combat.search_enemy) or modes["follow"]) and current_mode ~= "_run" then
    local timer
    if self.hostile then
      timer = def.combat.search_timer or 2
    elseif modes["follow"] then
      timer = modes["follow"].timer
    end
    if self.searchtimer > (timer or 4) then
      self.searchtimer = 0
      local targets = {}
      if self.hostile then
        targets = findTarget(me, current_pos, def.combat.search_radius, def.combat.search_type, def.combat.search_xray)
      else
        targets = findTarget(me, current_pos, modes["follow"].radius or 5, "player")
      end
      if #targets > 1 then
        self.target = targets[rnd(1, #targets)]
      elseif #targets == 1 then
        self.target = targets[1]
      end
      if self.target then
        if self.hostile and modes["attack"] then
          current_mode = "attack"
        else
          local name = self.target:get_wielded_item():get_name()
          if name and checkWielded(name, modes["follow"].items) == true then
            current_mode = "follow"
            self.modetimer = 0
          else
            self.target = nil
          end
        end
      end
    end
  end

  if current_mode == "eat" and not self.eat_node then
    local nodes = modes[current_mode].nodes
    local p = {x = current_pos.x, y = current_pos.y - 1, z = current_pos.z}
    local sn = core.get_node_or_nil(p)
    local eat_node
    for _,name in pairs(nodes) do
      if name == self.last_node.name then
        eat_node = current_pos
        break
      elseif sn and sn.name == name then
        eat_node = p
        break
      end
    end

    if not eat_node then
      current_mode = "idle"
    else
      self.eat_node = eat_node
    end
  end


  -- further mode handling
  -- update mode
  if current_mode ~= "attack" and
      (current_mode == "" or self.modetimer > (modes[current_mode].duration or 4)) then
    self.modetimer = 0

    local new_mode = creatures.rnd(modes) or "idle"
    if new_mode == "eat" and self.in_water == true then
      new_mode = "idle"
    end
    if current_mode == "follow" and rnd(1, 10) < 3 then
      new_mode = current_mode
    elseif current_mode == "follow" then
      -- "lock" searching a little bit
      self.searchtimer = rnd(5, 8) * -1
      self.target = nil
    end
    current_mode = new_mode

    -- change eaten node when mode changes
    if self.eat_node then
      local n = core.get_node_or_nil(self.eat_node)
      local nnn = n.name
      local def = core.registered_nodes[n.name]
      local sounds
      if def then
         if def.drop and type(def.drop) == "string" then
           nnn = def.drop
         elseif not def.walkable then
           nnn = "air"
         end
      end
      if nnn and nnn ~= n.name and core.registered_nodes[nnn] then
        core.set_node(self.eat_node, {name = nnn})
        if not sounds then
          sounds = def.sounds
        end
        if sounds and sounds.dug then
          core.sound_play(sounds.dug, {pos = self.eat_node, max_hear_distance = 5, gain = 1})
        end
      end
      self.eat_node = nil
    end
  end

  -- mode has changes, do things
  if current_mode ~= self.last_mode then
    self.last_mode = current_mode

    local moving_speed = modes[current_mode].moving_speed or 0
    if moving_speed > 0 then
      local yaw = (getYaw(me:getyaw()) + 90.0) * DEGTORAD
      me:setyaw(yaw + 4.73)
      self.dir = {x = math.cos(yaw), y = 0, z = math.sin(yaw)}
      if self.can_fly then
        if current_pos.y >= (modes["fly"].max_height or 50) and not self.target then
          self.dir.y = -0.5
        else
          self.dir.y = (rnd() - 0.5)
        end
      end

      -- reduce speed in water
      if self.in_water == true then
        moving_speed = moving_speed * 0.7
      end
    else
        self.dir = nullVec
    end

    update_velocity(me, self.dir, moving_speed)
    local anim_def = def.model.animations[current_mode]
    if self.in_water and def.model.animations["swim"] then
      anim_def = def.model.animations["swim"]
    end
    update_animation(me, current_mode, anim_def)
  end

  -- update yaw
  if current_mode ~= "attack" and current_mode ~= "follow" and
      (modes[current_mode].update_yaw or 0) > 0 and
      self.yawtimer > (modes[current_mode].update_yaw or 4) then
    self.yawtimer = 0
    local mod = nil
    if current_mode == "_run" then
      mod = me:getyaw()
    end
    local yaw = (getYaw(mod) + 90.0) * DEGTORAD
    me:setyaw(yaw + 4.73)
    local moving_speed = modes[current_mode].moving_speed or 0
    if moving_speed > 0 then
      self.dir = {x = math.cos(yaw), y = nil, z = math.sin(yaw)}
      update_velocity(me, self.dir, moving_speed)
    end
  end

  --swim
  if self.can_swim and self.swimtimer > 0.8 and self.last_node then
    self.swimtimer = 0
    local name = self.last_node.name
    if name then
      if name == "default:water_source" then
        self.air_cnt = 0
        local vel = me:getvelocity()
        update_velocity(me, {x = vel.x, y = 0.9, z = vel.z}, 1)
        me:setacceleration({x = 0, y = -1.2, z = 0})
        self.in_water = true
        -- play swimming sounds
        if def.sounds and def.sounds.swim then
          local swim_snd = def.sounds.swim
          core.sound_play(swim_snd.name, {pos = current_pos, gain = swim_snd.gain or 1, max_hear_distance = swim_snd.distance or 10})
        end
        spawnParticles(current_pos, vel, "bubble.png")
      else
        self.air_cnt = self.air_cnt + 1
        if self.in_water == true and self.air_cnt > 5 then
          self.in_water = false
          if not self.can_fly then
            me:setacceleration({x = 0, y = -15, z = 0})
          end
        end
      end
    end
  end

  -- Add damage when drowning or in lava
  if self.env_damage and self.envtimer > 1 and self.last_node then
    self.envtimer = 0
    local name = self.last_node.name
    if not self.can_swim and name == "default:water_source" then
      changeHP(self, -1)
    elseif self.can_burn then
      if name == "fire:basic_flame" or name == "default:lava_source" then
        changeHP(self, -4)
      end
    end

    -- add damage when light is too bright or too dark
    local tod = core.get_timeofday() * 24000
    if self.last_llvl and self.can_burn and self.last_llvl > (def.stats.light.max or 15) and tod < 18000 then
      changeHP(self, -1)
    elseif self.last_llvl and self.last_llvl < (def.stats.light.min or 0) then
      changeHP(self, -2)
    end
  end

  -- Random sounds
  if def.sounds and def.sounds.random[current_mode] then
    local rnd_sound = def.sounds.random[current_mode]
    if not self.snd_rnd_time then
      self.snd_rnd_time = rnd((rnd_sound.time_min or 5), (rnd_sound.time_max or 35))
    end
    if rnd_sound and self.soundtimer > self.snd_rnd_time + rnd() then
      self.soundtimer = 0
      self.snd_rnd_time = nil
      core.sound_play(rnd_sound.name, {pos = current_pos, gain = rnd_sound.gain or 1, max_hear_distance = rnd_sound.distance or 30})
    end
  end

  self.mode = current_mode
end


creatures.get_staticdata = function(self)
  return {
    hp = self.object:get_hp(),
		mode = self.mode,
    tamed = self.tamed,
    modetimer = self.modetimer,
    lifetimer = self.lifetimer,
    soundtimer = self.soundtimer,
		fall_dist = self.fall_dist,
    in_water = self.in_water,
	}
end
