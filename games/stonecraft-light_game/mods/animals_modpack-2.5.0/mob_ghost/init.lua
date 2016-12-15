-------------------------------------------------------------------------------
-- Mob Ghost (based uppon idea of Blockmen)
--
--! @file init.lua
--! @brief mob_ghost implementation
--! @copyright Sapier
--! @author Sapier
--! @date 2013-09-09
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
core.log("action","MOD: mob_ghost loading ...")

local version = "0.0.1"

local ghost_groups = {
						not_in_creative_inventory=1
					}

local selectionbox_ghost = {-0.3, -0.5, -0.3, 0.3, 0.75, 0.3}

local ghost_movement_pattern = {
	name                       = "flight_pattern_ghost",
	jump_up                    = 0,   -- chance to jump up on collision
	random_jump_chance         = 0.4, -- chance to fly up or down
	random_jump_delay          = 10,  -- minimum time between switching levels
	random_acceleration_change = 0.1,
}

mobf_probab_movgen_register_pattern(ghost_movement_pattern)

local env_low_ground_flight = {
			media = {
						"air"
					},

			--ground is first node above/below not beeing of media type
			max_height_above_ground = 5,
			min_height_above_ground = 0
}

environment.register("flight_ghost", env_low_ground_flight)


local ghost_prototype = {
		name="ghost",
		modname="mob_ghost",

		factions = {
			member = {
				"monsters",
				"undead",
				"ghosts"
				}
			},

		generic = {
					description="Ghost (Animals)",
					base_health=12,
					armor_groups= {
						fleshy=130,
					},
					groups = ghost_groups,
					envid="flight_ghost",
					population_density=100,
				},
		movement =  {
					min_accel=0.5,
					max_accel=1,
					max_speed=3,
					pattern="flight_pattern_ghost",
					canfly=true,
					follow_speedup=4,
					},
		combat = {
					starts_attack = true,
					sun_sensitive = true,
					distance      = nil,
					self_destruct = nil,
					
					on_hit_overlay = {
						texture = "mob_ghost_ghost_hit.png",
						timer   = 0.4
					},
					
					melee = {
						maxdamage=1,
						range=2,
						speed=0.6,
						},
					},
		sound = {
				random = {
					interval = 20,
					max_interval_deviation = 15,
					list = {
						{
						name="mob_ghost_ghost",
						gain = 0.6,
						max_hear_distance = 10,
						},
					}
				},
				hit = {
					name="mob_ghost_ghost_hit",
					gain = 0.4,
					max_hear_distance = 5,
				},
				die = {
					name="mob_ghost_ghost_death",
					gain = 0.5,
					max_hear_distance = 5,
				}
		},
		animation = {
				stand = {
					start_frame = 0,
					end_frame   = 0,
					},
				walk = {
					start_frame = 168,
					end_frame   = 187,
					},
			},
		attention = {
				hear_distance = 5,
				hear_distance_value = 20,
				view_angle = nil,  -- doesn't work for models with broken orientation
				own_view_value = 0,
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
					movgen = "none",
					typical_state_time = 30,
					chance = 0,
					animation = "stand",
					graphics_3d = {
						visual = "mesh",
						mesh = "mob_ghost_ghost.x",
						textures = {"mob_ghost_ghost.png"},
						collisionbox = selectionbox_ghost,
						visual_size= {x=1,y=1,z=1},
						model_orientation_fix = -math.pi/2,
						},
				},
				{
					name = "walking",
					movgen = "probab_mov_gen",
					typical_state_time = 120,
					chance = 0.5,
					animation = "walk",
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

local ghost_name   = ghost_prototype.modname .. ":"  .. ghost_prototype.name
local ghost_env = mobf_environment_by_name(ghost_prototype.generic.envid)

mobf_spawner_register("ghost_spawner_1",ghost_name,
	{
	spawnee = ghost_name,
	spawn_interval = 300,
	spawn_inside = ghost_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=ghost_name,
				distance=ghost_prototype.generic.population_density,threshold=1 },
		},

	absolute_height =
	{
		min = 0,
	},
	
	light_around =
	{
		{ type="TIMED_MIN", distance = 0, threshold=LIGHT_MAX +1,time=0.5 },
		{ type="TIMED_MAX", distance = 0, threshold=6,time=0.0 },
		{ type="CURRENT_MAX", distance = 0, threshold=5 }
	},

	daytimes =
	{
		{ begin = 0.85, stop=0.99 },
		{ begin = 0.0,  stop=0.15 },
	},

	mapgen =
	{
		enabled = true,
		retries = 5,
		spawntotal = 1,
	},

	surfaces = {"default:dirt_with_grass","default:desert_sand"},
	collisionbox = selectionbox_ghost
	})

if factions~= nil and
	type(factions.set_base_reputation) == "function" then
	factions.set_base_reputation("ghosts","players",-25)
end

core.log("action","\tadding mob "..ghost_prototype.name)
mobf_add_mob(ghost_prototype)
core.log("action","MOD: mob_ghost mod            version " .. version .. " loaded")