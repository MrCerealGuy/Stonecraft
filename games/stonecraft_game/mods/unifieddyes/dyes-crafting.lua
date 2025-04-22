-- crafting!

-- Generate all dyes that are not part of the default minetest_game dyes mod

local S = minetest.get_translator("unifieddyes")

for _, h in ipairs(unifieddyes.HUES_EXTENDED) do
	local hue = h[1]
	local r = h[2]
	local g = h[3]
	local b = h[4]

	for v = 0, 6 do
		local val = unifieddyes.VALS_EXTENDED[v+1]

		local factor = 40
		if v > 3 then factor = 75 end

		local r2 = math.max(math.min(r + (4-v)*factor, 255), 0)
		local g2 = math.max(math.min(g + (4-v)*factor, 255), 0)
		local b2 = math.max(math.min(b + (4-v)*factor, 255), 0)

		-- full-sat color

		local desc = hue:gsub("%a", string.upper, 1).." Dye"

		if val ~= "" then
			desc = val:sub(1, -2):gsub("%a", string.upper, 1) .." "..desc
		end

		local color = string.format("%02x", r2)..string.format("%02x", g2)..string.format("%02x", b2)
		if minetest.registered_items["dye:"..val..hue] then
			minetest.override_item("dye:"..val..hue, {
				inventory_image = "unifieddyes_dye.png^[colorize:#"..color..":200",
			})
		else
			if (val..hue) ~= "medium_orange"
			  and (val..hue) ~= "light_red" then
				minetest.register_craftitem(":dye:"..val..hue, {
					description = S(desc),
					inventory_image = "unifieddyes_dye.png^[colorize:#"..color..":200",
					groups = { dye=1, not_in_creative_inventory=1 },
				})
			end
		end
		minetest.register_alias("unifieddyes:"..val..hue, "dye:"..val..hue)

		if v > 3 then -- also register the low-sat version

			local pr = 0.299
			local pg = 0.587
			local pb = 0.114

			local p = math.sqrt(r2*r2*pr + g2*g2*pg + b2*b2*pb)
			local r3 = math.floor(p+(r2-p)*0.5)
			local g3 = math.floor(p+(g2-p)*0.5)
			local b3 = math.floor(p+(b2-p)*0.5)

			local ccolor = string.format("%02x", r3)..string.format("%02x", g3)..string.format("%02x", b3)

			minetest.register_craftitem(":dye:"..val..hue.."_s50", {
				description = S(desc.." (low saturation)"),
				inventory_image = "unifieddyes_dye.png^[colorize:#"..ccolor..":200",
				groups = { dye=1, not_in_creative_inventory=1 },
			})
			minetest.register_alias("unifieddyes:"..val..hue.."_s50", "dye:"..val..hue.."_s50")
		end
	end
end

-- register the greyscales too :P

for y = 1, 14 do -- colors 0 and 15 are black and white, default dyes

	if y ~= 4 and y ~= 8 and y~= 11 then -- don't register the three greys, they're done separately.

		local rgb = string.format("%02x", y*17)..string.format("%02x", y*17)..string.format("%02x", y*17)
		local name = "grey_"..y
		local desc = "Grey Dye #"..y

		minetest.register_craftitem(":dye:"..name, {
			description = S(desc),
			inventory_image = "unifieddyes_dye.png^[colorize:#"..rgb..":200",
			groups = { dye=1, not_in_creative_inventory=1 },
		})
		minetest.register_alias("unifieddyes:"..name, "dye:"..name)
	end
end

if minetest.get_modpath("dye") then
	minetest.override_item("dye:grey", {
		inventory_image = "unifieddyes_dye.png^[colorize:#888888:200",
	})

	minetest.override_item("dye:dark_grey", {
		inventory_image = "unifieddyes_dye.png^[colorize:#444444:200",
	})

	minetest.register_craftitem(":dye:light_grey", {
		description = S("Light grey Dye"),
		inventory_image = "unifieddyes_dye.png^[colorize:#cccccc:200",
		groups = { dye=1, not_in_creative_inventory=1 },
	})
end

-- build a table of color <-> palette associations to reduce the need for
-- realtime lookups with getpaletteidx()

for _, palette in ipairs({"extended", "split", "wallmounted"}) do
	local palette2 = palette

	for i in ipairs(unifieddyes.SATS) do
		local sat = (palette == "wallmounted") and "" or unifieddyes.SATS[i]
		for _, hue in ipairs(unifieddyes.HUES_EXTENDED) do
			for _, val in ipairs(unifieddyes.VALS_EXTENDED) do
				local color = val..hue[1]..sat
				if unifieddyes.getpaletteidx("dye:"..color, palette2) then
					unifieddyes.palette_has_color[palette.."_"..color] = true
				end
			end
		end
	end

	for y = 0, 15 do
		local grey = "grey_"..y

		if y == 0 then grey = "black"
		elseif y == 4 then grey = "dark_grey"
		elseif y == 8 then grey = "grey"
		elseif y == 11 then grey = "light_grey"
		elseif y == 15 then grey = "white"
		end
		if unifieddyes.getpaletteidx("dye:"..grey, palette2) then
			unifieddyes.palette_has_color[palette.."_"..grey] = true
		end
	end
end

unifieddyes.palette_has_color["wallmounted_light_red"] = true

unifieddyes.base_color_crafts = {
	{ "red",		"flowers:rose",				nil,				nil,			nil,			nil,		4 },
	{ "vermilion",	"dye:red",					"dye:orange",		nil,			nil,			nil,		3 },
	{ "orange",		"flowers:tulip",			nil,				nil,			nil,			nil,		4 },
	{ "orange",		"dye:red",					"dye:yellow",		nil,			nil,			nil,		2 },
	{ "amber",		"dye:orange",				"dye:yellow",		nil,			nil,			nil,		2 },
	{ "yellow",		"flowers:dandelion_yellow",	nil,				nil,			nil,			nil,		4 },
	{ "lime",		"dye:yellow",				"dye:chartreuse",	nil,			nil,			nil,		2 },
	{ "lime",		"dye:yellow",				"dye:yellow",		"dye:green",	nil,			nil,		3 },
	{ "chartreuse",	"dye:yellow",				"dye:green",		nil,			nil,			nil,		2 },
	{ "harlequin",	"dye:chartreuse",			"dye:green",		nil,			nil,			nil,		2 },
	{ "harlequin",	"dye:yellow",				"dye:green",		"dye:green",	nil,			nil,		3 },
	{ "green", 		"default:cactus",			nil,				nil,			nil,			nil,		4 },
	{ "green", 		"dye:yellow",				"dye:blue",			nil,			nil,			nil,		2 },
	{ "malachite",	"dye:green",				"dye:spring",		nil,			nil,			nil,		2 },
	{ "malachite",	"dye:green",				"dye:green",		"dye:cyan",		nil,			nil,		3 },
	{ "malachite",	"dye:green",				"dye:green",		"dye:green",	"dye:blue",		nil,		4 },
	{ "spring",		"dye:green",				"dye:cyan",			nil,			nil,			nil,		2 },
	{ "spring",		"dye:green",				"dye:green",		"dye:blue",		nil,			nil,		3 },
	{ "turquoise",	"dye:spring",				"dye:cyan",			nil,			nil,			nil,		2 },
	{ "turquoise",	"dye:green",				"dye:cyan",			"dye:cyan",		nil,			nil,		3 },
	{ "turquoise",	"dye:green",				"dye:green",		"dye:green",	"dye:blue",		"dye:blue",	5 },
	{ "cyan",		"dye:green",				"dye:blue",			nil,			nil,			nil,		2 },
	{ "cerulean",	"dye:cyan",					"dye:azure",		nil,			nil,			nil,		2 },
	{ "cerulean",	"dye:cyan",					"dye:cyan",			"dye:blue",		nil,			nil,		3 },
	{ "cerulean",	"dye:green",				"dye:green",		"dye:blue",		"dye:blue",		"dye:blue",	5 },
	{ "azure",		"dye:cyan",					"dye:blue",			nil,			nil,			nil,		2 },
	{ "azure",		"dye:green",				"dye:blue",			"dye:blue",		nil,			nil,		3 },
	{ "sapphire",	"dye:azure",				"dye:blue",			nil,			nil,			nil,		2 },
	{ "sapphire",	"dye:cyan",					"dye:blue",			"dye:blue",		nil,			nil,		3 },
	{ "sapphire",	"dye:green",				"dye:blue",			"dye:blue",		"dye:blue",		nil,		4 },
	{ "blue",		"flowers:geranium",			nil,				nil,			nil,			nil,		4 },
	{ "indigo",		"dye:blue",					"dye:violet",		nil,			nil,			nil,		2 },
	{ "violet",		"flowers:viola",			nil,				nil,			nil,			nil,		4 },
	{ "violet",		"dye:blue",					"dye:magenta",		nil,			nil,			nil,		2 },
	{ "mulberry",	"dye:violet",				"dye:magenta",		nil,			nil,			nil,		2 },
	{ "mulberry",	"dye:violet",				"dye:blue",			"dye:red",		nil,			nil,		3 },
	{ "magenta",	"dye:blue",					"dye:red",			nil,			nil,			nil,		2 },
	{ "fuchsia",	"dye:magenta",				"dye:rose",			nil,			nil,			nil,		2 },
	{ "fuchsia",	"dye:blue",					"dye:red",			"dye:rose",		nil,			nil,		3 },
	{ "fuchsia",	"dye:red",					"dye:violet",		nil,			nil,			nil,		2 },
	{ "rose",		"dye:magenta",				"dye:red",			nil,			nil,			nil,		2 },
	{ "rose",		"dye:red",					"dye:red",			"dye:blue",		nil,			nil,		3 },
	{ "crimson",	"dye:rose",					"dye:red",			nil,			nil,			nil,		2 },
	{ "crimson",	"dye:magenta",				"dye:red",			"dye:red",		nil,			nil,		3 },
	{ "crimson",	"dye:red",					"dye:red",			"dye:red",		"dye:blue",		nil,		4 },

	{ "black",		"default:coal_lump",		nil,				nil,			nil,			nil,		4 },
	{ "white",		"flowers:dandelion_white",	nil,				nil,			nil,			nil,		4 },
}

unifieddyes.shade_crafts = {
	{ "faint_",		"",			"dye:white",		"dye:white",	"dye:white",	4 },
	{ "pastel_",	"",			"dye:white",		"dye:white",	nil,			3 },
	{ "light_",		"",			"dye:white",		nil,			nil,			2 },
	{ "bright_",	"",			"color",			"dye:white",	nil,			3 },
	{ "",			"_s50",		"dye:light_grey",	nil,			nil,			2 },
	{ "",			"_s50",		"dye:black",		"dye:white",	"dye:white",	3 },
	{ "medium_",	"",			"dye:black",		nil,			nil,			2 },
	{ "medium_",	"_s50",		"dye:grey",			nil,			nil,			2 },
	{ "medium_",	"_s50",		"dye:black",		"dye:white",	nil,			3 },
	{ "dark_",		"",			"dye:black",		"dye:black",	nil,			3 },
	{ "dark_",		"_s50",		"dye:dark_grey",	nil,			nil,			2 },
	{ "dark_",		"_s50",		"dye:black",		"dye:black",	"dye:white",	4 },
}

for _,i in ipairs(unifieddyes.base_color_crafts) do
	local color = i[1]
	local yield = i[7]

	minetest.register_craft( {
		type = "shapeless",
		output = "dye:"..color.." "..yield,
		recipe = {
			i[2],
			i[3],
			i[4],
			i[5],
			i[6],
		},
	})

	for _,j in ipairs(unifieddyes.shade_crafts) do
		local firstdye = j[3]
		if firstdye == "color" then firstdye = "dye:"..color end

		-- ignore black, white, anything containing the word "grey"

		if color ~= "black" and color ~= "white" and not string.find(color, "grey") then

			minetest.register_craft( {
				type = "shapeless",
				output = "dye:"..j[1]..color..j[2].." "..j[6],
				recipe = {
					"dye:"..color,
					firstdye,
					j[4],
					j[5]
				},
			})
		end
	end
end

-- greys

unifieddyes.greymixes = {
	{ 1,	"dye:black",			"dye:black",		"dye:black",		"dye:dark_grey",	4 },
	{ 2,	"dye:black",			"dye:black",		"dye:dark_grey",	nil,				3 },
	{ 3,	"dye:black",			"dye:dark_grey",	nil,				nil,				2 },
	{ 4,	"dye:white",			"dye:black",		"dye:black",		nil,				3 },
	{ 5,	"dye:dark_grey",		"dye:dark_grey",	"dye:grey",			nil,				3 },
	{ 6,	"dye:dark_grey",		"dye:grey",			nil,				nil,				2 },
	{ 7,	"dye:dark_grey",		"dye:grey",			"dye:grey",			nil,				3 },
	{ 8,	"dye:white",			"dye:black",		nil,				nil,				2 },
	{ 9,	"dye:grey", 			"dye:grey",			"dye:light_grey",	nil,				3 },
	{ 10,	"dye:grey",				"dye:light_grey",	"dye:light_grey",	nil,				3 },
	{ 11,	"dye:white",			"dye:white",		"dye:black",		nil,				3 },
	{ 12,	"dye:light_grey",		"dye:light_grey",	"dye:white",		nil,				3 },
	{ 13,	"dye:light_grey",		"dye:white",		nil,				nil,				2 },
	{ 14,	"dye:white", 			"dye:white",		"dye:light_grey",	nil,				3 },
}

for _, i in ipairs(unifieddyes.greymixes) do
	local shade = i[1]
	local dye1 = i[2]
	local dye2 = i[3]
	local dye3 = i[4]
	local dye4 = i[5]
	local yield = i[6]
	local color = "grey_"..shade
	if shade == 4 then
		color = "dark_grey"
	elseif shade == 8 then
		color = "grey"
	elseif shade == 11 then
		color = "light_grey"
	end

	minetest.register_craft( {
		type = "shapeless",
		output = "dye:"..color.." "..yield,
		recipe = {
			dye1,
			dye2,
			dye3,
			dye4,
		},
	})
end

-- other crafts
-- we can't make dark orange anymore because brown/medium orange conflicts

minetest.register_craft( {
	type = "shapeless",
	output = "dye:dark_orange",
	recipe = {
		"dye:brown",
		"dye:brown"
	},
})

minetest.register_craft( {
	output = "unifieddyes:airbrush",
	recipe = {
		{ "basic_materials:brass_ingot", "",           "basic_materials:plastic_sheet" },
		{ "",                   "default:steel_ingot", ""                              },
		{ "",                   "",                    "default:steel_ingot"           }
	},
})
