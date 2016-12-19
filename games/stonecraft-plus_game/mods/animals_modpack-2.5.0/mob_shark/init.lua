-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief shark implementation
--! @copyright Sapier
--! @author Sapier
--! @date 2014-05-30
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
--
-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
  dofile(minetest.get_modpath("intllib").."/intllib.lua")
  S = intllib.Getter(minetest.get_current_modname())
else
  S = function ( s ) return s end
end

local version = "0.2.0"

minetest.log("action","MOD: mob_shark loading ...")

local selectionbox_shark = {-0.75, -0.5, -0.75, 0.75, 0.5, 0.75}

local shark_groups = {
						not_in_creative_inventory=1
					}

function shark_drop()
	local result = {}

	if math.random() < 0.01 then
		table.insert(result,"animalmaterials:shark_tooth 3")
	end

	if math.random() < 0.01 then
		table.insert(result,"animalmaterials:shark_skin 1")
	end

	table.insert(result,"animalmaterials:fish_shark 3")

	return result
end

local shark_prototype = {
		name="shark",
		modname="mob_shark",

		factions = {
			member = {
				"animals",
				"fish",
				"sharks"
				}
			},

		generic = {
					description= S("Shark"),
					base_health=5,
					kill_result=shark_drop,
					armor_groups= {
						fleshy=20,
					},
					groups = shark_groups,
					envid="deep_water",
					population_density = 450,
				},
		movement =  {
					default_gen="probab_mov_gen",
					min_accel=0.1,
					max_accel=0.3,
					max_speed=0.8,
					pattern="swim_pattern1",
					canfly=true,
					follow_speedup= { x=20,y=1.5,z=20 },
				},
		combat = {
					angryness=1,
					starts_attack=true,
					sun_sensitive=false,
					melee = {
						maxdamage=5,
						range=2,
						speed=1,
						},
					distance 		= nil,
					self_destruct 	= nil,
					},
		animation = {
				swim = {
					start_frame = 80,
					end_frame   = 160,
					},
				stand = {
					start_frame = 1,
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
						mesh = "mob_shark.b3d",
						textures = {"mob_shark_shark_mesh.png"},
						collisionbox = selectionbox_shark,
						visual_size= {x=1,y=1,z=1},
						},
					graphics = {
						sprite_scale={x=2,y=1},
						sprite_div = {x=1,y=1},
						visible_height = 1,
						visible_width = 1,
						},
					typical_state_time = 30,
				},
				{
					name = "swiming",
					movgen = "probab_mov_gen",
					chance = 0.9,
					animation = "swim",
					typical_state_time = 180,
				},
				{
					name = "combat",
					typical_state_time = 9999,
					chance = 0.0,
					animation = "swim",
					movgen = "follow_mov_gen"
				},
				},
		}

local shark_name = shark_prototype.modname .. ":"  .. shark_prototype.name
local shark_env = mobf_environment_by_name(shark_prototype.generic.envid)

mobf_spawner_register("shark_spawner_1",shark_name,
	{
	spawnee = shark_name,
	spawn_interval = 60,
	spawn_inside = shark_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=shark_name,
				distance=shark_prototype.generic.population_density,threshold=2 },
		},

	absolute_height =
	{
		min = -50,
		max = -20
	},

	nodes_around =
	{
		{type="MIN",distance=2, name={ "default:water_flowing","default:water_source"},threshold=22},
	},

	-- set to empty to disable relative check
	relative_height = {},

	collisionbox = selectionbox_shark,

	spawns_per_interval = 5
	})

--register with animals mod
minetest.log("action","\tadding mob "..shark_prototype.name)
mobf_add_mob(shark_prototype)
minetest.log("action","MOD: mob_shark mod version " .. version .. " loaded")
