-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief dungeonmaster implementation
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

minetest.log("action","MOD: animal_dm loading ...")
local version = "0.2.0"

local dm_groups = {
					not_in_creative_inventory=1
				}

local selectionbox_dm = {-0.75, -1, -0.75, 0.75, 1, 0.75}

local dm_prototype = {
		name="dm",
		modname="animal_dm",

		factions = {
			member = {
				"underground",
				"monsters"
				}
			},

		generic = {
					description= S("Dungeonmaster (MOBF)"),
					base_health=30,
					kill_result="",
					armor_groups= {
						fleshy=30,
						deamon=40,
					},
					groups = dm_groups,
					envid="simple_air",
					population_density=750,
				},
		movement =  {
					min_accel=0.2,
					max_accel=0.4,
					max_speed=0.25,
					pattern="stop_and_go",
					canfly=false,
					follow_speedup=5,
					},
		combat = {
					angryness=0.99,
					starts_attack=true,
					sun_sensitive=true,
					melee = {
						maxdamage=3,
						range=5,
						speed=1,
						},
					distance = {
						attack="animal_resources:fireball_entity",
						range =15,
						speed = 1,
						},
					self_destruct = nil,
					},
		sound = {
					random = {
								name="animal_dm_random_1",
								min_delta = 30,
								chance = 0.5,
								gain = 0.5,
								max_hear_distance = 5,
								},
					distance = {
								name="animal_dm_fireball",
								gain = 0.5,
								max_hear_distance = 7,
								},
					die = {
								name="animal_dm_die",
								gain = 0.7,
								max_hear_distance = 7,
								},
					melee = {
								name="animal_dm_hit",
								gain = 0.7,
								max_hear_distance = 5,
								},
					},
		animation = {
				walk = {
					start_frame = 31,
					end_frame   = 60,
					},
				stand = {
					start_frame = 1,
					end_frame   = 30,
					},
				combat = {
					start_frame = 61,
					end_frame   = 90,
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
					mesh = "animal_dm.b3d",
					textures = {"animal_dm_mesh.png"},
					collisionbox = selectionbox_dm,
					visual_size= {x=1,y=1,z=1},
					},
				graphics = {
					sprite_scale={x=4,y=4},
					sprite_div = {x=6,y=1},
					visible_height = 2,
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
				movgen="follow_mov_gen",
				name = "combat",
				chance = 0,
				animation = "combat",
				typical_state_time = 0,
				},
			},
		}

--compatibility code
minetest.register_entity("animal_dm:dm_spawner_shadows",
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

dm_debug = function (msg)
    --minetest.log("action", "mobs: "..msg)
    --minetest.chat_send_all("mobs: "..msg)
end

local modpath = minetest.get_modpath("animal_dm")
dofile (modpath .. "/vault.lua")

local dm_name   = dm_prototype.modname .. ":"  .. dm_prototype.name
local dm_env = mobf_environment_by_name(dm_prototype.generic.envid)

mobf_spawner_register("dm_spawner_1",dm_name,
	{
	spawnee = dm_name,
	spawn_interval = 60,
	spawn_inside = dm_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=dm_name,
				distance=750,threshold=2 },
		},

	light_around =
	{
		{ type="CURRENT_MAX", distance = 2, threshold=6 }
	},

	absolute_height = {
		max = -50,
	},

	nodes_around =
	{
		{ type="MIN",name = {"default:lava_source"},distance=3,threshold=1}
	},

	mapgen =
	{
		enabled = true,
		retries = 10,
		spawntotal = 3,
	},

	surfaces = { "default:dirt",
					"default:cobble",
					"default:stone",
					"default:desert_stone",
					"default:gravel"},

	collisionbox = selectionbox_dm
	})


minetest.log("action", "\tadding mob "..dm_prototype.name)
if mobf_add_mob(dm_prototype) then
	dofile (modpath .. "/vault.lua")
end
minetest.log("action","MOD: animal_dm mod              version " .. version .. " loaded")
