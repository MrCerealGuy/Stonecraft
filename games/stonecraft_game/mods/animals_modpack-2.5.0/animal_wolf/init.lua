-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allowed to pretend you have written it.
--
--! @file init.lua
--! @brief wolf implementation
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

minetest.log("action","MOD: mob_wolf loading ...")

local version = "0.2.1"

local wolf_groups = {
						not_in_creative_inventory=1
					}

local selectionbox_wolf = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}

wolf_prototype = {
		name="wolf",
		modname="animal_wolf",

		factions = {
			member = {
				"animals",
				"forrest_animals",
				"wolfs"
				}
			},

		generic = {
					description= S("Wolf"),
					base_health=10,
					kill_result="animalmaterials:fur 1",
					armor_groups= {
						fleshy=90,
					},
					groups = wolf_groups,
					addoncatch = "animal_wolf:tamed_wolf",
					envid="on_ground_2",
					population_density=800,
				},
		movement =  {
					canfly=false,
					guardspawnpoint = true,
					teleportdelay = 60,
					min_accel=0.5,
					max_accel=0.9,
					max_speed=1.5,
					follow_speedup=10,
					},
		catching = {
					tool="animalmaterials:net",
					consumed=true,
					},
		combat = {
					starts_attack=true,
					sun_sensitive=false,
					melee = {
						maxdamage=5,
						range=2,
						speed=1,
						},
					distance 		= nil,
					self_destruct 	= nil,
					},
		sound = {
					random = nil,
					melee = {
						name="animal_wolf_melee",
						gain = 0.8,
						max_hear_distance = 10
					},
					hit = {
						name="animal_wolf_hit",
						gain = 0.8,
						max_hear_distance = 5
					},
					start_attack = {
						name="animal_wolf_attack",
						gain = 0.8,
						max_hear_distance = 20
					},
			},
		animation = {
				stand = {
					start_frame = 0,
					end_frame   = 60,
					},
				walk = {
					start_frame = 61,
					end_frame   = 120,
					},
				sleep = {
					start_frame = 121,
					end_frame   = 180,
					},
			},
		attention = {
				hear_distance = 5,
				hear_distance_value = 20,
				view_angle = math.pi/2,
				own_view_value = 0.2,
				remote_view = false,
				remote_view_value = 0,
				attention_distance_value = 0.2,
				watch_threshold = 10,
				attack_threshold = 20,
				attention_distance = 10,
				attention_max = 25,
		},
		states = {
				{
					name = "default",
					movgen = "follow_mov_gen",
					typical_state_time = 30,
					chance = 0,
					animation = "stand",
					graphics_3d = {
						visual = "mesh",
						mesh = "animal_wolf.b3d",
						textures = {"animal_wolf_mesh.png"},
						collisionbox = selectionbox_wolf,
						visual_size= {x=1,y=1,z=1},
						},
				},
				{
					name = "sleeping",
					--TODO replace by check for night
					custom_preconhandler = nil,
					movgen = "none",
					typical_state_time = 300,
					chance = 0.10,
					animation = "sleep",
				},
				{
					name = "combat",
					typical_state_time = 9999,
					chance = 0.0,
					animation = "walk",
					movgen = "follow_mov_gen"
				},
			}
		}

tamed_wolf_prototype = {
		name="tamed_wolf",
		modname="animal_wolf",

		generic = {
					description= S("Tamed Wolf"),
					base_health=10,
					kill_result="animalmaterials:fur 1",
					armor_groups= {
						fleshy=90,
					},
					groups = wolf_groups,
					envid="on_ground_2",
					--this needs to be done by animal as first on_activate handler is called
					--before placer is known to entity
					custom_on_place_handler = function(entity, placer, pointed_thing)
						if placer:is_player(placer) then
							if entity.dynamic_data ~= nil and
								entity.dynamic_data.movement ~= nil  then
								entity.dynamic_data.movement.target = placer
							else
								print("ANIMAL tamed wolf: unable to set owner maybe wolf has been already deleted")
							end
						end
					end,
					custom_on_activate_handler = function(entity)
						print("ANIMAL tamed wolf: custom on activate handler called")
						if (entity.dynamic_data.spawning.spawner ~= nil) then
							print("ANIMAL tamed wolf: setting target to: " .. entity.dynamic_data.spawning.spawner )
							entity.dynamic_data.movement.target = minetest.get_player_by_name(entity.dynamic_data.spawning.spawner)
						end
					end,
					custom_on_step_handler = function(entity,now,dstep)
						if entity.dynamic_data.spawning.spawner == nil and
							now - entity.dynamic_data.spawning.original_spawntime > 30 then
								print("ANIMAL tamed wolf: tamed wolf without owner removing")
								spawning.remove(entity)
						end
					end
				},
		movement =  {
					canfly=false,
					guardspawnpoint = false,
					teleportdelay = 20,
					min_accel=0.3,
					max_accel=0.9,
					max_speed=1.5,
					max_distance=2,
					follow_speedup=20,
					},
		catching = {
					tool="animalmaterials:net",
					consumed=true,
					},
		sound = {
					random = nil,
					},
				animation = {
				stand = {
					start_frame = 0,
					end_frame   = 60,
					},
				walk = {
					start_frame = 61,
					end_frame   = 120,
					},
			},
		states = {
				{
					name = "default",
					movgen = "follow_mov_gen",
					typical_state_time = 60,
					chance = 0,
					animation = "stand",
					graphics_3d = {
						visual = "mesh",
						mesh = "animal_wolf.b3d",
						textures = {"animal_wolf_tamed_mesh.png"},
						collisionbox = selectionbox_wolf,
						visual_size= {x=1,y=1,z=1},
						},
				},
			}
		}

local wolf_name   = wolf_prototype.modname .. ":"  .. wolf_prototype.name
local wolf_env = mobf_environment_by_name(wolf_prototype.generic.envid)

mobf_spawner_register("wolf_spawner_1",wolf_name,
	{
	spawnee = wolf_name,
	spawn_interval = 300,
	spawn_inside = wolf_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=wolf_name,
				distance=wolf_prototype.generic.population_density,threshold=1 },
		},

	nodes_around =
		{
			{ type="MIN", name = { "default:leaves","default:tree"},distance=3,threshold=4}
		},

	absolute_height =
	{
		min = -10,
	},

	mapgen =
	{
		enabled = true,
		retries = 5,
		spawntotal = 1,
	},

	surfaces = wolf_env.surfaces.good,
	collisionbox = selectionbox_wolf
	})

if factions~= nil and
	type(factions.set_base_reputation) == "function" then
	factions.set_base_reputation("wolfs","players",-25)
end

minetest.log("action","\tadding mob "..wolf_prototype.name)
mobf_add_mob(wolf_prototype)
minetest.log("action","\tadding mob "..tamed_wolf_prototype.name)
mobf_add_mob(tamed_wolf_prototype)
minetest.log("action","MOD: animal_wolf mod            version " .. version .. " loaded")
