function aff_thermometer(pos, node)
	local temperature = math.floor(get_instant_temperature(pos))
	node.name = "forest:_thermometer_"..temperature
	minetest.set_node(pos, node)
end

minetest.register_node("forest:_thermometer_0", {
	description = "Thermometre",
	drawtype = "torchlike",
	tiles = {
		{name="thermometer_0b.png"},
		{name="thermometer_0b.png"},
		{name="thermometer_0b.png"},
	},
	inventory_image = "thermometer.png",
	wield_image = "thermometer.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	light_source = 3,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, -0.1, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, 0.1, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.2, 0.3, 0.1},
	},
	groups = {dig_immediate=3, thermometer=1, attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})

for i = 1, 20 do
minetest.register_node("forest:_thermometer_"..i, {
	description = "Thermometre",
	drawtype = "torchlike",
	tiles = {
		{name="thermometer_"..i.."b.png"},
		{name="thermometer_"..i.."b.png"},
		{name="thermometer_"..i.."b.png"}
	},
	inventory_image = "thermometer.png",
	wield_image = "thermometer.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	light_source = 3,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {dig_immediate=3, thermometer=1, not_in_creative_inventory=1, attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	drop = "forest:_thermometer_0",
})
end

minetest.register_abm({
	nodenames = {"group:thermometer"},
	interval = 10,
	chance = 1,
	action = aff_thermometer,
})
