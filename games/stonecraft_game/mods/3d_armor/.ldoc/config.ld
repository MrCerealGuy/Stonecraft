
-- place this file in mod ".ldoc" directory

local print, type, string, table, tostring, tonumber, error, pairs, ipairs
if import then
	print = import("print")
	type = import("type")
	string = import("string")
	table = import("table")
	tostring = import("tostring")
	tonumber = import("tonumber")
	error = import("error")
	pairs = import("pairs")
	ipairs = import("ipairs")
end

project = "3d_armor"
title = "3D Armor"
format = "markdown"
not_luadoc = true
boilerplate = false
wrap = false
style = true
favicon = "https://www.minetest.net/media/icon.svg"

file = {
	"3d_armor/api.lua",
	".ldoc/settings.luadoc",
	--".ldoc/armors.luadoc",
	".ldoc/helmets.luadoc",
	".ldoc/chestplates.luadoc",
	".ldoc/leggings.luadoc",
	".ldoc/boots.luadoc",
	--".ldoc/shields.luadoc",
	"shields/init.lua",
	".ldoc/crafting.luadoc",
}


new_type("setting", "Settings")
new_type("armor", "Armors")
new_type("craft", "Craft Recipes")

alias("helmet", "armor")
alias("chestplate", "armor")
alias("leggings", "armor")
alias("boots", "armor")
alias("shield", "armor")
alias("grp", "group")

-- function declarations
local format_text
local format_group

custom_tags = {
	-- settings
	{
		"settype",
		title = "Type",
		hidden = true,
	},
	{
		"min",
		title = "Minimum Value",
		hidden = true,
	},
	{
		"max",
		title = "Maximum Value",
		hidden = true,
	},
	{
		"default",
		title = "Default Value",
		hidden = true,
	},
	-- craft items/tools
	{
		-- specify image basename only
		"img",
		title = "Inventory Image",
		format = function(value)
			return "<img src=\"../data/" .. value .. "\" style=\"width:32px; height:32px;\" />"
		end,
	},
	{
		-- specify full (relative or absolute) image path
		"image",
		title = "Image",
		format = function(value)
			return "<img src=\"" .. value .. "\" style=\"width:32px; height:32px;\" />"
		end,
	},
	{
		"group",
		title = "Groups",
		format = function(value)
			return format_group(value)
		end,
	},
	{
		"armorgrp",
		title = "Armor Groups",
		format = function(value)
			return format_group(value)
		end,
	},
	{
		"damagegrp",
		title = "Damage Groups",
		format = function(value)
			return format_group(value)
		end,
	},
}


if string then
	string.trim = function(st, delim)
		if not delim then
			delim = " "
		end

		while string.find(st, delim) == 1 do
			st = st:sub(2)
		end

		while string.sub(st, string.len(st)) == delim do
			st = st:sub(1, string.len(st)-1)
		end

		return st
	end

	string.split = function(st, delim)
		local list = {}

		local idx = string.find(st, delim)
		while idx do
			table.insert(list, st:sub(1, idx-1))
			st = st:sub(idx+1)
			idx = string.find(st, delim)
		end
		-- add remaining item
		table.insert(list, st)

		return list
	end
end

if table then
	if not table.copy then
		table.copy = function(orig_table)
			local new_table = {}
			for k, v in pairs(orig_table) do
				new_table[k] = v
			end

			return new_table
		end
	end
end

format_text = function(text, flags)
	local ret = "<"
	local ttype = "span"
	if flags.code then
		ttype = "code"
	end

	ret = ret .. ttype .. " style=\""

	if flags.size then
		ret = ret .. "font-size:" .. flags.size .. ";"
	end
	if flags.mono then
		ret = ret .. "font-family:monospace;"
	end
	if flags.italic then
		ret = ret .. "font-style:italic;"
	end
	if flags.bold then
		ret = ret .. "font-weight:bold;"
	end
	if flags.color then
		ret = ret .. "color:" .. flags.color .. ";"
	end
	if flags.bgcolor then
		ret = ret .. "background-color:" .. flags.bgcolor .. ";"
	end

	ret = ret .. "\">" .. text .. "</" .. ttype .. ">"

	return ret
end

format_group = function(text)
	if string then
		local idx, k, v = string.find(text, " ")
		if idx then
			text = format_text(string.sub(text, 1, idx-1) .. ": ", {mono=true, color="darkgreen"})
				.. string.sub(text, idx)
		end
	end

	return text
end


local function format_setting_tag(desc, value)
	return "\n- <span style=\"font-size:80%;\">`" .. desc .. ":`</span> `" .. value .. "`"
end


local registered = {
	settings = {},
}

local function setting_handler(item)
	-- avoid parsing again
	if registered.settings[item.name] then
		return item
	end

	if not ipairs or not type then
		return item
	end

	local tags = {
		{"settype", "type"},
		{"default"},
		{"min", "minimum value"},
		{"max", "maximum value"},
	}

	local def = {
		["settype"] = format_setting_tag("type", "string"),
	}

	for _, t in ipairs(tags) do
		local name = t[1]
		local desc = t[2]
		if not desc then desc = name end

		local value = item.tags[name]
		if type(value) == "table" then
			if #value > 1 then
				local msg = item.file.filename .. " (line " .. item.lineno
					.. "): multiple instances of tag \"" .. name .. "\" found"
				if error then
					error(msg)
				elseif print then
					print("WARNING: " .. msg)
				end
			end

			if value[1] then
				def[name] = format_setting_tag(desc, value[1])
			end
		end
	end

	item.description = item.description .. "\n\n**Definition:**\n" .. def.settype
	for _, t in ipairs({def.default, def.min, def.max}) do
		if t then
			item.description = item.description .. t
		end
	end

	registered.settings[item.name] = true

	return item
end

function custom_display_name_handler(item, default_handler)
	if item.type == "setting" then
		item = setting_handler(item)
	end

	if item then
		return default_handler(item)
	end
end


local custom_see_links = {
	["ObjectRef"] = "https://minetest.gitlab.io/minetest/class-reference/#objectref",
	["PlayerMetaRef"] = "https://minetest.gitlab.io/minetest/class-reference/#playermetaref",
	["ItemDef"] = "https://minetest.gitlab.io/minetest/definition-tables/#item-definition",
	["ItemStack"] = "https://minetest.gitlab.io/minetest/class-reference/#itemstack",
	["groups"] = "https://minetest.gitlab.io/minetest/groups/",
	["entity_damage_mechanism"] = "https://minetest.gitlab.io/minetest/entity-damage-mechanism/",
	["vector"] = "https://minetest.gitlab.io/minetest/representations-of-simple-things/#positionvector",
}

local function format_custom_see(name, section)
	local url = custom_see_links[name]
	if not url then
		url = ""
	end

	if not name then
		name = ""
	end

	return name, url
end

custom_see_handler("^(ObjectRef)$", function(name, section)
	return format_custom_see(name, section)
end)

custom_see_handler("^(PlayerMetaRef)$", function(name, section)
	return format_custom_see(name, section)
end)

custom_see_handler("^(ItemDef)$", function(name, section)
	return format_custom_see(name, section)
end)

custom_see_handler("^(groups)$", function(name, section)
	return format_custom_see(name, section)
end)

custom_see_handler("^(entity_damage_mechanism)$", function(name, section)
	return format_custom_see(name, section)
end)

custom_see_handler("^(ItemStack)$", function(name, section)
	return format_custom_see(name, section)
end)

custom_see_handler("^(vector)$", function(name, section)
	return name, "https://minetest.gitlab.io/minetest/representations-of-simple-things/#positionvector"
end)
