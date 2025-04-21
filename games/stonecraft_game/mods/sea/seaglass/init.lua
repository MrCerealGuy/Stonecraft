-- NODES

local repl = {
   ["off"] = "",
   ["on"] = "off",
}

local colors = {"yellow", "red", "blue", "white", "black"}

local function register_glass(suffix, color, cgroups)
   -- suffix : bool (false:off | true:on)
   local desc = "Seaglass "

   local col, c = "", ""
   if color and color ~= "" then
      col,c = color, "_"..color
      desc = desc..color.." "
   end

   local l, light, ls = "", "on", 7
   if not suffix then
      l,light = "off","off"
      ls = 0
   end

   desc = desc..light
   
   minetest.register_node(
      "seaglass:seaglass"..l..c,
      {
	 description = desc,
	 drawtype = "glasslike",
	 tiles = {"seaglass_seaglass"..c..".png"},
	 inventory_image = minetest.inventorycube("seaglass_seaglass"..c..".png"),
	 use_texture_alpha = "clip",
	 paramtype = "light",
	 sunlight_propagates = true,
	 light_source = ls,
	 is_ground_content = true,
	 drop = "seaglass:seaglassoff"..c,
	 groups = cgroups, -- {snappy=2,cracky=3,oddly_breakable_by_hand=3, nocolor=1, shine=1, not_in_creative_inventory=1},
	 sounds = default.node_sound_glass_defaults(),
	 on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
	    node.name = "seaglass:seaglass"..repl[light]..c
	    minetest.set_node(pos, node)
	 end,
      })

   stairs.register_stair_and_slab("seaglass"..l..c, "seaglass:seaglass"..l..c,
				       cgroups,
				       {"seaglass_seaglass"..c..".png"},
				       "Seaglass stair "..light.." "..col,
				       "Seaglass slab "..light.." "..col,
				       default.node_sound_glass_defaults())
   
   for _,i in ipairs({"slab", "stair", "stair_outer", "stair_inner"}) do
      minetest.override_item(
	 "stairs:"..i.."_seaglass"..l..c,
	 {
	    light_source = ls,
	    drop = "stairs:"..i.."_seaglassoff"..c,
	    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
	       node.name = "stairs:"..i.."_seaglass"..repl[light]..c
	       minetest.set_node(pos, node)
	    end
	 })
      if suffix then
	 minetest.register_alias("stairsshine:"..i.."_seaglass"..c, "stairs:"..i.."_seaglass"..c)
      end
   end
   
end

for _,color in ipairs(colors) do
   local groups_off = {noshine=1, snappy=2, cracky=3, oddly_breakable_by_hand=3}
   local groups_on = {not_in_creative_inventory=1, shine=1, snappy=2, cracky=3, oddly_breakable_by_hand=3}

   if color == "yellow" then
      groups_off.color_yellow = 1
      groups_on.color_yellow = 1
      groups_on.yellowshine = 1
   elseif color == "red" then
      groups_off.color_red = 1
      groups_on.color_red = 1
      groups_on.redshine = 1
   elseif color == "blue" then
      groups_off.color_blue = 1
      groups_on.color_blue = 1
      groups_on.blueshine = 1
   elseif color == "white" then
      groups_off.color_white = 1
      groups_on.color_white = 1
      groups_on.whiteshine = 1
   elseif color == "black" then
      groups_off.color_black = 1
      groups_on.color_black = 1
      groups_on.blackshine = 1
   end

   register_glass(false, color, groups_off)
   register_glass(true, color, groups_on)
end

register_glass(false, nil, {snappy=2,cracky=3,oddly_breakable_by_hand=3, nocolor=1, noshine=1})
register_glass(true, nil, {snappy=2,cracky=3,oddly_breakable_by_hand=3, nocolor=1, shine=1, not_in_creative_inventory=1})


-- CRAFTING


local register_seaglass_craft = function(output,recipe)
    minetest.register_craft({
        type = 'shapeless',
        output = output,
        recipe = recipe,
	})
end

register_seaglass_craft("seaglass:seaglassoff", {'clams:collectedalgae', 'default:glass'})

register_seaglass_craft("seaglass:seaglassoff_yellow", {'clams:collectedalgae', 'default:glass', 'dye:yellow'})
register_seaglass_craft("seaglass:seaglassoff_red", {'clams:collectedalgae', 'default:glass', 'dye:red'})
register_seaglass_craft("seaglass:seaglassoff_blue", {'clams:collectedalgae', 'default:glass', 'dye:blue'})
register_seaglass_craft("seaglass:seaglassoff_white", {'clams:collectedalgae', 'default:glass', 'dye:white'})
register_seaglass_craft("seaglass:seaglassoff_black", {'clams:collectedalgae', 'default:glass', 'dye:black'})

register_seaglass_craft("seaglass:seaglassoff_yellow", {'seaglass:seaglass', 'dye:yellow'})
register_seaglass_craft("seaglass:seaglassoff_red", {'seaglass:seaglass', 'dye:red'})
register_seaglass_craft("seaglass:seaglassoff_blue", {'seaglass:seaglass', 'dye:blue'})
register_seaglass_craft("seaglass:seaglassoff_white", {'seaglass:seaglass', 'dye:white'})
register_seaglass_craft("seaglass:seaglassoff_black", {'seaglass:seaglass', 'dye:black'})

register_seaglass_craft("seaglass:seaglassoff_yellow", {'seaglass:seaglassoff', 'dye:yellow'})
register_seaglass_craft("seaglass:seaglassoff_red", {'seaglass:seaglassoff', 'dye:red'})
register_seaglass_craft("seaglass:seaglassoff_blue", {'seaglass:seaglassoff', 'dye:blue'})
register_seaglass_craft("seaglass:seaglassoff_white", {'seaglass:seaglassoff', 'dye:white'})
register_seaglass_craft("seaglass:seaglassoff_black", {'seaglass:seaglassoff', 'dye:black'})

register_seaglass_craft("seaglass:seaglassoff", {'seaglass:seaglass'})
register_seaglass_craft("seaglass:seaglassoff_yellow", {'seaglass:seaglass_yellow'})
register_seaglass_craft("seaglass:seaglassoff_red", {'seaglass:seaglass_red'})
register_seaglass_craft("seaglass:seaglassoff_blue", {'seaglass:seaglass_blue'})
register_seaglass_craft("seaglass:seaglassoff_white", {'seaglass:seaglass_white'})
register_seaglass_craft("seaglass:seaglassoff_black", {'seaglass:seaglass_black'})

register_seaglass_craft("seaglass:seaglass", {'seaglass:seaglassoff'})
register_seaglass_craft("seaglass:seaglass_yellow", {'seaglass:seaglassoff_yellow'})
register_seaglass_craft("seaglass:seaglass_red", {'seaglass:seaglassoff_red'})
register_seaglass_craft("seaglass:seaglass_blue", {'seaglass:seaglassoff_blue'})
register_seaglass_craft("seaglass:seaglass_white", {'seaglass:seaglassoff_white'})
register_seaglass_craft("seaglass:seaglass_black", {'seaglass:seaglassoff_black'})

register_seaglass_craft("stairs:stair_seaglass", {'stairs:stair_seaglassoff'})
register_seaglass_craft("stairs:stair_seaglass_yellow", {'stairs:stair_seaglassoff_yellow'})
register_seaglass_craft("stairs:stair_seaglass_red", {'stairs:stair_seaglassoff_red'})
register_seaglass_craft("stairs:stair_seaglass_blue", {'stairs:stair_seaglassoff_blue'})
register_seaglass_craft("stairs:stair_seaglass_white", {'stairs:stair_seaglassoff_white'})
register_seaglass_craft("stairs:stair_seaglass_black", {'stairs:stair_seaglassoff_black'})

register_seaglass_craft("stairs:stair_seaglassoff", {'stairs:stair_seaglass'})
register_seaglass_craft("stairs:stair_seaglassoff_yellow", {'stairs:stair_seaglass_yellow'})
register_seaglass_craft("stairs:stair_seaglassoff_red", {'stairs:stair_seaglass_red'})
register_seaglass_craft("stairs:stair_seaglassoff_blue", {'stairs:stair_seaglass_blue'})
register_seaglass_craft("stairs:stair_seaglassoff_white", {'stairs:stair_seaglass_white'})
register_seaglass_craft("stairs:stair_seaglassoff_black", {'stairs:stair_seaglass_black'})

register_seaglass_craft("stairs:stair_outer_seaglass", {'stairs:stair_outer_seaglassoff'})
register_seaglass_craft("stairs:stair_outer_seaglass_yellow", {'stairs:stair_outer_seaglassoff_yellow'})
register_seaglass_craft("stairs:stair_outer_seaglass_red", {'stairs:stair_outer_seaglassoff_red'})
register_seaglass_craft("stairs:stair_outer_seaglass_blue", {'stairs:stair_outer_seaglassoff_blue'})
register_seaglass_craft("stairs:stair_outer_seaglass_white", {'stairs:stair_outer_seaglassoff_white'})
register_seaglass_craft("stairs:stair_outer_seaglass_black", {'stairs:stair_outer_seaglassoff_black'})

register_seaglass_craft("stairs:stair_outer_seaglassoff", {'stairs:stair_outer_seaglass'})
register_seaglass_craft("stairs:stair_outer_seaglassoff_yellow", {'stairs:stair_outer_seaglass_yellow'})
register_seaglass_craft("stairs:stair_outer_seaglassoff_red", {'stairs:stair_outer_seaglass_red'})
register_seaglass_craft("stairs:stair_outer_seaglassoff_blue", {'stairs:stair_outer_seaglass_blue'})
register_seaglass_craft("stairs:stair_outer_seaglassoff_white", {'stairs:stair_outer_seaglass_white'})
register_seaglass_craft("stairs:stair_outer_seaglassoff_black", {'stairs:stair_outer_seaglass_black'})

register_seaglass_craft("stairs:stair_inner_seaglass", {'stairs:stair_inner_seaglassoff'})
register_seaglass_craft("stairs:stair_inner_seaglass_yellow", {'stairs:stair_inner_seaglassoff_yellow'})
register_seaglass_craft("stairs:stair_inner_seaglass_red", {'stairs:stair_inner_seaglassoff_red'})
register_seaglass_craft("stairs:stair_inner_seaglass_blue", {'stairs:stair_inner_seaglassoff_blue'})
register_seaglass_craft("stairs:stair_inner_seaglass_white", {'stairs:stair_inner_seaglassoff_white'})
register_seaglass_craft("stairs:stair_inner_seaglass_black", {'stairs:stair_inner_seaglassoff_black'})

register_seaglass_craft("stairs:stair_inner_seaglassoff", {'stairs:stair_inner_seaglass'})
register_seaglass_craft("stairs:stair_inner_seaglassoff_yellow", {'stairs:stair_inner_seaglass_yellow'})
register_seaglass_craft("stairs:stair_inner_seaglassoff_red", {'stairs:stair_inner_seaglass_red'})
register_seaglass_craft("stairs:stair_inner_seaglassoff_blue", {'stairs:stair_inner_seaglass_blue'})
register_seaglass_craft("stairs:stair_inner_seaglassoff_white", {'stairs:stair_inner_seaglass_white'})
register_seaglass_craft("stairs:stair_inner_seaglassoff_black", {'stairs:stair_inner_seaglass_black'})

register_seaglass_craft("stairs:slab_seaglass", {'stairs:slab_seaglassoff'})
register_seaglass_craft("stairs:slab_seaglass_yellow", {'stairs:slab_seaglassoff_yellow'})
register_seaglass_craft("stairs:slab_seaglass_red", {'stairs:slab_seaglassoff_red'})
register_seaglass_craft("stairs:slab_seaglass_blue", {'stairs:slab_seaglassoff_blue'})
register_seaglass_craft("stairs:slab_seaglass_white", {'stairs:slab_seaglassoff_white'})
register_seaglass_craft("stairs:slab_seaglass_black", {'stairs:slab_seaglassoff_black'})

register_seaglass_craft("stairs:slab_seaglassoff", {'stairs:slab_seaglass'})
register_seaglass_craft("stairs:slab_seaglassoff_yellow", {'stairs:slab_seaglass_yellow'})
register_seaglass_craft("stairs:slab_seaglassoff_red", {'stairs:slab_seaglass_red'})
register_seaglass_craft("stairs:slab_seaglassoff_blue", {'stairs:slab_seaglass_blue'})
register_seaglass_craft("stairs:slab_seaglassoff_white", {'stairs:slab_seaglass_white'})
register_seaglass_craft("stairs:slab_seaglassoff_black", {'stairs:slab_seaglass_black'})


-- ALIASES


minetest.register_alias("clams:yellowlightglass","seaglass:seaglassoff_yellow")
minetest.register_alias("clams:redlightglass","seaglass:seaglassoff_red")
minetest.register_alias("clams:bluelightglass","seaglass:seaglassoff_blue")
minetest.register_alias("clams:whitelightglass","seaglass:seaglassoff_white")
minetest.register_alias("clams:blacklightglass","seaglass:seaglassoff_black")

minetest.log("action", "[sea - seaglass] loaded.")
