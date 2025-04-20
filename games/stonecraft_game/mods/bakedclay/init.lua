
-- translation support

local S = minetest.get_translator("bakedclay")

-- list of clay colours

local clay = {
	{"natural", S("Natural")},
	{"white", S("White")},
	{"grey", S("Grey")},
	{"black", S("Black")},
	{"red", S("Red")},
	{"yellow", S("Yellow")},
	{"green", S("Green")},
	{"cyan", S("Cyan")},
	{"blue", S("Blue")},
	{"magenta", S("Magenta")},
	{"orange", S("Orange")},
	{"violet", S("Violet")},
	{"brown", S("Brown")},
	{"pink", S("Pink")},
	{"dark_grey", S("Dark Grey")},
	{"dark_green", S("Dark Green")}
}

-- check mod support

local techcnc_mod = minetest.get_modpath("technic_cnc")
local stairs_mod = minetest.get_modpath("stairs")
local stairsplus_mod = minetest.get_modpath("moreblocks")
		and minetest.global_exists("stairsplus")
local stairsplus_compat = minetest.settings:get_bool("stairsplus_clay_compatibility") ~= false

-- scroll through colours

for _, clay in pairs(clay) do

	-- register node

	minetest.register_node("bakedclay:" .. clay[1], {
		description = clay[2] .. " " .. S("Baked Clay"),
		tiles = {"baked_clay_" .. clay[1] ..".png"},
		groups = {cracky = 3, bakedclay = 1},
		sounds = default.node_sound_stone_defaults(),
		is_ground_content = false
	})

	-- register craft recipe

	if clay[1] ~= "natural" then

		minetest.register_craft({
			output = "bakedclay:" .. clay[1] .. " 8",
			recipe = {
				{"group:bakedclay", "group:bakedclay", "group:bakedclay"},
				{"group:bakedclay", "dye:" .. clay[1], "group:bakedclay"},
				{"group:bakedclay", "group:bakedclay", "group:bakedclay"}
			}
		})
	end

	-- stairs plus

	if stairsplus_mod then

		stairsplus:register_all("bakedclay", "baked_clay_" .. clay[1],
				"bakedclay:" .. clay[1], {
			description = clay[2] .. " " .. S("Baked Clay"),
			tiles = {"baked_clay_" .. clay[1] .. ".png"},
			groups = {cracky = 3},
			sounds = default.node_sound_stone_defaults()
		})

		if stairsplus_compat then

			stairsplus:register_alias_all("bakedclay", clay[1],
					"bakedclay", "baked_clay_" .. clay[1])

			minetest.register_alias("stairs:slab_bakedclay_".. clay[1],
					"bakedclay:slab_baked_clay_" .. clay[1])

			minetest.register_alias("stairs:stair_bakedclay_".. clay[1],
					"bakedclay:stair_baked_clay_" .. clay[1])
		end

	-- stairs redo

	elseif stairs_mod and stairs.mod then

		stairs.register_all("bakedclay_" .. clay[1], "bakedclay:" .. clay[1],
			{cracky = 3},
			{"baked_clay_" .. clay[1] .. ".png"},
			clay[2] .. " " .. S("Baked Clay"),
			default.node_sound_stone_defaults())

	-- default stairs

	elseif stairs_mod then

		stairs.register_stair_and_slab("bakedclay_".. clay[1], "bakedclay:".. clay[1],
			{cracky = 3},
			{"baked_clay_" .. clay[1] .. ".png"},
			clay[2] .. " " .. S("Baked Clay Stair"),
			clay[2] .. " " .. S("Baked Clay Slab"),
			default.node_sound_stone_defaults())
	end

	-- register bakedclay for use in technic_cnc mod after all mods loaded

	if techcnc_mod then

		minetest.register_on_mods_loaded(function()

			technic_cnc.register_all("bakedclay:" .. clay[1],
				{cracky = 3, not_in_creative_inventory = 1},
				{"baked_clay_" .. clay[1] .. ".png"},
				clay[2] .. " Baked Clay")
		end)
	end
end

-- Terracotta blocks

for _, clay in pairs(clay) do

	if clay[1] ~= "natural" then

		local texture = "baked_clay_terracotta_" .. clay[1] ..".png"

		minetest.register_node("bakedclay:terracotta_" .. clay[1], {
			description = clay[2] .. " " .. S("Glazed Terracotta"),
			tiles = {
				texture .. "",
				texture .. "",
				texture .. "^[transformR180",
				texture .. "",
				texture .. "^[transformR270",
				texture .. "^[transformR90",
			},
			paramtype2 = "facedir",
			groups = {cracky = 3, terracotta = 1},
			sounds = default.node_sound_stone_defaults(),
			is_ground_content = false,
			on_place = minetest.rotate_node
		})

		minetest.register_craft({
			type = "cooking",
			output = "bakedclay:terracotta_" .. clay[1],
			recipe = "bakedclay:" .. clay[1]
		})
	end
end

minetest.register_alias("bakedclay:terracotta_light_blue", "bakedclay:terracotta_cyan")

-- cook clay block into natural baked clay

minetest.register_craft({
	type = "cooking",
	output = "bakedclay:natural",
	recipe = "default:clay"
})

-- register a few extra dye colour options

minetest.register_craft({
	output = "dye:green 4",
	recipe = {{"default:cactus"}}
})

minetest.register_craft({
	output = "dye:brown 4",
	recipe = {{"default:dry_shrub"}}
})

-- only add light grey recipe if unifieddye mod isnt present (conflict)

if not minetest.get_modpath("unifieddyes") then

	minetest.register_craft( {
		output = "dye:dark_grey 3",
		recipe = {{"dye:black", "dye:black", "dye:white"}}
	})

	minetest.register_craft( {
		output = "dye:grey 3",
		recipe = {{"dye:black", "dye:white", "dye:white"}}
	})
end

-- 2x2 red baked clay makes 16x clay brick

minetest.register_craft( {
	output = "default:clay_brick 16",
	recipe = {
		{"bakedclay:red", "bakedclay:red"},
		{"bakedclay:red", "bakedclay:red"}
	}
})

-- colored clay compatibility

if minetest.settings:get_bool("colored_clay_compatibility") == true then

	local cc = {
		{"black", "black"},
		{"blue", "blue"},
		{"bright", "natural"},
		{"brown", "brown"},
		{"cyan", "cyan"},
		{"dark_green", "dark_green"},
		{"dark_grey", "dark_grey"},
		{"green", "green"},
		{"grey", "grey"},
		{"hardened", "natural"},
		{"magenta", "magenta"},
		{"orange", "orange"},
		{"pink", "pink"},
		{"red", "red"},
		{"violet", "violet"},
		{"white", "white"},
		{"yellow", "yellow"}
	}

	for n = 1, #cc do

		local nod1 = "colored_clay:" .. cc[n][1]
		local nod2 = "bakedclay:" .. cc[n][2]

		minetest.register_alias(nod1, nod2)

		if stairsplus_mod then
			stairsplus:register_alias_all("colored_clay", cc[n][1], "bakedclay", cc[n][2])
		end
	end
end

-- get mod path

local path = minetest.get_modpath("bakedclay")

-- add new flowers

dofile(path .. "/flowers.lua")

-- add lucky blocks if mod present

if minetest.get_modpath("lucky_block") then
	dofile(path .. "/lucky_block.lua")
end

print ("[MOD] Baked Clay loaded")
