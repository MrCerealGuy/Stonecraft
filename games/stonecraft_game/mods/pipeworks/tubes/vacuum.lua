
local S = minetest.get_translator("pipeworks")

local has_vislib = minetest.get_modpath("vizlib")

local enable_max = minetest.settings:get_bool("pipeworks_enable_items_per_tube_limit", true)
local max_items = tonumber(minetest.settings:get("pipeworks_max_items_per_tube")) or 30
max_items = math.ceil(max_items / 2)  -- Limit vacuuming to half the max limit

local function vacuum(pos, radius)
	radius = radius + 0.5
	local min_pos = vector.subtract(pos, radius)
	local max_pos = vector.add(pos, radius)
	local count = 0
	for _, obj in pairs(minetest.get_objects_in_area(min_pos, max_pos)) do
		local entity = obj:get_luaentity()
		if entity and entity.name == "__builtin:item" then
			if entity.itemstring ~= "" then
				pipeworks.tube_inject_item(pos, pos, vector.new(0, 0, 0), entity.itemstring)
				entity.itemstring = ""
				count = count + 1
			end
			obj:remove()
			if enable_max and count >= max_items then
				return  -- Don't break tube by vacuuming too many items
			end
		end
	end
end

local function set_timer(pos)
	local timer = minetest.get_node_timer(pos)
	-- Randomize timer so not all tubes vacuum at the same time
	timer:start(math.random(10, 20) * 0.1)
end

local function repair_tube(pos, was_node)
	minetest.swap_node(pos, {name = was_node.name, param2 = was_node.param2})
	pipeworks.scan_for_tube_objects(pos)
	set_timer(pos)
end

local function show_area(pos, node, player)
	if not player or player:get_wielded_item():get_name() ~= "" then
		-- Only show area when using an empty hand
		return
	end
	local radius = tonumber(minetest.get_meta(pos):get("dist")) or 2
	vizlib.draw_cube(pos, radius + 0.5, {player = player})
end

if pipeworks.enable_sand_tube then
	pipeworks.register_tube("pipeworks:sand_tube", {
		description = S("Vacuuming Pneumatic Tube Segment"),
		inventory_image = "pipeworks_sand_tube_inv.png",
		short = "pipeworks_sand_tube_short.png",
		noctr = {"pipeworks_sand_tube_noctr.png"},
		plain = {"pipeworks_sand_tube_plain.png"},
		ends = {"pipeworks_sand_tube_end.png"},
		node_def = {
			groups = {vacuum_tube = 1},
			tube = {
				on_repair = repair_tube,
			},
			on_construct = set_timer,
			on_timer = function(pos, elapsed)
				vacuum(pos, 2)
				set_timer(pos)
			end,
			on_punch = has_vislib and show_area or nil,
		},
	})
end

if pipeworks.enable_mese_sand_tube then
	local formspec = "formspec_version[2]size[8,3]"..
		pipeworks.fs_helpers.get_prepends("8,3")..
		"image[0.5,0.3;1,1;pipeworks_mese_sand_tube_inv.png]"..
		"label[1.75,0.8;"..S("Adjustable Vacuuming Tube").."]"..
		"field[0.5,1.7;5,0.8;dist;"..S("Radius")..";${dist}]"..
		"button_exit[5.5,1.7;2,0.8;save;"..S("Save").."]"

	pipeworks.register_tube("pipeworks:mese_sand_tube", {
		description = S("Adjustable Vacuuming Tube"),
		inventory_image = "pipeworks_mese_sand_tube_inv.png",
		short = "pipeworks_mese_sand_tube_short.png",
		noctr = {"pipeworks_mese_sand_tube_noctr.png"},
		plain = {"pipeworks_mese_sand_tube_plain.png"},
		ends = {"pipeworks_mese_sand_tube_end.png"},
		node_def = {
			groups = {vacuum_tube = 1},
			tube = {
				on_repair = repair_tube,
			},
			on_construct = function(pos)
				local meta = minetest.get_meta(pos)
				meta:set_int("dist", 2)
				meta:set_string("formspec", formspec)
				meta:set_string("infotext", S("Adjustable Vacuuming Tube (@1m)", 2))
				set_timer(pos)
			end,
			on_timer = function(pos, elapsed)
				local radius = minetest.get_meta(pos):get_int("dist")
				vacuum(pos, radius)
				set_timer(pos)
			end,
			on_receive_fields = function(pos, _, fields, sender)
				if not fields.dist or not pipeworks.may_configure(pos, sender) then
					return
				end
				local meta = minetest.get_meta(pos)
				local dist = math.min(math.max(tonumber(fields.dist) or 0, 0), 8)
				meta:set_int("dist", dist)
				meta:set_string("infotext", S("Adjustable Vacuuming Tube (@1m)", dist))
			end,
			on_punch = has_vislib and show_area or nil,
		},
	})
end

minetest.register_lbm({
	label = "Vacuum tube node timer starter",
	name = "pipeworks:vacuum_tube_start",
	nodenames = {"group:vacuum_tube"},
	run_at_every_load = false,
	action = set_timer,
})
