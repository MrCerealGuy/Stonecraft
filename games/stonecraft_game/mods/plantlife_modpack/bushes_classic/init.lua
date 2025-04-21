-- Bushes classic mod originally by unknown
-- now maintained by VanessaE

bushes_classic = {}

-- support for i18n
local S = minetest.get_translator("bushes_classic")

bushes_classic.bushes = {
	"strawberry",
	"blackberry",
	"blueberry",
	"raspberry",
	"gooseberry",
	"mixed_berry"
}

bushes_classic.bushes_descriptions = {
	{S("Strawberry"),  S("Raw Strawberry pie"),  S("Cooked Strawberry pie"),  S("Slice of Strawberry pie"),  S("Basket with Strawberry pies"),  S("Strawberry Bush")},
	{S("Blackberry"),  S("Raw Blackberry pie"),  S("Cooked Blackberry pie"),  S("Slice of Blackberry pie"),  S("Basket with Blackberry pies"),  S("Blackberry Bush")},
	{S("Blueberry"),   S("Raw Blueberry pie"),   S("Cooked Blueberry pie"),   S("Slice of Blueberry pie"),   S("Basket with Blueberry pies"),   S("Blueberry Bush")},
	{S("Raspberry"),   S("Raw Raspberry pie"),   S("Cooked Raspberry pie"),   S("Slice of Raspberry pie"),   S("Basket with Raspberry pies"),   S("Raspberry Bush")},
	{S("Gooseberry"),  S("Raw Gooseberry pie"),  S("Cooked Gooseberry pie"),  S("Slice of Gooseberry pie"),  S("Basket with Gooseberry pies"),  S("Gooseberry Bush")},
	{S("Mixed Berry"), S("Raw Mixed Berry pie"), S("Cooked Mixed Berry pie"), S("Slice of Mixed Berry pie"), S("Basket with Mixed Berry pies"), S("Currently fruitless Bush")}
}

bushes_classic.spawn_list = {}

local modpath = minetest.get_modpath('bushes_classic')
dofile(modpath..'/cooking.lua')
dofile(modpath..'/nodes.lua')

local spawn_plants = bushes_classic.spawn_list

local function get_biome_data(pos, perlin_fertile)
	local fertility = perlin_fertile:get_2d({x=pos.x, y=pos.z})

	local data = minetest.get_biome_data(pos)
	-- Original values this method returned were +1 (lowest) to -1 (highest)
	-- so we need to convert the 0-100 range from get_biome_data() to that.
	return fertility, 1 - (data.heat / 100 * 2), 1 - (data.humidity / 100 * 2)
end

minetest.register_abm({
	nodenames = {
		"default:dirt_with_grass",
		"woodsoils:dirt_with_leaves_1",
		"woodsoils:grass_with_leaves_1",
		"woodsoils:grass_with_leaves_2",
		"farming:soil",
		"farming:soil_wet"
	},
	interval = 3600,
	chance = 100,
	label = "[bushes_classic] spawn bushes",
	min_y = -16,
	max_y = 48,
	action = function(pos, node)
		local p_top = {x = pos.x, y = pos.y + 1, z = pos.z}
		local n_top = minetest.get_node_or_nil(p_top)
		if not n_top or n_top.name ~= "air" then return end

		local perlin_fertile_area = minetest.get_perlin(545342534, 3, 0.6, 100)

		local fertility, temperature, humidity = get_biome_data(pos, perlin_fertile_area)

		local pos_biome_ok = fertility > -0.1 and temperature <= 0.15 and temperature >= -0.15 and humidity <= 0 and humidity >= -1
		if not pos_biome_ok then return end

		if minetest.find_node_near(p_top, 10 + math.random(-1.5,2), {"group:bush"}) then
			return -- Nodes to avoid are nearby
		end

		local plant_to_spawn = spawn_plants[math.random(1, #spawn_plants)]

		minetest.swap_node(p_top, {name = plant_to_spawn, param2 = 0})
	end
})

minetest.register_alias("bushes:basket_pies", "bushes:basket_strawberry")
