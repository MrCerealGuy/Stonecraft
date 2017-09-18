
local S = homedecor_i18n.gettext

local longsofa_cbox = {
	type = "wallmounted",
	wall_side   = {-0.5, -0.5, -0.5, 0.5, 0.5, 2.5},
}

minetest.register_node("lrfurn:longsofa", {
	description = S("Long Sofa"),
	drawtype = "mesh",
	mesh = "lrfurn_sofa_long.obj",
	tiles = {
		"lrfurn_upholstery.png",
		{ name = "lrfurn_sofa_bottom.png", color = 0xffffffff }
	},
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	inventory_image = "lrfurn_longsofa_inv.png",
	wield_scale = { x = 0.6, y = 0.6, z = 0.6 },
	groups = {snappy=3, ud_param2_colorable = 1},
	sounds = default.node_sound_wood_defaults(),
	selection_box = longsofa_cbox,
	node_box = longsofa_cbox,
	on_rotate = screwdriver.disallow,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		lrfurn.fix_sofa_rotation_nsew(pos, placer, itemstack, pointed_thing)
		unifieddyes.recolor_on_place(pos, placer, itemstack, pointed_thing)
		local playername = placer:get_player_name()
		if minetest.is_protected(pos, placer:get_player_name()) then return true end

		local fdir = minetest.dir_to_facedir(placer:get_look_dir(), false)

		if lrfurn.check_right(pos, fdir, true, placer) then
			if not creative.is_enabled_for(playername) then
				itemstack:take_item()
			end
		else
			minetest.chat_send_player(placer:get_player_name(), S("No room to place the sofa!"))
			minetest.set_node(pos, { name = "air" })
		end
		return itemstack
	end,
	after_dig_node = unifieddyes.after_dig_node,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if not clicker:is_player() then
			return itemstack
		end
		pos.y = pos.y-0.5
		clicker:setpos(pos)
		clicker:set_hp(20)
		return itemstack
	end
})

minetest.register_craft({
	output = "lrfurn:longsofa",
	recipe = {
		{"wool:white", "wool:white", "wool:white", },
		{"stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood", },
		{"group:stick", "group:stick", "group:stick", }
	}
})

minetest.register_craft({
	output = "lrfurn:longsofa",
	recipe = {
		{"wool:white", "wool:white", "wool:white", },
		{"moreblocks:slab_wood", "moreblocks:slab_wood", "moreblocks:slab_wood", },
		{"group:stick", "group:stick", "group:stick", }
	}
})

-- convert old static nodes to param2 colorization

lrfurn.old_static_longsofas = {}

for _, color in ipairs(lrfurn.colors) do
	table.insert(lrfurn.old_static_longsofas, "lrfurn:longsofa_"..color)
end

minetest.register_lbm({
	name = "lrfurn:convert_longsofas",
	label = "Convert lrfurn long sofas to use param2 color",
	run_at_every_load = false,
	nodenames = lrfurn.old_static_longsofas,
	action = function(pos, node)
		local name = node.name
		local color = string.sub(name, string.find(name, "_")+1)

		if color == "red" then
			color = "medium_red"
		elseif color == "dark_green" then
			color = "medium_green"
		elseif color == "magenta" then
			color = "medium_magenta"
		elseif color == "cyan" then
			color = "medium_cyan"
		end

		local paletteidx, _ = unifieddyes.getpaletteidx("unifieddyes:"..color, "wallmounted")
		local old_fdir = math.floor(node.param2 % 32)
		local new_fdir = 3

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

		minetest.set_node(pos, { name = "lrfurn:longsofa", param2 = param2 })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)

	end
})

if minetest.settings:get("log_mods") then
	minetest.log("action", "[lrfurn/longsofas] "..S("Loaded!"))
end
