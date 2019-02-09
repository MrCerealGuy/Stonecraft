--[[

2017-01-06 modified by MrCerealGuy <mrcerealguy@gmx.de>
	exit if mod is deactivated

--]]

if core.skip_mod("homedecor") then return end

local S = homedecor_i18n.gettext

lavalamp = {}

minetest.register_node("lavalamp:lavalamp", {
	description = S("Lava Lamp"),
	drawtype = "mesh",
	mesh = "lavalamp.obj",
	tiles = {
		{ name = "lavalamp_metal.png", color = "white" },
		{ name = "lavalamp_lamp_liquid.png", color = "white" },
	},
	overlay_tiles = {
		"",
		{
			name="lavalamp_lamp_anim.png",
			animation={
				type="vertical_frames",
				aspect_w=40,
				aspect_h=40,
				length=6.0,
			},
		},
	},
	use_texture_alpha = true,
	inventory_image = "lavalamp_lamp_inv.png",
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	sunlight_propagates = true,
	walkable = false,
	light_source = 14,
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25,0.5, 0.25 },
	},
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, ud_param2_colorable = 1},
	sounds = default.node_sound_glass_defaults(),
	on_construct = unifieddyes.on_construct,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		node.name = "lavalamp:lavalamp_off"
		minetest.swap_node(pos, node)
		return itemstack
	end
})

minetest.register_node("lavalamp:lavalamp_off", {
	description = S("Lava Lamp (off)"),
	drawtype = "mesh",
	mesh = "lavalamp.obj",
	tiles = {
		{ name = "lavalamp_metal.png", color = 0xffffffff },
		"lavalamp_lamp_off.png",
	},
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25,0.5, 0.25 },
	},
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	drop = "lavalamp:lavalamp",
	on_construct = unifieddyes.on_construct,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		node.name = "lavalamp:lavalamp"
		minetest.swap_node(pos, node)
		return itemstack
	end,
	drop = {
		items = {
			{items = {"lavalamp:lavalamp"}, inherit_color = true },
		}
	}
})

minetest.register_craft({
	output = "lavalamp:lavalamp",
	recipe = {
		{"", "wool:white", "", },
		{"", "bucket:bucket_water", "", },
		{"", "wool:black", "", }
	}
})

unifieddyes.register_color_craft({
	output = "lavalamp:lavalamp",
	palette = "extended",
	type = "shapeless",
	neutral_node = "lavalamp:lavalamp",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

-- convert to param2 coloring

local colors = {
	"red",
	"orange",
	"yellow",
	"green",
	"blue",
	"violet"
}

lavalamp.old_static_nodes = {}
for _, color in ipairs(colors) do
	table.insert(lavalamp.old_static_nodes, "lavalamp:"..color)
	table.insert(lavalamp.old_static_nodes, "lavalamp:"..color.."_off")
end

minetest.register_lbm({
	name = "lavalamp:convert",
	label = "Convert lava lamps to use param2 color",
	run_at_every_load = false,
	nodenames = lavalamp.old_static_nodes,
	action = function(pos, node)
		local name = node.name
		local color

		if string.find(name, "red") then
			color = "red"
		elseif string.find(name, "orange") then
			color = "orange"
		elseif string.find(name, "yellow") then
			color = "yellow"
		elseif string.find(name, "green") then
			color = "green"
		elseif string.find(name, "blue") then
			color = "blue"
		elseif string.find(name, "violet") then
			color = "violet"
		end

		local paletteidx, _ = unifieddyes.getpaletteidx("unifieddyes:"..color, "extended")

		minetest.set_node(pos, { name = "lavalamp:lavalamp", param2 = paletteidx })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)

	end
})
