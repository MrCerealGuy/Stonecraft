
local S = homedecor_i18n.gettext

minetest.register_node("homedecor:bathroom_tiles_dark", {
	description = S("Bathroom/kitchen tiles (dark)"),
	tiles = {
		"homedecor_bathroom_tiles_bg.png"
	},
	overlay_tiles = {
		{ name = "homedecor_bathroom_tiles_fg.png", color = 0xff606060 },
	},
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	place_param2 = 240,
	groups = {cracky=3, ud_param2_colorable = 1},
	sounds = default.node_sound_stone_defaults(),
	on_construct = unifieddyes.on_construct,
	after_place_node = unifieddyes.recolor_on_place,
	after_dig_node = unifieddyes.after_dig_node
})

minetest.register_node("homedecor:bathroom_tiles_medium", {
	description = S("Bathroom/kitchen tiles (medium)"),
	tiles = {
		"homedecor_bathroom_tiles_bg.png"
	},
	overlay_tiles = {
		{ name = "homedecor_bathroom_tiles_fg.png", color = 0xffc0c0c0 },
	},
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	place_param2 = 240,
	groups = {cracky=3, ud_param2_colorable = 1},
	sounds = default.node_sound_stone_defaults(),
	on_construct = unifieddyes.on_construct,
	after_place_node = unifieddyes.recolor_on_place,
	after_dig_node = unifieddyes.after_dig_node
})

minetest.register_node("homedecor:bathroom_tiles_light", {
	description = S("Bathroom/kitchen tiles (light)"),
	tiles = {
		"homedecor_bathroom_tiles_bg.png"
	},
	overlay_tiles = {
			{ name = "homedecor_bathroom_tiles_fg.png", color = 0xffffffff },
	},
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	place_param2 = 240,
	groups = {cracky=3, ud_param2_colorable = 1},
	sounds = default.node_sound_stone_defaults(),
	on_construct = unifieddyes.on_construct,
	after_place_node = unifieddyes.recolor_on_place,
	after_dig_node = unifieddyes.after_dig_node
})

local tr_cbox = {
	type = "fixed",
	fixed = { -0.375, -0.3125, 0.25, 0.375, 0.375, 0.5 }
}

homedecor.register("towel_rod", {
	description = S("Towel rod with towel"),
	mesh = "homedecor_towel_rod.obj",
	tiles = {
		"homedecor_generic_terrycloth.png",
		"default_wood.png",
	},
	inventory_image = "homedecor_towel_rod_inv.png",
	selection_box = tr_cbox,
	walkable = false,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3},
	sounds = default.node_sound_defaults(),
})

homedecor.register("medicine_cabinet", {
	description = S("Medicine cabinet"),
	mesh = "homedecor_medicine_cabinet.obj",
	tiles = {
		'default_wood.png',
		'homedecor_medicine_cabinet_mirror.png'
	},
	inventory_image = "homedecor_medicine_cabinet_inv.png",
	selection_box = {
		type = "fixed",
		fixed = {-0.3125, -0.1875, 0.3125, 0.3125, 0.5, 0.5}
	},
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(pos, node, puncher, pointed_thing)
		node.name = "homedecor:medicine_cabinet_open"
		minetest.swap_node(pos, node)
	end,
	infotext=S("Medicine cabinet"),
	inventory = {
		size=6,
	},
})

homedecor.register("medicine_cabinet_open", {
	mesh = "homedecor_medicine_cabinet_open.obj",
	tiles = {
		'default_wood.png',
		'homedecor_medicine_cabinet_mirror.png',
		'homedecor_medicine_cabinet_inside.png'
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3125, -0.1875, -0.25, 0.3125, 0.5, 0.5}
	},
	walkable = false,
	groups = { snappy = 3, not_in_creative_inventory=1 },
	drop = "homedecor:medicine_cabinet",
	on_punch = function(pos, node, puncher, pointed_thing)
		node.name = "homedecor:medicine_cabinet"
		minetest.swap_node(pos, node)
	end,
})

-- convert old static nodes

homedecor.old_static_bathroom_tiles = {
	"homedecor:tiles_1",
	"homedecor:tiles_2",
	"homedecor:tiles_3",
	"homedecor:tiles_4",
	"homedecor:tiles_red",
	"homedecor:tiles_tan",
	"homedecor:tiles_yellow",
	"homedecor:tiles_green",
	"homedecor:tiles_blue"
}

local old_to_color = {
	"light_grey",
	"grey",
	"black",
	"black"
}

minetest.register_lbm({
	name = "homedecor:convert_bathroom_tiles",
	label = "Convert bathroom tiles to use param2 color",
	run_at_every_load = false,
	nodenames = homedecor.old_static_bathroom_tiles,
	action = function(pos, node)
		local name = node.name
		local newname = "homedecor:bathroom_tiles_light"
		local a = string.find(name, "_")
		local color = string.sub(name, a + 1)

		if color == "tan" then
			color = "yellow_s50"
		elseif color == "1" or color == "2" or color == "3" or color == "4" then
			if color == "4" then
				newname = "homedecor:bathroom_tiles_medium"
			end
			color = old_to_color[tonumber(color)]
		elseif color ~= "yellow" then
			color = color.."_s50"
		end

		local paletteidx = unifieddyes.getpaletteidx("unifieddyes:"..color, "extended")

		minetest.set_node(pos, { name = newname, param2 = paletteidx })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)
		meta:set_string("palette", "ext")
	end
})

minetest.register_lbm({
	name = "homedecor:recolor_bathroom_tiles",
	label = "Convert bathroom tiles to use UD extended palette",
	run_at_every_load = false,
	nodenames = {
		"homedecor:bathroom_tiles_light",
		"homedecor:bathroom_tiles_medium",
		"homedecor:bathroom_tiles_dark",
	},
	action = function(pos, node)
		local meta = minetest.get_meta(pos)
		if meta:get_string("palette") ~= "ext" then
			minetest.swap_node(pos, { name = node.name, param2 = unifieddyes.convert_classic_palette[node.param2] })
			meta:set_string("palette", "ext")
		end
	end
})
