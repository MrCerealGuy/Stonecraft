
local S = mobs.intllib


-- Lava Flan by Zeg9 (additional textures by JurajVajda)

mobs:register_mob("mobs_monster:lava_flan", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	reach = 2,
	damage = 3,
	hp_min = 10,
	hp_max = 35,
	armor = 80,
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
	visual = "mesh",
	mesh = "zmobs_lava_flan.x",
	textures = {
		{"zmobs_lava_flan.png"},
		{"zmobs_lava_flan2.png"},
		{"zmobs_lava_flan3.png"},
	},
	blood_texture = "fire_basic_flame.png",
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_lavaflan",
		war_cry = "mobs_lavaflan",
	},
	walk_velocity = 0.5,
	run_velocity = 2,
	jump = true,
	view_range = 10,
	floats = 1,
	drops = {
		{name = "mobs:lava_orb", chance = 15, min = 1, max = 1},
	},
	water_damage = 8,
	lava_damage = 0,
	light_damage = 0,
	immune_to = {
		{"mobs:pick_lava", -2}, -- lava pick heals 2 health
	},
	fly_in = {"default:lava_source", "default:lava_flowing"},
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 8,
		walk_start = 10,
		walk_end = 18,
		run_start = 20,
		run_end = 28,
		punch_start = 20,
		punch_end = 28,
	},
	on_die = function(self, pos)

		local cod = self.cause_of_death or {}
		local def = cod.node and minetest.registered_nodes[cod.node]

		if def and def.groups and def.groups.water then

			pos.y = pos.y + 1

			mobs:effect(pos, 40, "tnt_smoke.png", 3, 5, 2, 0.5, nil, false)

			minetest.sound_play("fire_extinguish_flame",
				{pos = pos, max_hear_distance = 12, gain = 1.5}, true)

			self.object:remove()

			if math.random(4) == 1 then
				mobs:add_mob(pos, {
					name = "mobs_monster:obsidian_flan",
				})
			end
		else
			if minetest.get_node(pos).name == "air" then
				minetest.set_node(pos, {name = "fire:basic_flame"})
			end

			mobs:effect(pos, 40, "fire_basic_flame.png", 2, 3, 2, 5, 10, nil)

			self.object:remove()
		end
	end,
	glow = 10,
})


if not mobs.custom_spawn_monster then
mobs:spawn({
	name = "mobs_monster:lava_flan",
	nodes = {"default:lava_source"},
	chance = 1500,
	active_object_count = 1,
	max_height = 0,
})
end


mobs:register_egg("mobs_monster:lava_flan", S("Lava Flan"), "default_lava.png", 1)

mobs:alias_mob("mobs:lava_flan", "mobs_monster:lava_flan") -- compatibility


-- lava orb
minetest.register_craftitem(":mobs:lava_orb", {
	description = S("Lava orb"),
	inventory_image = "zmobs_lava_orb.png",
	light_source = 14,
})

minetest.register_alias("zmobs:lava_orb", "mobs:lava_orb")

minetest.register_craft({
	type = "fuel",
	recipe = "mobs:lava_orb",
	burntime = 80,
})


-- Lava Pick (digs and smelts at same time)

local old_handle_node_drops = minetest.handle_node_drops

function minetest.handle_node_drops(pos, drops, digger)

	-- does player exist?
	if not digger then return end

	-- are we holding Lava Pick?
	if digger:get_wielded_item():get_name() ~= ("mobs:pick_lava") then
		return old_handle_node_drops(pos, drops, digger)
	end

	-- reset new smelted drops
	local hot_drops = {}

	-- loop through current node drops
	for _, drop in pairs(drops) do

		-- get cooked output of current drops
		local stack = ItemStack(drop)
		local output = minetest.get_craft_result({
			method = "cooking",
			width = 1,
			items = {drop}
		})

		-- if we have cooked result then add to new list
		if output
		and output.item
		and not output.item:is_empty() then

			table.insert(hot_drops,
				ItemStack({
					name = output.item:get_name(),
					count = output.item:to_table().count,
				})
			)
		else -- if not then return normal drops
			table.insert(hot_drops, stack)
		end
	end

	return old_handle_node_drops(pos, hot_drops, digger)
end

minetest.register_tool(":mobs:pick_lava", {
	description = S("Lava Pickaxe"),
	inventory_image = "mobs_pick_lava.png",
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.80, [2]=0.80, [3]=0.40}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy = 6, fire = 1},
	},
	groups = {pickaxe = 1},
	light_source = 14
})

minetest.register_craft({
	output = "mobs:pick_lava",
	recipe = {
		{"mobs:lava_orb", "mobs:lava_orb", "mobs:lava_orb"},
		{"", "default:obsidian_shard", ""},
		{"", "default:obsidian_shard", ""},
	}
})

-- Add [toolranks] mod support if found
if minetest.get_modpath("toolranks") then

minetest.override_item("mobs:pick_lava", {
	original_description = "Lava Pickaxe",
	description = toolranks.create_description("Lava Pickaxe", 0, 1),
	after_use = toolranks.new_afteruse})
end


-- obsidian flan

mobs:register_mob("mobs_monster:obsidian_flan", {
	type = "monster",
	passive = false,
	attack_type = "shoot",
	shoot_interval = 0.5,
	shoot_offset = 1.0,
	arrow = "mobs_monster:obsidian_arrow",
	reach = 2,
	damage = 3,
	hp_min = 10,
	hp_max = 35,
	armor = 30,
	visual_size = {x = 0.6, y = 0.6},
	collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.8, 0.3},
	visual = "mesh",
	mesh = "zmobs_lava_flan.x",
	textures = {
		{"mobs_obsidian_flan.png"},
	},
	blood_texture = "default_obsidian.png",
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_lavaflan",
--		war_cry = "mobs_lavaflan",
	},
	walk_velocity = 0.1,
	run_velocity = 0.5,
	jump = false,
	view_range = 10,
	floats = 0,
	drops = {
		{name = "default:obsidian_shard", chance = 1, min = 1, max = 5},
		{name = "default:obsidian", chance = 3, min = 0, max = 2},
	},
	water_damage = 0,
	lava_damage = 8,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 8,
		walk_start = 10,
		walk_end = 18,
		run_start = 20,
		run_end = 28,
		punch_start = 20,
		punch_end = 28,
	}
})

mobs:register_egg("mobs_monster:obsidian_flan", S("Obsidian Flan"),
		"default_obsidian.png", 1)


local mobs_griefing = minetest.settings:get_bool("mobs_griefing") ~= false

-- mese arrow (weapon)
mobs:register_arrow("mobs_monster:obsidian_arrow", {
	visual = "sprite",
--	visual = "wielditem",
	visual_size = {x = 0.5, y = 0.5},
	textures = {"default_obsidian_shard.png"},
	velocity = 6,
--	rotate = 180,

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

		if mobs_griefing == false or minetest.is_protected(pos, "") then
			return
		end

		local texture = "default_dirt.png" --fallback texture

		local radius = 1
		local def = minetest.registered_nodes[node]
		if def then
			node = { name = node }
		end
		if def and def.tiles and def.tiles[1] then
			texture = def.tiles[1]
		end

		-- do not break obsidian or diamond blocks or unbreakable nodes
		if (def.groups and def.groups.level and def.groups.level > 1)
		or def.groups.unbreakable then
			return
		end

		minetest.add_particlespawner({
			amount = 32,
			time = 0.1,
			minpos = vector.subtract(pos, radius / 2),
			maxpos = vector.add(pos, radius / 2),
			minvel = {x = -3, y = 0, z = -3},
			maxvel = {x = 3, y = 5,  z = 3},
			minacc = {x = 0, y = -10, z = 0},
			maxacc = {x = 0, y = -10, z = 0},
			minexptime = 0.8,
			maxexptime = 2.0,
			minsize = radius * 0.33,
			maxsize = radius,
			texture = texture,
			-- ^ only as fallback for clients without support for `node` parameter
			node = node,
			collisiondetection = true,
		})

		minetest.set_node(pos, {name = "air"})

		local snd = def.sounds and def.sounds.dug or "default_dig_crumbly"

		minetest.sound_play(snd, {pos = pos, max_hear_distance = 12, gain = 1.0}, true)
	end
})
