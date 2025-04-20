
local S = minetest.get_translator("ethereal")

-- local math functions

local math_floor, math_max, math_random = math.floor, math.max, math.random

-- Seaweed

minetest.register_node("ethereal:seaweed", {
	description = S("Seaweed"),
	drawtype = "plantlike",
	tiles = {"ethereal_seaweed.png"},
	inventory_image = "ethereal_seaweed.png",
	wield_image = "ethereal_seaweed.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	selection_box = {
		type = "fixed", fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {food_seaweed = 1, snappy = 3},
	on_use = minetest.item_eat(1),
	sounds = default.node_sound_leaves_defaults(),

	on_place = function(itemstack, placer, pointed_thing)

		local pname = placer:get_player_name()
		local pos = pointed_thing.above
		local pos_up = {x = pos.x, y = pos.y + 1, z = pos.z}
		local pos_down = {x = pos.x, y = pos.y - 1, z = pos.z}
		local def_up = minetest.registered_nodes[minetest.get_node(pos_up).name] or {}
		local def_down = minetest.registered_nodes[minetest.get_node(pos_down).name] or {}

		if def_up.liquidtype == nil or def_up.liquidtype ~= "none" then

			if minetest.is_protected(pos, pname) then return end

			if def_down.name ~= "default:sand" and def_down.name ~= "ethereal:sandy" then
				return
			end

			if minetest.get_node(pos_up).name == "default:water_source" then

				minetest.set_node(pos_down, {name = "ethereal:seaweed_rooted",
						param2 = 16})

				if not ethereal.check_creative(pname) then
					itemstack:take_item()
				end
			end

			return itemstack
		end

		return minetest.item_place_node(itemstack, placer, pointed_thing)
	end
})

ethereal.add_eatable("ethereal:seaweed", 1)

-- seaweed rooted in sand

minetest.register_node("ethereal:seaweed_rooted", {
	description = S("Seaweed"),
	drop = "ethereal:seaweed",
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "ethereal_seaweed.png", tileable_vertical = true}},
	inventory_image = "ethereal_seaweed.png",
	wield_image = "ethereal_seaweed.png",
	paramtype = "light",
	paramtype2 = "leveled",
	light_source = 3,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, {-2/16, 0.5, -2/16, 2/16, 3.5, 2/16},
		},
	},
	node_dig_prediction = "default:sand",
	node_placement_prediction = "",
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {food_seaweed = 1, snappy = 3, flammable = 3, not_in_creative_inventory = 1},
	on_use = minetest.item_eat(1),
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		minetest.set_node(pos, {name = "default:sand"})
	end,

	on_place = function(itemstack, placer, pointed_thing) -- do not place rooted seaweed
		return itemstack
	end,

	on_dig = function(pos, node, digger)

		local p2 = node.param2 or 16
		local num = math_max(1, math_floor(p2 / 16))
		local inv = digger and digger:get_inventory()

		if not inv then return end

		local stack = ItemStack("ethereal:seaweed " .. tonumber(num))
		local leftover = inv:add_item("main", stack)
		local count = leftover:get_count()

		minetest.set_node(pos, {name = "default:sand"})

		if count > 0 then
			pos.y = pos.y + 1
			minetest.add_item(pos, "ethereal:seaweed " .. tonumber(count))
		end
	end
})

-- update old style seaweed nodes to new

minetest.register_lbm({
	label = "[ethereal] Upgrade seaweed",
	name = "ethereal:upgrade_seaweed",
	nodenames = {"ethereal:seaweed"},
	run_at_every_load = false,

	action = function(pos, node)

		local pos_up = {x = pos.x, y = pos.y + 1, z = pos.z}
		local pos_down = {x = pos.x, y = pos.y - 1, z = pos.z}
		local def_up = minetest.registered_nodes[minetest.get_node(pos_up).name] or {}
		local def_down = minetest.registered_nodes[minetest.get_node(pos_down).name] or {}

		if def_down.name == "default:sand" or def_down.name == "ethereal:sandy" then

			local height = 0

			while height < 14 and minetest.get_node(pos_up).name == "ethereal:seaweed" do
				minetest.remove_node(pos_up)
				height = height + 1
				pos_up.y = pos_up.y + 1
			end

			minetest.remove_node(pos)

			minetest.set_node(pos_down, {name = "ethereal:seaweed_rooted",
					param2 = (height + 1) * 16})
		end
	end
})

-- seaweed to dark green dye

minetest.register_craft( {
	output = "dye:dark_green 3",
	recipe = {{"ethereal:seaweed"}}
})


-- coral on_place helper function

local coral_nodes = {}

local function register_coral(name, description, texture)

	local function plantlike_on_place(itemstack, placer, pointed_thing)

		local pname = placer:get_player_name()
		local pos = pointed_thing.above
		local pos_up = {x = pos.x, y = pos.y + 1, z = pos.z}
		local pos_down = {x = pos.x, y = pos.y - 1, z = pos.z}
		local def_up = minetest.registered_nodes[minetest.get_node(pos_up).name] or {}
		local def_down = minetest.registered_nodes[minetest.get_node(pos_down).name] or {}

		if def_up.liquidtype == nil or def_up.liquidtype ~= "none" then

			if minetest.is_protected(pos, pname) then return end

			if def_down.name ~= "default:sand"and def_down.name ~= "ethereal:sandy" then
				return
			end

			minetest.set_node(pos_down, {name = "ethereal:" .. name .. "_rooted"})

			if not ethereal.check_creative(pname) then
				itemstack:take_item()
			end

			return itemstack
		end

		return minetest.item_place_node(itemstack, placer, pointed_thing)
	end

	local function rooted_on_dig(pos, node, digger)

		local res = minetest.node_dig(pos, node, digger)

		if res == true then
			minetest.set_node(pos, {name = "default:sand"})
		end

		return res
	end

	-- decorative coral node
	minetest.register_node("ethereal:" .. name, {
		description = description,
		drawtype = "plantlike",
		tiles = {texture},
		inventory_image = texture,
		wield_image = texture,
		paramtype = "light",
		selection_box = {
			type = "fixed", fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 1 / 4, 6 / 16}
		},
		light_source = 3,
		groups = {snappy = 3},
		sounds = default.node_sound_leaves_defaults(),
		on_place = plantlike_on_place
	})

	-- coral node rooted in sand
	minetest.register_node("ethereal:" .. name .. "_rooted", {
		description = description,
		drop = "ethereal:" .. name,
		drawtype = "plantlike_rooted",
		tiles = {"default_sand.png"},
		special_tiles = {{name = texture, tileable_vertical = true}},
		inventory_image = texture,
		wield_image = texture,
		paramtype = "light",
		selection_box = {
			type = "fixed", fixed = {-6 / 16, 0.5, -6 / 16, 6 / 16, 1.25, 6 / 16}
		},
		light_source = 3,
		groups = {snappy = 3, not_in_creative_inventory = 1},
		sounds = default.node_sound_leaves_defaults(),
		on_dig = rooted_on_dig
	})

	table.insert(coral_nodes, "ethereal:" .. name)
end

-- update old style coral to new

minetest.register_lbm({
	label = "[ethereal] Upgrade corals",
	name = "ethereal:upgrade_corals",
	nodenames = coral_nodes,
	run_at_every_load = false,

	action = function(pos, node)

		local pos_up = {x = pos.x, y = pos.y + 1, z = pos.z}
		local pos_down = {x = pos.x, y = pos.y - 1, z = pos.z}
		local def_up = minetest.registered_nodes[minetest.get_node(pos_up).name] or {}
		local def_down = minetest.registered_nodes[minetest.get_node(pos_down).name] or {}

		if (def_up.liquidtype == nil or def_up.liquidtype ~= "none")
		and (def_down.name == "default:sand" or def_down.name == "ethereal:sandy") then

			minetest.set_node(pos_down, {name = node.name .. "_rooted"})

			minetest.remove_node(pos)
		end
	end
})

-- Blua Coral

register_coral("coral2", S("Blue Glow Coral"), "ethereal_coral_blue.png")

minetest.register_craft({output = "dye:cyan 3", recipe = {{"ethereal:coral2"}}})

-- Orange Coral

register_coral("coral3", S("Orange Glow Coral"), "ethereal_coral_orange.png")

minetest.register_craft({output = "dye:orange 3", recipe = {{"ethereal:coral3"}}})

-- Pink Coral

register_coral("coral4", S("Pink Glow Coral"), "ethereal_coral_pink.png")

minetest.register_craft({output = "dye:pink 3", recipe = {{"ethereal:coral4"}}})

-- Green Coral

register_coral("coral5", S("Green Glow Coral"), "ethereal_coral_green.png")

minetest.register_craft({output = "dye:green 3", recipe = {{"ethereal:coral5"}}})

-- Undersea Sand (used for growing seaweed and corals)

minetest.register_node("ethereal:sandy", {
	description = S("Sandy"),
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {
		crumbly = 3, falling_node = 1, sand = 1, not_in_creative_inventory = 1
	},
	drop = "default:sand",
	sounds = default.node_sound_sand_defaults()
})

minetest.register_craft({
	output = "ethereal:sandy",
	recipe = {
		{"ethereal:slime_mold", "ethereal:slime_mold", "ethereal:slime_mold"},
		{"ethereal:slime_mold", "group:sand", "ethereal:slime_mold"},
		{"ethereal:slime_mold", "ethereal:slime_mold", "ethereal:slime_mold"},
	}
})

-- randomly generate coral or seaweed and have seaweed grow up to 14 high

if ethereal.sealife == 1 then

	minetest.register_abm({
		label = "Grow coral/seaweed",
		nodenames = {"ethereal:sandy", "ethereal:seaweed_rooted"},
		neighbors = {"group:water"},
		interval = 15,
		chance = 10,
		catch_up = false,

		action = function(pos, node)

			-- grow new seaweed using param2 values
			if node.name == "ethereal:seaweed_rooted" then

				local p2 = node.param2 or 16
				local height = math_max(1, math_floor(p2 / 16))

				if height > 13 then return end

				height = height + 1

				local tpos = {x = pos.x, y = pos.y + height + 1, z = pos.z}

				if minetest.get_node(tpos).name ~= "default:water_source" then
					return
				end

				minetest.set_node(pos, {name = "ethereal:seaweed_rooted",
						param2 = (height * 16)})

				return
			end

			local sel = math_random(6)
			local pos_up = {x = pos.x, y = pos.y + 1, z = pos.z}
			local nod = minetest.get_node(pos_up).name

			if nod == "default:water_source" then

				if sel == 1 then

					local height = math_random(6)

					minetest.set_node(pos, {name = "ethereal:seaweed_rooted",
							param2 = (height * 16)})

				elseif sel == 6 then

					minetest.set_node(pos_up, {name = "ethereal:sponge_wet"})

				elseif sel > 1 then

					minetest.set_node(pos, {name = "ethereal:coral" .. sel .. "_rooted"})
				end
			end
		end
	})
end

-- sponge nodes (place dry sponge to suck up all water surrounding it, cook to dry)

minetest.register_node("ethereal:sponge_air", {
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	pointable = false,
	drop = "",
	groups = {not_in_creative_inventory = 1}
})

minetest.register_node("ethereal:sponge_wet", {
	description = S("Wet sponge"),
	tiles = {"ethereal_sponge_wet.png"},
	groups = {crumbly = 3},
	sounds = default.node_sound_sand_defaults()
})

minetest.register_node("ethereal:sponge", {
	description = S("Sponge"),
	tiles = {"ethereal_sponge.png"},
	groups = {crumbly = 3},
	sounds = default.node_sound_sand_defaults(),

	after_place_node = function(pos, placer, itemstack, pointed_thing)

		-- get player name
		local name = placer:get_player_name()

		-- is area protected
		if minetest.is_protected(pos, name) then return end

		-- get water nodes within range
		local num = minetest.find_nodes_in_area(
				{x = pos.x - 3, y = pos.y - 3, z = pos.z - 3},
				{x = pos.x + 3, y = pos.y + 3, z = pos.z + 3}, {"group:water"})

		-- no water
		if #num == 0 then return end

		-- replace water nodes with sponge air
		for _, w in pairs(num) do

			if not minetest.is_protected(pos, name) then
				minetest.set_node(w, {name = "ethereal:sponge_air"})
			end
		end

		-- replace dry sponge with wet sponge
		minetest.set_node(pos, {name = "ethereal:sponge_wet"})
	end
})

-- cook wet sponge into dry sponge

minetest.register_craft({
	type = "cooking",
	recipe = "ethereal:sponge_wet",
	output = "ethereal:sponge",
	cooktime = 3
})

-- use leaf decay to remove sponge air nodes

default.register_leafdecay({
	trunks = {"ethereal:sponge_wet"},
	leaves = {"ethereal:sponge_air"},
	radius = 3
})

-- dry sponges can be used as fuel

minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:sponge",
	burntime = 5
})
