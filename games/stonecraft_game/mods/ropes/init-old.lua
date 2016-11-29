-- Rope mod. By Mirko K.
--
-- Three tree block in a vertical row = 9 meter of rope.
-- Placement automatically adds rope downwards until it runs out or some
-- non-air block is in the way.
-- Push (single left-click) cuts the rope at that position. Digging removes
-- the whole rope.
--
-- Licence:
--   Code: GPL
--   Texture: CC-BY-SA

minetest.register_on_placenode(function(pos, newnode, placer)
	if newnode.name == "ropes:rope" then
	    place_rope(pos, newnode, placer)
	end
    end
)

minetest.register_on_dignode(function(pos, oldnode, digger)
	if oldnode.name == "ropes:rope" then
	    remove_rope(pos, oldnode, digger, true)
        end
    end
)

minetest.register_on_punchnode(function(pos, oldnode, digger)
	if oldnode.name == "ropes:rope" then
	    remove_rope(pos, oldnode, digger, false)
        end
    end
)

-- helper function
inventory_find_item = function (object, name, item)
    local inventory = object:inventory_get_list(name)
    for key, value in pairs(inventory) do
	if value == item then
	    return key, value
	end
    end
    return nil, nil
end

place_rope = function (pos, newnode, placer)
    local inventory = placer:inventory_get_list("main")
    local witem = placer:get_wielded_itemstring()
    local windex, witem = inventory_find_item(placer, "main", witem)
    local param2 = newnode.param2
    while witem ~= nil and witem:len() ~= 0 do
	pos.y = pos.y - 1
	if minetest.env:get_node(pos).name ~= "air" then
	    break
	end
	if minetest.env:add_node(pos, {name="ropes:rope", param2=param2}) ~= true
	then
	    break
	end
	witem = stackstring_take_item(witem)
    end
    if windex == nil then
    else
        inventory[windex] = witem
	placer:inventory_set_list("main", inventory)
    end
end

remove_rope = function(pos, oldnode, digger, completely)
    local num = 0
    local below = pos
    local above = pos
    if completely == true then
	above.y = above.y + 1
	while minetest.env:get_node(above).name == "ropes:rope" do
	    minetest.env:remove_node(above)
	    above.y = above.y + 1
	    num = num + 1
	end
    end
    below.y = below.y - 1
    while minetest.env:get_node(below).name == "ropes:rope" do
	minetest.env:remove_node(below)
	below.y = below.y -1
	num = num + 1
    end
    if num ~= 0 then
        digger:add_to_inventory_later('node "ropes:rope" ' .. num)
    end
    return true
end

minetest.register_craft({
    output = 'node "ropes:rope" 9',
    recipe = {
    	{'', 'node "tree"', ''},
    	{'', 'node "tree"', ''},
    	{'', 'node "tree"', ''},
    }
})

minetest.register_node("ropes:rope", {
    drawtype = "signlike",
    tiles = {"rope.png"},
    inventory_image = "rope.png",
    light_propagates = true,
    paramtype = "light",
    is_ground_content = true,
    wall_mounted = true,
    walkable = false,
    climbable = true,
    selection_box = {
        type = "wallmounted",
	--wall_top = = <default>
	--wall_bottom = = <default>
	--wall_side = = <default>
    },
    furnace_burntime = 5,
    material = {
	diggablity = "normal",
	cuttability = 1.5,
    },
})



