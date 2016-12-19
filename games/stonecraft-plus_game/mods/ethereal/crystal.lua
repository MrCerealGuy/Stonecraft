
local S = ethereal.intllib

-- Crystal Spike (Hurts if you touch it - thanks to ZonerDarkRevention for his DokuCraft DeviantArt crystal texture)
minetest.register_node("ethereal:crystal_spike", {
	description = S("Crystal Spike"),
	drawtype = "plantlike",
	tiles = { "crystal_spike.png" },
	inventory_image = "crystal_spike.png",
	wield_image = "crystal_spike.png",
	paramtype = "light",
	light_source = 7,
	sunlight_propagates = true,
	walkable = false,
	damage_per_second = 1,
	groups = {cracky = 1, falling_node = 1, puts_out_fire = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

-- Crystal Ingot
minetest.register_craftitem("ethereal:crystal_ingot", {
	description = S("Crystal Ingot"),
	inventory_image = "crystal_ingot.png",
	wield_image = "crystal_ingot.png",
})

minetest.register_craft({
	output = "ethereal:crystal_ingot",
	recipe = {
		{"default:mese_crystal", "ethereal:crystal_spike"},
		{"ethereal:crystal_spike", "default:mese_crystal"},
	}
})

-- Crystal Block
minetest.register_node("ethereal:crystal_block", {
	description = S("Crystal Block"),
	tiles = {"crystal_block.png"},
	light_source = 9,
	is_ground_content = false,
	groups = {cracky = 1, level = 2, puts_out_fire = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "ethereal:crystal_block",
	recipe = {
		{"ethereal:crystal_ingot", "ethereal:crystal_ingot", "ethereal:crystal_ingot"},
		{"ethereal:crystal_ingot", "ethereal:crystal_ingot", "ethereal:crystal_ingot"},
		{"ethereal:crystal_ingot", "ethereal:crystal_ingot", "ethereal:crystal_ingot"},
	}
})

minetest.register_craft({
	output = "ethereal:crystal_ingot 9",
	recipe = {
		{"ethereal:crystal_block"},
	}
})

-- Crystal Sword (Powerful wee beastie)
minetest.register_tool("ethereal:sword_crystal", {
	description = S("Crystal Sword"),
	inventory_image = "crystal_sword.png",
	wield_image = "crystal_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level = 1,
		groupcaps = {
			snappy = {
				times = {[1] = 1.70, [2] = 0.70, [3] = 0.25},
				uses = 50,
				maxlevel = 3
			},
		},
		damage_groups = {fleshy = 10},
	}
})

minetest.register_craft({
	output = "ethereal:sword_crystal",
	recipe = {
		{"ethereal:crystal_ingot"},
		{"ethereal:crystal_ingot"},
		{"default:steel_ingot"},
	}
})

-- Crystal Axe
minetest.register_tool("ethereal:axe_crystal", {
	description = S("Crystal Axe"),
	inventory_image = "crystal_axe.png",
	wield_image = "crystal_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level = 1,
		groupcaps = {
			choppy = {
				times = {[1] = 2.00, [2] = 0.80, [3] = 0.40},
				uses = 30,
				maxlevel = 2
			},
		},
		damage_groups = {fleshy = 7},
	},
})

minetest.register_craft({
	output = 'ethereal:axe_crystal',
	recipe = {
		{'ethereal:crystal_ingot', 'ethereal:crystal_ingot'},
		{'ethereal:crystal_ingot', 'default:steel_ingot'},
		{'', 'default:steel_ingot'},
	}
})

-- Crystal Pick (This will last a while)
minetest.register_tool("ethereal:pick_crystal", {
	description = S("Crystal Pickaxe"),
	inventory_image = "crystal_pick.png",
	wield_image = "crystal_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level = 3,
		groupcaps={
			cracky = {
				times = {[1] = 1.8, [2] = 0.8, [3] = 0.40},
				uses = 40,
				maxlevel = 3
			},
		},
		damage_groups = {fleshy = 7},
	},
})

minetest.register_craft({
	output = "ethereal:pick_crystal",
	recipe = {
		{"ethereal:crystal_ingot", "ethereal:crystal_ingot", "ethereal:crystal_ingot"},
		{"", "default:steel_ingot", ""},
		{"", "default:steel_ingot", ""},
	}
})

-- Crystal Shovel (with Soft Touch so player can dig up dirt with grass intact)
minetest.register_tool("ethereal:shovel_crystal", {
	description = S("Crystal (soft touch) Shovel"),
	inventory_image = "crystal_shovel.png",
	wield_image = "crystal_shovel.png^[transformR90",

	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		-- Check if node protected
		if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
			return
		end

		local pos = pointed_thing.under
		local nn = minetest.get_node(pos).name

		-- Is node dirt, sand or gravel
		if minetest.get_item_group(nn, "crumbly") > 0 then

			local inv = user:get_inventory()

			minetest.remove_node(pointed_thing.under)

			nodeupdate(pos)

			inv:add_item("main", {name = nn})
			itemstack:add_wear(65535 / 100) -- 111 uses

			minetest.sound_play("default_dirt_footstep", {pos = pos, gain = 0.35})

			return itemstack
		end
	end,
})

minetest.register_craft({
	output = "ethereal:shovel_crystal",
	recipe = {
		{"ethereal:crystal_ingot"},
		{"default:steel_ingot"},
		{"default:steel_ingot"},
	}
})

-- Crystal Gilly Staff (replenishes air supply when used)
minetest.register_tool("ethereal:crystal_gilly_staff", {
	description = S("Crystal Gilly Staff"),
	inventory_image = "crystal_gilly_staff.png",
	wield_image = "crystal_gilly_staff.png",

	on_use = function(itemstack, user, pointed_thing)
		if user:get_breath() < 10 then
			user:set_breath(10)
		end
	end,
})

minetest.register_craft({
	output = "ethereal:crystal_gilly_staff",
	recipe = {
		{"ethereal:green_moss", "ethereal:gray_moss", "ethereal:fiery_moss"},
		{"ethereal:crystal_moss", "ethereal:crystal_ingot", "ethereal:mushroom_moss"},
		{"", "ethereal:crystal_ingot", ""},
	}
})
