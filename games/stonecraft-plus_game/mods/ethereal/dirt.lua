
local S = ethereal.intllib

-- override default dirt (to stop caves cutting away dirt)
minetest.override_item("default:dirt", {is_ground_content = ethereal.cavedirt})

-- green dirt
minetest.register_node("ethereal:green_dirt", {
	description = S("Green Dirt"),
	tiles = {
		"default_grass.png",
		"default_dirt.png",
		"default_dirt.png^default_grass_side.png"
	},
	is_ground_content = ethereal.cavedirt,
	groups = {crumbly = 3, soil = 1, ethereal_grass = 1},
	soil = {
		base = "ethereal:green_dirt",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults()
})

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
	cooktime = 3,
})

local dirts = {
	"Bamboo", "Jungle", "Grove", "Prairie", "Cold",
	"Crystal", "Mushroom", "Fiery", "Gray"
}

for n = 1, #dirts do

	local desc = dirts[n]
	local name = desc:lower()

	minetest.register_node("ethereal:"..name.."_dirt", {
		description = S(desc.." Dirt"),
		tiles = {
			"ethereal_grass_"..name.."_top.png",
			"default_dirt.png",
			"default_dirt.png^ethereal_grass_"..name.."_side.png"
		},
		is_ground_content = ethereal.cavedirt,
		groups = {crumbly = 3, soil = 1, ethereal_grass = 1},
		soil = {
			base = "ethereal:"..name.."_dirt",
			dry = "farming:soil",
			wet = "farming:soil_wet"
		},
		drop = "default:dirt",
		sounds = default.node_sound_dirt_defaults()
	})

end

-- re-register dirt types for abm
dirts = {
	"ethereal:bamboo_dirt", "ethereal:jungle_dirt", "ethereal:grove_dirt",
	"ethereal:prairie_dirt", "ethereal:cold_dirt", "ethereal:crystal_dirt",
	"ethereal:mushroom_dirt", "ethereal:fiery_dirt", "ethereal:gray_dirt",
	"default:dirt_with_grass", "default:dirt_with_dry_grass", "ethereal:green_dirt",
	"default:dirt_with_snow", "default:dirt_with_dry_grass"
}

-- check surrounding grass and change dirt to same colour
local grass_spread = function(pos, node)

	-- not enough light
	local above = {x = pos.x, y = pos.y + 1, z = pos.z}

	if (minetest.get_node_light(above) or 0) < 13 then
		return
	end

	-- water above grass
	local name = minetest.get_node(above).name
	local def = minetest.registered_nodes[name]

	if name == "ignore" or not def or def.liquidtype ~= "none" then
		return
	end

	local curr_max, curr_type, num  = 0, ""

	-- find all default and ethereal grasses in area around dirt
	local positions, grasses = minetest.find_nodes_in_area(
		{x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
		{x = pos.x + 1, y = pos.y + 2, z = pos.z + 1},
		{"group:ethereal_grass", "default:dirt_with_grass",
		"default:dirt_with_dry_grass", "default:dirt_with_snow"})

	-- count new grass nodes
	for n = 1, #dirts do

		num = grasses[ dirts[n] ] or 0

		if num > curr_max then
			curr_max = num
			curr_type = dirts[n]
		end
	end

	-- no grass nearby, keep as dirt
	if curr_type == "" then
		return
	end

	-- change default green grass to ethereal green grass
	if curr_type == "default:dirt_with_grass" then
		curr_type = "ethereal:green_dirt"
	end

	minetest.swap_node(pos, {name = curr_type})
end

-- any grass with a block above will turn into dirt
local grass_devoid = function(pos, node)

	local above = {x = pos.x, y = pos.y + 1, z = pos.z}
	local name = minetest.get_node(above).name
	local nodedef = minetest.registered_nodes[name]

	if name ~= "ignore" and nodedef and not ((nodedef.sunlight_propagates or
			nodedef.paramtype == "light") and
			nodedef.liquidtype == "none") then

		minetest.swap_node(pos, {name = "default:dirt"})
	end
end

-- flower spread, also crystal and fire flower regeneration
local flower_spread = function(pos, node)

	if (minetest.get_node_light(pos) or 0) < 13 then
		return
	end

	local pos0 = {x = pos.x - 4, y = pos.y - 2, z = pos.z - 4}
	local pos1 = {x = pos.x + 4, y = pos.y + 2, z = pos.z + 4}

	local num = #minetest.find_nodes_in_area_under_air(pos0, pos1, "group:flora")

	if num > 3
	and node.name == "ethereal:crystalgrass" then

		local grass = minetest.find_nodes_in_area_under_air(
			pos0, pos1, {"ethereal:crystalgrass"})

		if #grass > 4
		and not minetest.find_node_near(pos, 4, {"ethereal:crystal_spike"}) then

			pos = grass[math.random(#grass)]

			pos.y = pos.y - 1

			if minetest.get_node(pos).name == "ethereal:crystal_dirt" then

				pos.y = pos.y + 1

				minetest.swap_node(pos, {name = "ethereal:crystal_spike"})
			end
		end

		return

	elseif num > 3
	and node.name == "ethereal:dry_shrub" then

		local grass = minetest.find_nodes_in_area_under_air(
			pos0, pos1, {"ethereal:dry_shrub"})

		if #grass > 8
		and not minetest.find_node_near(pos, 4, {"ethereal:fire_flower"}) then

			pos = grass[math.random(#grass)]

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

	local seedling = minetest.find_nodes_in_area_under_air(
		pos0, pos1, {"group:soil"})

	if #seedling > 0 then

		pos = seedling[math.random(#seedling)]

		-- default farming has desert sand as soil, so dont spread on this
		if minetest.get_node(pos).name == "default:desert_sand" then
			return
		end

		pos.y = pos.y + 1

		if (minetest.get_node_light(pos) or 0) < 13 then
			return
		end

		minetest.swap_node(pos, {name = node.name})
	end
end

-- grow papyrus up to 4 high and bamboo up to 8 high
local grow_papyrus = function(pos, node)

	local oripos = pos.y
	local high = 4

	pos.y = pos.y - 1

	local nod = minetest.get_node_or_nil(pos)

	if not nod
	or minetest.get_item_group(nod.name, "soil") < 1
	or minetest.find_node_near(pos, 3, {"group:water"}) == nil then
		return
	end

	if node.name == "ethereal:bamboo" then
		high = 8
	end

	pos.y = pos.y + 1

	local height = 0

	while height < high
	and minetest.get_node(pos).name == node.name do
		height = height + 1
		pos.y = pos.y + 1
	end

	nod = minetest.get_node_or_nil(pos)

	if nod
	and nod.name == "air"
	and height < high then

		if node.name == "ethereal:bamboo"
		and height == (high - 1) then

			ethereal.grow_bamboo_tree({x = pos.x, y = oripos, z = pos.z})
		else
			minetest.swap_node(pos, {name = node.name})
		end
	end

end

-- loop through active abm's
for _, ab in pairs(minetest.registered_abms) do

	local label = ab.label or ""
	local node1 = ab.nodenames and ab.nodenames[1] or ""
	local node2 = ab.nodenames and ab.nodenames[2] or ""
	local neigh = ab.neighbors and ab.neighbors[1] or ""

	-- find dirt to grass abm and replace with spread function
	if label == "Grass spread"
	or (node1 == "default:dirt"
	and neigh == "default:dirt_with_grass") then

		--ab.interval = 2
		--ab.chance = 1
		ab.nodenames = {"default:dirt_with_grass", "default:dirt"}
		ab.neighbors = {"air"}
		ab.action = grass_spread

	-- find grass devoid of light to dirt abm and change to devoid function
	elseif label == "Grass covered"
	or (node1 == "default:dirt_with_grass"
	and node2 == "default:dirt_with_dry_grass") then

		--ab.interval = 2
		--ab.chance = 1
		ab.nodenames = {
			"default:dirt_with_grass", "default:dirt_with_dry_grass",
			"default:dirt_with_snow", "group:ethereal_grass"
		}
		ab.action = grass_devoid

	-- find flower spread abm and change to spread function
	elseif label == "Flower spread"
	or node1 == "group:flora" then

		--ab.interval = 1
		--ab.chance = 1
		ab.nodenames = {"group:flora"}
		ab.neighbors = {"group:soil"}
		ab.action = flower_spread

	-- find grow papyrus abm and change to grow_papyrus function
	elseif label == "Grow papyrus"
	or node1 == "default:papyrus" then

		--ab.interval = 2
		--ab.chance = 1
		ab.nodenames = {"default:papyrus", "ethereal:bamboo"}
		ab.neighbors = {"group:soil"}
		ab.action = grow_papyrus
	end
end

-- If Baked Clay mod not active, make Red, Orange and Grey nodes
if not minetest.get_modpath("bakedclay") then

	minetest.register_node(":bakedclay:red", {
		description = S("Red Baked Clay"),
		tiles = {"baked_clay_red.png"},
		groups = {cracky = 3},
		is_ground_content = ethereal.cavedirt,
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node(":bakedclay:orange", {
		description = S("Orange Baked Clay"),
		tiles = {"baked_clay_orange.png"},
		groups = {cracky = 3},
		is_ground_content = ethereal.cavedirt,
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node(":bakedclay:grey", {
		description = S("Grey Baked Clay"),
		tiles = {"baked_clay_grey.png"},
		groups = {cracky = 3},
		is_ground_content = ethereal.cavedirt,
		sounds = default.node_sound_stone_defaults(),
	})

end

-- Quicksand (old style, sinking inside shows black instead of yellow effect,
-- works ok with noclip enabled though)
minetest.register_node("ethereal:quicksand", {
	description = S("Quicksand"),
	tiles = {"default_sand.png"},
	drop = "default:sand",
	liquid_viscosity = 15,
	liquidtype = "source",
	liquid_alternative_flowing = "ethereal:quicksand",
	liquid_alternative_source = "ethereal:quicksand",
	liquid_renewable = false,
	liquid_range = 0,
	drowning = 1,
	walkable = false,
	climbable = false,
	post_effect_color = {r = 230, g = 210, b = 160, a = 245},
	groups = {crumbly = 3, sand = 1, liquid = 3, disable_jump = 1},
	sounds = default.node_sound_sand_defaults(),
})

-- Quicksand (new style, sinking inside shows yellow effect with or without noclip,
-- but old quicksand is shown as black until block placed nearby to update light)
minetest.register_node("ethereal:quicksand2", {
	description = S("Quicksand"),
	tiles = {"default_sand.png"},
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
	sounds = default.node_sound_sand_defaults(),
})
