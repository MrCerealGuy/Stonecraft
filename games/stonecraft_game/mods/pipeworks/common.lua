----------------------
-- Vector functions --
----------------------

function pipeworks.vector_cross(a, b)
	return {
		x = a.y * b.z - a.z * b.y,
		y = a.z * b.x - a.x * b.z,
		z = a.x * b.y - a.y * b.x
	}
end

function pipeworks.vector_dot(a, b)
	return a.x * b.x + a.y * b.y + a.z * b.z
end

-----------------------
-- Facedir functions --
-----------------------

function pipeworks.facedir_to_top_dir(facedir)
	return 	({[0] = {x =  0, y =  1, z =  0},
	                {x =  0, y =  0, z =  1},
	                {x =  0, y =  0, z = -1},
	                {x =  1, y =  0, z =  0},
	                {x = -1, y =  0, z =  0},
	                {x =  0, y = -1, z =  0}})
		[math.floor(facedir / 4)]
end

function pipeworks.facedir_to_right_dir(facedir)
	return pipeworks.vector_cross(
		pipeworks.facedir_to_top_dir(facedir),
		minetest.facedir_to_dir(facedir)
	)
end

local directions = {}
pipeworks.directions = directions
function directions.side_to_dir(side)
	return ({[0] = vector.new(),
		vector.new( 0,  1,  0),
		vector.new( 0, -1,  0),
		vector.new( 1,  0,  0),
		vector.new(-1,  0,  0),
		vector.new( 0,  0,  1),
		vector.new( 0,  0, -1)
	})[side]
end

function directions.dir_to_side(dir)
	local c = pipeworks.vector_dot(dir, vector.new(1, 2, 3)) + 4
	return ({6, 2, 4, 0, 3, 1, 5})[c]
end

----------------------
-- String functions --
----------------------

--[[function pipeworks.string_split(str, sep)
	local fields = {}
	local index = 1
	local expr = "([^"..sep.."])+"
	string.gsub(str, expr, function(substring)
		fields[index] = substring
		index = index + 1
	end)
	return fields
end]]

function pipeworks.string_startswith(str, substr)
	return str:sub(1, substr:len()) == substr
end

---------------------
-- Table functions --
---------------------

function pipeworks.table_contains(tbl, element)
	for _, elt in pairs(tbl) do
		if elt == element then
			return true
		end
	end
	return false
end

function pipeworks.table_extend(tbl, tbl2)
	local index = #tbl + 1
	for _, elt in ipairs(tbl2) do
		tbl[index] = elt
		index = index + 1
	end
end

function pipeworks.table_recursive_replace(tbl, pattern, replace_with)
	if type(tbl) == "table" then
		local tbl2 = {}
		for key, value in pairs(tbl) do
			tbl2[key] = pipeworks.table_recursive_replace(value, pattern, replace_with)
		end
		return tbl2
	elseif type(tbl) == "string" then
		return tbl:gsub(pattern, replace_with)
	else
		return tbl
	end
end

------------------------
-- Formspec functions --
------------------------

local fs_helpers = {}
pipeworks.fs_helpers = fs_helpers
function fs_helpers.on_receive_fields(pos, fields)
	local meta = minetest.get_meta(pos)
	for field, value in pairs(fields) do
		if pipeworks.string_startswith(field, "fs_helpers_cycling:") then
			local l = field:split(":")
			local new_value = tonumber(l[2])
			local meta_name = l[3]
			meta:set_int(meta_name, new_value)
		end
	end
end

function fs_helpers.cycling_button(meta, base, meta_name, values)
	local current_value = meta:get_int(meta_name)
	local new_value = (current_value + 1) % (#values)
	local val = values[current_value + 1]
	local text
	local texture_name = nil
	local addopts = nil
	--when we get a table, we know the caller wants an image_button
	if type(val) == "table" then
		text = val["text"]
		texture_name = val["texture"]
		addopts = val["addopts"]
	else
		text = val
	end
	local field = "fs_helpers_cycling:"..new_value..":"..meta_name
	return base..";"..(texture_name and texture_name..";" or "")..field..";"..minetest.formspec_escape(text)..(addopts and ";"..addopts or "").."]"
end

---------
-- Env --
---------

function pipeworks.load_position(pos)
	if pos.x < -30912 or pos.y < -30912 or pos.z < -30912 or
	   pos.x >  30927 or pos.y >  30927 or pos.z >  30927 then return end
	if minetest.get_node_or_nil(pos) then
		return
	end
	local vm = minetest.get_voxel_manip()
	vm:read_from_map(pos, pos)
end

local function delay(...)
	local args = {...}
	return (function() return unpack(args) end)
end

local function get_set_wrap(name, is_dynamic)
	return (function(self)
		return self["_" .. name]
	end), (function(self, value)
		if is_dynamic then
			self["_" .. name] = type(value) == "table"
				and table.copy(value) or value
		end
	end)
end

function pipeworks.create_fake_player(def, is_dynamic)
	local wielded_item = ItemStack("")
	if def.inventory and def.wield_list then
		wielded_item = def.inventory:get_stack(def.wield_list, def.wield_index or 1)
	end
	local p = {
		get_player_name = delay(def.name),
		is_player = delay(true),
		is_fake_player = true,

		_formspec = def.formspec or default.gui_survival_form,
		_hp = def.hp or 20,
		_breath = 11,
		_pos = def.position and table.copy(def.position) or vector.new(),
		_properties = def.properties or { eye_height = def.eye_height or 1.47 },
		_inventory = def.inventory,
		_wield_index = def.wield_index or 1,
		_wielded_item = wielded_item,

		-- Model and view
		_eye_offset1 = vector.new(),
		_eye_offset3 = vector.new(),
		set_eye_offset = function(self, first, third)
			self._eye_offset1 = table.copy(first)
			self._eye_offset3 = table.copy(third)
		end,
		get_eye_offset = function(self)
			return self._eye_offset1, self._eye_offset3
		end,
		get_look_dir = delay(def.look_dir or {x=0, y=0, z=1}),
		get_look_pitch = delay(def.look_pitch or 0),
		get_look_yaw = delay(def.look_yaw or 0),
		get_look_horizontal = delay(def.look_yaw or 0),
		get_look_vertical = delay(-(def.look_pitch or 0)),
		set_animation = delay(),

		-- Controls
		get_player_control = delay({
			jump=false, right=false, left=false, LMB=false, RMB=false,
			sneak=def.sneak, aux1=false, down=false, up=false
		}),
		get_player_control_bits = delay(def.sneak and 64 or 0),

		-- Inventory and ItemStacks
		get_inventory = delay(def.inventory),
		set_wielded_item = function(self, item)
			if self._inventory and def.wield_list then
				return self._inventory:set_stack(def.wield_list,
					self._wield_index, item)
			end
			_wielded_item = ItemStack(item)
		end,
		get_wielded_item = function(self, item)
			if self._inventory and def.wield_list then
				return self._inventory:get_stack(def.wield_list,
					self._wield_index)
			end
			return ItemStack(self._wielded_item)
		end,
		get_wield_list = delay(def.wield_list),

		punch = delay(),
		remove = delay(),
		right_click = delay(),
		set_attach = delay(),
		set_detach = delay(),
		set_bone_position = delay(),
		hud_change = delay(),
	}
	local _trash
	-- Getter & setter functions
	p.get_inventory_formspec, p.set_inventory_formspec
		= get_set_wrap("formspec", is_dynamic)
	p.get_breath, p.set_breath = get_set_wrap("breath", is_dynamic)
	p.get_hp, p.set_hp = get_set_wrap("hp", is_dynamic)
	p.get_pos, p.set_pos = get_set_wrap("pos", is_dynamic)
	_trash, p.move_to = get_set_wrap("pos", is_dynamic)
	p.get_wield_index, p.set_wield_index = get_set_wrap("wield_index", true)
	p.get_properties, p.set_properties = get_set_wrap("properties", false)

	-- Backwards compatibilty
	p.getpos = p.get_pos
	p.setpos = p.set_pos
	p.moveto = p.move_to

	-- TODO "implement" all these
	-- set_armor_groups
	-- get_armor_groups
	-- get_animation
	-- get_bone_position
	-- get_player_velocity
	-- set_look_pitch
	-- set_look_yaw
	-- set_physics_override
	-- get_physics_override
	-- hud_add
	-- hud_remove
	-- hud_get
	-- hud_set_flags
	-- hud_get_flags
	-- hud_set_hotbar_itemcount
	-- hud_get_hotbar_itemcount
	-- hud_set_hotbar_image
	-- hud_get_hotbar_image
	-- hud_set_hotbar_selected_image
	-- hud_get_hotbar_selected_image
	-- hud_replace_builtin
	-- set_sky
	-- get_sky
	-- override_day_night_ratio
	-- get_day_night_ratio
	-- set_local_animation
	return p
end
