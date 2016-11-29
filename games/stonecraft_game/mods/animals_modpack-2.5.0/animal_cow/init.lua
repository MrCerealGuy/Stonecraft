-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief cow implementation
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

minetest.log("action","MOD: animal_cow mod loading ...")
local version = "0.3.1"

local cow_groups = {
						not_in_creative_inventory=1
					}

local selectionbox_cow = {-1.5, -1.54, -0.75, 0.8, 0.7, 0.75}
local selectionbox_steer = {-1.5*1.1, -1.54*1.1, -0.75*1.1, 0.8*1.1, 0.7*1.1, 0.75*1.1}
local selectionbox_baby_calf = {-0.8, -0.8, -0.5, 0.8, 0.8, 0.5}

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
    "flowers:dandelion_white",
    "flowers:rose"
}

local hunger_config =  {
      target_nodes = feeding_nodes,
      range = 15,
      chance = 0.3,
      typical_walk_time = 50,
      }

function cattle_drop()
	local result = {}
	if math.random() < 0.25 then
		table.insert(result,"animalmaterials:meat_beef 6")
	else
		table.insert(result,"animalmaterials:meat_beef 5")
	end

	if math.random() < 0.25 then
		table.insert(result,"animalmaterials:coat_cattle 1")
	end

	if math.random() < 0.1 then
		table.insert(result,"animalmaterials:bone 1")
	end

	return result
end

local cow_prototype = {
		name="cow",
		modname="animal_cow",

		factions = {
			member = {
				"animals",
				"grassland_animals"
				}
			},

		generic = {
					description= S("Cow"),
					base_health=40,
					kill_result=cattle_drop,
					armor_groups= {
						fleshy=60,
					},
					groups = cow_groups,
					envid = "meadow",
					population_density=200,
				},
		movement =  {
					default_gen="none",
					min_accel=0.05,
					max_accel=0.1,
					max_speed=0.3,
					min_speed=0.025,
					pattern="stop_and_go",
					canfly=false,
					max_distance=0.1,
					},
		harvest = {
					tool="vessels:drinking_glass",
					tool_consumed=true,
					result="animalmaterials:milk",
					transforms_to="",
					min_delay=60,
					},
		catching = {
					tool="animalmaterials:lasso",
					consumed=true,
					},
		--animation testing only
		--patrol = {
		--		state = "patrol",
		--		cycle_path = true,
		--	},
		sound = {
				random = {
					interval = 60,
					max_interval_deviation = 20,
					list = {
						{
						name="Mudchute_cow_1",
						gain = 1,
						max_hear_distance = 10,
						},
						{
						name="animal_cow_random_1",
						gain = 1,
						max_hear_distance = 10,
						},
						{
						name="animal_cow_random_2",
						gain = 1,
						max_hear_distance = 10,
						},
						{
						name="animal_cow_random_3",
						gain = 1,
						max_hear_distance = 10,
						},
						{
						name="animal_cow_random_4",
						gain = 1,
						max_hear_distance = 10,
						},
						{
						name="animal_cow_random_5",
						gain = 1,
						max_hear_distance = 10,
						},
					}
				},
				hit = {
							name="animal_cow_hit",
							gain = 1,
							max_hear_distance = 5,
				},
				harvest = {
							name="animal_cow_harvest",
							gain = 1,
							max_hear_distance = 5,
				},
			},
		states = {
				{
				name = "walking",
				movgen = "probab_mov_gen",
				typical_state_time = 180,
				chance = 0.40,
				animation = "walk",
				},
				{
				name = "flee",
				movgen = "flee_mov_gen",
				typical_state_time = 30,
				chance = 0,
				animation = "walk",
				},
				{
				name = "eating",
				movgen = "none",
				typical_state_time = 45,
				chance = 0.15,
				animation = "eat",
				},
				{
				name = "default",
				movgen = "none",
				typical_state_time = 45,
				chance = 0.15,
				animation = "stand",
				graphics = {
					sprite_scale={x=4,y=4},
					sprite_div = {x=6,y=1},
					visible_height = 2,
				},
				graphics_3d = {
					visual = "mesh",
					mesh = "animal_cow.b3d",
					textures = {"cow_mesh.png"},
					collisionbox = selectionbox_cow,
					visual_size= {x=1,y=1,z=1},
					},
				},
				-- animation testing
				--{
				--name = "patrol",
				--movgen = "mgen_path",
				--typical_state_time = 9999,
				--chance = 0.0,
				--animation = "walk",
				--state_mode = "user_def",
				--},
			},
		animation = {
				walk = {
					start_frame = 170,
					end_frame   = 250,
					basevelocity = 5,
					},
				stand = {
					start_frame = 0,
					end_frame   = 80,
					},
				eat = {
					start_frame = 81,
					end_frame   = 169,
					},
			},
		hunger = hunger_config
		}

local steer_prototype = {
		name="steer",
		modname="animal_cow",

		factions = {
			member = {
				"animals",
				"grassland_animals"
				}
			},

		generic = {
			description=S("Steer"),
			base_health=40,
			kill_result=cattle_drop,
			armor_groups= {
				fleshy=60,
			},
			groups = cow_groups,
			envid = "meadow",
			population_density=200,
		},
		movement =  {
			default_gen="probab_mov_gen",
			min_accel=0.05,
			max_accel=0.1,
			max_speed=0.3,
			min_speed=0.025,
			pattern="stop_and_go",
			canfly=false,
			},
		harvest = nil,
		catching = {
			tool="animalmaterials:lasso",
			consumed=true,
			},
		sound = {
			random = {
				interval = 60,
				max_interval_deviation = 20,
				list = {
					{
					name="Mudchute_cow_1",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_1",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_2",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_3",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_4",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_5",
					gain = 1,
					max_hear_distance = 10,
					},
				}
			},
			hit = {
				name="animal_cow_hit",
				gain = 1,
				max_hear_distance = 5,
				},
			},
		states = {
			{
				name = "walking",
				movgen = "probab_mov_gen",
				typical_state_time = 180,
				chance = 0.40,
				animation = "walk",
			},
			{
				name = "flee",
				movgen = "flee_mov_gen",
				typical_state_time = 30,
				chance = 0,
				animation = "walk",
			},
			{
				name = "eating",
				movgen = "none",
				typical_state_time = 45,
				chance = 0.15,
				animation = "eat",
			},
			{
				name = "default",
				movgen = "none",
				typical_state_time = 45,
				chance = 0.15,
				animation = "stand",
				graphics = {
					sprite_scale={x=4,y=4},
					sprite_div = {x=6,y=1},
					visible_height = 2,
					},
				graphics_3d = {
					visual = "mesh",
					mesh = "animal_steer.b3d",
					textures = {"steer_mesh.png"},
					collisionbox = selectionbox_cow,
					visual_size= {x=1,y=1,z=1},
					},
			},
		},
		animation = {
				walk = {
					start_frame = 170,
					end_frame   = 250,
					basevelocity = 3.5,
					},
				stand = {
					start_frame = 0,
					end_frame   = 80,
					},
				eat = {
					start_frame = 81,
					end_frame   = 169,
					},
			},
		hunger = hunger_config
		}

baby_calf_f_prototype = {
		name="baby_calf_f",
		modname="animal_cow",

		factions = {
			member = {
				"animals",
				"grassland_animals"
				}
			},

		generic = {
			description= S("Baby Calf female"),
			base_health=40,
			kill_result="animalmaterials:meat_beef 2",
			armor_groups= {
				fleshy=60,
			},
			groups = cow_groups,
			envid = "meadow"
			},
		movement =  {
			default_gen="probab_mov_gen",
			min_accel=0.025,
			max_accel=0.15,
			max_speed=0.2,
			min_speed=0.025,
			pattern="stop_and_go",
			canfly=false,
			},
		catching = {
			tool="animalmaterials:lasso",
			consumed=true,
			},
		auto_transform = {
			result="animal_cow:cow",
			delay=7200,
			},
		sound = {
			random = {
				interval = 60,
				max_interval_deviation = 20,
				list = {
					{
					name="Mudchute_cow_1",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_1",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_2",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_3",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_4",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_5",
					gain = 1,
					max_hear_distance = 10,
					},
				}
			},
			hit = {
				name="animal_cow_hit",
				gain = 1,
				max_hear_distance = 5,
				},
			},
		animation = {
				walk = {
					start_frame = 1,
					end_frame   = 40,
					basevelocity = 0.15,
					},
				stand = {
					start_frame = 41,
					end_frame   = 80,
					},
			},
		states = {
				{
				name = "walking",
				movgen = "probab_mov_gen",
				typical_state_time = 180,
				chance = 0.50,
				animation = "walk",
				},
				{
				name = "flee",
				movgen = "flee_mov_gen",
				typical_state_time = 30,
				chance = 0,
				animation = "walk",
				},
				{
				name = "default",
				movgen = "none",
				typical_state_time = 45,
				chance = 0.0,
				animation = "stand",
				graphics = {
					sprite_scale={x=2,y=2},
					sprite_div = {x=6,y=1},
					visible_height = 1,
					},
				graphics_3d = {
					visual = "mesh",
					mesh = "animal_calf.b3d",
					textures = {"animal_calf_mesh.png"},
					collisionbox = selectionbox_baby_calf,
					visual_size= {x=1,y=1,z=1},
					},
				},
			},
		hunger = hunger_config
		}

baby_calf_m_prototype = {
		name="baby_calf_m",
		modname="animal_cow",

		factions = {
			member = {
				"animals",
				"grassland_animals"
				}
			},

		generic = {
				description= S("Baby Calf male"),
				base_health=40,
				kill_result="animalmaterials:meat_beef 2",
				armor_groups= {
					fleshy=60,
				},
				groups = cow_groups,
				envid = "meadow"
				},
		movement =  {
				min_accel=0.025,
				max_accel=0.15,
				max_speed=0.2,
				min_speed=0.025,
				pattern="stop_and_go",
				canfly=false,
				},
		catching = {
				tool="animalmaterials:lasso",
				consumed=true,
				},
		auto_transform = {
				result="animal_cow:steer",
				delay=7200,
				},
		sound = {
			random = {
				interval = 60,
				max_interval_deviation = 20,
				list = {
					{
					name="Mudchute_cow_1",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_1",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_2",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_3",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_4",
					gain = 1,
					max_hear_distance = 10,
					},
					{
					name="animal_cow_random_5",
					gain = 1,
					max_hear_distance = 10,
					},
				}
			},
			hit = {
				name="animal_cow_hit",
				gain = 1,
				max_hear_distance = 5,
			},
		},
		animation = {
				walk = {
					start_frame = 1,
					end_frame   = 40,
					basevelocity = 0.15,
					},
				stand = {
					start_frame = 41,
					end_frame   = 80,
					},
			},
		states = {
				{
				name = "walking",
				movgen = "probab_mov_gen",
				typical_state_time = 180,
				chance = 0.50,
				animation = "walk",
				},
				{
				name = "flee",
				movgen = "flee_mov_gen",
				typical_state_time = 30,
				chance = 0,
				animation = "walk",
				},
				{
				name = "default",
				movgen = "none",
				typical_state_time = 45,
				chance = 0.0,
				animation = "stand",
				graphics = {
					sprite_scale={x=2,y=2},
					sprite_div = {x=6,y=1},
					visible_height = 1,
					},
				graphics_3d = {
					visual = "mesh",
					mesh = "animal_calf.b3d",
					textures = {"animal_calf_mesh.png"},
					collisionbox = selectionbox_baby_calf,
					visual_size= {x=1,y=1,z=1},
					},
				},
			},
		hunger = hunger_config
		}

local cowname   = cow_prototype.modname .. ":"  .. cow_prototype.name
local steername = steer_prototype.modname .. ":"  .. steer_prototype.name

local cow_env = mobf_environment_by_name(cow_prototype.generic.envid)
local steer_env = mobf_environment_by_name(steer_prototype.generic.envid)

mobf_spawner_register("cow_spawner_1",cowname,
	{
	spawnee = cowname,
	spawn_interval = 20,
	spawn_inside = cow_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=cowname,
				distance=cow_prototype.generic.population_density,threshold=2 },
			{ type="MAX",entityname=steername,
				distance=cow_prototype.generic.population_density,threshold=2 },
			{ type="MAX",entityname=steername,distance=30,threshold=1 },
			{ type="MAX",entityname=cowname,distance=30,threshold=1 }
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
		retries = 30,
		spawntotal = 2,
	},

	flat_area =
	{
		range = 2,
		deviation = 1,
	},

	surfaces = cow_env.surfaces.good,
	collisionbox = selectionbox_cow
	})

mobf_spawner_register("steer_spawner_1",steername,
	{
	spawnee = steername,
	spawn_interval = 20,
	spawn_inside = steer_env.media,
	entities_around =
		{
			{ type="MAX",distance=2,threshold=0 },
			{ type="MAX",entityname=steername,
				distance=steer_prototype.generic.population_density,threshold=2 },
			{ type="MAX",entityname=cowname,
				distance=steer_prototype.generic.population_density,threshold=2 },
			{ type="MAX",entityname=steername,distance=30,threshold=1 },
			{ type="MAX",entityname=cowname,distance=30,threshold=1 }
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
		retries = 30,
		spawntotal = 2,
	},

	surfaces = steer_env.surfaces.good,
	flat_area =
	{
		range = 2,
		deviation = 1,
	},
	collisionbox = selectionbox_steer
	})

--register with animals mod
minetest.log("action","\tadding "..baby_calf_f_prototype.name)
mobf_add_mob(baby_calf_f_prototype)
minetest.log("action","\tadding "..baby_calf_m_prototype.name)
mobf_add_mob(baby_calf_m_prototype)
minetest.log("action","\tadding "..cow_prototype.name)
mobf_add_mob(cow_prototype)
minetest.log("action","\tadding "..steer_prototype.name)
mobf_add_mob(steer_prototype)
minetest.log("action","MOD: animal_cow mod             version " .. version .. " loaded")
