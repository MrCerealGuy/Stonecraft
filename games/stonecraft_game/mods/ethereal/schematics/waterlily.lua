
-- waterlily

ethereal.waterlily = {

	size = {x = 1, y = 3, z = 1},

	data = {
		{name = "default:sand", param1 = 255},
		{name = "default:water_source", param1 = 255},
		{name = "flowers:waterlily", param1 = 255},
	}
}


if ethereal.lilywalk == true then

	minetest.override_item("flowers:waterlily", {walkable = true})

	if minetest.registered_nodes["flowers:waterlily_waving"] then

		minetest.override_item("flowers:waterlily_waving", {walkable = true})
	end
end
