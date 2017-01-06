-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief deer implementation
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

minetest.log("action","MOD: animal_deer mod loading ... ")

local version = "0.3.0"

local deer_groups = {
						not_in_creative_inventory=1
					}

local selectionbox_deer = {-0.7, -1.1, -0.7, 0.7, 0.8, 0.7}

function deer_m_drop()
	local result = {}
	if math.random() < 0.25 then
		table.insert(result,"animalmaterials:meat_venison 3")
	else
		table.insert(result,"animalmaterials:meat_venison 2")
	end

	if math.random() < 0.25 then
		table.insert(result,"animalmaterials:deer_horns 1")
	end

	if math.random() < 0.25 then
		table.insert(result,"animalmaterials:fur_deer 1")
	end

	if math.random() < 0.1 then
		table.insert(result,"animalmaterials:bone 1")
	end

	return result
end

function deer_f_drop()
	local result = {}
	if math.random() < 0.05 then
		table.insert(result,"animalmaterials:meat_venison 3")
	else
		table.insert(result,"animalmaterials:meat_venison 2")
	end

	if math.random() < 0.25 then
		table.insert(result,"animalmaterials:fur_deer 1")
	end

	if math.random() < 0.1 then
		table.insert(result,"animalmaterials:bone 1")
	end

	return result
end

function deer_watch_callback(entity,target)
	local flee_state = mob_state.get_state_by_name(entity,"flee")
	mob_state.change_state(entity,flee_state)
	entity.dynamic_data.current_movement_gen.set_target(entity,target)
end

local deer_m_prototype = {
	name="deer_m",
	modname = "animal_deer",

	factions = {
		member = {
			"animals",
			"forrest_animals"
			}
		},

	generic = {
				description= S("Deer (m)"),
				base_health=25,
				kill_result=deer_m_drop,
				armor_groups= {
					fleshy=75,
				},
				groups = deer_groups,
				envid="meadow",
				population_density=200,
			},
	movement =  {
				default_gen="probab_mov_gen",
				min_accel=0.2,
				max_accel=0.4,
				max_speed=2,
				min_speed=0.02,
				pattern="stop_and_go",
				canfly=false,
--				max_distance = 0.1
				},
	catching = {
				tool="animalmaterials:lasso",
				consumed=true,
				},
	random_drop    = nil,
	auto_transform = nil,
	attention = {
			hear_distance = 10,
			hear_distance_value = 20,
			view_angle = math.pi/2,
			own_view_value = 0.2,
			remote_view = false,
			remote_view_value = 0,
			attention_distance_value = 0.2,
			watch_threshold = 10,
			attention_distance = 15,
			attention_max = 25,
			watch_callback = deer_watch_callback
	},
	animation = {
			walk = {
				start_frame = 0,
				end_frame   = 60,
				basevelocity = 5.5,
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
	--animation testing only
--	patrol = {
--				state = "patrol",
--				cycle_path = true,
--			},
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
					visible_height = 2,
					visible_width = 1,
					},
				graphics_3d = {
					visual = "mesh",
					mesh = "animal_deer_m.b3d",
					textures = {"animal_deer_mesh_m.png"},
					collisionbox = selectionbox_deer,
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
				chance = 0.25,
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
			typical_state_time = 20,
			chance = 0,
			animation = "walk",
			},
--			{
--			name = "patrol",
--			movgen = "mgen_path",
--			typical_state_time = 9999,
--			chance = 0.0,
--			animation = "walk",
--			state_mode = "user_def",
--			},
		}
	}

local deer_f_prototype = {
	name="deer_f",
	modname = "animal_deer",

	factions = {
		member = {
			"animals",
			"forrest_animals"
			}
		},

	generic = {
				description= S("Deer (f)"),
				base_health=25,
				kill_result=deer_f_drop,
				armor_groups= {
					fleshy=75,
				},
				groups = deer_groups,
				envid="meadow",
				population_density=200,
			},
	movement =  {
				default_gen="probab_mov_gen",
				min_accel=0.2,
				max_accel=0.4,
				max_speed=2,
				min_speed=0.02,
				pattern="stop_and_go",
				canfly=false,
				},
	catching = {
				tool="animalmaterials:lasso",
				consumed=true,
				},
	random_drop    = nil,
	auto_transform = nil,
	attention = {
			hear_distance = 10,
			hear_distance_value = 20,
			view_angle = math.pi/2,
			own_view_value = 0.2,
			remote_view = false,
			remote_view_value = 0,
			attention_distance_value = 0.2,
			watch_threshold = 10,
			attention_distance = 15,
			attention_max = 25,
			watch_callback = deer_watch_callback
	},
	animation = {
			walk = {
				start_frame = 0,
				end_frame   = 60,
				basevelocity = 5.5,
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
					visible_height = 2,
					visible_width = 1,
					},
				graphics_3d = {
					visual = "mesh",
					mesh = "animal_deer_f.b3d",
					textures = {"animal_deer_mesh_m.png"},
					collisionbox = selectionbox_deer,
					visual_size= {x=0.9,y=0.9,z=0.9},
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
				chance = 0.25,
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
			typical_state_time = 20,
			chance = 0,
			animation = "walk",
			},
		}
	}

--compatibility code
minetest.register_entity(":animal_deer:deer__default",
	{
		on_activate = function(self,staticdata)
			minetest.add_entity(self.object:getpos(),"animal_deer:deer_m")
			self.object:remove()
		end
	})

local deer_m_name   = deer_m_prototype.modname .. ":"  .. deer_m_prototype.name
local deer_f_name   = deer_f_prototype.modname .. ":"  .. deer_f_prototype.name

local deer_env = mobf_environment_by_name(deer_m_prototype.generic.envid)

mobf_spawner_register("deer_m_spawner_1",deer_m_name,
	{
	spawnee = deer_m_name,
	spawn_interval = 120,
	spawn_inside = deer_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",distance=5,threshold=1 },
			{ type="MAX",entityname=deer_m_name,
				distance=deer_m_prototype.generic.population_density,threshold=2 },
			{ type="MAX",entityname=deer_f_name,
				distance=deer_m_prototype.generic.population_density,threshold=2 }
		},

	nodes_around =
		{
			{ type="MIN", name = { "default:leaves","default:tree"},distance=5,threshold=4}
		},

	absolute_height =
	{
		min = -10,
	},

	mapgen =
	{
		enabled = true,
		retries = 30,
		spawntotal = 1,
	},

	surfaces = deer_env.surfaces.good,
	collisionbox = selectionbox_deer
	})

mobf_spawner_register("deer_f_spawner_1",deer_f_name,
	{
	spawnee = deer_f_name,
	spawn_interval = 120,
	spawn_inside = deer_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",distance=5,threshold=1 },
			{ type="MAX",entityname=deer_f_name,
				distance=deer_f_prototype.generic.population_density,threshold=2 },
			{ type="MAX",entityname=deer_f_name,
				distance=deer_f_prototype.generic.population_density,threshold=2 }
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
		retries = 30,
		spawntotal = 1,
	},

	surfaces = deer_env.surfaces.good,
	collisionbox = selectionbox_deer
	})

--register with animals mod
minetest.log("action","\tadding mob "..deer_m_prototype.name)
mobf_add_mob(deer_m_prototype)
minetest.log("action","\tadding mob "..deer_f_prototype.name)
mobf_add_mob(deer_f_prototype)
minetest.log("action","MOD: animal_deer mod            version " .. version .. " loaded")
