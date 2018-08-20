local x_disp = 0.125
local z_disp = 0.125

local stal_on_place = function(itemstack, placer, pointed_thing, itemname)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return itemstack
	end
	if pt.type ~= "node" then
		return itemstack
	end

	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)

	if minetest.is_protected(pt.above, placer:get_player_name()) then
		minetest.record_protection_violation(pt.above, placer:get_player_name())
		return
	end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] or not minetest.registered_nodes[above.name] then
		return itemstack
	end
	-- check if you can replace the node above the pointed node
	if not minetest.registered_nodes[above.name].buildable_to then
		return itemstack
	end

	local new_param2
	-- check if pointing at an existing stalactite
	if minetest.get_item_group(under.name, "subterrane_stal_align") ~= 0 then
		new_param2 = under.param2
	else
		new_param2 = math.random(0,3)
	end

	-- add the node and remove 1 item from the itemstack
	minetest.add_node(pt.above, {name = itemname, param2 = new_param2})
	if not minetest.setting_getbool("creative_mode") then
		itemstack:take_item()
	end
	return itemstack
end

local stal_box_1 = {{-0.0625+x_disp, -0.5, -0.0625+z_disp, 0.0625+x_disp, 0.5, 0.0625+z_disp}}
local stal_box_2 = {{-0.125+x_disp, -0.5, -0.125+z_disp, 0.125+x_disp, 0.5, 0.125+z_disp}}
local stal_box_3 = {{-0.25+x_disp, -0.5, -0.25+z_disp, 0.25+x_disp, 0.5, 0.25+z_disp}}
local stal_box_4 = {{-0.375+x_disp, -0.5, -0.375+z_disp, 0.375+x_disp, 0.5, 0.375+z_disp}}

local simple_copy = function(t)
	local r = {}
	for k, v in pairs(t) do
		r[k] = v
	end
	return r
end

subterrane.register_stalagmite_nodes = function(base_name, base_node_def, drop_base_name)
	base_node_def.groups = base_node_def.groups or {}
	base_node_def.groups.subterrane_stal_align = 1
	base_node_def.groups.flow_through = 1
	base_node_def.drawtype = "nodebox"
	base_node_def.paramtype = "light"
	base_node_def.paramtype2 = "facedir"
	base_node_def.is_ground_content = true
	base_node_def.node_box = {type = "fixed"}
	
	local def1 = simple_copy(base_node_def)
	def1.groups.fall_damage_add_percent = 100
	def1.node_box.fixed = stal_box_1
	def1.on_place = function(itemstack, placer, pointed_thing)
		return stal_on_place(itemstack, placer, pointed_thing, base_name.."_1")
	end
	if drop_base_name then
		def1.drop = drop_base_name.."_1"
	end
	minetest.register_node(base_name.."_1", def1)

	local def2 = simple_copy(base_node_def)
	def2.groups.fall_damage_add_percent = 50
	def2.node_box.fixed = stal_box_2
	def2.on_place = function(itemstack, placer, pointed_thing)
		return stal_on_place(itemstack, placer, pointed_thing, base_name.."_2")
	end
	if drop_base_name then
		def2.drop = drop_base_name.."_2"
	end
	minetest.register_node(base_name.."_2", def2)

	local def3 = simple_copy(base_node_def)
	def3.node_box.fixed = stal_box_3
	def3.on_place = function(itemstack, placer, pointed_thing)
		return stal_on_place(itemstack, placer, pointed_thing, base_name.."_3")
	end
	if drop_base_name then
		def3.drop = drop_base_name.."_3"
	end
	minetest.register_node(base_name.."_3", def3)

	local def4 = simple_copy(base_node_def)
	def4.node_box.fixed = stal_box_4
	def4.on_place = function(itemstack, placer, pointed_thing)
		return stal_on_place(itemstack, placer, pointed_thing, base_name.."_4")
	end
	if drop_base_name then
		def4.drop = drop_base_name.."_4"
	end
	minetest.register_node(base_name.."_4", def4)
	
	return {
		minetest.get_content_id(base_name.."_1"),
		minetest.get_content_id(base_name.."_2"),
		minetest.get_content_id(base_name.."_3"),
		minetest.get_content_id(base_name.."_4"),
	}
end