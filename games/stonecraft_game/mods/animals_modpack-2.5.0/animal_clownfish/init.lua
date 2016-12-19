-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief clownfish implementation
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

minetest.log("action","MOD: animal_clownfish mod loading ...")

local version = "0.2.0"

local selectionbox_clownfish = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}

local clownfish_groups = {
						not_in_creative_inventory=1
					}

function clownfish_drop()
	local result = {}
	table.insert(result,"animalmaterials:scale_golden 1")
	table.insert(result,"animalmaterials:fish_clownfish 1")

	return result
end

local clownfish_prototype = {
		name="clownfish",
		modname="animal_clownfish",

		factions = {
			member = {
				"animals",
				"fish"
				}
			},

		generic = {
					description= S("Clownfish"),
					base_health=5,
					kill_result=clownfish_drop,
					armor_groups= {
						fleshy=90,
					},
					groups = clownfish_groups,
					envid = "open_waters",
					population_density=350,
				},
		movement = {
					default_gen="probab_mov_gen",
					min_accel=0.2,
					max_accel=0.3,
					max_speed=1.5,
					pattern="swim_pattern2",
					canfly=true,
					},
		catching = {
					tool="animalmaterials:net",
					consumed=true,
					},
		animation = {
				swim = {
					start_frame = 81,
					end_frame   = 155,
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
						mesh = "animal_clownfish.b3d",
						textures = {"animal_clownfish_mesh.png"},
						collisionbox = selectionbox_clownfish,
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
					name = "swiming",
					movgen = "probab_mov_gen",
					chance = 0.9,
					animation = "swim",
					typical_state_time = 180,
				},
				},
		}
--compatibility code
minetest.register_entity("animal_clownfish:clownfish_spawner_shallow_water",
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
local clownfish_name = clownfish_prototype.modname .. ":"  .. clownfish_prototype.name
local clownfish_env = mobf_environment_by_name(clownfish_prototype.generic.envid)

mobf_spawner_register("clownfish_spawner_1",clownfish_name,
	{
	spawnee = clownfish_name,
	spawn_interval = 60,
	spawn_inside = clownfish_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=clownfish_name,
				distance=clownfish_prototype.generic.population_density,threshold=2 },
		},

	absolute_height =
	{
		min = -15,
		max = -5
	},

	nodes_around =
	{
		{type="MIN",distance=2, name={ "default:water_flowing","default:water_source"},threshold=22},
		{type="MIN",distance=10,name={"default:sand"},threshold=1}
	},

	-- set to empty to disable relative check
	relative_height = {},

	collisionbox = selectionbox_clownfish,

	spawns_per_interval = 5
	})


--register with animals mod
minetest.log("action","\tadding animal "..clownfish_prototype.name)
mobf_add_mob(clownfish_prototype)
minetest.log("action","MOD: animal_clownfish mod       version " .. version .. " loaded")
