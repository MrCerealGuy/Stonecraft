
-- add lucky blocks

local function growy(pos, player)

	local dpos = minetest.find_node_near(pos, 1, "group:soil")

	if dpos then
		bonemeal:on_use(dpos, 5)
	end
end


if minetest.get_modpath("lucky_block") then

	lucky_block:add_blocks({
		{"lig"},
		{"dro", {"bonemeal:mulch"}, 10},
		{"dro", {"bonemeal:bonemeal"}, 10},
		{"dro", {"bonemeal:fertiliser"}, 10},
		{"cus", growy},
	})

end
