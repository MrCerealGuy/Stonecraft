
local old_furnace = table.copy(minetest.registered_nodes["mcl_furnaces:furnace"])
local old_blast_furnace = table.copy(minetest.registered_nodes["mcl_blast_furnace:blast_furnace"])
local old_smoker = table.copy(minetest.registered_nodes["mcl_smoker:smoker"])

local tube_entry = "^pipeworks_tube_connection_stony.png"

-- groups
local furnace_groups = old_furnace.groups
furnace_groups["tubedevice"] = 1
furnace_groups["tubedevice_receiver"] = 1
local furnace_groups_active = table.copy(furnace_groups)
furnace_groups_active["not_in_creative_inventory"] = 1

local blast_furnace_groups = old_blast_furnace.groups
blast_furnace_groups["tubedevice"] = 1
blast_furnace_groups["tubedevice_receiver"] = 1
local blast_furnace_groups_active = table.copy(blast_furnace_groups)
blast_furnace_groups_active["not_in_creative_inventory"] = 1

local smoker_groups = old_smoker.groups
smoker_groups["tubedevice"] = 1
smoker_groups["tubedevice_receiver"] = 1
local smoker_groups_active = table.copy(smoker_groups)
smoker_groups_active["not_in_creative_inventory"] = 1


-- a hack to give the exp to fake players it's be dropped instead added to (fake) player inv
local function give_xp(pos, player)
   local meta = minetest.get_meta(pos)
   local dir = vector.divide(minetest.facedir_to_dir(minetest.get_node(pos).param2), -1.95)
   local xp = meta:get_int("xp")
   if xp > 0 then
      mcl_experience.throw_xp(vector.add(pos, dir), xp)
      meta:set_int("xp", 0)
   end
end

local override = {}

override.tiles = {
   "default_furnace_top.png"..tube_entry,
   "default_furnace_bottom.png"..tube_entry,
   "default_furnace_side.png"..tube_entry,
   "default_furnace_side.png"..tube_entry,
   "default_furnace_side.png"..tube_entry,
   "default_furnace_front.png"
}

override.groups = furnace_groups

override.tube = {
   insert_object = function(pos, node, stack, direction)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local timer = minetest.get_node_timer(pos)
      if not timer:is_started() then
	 timer:start(1.0)
      end
      if direction.y == 1 then
	 return inv:add_item("fuel", stack)
      else
	 return inv:add_item("src", stack)
      end
   end,
   can_insert = function(pos,node,stack,direction)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      if direction.y == 1 then
	 return inv:room_for_item("fuel", stack)
      else
	 if meta:get_int("split_material_stacks") == 1 then
	    stack = stack:peek_item(1)
	 end
	 return inv:room_for_item("src", stack)
      end
   end,
   input_inventory = "dst",
   connect_sides = {left = 1, right = 1, back = 1, bottom = 1, top = 1}
}

override.after_place_node = function(pos, placer, itemstack, pointed_thing)
   pipeworks.after_place(pos, placer, itemstack, pointed_thing)
end

override.after_dig_node = function(pos, oldnode, oldmetadata, digger)
   old_furnace.after_dig_node(pos, oldnode, oldmetadata, digger)
   pipeworks.after_dig(pos)
end

override.on_metadata_inventory_take = function(pos, listname, index, stack, player)
   if listname == "dst" then
      if stack:get_name() == "mcl_core:iron_ingot" then
	 awards.unlock(player:get_player_name(), "mcl:acquireIron")
      elseif stack:get_name() == "mcl_fishing:fish_cooked" then
	 awards.unlock(player:get_player_name(), "mcl:cookFish")
      end
      give_xp(pos, player)
   end
end

override.on_rotate = pipeworks.on_rotate


local override_active = table.copy(override)

override_active.tiles = {
   "default_furnace_top.png"..tube_entry,
   "default_furnace_bottom.png"..tube_entry,
   "default_furnace_side.png"..tube_entry,
   "default_furnace_side.png"..tube_entry,
   "default_furnace_side.png"..tube_entry,
   "default_furnace_front_active.png",
}

override_active.groups = furnace_groups_active

override_active.tube = {
   insert_object = function(pos,node,stack,direction)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local timer = minetest.get_node_timer(pos)
      if not timer:is_started() then
	 timer:start(1.0)
      end
      if direction.y == 1 then
	 return inv:add_item("fuel", stack)
      else
	 return inv:add_item("src", stack)
      end
   end,
   can_insert = function(pos, node, stack, direction)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      if direction.y == 1 then
	 return inv:room_for_item("fuel", stack)
      else
	 return inv:room_for_item("src", stack)
      end
   end,
   input_inventory = "dst",
   connect_sides = {left = 1, right = 1, back = 1, bottom = 1, top = 1}
}


--blast furnace

local override_blast_furnace = {}

override_blast_furnace.tiles = {
   "blast_furnace_top.png"..tube_entry,
   "blast_furnace_top.png"..tube_entry,
   "blast_furnace_side.png"..tube_entry,
   "blast_furnace_side.png"..tube_entry,
   "blast_furnace_side.png"..tube_entry,
   "blast_furnace_front.png"
}

override_blast_furnace.groups = blast_furnace_groups

override_blast_furnace.tube = {
   insert_object = function(pos, node, stack, direction)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local timer = minetest.get_node_timer(pos)
      if not timer:is_started() then
	 timer:start(1.0)
      end
      if direction.y == 1 then
	 return inv:add_item("fuel", stack)
      else
	 return inv:add_item("src", stack)
      end
   end,
   can_insert = function(pos,node,stack,direction)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      if direction.y == 1 then
	 return inv:room_for_item("fuel", stack)
      else
	 if meta:get_int("split_material_stacks") == 1 then
	    stack = stack:peek_item(1)
	 end
	 return inv:room_for_item("src", stack)
      end
   end,
   input_inventory = "dst",
   connect_sides = {left = 1, right = 1, back = 1, bottom = 1, top = 1}
}

override_blast_furnace.after_place_node = function(pos, placer, itemstack, pointed_thing)
   pipeworks.after_place(pos, placer, itemstack, pointed_thing)
end

override_blast_furnace.after_dig_node = function(pos, oldnode, oldmetadata, digger)
   old_blast_furnace.after_dig_node(pos, oldnode, oldmetadata, digger)
   pipeworks.after_dig(pos)
end

override_blast_furnace.on_metadata_inventory_take = function(pos, listname, index, stack, player)
   -- Award smelting achievements
   if listname == "dst" then
      if stack:get_name() == "mcl_core:iron_ingot" then
	 awards.unlock(player:get_player_name(), "mcl:acquireIron")
      end
      give_xp(pos, player)
   end
end

override_blast_furnace.on_rotate = pipeworks.on_rotate


local override_blast_active = table.copy(override)

override_blast_active.tiles = {
   "blast_furnace_top.png"..tube_entry,
   "blast_furnace_top.png"..tube_entry,
   "blast_furnace_side.png"..tube_entry,
   "blast_furnace_side.png"..tube_entry,
   "blast_furnace_side.png"..tube_entry,
   {
      name = "blast_furnace_front_on.png",
      animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 48 }
   },
}

override_blast_active.groups = blast_furnace_groups_active

override_blast_active.tube = {
   insert_object = function(pos,node,stack,direction)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local timer = minetest.get_node_timer(pos)
      if not timer:is_started() then
	 timer:start(1.0)
      end
      if direction.y == 1 then
	 return inv:add_item("fuel", stack)
      else
	 return inv:add_item("src", stack)
      end
   end,
   can_insert = function(pos, node, stack, direction)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      if direction.y == 1 then
	 return inv:room_for_item("fuel", stack)
      else
	 return inv:room_for_item("src", stack)
      end
   end,
   input_inventory = "dst",
   connect_sides = {left = 1, right = 1, back = 1, bottom = 1, top = 1}
}


-- smoker

local override_smoker = {}

override_smoker.tiles = {
   "smoker_top.png"..tube_entry,
   "smoker_bottom.png"..tube_entry,
   "smoker_side.png"..tube_entry,
   "smoker_side.png"..tube_entry,
   "smoker_side.png"..tube_entry,
   "smoker_front.png"
}

override_smoker.groups = smoker_groups

override_smoker.tube = {
   insert_object = function(pos, node, stack, direction)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local timer = minetest.get_node_timer(pos)
      if not timer:is_started() then
	 timer:start(1.0)
      end
      if direction.y == 1 then
	 return inv:add_item("fuel", stack)
      else
	 return inv:add_item("src", stack)
      end
   end,
   can_insert = function(pos,node,stack,direction)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      if direction.y == 1 then
	 return inv:room_for_item("fuel", stack)
      else
	 if meta:get_int("split_material_stacks") == 1 then
	    stack = stack:peek_item(1)
	 end
	 return inv:room_for_item("src", stack)
      end
   end,
   input_inventory = "dst",
   connect_sides = {left = 1, right = 1, back = 1, bottom = 1, top = 1}
}

override_smoker.after_place_node = function(pos, placer, itemstack, pointed_thing)
   pipeworks.after_place(pos, placer, itemstack, pointed_thing)
end

override_smoker.after_dig_node = function(pos, oldnode, oldmetadata, digger)
   old_smoker.after_dig_node(pos, oldnode, oldmetadata, digger)
   pipeworks.after_dig(pos)
end

override_smoker.on_metadata_inventory_take = function(pos, listname, index, stack, player)
   -- Award fish achievements
   if listname == "dst" then
      if stack:get_name() == "mcl_fishing:fish_cooked" then
	 awards.unlock(player:get_player_name(), "mcl:cookFish")
      end
      give_xp(pos, player)
   end
end

override_smoker.on_rotate = pipeworks.on_rotate


local override_smoker_active = table.copy(override)

override_smoker_active.tiles = {
   "smoker_top.png"..tube_entry,
   "smoker_bottom.png"..tube_entry,
   "smoker_side.png"..tube_entry,
   "smoker_side.png"..tube_entry,
   "smoker_side.png"..tube_entry,
   {
      name = "smoker_front_on.png",
      animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 48 }
   },
}

override_smoker_active.groups = smoker_groups_active

override_smoker_active.tube = {
   insert_object = function(pos,node,stack,direction)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local timer = minetest.get_node_timer(pos)
      if not timer:is_started() then
	 timer:start(1.0)
      end
      if direction.y == 1 then
	 return inv:add_item("fuel", stack)
      else
	 return inv:add_item("src", stack)
      end
   end,
   can_insert = function(pos, node, stack, direction)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      if direction.y == 1 then
	 return inv:room_for_item("fuel", stack)
      else
	 return inv:room_for_item("src", stack)
      end
   end,
   input_inventory = "dst",
   connect_sides = {left = 1, right = 1, back = 1, bottom = 1, top = 1}
}


-- override
minetest.override_item("mcl_furnaces:furnace", override)
minetest.override_item("mcl_furnaces:furnace_active", override_active)

minetest.override_item("mcl_blast_furnace:blast_furnace", override_blast_furnace)
minetest.override_item("mcl_blast_furnace:blast_furnace_active", override_blast_active)

minetest.override_item("mcl_smoker:smoker", override_smoker)
minetest.override_item("mcl_smoker:smoker_active", override_smoker_active)
