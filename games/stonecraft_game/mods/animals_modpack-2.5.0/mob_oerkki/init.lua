-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief big_red implementation
--! @copyright Sapier
--! @author Sapier
--! @date 2013-01-27
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
minetest.log("action","MOD: mob_oerkki mod loading ...")
local version = "0.2.1"

local oerkki_groups = {
						not_in_creative_inventory=1
						}

local selectionbox_oerkki = {-0.75, -1.25, -0.75, 0.75, 0.75, 0.75}

local oerkki_prototype = {
		name="oerkki",
		modname="mob_oerkki",

		factions = {
			member = {
				"underground",
				"monsters"
				}
			},

		generic = {
					description="Oerkki",
					base_health=3,
					kill_result="animalmaterials:meat_toxic 1",
					armor_groups= {
						fleshy=30,
						deamon=30,
					},
					groups = oerkki_groups,
					envid="simple_air",
					population_density=750,
				},
		movement = {
					default_gen="probab_mov_gen",
					min_accel=0.2,
					max_accel=0.6,
					max_speed=2.5,
					pattern="stop_and_go",
					canfly=false,
					follow_speedup=30,
					},
		harvest = {
					tool="",
					tool_consumed=false,
					result="",
					transforms_to="",
					min_delay=-1,
					},
		combat = {
					angryness=0.65,
					starts_attack=true,
					sun_sensitive=false,
					melee = {
						maxdamage=1.5,
						range=2,
						speed=2,
						},
					self_destruct = nil,
					},
		sound = {
			},
		animation = {
				move = {
					start_frame = 1,
					end_frame   = 29,
					},
				combat = {
					start_frame = 30,
					end_frame   = 60,
					},
			},
		states = {
				{
				name = "default",
				movgen = "none",
				chance = 0,
				animation = "move",
				graphics_3d = {
					visual = "mesh",
					mesh = "mob_oerkki.b3d",
					textures = {"mob_oerkki_mesh.png"},
					collisionbox = selectionbox_oerkki,
					visual_size= {x=1,y=1,z=1},
					},
				graphics = {
					sprite_scale={x=6,y=6},
					sprite_div = {x=1,y=1},
					visible_height = 3.2,
					visible_width = 1,
					},
				typical_state_time = 30,
				},
				{
				name = "walking",
				movgen = "probab_mov_gen",
				chance = 0.5,
				animation = "move",
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

minetest.register_entity("mob_oerkki:oerkki_spawner_shadows",
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

local oerkki_name   = oerkki_prototype.modname .. ":"  .. oerkki_prototype.name
local oerkki_env = mobf_environment_by_name(oerkki_prototype.generic.envid)

mobf_spawner_register("oerkki_spawner_1",oerkki_name,
	{
	spawnee = oerkki_name,
	spawn_interval = 60,
	spawn_inside = oerkki_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=oerkki_name,
				distance=100,threshold=2 },
		},

	light_around =
	{
		{ type="CURRENT_MAX", distance = 2, threshold=6 }
	},

	absolute_height = {
		max = -50,
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

	collisionbox = selectionbox_oerkki
	})

--register with animals mod
minetest.log("action","\tadding mob "..oerkki_prototype.name)
mobf_add_mob(oerkki_prototype)
minetest.log("action","MOD: mob_oerkki mod         version " .. version .. " loaded")