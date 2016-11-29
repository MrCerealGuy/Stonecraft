-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
  dofile(minetest.get_modpath("intllib").."/intllib.lua")
  S = intllib.Getter(minetest.get_current_modname())
else
  S = function ( s ) return s end
end

local version = "0.2.0"

minetest.log("action","MOD: animal_fish_blue_white loading ...")

local selectionbox_fish_blue_white = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25}

local fish_blue_white_groups = {
                        not_in_creative_inventory=1
                    }

function fish_blue_white_drop()
	local result = {}

	if math.random() < 0.01 then
		table.insert(result,"animalmaterials:scale_blue 1")
	end

	if math.random() < 0.01 then
		table.insert(result,"animalmaterials:scale_white 1")
	end

	table.insert(result,"animalmaterials:fish_bluewhite 3")

	return result
end

local fish_blue_white_prototype = {
		name="fish_blue_white",
		modname="animal_fish_blue_white",

		factions = {
			member = {
				"animals",
				"fish"
				}
			},

		generic = {
					description= S("Blue white fish"),
					base_health=5,
					kill_result=fish_blue_white_drop,
					armor_groups= {
						fleshy=80,
					},
					groups = fish_blue_white_groups,
					envid="shallow_waters",
					population_density=150,
				},
		movement =  {
					default_gen="probab_mov_gen",
					min_accel=0.1,
					max_accel=0.3,
					max_speed=0.8,
					pattern="swim_pattern1",
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
						mesh = "fish_blue_white.b3d",
						textures = {"fish_blue_white_mesh.png"},
						collisionbox = selectionbox_fish_blue_white,
						visual_size= {x=1,y=1,z=1},
						},
					graphics = {
						sprite_scale={x=2,y=1},
						sprite_div = {x=1,y=1},
						visible_height = 1,
						visible_width = 1,
						},
					typical_state_time = 5,
				},
				{
					name = "swiming",
					movgen = "probab_mov_gen",
					chance = 0.45,
					animation = "swim",
					typical_state_time = 30,
				},
				},
		hunger = {
			target_entities = {
					"fishing:bobber_entity"
					},
			range = 15,
			chance = 0.5,
			typical_walk_time = 30,
			keep_food = true,
		},
		}
--compatibility code
minetest.register_entity("animal_fish_blue_white:fish_blue_white_spawner_shallow_water",
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
local fish_blue_white_name = fish_blue_white_prototype.modname .. ":"  .. fish_blue_white_prototype.name
local fish_blue_white_env = mobf_environment_by_name(fish_blue_white_prototype.generic.envid)

mobf_spawner_register("fish_bw_spawner_1",fish_blue_white_name,
	{
	spawnee = fish_blue_white_name,
	spawn_interval = 60,
	spawn_inside = fish_blue_white_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=fish_blue_white_name,
				distance=fish_blue_white_prototype.generic.population_density,threshold=2 },
		},

	absolute_height =
	{
		min = -10,
		max = 1
	},

	nodes_around =
	{
		{type="MIN",distance=2, name={ "default:water_flowing","default:water_source"},threshold=22},
		{type="MIN",distance=10,name={"default:dirt","default:dirt_with_grass"},threshold=1}
	},

	-- set to empty to disable relative check
	relative_height = {},

	collisionbox = selectionbox_fish_blue_white,

	spawns_per_interval = 5
	})


--register with animals mod
minetest.log("action","\tadding mob "..fish_blue_white_prototype.name)
mobf_add_mob(fish_blue_white_prototype)
minetest.log("action","MOD: animal_fish_blue_white mod version " .. version .. " loaded")
