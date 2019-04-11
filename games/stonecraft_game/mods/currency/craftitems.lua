-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_craftitem("currency:minegeld_cent_5", {
	description = S("5 Minegeld cent coin"),
	inventory_image = "minegeld_cent_5.png",
		stack_max = 1000,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_cent_10", {
	description = S("10 Minegeld cent coin"),
	inventory_image = "minegeld_cent_10.png",
		stack_max = 1000,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_cent_25", {
	description = S("25 Minegeld cent coin"),
	inventory_image = "minegeld_cent_25.png",
		stack_max = 1000,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld", {
	description = S("1 Minegeld Note"),
	inventory_image = "minegeld.png",
		stack_max = 65535,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_5", {
	description = S("5 Minegeld Note"),
	inventory_image = "minegeld_5.png",
		stack_max = 65535,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_10", {
	description = S("10 Minegeld Note"),
	inventory_image = "minegeld_10.png",
		stack_max = 65535,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_50", {
	description = S("50 Minegeld Note"),
	inventory_image = "minegeld_50.png",
		stack_max = 65535,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_100", {
	description = S("100 Minegeld Note"),
	inventory_image = "minegeld_100.png",
		stack_max = 65535,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_bundle", {
	description = S("Bundle of random Minegeld notes"),
	inventory_image = "minegeld_bundle.png",
		stack_max = 65535,
})
