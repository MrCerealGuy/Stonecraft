-- This uses a trick: you can first define the recipes using all of the base
-- colors, and then some recipes using more specific colors for a few non-base
-- colors available. When crafting, the last recipes will be checked first.

--[[

2017-05-13 added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local dyes = {
	{"white",      S("White")},
	{"grey",       S("Grey")},
	{"black",      S("Black")},
	{"red",        S("Red")},
	{"yellow",     S("Yellow")},
	{"green",      S("Green")},
	{"cyan",       S("Cyan")},
	{"blue",       S("Blue")},
	{"magenta",    S("Magenta")},
	{"orange",     S("Orange")},
	{"violet",     S("Violet")},
	{"brown",      S("Brown")},
	{"pink",       S("Pink")},
	{"dark_grey",  S("Dark Grey")},
	{"dark_green", S("Dark Green")},
}

for i = 1, #dyes do
	local name, desc = unpack(dyes[i])

	minetest.register_node("wool:" .. name, {
		description = desc .. S(" Wool"),
		tiles = {"wool_" .. name .. ".png"},
		is_ground_content = false,
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 3,
				flammable = 3, wool = 1},
		sounds = default.node_sound_defaults(),
	})

	minetest.register_craft{
		type = "shapeless",
		output = "wool:" .. name,
		recipe = {"group:dye,color_" .. name, "group:wool"},
	}
end

-- Legacy
-- Backwards compatibility with jordach's 16-color wool mod
minetest.register_alias("wool:dark_blue", "wool:blue")
minetest.register_alias("wool:gold", "wool:yellow")
