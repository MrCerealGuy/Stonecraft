-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief boombomb implementation
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

minetest.log("action","MOD: animal_creeper mod loading ...")

local version = "0.2.0"

local creeper_groups = {
						not_in_creative_inventory=1
						}

local selectionbox_creeper = {-1, -1, -1, 1, 1, 1}

local creeper_prototype = {
		name="creeper",
		modname="animal_creeper",

		factions = {
			member = {
				"monsters"
				}
			},

		generic = {
					description= S("BoomBomb"),
					base_health=3,
					kill_result="",
					armor_groups= {
						monster=90,
						fleshy=45
					},
					groups = creeper_groups,
					envid="on_ground_2",
					population_density=500,
				},
		movement =  {
					min_accel=0.4,
					max_accel=0.6,
					max_speed=2,
					pattern="stop_and_go",
					canfly=false,
					follow_speedup=5,
					},
		combat = {
					angryness=0.95,
					starts_attack=true,
					sun_sensitive=true,
					melee = {
						maxdamage=0,
						range=2,
						speed=1,
						},
					distance 		= nil,
					self_destruct = {
						damage=15,
						range=5,
						node_damage_range = 1.5,
						delay=5,
						},
					},
		sound = {
					random = {
								name="animal_creeper_random_1",
								min_delta = 10,
								chance = 0.5,
								gain = 1,
								max_hear_distance = 75,
								},
					self_destruct = {
								name="animal_creeper_bomb_explosion",
								gain = 2,
								max_hear_distance = 150,
								},
					},
		states = {
				{
					name = "default",
					movgen = "probab_mov_gen",
					typical_state_time = 30,
					chance = 0,
					graphics = {
						sprite_scale={x=4,y=4},
						sprite_div = {x=6,y=1},
						visible_height = 1.5,
						},
					graphics_3d = {
						visual = "mesh",
						mesh = "boombomb.b3d",
						textures = {"boombomb_mesh.png"},
						collisionbox = selectionbox_creeper,
						visual_size= {x=1,y=1,z=1},
					},
				},
			}
		}

--compatibility code
minetest.register_entity("animal_creeper:creeper_spawner",
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

minetest.register_entity("animal_creeper:creeper_spawner_at_night",
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

local creeper_name   = creeper_prototype.modname .. ":"  .. creeper_prototype.name

local creeper_env = mobf_environment_by_name(creeper_prototype.generic.envid)

mobf_spawner_register("boombomb_spawner_1",creeper_name,
	{
	spawnee = creeper_name,
	spawn_interval = 10,
	spawn_inside = creeper_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=creeper_name,
				distance=creeper_prototype.generic.population_density,threshold=1 },
		},

	absolute_height =
	{
		min = -10,
	},

	light_around =
	{
		{ type="TIMED_MIN", distance = 0, threshold=LIGHT_MAX +1,time=0.5 },
		{ type="TIMED_MAX", distance = 0, threshold=6,time=0.0 },
		{ type="CURRENT_MAX", distance = 0, threshold=5 }
	},

	daytimes =
	{
		{ begin = 0.75, stop=0.99 },
		{ begin = 0.0,  stop=0.25 },
	},

	surfaces = creeper_env.surfaces.good,
	collisionbox = selectionbox_creeper
	})

--register with animals mod
minetest.log("action","\tadding mob "..creeper_prototype.name)
mobf_add_mob(creeper_prototype)
minetest.log("action","MOD: animal_creeper mod         version " .. version .. " loaded")
