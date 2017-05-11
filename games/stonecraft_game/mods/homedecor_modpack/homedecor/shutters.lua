-- Various kinds of window shutters

local S = homedecor_i18n.gettext

local shutters = {
	"mahogany",
	"red",
	"yellow",
	"forest_green",
	"light_blue",
	"violet",
	"black",
	"dark_grey",
	"grey",
	"white",
}

local shutter_cbox = {
	type = "wallmounted",
	wall_top =		{ -0.5,  0.4375, -0.5,  0.5,     0.5,    0.5 },
	wall_bottom =	{ -0.5, -0.5,    -0.5,  0.5,    -0.4375, 0.5 },
	wall_side =		{ -0.5, -0.5,    -0.5, -0.4375,  0.5,    0.5 }
}

local inv = "homedecor_window_shutter_inv.png^[colorize:#a87034:150"

homedecor.register("shutter", {
	mesh = "homedecor_window_shutter.obj",
	tiles = {
		{ name = "homedecor_window_shutter.png", color = 0xffa87034 }
	},
	description = S("Wooden Shutter"),
	inventory_image = inv,
	wield_image = inv,
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	ud_replacement_node = "homedecor:shutter_colored",
	groups = { snappy = 3, ud_param2_colorable = 1 },
	sounds = default.node_sound_wood_defaults(),
	selection_box = shutter_cbox,
	node_box = shutter_cbox,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
		unifieddyes.recolor_on_place(pos, placer, itemstack, pointed_thing)
	end,
	after_dig_node = unifieddyes.after_dig_node
})

homedecor.register("shutter_colored", {
	mesh = "homedecor_window_shutter.obj",
	tiles = { "homedecor_window_shutter.png" },
	description = S("Wooden Shutter"),
	inventory_image = "homedecor_window_shutter_inv.png",
	wield_image = "homedecor_window_shutter_inv.png",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	groups = { snappy = 3 , not_in_creative_inventory = 1, ud_param2_colorable = 1},
	sounds = default.node_sound_wood_defaults(),
	selection_box = shutter_cbox,
	node_box = shutter_cbox,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
		unifieddyes.recolor_on_place(pos, placer, itemstack, pointed_thing)
	end,
	after_dig_node = unifieddyes.after_dig_node,
	drop = "homedecor:shutter"
})

minetest.register_alias("homedecor:shutter_purple", "homedecor:shutter_violet")
minetest.register_alias("homedecor:shutter_oak", "homedecor:shutter")

-- convert to param2 coloring

homedecor.old_shutter_nodes = {}

for _, color in ipairs(shutters) do
	table.insert(homedecor.old_shutter_nodes, "homedecor:shutter_"..color)
end

minetest.register_lbm({
	name = "homedecor:convert_shutters",
	label = "Convert shutter static nodes to use param2 color",
	run_at_every_load = false,
	nodenames = homedecor.old_shutter_nodes,
	action = function(pos, node)
		local name = node.name
		local color = string.sub(name, string.find(name, "_") + 1)

		if color == "mahogany" then
			color = "dark_red"
		elseif color == "forest_green" then
			color = "dark_green"
		elseif color == "light_blue" then
			color = "medium_cyan"
		elseif color == "red" then
			color = "medium_red"
		end

		local paletteidx = unifieddyes.getpaletteidx("unifieddyes:"..color, "wallmounted")
		local param2 = paletteidx + node.param2

		minetest.set_node(pos, { name = "homedecor:shutter_colored", param2 = param2 })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)
	end
})
