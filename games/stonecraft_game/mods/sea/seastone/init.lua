--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

2017-05-15 MrCerealGuy: added intllib support

--]]

local DIR_DELIM = DIR_DELIM or "/"
local world_file = minetest.get_worldpath()..DIR_DELIM.."world.mt"
local world_conf = Settings(world_file)
local enable_seaplants = world_conf:get("enable_seaplants")

if enable_seaplants ~= nil and enable_seaplants == "false" then
	minetest.log("info", "[sea:seastone] skip loading mod.")
	return
end

-- --------------------------------------------------------------------------------------------------------

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- NODES
minetest.register_node("seastone:seastone", {
	description = S("Seastone"),
	tiles = {"seastone_seastone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'seacobble:seacobble',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seastone:seastone_cyan", {
	description = S("Seastone cyan"),
	tiles = {"seastone_seastone_cyan.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1;},
	drop = 'seacobble:seacobble_cyan',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seastone:seastone_magenta", {
	description = S("Seastone magenta"),
	tiles = {"seastone_seastone_magenta.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'seacobble:seacobble_magenta',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seastone:seastone_lime", {
	description = S("Seastone lime"),
	tiles = {"seastone_seastone_lime.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'seacobble:seacobble_lime',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seastone:seastone_aqua", {
	description = S("Seastone aqua"),
	tiles = {"seastone_seastone_aqua.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'seacobble:seacobble_aqua',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seastone:seastone_skyblue", {
	description = S("Seastone skyblue"),
	tiles = {"seastone_seastone_skyblue.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'seacobble:seacobble_skyblue',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seastone:seastone_redviolet", {
	description = S("Seastone redviolet"),
	tiles = {"seastone_seastone_redviolet.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'seacobble:seacobble_redviolet',
	sounds = default.node_sound_stone_defaults(),
})


-- STAIRS


stairs.register_stair_and_slab("seastone", "seastone:seastone",
		{cracky=3, stone=1},
		{"seastone_seastone.png"},
		S("Seastone stair"),
		S("Seastone slab"),
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seastone_cyan", "seastone:seastone_cyan",
		{cracky=3, stone=1},
		{"seastone_seastone_cyan.png"},
		S("Seastone stair cyan"),
		S("Seastone slab cyan"),
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seastone_magenta", "seastone:seastone_magenta",
		{cracky=3, stone=1},
		{"seastone_seastone_magenta.png"},
		S("Seastone stair magenta"),
		S("Seastone slab magenta"),
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seastone_lime", "seastone:seastone_lime",
		{cracky=3, stone=1},
		{"seastone_seastone_lime.png"},
		S("Seastone stair lime"),
		S("Seastone slab lime"),
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seastone_aqua", "seastone:seastone_aqua",
		{cracky=3, stone=1},
		{"seastone_seastone_aqua.png"},
		S("Seastone stair aqua"),
		S("Seastone slab aqua"),
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seastone_skyblue", "seastone:seastone_skyblue",
		{cracky=3, stone=1},
		{"seastone_seastone_skyblue.png"},
		S("Seastone stair skyblue"),
		S("Seastone slab skyblue"),
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seastone_redviolet", "seastone:seastone_redviolet",
		{cracky=3, stone=1},
		{"seastone_seastone_redviolet.png"},
		S("Seastone stair redviolet"),
		S("Seastone slab redviolet"),
		default.node_sound_stone_defaults())


-- CRAFTING


local register_seastone_craft = function(output,recipe)
    minetest.register_craft({
        type = 'shapeless',
        output = output,
        recipe = recipe,
	})
end

register_seastone_craft("seastone:seastone", {'clams:crushedwhite', 'default:stone'})

register_seastone_craft("seastone:seastone_cyan", {'seastone:seastone', 'dye:cyan'})
register_seastone_craft("seastone:seastone_magenta", {'seastone:seastone', 'dye:magenta'})
register_seastone_craft("seastone:seastone_lime", {'seastone:seastone', 'dye:lime'})
register_seastone_craft("seastone:seastone_aqua", {'seastone:seastone', 'dye:aqua'})
register_seastone_craft("seastone:seastone_skyblue", {'seastone:seastone', 'dye:skyblue'})
register_seastone_craft("seastone:seastone_redviolet", {'seastone:seastone', 'dye:redviolet'})

register_seastone_craft("seastone:seastone_cyan", {'clams:crushedwhite', 'default:stone','dye:cyan'})
register_seastone_craft("seastone:seastone_magenta", {'clams:crushedwhite', 'default:stone','dye:magenta'})
register_seastone_craft("seastone:seastone_lime", {'clams:crushedwhite', 'default:stone','dye:lime'})
register_seastone_craft("seastone:seastone_aqua", {'clams:crushedwhite', 'default:stone','dye:aqua'})
register_seastone_craft("seastone:seastone_skyblue", {'clams:crushedwhite', 'default:stone','dye:skyblue'})
register_seastone_craft("seastone:seastone_redviolet", {'clams:crushedwhite', 'default:stone','dye:redviolet'})

-- COOKING


local register_smoothblock_cooking = function(output,recipe)
    minetest.register_craft({
       type = "cooking",
       output = output,
       recipe = recipe,
	})
end

register_smoothblock_cooking("seastone:seastone", "seacobble:seacobble")
register_smoothblock_cooking("seastone:seastone_cyan", "seacobble:seacobble_cyan")
register_smoothblock_cooking("seastone:seastone_magenta", "seacobble:seacobble_magenta")
register_smoothblock_cooking("seastone:seastone_lime", "seacobble:seacobble_lime")
register_smoothblock_cooking("seastone:seastone_aqua", "seacobble:seacobble_aqua")
register_smoothblock_cooking("seastone:seastone_skyblue", "seacobble:seacobble_skyblue")
register_smoothblock_cooking("seastone:seastone_redviolet", "seacobble:seacobble_redviolet")