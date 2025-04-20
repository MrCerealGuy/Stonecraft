--[[
	Minetest Ethereal Mod

	Created by ChinChow

	Updated by TenPlus1
]]

-- global

ethereal = {version = "20250209"}

-- setting helper

local function setting(stype, name, default)

	local value

	if stype == "bool" then
		value = minetest.settings:get_bool("ethereal." .. name)
	elseif stype == "string" then
		value = minetest.settings:get("ethereal." .. name)
	elseif stype == "number" then
		value = tonumber(minetest.settings:get("ethereal." .. name))
	end

	if value == nil then value = default end

	ethereal[name] = value
end

-- DO NOT change settings below, use the settings.conf file instead

setting("number", "leaftype", 0)
setting("bool", "leafwalk", false)
setting("bool", "cavedirt", true)
setting("bool", "torchdrop", true)
setting("bool", "papyruswalk", true)
setting("bool", "lilywalk", true)
setting("bool", "xcraft", true)
setting("bool", "flight", true)
setting("number", "glacier", 1)
setting("number", "bamboo", 1)
setting("number", "mesa", 1)
setting("number", "alpine", 1)--taiga
setting("number", "snowy", 1)--coniferous_forest
setting("number", "frost", 1)
setting("number", "grassy", 1)--deciduous_forest
setting("number", "caves", 1)
setting("number", "grayness", 1)
setting("number", "grassytwo", 1)
setting("number", "prairie", 1)
setting("number", "jumble", 1)
setting("number", "junglee", 1)--rainforest
setting("number", "desert", 1)
setting("number", "grove", 1)
setting("number", "mushroom", 1)
setting("number", "sandstone", 1)--sandstone_desert
setting("number", "plains", 1)
setting("number", "savanna", 1)
setting("number", "fiery", 1)
setting("number", "swamp", 1)
setting("number", "quicksand", 1)--swamp quicksand
setting("number", "tundra", 1)
setting("number", "mediterranean", 1)
setting("number", "cold_desert", 1)
setting("number", "snowy_grassland", 1)
setting("number", "sealife", 1)
setting("number", "reefs", 1)
setting("number", "logs", 1)
setting("bool", "wood_rotate", true)


local path = minetest.get_modpath("ethereal")

--[[ Load settings.conf file if found [DEPRECATED]

local input = io.open(path.."/settings.conf", "r")

if input then
	dofile(path .. "/settings.conf") ; input:close() ; input = nil
end ]]

-- Falling node function

ethereal.check_falling = minetest.check_for_falling or nodeupdate

-- creative check

local creative_mode_cache = minetest.settings:get_bool("creative_mode")

function ethereal.check_creative(name)
	return creative_mode_cache or minetest.check_player_privs(name, {creative = true})
end

-- helper function to add {eatable} group to food items

function ethereal.add_eatable(item, hp)

	local def = minetest.registered_items[item]

	if def then

		local groups = table.copy(def.groups) or {}

		groups.eatable = hp ; groups.flammable = 2

		minetest.override_item(item, {groups = groups})
	end
end

-- strawberry check and load

if minetest.get_modpath("farming") and farming.mod and farming.mod == "redo" then
	-- farming redo already has strawberry included
else
	dofile(path .. "/strawberry.lua")
end

-- load mod sections

dofile(path .. "/plantlife.lua")
dofile(path .. "/onion.lua")
dofile(path .. "/crystal.lua")
dofile(path .. "/water.lua")
dofile(path .. "/dirt.lua")
dofile(path .. "/food.lua")
dofile(path .. "/wood.lua")
dofile(path .. "/leaves.lua")
dofile(path .. "/sapling.lua")
dofile(path .. "/fishing.lua")
dofile(path .. "/extra.lua")
dofile(path .. "/sealife.lua")
dofile(path .. "/fences.lua")

if minetest.settings:get_bool("ethereal.clear_default_biomes", true) then
	dofile(path .. "/biomes_init.lua")
end

dofile(path .. "/biomes.lua")
dofile(path .. "/ores.lua")
dofile(path .. "/schems.lua")
dofile(path .. "/decor.lua")
dofile(path .. "/compatibility.lua")
dofile(path .. "/stairs.lua")

-- add flight if enabled

if ethereal.flight then
	dofile(path .. "/flight.lua")
end

-- add lucky blocks if mod active

if minetest.get_modpath("lucky_block") then
	dofile(path .. "/lucky_block.lua")
end

-- Set bonemeal aliases

if minetest.get_modpath("bonemeal") then
	minetest.register_alias("ethereal:bone", "bonemeal:bone")
	minetest.register_alias("ethereal:bonemeal", "bonemeal:bonemeal")
else -- or return to where it came from
	minetest.register_alias("ethereal:bone", "default:dirt")
	minetest.register_alias("ethereal:bonemeal", "default:dirt")
end

-- ambience lite

if minetest.get_modpath("ambience") then
	dofile(path .. "/ambience.lua")
end

print ("[MOD] Ethereal loaded")
