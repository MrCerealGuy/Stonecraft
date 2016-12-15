-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief npc implementation
--! @copyright Sapier
--! @author Sapier
--! @date 2013-01-27
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
  dofile(minetest.get_modpath("intllib").."/intllib.lua")
  S = intllib.Getter(minetest.get_current_modname())
else
  S = function ( s ) return s end
end

minetest.log("action","MOD: mob_guard mod loading ...")

local version = "0.2.1"
local guard_groups = {
						not_in_creative_inventory=1
					}

guard_prototype = {
		name="guard",
		modname="mob_guard",

		factions = {
			member = {
				"npc",
				"hireling"
				}
			},

		generic = {
					description= S("Guard"),
					base_health=40,
					kill_result="",
					armor_groups= {
						fleshy=60,
					},
					groups = guard_groups,
					envid="simple_air",
					stepheight = 0.51,
				},
		movement =  {
					guardspawnpoint = true,
					teleportdelay = 60,
					min_accel=0.3,
					max_accel=0.7,
					max_speed=1.5,
					min_speed=0.01,
					pattern="stop_and_go",
					canfly=false,
					follow_speedup=10,
					max_distance=0.2,
					},
		catching = {
					tool="animalmaterials:contract",
					consumed=true,
					},
		combat = {
					angryness=0.99,
					starts_attack=true,
					sun_sensitive=false,
					attack_hostile_mobs = true,
					melee = {
						maxdamage=2,
						range=2,
						speed=1,
						},
					self_destruct = nil,
					},
		patrol = {
					state = "patrol",
					cycle_path = true,
				},
		states = {
				{
				name = "combat_melee",
				movgen = "none",
				typical_state_time = 9999,
				chance = 0.0,
				animation = "punch",
				state_mode = "combat",
				},
				{
				name = "combat",
				movgen = "follow_mov_gen",
				typical_state_time = 9999,
				chance = 0.0,
				animation = "walk",
				state_mode = "combat",
				},
				{
				name = "default",
				movgen = "follow_mov_gen",
				typical_state_time = 180,
				chance = 1.00,
				animation = "stand",
				state_mode = "auto",
				graphics_3d = {
					visual = "mesh",
					mesh = "mob_guard_guard.b3d",
					textures = {"mob_guard_guard_mesh.png"},
					collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
					visual_size= {x=1, y=1},
					},
				},
				{
				name = "patrol",
				movgen = "mgen_path",
				typical_state_time = 9999,
				chance = 0.0,
				animation = "walk",
				state_mode = "user_def",
				},
			},
		animation = {
				walk = {
					start_frame = 168,
					end_frame   = 188,
					basevelocity = 18,
					},
				stand = {
					start_frame = 0,
					end_frame   = 80,
					},
				punch = {
					start_frame = 189,
					end_frame = 199,
					},
			},
		sound = {
				hit = {
					name="animal_resources_mattgarkusha_human_male_grunt",
					gain = 0.5,
					max_hear_distance = 5,
				},
				melee = {
					name="mob_guard_melee",
					gain = 0.5,
					max_hear_distance = 5,
				}
			}
		}

minetest.log("action","\tadding mob "..guard_prototype.name)
mobf_add_mob(guard_prototype)
minetest.log("action","MOD: mob_guard mod                version " .. version .. " loaded")
