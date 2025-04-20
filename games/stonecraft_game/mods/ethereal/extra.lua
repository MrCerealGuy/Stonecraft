
local S = minetest.get_translator("ethereal")

-- Blue Marble Nodes and recipe

minetest.register_node("ethereal:blue_marble", {
	description = S("Blue Marble"),
	tiles = {"ethereal_blue_marble.png"},
	groups = {cracky = 1, stone = 1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ethereal:blue_marble_tile", {
	description = S("Blue Marble Tile"),
	tiles = {"ethereal_blue_marble_tile.png"},
	groups = {cracky = 1, stone = 1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_craft({
	output = "ethereal:blue_marble_tile 9",
	recipe = {
		{"ethereal:blue_marble", "ethereal:blue_marble", "ethereal:blue_marble"},
		{"ethereal:blue_marble", "ethereal:blue_marble", "ethereal:blue_marble"},
		{"ethereal:blue_marble", "ethereal:blue_marble", "ethereal:blue_marble"}
	}
})

-- Etherium Dust

minetest.register_craftitem("ethereal:etherium_dust", {
	description = S("Etherium Dust"),
	inventory_image = "ethereal_etherium_dust.png",
	wield_image = "ethereal_etherium_dust.png"
})

-- Ethereium Ore

minetest.register_node("ethereal:etherium_ore", {
	description = S("Etherium Ore"),
	tiles = {"default_desert_stone.png^ethereal_etherium_ore.png"},
	groups = {cracky = 3},
	drop = "ethereal:etherium_dust",
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("ethereal:stone_with_etherium_ore", {
	description = S("Etherium Ore"),
	tiles = {"default_stone.png^ethereal_etherium_ore.png"},
	groups = {cracky = 3},
	drop = "ethereal:etherium_dust",
	sounds = default.node_sound_stone_defaults()
})

-- Bamboo Flooring

minetest.register_node("ethereal:bamboo_floor", {
	description = S("Bamboo Floor"),
	drawtype = "nodebox",
	tiles = {"ethereal_bamboo_floor.png"},
	wield_image = "ethereal_bamboo_floor.png",
	inventory_image = "ethereal_bamboo_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = true,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
		wall_side   = {-0.5, -0.5, -0.5, -0.4375, 0.5, 0.5}
	},
	selection_box = {type = "wallmounted"},
	groups = {snappy = 3, choppy = 3 , flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:bamboo_floor 2",
	recipe = {
		{"ethereal:bamboo", "ethereal:bamboo"},
		{"ethereal:bamboo", "ethereal:bamboo"}
	}
})

-- Bamboo Block

minetest.register_node("ethereal:bamboo_block", {
	description = S("Bamboo Block"),
	tiles = {"ethereal_bamboo_floor.png"},
	paramtype = "light",
	groups = {snappy = 3, choppy = 3 , flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:bamboo_block",
	recipe = {
		{"ethereal:bamboo_floor"},
		{"ethereal:bamboo_floor"}
	}
})

minetest.register_craft({
	output = "ethereal:bamboo_block",
	recipe = {
		{"ethereal:bamboo", "ethereal:bamboo", "ethereal:bamboo"},
		{"ethereal:bamboo", "ethereal:bamboo", "ethereal:bamboo"},
		{"ethereal:bamboo", "ethereal:bamboo", "ethereal:bamboo"}
	}
})

-- Paper recipes

minetest.register_craft({
	output = "default:paper 6",
	recipe = {
		{"ethereal:bamboo", "ethereal:bamboo"},
		{"ethereal:bamboo", "ethereal:bamboo"},
		{"ethereal:bamboo", "ethereal:bamboo"}
	}
})

minetest.register_craft({
	output = "default:paper 2",
	recipe = {
		{"farming:cotton", "farming:cotton", "farming:cotton"}
	}
})

-- 4x red mushrooms make mushroom block

minetest.register_craft({
	output = "ethereal:mushroom",
	recipe = {
		{"flowers:mushroom_red", "flowers:mushroom_red"},
		{"flowers:mushroom_red", "flowers:mushroom_red"}
	}
})

minetest.register_craft({
	output = "ethereal:mushroom_brown",
	recipe = {
		{"flowers:mushroom_brown", "flowers:mushroom_brown"},
		{"flowers:mushroom_brown", "flowers:mushroom_brown"}
	}
})

-- X pattern craft recipes (5x 'a' in X pattern gives 5 of 'b')

if ethereal.xcraft == true then

	local cheat = {
		{"default:cobble", "default:gravel", 5},
		{"default:gravel", "default:dirt", 5},
		{"default:dirt", "default:sand", 5},
		{"default:ice", "default:snow", 20},
		{"ethereal:dry_dirt", "default:desert_sand", 5},
		{"default:stone", "default:silver_sandstone", 5}
	}

	for n = 1, #cheat do

		minetest.register_craft({
			output = cheat[n][2] .. " " .. cheat[n][3],
			recipe = {
				{cheat[n][1], "", cheat[n][1]},
				{"", cheat[n][1], ""},
				{cheat[n][1], "", cheat[n][1]}
			}
		})
	end
end

-- Palm Wax

minetest.register_craftitem("ethereal:palm_wax", {
	description = S("Palm Wax"),
	inventory_image = "ethereal_palm_wax.png",
	wield_image = "ethereal_palm_wax.png"
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "ethereal:palm_wax",
	recipe = "ethereal:palmleaves"
})

-- candle helper function

local candle_colors = {
	[""] = "F7F2CD",
	["black"] = "40403F",
	["blue"] = "5587B4",
	["brown"] = "6D4728",
	["cyan"] = "78F1B1",
	["dark_green"] = "23AF23",
	["dark_grey"] = "868178",
	["green"] = "96CA32",
	["grey"] = "C0BAAF",
	["magenta"] = "C22E7D",
	["orange"] = "E88817",
	["pink"] = "FA8B91",
	["red"] = "CF4727",
	["violet"] = "975EC0",
	["yellow"] = "FFF74D"
}

local function add_candle(col, dcol)

	local under = "" ; if dcol ~= "" then under = "_" end

	minetest.register_node("ethereal:candle" .. under .. col, {
		description = S(dcol .. "Candle"),
		drawtype = "plantlike",

		inventory_image = "ethereal_candle_base_inv.png^[multiply:#"
			.. candle_colors[col] .. "70^ethereal_candle_flame_inv.png",
		wield_image = "ethereal_candle_base_inv.png^[multiply:#"
			.. candle_colors[col] .. "70^ethereal_candle_flame_inv.png",
		tiles = {
			{
				name = "ethereal_candle_base.png^[multiply:#"
					.. candle_colors[col] .. "70^ethereal_candle_flame.png",
				animation = {
					type="vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.0
				}
			}
		},
		paramtype = "light",
		light_source = 11,
		sunlight_propagates = true,
		walkable = false,
		groups = {candle = 1, dig_immediate = 3, attached_node = 1},
		sounds = default.node_sound_defaults(),
		selection_box = {
			type = "fixed", fixed = { -0.15, -0.5, -0.15, 0.15, 0, 0.15 }
		}
	})

	if dcol ~= "" then
		minetest.register_craft({
			output = "ethereal:candle" .. under .. col,
			recipe = { {"group:candle", "dye:" .. col} }
		})
	end
end

add_candle("", "")
add_candle("black", "Black ")
add_candle("blue", "Blue ")
add_candle("brown", "Brown ")
add_candle("cyan", "Cyan ")
add_candle("dark_green", "Dark Green ")
add_candle("dark_grey", "Dark Grey ")
add_candle("green", "Green ")
add_candle("grey", "Grey ")
add_candle("magenta", "Magenta ")
add_candle("orange", "Orange ")
add_candle("pink", "Pink ")
add_candle("red", "Red ")
add_candle("violet", "Violet ")
add_candle("yellow", "Yellow ")

-- white candle recipe

minetest.register_craft({
	output = "ethereal:candle",
	recipe = {
		{"group:candle", "dye:white"}
	}
})

-- base candle recipe

minetest.register_craft({
	output = "ethereal:candle 2",
	recipe = {
		{"farming:string"},
		{"ethereal:palm_wax"},
		{"ethereal:palm_wax"}
	}
})

-- wooden bowl, dont add bowl if farming redo already has one

if not minetest.registered_items["farming:bowl"] then

	minetest.register_craftitem("ethereal:bowl", {
		description = S("Bowl"),
		inventory_image = "ethereal_bowl.png",
		groups = {food_bowl = 1, flammable = 2}
	})

	minetest.register_craft({
		output = "ethereal:bowl 4",
		recipe = {
			{"group:wood", "", "group:wood"},
			{"", "group:wood", ""}
		}
	})
else
	minetest.register_alias("ethereal:bowl", "farming:bowl")
end

-- stone Ladder

minetest.register_node("ethereal:stone_ladder", {
	description = S("Stone Ladder"),
	drawtype = "signlike",
	tiles = {"ethereal_stone_ladder.png"},
	inventory_image = "ethereal_stone_ladder.png",
	wield_image = "ethereal_stone_ladder.png",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {type = "wallmounted"},
	groups = {cracky = 3, oddly_breakable_by_hand = 1},
	legacy_wallmounted = true,
	sounds = default.node_sound_stone_defaults()
})

minetest.register_craft({
	output = "ethereal:stone_ladder 4",
	recipe = {
		{"group:stone", "", "group:stone"},
		{"group:stone", "group:stone", "group:stone"},
		{"group:stone", "", "group:stone"}
	}
})

-- Paper Wall

minetest.register_node("ethereal:paper_wall", {
	drawtype = "nodebox",
	description = S("Paper Wall"),
	tiles = {"ethereal_paper_wall.png"},
	inventory_image = "ethereal_paper_wall.png",
	wield_image = "ethereal_paper_wall.png",
	paramtype = "light",
	groups = {snappy = 3},
	sounds = default.node_sound_wood_defaults(),
	walkable = true,
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype2 = "facedir",
	selection_box = {
		type = "fixed", fixed = {-0.5, -0.5, 5/11, 0.5, 0.5, 8/16}
	},
	node_box = {
		type = "fixed", fixed = {{-0.5, -0.5, 5/11, 0.5, 0.5, 8/16}}
	}
})

minetest.register_craft({
	output = "ethereal:paper_wall",
	recipe = {
		{"group:stick", "default:paper", "group:stick"},
		{"group:stick", "default:paper", "group:stick"},
		{"group:stick", "default:paper", "group:stick"}
	}
})

-- Glostone (A little bit of light decoration)

minetest.register_node("ethereal:glostone", {
	description = S("Glo Stone"),
	tiles = {"ethereal_glostone.png"},
	groups = {cracky = 3},
	light_source = 13,
	drop = "ethereal:glostone",
	sounds = default.node_sound_stone_defaults()
})

minetest.register_craft({
	output = "ethereal:glostone",
	recipe = {
		{"", "default:torch", ""},
		{"default:torch", "default:stone", "default:torch"},
		{"", "dye:yellow", ""}
	}
})

-- Charcoal Lump

minetest.register_craftitem("ethereal:charcoal_lump", {
	description = S("Lump of Charcoal"),
	inventory_image = "ethereal_charcoal_lump.png"
})

minetest.register_craft({
	output = "ethereal:charcoal_lump 2",
	recipe = {
		{"ethereal:scorched_tree"}
	}
})

minetest.register_craft({
	output = "ethereal:charcoal_lump 2",
	type = "cooking",
	recipe = "group:tree",
	cooktime = 4
})

minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:charcoal_lump",
	burntime = 10
})

-- Make Torch from Charcoal Lump

minetest.register_craft({
	output = "default:torch 4",
	recipe = {
		{"ethereal:charcoal_lump"},
		{"default:stick"}
	}
})

-- staff of light alternative node list

ethereal.lightstaff_recipes = {
	["nether:rack"] = "nether:glowstone",
	["nether:rack_deep"] = "nether:glowstone_deep"
}

-- Staff of Light (by Xanthin)

minetest.register_tool("ethereal:light_staff", {
	description = S("Staff of Light"),
	inventory_image = "ethereal_light_staff.png",
	light_source = 13,
	wield_image = "ethereal_light_staff.png",
	sound = {breaks = "default_tool_breaks"},
	stack_max = 1,

	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then return end

		local pos = pointed_thing.under
		local pname = user:get_player_name()

		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end

		local node = minetest.get_node(pos).name
		local def = minetest.registered_nodes[node]
		local stone = def and def.groups and def.groups.stone and def.groups.stone == 1

		if ethereal.lightstaff_recipes[node] or stone then

			local glo = ethereal.lightstaff_recipes[node] or "ethereal:glostone"

			minetest.set_node(pos, {name = glo})

			itemstack:add_wear(65535 / 149) -- 150 uses

			return itemstack
		end
	end
})

minetest.register_craft({
	output = "ethereal:light_staff",
	recipe = {
		{"ethereal:illumishroom", "default:mese_crystal", "ethereal:illumishroom"},
		{"ethereal:illumishroom2", "default:steel_ingot", "ethereal:illumishroom2"},
		{"ethereal:illumishroom3", "default:steel_ingot", "ethereal:illumishroom3"}
	}
})
