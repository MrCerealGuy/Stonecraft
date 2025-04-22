local functions = {}

function functions.can_interact_with_node(player, pos)
	--if we have default, use it
	if default then return default.can_interact_with_node(player, pos) end

	local owner = minetest.get_meta(pos):get_string("owner") or ""

	--check that we have a valid player
	if not player or not player:is_player() then return false end
	--check there privs for compat with areas
	if minetest.check_player_privs(player, "protection_bypass") then return true end
	--if a normal player, check if they are the owner
	if owner == "" or owner == player:get_player_name() then return true end

	return false
end

function functions.sapling_on_place(
	itemstack, player, pointed_thing, sapling_name, minp_relative, maxp_relative, interval
)
	if default then
		return default.sapling_on_place(
			itemstack, player, pointed_thing, sapling_name, minp_relative, maxp_relative, interval
		)
	end

	local pos = pointed_thing.above
	local pname = player and player:get_player_name() or ""
	local below_node = minetest.get_node_or_nil(pointed_thing.under)

	if below_node and minetest.registered_items[below_node.name] and
		minetest.registered_items[below_node.name].buildable_to then

		pos = pointed_thing.under
	end

	--check protection
	if minetest.is_protected(pos, pname) then
		minetest.record_protection_violation(pos, pname)
		return itemstack
	end

	--actually place sapling
	minetest.set_node(pos, {name = sapling_name})

	--handle survival
	if not minetest.is_creative_enabled(pname) then
		itemstack:take_item()
	end

	return itemstack
end

return functions