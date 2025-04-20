-- support for i18n
local S = minetest.get_translator(minetest.get_current_modname())
local F = minetest.formspec_escape
local has_technic = minetest.get_modpath("technic") ~= nil

if not minetest.global_exists("unified_inventory") then
	minetest.log("warning", "3d_armor_ui: Mod loaded but unused.")
	return
end

local ui = unified_inventory
if ui.sfinv_compat_layer then
	return
end

armor:register_on_update(function(player)
	local name = player:get_player_name()
	if unified_inventory.current_page[name] == "armor" then
		unified_inventory.set_inventory_formspec(player, "armor")
	end
end)

unified_inventory.register_button("armor", {
	type = "image",
	image = "inventory_plus_armor.png",
	tooltip = S("3D Armor")
})

unified_inventory.register_page("armor", {
	get_formspec = function(player, perplayer_formspec)
		local fy = perplayer_formspec.form_header_y + 0.5
		local gridx = perplayer_formspec.std_inv_x
		local gridy = 0.6

		local name = player:get_player_name()
		local formspec = perplayer_formspec.standard_inv_bg..
			perplayer_formspec.standard_inv..
			ui.make_inv_img_grid(gridx, gridy, 2, 3)..
			string.format("label[%f,%f;%s]",
				perplayer_formspec.form_header_x, perplayer_formspec.form_header_y, F(S("Armor")))..
			string.format("list[detached:%s_armor;armor;%f,%f;2,3;]",
				name, gridx + ui.list_img_offset, gridy + ui.list_img_offset) ..
			"image[3.5,"..(fy - 0.25)..";2,4;"..armor.textures[name].preview.."]"..
			"label[6.0,"..(fy + 0.0)..";"..F(S("Level"))..": "..armor.def[name].level.."]"..
			"label[6.0,"..(fy + 0.5)..";"..F(S("Heal"))..":  "..armor.def[name].heal.."]"..
			"listring[current_player;main]"..
			"listring[detached:"..name.."_armor;armor]"
		if armor.config.fire_protect then
			formspec = formspec.."label[6.0,"..(fy + 1.0)..";"..
				F(S("Fire"))..":  "..armor.def[name].fire.."]"
		end
		if has_technic then
			formspec = formspec.."label[6.0,"..(fy + 1.5)..";"..
				F(S("Radiation"))..":  "..armor.def[name].groups["radiation"].."]"
		end
		return {formspec=formspec}
	end,
})
