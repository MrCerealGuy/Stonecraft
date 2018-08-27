-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_craftitem("currency:minegeld", {
    description = S("1 MineGeld Note"),
    inventory_image = "minegeld.png",
        stack_max = 30000,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_5", {
    description = S("5 MineGeld Note"),
    inventory_image = "minegeld_5.png",
        stack_max = 30000,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_10", {
    description = S("10 MineGeld Note"),
    inventory_image = "minegeld_10.png",
        stack_max = 30000,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_50", {
    description = S("50 MineGeld Note"),
    inventory_image = "minegeld_50.png",
        stack_max = 30000,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_bundle", {
    description = S("Bundle of random Minegeld notes"),
    inventory_image = "minegeld_bundle.png",
        stack_max = 30000,
})
