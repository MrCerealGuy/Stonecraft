-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief sheep implementation
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

minetest.log("action","MOD: animal_sheep mod loading ...")

local version = "0.3.2"

local sheep_groups = {
						sheerable=1,
						wool=1,
						not_in_creative_inventory=1
					}

local selectionbox_sheep = {-0.65, -0.75, -0.65, 0.65, 0.45, 0.65}
local selectionbox_lamb = {-0.65*0.6, -0.8*0.6, -0.65*0.6,
                           0.65*0.6, 0.45*0.6, 0.65*0.65 }

local feeding_nodes = {
    "default:junglegrass",
    "default:sapling",
    "default:grass_1",
    "default:grass_2",
    "default:grass_3",
    "default:grass_4",
    "default:grass_5",
    "flowers:tulip",
    "flowers:dandelion_yellow",
    "flowers:geranium",
    "flowers:viola",
    "flowers:dandelion_white"
}

local hunger_config =  {
      target_nodes = feeding_nodes,
      range = 10,
      chance = 0.3,
      typical_walk_time = 30,
      }

local sheep_prototype = {
		name="sheep",
		modname="animal_sheep",

		factions = {
			member = {
				"animals",
				"grassland_animals"
				}
			},

		generic = {
					description= S("Sheep"),
					base_health=10,
					kill_result="animalmaterials:meat_lamb 2",
					armor_groups= {
						fleshy=85,
					},
					groups = sheep_groups,
					envid="meadow",
					population_density = 50
				},
		movement =  {
					min_accel=0.05,
					max_accel=0.1,
					max_speed=0.5,
					min_speed=0.1,
					pattern="stop_and_go",
					canfly=false,
--					max_distance = 0.1
					},
		harvest = {
					tool="animalmaterials:scissors",
					max_tool_usage=40,
					tool_consumed=false,
					result="wool:white 1",
					transforms_to="animal_sheep:sheep_naked",
					min_delay=-1,
					},
		catching = {
					tool="animalmaterials:lasso",
					consumed=true,
					},
		sound = {
					random = {
							interval = 20,
							max_interval_deviation = 5,
							list = {
								{
								name="Mudchute_sheep_1",
								gain = 0.4,
								max_hear_distance = 10,
								},
								{
								name="animal_sheep_random_2",
								gain = 0.4,
								max_hear_distance = 10,
								},
							}
					},
					harvest = {
								name="animal_sheep_harvest",
								gain = 0.8,
								max_hear_distance = 5
					},
					hit = {
								name="animal_sheep_hit_1",
								gain = 0.8,
								max_hear_distance = 5
					},
					catch = {
								name="animal_sheep_catch",
								gain = 0.8,
								max_heat_distance = 5
					},
		},
		--animation testing only
--		patrol = {
--					state = "patrol",
--					cycle_path = true,
--				},
		animation = {
				walk = {
					start_frame = 0,
					end_frame   = 60,
					basevelocity = 3,
					},
				stand = {
					start_frame = 61,
					end_frame   = 120,
					},
				eating = {
					start_frame = 121,
					end_frame   = 180,
					},
				sleep = {
					start_frame = 181,
					end_frame   = 240,
					},
			},
		states = {
				{
					name = "default",
					movgen = "none",
					typical_state_time = 30,
					chance = 0,
					animation = "stand",
					graphics = {
						sprite_scale={x=4,y=4},
						sprite_div = {x=6,y=1},
						visible_height = 1.5,
						},
					graphics_3d = {
						visual = "mesh",
						mesh = "animal_sheep_sheep.b3d",
						textures = {"animal_sheep_mesh.png"},
						collisionbox = selectionbox_sheep,
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
					name = "eating",
					custom_preconhandler = nil,
					movgen = "none",
					typical_state_time = 20,
					chance = 0.05,
					animation = "eating"
				},
				{
					name = "walking",
					custom_preconhandler = nil,
					movgen = "probab_mov_gen",
					typical_state_time = 180,
					chance = 0.50,
					animation = "walk"
				},
				{
				name = "flee",
				movgen = "flee_mov_gen",
				typical_state_time = 10,
				chance = 0,
				animation = "walk",
				},
--				{
--				name = "patrol",
--				movgen = "mgen_path",
--				typical_state_time = 9999,
--				chance = 0.0,
--				animation = "walk",
--				state_mode = "user_def",
--				},
			},
		hunger = hunger_config,
		}

local lamb_prototype = {
		name="lamb",
		modname="animal_sheep",

		factions = {
			member = {
				"animals",
				"grassland_animals"
				}
			},

		generic = {
					description= S("Lamb"),
					base_health=3,
					kill_result="animalmaterials:meat_lamb 1",
					armor_groups= {
						fleshy=85,
					},
					envid="meadow",
					population_density = 0
				},
		movement =  {
					canfly=false,
					min_accel=0.025,
					max_accel=0.05,
					max_speed=0.3,
					min_speed=0.05,
					pattern="stop_and_go"
					},
		harvest     = nil,
		catching = {
					tool="animalmaterials:lasso",
					consumed=true,
					},
		auto_transform = {
					result="animal_sheep:sheep",
					delay=1800
					},
		sound = {
					random = {
							interval = 60,
							max_interval_deviation = 20,
							list = {
								{
								name="animal_sheep_lamb_random_1",
								gain = 0.4,
								max_hear_distance = 10,
								},
							}
					},
					hit = {
								name="animal_sheep_hit_1",
								gain = 0.8,
								max_hear_distance = 3
								},
					catch = {
								name="animal_sheep_catch",
								gain = 0.8,
								max_heat_distance = 5
								},
					},
		animation = {
				walk = {
					start_frame = 0,
					end_frame   = 60,
					basevelocity = 3,
					},
				stand = {
					start_frame = 61,
					end_frame   = 120,
					},
				eating = {
					start_frame = 121,
					end_frame   = 180,
					},
				sleep = {
					start_frame = 181,
					end_frame   = 240,
					},
			},
		states = {
				{
					name = "default",
					movgen = "none",
					typical_state_time = 30,
					chance = 0,
					animation = "stand",
					graphics = {
						sprite_scale={x=4,y=4},
						sprite_div = {x=6,y=1},
						visible_height = 1.5,
						},
					graphics_3d = {
						visual = "mesh",
						mesh = "animal_sheep_sheep.b3d",
						textures = {"animal_sheep_mesh.png"},
						collisionbox = selectionbox_lamb,
						visual_size= {x=0.5,y=0.5,z=0.5},
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
					name = "eating",
					custom_preconhandler = nil,
					movgen = "none",
					typical_state_time = 20,
					chance = 0.05,
					animation = "eating"
				},
				{
					name = "walking",
					custom_preconhandler = nil,
					movgen = "probab_mov_gen",
					typical_state_time = 180,
					chance = 0.50,
					animation = "walk"
				},
				{
				name = "flee",
				movgen = "flee_mov_gen",
				typical_state_time = 15,
				chance = 0,
				animation = "walk",
				},
			},
		hunger = hunger_config,
		}

local sheep_naked_prototype = {
		name="sheep_naked",
		modname="animal_sheep",

		factions = {
			member = {
				"animals",
				"grassland_animals"
				}
			},

		generic = {
					description= S("Naked sheep"),
					base_health=10,
					kill_result="animalmaterials:meat_lamb 2",
					armor_groups= {
						fleshy=85,
					},
					envid="meadow",
					population_density = 0
				},
		movement =  {
					canfly=false,
					min_accel=0.05,
					max_accel=0.1,
					max_speed=0.5,
					min_speed=0.1,
					pattern="stop_and_go"
					},
		catching = {
					tool="animalmaterials:lasso",
					consumed=true,
					},
		auto_transform = {
					result="animal_sheep:sheep",
					delay=300
					},
		sound = {
					random = {
							interval = 20,
							max_interval_deviation = 5,
							list = {
								{
								name="Mudchute_sheep_1",
								gain = 0.4,
								max_hear_distance = 10,
								},
								{
								name="animal_sheep_random_2",
								gain = 0.4,
								max_hear_distance = 10,
								},
							}
					},
					hit = {
								name="animal_sheep_hit_1",
								gain = 0.8,
								max_hear_distance = 5
					},
					catch = {
								name="animal_sheep_catch",
								gain = 0.8,
								max_heat_distance = 5
					},
		},
		animation = {
				walk = {
					start_frame = 0,
					end_frame   = 60,
					basevelocity = 0.3,
					},
				stand = {
					start_frame = 61,
					end_frame   = 120,
					},
				eating = {
					start_frame = 121,
					end_frame   = 180,
					},
				sleep = {
					start_frame = 181,
					end_frame   = 240,
					},
			},
		states = {
				{
					name = "default",
					movgen = "none",
					typical_state_time = 30,
					chance = 0,
					animation = "stand",
					graphics = {
						sprite_scale={x=4,y=4},
						sprite_div = {x=6,y=1},
						visible_height = 1.5,
						},
					graphics_3d = {
						visual = "mesh",
						mesh = "animal_sheep_sheep.b3d",
						textures = {"animal_sheep_naked_mesh.png"},
						collisionbox = selectionbox_sheep,
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
					name = "eating",
					custom_preconhandler = nil,
					movgen = "none",
					typical_state_time = 20,
					chance = 0.05,
					animation = "eating"
				},
				{
					name = "walking",
					custom_preconhandler = nil,
					movgen = "probab_mov_gen",
					typical_state_time = 180,
					chance = 0.50,
					animation = "walk"
				},
				{
				name = "flee",
				movgen = "flee_mov_gen",
				typical_state_time = 10,
				chance = 0,
				animation = "walk",
				},
			},
		hunger = hunger_config
		}


minetest.register_craft({
	output = "animalmaterials:scissors 5",
	recipe = {
		{'', "default:steel_ingot",''},
		{'', "default:steel_ingot",''},
		{"default:stick",'',"default:stick"},
	}
})

local spawneename   = sheep_prototype.modname .. ":"  .. sheep_prototype.name
local secondaryname = sheep_naked_prototype.modname .. ":"  .. sheep_naked_prototype.name

local sheep_env = mobf_environment_by_name(sheep_prototype.generic.envid)

mobf_spawner_register("sheep_spawner_1",spawneename,
	{
	spawnee = spawneename,
	spawn_interval = 120,
	spawn_inside = sheep_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=spawneename,
				distance=sheep_prototype.generic.population_density,threshold=2 },
			{ type="MAX",entityname=secondaryname,
				distance=sheep_prototype.generic.population_density,threshold=2 }
		},

	nodes_around =
		{
			{ type="MAX", name = { "default:leaves","default:tree"},distance=5,threshold=0}
		},

	absolute_height =
	{
		min = -10,
	},

	mapgen =
	{
		enabled = true,
		retries = 10,
		spawntotal = 3,
	},

	flat_area =
	{
		range = 1,
	},

	surfaces = sheep_env.surfaces.good,
	collisionbox = selectionbox_sheep
	})

minetest.log("action","\tadding animal "..sheep_prototype.name)
mobf_add_mob(sheep_prototype)
minetest.log("action","\tadding animal "..sheep_naked_prototype.name)
mobf_add_mob(sheep_naked_prototype)
minetest.log("action","\tadding animal "..lamb_prototype.name)
mobf_add_mob(lamb_prototype)

minetest.log("action","MOD: animal_sheep mod           version " .. version .. " loaded")

