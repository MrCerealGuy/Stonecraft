-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief gull implementation
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

minetest.log("action","MOD: animal_gull loading ...")

local version = "0.2.0"

local gull_groups = {
						not_in_creative_inventory=1
					}

local selectionbox_gull = {-1, -0.3, -1, 1, 0.3, 1}

gull_prototype = {
		name="gull",
		modname="animal_gull",

		factions = {
			member = {
				"animals",
				"birds"
				}
			},

		generic = {
					description= S("Gull"),
					base_health=5,
					kill_result="",
					armor_groups= {
						fleshy=85,
					},
					groups = gull_groups,
					envid="flight_1",
					population_density = 250,
				},
		movement =  {
					min_accel=0.5,
					max_accel=1,
					max_speed=4,
					pattern="flight_pattern1",
					canfly=true,
					},
		animation = {
				fly = {
					start_frame = 0,
					end_frame   = 95,
					},
				},
		states = {
				{
					name = "default",
					movgen = "probab_mov_gen",
					typical_state_time = 100,
					chance = 0,
					animation = "fly",
					graphics = {
						sprite_scale={x=2,y=2},
						sprite_div = {x=6,y=1},
						visible_height = 1,
						visible_width = 1,
					},
					graphics_3d = {
						visual = "mesh",
						mesh = "animal_gull.b3d",
						textures = {"animal_gull_mesh.png"},
						collisionbox = selectionbox_gull,
						visual_size= {x=1,y=1,z=1},
						},
				},
			}
		}

--compatibility code
minetest.register_entity("animal_gull:gull_spawner",
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
local gullname = gull_prototype.modname .. ":"  .. gull_prototype.name
local gull_env = mobf_environment_by_name(gull_prototype.generic.envid)

mobf_spawner_register("gull_spawner_1",gullname,
	{
	spawnee = gullname,
	spawn_interval = 60,
	spawn_inside = gull_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=gullname,
				distance=gull_prototype.generic.population_density,threshold=2 },
		},

	relative_height =
	{
		min = gull_env.min_height_above_ground,
		max = gull_env.min_height_above_ground
	},

	absolute_height =
	{
		min = 10,
	},

	surfaces = { "default:water_source", "default:water_flowing"},
	collisionbox = selectionbox_gull
	})


--register with animals mod
minetest.log("action","\tadding mob "..gull_prototype.name)
mobf_add_mob(gull_prototype)
minetest.log("action","MOD: animal_gull mod            version " .. version .. " loaded")
