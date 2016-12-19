-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief rat implementation
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

minetest.log("action","MOD: animal_rat loading ...")

local version = "0.2.1"

local selectionbox_rat = {-0.2, -0.0625, -0.2, 0.2, 0.125, 0.2}

local rat_groups = {
						not_in_creative_inventory=1
					}

local rat_prototype = {
		name="rat",
		modname="animal_rat",

		factions = {
			member = {
				"animals",
				}
			},

		generic = {
					description= S("Rat (Animals)"),
					base_health=2,
					kill_result="",
					armor_groups= {
						fleshy=90,
					},
					groups = rat_groups,
					envid="simple_air",
					population_density = 250,
				},
		movement =  {
					default_gen="probab_mov_gen",
					min_accel=0.4,
					max_accel=0.6,
					max_speed=1.0,
					pattern="run_and_jump_low",
					canfly=false,
					},
		catching = {
					tool="animalmaterials:net",
					consumed=true,
					},
		animation = {
				walk = {
					start_frame = 1,
					end_frame   = 40,
					basevelocity = 0.1,
					},
				stand = {
					start_frame = 41,
					end_frame   = 80,
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
					mesh = "animal_rat.b3d",
					textures = {"animal_rat_mesh.png"},
					collisionbox = selectionbox_rat,
					visual_size= {x=1,y=1,z=1},
					},
				graphics = {
					sprite_scale={x=1,y=1},
					sprite_div = {x=6,y=1},
					visible_height = 1,
					visible_width = 1,
					},
				typical_state_time = 10,
				},
				{
				name = "walking",
				movgen = "probab_mov_gen",
				chance = 0.75,
				animation = "walk",
				typical_state_time = 180,
				},
			},
			
		sound = {
			random = {
				interval = 90,
				max_interval_deviation = 20,
				list = {
					{
					name="animal_rat_random",
					gain = 1,
					max_hear_distance = 5,
					}
				}
			}
		}
	}

--compatibility code
minetest.register_entity("animal_rat:rat_spawner_shadows",
 {
	physical        = false,
	collisionbox    = { 0.0,0.0,0.0,0.0,0.0,0.0},
	visual          = "sprite",
	textures        = { "invisible.png^[makealpha:128,0,0^[makealpha:128,128,0" },
	on_activate = function(self,staticdata)

		local pos = self.object:getpos();
		minetest.add_entity(pos,"mobf:compat_spawner")
		self.object:remove()
	end,
})

--spawning code
local rat_name   = rat_prototype.modname .. ":"  .. rat_prototype.name
local rat_env = mobf_environment_by_name(rat_prototype.generic.envid)

mobf_spawner_register("rat_spawner_1",rat_name,
	{
	spawnee = rat_name,
	spawn_interval = 120,
	spawn_inside = rat_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=rat_name,
				distance=rat_prototype.generic.population_density,threshold=2 },
		},

	nodes_around =
		{
			{ type="MIN", name = { "default:leaves","default:tree"},distance=1,threshold=2}
		},

	absolute_height =
	{
		min = -10,
	},

	mapgen =
	{
		enabled = true,
		retries = 10,
		spawntotal = 2,
	},

	collisionbox = selectionbox_rat
	})

mobf_spawner_register("rat_spawner_2",rat_name,
	{
	spawnee = rat_name,
	spawn_interval = 120,
	spawn_inside = rat_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=rat_name,
				distance=rat_prototype.generic.population_density,threshold=2 },
		},

	light_around =
	{
		{ type="CURRENT_MAX", distance = 2, threshold=6 }
	},

	absolute_height = {
		max = 100,
	},

	mapgen =
	{
		enabled = true,
		retries = 10,
		spawntotal = 3,
	},

	collisionbox = selectionbox_rat
	})

--register mod
minetest.log("action","\tadding "..rat_prototype.name)
mobf_add_mob(rat_prototype)
minetest.log("action","MOD: animal_rat mod             version " .. version .. " loaded")
