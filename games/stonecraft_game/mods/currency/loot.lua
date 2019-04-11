if not minetest.get_modpath("loot") then
	return
end

loot.register_loot({
	weights = { generic = 50 },
	payload = {
		stack = ItemStack("currency:minegeld"),
		min_size = 1,
		max_size = 250,
	},
})

loot.register_loot({
	weights = { generic = 50 },
	payload = {
		stack = ItemStack("currency:minegeld_5"),
		min_size = 1,
		max_size = 50,
	},
})

loot.register_loot({
	weights = { generic = 50 },
	payload = {
		stack = ItemStack("currency:minegeld_10"),
		min_size = 1,
		max_size = 10,
	},
})


loot.register_loot({
	weights = { generic = 50 },
	payload = {
		stack = ItemStack("currency:minegeld_50"),
		min_size = 1,
		max_size = 10,
	},
})

loot.register_loot({
	weights = { generic = 50 },
	payload = {
		stack = ItemStack("currency:minegeld_100"),
		min_size = 1,
		max_size = 10,
	},
})
