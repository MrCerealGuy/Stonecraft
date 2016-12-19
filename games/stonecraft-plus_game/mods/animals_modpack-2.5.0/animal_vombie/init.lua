local version = "0.2.2"

minetest.log("action","MOD: loading animal_vombie ... ")

local vombie_groups = {
						not_in_creative_inventory=1
					}

local selectionbox_vombie = {-0.3, -1.0, -0.3, 0.3, 0.7, 0.3}

local modpath = minetest.get_modpath("animal_vombie")

dofile (modpath .. "/flame.lua")

function vombie_drop()
	local result = {}
	if math.random() < 0.05 then
		table.insert(result,"animalmaterials:bone 2")
	else
		table.insert(result,"animalmaterials:bone 1")
	end

	table.insert(result,"animalmaterials:meat_undead 1")

	return result
end

function vombie_on_step_handler(entity,now,dtime)
	local pos = entity.getbasepos(entity)
	local current_light = minetest.get_node_light(pos)

	--print("vombie on step: current_light:" .. current_light .. " max light: "
	--	.. LIGHT_MAX .. " 3dmode:" .. dump(minetest.world_setting_get("disable_animals_3d_mode")))

	if current_light ~= nil and
		current_light > LIGHT_MAX and
		minetest.world_setting_get("mobf_disable_3d_mode") ~= true and
		minetest.world_setting_get("vombie_3d_burn_animation_enabled") == true then


		local xdelta = (math.random()-0.5)
		local zdelta = (math.random()-0.5)
		--print("receiving sun damage: " .. xdelta .. " " .. zdelta)
		local newobject=minetest.add_entity( {	x=pos.x + xdelta,
													y=pos.y,
													z=pos.z + zdelta },
										"animal_vombie:vombie_flame")

		--add particles
	end
	if entity.dynamic_data.spawning.spawner == "at_night" or
		entity.dynamic_data.spawning.spawner == "at_night_mapgen" then
		local current_time = minetest.get_timeofday()
		if (current_time > 0.15) and
			(current_time < 0.30) then
			if entity.last_time ~= nil then
				local last_step_size = dtime /  86400 -- (24*3600)
				local time_step = current_time - entity.last_time
				if time_step > last_step_size * 1000 then
					print("Vombie: time jump detected removing mob: " .. time_step .. " last_step_size: " .. (last_step_size * 1000))
					spawning.remove(entity)
					--return false to abort procession of other hooks
					return false
				end
			end
		end

		entity.last_time = current_time
	end
end

function vombie_on_activate_handler(entity)

	local pos = entity.object:getpos()

	local current_light = minetest.get_node_light(pos)

	if current_light == nil then
		minetest.log(LOGLEVEL_ERROR,
			"ANIMALS:Vombie Bug!!! didn't get a light value for ".. printpos(pos))
		return
	end
	--check if animal is in sunlight
	if ( current_light > LIGHT_MAX) then
		--don't spawn vombie in sunlight
		spawning.remove(entity)
	end
end

local vombie_prototype = {
		name="vombie",
		modname="animal_vombie",

		factions = {
			member = {
				"monsters",
				"undead"
				}
			},

		generic = {
					description="Vombie",
					base_health=8,
					kill_result=vombie_drop,
					armor_groups= {
						fleshy=95,
						daemon=30,
					},
					groups = vombie_groups,
					envid="simple_air",
					custom_on_step_handler = vombie_on_step_handler,
					custom_on_activate_handler = vombie_on_activate_handler,
					population_density=20,
					stepheight = 0.51,
				},
		movement =  {
					min_accel=0.3,
					max_accel=0.75,
					max_speed=1,
					pattern="stop_and_go",
					canfly=false,
					follow_speedup=20,
					},
		combat = {
					angryness=1,
					starts_attack=true,
					sun_sensitive=true,
					melee = {
						maxdamage=2,
						range=2,
						speed=1,
						},
					distance 		= nil,
					self_destruct 	= nil,
					},
		sound = {
					random = {
								name="animal_vombie_random_1",
								min_delta = 10,
								chance = 0.5,
								gain = 0.05,
								max_hear_distance = 5,
								},
					sun_damage = {
								name="animal_vombie_sun_damage",
								gain = 0.25,
								max_hear_distance = 7,
								},
					hit = {
								name="animal_vombie_hit",
								gain = 0.25,
								max_hear_distance = 5,
								},
					},
		animation = {
				stand = {
					start_frame = 0,
					end_frame   = 80,
					},
				walk = {
					start_frame = 168,
					end_frame   = 188,
					},
				attack = {
					start_frame = 81,
					end_frame   = 110,
					},
			},
		states = {
				{
					name = "default",
					movgen = "none",
					typical_state_time = 30,
					chance = 0,
					animation = "stand",
					graphics = {
						sprite_scale={x=4,y=4},
						sprite_div = {x=6,y=2},
						visible_height = 2.2,
						visible_width = 1,
					},
					graphics_3d = {
						visual = "mesh",
						mesh = "animal_vombie_vombie.b3d",
						textures = {"animal_vombie_vombie_mesh.png"},
						collisionbox = selectionbox_vombie,
						visual_size= {x=1,y=1,z=1},
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
					animation = "attack",
					movgen="mgen_path",
				},
			}
		}


--compatibility code
minetest.register_entity("animal_vombie:vombie_spawner",
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

minetest.register_entity("animal_vombie:vombie_spawner_at_night",
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

minetest.register_entity("animal_vombie:vombie_spawner_shadows",
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
local vombie_name   = vombie_prototype.modname .. ":"  .. vombie_prototype.name
local vombie_env = mobf_environment_by_name(vombie_prototype.generic.envid)

mobf_spawner_register("vombie_spawner_1",vombie_name,
	{
	spawnee = vombie_name,
	spawn_interval = 10,
	spawn_inside = vombie_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=vombie_name,
				distance=vombie_prototype.generic.population_density,threshold=2 },
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
		{ begin = 0.85, stop=0.99 },
		{ begin = 0.0,  stop=0.15 },
	},

	surfaces = { "default:dirt_with_grass", "default:sand", "default:desert_sand"},
	collisionbox = selectionbox_vombie
	})

mobf_spawner_register("vombie_spawner_2",vombie_name,
	{
	spawnee = vombie_name,
	spawn_interval = 60,
	spawn_inside = vombie_env.media,
	entities_around =
		{
			{ type="MAX",distance=1,threshold=0 },
			{ type="MAX",entityname=vombie_name,
				distance=50,threshold=2 },
		},

	light_around =
	{
		{ type="OVERALL_MAX", distance = 2, threshold=6 }
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

	collisionbox = selectionbox_vombie
	})


--register with animals mod
minetest.log("action","\tadding mob "..vombie_prototype.name)
mobf_add_mob(vombie_prototype)
minetest.log("action","MOD: animal_vombie mod          version " .. version .. " loaded")