
local S = technic.getter

local fs_helpers = pipeworks.fs_helpers

local tube_entry = "^pipeworks_tube_connection_metallic.png"

local param2_to_under = {
	[0] = {x= 0,y=-1,z= 0}, [1] = {x= 0,y= 0,z=-1},
	[2] = {x= 0,y= 0,z= 1}, [3] = {x=-1,y= 0,z= 0},
	[4] = {x= 1,y= 0,z= 0}, [5] = {x= 0,y= 1,z= 0}
}

local base_formspec = "size[8,9;]"..
	"label[0,0;"..S("Self-Contained Injector").."]"..
	"list[context;main;0,2;8,2;]"..
	"list[current_player;main;0,5;8,4;]"..
	"listring[]"

local function set_injector_formspec(pos)
	local meta = minetest.get_meta(pos)
	local formspec = base_formspec..
		fs_helpers.cycling_button(
			meta,
			pipeworks.button_base,
			"splitstacks",
			{
				pipeworks.button_off,
				pipeworks.button_on
			}
		)..pipeworks.button_label
	if meta:get_string("mode") == "whole stacks" then
		formspec = formspec.."button[0,1;4,1;mode_item;"..S("Stackwise").."]"
	else
		formspec = formspec.."button[0,1;4,1;mode_stack;"..S("Itemwise").."]"
	end
	if minetest.get_node_timer(pos):is_started() then
		formspec = formspec.."button[4,1;4,1;disable;"..S("Enabled").."]"
	else
		formspec = formspec.."button[4,1;4,1;enable;"..S("Disabled").."]"
	end
	meta:set_string("formspec", formspec)
end

minetest.register_node("technic:injector", {
	description = S("Self-Contained Injector"),
	tiles = {
		"technic_injector_top.png"..tube_entry,
		"technic_injector_bottom.png",
		"technic_injector_side.png"..tube_entry,
		"technic_injector_side.png"..tube_entry,
		"technic_injector_side.png"..tube_entry,
		"technic_injector_side.png"
	},
	paramtype2 = "facedir",
	groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2, tubedevice=1, tubedevice_receiver=1},
	tube = {
		can_insert = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			if meta:get_int("splitstacks") == 1 then
				stack = stack:peek_item(1)
			end
			return meta:get_inventory():room_for_item("main", stack)
		end,
		insert_object = function(pos, node, stack, direction)
			return minetest.get_meta(pos):get_inventory():add_item("main", stack)
		end,
		connect_sides = {left=1, right=1, back=1, top=1, bottom=1},
	},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Self-Contained Injector"))
		meta:set_string("mode", "single items")
		meta:get_inventory():set_size("main", 16)
		minetest.get_node_timer(pos):start(1)
		set_injector_formspec(pos)
	end,
	can_dig = function(pos, player)
		return minetest.get_meta(pos):get_inventory():is_empty("main")
	end,
	on_receive_fields = function(pos, formanme, fields, sender)
		if fields.quit or not pipeworks.may_configure(pos, sender) then
			return
		end
		local meta = minetest.get_meta(pos)
		if fields.mode_item then
			meta:set_string("mode", "single items")
		elseif fields.mode_stack then
			meta:set_string("mode", "whole stacks")
		elseif fields.disable then
			minetest.get_node_timer(pos):stop()
		elseif fields.enable then
			minetest.get_node_timer(pos):start(1)
		end
		fs_helpers.on_receive_fields(pos, fields)
		set_injector_formspec(pos)
	end,
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local node = minetest.get_node(pos)
		local dir = param2_to_under[math.floor(node.param2 / 4)]
		local node_under = minetest.get_node(vector.add(pos, dir))
		if minetest.get_item_group(node_under.name, "tubedevice") > 0 then
			local inv = meta:get_inventory()
			local list = inv:get_list("main")
			if not list then
				return true
			end
			local stackwise = meta:get_string("mode") == "whole stacks"
			for i,stack in ipairs(list) do
				if not stack:is_empty() then
					if stackwise then
						technic.tube_inject_item(pos, pos, dir, stack:to_table())
						stack:clear()
					else
						technic.tube_inject_item(pos, pos, dir, stack:take_item(1):to_table())
					end
					inv:set_stack("main", i, stack)
					break
				end
			end
		end
		return true
	end,
	on_rotate = function(pos, node, user, mode, new_param2)
		node.param2 = new_param2
		minetest.swap_node(pos, node)
		pipeworks.scan_for_tube_objects(pos)
		return true
	end,
	allow_metadata_inventory_put = technic.machine_inventory_put,
	allow_metadata_inventory_take = technic.machine_inventory_take,
	allow_metadata_inventory_move = technic.machine_inventory_move,
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig
})

minetest.register_craft({
	output = "technic:injector 1",
	recipe = {
		{"", "technic:control_logic_unit",""},
		{"", "default:chest",""},
		{"", "pipeworks:tube_1",""},
	}
})

minetest.register_lbm({
	label = "Old injector conversion",
	name = "technic:old_injector_conversion",
	nodenames = {"technic:injector"},
	run_at_every_load = false,
	action = function(pos, node)
		minetest.get_node_timer(pos):start(1)
		set_injector_formspec(pos)
	end
})
