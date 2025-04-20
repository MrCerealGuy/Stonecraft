
local S = cottages.S

-- fast tool for digging nodes with the group "hay";
-- can also be placed as a node

-- the straw node from default and similar nodes can be digged with the pitchfork as well
local add_hay_group = {"farming:straw", "dryplants:reed", "darkage:straw_bale"}
for i, v in ipairs(add_hay_group) do
	if( minetest.registered_items[v]) then
		new_groups = minetest.registered_items[v].groups
		new_groups.hay = 3
		minetest.override_item(v, {groups = new_groups})
	end
end

-- creates hay when digging dirt_with_grass (thanks to the override above);
-- useful for digging hay and straw
-- can be placed as a node
minetest.register_tool("cottages:pitchfork", {
	description = S("pitchfork (dig dirt with grass to get hay, place with right-click)"),
	groups = {},
	inventory_image = "cottages_pitchfork.png",
	wield_image = "cottages_pitchfork.png^[transformFYR180",
	wield_scale = {x=1.5,y=1.5,z=0.5},
	stack_max = 1,
	liquids_pointable = false,
	-- very useful for digging hay, straw and bales of those materials
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[2]=0.80, [3]=0.40}, maxlevel=1, uses=1/0.002 },
			snappy={times={[2]=0.80, [3]=0.40}, maxlevel=1, uses=1/0.002 },
			hay   ={times={[2]=0.10, [3]=0.10}, maxlevel=1, uses=1/0.002 },
		},
                damage_groups = {fleshy=5}, -- slightly stronger than a stone sword
	},
	sound = {breaks = "default_tool_breaks"},
	-- place the pitchfork somewhere
	on_place = function(itemstack, placer, pointed_thing)
		if( placer == nil or pointed_thing == nil or pointed_thing.type ~= "node") then
			return nil
		end
		local pos  = minetest.get_pointed_thing_position( pointed_thing, 1 )
		local node = minetest.get_node_or_nil( pos )
		if( node == nil or not(node.name) or node.name ~= "air") then
			return nil
		end
		if minetest.is_protected(pos, placer:get_player_name()) then
			return nil
		end
		minetest.rotate_and_place(ItemStack("cottages:pitchfork_placed"), placer, pointed_thing)
		-- did the placing succeed?
		local nnode = minetest.get_node(pos)
		if( not(nnode) or not(nnode.name) or nnode.name ~= "cottages:pitchfork_placed") then
			return nil
		end
		local meta = minetest.get_meta(pos)
		meta:set_int( "wear", itemstack:get_wear())
		meta:set_string("infotext", S("pitchfork (for hay and straw)"))
		-- the tool has been placed; consume it
		return ItemStack("")
	end,
})


-- a ptichfork placed somewhere
minetest.register_node("cottages:pitchfork_placed", {
	description = S("pitchfork (for hay and straw)"),
	tiles = {"default_wood.png^[transformR90"}, --default_tree.png"},
	drawtype = "nodebox",
	paramtype  = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {snappy = 2, dig_immediate = 3, falling_node = 1, attached_node = 1, not_in_creative_inventory=1},
	sounds = cottages.sounds.wood,
	node_box = {
		type = "fixed",
		fixed = {
			-- handle (goes a bit into the ground)
			{ -(1/32), -(11/16), -(1/32),  (1/32), 16/16, (1/32)},
			-- middle connection
			{ -(7/32),  -(4/16), -(1/32),  (7/32), -(2/16), (1/32)},
			-- thongs
			{ -(7/32), -(11/16), -(1/32), -(5/32), -(4/16), (1/32)},
			{  (5/32), -(11/16), -(1/32),  (7/32), -(4/16), (1/32)},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.3, -0.5, -0.1, 0.3, 1.0, 0.1 }
	},
	drop = "cottages:pitchfork",
	-- perserve wear
	preserve_metadata = function(pos, oldnode, oldmeta, drops)
		if(oldmeta["wear"]) then
			-- the first drop is the pitchfork
			drops[1]:set_wear(oldmeta["wear"])
		end
	end,
})

--
-- craft recipes
--
minetest.register_craft({
        output = 'cottages:pitchfork',
        recipe = {
                { 'default:stick','default:stick','default:stick' },
                { '','default:stick', '' },
                { '','default:stick','' },
        }
})
