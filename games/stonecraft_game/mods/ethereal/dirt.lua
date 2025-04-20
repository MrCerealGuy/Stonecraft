
local S = minetest.get_translator("ethereal")

local math_random = math.random

-- override default dirt (to stop caves cutting away dirt)

minetest.override_item("default:dirt", {is_ground_content = ethereal.cavedirt})

-- replace old green_dirt with default grass

minetest.register_alias("ethereal:green_dirt", "default:dirt_with_grass")

-- dry dirt

minetest.register_node("ethereal:dry_dirt", {
	description = S("Dried Dirt"),
	tiles = {"ethereal_dry_dirt.png"},
	is_ground_content = ethereal.cavedirt,
	groups = {crumbly = 3},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	type = "cooking",
	output = "ethereal:dry_dirt",
	recipe = "default:dirt",
	cooktime = 3
})

-- ethereal dirt types

local dirts = {
	"Bamboo", "Jungle", "Grove", "Prairie", "Cold", "Crystal", "Mushroom", "Fiery", "Gray"
}

-- loop through and register dirts

for n = 1, #dirts do

	local desc = dirts[n]
	local name = desc:lower()

	minetest.register_node("ethereal:" .. name .. "_dirt", {
		description = S(desc .. " Dirt"),
		tiles = {
			"ethereal_grass_" .. name .. "_top.png", "default_dirt.png",
			{
				name = "default_dirt.png^ethereal_grass_" .. name .. "_side.png",
				tileable_vertical = false
			}
		},
		is_ground_content = ethereal.cavedirt,
		groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
		soil = {
			base = "ethereal:" .. name .. "_dirt",
			dry = "farming:soil",
			wet = "farming:soil_wet"
		},
		drop = "default:dirt",
		sounds = default.node_sound_dirt_defaults({
			footstep = {name = "default_grass_footstep", gain = 0.25}
		})
	})
end

-- flower spread, also crystal and fire flower regeneration

local function flower_spread(pos, node)

	if (minetest.get_node_light(pos) or 0) < 13 then return end

	local pos0 = {x = pos.x - 4, y = pos.y - 2, z = pos.z - 4}
	local pos1 = {x = pos.x + 4, y = pos.y + 2, z = pos.z + 4}
	local num = #minetest.find_nodes_in_area(pos0, pos1, "group:flora")

	-- stop flowers spreading too much just below top of map block
	if minetest.find_node_near(pos, 2, "ignore") then return end

	if num > 3 and node.name == "ethereal:crystalgrass" then

		local grass = minetest.find_nodes_in_area_under_air(
			pos0, pos1, {"ethereal:crystalgrass"})

		if #grass > 4
		and not minetest.find_node_near(pos, 4, {"ethereal:crystal_spike"}) then

			pos = grass[math_random(#grass)]

			pos.y = pos.y - 1

			if minetest.get_node(pos).name == "ethereal:crystal_dirt" then

				pos.y = pos.y + 1

				minetest.swap_node(pos, {name = "ethereal:crystal_spike"})
			end
		end

		return

	elseif num > 3 and node.name == "ethereal:dry_shrub" then

		local grass = minetest.find_nodes_in_area_under_air(
			pos0, pos1, {"ethereal:dry_shrub"})

		if #grass > 8
		and not minetest.find_node_near(pos, 4, {"ethereal:fire_flower"}) then

			pos = grass[math_random(#grass)]

			pos.y = pos.y - 1

			if minetest.get_node(pos).name == "ethereal:fiery_dirt" then

				pos.y = pos.y + 1

				minetest.swap_node(pos, {name = "ethereal:fire_flower"})
			end
		end

		return

	elseif num > 3 then
		return
	end

	pos.y = pos.y - 1

	local under = minetest.get_node(pos)

	-- make sure we have soil underneath
	if minetest.get_item_group(under.name, "soil") == 0
	or under.name == "default:desert_sand" then
		return
	end

	local seedling = minetest.find_nodes_in_area_under_air(pos0, pos1, {under.name})

	if #seedling > 0 then

		pos = seedling[math_random(#seedling)]

		pos.y = pos.y + 1

		if (minetest.get_node_light(pos) or 0) < 13 then return end

		minetest.swap_node(pos, {name = node.name})
	end
end

-- grow papyrus up to 4 high and bamboo up to 8 high

local function grow_papyrus(pos, node)

	local oripos = pos.y
	local high = 4

	pos.y = pos.y - 1

	local nod = minetest.get_node_or_nil(pos)

	if not nod
	or minetest.get_item_group(nod.name, "soil") < 1
	or minetest.find_node_near(pos, 3, {"group:water"}) == nil then return end

	if node.name == "ethereal:bamboo" then high = 8 end

	pos.y = pos.y + 1

	local height = 0

	while height < high and minetest.get_node(pos).name == node.name do
		height = height + 1
		pos.y = pos.y + 1
	end

	nod = minetest.get_node_or_nil(pos)

	if nod and nod.name == "air" and height < high then

		if node.name == "ethereal:bamboo" and height == (high - 1) then

			ethereal.grow_bamboo_tree({x = pos.x, y = oripos, z = pos.z})
		else
			minetest.swap_node(pos, {name = node.name})
		end
	end

end

-- override gros cactus function

function default.grow_cactus(pos, node)

	if node.param2 >= 4 then return end

	pos.y = pos.y - 1

	if minetest.get_item_group(minetest.get_node(pos).name, "sand") == 0 then
		return
	end

	pos.y = pos.y + 1

	local height = 0

	while node.name == "default:cactus" and height < 4 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end

	if height == 4 or node.name ~= "air" then return end

	if minetest.get_node_light(pos) < 13 then return end

	if math.random(100 - (height * 15)) == 1 then
		minetest.set_node(pos, {name = "ethereal:cactus_flower"})
	else
		minetest.set_node(pos, {name = "default:cactus"})
	end

	return true
end

-- override abm function

local function override_abm(name, redef)

	if not name or not redef then return end

	for _, ab in pairs(minetest.registered_abms) do

		if name == ab.label then

			for k, v in pairs(redef) do
				ab[k] = v
			end

			return ab
		end
	end
end

override_abm("Flower spread", {
--interval = 1, chance = 1, -- testing only
	chance = 96, -- moved back to original chance from 300
	nodenames = {"group:flora"},
	neighbors = {"group:soil"},
	action = flower_spread
})

override_abm("Grow papyrus", {
--interval = 2, chance = 1, -- testing only
	nodenames = {"default:papyrus", "ethereal:bamboo"},
	neighbors = {"group:soil"},
	action = grow_papyrus
})

override_abm("Mushroom spread", {
--interval = 1, chance = 1, -- testing only
	chance = 50, -- moved back to original chance from 150
	nodenames = {"group:mushroom"}
})

-- Add Red, Orange and Grey baked clay if mod isn't active

if not minetest.get_modpath("bakedclay") then

	minetest.register_node(":bakedclay:red", {
		description = S("Red Baked Clay"),
		tiles = {"baked_clay_red.png"},
		groups = {cracky = 3, bakedclay = 1},
		is_ground_content = ethereal.cavedirt,
		sounds = default.node_sound_stone_defaults()
	})

	minetest.register_node(":bakedclay:orange", {
		description = S("Orange Baked Clay"),
		tiles = {"baked_clay_orange.png"},
		groups = {cracky = 3, bakedclay = 1},
		is_ground_content = ethereal.cavedirt,
		sounds = default.node_sound_stone_defaults()
	})

	minetest.register_node(":bakedclay:grey", {
		description = S("Grey Baked Clay"),
		tiles = {"baked_clay_grey.png"},
		groups = {cracky = 3, bakedclay = 1},
		is_ground_content = ethereal.cavedirt,
		sounds = default.node_sound_stone_defaults()
	})

	minetest.register_node(":bakedclay:brown", {
		description = S("Brown Baked Clay"),
		tiles = {"baked_clay_brown.png"},
		groups = {cracky = 3, bakedclay = 1},
		is_ground_content = ethereal.cavedirt,
		sounds = default.node_sound_stone_defaults()
	})
end

-- Quicksand (new style, sinking inside shows yellow effect

minetest.register_node("ethereal:quicksand2", {
	description = S("Quicksand"),
	tiles = {"default_sand.png^[colorize:#00004F10"},
	drawtype = "glasslike",
	paramtype = "light",
	drop = "default:sand",
	liquid_viscosity = 15,
	liquidtype = "source",
	liquid_alternative_flowing = "ethereal:quicksand2",
	liquid_alternative_source = "ethereal:quicksand2",
	liquid_renewable = false,
	liquid_range = 0,
	drowning = 1,
	walkable = false,
	climbable = false,
	post_effect_color = {r = 230, g = 210, b = 160, a = 245},
	groups = {crumbly = 3, sand = 1, liquid = 3, disable_jump = 1},
	sounds = default.node_sound_sand_defaults()
})

-- alias old quicksand to new

minetest.register_alias("ethereal:quicksand", "ethereal:quicksand2")

-- craft quicksand

minetest.register_craft({
	output = "ethereal:quicksand2",
	recipe = {
		{"group:sand", "group:sand", "group:sand"},
		{"group:sand", "bucket:bucket_water", "group:sand"},
		{"group:sand", "group:sand", "group:sand"}
	},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})

-- slime mold

minetest.register_node("ethereal:slime_mold", {
	description = S("Slime Mold"),
	drawtype = "raillike",
	paramtype = "light",
	tiles = {"ethereal_slime_mold.png"},
	inventory_image = "ethereal_slime_mold.png",
	wield_image = "ethereal_slime_mold.png",
	use_texture_alpha = "clip",
	walkable = false,
	buildable_to = true,
	floodable = true,
	drop = {},
	groups = {crumbly = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed", fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	}
})

-- how slime molds spread

minetest.register_abm({
	label = "Slime mold spread",
	nodenames = {"ethereal:slime_mold"},
	neighbors = {"ethereal:spore_grass", "ethereal:fire_flower"},
	interval = 15,
	chance = 4,
	catch_up = false,

	action = function(pos, node)

		if minetest.find_node_near(pos, 1, {"ethereal:fire_flower"}) then

			minetest.sound_play("fire_extinguish_flame",
					{pos = pos, gain = 0.05, max_hear_distance = 3}, true)

			minetest.remove_node(pos) ; return
		end

		local near = minetest.find_node_near(pos, 1, {"ethereal:spore_grass"})

		if near then

			minetest.sound_play("default_gravel_dug",
					{pos = near, gain = 0.3, max_hear_distance = 3}, true)

			minetest.set_node(near, {name = "ethereal:slime_mold"})
		end
	end
})

-- slime block

minetest.register_node("ethereal:slime_block", {
	description = S("Slime Block"),
	tiles = {"ethereal_slime_block.png"},
	inventory_image = minetest.inventorycube("ethereal_slime_block.png"),
	groups = {crumbly = 3, bouncy = 100, fall_damage_add_percent = -100, disable_jump = 1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_craft({
	output = "ethereal:slime_block",
	recipe = {
		{"ethereal:slime_mold", "ethereal:slime_mold", "ethereal:slime_mold"},
		{"ethereal:slime_mold", "ethereal:fire_dust", "ethereal:slime_mold"},
		{"ethereal:slime_mold", "ethereal:slime_mold", "ethereal:slime_mold"}
	}
})
