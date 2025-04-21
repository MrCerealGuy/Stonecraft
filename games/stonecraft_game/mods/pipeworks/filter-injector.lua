local S = minetest.get_translator("pipeworks")
local fs_helpers = pipeworks.fs_helpers

local function set_filter_infotext(data, meta)
	local infotext = S("@1 Filter-Injector", data.wise_desc)
	if meta:get_int("slotseq_mode") == 2 then
		infotext = infotext .. " "..S("(slot #@1 next)", meta:get_int("slotseq_index"))
	end
	meta:set_string("infotext", infotext)
end

local function set_filter_formspec(data, meta)
	local itemname = S("@1 Filter-Injector", data.wise_desc)

	local formspec
	if data.digiline then
		local form_height = 3
		if pipeworks.enable_item_tags then
			form_height = 4
		end
		formspec =
			("size[8.5,%f]"):format(form_height) ..
			"item_image[0.2,0;1,1;pipeworks:"..data.name.."]"..
			"label[1.2,0.2;"..minetest.formspec_escape(itemname).."]"..
			"field[0.5,1.6;4.6,1;channel;"..S("Channel")..";${channel}]"..
			"button[4.8,1.3;1.5,1;set_channel;"..S("Set").."]"..
			fs_helpers.cycling_button(meta, ("button[0.2,%f;4.05,1"):format(form_height - 0.7), "slotseq_mode",
				{S("Sequence slots by Priority"),
				 S("Sequence slots Randomly"),
				 S("Sequence slots by Rotation")})..
			fs_helpers.cycling_button(meta, ("button[4.25,%f;4.05,1"):format(form_height - 0.7), "exmatch_mode",
				{S("Exact match - off"),
				 S("Exact match - on")})..
			("button_exit[6.3,%f;2,1;close;" .. S("Close") .. "]"):format(form_height - 1.7)
		if pipeworks.enable_item_tags then
			formspec = formspec ..
				("field[0.5,%f;4.6,1;item_tags;"):format(form_height - 1.4) .. S("Item Tags") .. ";${item_tags}]" ..
				("button[4.8,%f;1.5,1;set_item_tags;"):format(form_height - 1.7) .. S("Set") .. "]"
		end
	else
		local exmatch_button = ""
		if data.stackwise then
			exmatch_button =
				fs_helpers.cycling_button(meta, "button["..(10.2-(0.22)-4)..",4.5;4,1", "exmatch_mode",
					{S("Exact match - off"),
					 S("Exact match - on")})
		end
		local size = "10.2,11"
		local list_backgrounds = ""
		if minetest.get_modpath("i3") or minetest.get_modpath("mcl_formspec") then
			list_backgrounds = "style_type[box;colors=#666]"
			for i=0, 7 do
				for j=0, 1 do
					list_backgrounds = list_backgrounds .. "box[".. 0.22+(i*1.25) ..",".. 1.75+(j*1.25) ..";1,1;]"
				end
			end
		end
		formspec =
			"formspec_version[2]"..
			"size["..size.."]"..
			pipeworks.fs_helpers.get_prepends(size)..
			"item_image[0.22,0.22;1,1;pipeworks:"..data.name.."]"..
			"label[1.22,0.72;"..minetest.formspec_escape(itemname).."]"..
			"label[0.22,1.5;"..S("Prefer item types:").."]"..
			list_backgrounds..
			"list[context;main;0.22,1.75;8,2;]"..
			fs_helpers.cycling_button(meta, "button[0.22,4.5;4,1", "slotseq_mode",
				{S("Sequence slots by Priority"),
				 S("Sequence slots Randomly"),
				 S("Sequence slots by Rotation")})..
			exmatch_button..
			pipeworks.fs_helpers.get_inv(6)..
			"listring[]"
		if pipeworks.enable_item_tags then
			formspec = formspec ..
				"field[5.8,0.5;3,0.8;item_tags;" .. S("Item Tags") .. ";${item_tags}]" ..
				"button[9,0.3;1,1.1;set_item_tags;" .. S("Set") .. "]"
		end
	end
	meta:set_string("formspec", formspec)
end

local function punch_filter(data, filtpos, filtnode, msg)
	local filtmeta = minetest.get_meta(filtpos)
	local filtinv = filtmeta:get_inventory()
	local owner = filtmeta:get_string("owner")
	local fakeplayer = fakelib.create_player(owner)
	local dir = pipeworks.facedir_to_right_dir(filtnode.param2)
	local frompos = vector.subtract(filtpos, dir)
	local fromnode = minetest.get_node(frompos)
	if not fromnode then return end
	local fromdef = minetest.registered_nodes[fromnode.name]
	if not fromdef or not fromdef.tube then return end
	local fromtube = table.copy(fromdef.tube)
	local input_special_cases = {
		["technic:mv_electric_furnace"] = "dst",
		["technic:mv_electric_furnace_active"] = "dst",
		["technic:mv_alloy_furnace"] = "dst",
		["technic:mv_alloy_furnace_active"] = "dst",
		["technic:mv_centrifuge"] = "dst",
		["technic:mv_centrifuge_active"] = "dst",
		["technic:mv_compressor"] = "dst",
		["technic:mv_compressor_active"] = "dst",
		["technic:mv_extractor"] = "dst",
		["technic:mv_extractor_active"] = "dst",
		["technic:mv_grinder"] = "dst",
		["technic:mv_grinder_active"] = "dst",
		["technic:tool_workshop"] = "src",
		["technic:mv_freezer"] = "dst",
		["technic:mv_freezer_active"] = "dst",
		["technic:hv_electric_furnace"] = "dst",
		["technic:hv_electric_furnace_active"] = "dst",
		["technic:hv_compressor"] = "dst",
		["technic:hv_compressor_active"] = "dst",
		["technic:hv_grinder"] = "dst",
		["technic:hv_grinder_active"] = "dst"
	}

	-- make sure there's something appropriate to inject the item into
	local todir = pipeworks.facedir_to_right_dir(filtnode.param2)
	local topos = vector.add(filtpos, todir)
	local tonode = minetest.get_node(topos)
	local todef = minetest.registered_nodes[tonode.name]

	if not todef
	  or not (minetest.get_item_group(tonode.name, "tube") == 1
			  or minetest.get_item_group(tonode.name, "tubedevice") == 1
			  or minetest.get_item_group(tonode.name, "tubedevice_receiver") == 1) then
		return
	end

	if fromtube then fromtube.input_inventory = input_special_cases[fromnode.name] or fromtube.input_inventory end
	if not (fromtube and fromtube.input_inventory) then return end

	local slotseq_mode
	local exmatch_mode

	local item_tags = pipeworks.sanitize_tags(filtmeta:get_string("item_tags"))
	local filters = {}
	if data.digiline then
		local function add_filter(name, group, count, wear, metadata)
			table.insert(filters, {name = name, group = group, count = tonumber(count), wear = wear, metadata = metadata})
		end

		local function add_itemstring_filter(filter)
			local filterstack = ItemStack(filter)
			local filtername = filterstack:get_name()
			local filtercount = filterstack:get_count()
			local filterwear = string.match(filter, "%S*:%S*%s%d%s(%d)") and filterstack:get_wear()
			local filtermetadata = string.match(filter, "%S*:%S*%s%d%s%d(%s.*)") and filterstack:get_metadata()

			add_filter(filtername, nil, filtercount, filterwear, filtermetadata)
		end

		local t_msg = type(msg)
		if t_msg == "table" then
			local slotseq = msg.slotseq
			local t_slotseq = type(slotseq)
			if t_slotseq == "number" and slotseq >= 0 and slotseq <= 2 then
				slotseq_mode = slotseq
			elseif t_slotseq == "string" then
				slotseq = string.lower(slotseq)
				if slotseq == "priority" then
					slotseq_mode = 0
				elseif slotseq == "random" then
					slotseq_mode = 1
				elseif slotseq == "rotation" then
					slotseq_mode = 2
				end
			end

			local exmatch = msg.exmatch
			local t_exmatch = type(exmatch)
			if t_exmatch == "number" and (exmatch == 0 or exmatch == 1) then
				exmatch_mode = exmatch
			elseif t_exmatch == "boolean" then
				exmatch_mode = exmatch and 1 or 0
			end

			local slotseq_index = msg.slotseq_index
			if type(slotseq_index) == "number" then
				-- This should allow any valid index, but I'm not completely sure what
				-- constitutes a valid index, so I'm only allowing resetting it to 1.
				if slotseq_index == 1 then
					filtmeta:set_int("slotseq_index", slotseq_index)
					set_filter_infotext(data, filtmeta)
				end
			end

			if slotseq_mode ~= nil then
				filtmeta:set_int("slotseq_mode", slotseq_mode)
			end

			if exmatch_mode ~= nil then
				filtmeta:set_int("exmatch_mode", exmatch_mode)
			end

			if slotseq_mode ~= nil or exmatch_mode ~= nil then
				set_filter_formspec(data, filtmeta)
			end

			if pipeworks.enable_item_tags then
				if type(msg.tags) == "table" or type(msg.tags) == "string" then
					item_tags = pipeworks.sanitize_tags(msg.tags)
				elseif type(msg.tag) == "string" then
					item_tags = pipeworks.sanitize_tags({msg.tag})
				end
			end

			if msg.nofire then
				return
			end

			if msg.name or msg.group or msg.count or msg.wear or msg.metadata then
				add_filter(msg.name, msg.group, msg.count, msg.wear, msg.metadata)
			else
				for _, filter in ipairs(msg) do
					local t_filter = type(filter)
					if t_filter == "table" then
						if filter.name or filter.group or filter.count or filter.wear or filter.metadata then
							add_filter(filter.name, filter.group, filter.count, filter.wear, filter.metadata)
						end
					elseif t_filter == "string" then
						add_itemstring_filter(filter)
					end
				end
			end
		elseif t_msg == "string" then
			add_itemstring_filter(msg)
		end
	else
		for _, filterstack in ipairs(filtinv:get_list("main")) do
			local filtername = filterstack:get_name()
			local filtercount = filterstack:get_count()
			if filtername ~= "" then table.insert(filters, {name = filtername, count = filtercount}) end
		end
	end
	if #filters == 0 then table.insert(filters, "") end

	if slotseq_mode == nil then
		slotseq_mode = filtmeta:get_int("slotseq_mode")
	end

	if exmatch_mode == nil then
		exmatch_mode = filtmeta:get_int("exmatch_mode")
	end

	local frominv
	if fromtube.return_input_invref then
		frominv = fromtube.return_input_invref(frompos, fromnode, dir, owner)
		if not frominv then
			return
		end
	else
		local frommeta = minetest.get_meta(frompos)
		frominv = frommeta:get_inventory()
	end
	if fromtube.before_filter then fromtube.before_filter(frompos) end

	local function grabAndFire(frominvname, filterfor)
		local sposes = {}
		if not frominvname or not frominv:get_list(frominvname) then return end
		for spos,stack in ipairs(frominv:get_list(frominvname)) do
			local matches
			if filterfor == "" then
				matches = stack:get_name() ~= ""
			else
				local fname = filterfor.name
				local fgroup = filterfor.group
				local fwear = filterfor.wear
				local fmetadata = filterfor.metadata
				matches = (not fname                                             -- If there's a name filter,
				           or stack:get_name() == fname)                         --  it must match.

				          and (not fgroup                                        -- If there's a group filter,
				               or (type(fgroup) == "string"                      --  it must be a string
				                   and minetest.get_item_group(                  --  and it must match.
				                                stack:get_name(), fgroup) ~= 0))

				          and (not fwear                                         -- If there's a wear filter:
				               or (type(fwear) == "number"                       --  If it's a number,
				                   and stack:get_wear() == fwear)                --   it must match.
				               or (type(fwear) == "table"                        --  If it's a table:
				                   and (not fwear[1]                             --   If there's a lower bound,
				                        or (type(fwear[1]) == "number"           --    it must be a number
				                            and fwear[1] <= stack:get_wear()))   --    and it must be <= the actual wear.
				                   and (not fwear[2]                             --   If there's an upper bound
				                        or (type(fwear[2]) == "number"           --    it must be a number
				                            and stack:get_wear() < fwear[2]))))  --    and it must be > the actual wear.
				                                                                 --  If the wear filter is of any other type, fail.

				          and (not fmetadata                                     -- If there's a metadata filter,
				               or (type(fmetadata) == "string"                   --  it must be a string
				                   and stack:get_metadata() == fmetadata))       --  and it must match.
			end
			if matches then table.insert(sposes, spos) end
		end
		if #sposes == 0 then return false end
		if slotseq_mode == 1 then
			for i = #sposes, 2, -1 do
				local j = math.random(i)
				local t = sposes[j]
				sposes[j] = sposes[i]
				sposes[i] = t
			end
		elseif slotseq_mode == 2 then
			local headpos = filtmeta:get_int("slotseq_index")
			table.sort(sposes, function (a, b)
				if a >= headpos then
					if b < headpos then return true end
				else
					if b >= headpos then return false end
				end
				return a < b
			end)
		end
		for _, spos in ipairs(sposes) do
			local stack = frominv:get_stack(frominvname, spos)
			local doRemove = stack:get_count()
			if fromtube.can_remove then
				doRemove = fromtube.can_remove(frompos, fromnode, stack, dir, frominvname, spos)
			elseif fromdef.allow_metadata_inventory_take then
				doRemove = fromdef.allow_metadata_inventory_take(frompos, frominvname, spos, stack, fakeplayer)
			end
			-- stupid lack of continue statements grumble
			if doRemove > 0 then
				if slotseq_mode == 2 then
					local nextpos = spos + 1
					if nextpos > frominv:get_size(frominvname) then
						nextpos = 1
					end
					filtmeta:set_int("slotseq_index", nextpos)
					set_filter_infotext(data, filtmeta)
				end
				local item
				local count
				if data.stackwise then
					count = math.min(stack:get_count(), doRemove)
					if filterfor.count and (filterfor.count > 1 or data.digiline) then
						if exmatch_mode ~= 0 and filterfor.count > count then
							return false -- not enough, fail
						else
							-- limit quantity to filter amount
							count = math.min(filterfor.count, count)
						end
					end
				else
					count = 1
				end
				if fromtube.remove_items then
					-- it could be the entire stack...
					item = fromtube.remove_items(frompos, fromnode, stack, dir, count, frominvname, spos)
				else
					item = stack:take_item(count)
					frominv:set_stack(frominvname, spos, stack)
					if fromdef.on_metadata_inventory_take then
						fromdef.on_metadata_inventory_take(frompos, frominvname, spos, item, fakeplayer)
					end
				end
				local pos = vector.add(frompos, vector.multiply(dir, 1.4))
				local start_pos = vector.add(frompos, dir)
				pipeworks.tube_inject_item(pos, start_pos, dir, item,
					fakeplayer:get_player_name(), item_tags)
				return true -- only fire one item, please
			end
		end
		return false
	end

	for _, frominvname in ipairs(type(fromtube.input_inventory) == "table" and fromtube.input_inventory or {fromtube.input_inventory}) do
		local done = false
		for _, filterfor in ipairs(filters) do
			if grabAndFire(frominvname, filterfor) then
				done = true
				break
			end
		end
		if done then break end
	end
	if fromtube.after_filter then fromtube.after_filter(frompos) end
end

for _, data in ipairs({
	{
		name = "filter",
		wise_desc = S("Itemwise"),
		stackwise = false,
	},
	{
		name = "mese_filter",
		wise_desc = S("Stackwise"),
		stackwise = true,
	},
	{ -- register even if no digilines
		name = "digiline_filter",
		wise_desc = S("Digiline"),
		stackwise = true,
		digiline = true,
	},
}) do
	local node = {
		description = S("@1 Filter-Injector", data.wise_desc),
		tiles = {
			"pipeworks_"..data.name.."_top.png",
			"pipeworks_"..data.name.."_top.png",
			"pipeworks_"..data.name.."_output.png",
			"pipeworks_"..data.name.."_input.png",
			"pipeworks_"..data.name.."_side.png",
			"pipeworks_"..data.name.."_top.png",
		},
		paramtype2 = "facedir",
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, mesecon = 2, axey=1, handy=1, pickaxey=1},
		is_ground_content = false,
		_mcl_hardness=0.8,
		legacy_facedir_simple = true,
		_sound_def = {
			key = "node_sound_wood_defaults",
		},
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			set_filter_formspec(data, meta)
			set_filter_infotext(data, meta)
			local inv = meta:get_inventory()
			inv:set_size("main", 8*2)
		end,
		after_place_node = function (pos, placer)
			minetest.get_meta(pos):set_string("owner", placer:get_player_name())
			pipeworks.after_place(pos)
		end,
		after_dig_node = pipeworks.after_dig,
		on_rotate = pipeworks.on_rotate,
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			if not pipeworks.may_configure(pos, player) then
				return 0
			end
			local inv = minetest.get_meta(pos):get_inventory()
			inv:set_stack("main", index, stack)
			return 0
		end,
		allow_metadata_inventory_take = function(pos, listname, index, stack, player)
			if not pipeworks.may_configure(pos, player) then
				return 0
			end
			local inv = minetest.get_meta(pos):get_inventory()
			local fake_stack = inv:get_stack("main", index)
			fake_stack:take_item(stack:get_count())
			inv:set_stack("main", index, fake_stack)
			return 0
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			if not pipeworks.may_configure(pos, player) then return 0 end
			return count
		end,
		tube = {connect_sides = {right = 1}},
	}

	if data.digiline then
		node.groups.mesecon = nil
		if not minetest.get_modpath("digilines") then
			node.groups.not_in_creative_inventory = 1
		end

		node.on_receive_fields = function(pos, formname, fields, sender)
			if (fields.quit and not fields.key_enter_field)
			or not pipeworks.may_configure(pos, sender) then
				return
			end

			fs_helpers.on_receive_fields(pos, fields)

			if fields.channel and (fields.key_enter_field == "channel" or fields.set_channel) then
				minetest.get_meta(pos):set_string("channel", fields.channel)
			end

			local meta = minetest.get_meta(pos)
			if pipeworks.enable_item_tags and fields.item_tags and (fields.key_enter_field == "item_tags" or fields.set_item_tags) then
				local tags = pipeworks.sanitize_tags(fields.item_tags)
				meta:set_string("item_tags", table.concat(tags, ","))
			end
			--meta:set_int("slotseq_index", 1)
			set_filter_formspec(data, meta)
			set_filter_infotext(data, meta)
		end
		node.digiline = {
			effector = {
				action = function(pos, node, channel, msg)
					local meta = minetest.get_meta(pos)
					local setchan = meta:get_string("channel")
					if setchan ~= channel then return end

					punch_filter(data, pos, node, msg)
				end,
			},
		}
	else
		node.on_receive_fields = function(pos, formname, fields, sender)
			if not pipeworks.may_configure(pos, sender) then return end
			fs_helpers.on_receive_fields(pos, fields)
			local meta = minetest.get_meta(pos)
			meta:set_int("slotseq_index", 1)
			if pipeworks.enable_item_tags and fields.item_tags and (fields.key_enter_field == "item_tags" or fields.set_item_tags) then
				local tags = pipeworks.sanitize_tags(fields.item_tags)
				meta:set_string("item_tags", table.concat(tags, ","))
			end
			set_filter_formspec(data, meta)
			set_filter_infotext(data, meta)
		end
		node.mesecons = {
			effector = {
				action_on = function(pos, node)
					punch_filter(data, pos, node)
				end,
			},
		}
		node.on_punch = function (pos, node, puncher)
			punch_filter(data, pos, node)
		end
	end



	minetest.register_node("pipeworks:"..data.name, node)
	pipeworks.ui_cat_tube_list[#pipeworks.ui_cat_tube_list+1] = "pipeworks:"..data.name
end

--[[
In the past the filter-injectors had real items in their inventories. This code
puts them to the input to the filter-injector if possible. Else the items are
dropped.
]]
local function put_to_inputinv(pos, node, filtmeta, list)
	local dir = pipeworks.facedir_to_right_dir(node.param2)
	local frompos = vector.subtract(pos, dir)
	local fromnode = minetest.get_node(frompos)
	local fromdef = minetest.registered_nodes[fromnode.name]
	if not fromdef or not fromdef.tube then
		return
	end
	local fromtube = fromdef.tube
	local frominv
	if fromtube.return_input_invref then
		local owner = filtmeta:get_string("owner")
		frominv = fromtube.return_input_invref(frompos, fromnode, dir, owner)
		if not frominv then
			return
		end
	else
		frominv = minetest.get_meta(frompos):get_inventory()
	end
	local listname = type(fromtube.input_inventory) == "table" and
			fromtube.input_inventory[1] or fromtube.input_inventory
	if not listname then
		return
	end
	for i = 1, #list do
		local item = list[i]
		if not item:is_empty() then
			local leftover = frominv:add_item(listname, item)
			if not leftover:is_empty() then
				minetest.add_item(pos, leftover)
			end
		end
	end
	return true
end
minetest.register_lbm({
	label = "Give back items of old filters that had real inventories",
	name = "pipeworks:give_back_old_filter_items",
	nodenames = {"pipeworks:filter", "pipeworks:mese_filter"},
	run_at_every_load = false,
	action = function(pos, node)
		local meta = minetest.get_meta(pos)
		local list = meta:get_inventory():get_list("main")
		if put_to_inputinv(pos, node, meta, list) then
			return
		end
		pos.y = pos.y + 1
		for i = 1, #list do
			local item = list[i]
			if not item:is_empty() then
				minetest.add_item(pos, item)
			end
		end
	end,
})
