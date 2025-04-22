
local S = minetest.get_translator("farming")

--= A nice addition from Ademant's grain mod :)

-- Rye

farming.register_plant("farming:rye", {
	description = S("Rye seed"),
	paramtype2 = "meshoptions",
	inventory_image = "farming_rye_seed.png",
	steps = 8,
	place_param2 = 3
})

-- override rye item

minetest.override_item("farming:rye", {
	description = S("Rye"),
	groups = {food_rye = 1, flammable = 4, compostability = 65}
})

-- override rye crop

minetest.override_item("farming:rye_1", {drop = {}})
minetest.override_item("farming:rye_2", {drop = {}})
minetest.override_item("farming:rye_3", {drop = {}})
minetest.override_item("farming:rye_4", {drop = {}})
minetest.override_item("farming:rye_5", {drop = {}})

-- Oats

farming.register_plant("farming:oat", {
	description = S("Oat seed"),
	paramtype2 = "meshoptions",
	inventory_image = "farming_oat_seed.png",
	steps = 8,
	place_param2 = 3
})

-- override oat item

minetest.override_item("farming:oat", {
	description = S("Oats"),
	groups = {food_oats = 1, flammable = 4, compostability = 65}
})

-- override oat crop

minetest.override_item("farming:oat_1", {drop = {}})
minetest.override_item("farming:oat_2", {drop = {}})
minetest.override_item("farming:oat_3", {drop = {}})
minetest.override_item("farming:oat_4", {drop = {}})
minetest.override_item("farming:oat_5", {drop = {}})
