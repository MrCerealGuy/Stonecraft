--[[

2017-05-15 MrCerealGuy: added intllib support

--]]


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_tool("vines:shears", {
  description = S("Shears"),
  inventory_image = "vines_shears.png",
  wield_image = "vines_shears.png",
  stack_max = 1,
  max_drop_level=3,
  tool_capabilities = {
    full_punch_interval = 1.0,
    max_drop_level=0,
    groupcaps={
      snappy={times={[3]=0.2}, maxwear=0.05, maxlevel=3},
      wool={times={[3]=0.2}, maxwear=0.05, maxlevel=3}
    }
  },
})
