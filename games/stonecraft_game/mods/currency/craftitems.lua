-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_craftitem("currency:minegeld_cent_5", {
	description = S("@1 Minegeld cent coin", "5"),
	inventory_image = "minegeld_cent_5.png",
		stack_max = 1000,
		groups = {minegeld = 1, minegeld_coin = 1}
})

minetest.register_craftitem("currency:minegeld_cent_10", {
	description = S("@1 Minegeld cent coin", "10"),
	inventory_image = "minegeld_cent_10.png",
		stack_max = 1000,
		groups = {minegeld = 1, minegeld_coin = 1}
})

minetest.register_craftitem("currency:minegeld_cent_25", {
	description = S("@1 Minegeld cent coin", "25"),
	inventory_image = "minegeld_cent_25.png",
		stack_max = 1000,
		groups = {minegeld = 1, minegeld_coin = 1}
})

minetest.register_craftitem("currency:minegeld", {
	description = S("@1 Minegeld Note", "1"),
	inventory_image = "minegeld.png",
		stack_max = 65535,
		groups = {minegeld = 1, minegeld_note = 1}
})

minetest.register_craftitem("currency:minegeld_5", {
	description = S("@1 Minegeld Note", "5"),
	inventory_image = "minegeld_5.png",
		stack_max = 65535,
		groups = {minegeld = 1, minegeld_note = 1}
})

minetest.register_craftitem("currency:minegeld_10", {
	description = S("@1 Minegeld Note", "10"),
	inventory_image = "minegeld_10.png",
		stack_max = 65535,
		groups = {minegeld = 1, minegeld_note = 1}
})

minetest.register_craftitem("currency:minegeld_50", {
	description = S("@1 Minegeld Note", "50"),
	inventory_image = "minegeld_50.png",
		stack_max = 65535,
		groups = {minegeld = 1, minegeld_note = 1}
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
