-- Rope mod. By Mirko K.
--		modified by Temperest <http://minetest.net/forum/profile.php?id=640> [FEB 2012]
--		modified by Wulfsdad <http://minetest.net/forum/profile.php?id=3738> [DEC 2012]
--		
-- Placement automatically adds rope downwards until it runs out or some
-- non-air block is in the way.
-- Push (single left-click) cuts the rope at that position. Digging removes
-- the whole rope.
--
-- Licence:
--   Code: GPL
--   Texture: CC-BY-SA


minetest.register_on_punchnode(function(pos, oldnode, digger)
    if oldnode.name == "ropes:rope" then
		remove_rope(pos, oldnode, digger, "ropes:rope")
	 elseif oldnode.name == "moreblocks:rope" then
		remove_rope(pos, oldnode, digger, "moreblocks:rope")
	 end
end)

place_rope = function(itemstack, placer, pointed_thing)
    if pointed_thing.type == "node" then
        -- Calculate wall-mount direction
        local under = pointed_thing.under
        local above = pointed_thing.above
        local dir = {x = under.x - above.x, y = under.y - above.y, z = under.z - above.z}
        local param2_wallmounted = minetest.dir_to_wallmounted(dir)

        local pos = above
        local oldnode = minetest.env:get_node(pos)
        local olddef = ItemStack({name=oldnode.name}):get_definition()

        while oldnode.name == "air" and not itemstack:is_empty() do
            minetest.log("action", placer:get_player_name() .. " places rope "
                .. " at " .. minetest.pos_to_string(pos))

            -- Place the rope
				local newnode = {name = itemstack:get_name(), param1 = 0, param2 = param2_wallmounted}
            minetest.env:add_node(pos, newnode)
            itemstack:take_item()

            -- if you want, call all callbacks in minetest.registered_on_placenodes here
            -- see minetest.item_place_node in builtin.lua

            -- Go down
            pos.y = pos.y - 1
            oldnode = minetest.env:get_node(pos)
            olddef = ItemStack({name=oldnode.name}):get_definition()
        end
    end
    return itemstack
end

remove_rope = function(pos, oldnode, digger, rope_name)
    local num = 0
    local below = {x=pos.x,y=pos.y,z=pos.z}
    while minetest.env:get_node(below).name == rope_name do
		minetest.env:remove_node(below)
		below.y = below.y -1
		num = num + 1
    end
    if num ~= 0 then
		digger:get_inventory():add_item("main", rope_name..' '..num)
    end
    return true
end

minetest.register_craft({
    output = '"ropes:rope" 2',
    recipe = {
        {'flowers:cotton'},
        {'flowers:cotton'},
        {'flowers:cotton'},
    }
})

minetest.register_craft({
    output = '"ropes:rope" 6',
    recipe = {
        {'wool:white','',''},
        {'','wool:white',''},
        {'','','wool:white'},
    }
})

minetest.register_craft({
    output = '"ropes:rope" 6',
    recipe = {
        {'','','wool:white'},
        {'','wool:white',''},
        {'wool:white','',''},
    }
})

minetest.register_craft({
    output = '"ropes:rope" 6',
    recipe = {
        {'homedecor:curtain_white'},
        {'homedecor:curtain_white'},
        {'homedecor:curtain_white'},
    }
})

minetest.register_node("ropes:rope", {
    description = "Rope",
    drawtype = "signlike",
    tiles = {"rope.png"},
    inventory_image = "rope.png",
	 wield_image = "rope.png",
    light_propagates = true,
    paramtype = "light",
    paramtype2 = "wallmounted",
    legacy_wall_mounted = true,
    is_ground_content = true,
    walkable = false,
    climbable = true,
    selection_box = {
        type = "wallmounted",
    --wall_top = = <default>
    --wall_bottom = = <default>
    --wall_side = = <default>
    },
    on_place = place_rope,
--     burntime = 5,
--     material = {
--     diggablity = "normal",
--     cuttability = 1.5,
--     },
	groups = {flammable=2},
})

if minetest.get_modpath("moreblocks") ~= nil then
	minetest.register_node(":moreblocks:rope", {
		description = "Rope",
		drawtype = "signlike",
		tiles = {"moreblocks_rope.png"},
		inventory_image = "moreblocks_rope.png",
		wield_image = "moreblocks_rope.png",
		light_propagates = true,
		paramtype = "light",
		paramtype2 = "wallmounted",
		legacy_wall_mounted = true,
		is_ground_content = true,
		walkable = false,
		climbable = true,
		selection_box = {
			type = "wallmounted",
		},
		on_place = place_rope,
		groups = {snappy=3,flammable=2},
		sounds = default.node_sound_leaves_defaults(),
	})
end

if minetest.get_modpath("farming") ~= nil then
	minetest.register_craft({
		type = "shapeless",
		 output = "ropes:rope",
		 recipe = { "farming:string","farming:string", }
	})
end