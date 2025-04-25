local S = minetest.get_translator("livingnether")

mobs:register_mob("livingnether:noodlemaster", {
stepheight = 3,
	type = "monster",
	passive = false,
        attack_animals = false,
	damage = 15,
	reach = 5,
	attack_type = "dogshoot",
	dogshoot_switch = 1,
	dogshoot_count_max = 12, -- shoot for 10 seconds
	dogshoot_count2_max = 3, -- dogfight for 3 seconds
	shoot_interval = 0.2,
	arrow = "livingnether:lavaball",
	shoot_offset = 0.8,
	hp_min = 250,
	hp_max = 1000,
	armor = 100,
collisionbox = {-3,-1.0,-3,3,3,3},
	visual = "mesh",
	mesh = "Noodlemaster.b3d",
	visual_size = {x = 4.0, y = 4.0},
	textures = {
		{"texturenoodlemaster.png"},
	},
	sounds = {
		death = "livingnether_noodlemaster",
		random = "livingnether_noodlemaster2",
		distance = 30,
	},
	makes_footstep_sound = false,
	walk_velocity = 3,
	run_velocity = 4,
	fall_speed = 0,
	jump = true,
        jump_height = 6,
	stepheight = 3,
	fly = true,
	drops = {
		{name = "default:mese_crystal", chance = 1, min = 1, max = 3},
	},
	water_damage = 1,
	lava_damage = 0,
	light_damage = 0,
	fear_height = 0,
	animation = {
		speed_normal = 50,
		stand_start = 0,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		fly_start = 100, -- swim animation
		fly_end = 200,
		punch_start = 250,
		punch_end = 350,
		shoot_start = 250,
		shoot_end = 350,
		-- 50-70 is slide/water idle
	},

fly_in = {"air"},
	floats = 0,
view_range = 20,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_livingnether then
mobs:spawn({
	name = "livingnether:noodlemaster",
	nodes = {"nether:rack_deep"},
	min_light = 0,
	interval = 500,
	chance = 8000, -- 15000
	min_height = livingnether.MIN_HEIGHT,
	max_height = livingnether.MAX_HEIGHT,
})
end

mobs:register_egg("livingnether:noodlemaster", S("Noodlemaster"), "anoodlemaster.png")

-- fireball (weapon)
mobs:register_arrow("livingnether:lavaball", {
	visual = "sprite",
--	visual = "wielditem",
	visual_size = {x = 0.5, y = 0.5},
	textures = {"lavaball.png"},
	collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	velocity = 7,
	tail = 1,
	tail_texture = "lavaball.png",
	tail_size = 10,
	glow = 5,
	expire = 0.1,

	on_activate = function(self, staticdata, dtime_s)
		-- make fireball indestructable
		self.object:set_armor_groups({immortal = 1, fleshy = 100})
	end,

	-- if player has a good weapon with 7+ damage it can deflect fireball
	on_punch = function(self, hitter, tflp, tool_capabilities, dir)

		if hitter and hitter:is_player() and tool_capabilities and dir then

			local damage = tool_capabilities.damage_groups and
				tool_capabilities.damage_groups.fleshy or 1

			local tmp = tflp / (tool_capabilities.full_punch_interval or 1.4)

			if damage > 6 and tmp < 4 then

				self.object:set_velocity({
					x = dir.x * self.velocity,
					y = dir.y * self.velocity,
					z = dir.z * self.velocity,
				})
			end
		end
	end,

	-- direct hit, no fire... just plenty of pain
	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},
		}, nil)
	end,

	-- node hit
	hit_node = function(self, pos, node)
		mobs:boom(self, pos, 1)

	end
})