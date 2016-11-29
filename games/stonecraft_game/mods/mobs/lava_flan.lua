
-- Lava Flan by Zeg9 (additional textures by JurajVajda)

mobs:register_mob("mobs:lava_flan", {
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
	water_damage = 5,
	lava_damage = 0,
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
	},
	on_die = function(self, pos)
		minetest.set_node(pos, {name = "fire:basic_flame"})
	end,
})

mobs:register_spawn("mobs:lava_flan", {"default:lava_source"}, 15, 0, 1000, 3, 0)

mobs:register_egg("mobs:lava_flan", "Lava Flan", "default_lava.png", 1)

-- lava orb
minetest.register_craftitem("mobs:lava_orb", {
	description = "Lava orb",
	inventory_image = "zmobs_lava_orb.png",
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
					count = stack:get_count()
				})
			)

		else -- if not then return normal drops
			table.insert(hot_drops, stack)
		end
	end

	return old_handle_node_drops(pos, hot_drops, digger)
end

minetest.register_tool("mobs:pick_lava", {
	description = "Lava Pickaxe",
	inventory_image = "mobs_pick_lava.png",
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.80, [2]=0.90, [3]=0.45}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_craft({
	output = "mobs:pick_lava",
	recipe = {
		{"mobs:lava_orb", "mobs:lava_orb", "mobs:lava_orb"},
		{"", "default:obsidian_shard", ""},
		{"", "default:obsidian_shard", ""},
	}
})
