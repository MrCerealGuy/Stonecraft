local ui = unified_inventory

local function default_refill(stack)
	stack:set_count(stack:get_stack_max())
	local itemdef = minetest.registered_items[stack:get_name()]
	if itemdef
	and (itemdef.wear_represents or "mechanical_wear") == "mechanical_wear"
	and stack:get_wear() ~= 0 then
		stack:set_wear(0)
	end
	return stack
end

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	unified_inventory.players[player_name] = {}
	unified_inventory.current_index[player_name] = 1 -- Item (~page) index
	unified_inventory.filtered_items_list[player_name] =
		unified_inventory.items_list
	unified_inventory.activefilter[player_name] = ""
	unified_inventory.active_search_direction[player_name] = "nochange"
	unified_inventory.current_searchbox[player_name] = ""
	unified_inventory.current_category[player_name] = "all"
	unified_inventory.current_category_scroll[player_name] = 0
	unified_inventory.alternate[player_name] = 1
	unified_inventory.current_item[player_name] = nil
	unified_inventory.current_craft_direction[player_name] = "recipe"

	-- Refill slot
	local refill = minetest.create_detached_inventory(player_name.."refill", {
		allow_put = function(inv, listname, index, stack, player)
			if unified_inventory.is_creative(player_name) then
				return stack:get_count()
			else
				return 0
			end
		end,
		on_put = function(inv, listname, index, stack, player)
			local handle_refill = (minetest.registered_items[stack:get_name()] or {}).on_refill or default_refill
			stack = handle_refill(stack)
			inv:set_stack(listname, index, stack)
			minetest.sound_play("electricity",
					{to_player=player_name, gain = 1.0})
		end,
	}, player_name)
	refill:set_size("main", 1)
end)

minetest.register_on_mods_loaded(function()
       minetest.register_on_joinplayer(function(player)
               -- After everything is initialized, set up the formspec
               ui.apply_filter(player, "", "nochange")
               ui.set_inventory_formspec(player, unified_inventory.default)
       end)
end)

local function apply_new_filter(player, search_text, new_dir)
	local player_name = player:get_player_name()

	minetest.sound_play("ui_click", {to_player=player_name, gain = 0.1})
	ui.apply_filter(player, search_text, new_dir)
	ui.current_searchbox[player_name] = search_text
	ui.set_inventory_formspec(player, ui.current_page[player_name])
end

-- Search box handling
local function receive_fields_searchbox(player, formname, fields)
	local player_name = player:get_player_name()

	-- always take new search text, even if not searching on it yet
	if fields.searchbox and fields.searchbox ~= ui.current_searchbox[player_name] then
		ui.current_searchbox[player_name] = fields.searchbox
	end

	if fields.searchbutton
			or fields.key_enter_field == "searchbox" then

		if ui.current_searchbox[player_name] ~= ui.activefilter[player_name] then
			ui.apply_filter(player, ui.current_searchbox[player_name], "nochange")
			ui.set_inventory_formspec(player, ui.current_page[player_name])
			minetest.sound_play("paperflip2",
					{to_player=player_name, gain = 1.0})
		end
	elseif fields.searchresetbutton then
		if ui.activefilter[player_name] ~= "" then
			apply_new_filter(player, "", "nochange")
		end
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "" then
		return
	end

	receive_fields_searchbox(player, formname, fields)

	local player_name = player:get_player_name()

	local ui_peruser,draw_lite_mode = unified_inventory.get_per_player_formspec(player_name)

	local clicked_category
	for name, value in pairs(fields) do
		local category_name = string.match(name, "^category_(.+)$")
		if category_name then
			clicked_category = category_name
			break
		end
	end

	if clicked_category
	and clicked_category ~= unified_inventory.current_category[player_name] then
		unified_inventory.current_category[player_name] = clicked_category
		unified_inventory.apply_filter(player, unified_inventory.current_searchbox[player_name], "nochange")
		unified_inventory.set_inventory_formspec(player,
				unified_inventory.current_page[player_name])
	end

	if fields.next_category or fields.prev_category then
		local step = fields.next_category and 1 or -1
		local scroll_old = ui.current_category_scroll[player_name]
		local scroll_new = math.max(0, math.min(#ui.category_list - ui_peruser.pagecols, scroll_old + step))

		if scroll_old ~= scroll_new then
			ui.current_category_scroll[player_name] = scroll_new
			ui.set_inventory_formspec(player,
					unified_inventory.current_page[player_name])
		end
	end

	for i, def in pairs(unified_inventory.buttons) do
		if fields[def.name] then
			def.action(player)
			minetest.sound_play("ui_click",
					{to_player=player_name, gain = 0.1})
			return
		end
	end

	-- Inventory page controls
	local start = math.floor(
		unified_inventory.current_index[player_name] / ui_peruser.items_per_page + 1)
	local start_i = start
	local pagemax = math.floor(
		(#unified_inventory.filtered_items_list[player_name] - 1)
		/ (ui_peruser.items_per_page) + 1)

	if fields.start_list then
		start_i = 1
	end
	if fields.rewind1 then
		start_i = start_i - 1
	end
	if fields.forward1 then
		start_i = start_i + 1
	end
	if fields.rewind3 then
		start_i = start_i - 3
	end
	if fields.forward3 then
		start_i = start_i + 3
	end
	if fields.end_list then
		start_i = pagemax
	end
	if start_i < 1 then
		start_i = 1
	end
	if start_i > pagemax then
		start_i = pagemax
	end
	if start_i ~= start then
		minetest.sound_play("paperflip1",
				{to_player=player_name, gain = 1.0})
		unified_inventory.current_index[player_name] = (start_i - 1) * ui_peruser.items_per_page + 1
		unified_inventory.set_inventory_formspec(player,
				unified_inventory.current_page[player_name])
	end

	-- Check clicked item image button
	local clicked_item
	for name, value in pairs(fields) do
		local new_dir, mangled_item = string.match(name, "^[0-9]*_?item_button_([a-z]+)_(.*)$")
		if new_dir and mangled_item then
			clicked_item = unified_inventory.demangle_for_formspec(mangled_item)
			if string.sub(clicked_item, 1, 6) == "group:" then
				-- Change search filter to this group
				unified_inventory.current_category[player_name] = "all"
				apply_new_filter(player, clicked_item, new_dir)
				return
			end
			if new_dir == "recipe" or new_dir == "usage" then
				unified_inventory.current_craft_direction[player_name] = new_dir
			end
			break
		end
	end
	if clicked_item then
		minetest.sound_play("ui_click",
				{to_player=player_name, gain = 0.1})
		local page = unified_inventory.current_page[player_name]
		local player_creative = unified_inventory.is_creative(player_name)
		if not player_creative then
			page = "craftguide"
		end
		if page == "craftguide" then
			unified_inventory.current_item[player_name] = clicked_item
			unified_inventory.alternate[player_name] = 1
			unified_inventory.set_inventory_formspec(player, "craftguide")
		elseif player_creative then
			-- Creative page: Add entire stack to inventory
			local inv = player:get_inventory()
			local stack = ItemStack(clicked_item)
			stack:set_count(stack:get_stack_max())
			if inv:room_for_item("main", stack) then
				inv:add_item("main", stack)
			end
		end
	end

	-- alternate buttons
	if not (fields.alternate or fields.alternate_prev) then
		return
	end
	minetest.sound_play("ui_click",
			{to_player=player_name, gain = 0.1})
	local item_name = unified_inventory.current_item[player_name]
	if not item_name then
		return
	end
	local crafts = unified_inventory.crafts_for[unified_inventory.current_craft_direction[player_name]][item_name]
	if not crafts then
		return
	end
	local alternates = #crafts
	if alternates <= 1 then
		return
	end
	local alternate
	if fields.alternate then
		alternate = unified_inventory.alternate[player_name] + 1
		if alternate > alternates then
			alternate = 1
		end
	elseif fields.alternate_prev then
		alternate = unified_inventory.alternate[player_name] - 1
		if alternate < 1 then
			alternate = alternates
		end
	end
	unified_inventory.alternate[player_name] = alternate
	unified_inventory.set_inventory_formspec(player,
			unified_inventory.current_page[player_name])
end)

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	minetest.remove_detached_inventory(player_name.."_bags")
	minetest.remove_detached_inventory(player_name.."refill")
end)
