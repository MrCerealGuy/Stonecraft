
function technic.chests.send_digiline_message(pos, event, player, items)
	local set_channel = minetest.get_meta(pos):get_string("channel")
	local player_name = player and player:get_player_name() or ""
	digilines.receptor_send(pos, digilines.rules.default, set_channel, {
		event = event,
		items = items,
		player = player_name,
		pos = pos
	})
end

local function item_matches(item, stack)
	-- Same macthing as pipeworks filter injector
	local name = stack:get_name()
	local wear = stack:get_wear()
	return (not item.name or name == item.name)
			and (not item.group or (type(item.group) == "string" and minetest.get_item_group(name, item.group) ~= 0))
			and (not item.wear or (type(item.wear) == "number" and wear == item.wear) or (type(item.wear) == "table"
			and (not item.wear[1] or (type(item.wear[1]) == "number" and item.wear[1] <= wear))
			and (not item.wear[2] or (type(item.wear[2]) == "number" and wear < item.wear[2]))))
			and (not item.metadata or (type(item.metadata) == "string" and stack:get_metadata() == item.metadata))
end

function technic.chests.digiline_effector(pos, _, channel, msg)
	local meta = minetest.get_meta(pos)
	local set_channel = meta:get_string("channel")
	if channel ~= set_channel then
		return
	end
	if type(msg) ~= "table" or not msg.command then
		return
	end
	local inv = meta:get_inventory()

	if msg.command == "sort" then
		technic.chests.sort_inv(inv, meta:get_int("sort_mode"))

	elseif msg.command == "is_empty" then
		local empty = inv:is_empty("main")
		digilines.receptor_send(pos, digilines.rules.default, set_channel, empty)

	elseif msg.command == "get_list" then
		local inv_table = {}
		local list = inv:get_list("main")
		if list then
			for _,stack in ipairs(list) do
				if not stack:is_empty() then
					table.insert(inv_table, stack:get_name().." "..stack:get_count())
				else
					table.insert(inv_table, "")
				end
			end
		end
		digilines.receptor_send(pos, digilines.rules.default, set_channel, inv_table)

	elseif msg.command == "get_stack" and type(msg.index) == "number" then
		local stack = inv:get_stack("main", msg.index):to_table()
		digilines.receptor_send(pos, digilines.rules.default, set_channel, stack)

	elseif msg.command == "contains_item" and (type(msg.item) == "string" or type(msg.item) == "table") then
		local contains = inv:contains_item("main", msg.item)
		digilines.receptor_send(pos, digilines.rules.default, set_channel, contains)

	elseif msg.command == "room_for_item" and (type(msg.item) == "string" or type(msg.item) == "table") then
		local room = inv:room_for_item("main", msg.item)
		digilines.receptor_send(pos, digilines.rules.default, set_channel, room)

	elseif msg.command == "count_item" and (type(msg.item) == "string" or type(msg.item) == "table") then
		local count = 0
		local list = inv:get_list("main")
		if list then
			if type(msg.item) == "string" then
				local itemstack = ItemStack(msg.item)
				msg.item = {
					name = itemstack:get_name(),
					count = itemstack:get_count(),
					wear = string.match(msg.item, "%S*:%S*%s%d%s(%d)") and itemstack:get_wear(),
					metadata = string.match(msg.item, "%S*:%S*%s%d%s%d(%s.*)") and itemstack:get_meta():get_string("")
				}
			end
			for _,stack in pairs(list) do
				if not stack:is_empty() and item_matches(msg.item, stack) then
					count = count + stack:get_count()
				end
			end
			if msg.item.count and type(msg.item.count) == "number" and msg.item.count > 1 then
				count = math.floor(count / msg.item.count)
			end
		end
		digilines.receptor_send(pos, digilines.rules.default, set_channel, count)
	end
end
