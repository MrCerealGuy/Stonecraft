-- contains hay_mat, hay and hay bale
-- (gives the pitchfork some work)
--
local S = cottages.S

-- If default:dirt_with_grass is digged while wielding a pitchfork, it will
-- turn into dirt and get some hay placed above it.
-- The hay will disappear (decay) after a couple of minutes.
if(     minetest.registered_items["default:dirt_with_grass"]
    and minetest.registered_tools["cottages:pitchfork"]) then
  minetest.override_item("default:dirt_with_grass", {
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if( not( pos ) or not( digger )) then
			return
		end
		local wielded = digger:get_wielded_item()
		if(    not( wielded )
		    or not( wielded:get_name() )
		    or (wielded:get_name()~="cottages:pitchfork")) then
			return
		end

		local pos_above = {x=pos.x, y=pos.y+1, z=pos.z}
		local node_above = minetest.get_node_or_nil( pos_above)
		if( not(node_above) or not(node_above.name) or node_above.name ~= "air" ) then
			return nil
		end
		minetest.swap_node( pos,       {name="default:dirt"})
		minetest.add_node(  pos_above, {name="cottages:hay_mat", param2=math.random(2,25)}) 
		-- start a node timer so that the hay will decay after some time
		local timer = minetest.get_node_timer(pos_above)
		if not timer:is_started() then
			timer:start(math.random(60, 300))
		end
		-- TODO: prevent dirt from beeing multiplied this way (that is: give no dirt!)
		return
	end,
  })
end



-- more comparable to the straw mat than to a hay bale
-- (can be created by digging dirt with grass with the pitchfork)
minetest.register_node("cottages:hay_mat", {
	drawtype = "nodebox",
	paramtype2 = "leveled",
	description = S("Some hay"),
	tiles = {cottages.straw_texture.."^[multiply:#88BB88"},
	groups = {hay=3, snappy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = cottages.sounds.leaves,
        -- the bale is slightly smaller than a full node
	is_ground_content = false,
	node_box = {
		type = "leveled", --"fixed",
		fixed = {
				{-0.5,-0.5,-0.5, 0.5, 0.5, 0.5},
			}
	},
	-- make sure a placed hay block looks halfway reasonable
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		minetest.swap_node( pos, {name="cottages:hay_mat", param2=math.random(2,25)})
	end,
	on_timer = function(pos, elapsed)
		local node = minetest.get_node(pos)
		if( node and node.name=="cottages:hay_mat") then
			minetest.remove_node(pos)
			minetest.check_for_falling(pos)
		end
	end,
})

-- hay block, similar to straw block
minetest.register_node("cottages:hay", {
	description = S("Hay"),
	tiles = {cottages.straw_texture.."^[multiply:#88BB88"},
	groups = {hay=3, snappy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = cottages.sounds.leaves,
	is_ground_content = false,
})


-- hay bales for hungry animals
minetest.register_node("cottages:hay_bale", {
	drawtype = "nodebox",
	description = S("Hay bale"),
	tiles = {"cottages_darkage_straw_bale.png^[multiply:#88BB88"},
	paramtype = "light",
	groups = {hay=3, snappy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = cottages.sounds.leaves,
        -- the bale is slightly smaller than a full node
	node_box = {
		type = "fixed",
		fixed = {
				{-0.45, -0.5,-0.45,  0.45,  0.45, 0.45},
			}
	},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.45, -0.5,-0.45,  0.45,  0.45, 0.45},
			}
	},
	is_ground_content = false,
})


--
-- craft recipes
--
minetest.register_craft({
	output = "cottages:hay_mat 9",
	recipe = {
		{"cottages:hay"},
	},
})

minetest.register_craft({
	output = "cottages:hay",
	recipe = {
		{"cottages:hay_mat", "cottages:hay_mat", "cottages:hay_mat"},
		{"cottages:hay_mat", "cottages:hay_mat", "cottages:hay_mat"},
		{"cottages:hay_mat", "cottages:hay_mat", "cottages:hay_mat"},
	},
})

minetest.register_craft({
	output = "cottages:hay",
	recipe = {{"cottages:hay_bale"}},
})

minetest.register_craft({
	output = "cottages:hay_bale",
	recipe = {{"cottages:hay"}},
})
