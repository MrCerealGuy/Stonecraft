--[[

2017-05-15 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_craft({
  output = 'vines:rope_block',
  recipe = vines.recipes['rope_block']
})

minetest.register_craft({
  output = 'vines:shears',
  recipe = vines.recipes['shears']
})

minetest.register_craftitem("vines:vines", {
  description = S("Vines"),
  inventory_image = "vines_item.png",
})
