-------------------------------------------------------------------------------
-- Mob warthog (based uppon idea of TenPlus1)
--
--! @file init.lua
--! @brief mob_ghost implementation
--! @copyright Sapier
--! @author Sapier
--! @date 2014-09-10
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
core.log("action","MOD: mob_warthog loading ...")

local version = "0.0.1"

local warthog_groups = {
						not_in_creative_inventory=1
					}

local selectionbox_warthog = {-0.4, -0.01, -0.4, 0.4, 1, 0.4}

local function warthog_drop()
	local result = {}
	if math.random() < 0.25 then
		table.insert(result,"animalmaterials:pork_raw 3")
	else
		table.insert(result,"animalmaterials:pork_raw 2")
	end

	return result
end


local warthog_prototype = {
		name="warthog",
		modname="mob_warthog",

		factions = {
			member = {
				"animals",
				"warthog",
				"forrest_animals"
				}
			},

		generic = {
					description="Warthog (Animals)",
					base_health=15,
					kill_result=warthog_drop,
					armor_groups= {
						fleshy=130,
					},
					groups = warthog_groups,
					envid="meadow",
					population_density=150,
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
		combat = {
					starts_attack = false,
					sun_sensitive = false,
					distance      = nil,
					self_destruct = nil,
					
--					on_hit_overlay = {
--						texture = "mob_ghost_ghost_hit.png",
--						timer   = 0.4
--					},
					
					melee = {
						maxdamage=1,
						range=2,
						speed=0.6,
						},
					},
		catching = {
				tool="animalmaterials:lasso",
				consumed=true,
				},
		sound = {
				random = {
					interval = 20,
					max_interval_deviation = 15,
					list = {
						{
						name="mob_warthog_warthog",
						gain = 0.6,
						max_hear_distance = 10,
						},
					}
				},
				hit = {
					name="mob_warthog_hit",
					gain = 0.4,
					max_hear_distance = 5,
				},
				die = {
					name="mob_warthog_die",
					gain = 0.5,
					max_hear_distance = 5,
				},
				melee = {
					name="mob_warthog_melee",
					gain = 0.5,
					max_hear_distance = 5,
				}
		},
		animation = {
				stand = {
					start_frame = 25,
					end_frame   = 55,
					},
				walk = {
					start_frame = 70,
					end_frame   = 100,
					},
			},
		states = {
				{
					name = "default",
					movgen = "none",
					typical_state_time = 30,
					chance = 0,
					animation = "stand",
					graphics_3d = {
						visual = "mesh",
						mesh = "mob_warthog.x",
						textures = {"mob_warthog.png"},
						collisionbox = selectionbox_warthog,
						visual_size= {x=1,y=1,z=1},
						model_orientation_fix = -math.pi/2,
						},
				},
				{
					name = "walking",
					movgen = "probab_mov_gen",
					typical_state_time = 120,
					chance = 0.5,
					animation = "walk",
				},
				{
					name = "combat",
					typical_state_time = 9999,
					chance = 0.0,
					animation = "walk",
					movgen = "follow_mov_gen"
				},
			}
		}

local warthog_name   = warthog_prototype.modname .. ":"  .. warthog_prototype.name
local ghost_env = mobf_environment_by_name(warthog_prototype.generic.envid)

mobf_spawner_register("warthog_spawner_1",warthog_name,
	{
	spawnee = warthog_name,
	spawn_interval = 300,
	spawn_inside = ghost_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=warthog_name,
				distance=warthog_prototype.generic.population_density,threshold=1 },
		},

	absolute_height =
	{
		min = 0,
	},
	
	nodes_around =
	{
		{ type="MIN", name = { "default:leaves","default:tree"},distance=5,threshold=4}
	},

	mapgen =
	{
		enabled = true,
		retries = 5,
		spawntotal = 1,
	},

	surfaces = {"default:dirt_with_grass","default:dirt"},
	collisionbox = selectionbox_warthog
	})

if factions~= nil and
	type(factions.set_base_reputation) == "function" then
	factions.set_base_reputation("warthogs","players",-5)
end

core.log("action","\tadding mob "..warthog_prototype.name)
mobf_add_mob(warthog_prototype)
core.log("action","MOD: mob_warthog mod            version " .. version .. " loaded")