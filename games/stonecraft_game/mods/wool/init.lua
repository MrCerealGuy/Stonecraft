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
	{"white",      S("White"),      "basecolor_white"},
	{"grey",       S("Grey"),       "basecolor_grey"},
	{"black",      S("Black"),      "basecolor_black"},
	{"red",        S("Red"),        "basecolor_red"},
	{"yellow",     S("Yellow"),     "basecolor_yellow"},
	{"green",      S("Green"),      "basecolor_green"},
	{"cyan",       S("Cyan"),       "basecolor_cyan"},
	{"blue",       S("Blue"),       "basecolor_blue"},
	{"magenta",    S("Magenta"),    "basecolor_magenta"},
	{"orange",     S("Orange"),     "excolor_orange"},
	{"violet",     S("Violet"),     "excolor_violet"},
	{"brown",      S("Brown"),      "unicolor_dark_orange"},
	{"pink",       S("Pink"),       "unicolor_light_red"},
	{"dark_grey",  S("Dark Grey"),  "unicolor_darkgrey"},
	{"dark_green", S("Dark Green"), "unicolor_dark_green"},
}

for i = 1, #dyes do
	local name, desc, craft_color_group = unpack(dyes[i])

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
		recipe = {"group:dye," .. craft_color_group, "group:wool"},
	}
end


-- legacy

-- Backwards compatibility with jordach's 16-color wool mod
minetest.register_alias("wool:dark_blue", "wool:blue")
minetest.register_alias("wool:gold", "wool:yellow")
