
local S = homedecor_i18n.gettext

local function N_(x) return x end

local bed_sbox = {
	type = "wallmounted",
	wall_side = { -0.5, -0.5, -0.5, 0.5, 0.5, 1.5 }
}

local bed_cbox = {
	type = "wallmounted",
	wall_side = {
		{ -0.5, -0.5, -0.5, 0.5, -0.05, 1.5 },
		{ -0.5, -0.5, 1.44, 0.5, 0.5, 1.5 },
		{ -0.5, -0.5, -0.5, 0.5, 0.18, -0.44 },
	}
}

local kbed_sbox = {
	type = "wallmounted",
	wall_side = { -0.5, -0.5, -0.5, 1.5, 0.5, 1.5 }
}

local kbed_cbox = {
	type = "wallmounted",
	wall_side = {
		{ -0.5, -0.5, -0.5, 1.5, -0.05, 1.5 },
		{ -0.5, -0.5, 1.44, 1.5, 0.5, 1.5 },
		{ -0.5, -0.5, -0.5, 1.5, 0.18, -0.44 },
	}
}

homedecor.register("bed_regular", {
	mesh = "homedecor_bed_regular.obj",
	tiles = {
		{ name = "homedecor_bed_frame.png", color = 0xffffffff },
		{ name = "default_wood.png", color = 0xffffffff },
		{ name = "wool_white.png", color = 0xffffffff },
		"wool_white.png",
		{ name = "homedecor_bed_bottom.png", color = 0xffffffff },
		"wool_white.png^[brighten", -- pillow
	},
	inventory_image = "homedecor_bed_inv.png",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	description = S("Bed"),
	groups = {snappy=3, ud_param2_colorable = 1},
	selection_box = bed_sbox,
	node_box = bed_cbox,
	sounds = default.node_sound_wood_defaults(),
	on_rotate = screwdriver.disallow,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
		unifieddyes.recolor_on_place(pos, placer, itemstack, pointed_thing)
		if not placer:get_player_control().sneak then
			return homedecor.bed_expansion(pos, placer, itemstack, pointed_thing)
		end
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		unifieddyes.after_dig_node(pos, oldnode, oldmetadata, digger)
		homedecor.unextend_bed(pos)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local itemname = itemstack:get_name()
		if itemname == "homedecor:bed_regular" then
			homedecor.bed_expansion(pos, clicker, itemstack, pointed_thing, true)
			return itemstack
		else
--			if minetest.get_modpath("beds") then
--				beds.on_rightclick(pos, clicker)
--			end
			return itemstack
		end
	end
})

homedecor.register("bed_extended", {
	mesh = "homedecor_bed_extended.obj",
	tiles = {
		{ name = "homedecor_bed_frame.png", color = 0xffffffff },
		{ name = "default_wood.png", color = 0xffffffff },
		{ name = "wool_white.png", color = 0xffffffff },
		"wool_white.png",
		{ name = "homedecor_bed_bottom.png", color = 0xffffffff },
		"wool_white.png^[brighten",
	},
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = bed_sbox,
	node_box = bed_cbox,
	groups = {snappy=3, ud_param2_colorable = 1},
	sounds = default.node_sound_wood_defaults(),
	expand = { forward = "air" },
	on_rotate = screwdriver.disallow,
	after_place_node = unifieddyes.recolor_on_place,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		unifieddyes.after_dig_node(pos, oldnode, oldmetadata, digger)
		homedecor.unextend_bed(pos)
	end,
--	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
--		local itemname = itemstack:get_name()
--		if minetest.get_modpath("beds") then
--			beds.on_rightclick(pos, clicker)
--		end
--		return itemstack
--	end,
	drop = "homedecor:bed_regular"
})

homedecor.register("bed_kingsize", {
	mesh = "homedecor_bed_kingsize.obj",
	tiles = {
		{ name = "homedecor_bed_frame.png", color = 0xffffffff },
		{ name = "default_wood.png", color = 0xffffffff },
		{ name = "wool_white.png", color = 0xffffffff },
		"wool_white.png",
		{ name = "homedecor_bed_bottom.png", color = 0xffffffff },
		"wool_white.png^[brighten",
	},
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	inventory_image = "homedecor_bed_kingsize_inv.png",
	description = S("Bed (king sized)"),
	groups = {snappy=3, ud_param2_colorable = 1},
	selection_box = kbed_sbox,
	node_box = kbed_cbox,
	sounds = default.node_sound_wood_defaults(),
	on_rotate = screwdriver.disallow,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
		unifieddyes.recolor_on_place(pos, placer, itemstack, pointed_thing)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		unifieddyes.after_dig_node(pos, oldnode, oldmetadata, digger)
		local inv = digger:get_inventory()
		if digger:get_player_control().sneak and inv:room_for_item("main", "homedecor:bed_regular 2") then
			inv:remove_item("main", "homedecor:bed_kingsize 1")
			inv:add_item("main", "homedecor:bed_regular 2")
		end
	end,
--	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
--		local itemname = itemstack:get_name()
--		if minetest.get_modpath("beds") then
--			beds.on_rightclick(pos, clicker)
--		end
--		return itemstack
--	end
})

for _, w in pairs({ N_("mahogany"), N_("oak") }) do
	homedecor.register("nightstand_"..w.."_one_drawer", {
		description = S("Nightstand with One Drawer (@1)", S(w)),
		tiles = { 'homedecor_nightstand_'..w..'_tb.png',
			'homedecor_nightstand_'..w..'_tb.png^[transformFY',
			'homedecor_nightstand_'..w..'_lr.png^[transformFX',
			'homedecor_nightstand_'..w..'_lr.png',
			'homedecor_nightstand_'..w..'_back.png',
			'homedecor_nightstand_'..w..'_1_drawer_front.png'},
		node_box = {
			type = "fixed",
			fixed = {
				{ -8/16,     0, -30/64,  8/16,  8/16,   8/16 },	-- top half
				{ -7/16,  1/16, -32/64,  7/16,  7/16, -29/64},	-- drawer face
				{ -8/16, -8/16, -30/64, -7/16,     0,   8/16 },	-- left
				{  7/16, -8/16, -30/64,  8/16,     0,   8/16 },	-- right
				{ -8/16, -8/16,   7/16,  8/16,     0,   8/16 },	-- back
				{ -8/16, -8/16, -30/64,  8/16, -7/16,   8/16 }	-- bottom
			}
		},
		groups = { snappy = 3 },
		sounds = default.node_sound_wood_defaults(),
		selection_box = { type = "regular" },
		infotext=S("One-drawer Nightstand"),
		inventory = {
			size=8,
			lockable=true,
		},
	})

	homedecor.register("nightstand_"..w.."_two_drawers", {
		description = S("Nightstand with Two Drawers (@1)", S(w)),
		tiles = { 'homedecor_nightstand_'..w..'_tb.png',
			'homedecor_nightstand_'..w..'_tb.png^[transformFY',
			'homedecor_nightstand_'..w..'_lr.png^[transformFX',
			'homedecor_nightstand_'..w..'_lr.png',
			'homedecor_nightstand_'..w..'_back.png',
			'homedecor_nightstand_'..w..'_2_drawer_front.png'},
		node_box = {
			type = "fixed",
			fixed = {
				{ -8/16, -8/16, -30/64,  8/16,  8/16,   8/16 },	-- main body
				{ -7/16,  1/16, -32/64,  7/16,  7/16, -29/64 },	-- top drawer face
				{ -7/16, -7/16, -32/64,  7/16, -1/16, -29/64 },	-- bottom drawer face
			}
		},
		groups = { snappy = 3 },
		sounds = default.node_sound_wood_defaults(),
		selection_box = { type = "regular" },
		infotext=S("Two-drawer Nightstand"),
		inventory = {
			size=16,
			lockable=true,
		},
	})
end

-- convert to param2 colorization

local bedcolors = {
	"black",
	"brown",
	"blue",
	"cyan",
	"darkgrey",
	"dark_green",
	"green",
	"grey",
	"magenta",
	"orange",
	"pink",
	"red",
	"violet",
	"white",
	"yellow"
}

homedecor.old_bed_nodes = {}

for _, color in ipairs(bedcolors) do
	table.insert(homedecor.old_bed_nodes, "homedecor:bed_"..color.."_regular")
	table.insert(homedecor.old_bed_nodes, "homedecor:bed_"..color.."_extended")
	table.insert(homedecor.old_bed_nodes, "homedecor:bed_"..color.."_kingsize")
end

minetest.register_lbm({
	name = "homedecor:convert_beds",
	label = "Convert homedecor static bed nodes to use param2 color",
	run_at_every_load = false,
	nodenames = homedecor.old_bed_nodes,
	action = function(pos, node)
		local name = node.name
		local color = string.sub(name, string.find(name, "_") + 1)

		-- -10 puts us near the end of the color field
		color = string.sub(color, 1, string.find(color, "_", -10) - 1)

		if color == "darkgrey" then
			color = "dark_grey"
		end

		local paletteidx = unifieddyes.getpaletteidx("unifieddyes:"..color, "wallmounted")
		local old_fdir = math.floor(node.param2 % 32)
		local new_fdir = 3
		local new_name

		if old_fdir == 0 then
			new_fdir = 3
		elseif old_fdir == 1 then
			new_fdir = 4
		elseif old_fdir == 2 then
			new_fdir = 2
		elseif old_fdir == 3 then
			new_fdir = 5
		end

		local param2 = paletteidx + new_fdir

		if string.find(name, "regular") then
			new_name = "homedecor:bed_regular"
		elseif string.find(name, "extended") then
			new_name = "homedecor:bed_extended"
		else
			new_name = "homedecor:bed_kingsize"
		end

		minetest.set_node(pos, { name = new_name, param2 = param2 })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)
	end
})
