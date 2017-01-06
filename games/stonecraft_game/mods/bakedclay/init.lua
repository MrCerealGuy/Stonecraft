
-- Baked Clay by TenPlus1

local clay = {
	{"white", "White"},
	{"grey", "Grey"},
	{"black", "Black"},
	{"red", "Red"},
	{"yellow", "Yellow"},
	{"green", "Green"},
	{"cyan", "Cyan"},
	{"blue", "Blue"},
	{"magenta", "Magenta"},
	{"orange", "Orange"},
	{"violet", "Violet"},
	{"brown", "Brown"},
	{"pink", "Pink"},
	{"dark_grey", "Dark Grey"},
	{"dark_green", "Dark Green"},
}

for _, clay in pairs(clay) do

	-- node definition

	minetest.register_node("bakedclay:" .. clay[1], {
		description = clay[2] .. " Baked Clay",
		tiles = {"baked_clay_" .. clay[1] ..".png"},
		groups = {cracky = 3, bakedclay = 1},
		sounds = default.node_sound_stone_defaults(),
	})

	-- craft from dye and any baked clay

	minetest.register_craft({
		output = "bakedclay:" .. clay[1] .. " 8",
		recipe = {
			{"group:bakedclay", "group:bakedclay", "group:bakedclay"},
			{"group:bakedclay", "dye:" .. clay[1], "group:bakedclay"},
			{"group:bakedclay", "group:bakedclay", "group:bakedclay"}
		},
	})

	-- register stairsplus stairs if found
	if minetest.global_exists("stairsplus") then

		stairsplus:register_all("bakedclay", clay[1], "bakedclay:" .. clay[1], {
			description = clay[2] .. " Baked Clay",
			tiles = {"baked_clay_" .. clay[1] .. ".png"},
			groups = {cracky = 3},
			sounds = default.node_sound_stone_defaults(),
		})

	-- register stair and slab (unless stairs redo active)
	elseif stairs and not stairs.mod then

		stairs.register_stair_and_slab("bakedclay_".. clay[1], "bakedclay:".. clay[1],
			{cracky = 3},
			{"baked_clay_" .. clay[1] .. ".png"},
			clay[2] .. " Baked Clay Stair",
			clay[2] .. " Baked Clay Slab",
			default.node_sound_stone_defaults())
	end
end

-- cook clay block into white baked clay

minetest.register_craft({
	type = "cooking",
	output = "bakedclay:white",
	recipe = "default:clay",
})

-- register a few extra dye colour options

minetest.register_craft( {
	type = "shapeless",
	output = "dye:dark_grey 3",
	recipe = {"dye:black", "dye:black", "dye:white"}
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:grey 3",
	recipe = {"dye:black", "dye:white", "dye:white"}
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:green 4",
	recipe = {"default:cactus"}
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:black 4",
	recipe = {"default:coal_lump"}
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:brown 4",
	recipe = {"default:dry_shrub"}
})

-- register some new flowers to fill in missing dye colours


-- flower registration (borrowed from default game)

local function add_simple_flower(name, desc, box, f_groups)

	f_groups.snappy = 3
	f_groups.flower = 1
	f_groups.flora = 1
	f_groups.attached_node = 1

	minetest.register_node("bakedclay:" .. name, {
		description = desc,
		drawtype = "plantlike",
		waving = 1,
		tiles = {"baked_clay_" .. name .. ".png"},
		inventory_image = "baked_clay_" .. name .. ".png",
		wield_image = "baked_clay_" .. name .. ".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		stack_max = 99,
		groups = f_groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = box
		}
	})
end

local flowers = {
	{"delphinium", "Blue Delphinium", {-0.15, -0.5, -0.15, 0.15, 0.3, 0.15}, {color_cyan = 1}},
	{"thistle", "Thistle", {-0.15, -0.5, -0.15, 0.15, 0.2, 0.15}, {color_magenta = 1}},
	{"lazarus", "Lazarus Bell", {-0.15, -0.5, -0.15, 0.15, 0.2, 0.15}, {color_pink = 1}},
	{"mannagrass", "Reed Mannagrass", {-0.15, -0.5, -0.15, 0.15, 0.2, 0.15}, {color_dark_green = 1}},
}

for _,item in pairs(flowers) do
	add_simple_flower(unpack(item))
end

-- mapgen for new flowers

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.004,
		spread = {x = 100, y = 100, z = 100},
		seed = 7133,
		octaves = 3,
		persist = 0.6
	},
	y_min = 10,
	y_max = 90,
	decoration = "bakedclay:delphinium",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.004,
		spread = {x = 100, y = 100, z = 100},
		seed = 7134,
		octaves = 3,
		persist = 0.6
	},
	y_min = 15,
	y_max = 90,
	decoration = "bakedclay:thistle",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.01,
		spread = {x = 100, y = 100, z = 100},
		seed = 7135,
		octaves = 3,
		persist = 0.6
	},
	y_min = 1,
	y_max = 90,
	decoration = "bakedclay:lazarus",
	spawn_by = "default:jungletree",
	num_spawn_by = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:sand"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.009,
		spread = {x = 100, y = 100, z = 100},
		seed = 7136,
		octaves = 3,
		persist = 0.6
	},
	y_min = 1,
	y_max = 15,
	decoration = "bakedclay:mannagrass",
	spawn_by = "group:water",
	num_spawn_by = 1,
})

-- add lucky blocks

if minetest.get_modpath("lucky_block") then
local p = "bakedclay:"
lucky_block:add_blocks({
	{"dro", {"bakedclay:"}, 10, true},
	{"fal", {p.."black", p.."blue", p.."brown", p.."cyan", p.."dark_green",
		p.."dark_grey", p.."green", p.."grey", p.."magenta", p.."orange",
		p.."pink", p.."red", p.."violet", p.."white", p.."yellow"}, 0},
	{"fal", {p.."black", p.."blue", p.."brown", p.."cyan", p.."dark_green",
		p.."dark_grey", p.."green", p.."grey", p.."magenta", p.."orange",
		p.."pink", p.."red", p.."violet", p.."white", p.."yellow"}, 0, true},
	{"dro", {p.."delphinium", p.."lazarus", p.."mannagrass"}, 6},
})
end

print ("[MOD] Baked Clay loaded")
