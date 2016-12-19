
-- override default papyrus to make it walkable
minetest.override_item("default:papyrus", {walkable = true, sunlight_propagates = true})

-- have papyrus grow up to 4 high and bamboo grow up to 8 in height (shared abm)
minetest.register_abm({
	nodenames = {"default:papyrus", "ethereal:bamboo"},
	neighbors = {"group:soil"},
	interval = 14, --50,
	chance = 71, --20,
	catch_up = false,
	action = function(pos, node)

		local oripos = pos.y
		local high = 4

		pos.y = pos.y - 1

		local nod = minetest.get_node_or_nil(pos)

		if not nod
		or minetest.get_item_group(nod.name, "soil") < 1
		or minetest.find_node_near(pos, 3, {"group:water"}) == nil then
			return
		end

		if node.name == "ethereal:bamboo" then
			high = 8
		end

		pos.y = pos.y + 1

		local height = 0

		while height < high
		and minetest.get_node(pos).name == node.name do
			height = height + 1
			pos.y = pos.y + 1
		end

		nod = minetest.get_node_or_nil(pos)

		if nod
		and nod.name == "air"
		and height < high then

			if node.name == "ethereal:bamboo"
			and height == (high - 1) then

				ethereal.add_tree({
					x = pos.x,
					y = oripos,
					z = pos.z
				}, 1, 1, ethereal.bambootree)
			else
				minetest.swap_node(pos, {name = node.name})
			end
		end

	end,
})
