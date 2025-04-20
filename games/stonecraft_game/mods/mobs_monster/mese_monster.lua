
-- translation and custom mese monster types

local S = minetest.get_translator("mobs_monster")

local mese_monster_types = {

	{ -- red
		y_min = -20,
		y_max = -1000,
		damage = 2,
		reach = 3,
		hp_min = 15,
		hp_max = 25,
		armor = 80,
		skins = {"mobs_mese_monster_red.png"},
		immune_to = {
			{"default:pick_wood", 0},
			{"default:shovel_wood", 0},
			{"default:axe_wood", 0},
			{"default:sword_wood", 0}
		},
		drops = {
			{name = "default:mese_crystal", chance = 15, min = 0, max = 1},
			{name = "default:mese_crystal_fragment", chance = 2, min = 0, max = 1}
		},
		arrow_override = function(self)
			self.velocity = 6
			self.damage = 2
		end
	},

	{ -- green
		y_min = -1001,
		y_max = -2000,
		damage = 3,
		reach = 3,
		hp_min = 20,
		hp_max = 30,
		armor = 75,
		skins = {"mobs_mese_monster_green.png"},
		immune_to = {
			{"default:pick_wood", 0},
			{"default:shovel_wood", 0},
			{"default:axe_wood", 0},
			{"default:sword_wood", 0},
			{"default:pick_stone", 0},
			{"default:shovel_stone", 0},
			{"default:axe_stone", 0},
			{"default:sword_stone", 0}
		},
		drops = {
			{name = "default:mese_crystal", chance = 12, min = 0, max = 1},
			{name = "default:mese_crystal_fragment", chance = 1, min = 0, max = 1}
		},
		arrow_override = function(self)
			self.velocity = 6
			self.damage = 2
		end
	},

	{ -- blue
		y_min = -2001,
		y_max = -3000,
		damage = 3,
		reach = 4,
		hp_min = 25,
		hp_max = 35,
		armor = 70,
		skins = {"mobs_mese_monster_blue.png"},
		immune_to = {
			{"default:pick_wood", 0},
			{"default:shovel_wood", 0},
			{"default:axe_wood", 0},
			{"default:sword_wood", 0},
			{"default:pick_stone", 0},
			{"default:shovel_stone", 0},
			{"default:axe_stone", 0},
			{"default:sword_stone", 0},
			{"default:pick_bronze", 0},
			{"default:shovel_bronze", 0},
			{"default:axe_bronze", 0},
			{"default:sword_bronze", 0}
		},
		drops = {
			{name = "default:mese", chance = 15, min = 0, max = 1},
			{name = "default:mese_crystal", chance = 9, min = 0, max = 2},
			{name = "default:mese_crystal_fragment", chance = 1, min = 0, max = 2}
		},
		arrow_override = function(self)
			self.velocity = 7
			self.damage = 3
		end
	},

	{ -- purple
		y_min = -3000,
		y_max = -31000,
		damage = 4,
		reach = 5,
		hp_min = 30,
		hp_max = 40,
		armor = 60,
		skins = {"mobs_mese_monster_purple.png"},
		immune_to = {
			{"default:pick_wood", 0},
			{"default:shovel_wood", 0},
			{"default:axe_wood", 0},
			{"default:sword_wood", 0},
			{"default:pick_stone", 0},
			{"default:shovel_stone", 0},
			{"default:axe_stone", 0},
			{"default:sword_stone", 0},
			{"default:pick_bronze", 0},
			{"default:shovel_bronze", 0},
			{"default:axe_bronze", 0},
			{"default:sword_bronze", 0},
			{"default:pick_steel", 0},
			{"default:shovel_steel", 0},
			{"default:axe_steel", 0},
			{"default:sword_steel", 0}
		},
		drops = {
			{name = "default:mese", chance = 9, min = 0, max = 1},
			{name = "default:mese_crystal", chance = 6, min = 0, max = 2},
			{name = "default:mese_crystal_fragment", chance = 1, min = 0, max = 3}
		},
		arrow_override = function(self)
			self.velocity = 8
			self.damage = 4
		end
	}
}

-- Mese Monster by SirrobZeroone

mobs:register_mob("mobs_monster:mese_monster", {
	type = "monster",
	visual_size = {x = 10, y = 10},  -- Got scale wrong in blender by factor of 10 - S01
	passive = false,
	attack_type = "dogshoot",
	damage = 4,
	reach = 4,
	shoot_interval = 0.5,
	arrow = "mobs_monster:mese_arrow",
	shoot_offset = 0.75,
--	arrow_override = function(self)
--		self.velocity = 20
--	end,
	knock_back = true,
	hp_min = 10,
	hp_max = 25,
	armor = 80,
	collisionbox = {-0.75, -0.5, -0.75, 0.75, 2.5, 0.75},
	visual = "mesh",
	mesh = "mobs_mese_monster.b3d",
	textures = {{"mobs_mese_monster_purple.png"}},
	blood_texture = "default_mese_crystal_fragment.png",
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_mesemonster",
		damage = "default_glass_footstep"
	},
	view_range = 10,
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	jump_height = 8,
	can_leap = true,
	fall_damage = 0,
	fall_speed = -6,
	stepheight = 2.1,
	immune_to = {
		{"default:pick_wood", 0},
		{"default:shovel_wood", 0},
		{"default:axe_wood", 0},
		{"default:sword_wood", 0}
	},
	drops = {
		{name = "default:mese_crystal", chance = 9, min = 0, max = 2},
		{name = "default:mese_crystal_fragment", chance = 1, min = 0, max = 2},
	},
	water_damage = 1,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 18, speed_run = 18,
		walk_start = 10, walk_end = 41, walk_speed = 20,
		run_start = 10, run_end = 41, run_speed = 30,
		stand_start = 60, stand_end = 83,
		shoot_start = 100, shoot_end = 113,
		die_start = 125, die_end = 141, death_speed = 25, die_loop = false,
		jump_start = 150 , jump_end = 168, jump_loop = false,
		punch_start = 175, punch_end = 189
	},

	after_activate = function(self, staticdata, def, dtime)

		local tex = self and self.textures and self.textures[1]

		if tex == "zmobs_mese_monster.png" then self.object:remove() end
	end,

	on_spawn = function(self)

		local pos = self.object:get_pos()

		-- quick update self function
		local function update(self, def)

			self.object:set_properties({textures = def.skins})
			self.base_texture = def.skins

			-- added by mobs_redo
			self.hp_min = def.hp_min
			self.hp_max = def.hp_max
			self.health = math.random(self.hp_min, self.hp_max)
			self.damage = def.damage
			self.reach = def.reach
			self.armor = def.armor
			self.immune_to = def.immune_to
			self.drops = def.drops
			self.arrow_override = def.arrow_override
		end

		-- Normal spawn case
		for name, def in pairs(mese_monster_types) do

			if pos.y <= def.y_min and pos.y >= def.y_max then

				update(self, def)

				return true
			end
		end
--[[
		-- player using egg
		-- direction sets type N = red, E = green, S = blue, W = purple
		-- Just for fun - S01

		local objects = minetest.get_objects_inside_radius(pos, 10)

		for i, obj in ipairs(objects) do

			if minetest.is_player(obj)
			and obj:get_wielded_item():get_name() == "mobs_monster:mese_monster" then

				local degree = (360 + math.deg(obj:get_look_horizontal())) % 360
				local compass_sel

				if degree > 45 and degree <= 135      then compass_sel = 4
				elseif degree > 135 and degree <= 225 then compass_sel = 3
				elseif degree > 225 and degree <= 315 then compass_sel = 2
				else  							 	       compass_sel = 1
				end

				local def = mese_monster_types[compass_sel]

				update(self, def)

				return true
			end
		end
]]
		-- catch case if all else fails random it
		update(self, mese_monster_types[math.random(4)])

		return true
	end
})

-- mese arrow item

minetest.register_craftitem("mobs_monster:mese_crystal_fragment_arrow", {
	description = S("Mese Monster Arrow"),
	inventory_image = "mobs_mese_arrow.png",
	groups = {not_in_creative_inventory = 1}
})

-- mese arrow

mobs:register_arrow("mobs_monster:mese_arrow", {
	visual = "wielditem",
	visual_size = {x = 0.25, y = 0.25},
	textures = {"mobs_monster:mese_crystal_fragment_arrow"},
	velocity = 8,
	rotate = 180,
	damage = 2,

	hit_player = function(self, player)

		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = self.damage}
		}, nil)
	end,

	hit_mob = function(self, player)

		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = self.damage}
		}, nil)
	end,

	hit_node = function(self, pos, node)
	end
})

-- where to spawn

if not mobs.custom_spawn_monster then

	mobs:spawn({
		name = "mobs_monster:mese_monster",
		nodes = {"default:stone"},
		max_light = 7,
		chance = 5000,
		active_object_count = 1,
		max_height = -20
	})
end

-- spawn egg

mobs:register_egg("mobs_monster:mese_monster", S("Mese Monster"), "default_mese_block.png", 1)

-- compatibility with older mobs mod

mobs:alias_mob("mobs:mese_monster", "mobs_monster:mese_monster")

-- 9x mese crystal fragments = 1x mese crystal recipe

local f = "default:mese_crystal_fragment"

minetest.register_craft({
	output = "default:mese_crystal",
	recipe = {{f, f, f}, {f, f, f}, {f, f, f}}
})
