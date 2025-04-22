mineunit:set_modpath("default", "spec/fixtures")

local function register_node(name, groups, additional_definition)
	local definition = {
		description = name.." description",
		tiles = { "default_"..name },
		groups = groups,
	}
	for k,v in pairs(additional_definition or {}) do definition[k] = v end
	minetest.register_node(":default:"..name, definition)
end

local function register_item(name)
	minetest.register_craftitem(":default:"..name, {
		description = name.." description",
	})
end

-- Register some basic nodes for cutting, grinding, digging, registering recipes etc.
register_node("stone", {cracky = 3, stone = 1}, {is_ground_content = true, drop = "default:cobble"})
register_node("cobble", {cracky=3, stone = 2})
register_node("sand", {snappy=2, choppy=2, oddly_breakable_by_hand=2})
register_node("wood", {tree=1, choppy=2, oddly_breakable_by_hand=2})
register_node("dirt", {crumbly = 3, soil = 1})
register_node("sandstone", {crumbly = 1, cracky = 3})
register_node("steelblock", {cracky = 1, level = 2})
register_node("furnace", {cracky=2})
register_node("furnace_active", {cracky=2, not_in_creative_inventory=1}, {drop = "default:furnace"})

register_item("steel_ingot")

screwdriver = {}