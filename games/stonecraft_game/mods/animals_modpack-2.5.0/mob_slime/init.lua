-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief main init of slime mob
--! @copyright Sapier
--! @author Sapier
--! @date 2012-09-08
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

minetest.log("action","MOD: mob_slime mod loading ...")
local version = "0.2.1"

local selectionbox_slime_L = {-0.5, -0.4, -0.5,  0.5,0.4,0.5}
local selectionbox_slime_M = {-0.3, -0.2, -0.3,  0.3,0.2,0.3}
local selectionbox_slime_S = {-0.15,-0.1,-0.15,  0.15,0.1,0.15}

local modpath = minetest.get_modpath("mob_slime")

local slime_groups = {
						not_in_creative_inventory=1
					}

function mob_slime_bounce(entity)
	local pos = entity.object:getpos()
	local current_velocity = entity.object:getvelocity()

	local node_below = minetest.get_node({x=pos.x,y=pos.y + entity.collisionbox[2] -0.01,z=pos.z})

	if not mobf_is_walkable(node_below) then
		entity.object:setvelocity( {x=current_velocity.x,y=entity.data.movement.bounce,z=current_velocity.z})
		sound.play(pos,{
			name="mob_slime_bounce",
			gain = 0.5,
			max_hear_distance = 15,
		})
	end
end

function mob_slime_kill(entity,player)

	local pos = entity.getbasepos(entity)

	local dirs = {
					{x1=1,  z1=0, x2=0, z2=1},
					{x1=1,  z1=0, x2=-1,z2=0},
					{x1=1,  z1=0, x2=0, z2=-1},

					{x1=-1, z1=0, x2=0, z2=1},
					{x1=-1, z1=0, x2=1, z2=0},
					{x1=-1, z1=0, x2=0, z2=-1},

					{x1=0, z1=1, x2=0,  z2=-1},
					{x1=0, z1=1, x2=1,  z2=0},
					{x1=0, z1=1, x2=-1, z2=0},

					{x1=0, z1=-1, x2=0, z2=1},
					{x1=0, z1=-1, x2=1, z2=0},
					{x1=0, z1=-1, x2=-1,z2=0},
				}

	local mob_name = nil

	local toadd = dirs[math.random(1,#dirs)]

	if entity.data.generic.size == 3 then
		mob_name = "mob_slime:slime_M"
	end

	if entity.data.generic.size == 2 then
		mob_name = "mob_slime:slime_S"
	end

	if mob_name ~= nil then
		spawning.spawn_and_check(mob_name,
							{x=pos.x+toadd.x1,y=pos.y,z=pos.z+toadd.z1},
							"slime_kill_spawn")
		spawning.spawn_and_check(mob_name,
							{x=pos.x+toadd.x2,y=pos.y,z=pos.z+toadd.z2},
							"slime_kill_spawn")
	end

end

local prototype_mob_slime_L = {

	factions = {
			member = {
				"underground",
				}
			},

	--! @brief [MANDATORY] name of mob @b (alphanumeric and "_" only!!)
	name = "slime_L",
	--! @brief [MANDATORY] name of mod defining the mob
	modname = "mob_slime",

	--! @brief [MANDATORY] generic parameters for mob
	generic = {
		--! @brief [MANDATORY] description to show on mouse over in inventory
		description= S("Slime"),

		--! @brief [MANDATORY] maximum health
		base_health=1,

		--! @brief [MANDATORY] environment of mob to be
		envid="simple_air",

		--! @brief [OPTIONAL] item description OR function all returning a item description of whats the result of a kill
		kill_result = nil,

		--! @brief [OPTIONAL] armor groups of mob
		armor_groups = {
						fleshy=40,
						deamon=30,
					},

		groups = slime_groups,

		--! @brief [OPTIONAL] custom on_kill(entity,player) callback return true to skip normal on kill handling
		on_kill_callback = mob_slime_kill,

		--! @brief [OPTIONAL] custom on_step(entity) callback called after normal on_step handling is done
		custom_on_step_handler = mob_slime_bounce,

		--custom parameter
		size = 3,

		--population density
		population_density = 300,
		},

	--! @brief [MANDATORY] configuration of movement generator
	movement =  {
		--! @brief [MANDATORY] is this a flying mob
		canfly=false,

		--! @brief [MANDATORY] minumum acceleration of mob
		min_accel=0.1,

		--! @brief [MANDATORY] maximum acceleration of mob
		max_accel=0.2,

		--! @brief [MANDATORY] maximum absolute speed of mob
		max_speed=0.5,

		--! @brief [MOV_GEN_DEPENDENT | MANDATORY] pattern based movement gen -> pattern to use for movement
		pattern="dont_move",

		--custom parameter for bouncing
		bounce = 5,
		},

	--! @brief [3D MANDATORY] 3d graphics configuration for mob
	graphics_3d = {

		--! @brief [MANDATORY] this is the drawtype to use
		visual = "wielditem",

		--! @brief [MANDATORY] the model of the mob
		textures = {"mob_slime:box_slime_L"},

		--! @brief [MANDATORY] collisionbox to use
		collisionbox = selectionbox_slime_L,

		--! @brief [MANDATORY] xyz scale factors for the model
		visual_size = {x=0.66,y=0.66,z=0.66},
		},

	--! @brief [OPTIONAL] combat settings for mob
	combat = {
		--! @brief [MANDATORY] does mob start an attack on its own?
		starts_attack=true,

		--! @brief [MANDATORY] chance mob will attack (if starting attack on its own or beeing attacked)
		angryness=0.95,


		--! @brief [OPTIONAL] switch to this movement gen while in combat
		mgen="follow_mov_gen",

		--! @brief [OPTIONAL] configuration of meele attack
		melee = {
			--! @brief [MANDATORY] maximum damage mob does per hit
			maxdamage=0.5,
			--! @brief [MANDATORY] range mob will hit
			range=2,
			--! @brief [MANDATORY] minimum time between two hits
			speed=5,
			},
		},
	die = {
			name="mob_slime_die",
			gain = 0.7,
			max_hear_distance = 4,
			},
	states = {
				{
				name = "default",
				movgen = "none",
				chance = 0,
				typical_state_time = 300,
				graphics_3d = {
					visual = "mesh",
					mesh = "mob_slime_slime.b3d",
					textures = {"mob_slime_slime_mesh.png"},
					collisionbox = selectionbox_slime_L,
					visual_size= {x=1,y=1,z=1},
					},
				},

			},
	}

local prototype_mob_slime_S = {

	factions = {
			member = {
				"underground",
				}
			},

	--! @brief [MANDATORY] name of mob @b (alphanumeric and "_" only!!)
	name = "slime_S",
	--! @brief [MANDATORY] name of mod defining the mob
	modname = "mob_slime",

	--! @brief [MANDATORY] generic parameters for mob
	generic = {
		--! @brief [MANDATORY] description to show on mouse over in inventory
		description= S("Slime"),

		--! @brief [MANDATORY] maximum health
		base_health=1,

		--! @brief [MANDATORY] environment of mob to be
		envid="simple_air",

		--! @brief [OPTIONAL] item description OR function all returning a item description of whats the result of a kill
		kill_result = nil,

		--! @brief [OPTIONAL] armor groups of mob
		armor_groups = {
						fleshy=40,
						deamon=30,
					},

		groups = slime_groups,

		--! @brief [OPTIONAL] custom on_kill(entity,player) callback return true to skip normal on kill handling
		on_kill_callback = mob_slime_kill,

		--! @brief [OPTIONAL] custom on_step(entity) callback called after normal on_step handling is done
		custom_on_step_handler = mob_slime_bounce,

		--custom parameter
		size = 1,

		--population density
		population_density = 300,
		},

	--! @brief [MANDATORY] configuration of movement generator
	movement =  {
		--! @brief [MANDATORY] is this a flying mob
		canfly=false,

		--! @brief [MANDATORY] minumum acceleration of mob
		min_accel=0.1,

		--! @brief [MANDATORY] maximum acceleration of mob
		max_accel=0.2,

		--! @brief [MANDATORY] maximum absolute speed of mob
		max_speed=0.5,

		--! @brief [MOV_GEN_DEPENDENT | MANDATORY] pattern based movement gen -> pattern to use for movement
		pattern="dont_move",

		--custom parameter for bouncing
		bounce = 3,
		},

	--! @brief [OPTIONAL] combat settings for mob
	combat = {
		--! @brief [MANDATORY] does mob start an attack on its own?
		starts_attack=true,

		--! @brief [MANDATORY] chance mob will attack (if starting attack on its own or beeing attacked)
		angryness=0.95,


		--! @brief [OPTIONAL] switch to this movement gen while in combat
		mgen="follow_mov_gen",

		--! @brief [OPTIONAL] configuration of meele attack
		melee = {
			--! @brief [MANDATORY] maximum damage mob does per hit
			maxdamage=0.5,
			--! @brief [MANDATORY] range mob will hit
			range=2,
			--! @brief [MANDATORY] minimum time between two hits
			speed=5,
			},
		},
	die = {
		name="mob_slime_die",
		gain = 0.3,
		max_hear_distance = 4,
		},
	states = {
				{
				name = "default",
				movgen = "none",
				chance = 0,
				typical_state_time = 300,
				graphics_3d = {
					visual = "mesh",
					mesh = "mob_slime_slime.b3d",
					textures = {"mob_slime_slime_mesh.png"},
					collisionbox = selectionbox_slime_L,
					visual_size= {x=0.5,y=0.5,z=0.5},
					},
				},
			},
	}

local prototype_mob_slime_M = {

	factions = {
			member = {
				"underground",
				}
			},

	--! @brief [MANDATORY] name of mob @b (alphanumeric and "_" only!!)
	name = "slime_M",
	--! @brief [MANDATORY] name of mod defining the mob
	modname = "mob_slime",

	--! @brief [MANDATORY] generic parameters for mob
	generic = {
		--! @brief [MANDATORY] description to show on mouse over in inventory
		description= S("Slime"),

		--! @brief [MANDATORY] maximum health
		base_health=1,

		--! @brief [MANDATORY] environment of mob to be
		envid="simple_air",

		--! @brief [OPTIONAL] item description OR function all returning a item description of whats the result of a kill
		kill_result = nil,

		--! @brief [OPTIONAL] armor groups of mob
		armor_groups = {
						fleshy=40,
						deamon=30,
					},

		groups = slime_groups,

		--! @brief [OPTIONAL] custom on_kill(entity,player) callback return true to skip normal on kill handling
		on_kill_callback = mob_slime_kill,

		--! @brief [OPTIONAL] custom on_step(entity) callback called after normal on_step handling is done
		custom_on_step_handler = mob_slime_bounce,


		--custom parameter
		size = 2,

		--population density
		population_density = 300,
		},

	--! @brief [MANDATORY] configuration of movement generator
	movement =  {
		--! @brief [MANDATORY] is this a flying mob
		canfly=false,

		--! @brief [MANDATORY] minumum acceleration of mob
		min_accel=0.1,

		--! @brief [MANDATORY] maximum acceleration of mob
		max_accel=0.2,

		--! @brief [MANDATORY] maximum absolute speed of mob
		max_speed=0.5,

		--! @brief [MOV_GEN_DEPENDENT | MANDATORY] pattern based movement gen -> pattern to use for movement
		pattern="dont_move",

		--custom parameter for bouncing
		bounce = 4,
		},
	--! @brief [OPTIONAL] combat settings for mob
	combat = {
		--! @brief [MANDATORY] does mob start an attack on its own?
		starts_attack=true,

		--! @brief [MANDATORY] chance mob will attack (if starting attack on its own or beeing attacked)
		angryness=0.95,


		--! @brief [OPTIONAL] switch to this movement gen while in combat
		mgen="follow_mov_gen",

		--! @brief [OPTIONAL] configuration of meele attack
		melee = {
			--! @brief [MANDATORY] maximum damage mob does per hit
			maxdamage=0.5,
			--! @brief [MANDATORY] range mob will hit
			range=2,
			--! @brief [MANDATORY] minimum time between two hits
			speed=5,
			},
		},
	die = {
		name="mob_slime_die",
		gain = 0.5,
		max_hear_distance = 4,
		},
		states = {
				{
				name = "default",
				movgen = "none",
				chance = 0,
				typical_state_time = 300,
				graphics_3d = {
					visual = "mesh",
					mesh = "mob_slime_slime.b3d",
					textures = {"mob_slime_slime_mesh.png"},
					collisionbox = selectionbox_slime_L,
					visual_size= {x=0.75,y=0.75,z=0.75},
					},
				},
			},
	}

local slime_name   = prototype_mob_slime_L.modname .. ":"  .. prototype_mob_slime_L.name
local slime_env = mobf_environment_by_name(prototype_mob_slime_L.generic.envid)

mobf_spawner_register("slime_spawner_1",slime_name,
	{
	spawnee = slime_name,
	spawn_interval = 60,
	spawn_inside = slime_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=slime_name,
				distance=100,threshold=2 },
		},

	light_around =
	{
		{ type="CURRENT_MAX", distance = 2, threshold=6 }
	},

	nodes_around =
	{
		{ type="MIN", name = {"air"},distance=2,threshold=65}
	},

	absolute_height = {
		max = -100,
	},

	mapgen =
	{
		enabled = true,
		retries = 20,
		spawntotal = 3,
	},

	surfaces = { "default:dirt",
					"default:cobble",
					"default:stone",
					"default:desert_stone",
					"default:gravel"},

	collisionbox = selectionbox_slime_L,
	})

minetest.log("action","\tadding mob "..prototype_mob_slime_L.name)
mobf_add_mob(prototype_mob_slime_L)
minetest.log("action","\tadding mob "..prototype_mob_slime_M.name)
mobf_add_mob(prototype_mob_slime_M)
minetest.log("action","\tadding mob "..prototype_mob_slime_S.name)
mobf_add_mob(prototype_mob_slime_S)
minetest.log("action","MOD: mob_slime mod              version " .. version .. " loaded")
