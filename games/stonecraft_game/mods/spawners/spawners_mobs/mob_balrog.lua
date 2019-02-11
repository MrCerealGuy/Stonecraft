-- modified Sand Monster by PilzAdam with Mummy by BlockMen

local balrog_def = {
	type = "monster",
	passive = false,
	rotate = 180,
	hp_min = 1000,
	hp_max = 1250,
	pathfinding = false,
	attack_type = "dogshoot",
	shoot_interval = 0.6,
	dogshoot_switch = 1,
	dogshoot_count_max = 10,
	shoot_offset = 1,
	arrow = "spawners_mobs:balrog_firebolt",
	reach = 5,
	damage = 10,
	armor = 100,
	collisionbox = {-0.8, -2.1, -0.8, 0.8, 2.6, 0.8},
	visual_size = {x=2, y=2},
	visual = "mesh",
	mesh = "spawners_mobs_balrog.b3d",
	drawtype = "front",
	textures = {
		{"spawners_mobs_balrog.png"},
	},
	blood_texture = "fire_basic_flame.png",
	makes_footstep_sound = true,
	sounds = {
		death = "spawners_mobs_balrog_death",
		attack = "spawners_mobs_balrog_attack",
		shoot_attack = "spawners_mobs_balrog_fireball",
		damage = "spawners_mobs_balrog_hit",
		random = "spawners_mobs_balrog_neutral",
		distance = 15
	},
	walk_velocity = 3,
	run_velocity = 4,
	view_range = 20,
	jump = true,
	floats = 1,
	drops = {
		{name = "default:diamondblock", chance = 2, min = 1, max = 8},
		{name = "default:diamondblock", chance = 2, min = 1, max = 8},
		{name = "default:diamondblock", chance = 2, min = 1, max = 4},
		{name = "default:diamondblock", chance = 2, min = 1, max = 4},
		{name = "default:diamondblock", chance = 2, min = 1, max = 4},
		{name = "default:diamond", chance = 2, min = 1, max = 8},
		{name = "default:diamond", chance = 2, min = 1, max = 8},
		{name = "default:diamond", chance = 2, min = 1, max = 4},
		{name = "default:diamond", chance = 2, min = 1, max = 4},
		{name = "default:diamond", chance = 2, min = 1, max = 4},
		{name = "default:mese", chance = 2, min = 1, max = 4},
		{name = "default:mese_crystal", chance = 2, min = 1, max = 4},
		{name = "default:mese", chance = 2, min = 1, max = 4},
		{name = "default:mese_crystal", chance = 2, min = 1, max = 4},
		{name = "default:mese", chance = 2, min = 1, max = 4},
		{name = "default:mese_crystal", chance = 2, min = 1, max = 4},
		{name = "default:mese", chance = 2, min = 1, max = 4},
		{name = "default:mese_crystal", chance = 2, min = 1, max = 4},
		{name = "default:mese", chance = 2, min = 1, max = 4},
		{name = "default:mese_crystal", chance = 2, min = 1, max = 4},
		{name = "3d_armor:boots_diamond", chance = 2, min = 1, max = 4},
		{name = "3d_armor:chestplate_diamond", chance = 2, min = 1, max = 1},
		{name = "3d_armor:helmet_diamond", chance = 2, min = 1, max = 1},
		{name = "3d_armor:leggings_diamond", chance = 2, min = 1, max = 1},
		{name = "3d_armor:chestplate_bronze", chance = 2, min = 1, max = 1},
		{name = "3d_armor:helmet_bronze", chance = 2, min = 1, max = 1},
		{name = "3d_armor:leggings_bronze", chance = 2, min = 1, max = 1},
		{name = "3d_armor:chestplate_gold", chance = 2, min = 1, max = 1},
		{name = "3d_armor:helmet_gold", chance = 2, min = 1, max = 1},
		{name = "3d_armor:leggings_gold", chance = 2, min = 1, max = 1},
		{name = "3d_armor:helmet_magma", chance = 10, min = 1, max = 1},
		{name = "3d_armor:chestplate_magma", chance = 10, min = 1, max = 1},
		{name = "3d_armor:leggings_magma", chance = 10, min = 1, max = 1},
		{name = "3d_armor:boots_magma", chance = 10, min = 1, max = 1},
		{name = "obsidianmese:pick", chance = 2, min = 1, max = 1},
		{name = "obsidianmese:sword", chance = 2, min = 1, max = 1},
		{name = "default:pick_diamond", chance = 2, min = 1, max = 1},
		{name = "default:sword_diamond", chance = 2, min = 1, max = 1},
		{name = "default:shovel_diamond", chance = 2, min = 1, max = 1},
		{name = "default:axe_diamond", chance = 2, min = 1, max = 1},
		{name = "default:hoe_diamond", chance = 2, min = 1, max = 1},
		{name = "default:pick_mese", chance = 2, min = 1, max = 1},
		{name = "default:sword_mese", chance = 2, min = 1, max = 1},
		{name = "default:shovel_mese", chance = 2, min = 1, max = 1},
		{name = "default:axe_mese", chance = 2, min = 1, max = 1},
		{name = "default:hoe_mese", chance = 2, min = 1, max = 1},
		{name = "default:pick_bronze", chance = 2, min = 1, max = 1},
		{name = "default:sword_bronze", chance = 2, min = 1, max = 1},
		{name = "default:shovel_bronze", chance = 2, min = 1, max = 1},
		{name = "default:axe_bronze", chance = 2, min = 1, max = 1},
		{name = "default:hoe_bronze", chance = 2, min = 1, max = 1},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "farming:bread", chance = 2, min = 1, max = 3},
		{name = "obsidianmese:mese_apple", chance = 2, min = 1, max = 3},
		{name = "obsidianmese:mese_apple", chance = 2, min = 1, max = 3},
		{name = "obsidianmese:mese_apple", chance = 2, min = 1, max = 3},
		{name = "obsidianmese:mese_apple", chance = 2, min = 1, max = 3},
		{name = "obsidianmese:mese_apple", chance = 2, min = 1, max = 3},
	},
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
	fear_height = 2,
	animation = {
		stand_start = 0,
		stand_end = 240,
		walk_start = 240,
		walk_end = 300,
		punch_start = 300,
		punch_end = 380,
		speed_normal = 15,
		speed_run = 15,
	},
	_timer = 0,
	_random_trigger = 15,
	do_custom = function(self, dtime)
		if not self._timer then
			self._timer = 0
		end

		if not self._random_trigger then
			self._random_trigger = math.random(15, 30)
		end

		self._timer = self._timer + dtime

		if self._timer > self._random_trigger then
			self._timer = 0
			self._random_trigger = math.random(15, 30)

			local mob_pos = self.object:get_pos()
			local activation_area = minetest.get_objects_inside_radius(mob_pos, 20)
			for k, object in ipairs(activation_area) do
				if object:is_player() then
					local player_pos = object:get_pos()
					local player_hp = object:get_hp()

					-- is in MMO Arena & health check
					if x_default:isInMMOArena(player_pos) and player_hp > 0 then
						-- play sound
						minetest.sound_play("spawners_mobs_teleport", {
							object = object,
							gain = 1.0,
							max_hear_distance = 20
						})

						-- teleport player
						object:set_pos(mob_pos)
					end

				end
			end
		end
	end
}

mobs:register_mob("spawners_mobs:balrog", balrog_def)

-- mobs:spawn({
-- 	name = "spawners_mobs:balrog",
-- 	nodes = {"default:desert_sand", "default:desert_stone", "default:sand", "default:sandstone", "default:silver_sand"},
-- 	min_light = 0,
-- 	max_light = 20,
-- 	chance = 2000,
-- 	active_object_count = 2,
-- 	day_toggle = false,
-- })

mobs:register_egg("spawners_mobs:balrog", "balrog", "default_coal_block.png", 1, true)

-- shooting
mobs:register_arrow("spawners_mobs:balrog_firebolt", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"spawners_mobs_firebolt.png"},
	velocity = 15,

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

	hit_node = function(self, pos, node)
		-- minetest.set_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="default:lava_flowing"})
	end
})
