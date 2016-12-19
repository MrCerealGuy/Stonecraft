-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allowed to pretend you have written it.
--
--! @file init.lua
--! @brief bear implementation
--! @copyright Sapier
--! @author Sapier
--! @date 2013-09-09
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
minetest.log("action","MOD: mob_bear loading ...")

local version = "0.1.1"

local bear_groups = {
						not_in_creative_inventory=1
					}

local selectionbox_bear = {-0.7, -1, -0.7, 0.7, 0.7, 0.7}

bear_prototype = {
		name="bear",
		modname="mob_bear",

		factions = {
			member = {
				"animals",
				"forrest_animals",
				"bears"
				}
			},

		generic = {
					description="Bear",
					base_health=20,
					kill_result="animalmaterials:fur 2",
					armor_groups= {
						fleshy=90,
					},
					groups = bear_groups,
					addoncatch = "mob_bear:tamed_bear",
					envid="on_ground_2",
					population_density=1200,
				},
		movement =  {
					canfly=false,
					guardspawnpoint = true,
					teleportdelay = 60,
					min_accel=0.3,
					max_accel=0.6,
					max_speed=1.0,
					follow_speedup=8,
					},
		catching = {
					tool="animalmaterials:bone",
					consumed=true,
					},
		combat = {
					starts_attack=true,
					sun_sensitive=false,
					melee = {
						maxdamage=7,
						range=3,
						speed=1.5,
						},
					distance 		= nil,
					self_destruct 	= nil,
					},
		sound = {
				random = {
					interval = 90,
					max_interval_deviation = 20,
					list = {
						{
						name="mob_bear_random",
						gain = 1,
						max_hear_distance = 10,
						},
					}
				},
				hit = {
					name="mob_bear_hit",
					gain = 1,
					max_hear_distance = 5,
				},
				melee = {
					name="mob_bear_melee",
					gain = 1,
					max_hear_distance = 5,
				}
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
		ride = {
					walkspeed  = 4.8,
					sneakspeed = 0.8,
					jumpspeed  = 38,
					attacheoffset = { x=0,y=2,z=0},
					texturemod = "^mob_bear_bear_tamed_mesh.png",
					walk_anim = "walk",
					saddle = "animalmaterials:lasso"
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
						mesh = "mob_bear.b3d",
						textures = {"mob_bear_bear_mesh.png"},
						collisionbox = selectionbox_bear,
						visual_size= {x=3,y=3,z=3},
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

local bear_name   = bear_prototype.modname .. ":"  .. bear_prototype.name
local bear_env = mobf_environment_by_name(bear_prototype.generic.envid)

mobf_spawner_register("bear_spawner_1",bear_name,
	{
	spawnee = bear_name,
	spawn_interval = 300,
	spawn_inside = bear_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=bear_name,
				distance=bear_prototype.generic.population_density,threshold=1 },
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

	surfaces = bear_env.surfaces.good,
	collisionbox = selectionbox_bear
	})

if factions~= nil and
	type(factions.set_base_reputation) == "function" then
	factions.set_base_reputation("bears","players",-25)
end

minetest.log("action","\tadding mob "..bear_prototype.name)
mobf_add_mob(bear_prototype)
minetest.log("action","MOD: mob_bear mod            version " .. version .. " loaded")