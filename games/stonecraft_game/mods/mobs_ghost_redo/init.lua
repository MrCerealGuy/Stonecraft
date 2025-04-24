--[[
	Mobs Ghost Redo - Adds ghosts.
	Copyright © 2018, 2019 Hamlet <hamlatmesehub@riseup.net> and contributors.

	Licensed under the EUPL, Version 1.2 or – as soon they will be
	approved by the European Commission – subsequent versions of the
	EUPL (the "Licence");
	You may not use this work except in compliance with the Licence.
	You may obtain a copy of the Licence at:

	https://joinup.ec.europa.eu/software/page/eupl
	https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32017D0863

	Unless required by applicable law or agreed to in writing,
	software distributed under the Licence is distributed on an
	"AS IS" basis,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
	implied.
	See the Licence for the specific language governing permissions
	and limitations under the Licence.

--]]

-- Translation and settings

local S = minetest.get_translator("mobs_ghost_redo")
local ghost_daytime_check = minetest.settings:get_bool("mobs_ghost_redo_daytime_check")
local ghost_bones_only = minetest.settings:get_bool("mobs_ghost_redo_bones_only")
local ghost_difficulty = minetest.settings:get_bool("mobs_ghost_redo_difficulty")

if ghost_daytime_check == nil then
	ghost_daytime_check = false
end

if ghost_bones_only == nil then
	ghost_bones_only = false
end

if ghost_difficulty == nil then
	ghost_difficulty = false
end

-- Mineclone check

local mod_mcl = minetest.get_modpath("mcl_core")

-- Spawn settings (default, bones only, mineclone)

local SPAWNING_CHANCE = 7500
local ACTIVE_OBJECTS = 2
local SPAWNING_NODES = {"group:cracky", "group:crumbly"}

if mod_mcl == true then
	SPAWNING_NODES = {"group:pickaxey", "group:shovely"}
end

if ghost_bones_only == true then
	SPAWNING_NODES = {"bones:bones", "mobs_humans:human_bones"}
	SPAWNING_CHANCE = 7
	ACTIVE_OBJECTS = 1
end

-- Functions

local function is_daytime()

	local time = minetest.get_timeofday() * 24000

	if time >= 4700 and time <= 19250 then return true end
end

local function random_mesh()

	if math.random(2) == 2 then
		return "mobs_ghost_redo_ghost_2.b3d"
	end

	return "mobs_ghost_redo_ghost_1.b3d"
end

-- Drops

local DROPS = {{name = (mod_mcl and "mcl_raw_ores:raw_gold" or "default:gold_lump"),
		chance = 100, min = 1, max = 5}}

-- Entity definition

mobs:register_mob("mobs_ghost_redo:ghost", {
	type = "monster",
	hp_min = 10,
	hp_max = 20,
	armor = 100,
	walk_velocity = 1,
	run_velocity = 4,
	walk_chance = 25,
	fly = true,
	view_range = 15,
	reach = 4,
	damage = 4,
	water_damage = 0,
	lava_damage = 0,
	light_damage = 2,
	suffocation = false,
	attack_animals = true,
	group_attack = true,
	attack_type = "dogfight",
	blood_amount = 0,
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_ghost_redo_ghost_1",
		war_cry = "mobs_ghost_redo_ghost_2",
		attack = "mobs_ghost_redo_ghost_2",
		damage = "mobs_ghost_redo_ghost_hit",
		death = "mobs_ghost_redo_ghost_death"
	},
	drops = DROPS,
	visual = "mesh",
	visual_size = {x = 1, y = 1},
	collisionbox = {-0.3, -0.5, -0.3, 0.3, 1.5, 0.3},
	textures = {"mobs_ghost_redo_ghost.png"},
	mesh = "mobs_ghost_redo_ghost_1.b3d",
	animation = {
		stand_start = 0, stand_end = 80, stand_speed = 15,
		walk_start = 102, walk_end = 122, walk_speed = 12,
		run_start = 102, run_end = 122, run_speed = 10,
		fly_start = 102, fly_end = 122, fly_speed = 12,
		punch_start = 102, punch_end = 122, punch_speed = 25,
		die_start = 81, die_end = 101, die_speed = 28, die_loop = false
	},

	on_spawn = function(self, pos)

		if ghost_difficulty == true then

			self.health = math.random(20, 30)

			self.immune_to = {
				{(mod_mcl and "mcl_tools:sword_iron" or "default:sword_steel"), 6},
				{"default:sword_bronze", 6},
				{(mod_mcl and "mcl_tools:sword_gold" or "default:sword_mese"), 7},
				{"mobs_others:sword_obsidian", 7},
				{(mod_mcl and "mcl_tools:sword_diamond" or "default:sword_diamond"), 8},
				{"moreores:sword_silver", 12},
				{"moreores:sword_mithril", 9},
				{"pigiron:sword_iron", 6},
				{"all"}
			}
		end

		self.spawned = true
		self.mesh = random_mesh()
		self.counter = 0
		self.object:set_properties({
			health = self.health,
			immune_to = self.immune_to,
			spawned = self.spawned,
			mesh = self.mesh,
			counter = self.counter,
			physical = false,
			collide_with_objects = false
		})

		return true
	end,

	do_custom = function(self, dtime)

		if ghost_daytime_check == true then

			if self.light_damage ~= 0 then

				self.light_damage = 0

				self.object:set_properties({
					light_damage = self.light_damage
				})
			end

			if self.spawned == true then

				if is_daytime() == true then
					self.object:remove()
				else
					self.spawned = false
					self.object:set_properties({
						spawned = self.spawned
					})
				end
			else
				if self.counter < 15.0 then

					self.counter = self.counter + dtime

					self.object:set_properties({
						counter = self.counter
					})
				else

					if is_daytime() == true then
						self.object:remove()
					else
						self.counter = 0

						self.object:set_properties({
							counter = self.counter
						})
					end
				end
			end
		else
			if self.light_damage ~= 2 then

				self.light_damage = 2

				self.object:set_properties({
					light_damage = self.light_damage
				})
			end
		end
	end
})

-- Ghost spawn - Check for custom spawn.lua

local MP = minetest.get_modpath(minetest.get_current_modname()) .. "/"
local input = io.open(MP .. "spawn.lua", "r")

if input then
	input:close() ; input = nil ; dofile(MP .. "spawn.lua")
else
	mobs:spawn({name = "mobs_ghost_redo:ghost",
		nodes = SPAWNING_NODES,
		neighbors = {"air"},
		max_light = 4,
		interval = 60,
		chance = SPAWNING_CHANCE,
		active_object_count = ACTIVE_OBJECTS,
		min_height = -30912,
		day_toggle = false
	})
end

-- Ghost's egg

mobs:register_egg("mobs_ghost_redo:ghost", S("Ghost Spawner"),
	"mobs_ghost_redo_egg_ghost.png", 0)

-- Alias

mobs:alias_mob("mobs:ghost", "mobs_ghost_redo:ghost")


print("[MOD] Mobs Ghost Redo loaded.")
