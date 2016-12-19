-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief chicken implementation
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

minetest.log("action","MOD: animal_chicken mod loading ...")
local version = "0.2.2"

local chicken_groups = {
						not_in_creative_inventory=1
					}

local selectionbox_chicken = {-0.25, -0.15, -0.25, 0.2, 0.25, 0.25}
local selectionbox_rooster = {-0.25, -0.20, -0.25, 0.2, 0.25, 0.25}
local selectionbox_chick = {-0.1, -0.125, -0.1, 0.1, 0.15, 0.1}

local modpath = minetest.get_modpath("animal_chicken")

local function chicken_drop()
	local result = {}
	if math.random() < 0.05 then
		table.insert(result,"animalmaterials:feather 2")
	else
		table.insert(result,"animalmaterials:feather 1")
	end

	table.insert(result,"animalmaterials:meat_chicken 1")

	return result
end

local function egg_timeout(entity)

	if math.random() < 0.05 then
		local tospawn = "animal_chicken:chick_f"
		if math.random() > 0.5 then
			tospawn = "animal_chicken:chick_m"
		end

		local eggpos = entity.object:getpos()

		if (mobf_mob_around(
						"animal_chicken:rooster",
						nil,
						eggpos,
						5,false)) then
			spawning.spawn_and_check(tospawn,eggpos,"spawn_from_chicken_egg")
		end
	end
end

local chicken_prototype = {
		name="chicken",
		modname="animal_chicken",

		factions = {
			member = {
				"animals",
				"grassland_animals"
				}
			},

		generic = {
					description= S("Chicken"),
					base_health=5,
					kill_result=chicken_drop,
					armor_groups= {
						fleshy=90,
					},
					groups = chicken_groups,
					envid = "meadow",
					population_density=75,
				},
		movement =  {
					min_accel=0.05,
					max_accel=0.1,
					max_speed=0.3,
					min_speed=0.1,
					pattern="stop_and_go",
					canfly = false,
					},
		catching = {
					tool="animalmaterials:lasso",
					consumed=true,
					},
		random_drop = {
					result="animalmaterials:egg",
					min_delay=60,
					chance=0.2,
					on_timeout_callback=egg_timeout
					},
		sound = {
					random_drop = {
						name="animal_chicken_eggdrop",
						gain = 0.05,
						max_hear_distance = 5,
						},
					random = {
						interval = 80,
						max_interval_deviation = 20,
						list = {
							{
								name = "animal_chicken_random_chicken_1",
								gain = 1,
								max_hear_distance = 5,
							},
							{
								name = "animal_chicken_random_chicken_2",
								gain = 1,
								max_hear_distance = 5,
							},
							{
								name = "animal_chicken_random_chicken_3",
								gain = 1,
								max_hear_distance = 5,
							},
							{
								name = "animal_chicken_random_chicken_4",
								gain = 1,
								max_hear_distance = 5,
							},
							{
								name = "animal_chicken_random_chicken_5",
								gain = 1,
								max_hear_distance = 5,
							},
						}
					},
			},
		animation = {
				walk = {
					start_frame = 41,
					end_frame   = 81,
					},
				stand = {
					start_frame = 1,
					end_frame   = 40,
					},
			},
		states = {
				{
				name = "default",
				movgen = "none",
				chance = 0,
				animation = "stand",
				graphics_3d = {
					visual = "mesh",
					mesh = "animal_chicken.b3d",
					textures = {"animal_chicken_chicken_mesh.png"},
					collisionbox = selectionbox_chicken,
					visual_size= {x=1,y=1,z=1},
					},
				graphics = {
					sprite_scale={x=1,y=1},
					sprite_div = {x=6,y=1},
					visible_height = 1,
					visible_width = 1,
					},
				typical_state_time = 30,
				},
				{
				name = "walking",
				movgen = "probab_mov_gen",
				chance = 0.50,
				animation = "walk",
				typical_state_time = 180,
				},
				{
				name = "flee",
				movgen = "flee_mov_gen",
				typical_state_time = 5,
				chance = 0,
				animation = "walk",
				},
			},
		}

local rooster_prototype = {
		name="rooster",
		modname="animal_chicken",

		factions = {
			member = {
				"animals",
				"grassland_animals"
				}
			},

		generic = {
					description= S("Rooster"),
					base_health=5,
					kill_result=chicken_drop,
					armor_groups= {
						fleshy=90,
					},
					groups = chicken_groups,
					envid = "meadow",
					population_density=75,
				},
		movement =  {
					min_accel=0.05,
					max_accel=0.1,
					max_speed=0.3,
					min_speed=0.1,
					pattern="stop_and_go",
					canfly = false,
					},
		catching = {
					tool="animalmaterials:lasso",
					consumed=true,
					},
		sound = {
					random = {
						interval = 80,
						max_interval_deviation = 20,
						list = {
							{
								name = "animal_chicken_random_chicken_1",
								gain = 1,
								max_hear_distance = 5,
							},
							{
								name = "animal_chicken_random_chicken_2",
								gain = 1,
								max_hear_distance = 5,
							},
							{
								name = "animal_chicken_random_chicken_3",
								gain = 1,
								max_hear_distance = 5,
							},
							{
								name = "animal_chicken_random_chicken_4",
								gain = 1,
								max_hear_distance = 5,
							},
							{
								name = "animal_chicken_random_chicken_5",
								gain = 1,
								max_hear_distance = 5,
							},
						}
					},
			},
		animation = {
				walk = {
					start_frame = 41,
					end_frame   = 81,
					},
				stand = {
					start_frame = 1,
					end_frame   = 40,
					},
			},
		states = {
				{
				name = "default",
				movgen = "none",
				chance = 0,
				animation = "stand",
				graphics_3d = {
					visual = "mesh",
					mesh = "animal_rooster.b3d",
					textures = {"animal_chicken_rooster_mesh.png"},
					collisionbox = selectionbox_rooster,
					visual_size= {x=1,y=1,z=1},
					},
				graphics = {
					sprite_scale={x=1,y=1},
					sprite_div = {x=6,y=1},
					visible_height = 1,
					visible_width = 1,
					},
				typical_state_time = 30,
				},
				{
				name = "walking",
				movgen = "probab_mov_gen",
				chance = 0.25,
				animation = "walk",
				typical_state_time = 180,
				},
				{
				name = "flee",
				movgen = "flee_mov_gen",
				typical_state_time = 5,
				chance = 0,
				animation = "walk",
				},
			},
		}

local chick_m_prototype = {
		name="chick_m",
		modname="animal_chicken",

		factions = {
			member = {
				"animals",
				"grassland_animals"
				}
			},

		generic = {
				description= S("Chick - male"),
				base_health=5,
				kill_result="animalmaterials:feather 1",
				armor_groups= {
					fleshy=90,
				},
				groups = chicken_groups,
				envid = "meadow"
				},
		movement =  {
				min_accel=0.02,
				max_accel=0.05,
				max_speed=0.2,
				min_speed=0.05,
				pattern="stop_and_go",
				canfly = false,
				},
		catching = {
				tool="animalmaterials:lasso",
				consumed=true,
				},
		auto_transform = {
				result="animal_chicken:rooster",
				delay=600,
				},
		animation = {
				walk = {
					start_frame = 1,
					end_frame   = 40,
					},
				stand = {
					start_frame = 41,
					end_frame   = 81,
					},
			},
		states = {
				{
				name = "default",
				movgen = "none",
				chance = 0,
				animation = "stand",
				graphics_3d = {
					visual = "mesh",
					mesh = "animal_chick.b3d",
					textures = {"animal_chicken_chick_mesh.png"},
					collisionbox = selectionbox_chick,
					visual_size= {x=1,y=1,z=1},
					},
				graphics = {
					sprite_scale={x=1,y=1},
					sprite_div = {x=6,y=1},
					visible_height = 1,
					visible_width = 1,
					},
				typical_state_time = 30,
				},
				{
				name = "walking",
				movgen = "probab_mov_gen",
				chance = 0.50,
				animation = "walk",
				typical_state_time = 180,
				},
				{
				name = "flee",
				movgen = "flee_mov_gen",
				typical_state_time = 5,
				chance = 0,
				animation = "walk",
				},
			},
		}

local chick_f_prototype = {
		name="chick_f",
		modname="animal_chicken",

		factions = {
			member = {
				"animals",
				"grassland_animals"
				}
			},

		generic = {
				description= S("Chick - female"),
				base_health=5,
				kill_result="animalmaterials:feather 1",
				armor_groups= {
					fleshy=90,
				},
				groups = chicken_groups,
				envid = "meadow"
				},
		movement =  {
				min_accel=0.02,
				max_accel=0.05,
				max_speed=0.2,
				min_speed=0.05,
				pattern="stop_and_go",
				canfly = false,
				},
		catching = {
				tool="animalmaterials:lasso",
				consumed=true,
				},
		auto_transform = {
				result="animal_chicken:chicken",
				delay=600,
				},
		animation = {
				walk = {
					start_frame = 1,
					end_frame   = 40,
					},
				stand = {
					start_frame = 41,
					end_frame   = 81,
					},
			},
		states = {
				{
				name = "default",
				movgen = "none",
				chance = 0,
				animation = "stand",
				graphics_3d = {
					visual = "mesh",
					mesh = "animal_chick.b3d",
					textures = {"animal_chicken_chick_mesh.png"},
					collisionbox = selectionbox_chick,
					visual_size= {x=1,y=1,z=1},
					},
				graphics = {
					sprite_scale={x=1,y=1},
					sprite_div = {x=6,y=1},
					visible_height = 1,
					visible_width = 1,
					},
				typical_state_time = 30,
				},
				{
				name = "walking",
				movgen = "probab_mov_gen",
				chance = 0.50,
				animation = "walk",
				typical_state_time = 180,
				},
				{
				name = "flee",
				movgen = "flee_mov_gen",
				typical_state_time = 5,
				chance = 0,
				animation = "walk",
				},
			},
		}

local chicken_name   = chicken_prototype.modname .. ":"  .. chicken_prototype.name
local rooster_name = rooster_prototype.modname .. ":"  .. rooster_prototype.name

local chicken_env = mobf_environment_by_name(chicken_prototype.generic.envid)

mobf_spawner_register("chicken_spawner_1",chicken_name,
	{
	spawnee = chicken_name,
	spawn_interval = 120,
	spawn_inside = chicken_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=chicken_name,
				distance=chicken_prototype.generic.population_density,threshold=2 },
			{ type="MAX",entityname=rooster_name,
				distance=chicken_prototype.generic.population_density,threshold=2 }
		},

	nodes_around =
		{
			{ type="MIN", name = { "default:grass_1",
									"default:grass_2",
									"default:grass_3",
									"default:grass_4",
									"default:grass_5", },distance=8,threshold=1}
		},

	absolute_height =
	{
		min = -10,
	},

	mapgen =
	{
		enabled = true,
		retries = 20,
		spawntotal = 3,
	},

	surfaces = chicken_env.surfaces.good,
	collisionbox = selectionbox_chicken
	})

mobf_spawner_register("rooster_spawner_1",rooster_name,
	{
	spawnee = rooster_name,
	spawn_interval = 120,
	spawn_inside = chicken_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=chicken_name,
				distance=chicken_prototype.generic.population_density,threshold=2 },
			{ type="MAX",entityname=rooster_name,
				distance=chicken_prototype.generic.population_density,threshold=2 }
		},

	nodes_around =
		{
			{ type="MIN", name = { "default:default:grass_1",
									"default:default:grass_2",
									"default:default:grass_3",
									"default:default:grass_4",
									"default:default:grass_5", },distance=8,threshold=1}
		},

	absolute_height =
	{
		min = -10,
	},

	mapgen =
	{
		enabled = true,
		retries = 20,
		spawntotal = 3,
	},

	surfaces = chicken_env.surfaces.good,
	collisionbox = selectionbox_rooster
	})

--register with animals mod
minetest.log("action","\tadding animal "..chicken_prototype.name)
mobf_add_mob(chicken_prototype)
minetest.log("action","\tadding animal "..chick_m_prototype.name)
mobf_add_mob(chick_m_prototype)
minetest.log("action","\tadding animal "..chick_f_prototype.name)
mobf_add_mob(chick_f_prototype)
minetest.log("action","\tadding animal "..rooster_prototype.name)
mobf_add_mob(rooster_prototype)
minetest.log("action","MOD: animal_chicken mod         version " .. version .. " loaded")
