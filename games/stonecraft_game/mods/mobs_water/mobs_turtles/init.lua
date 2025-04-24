
-- settings

local l_skins = {
	{"turtle1.png^turtle2.png^turtle3.png^turtle4.png"
		.. "^turtle5.png^turtle6.png^turtle7.png"},
	{"turtle1.png^(turtle2.png^[colorize:#a0a0a0:150" -- grey
		.. ")^(turtle3.png^[colorize:#404040:150" -- dark grey
		.. ")^(turtle4.png^[colorize:#604000:175" -- brown
		.. ")^(turtle5.png^[colorize:#604000:100" -- brown 2
		.. ")^(turtle6.png^[colorize:#808000:150" .. ")^turtle7.png"} -- olive
}

local l_spawn_chance = 30000

-- Mineclone check

local mod_mcl = minetest.get_modpath("mcl_core")

-- land turtle

mobs:register_mob("mobs_turtles:turtle", {
	type = "animal",
	passive = true,
	hp_min = 15,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.4, 0.0, -0.4, 0.4, 0.35, 0.4},
	visual = "mesh",
	mesh = "mobf_turtle.x",
	textures = l_skins,
	makes_footstep_sound = false,
	view_range = 8,
	rotate = 270,
	walk_velocity = 0.1,
	run_velocity = 0.3,
	jump = false,
	fly = false,
	floats = 1,
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fall_damage = 1,
	animation = {
		speed_normal = 24, speed_run = 24,
		stand_start = 1,stand_end = 50,
		walk_start = 60, walk_end = 90,
		run_start = 60, run_end = 90,
		hide_start = 95, hide_end = 100
	},
	drops = {
		{name = (mod_mcl and "mcl_mobitems:beef" or "mobs:meat_raw"),
				chance = 1, min = 1, max = 3}
	},
	follow = (mod_mcl and "mcl_farming:carrot_item" or "farming:carrot"),

	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 5, false, true) then return end
		if mobs:capture_mob(self, clicker, nil, 80, 100, true, nil) then return end

		self.state = "hide"

		self:set_velocity(0)
		self:set_animation("hide")

		minetest.after(5, function()

			if self and self.object then
				self.state = "stand"
			end
		end)
	end,

	do_custom = function(self, dtime)

		if self and self.state == "hide" then
			self:set_velocity(0)
		end
	end
})

-- spawn egg

mobs:register_egg("mobs_turtles:turtle", "Turtle", "default_grass.png", 1)

-- sea turtle

mobs:register_mob("mobs_turtles:seaturtle", {
	type = "animal",
	passive = true,
	hp_min = 20,
	hp_max = 30,
	armor = 250,
	collisionbox = {-0.8, 0.0, -0.8, 0.8, 0.7, 0.8},
	visual = "mesh",
	visual_size = {x = 2, y = 2},
	mesh = "mobf_turtle.x",
	textures = l_skins,
	makes_footstep_sound = false,
	view_range = 10,
	rotate = 270,
	walk_velocity = 1,
	run_velocity = 1.5,
	stepheight = 1,
	jump = false,
	fly = true,
	fly_in = (mod_mcl and "mcl_core:water_source" or "default:water_source"),
	fall_speed = 0,
	floats = 1,
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fall_damage = 0,
	animation = {
		speed_normal = 24, speed_run = 24,
		stand_start = 1, stand_end = 50,
		walk_start = 60, walk_end = 90,
		run_start = 60, run_end = 90,
		hide_start = 95, hide_end = 100
	},
	drops = {
		{name = (mod_mcl and "mcl_mobitems:beef" or "mobs:meat_raw"),
				chance = 1, min = 1, max = 3}
	},
	on_rightclick = function(self, clicker)
		mobs:capture_mob(self, clicker, 0, 0, 80, true, nil)
	end
})

-- spawn egg

mobs:register_egg("mobs_turtles:seaturtle", "Sea Turtle", "default_water.png", 1)

-- Check for custom spawn.lua

local MP = minetest.get_modpath(minetest.get_current_modname()) .. "/"
local input = io.open(MP .. "spawn.lua", "r")

if input then
	input:close() ; input = nil ; dofile(MP .. "spawn.lua")
else
	-- land turtle
	mobs:spawn({
		name = "mobs_turtles:turtle",
		nodes = {(mod_mcl and "group:shovely" or "group:crumbly")},
		neighbors = {
			(mod_mcl and "groups:shovely" or "group:crumbly"),
			(mod_mcl and "mcl_core:reeds" or "default:papyrus"),
			(mod_mcl and "mcl_core:cactus" or "default:cactus"),
			"dryplants:juncus", "dryplants:reedmace"
		},
		min_light = 5,
		interval = 30,
		chance = l_spawn_chance,
		min_height = 1,
		max_height = 10
	})

	-- sea turtle
	mobs:spawn({
		name = "mobs_turtles:seaturtle",
		nodes = {"group:water"},
		neighbors = {
			"group:water", "group:seaplants", "seawrecks:woodship", "seawrecks:uboot"
		},
		min_light = 5,
		interval = 30,
		chance = l_spawn_chance,
		max_height = 0
	})
end

print("[MOD] Mobs Redo Turtles loaded")
