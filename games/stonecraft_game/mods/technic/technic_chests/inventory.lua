
-- Table to define order of type sorting
local itemtypes = {
	node = 1,
	tool = 2,
	craft = 3,
	none = 4
}

function technic.chests.sort_inv(inv, mode)
	local list = inv:get_list("main")
	if not list then return end
	local items = {}
	for _,stack in pairs(list) do
		if not stack:is_empty() then
			local name = stack:get_name()
			local wear = stack:get_wear()
			local meta = stack:get_metadata()
			local count = stack:get_count()
			local def = minetest.registered_items[name]
			local itemtype = (def and itemtypes[def.type]) and def.type or "none"
			local key = string.format("%s %05d %s", name, wear, meta)
			if not items[key] then
				items[key] = {
					stacks = {stack},
					wear = wear,
					count = count,
					itemtype = itemtype,
					key = key,
				}
			else
				items[key].count = items[key].count + count
				table.insert(items[key].stacks, stack)
			end
		end
	end
	local unique_items = {}
	for k,v in pairs(items) do
		table.insert(unique_items, v)
	end
	if mode == 1 then
		-- Quantity
		table.sort(unique_items, function(a, b)
			if a.count ~= b.count then
				return a.count > b.count
			end
			return a.key < b.key
		end)
	elseif mode == 2 then
		-- Type
		table.sort(unique_items, function(a, b)
			if itemtypes[a.itemtype] ~= itemtypes[b.itemtype] then
				return itemtypes[a.itemtype] < itemtypes[b.itemtype]
			end
			return a.key < b.key
		end)
	elseif mode == 3 then
		-- Wear
		table.sort(unique_items, function(a, b)
			if a.itemtype == "tool" and b.itemtype == "tool" then
				if a.wear ~= b.wear then
					return a.wear < b.wear
				end
				return a.key < b.key
			elseif a.itemtype == "tool" or b.itemtype == "tool" then
				return a.itemtype == "tool"
			end
			return a.key < b.key
		end)
	else
		-- Item
		table.sort(unique_items, function(a, b)
			return a.key < b.key
		end)
	end
	inv:set_list("main", {})
	for _,item in ipairs(unique_items) do
		for _,stack in ipairs(item.stacks) do
			inv:add_item("main", stack)
		end
	end
end

function technic.chests.get_inv_items(inv)
	local list = inv:get_list("main")
	if not list then return {} end
	local keys = {}
	for _,stack in pairs(list) do
		if not stack:is_empty() then
			keys[stack:get_name()] = true
		end
	end
	local items = {}
	for k,_ in pairs(keys) do
		items[#items + 1] = k
	end
	return items
end

function technic.chests.move_inv(from_inv, to_inv, filter)
	local list = from_inv:get_list("main")
	if not list then return {} end
	local moved_items = {}
	for i,stack in ipairs(list) do
		if not stack:is_empty() then
			local move_stack = false
			local name = stack:get_name()
			if name == filter or not filter then
				move_stack = true
			elseif type(filter) == "table" then
				for _,k in pairs(filter) do
					if name == k then
						move_stack = true
						break
					end
				end
			end
			if move_stack then
				local leftover = to_inv:add_item("main", stack)
				if not leftover:is_empty() then
					from_inv:set_stack("main", i, leftover)
					stack:set_count(stack:get_count() - leftover:get_count())
				else
					from_inv:set_stack("main", i, "")
				end
				table.insert(moved_items, stack:to_table())
			end
		end
	end
	return moved_items
end

function technic.chests.log_inv_change(pos, name, change, items)
	local spos = minetest.pos_to_string(pos)
	if change == "move" then
		minetest.log("action", name.." moves "..items.." in chest at "..spos)
	elseif change == "put" then
		minetest.log("action", name.." puts "..items.." into chest at "..spos)
	elseif change == "take" then
		minetest.log("action", name.." takes "..items.." from chest at "..spos)
	end
end
