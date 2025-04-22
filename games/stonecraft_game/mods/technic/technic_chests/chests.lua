
local function register_chests(name, data)
	for _,t in pairs({"", "_locked", "_protected"}) do
		local data_copy = {}
		for k, v in pairs(data) do
			data_copy[k] = v
		end
		data_copy.locked = t == "_locked"
		data_copy.protected = t == "_protected"
		technic.chests.register_chest(name, data_copy)
	end
end

local function register_crafts(name, material, base_open, base_locked, base_protected)
	name = name:lower()
	if minetest.registered_items[material] then
		if minetest.registered_items[base_open] then
			minetest.register_craft({
				output = "technic:"..name.."_chest",
				recipe = {
					{material, material, material},
					{material, base_open, material},
					{material, material, material},
				}
			})
		end
		if minetest.registered_items[base_locked] then
			minetest.register_craft({
				output = "technic:"..name.."_locked_chest",
				recipe = {
					{material, material, material},
					{material, base_locked, material},
					{material, material, material},
				}
			})
		end
		if minetest.registered_items[base_protected] then
			minetest.register_craft({
				output = "technic:"..name.."_protected_chest",
				recipe = {
					{material, material, material},
					{material, base_protected, material},
					{material, material, material},
				}
			})
		end
	end
	minetest.register_craft({
		output = "technic:"..name.."_locked_chest",
		type = "shapeless",
		recipe = {"basic_materials:padlock","technic:"..name.."_chest"}
	})
	minetest.register_craft({
		output = "technic:"..name.."_protected_chest",
		type = "shapeless",
		recipe = {"default:copper_ingot", "technic:"..name.."_chest"}
	})
	minetest.register_craft({
		output = "technic:"..name.."_chest",
		type = "shapeless",
		recipe = {"technic:"..name.."_locked_chest"}
	})
	minetest.register_craft({
		output = "technic:"..name.."_chest",
		type = "shapeless",
		recipe = {"technic:"..name.."_protected_chest"}
	})
end

-- Iron
register_chests("Iron", {
	width = 9,
	height = 5,
	sort = true,
	infotext = true,
})
register_crafts(
	"Iron",
	minetest.get_modpath("technic_worldgen") and "technic:cast_iron_ingot" or "default:steel_ingot",
	"default:chest",
	"default:chest_locked",
	"protector:chest"
)

-- Copper
register_chests("Copper", {
	width = 12,
	height = 5,
	sort = true,
	infotext = true,
	autosort = true,
})
register_crafts(
	"Copper",
	"default:copper_ingot",
	"technic:iron_chest",
	"technic:iron_locked_chest",
	"technic:iron_protected_chest"
)

-- Silver
register_chests("Silver", {
	width = 12,
	height = 6,
	sort = true,
	infotext = true,
	autosort = true,
	quickmove = true,
})
register_crafts(
	"Silver",
	"moreores:silver_ingot",
	"technic:copper_chest",
	"technic:copper_locked_chest",
	"technic:copper_protected_chest"
)

-- Gold
register_chests("Gold", {
	width = 15,
	height = 6,
	sort = true,
	infotext = true,
	autosort = true,
	quickmove = true,
	color = true,
})
register_crafts(
	"Gold",
	"default:gold_ingot",
	minetest.get_modpath("moreores") and "technic:silver_chest" or "technic:copper_chest",
	minetest.get_modpath("moreores") and "technic:silver_locked_chest" or "technic:copper_locked_chest",
	minetest.get_modpath("moreores") and "technic:silver_protected_chest" or "technic:copper_protected_chest"
)

-- Mithril
register_chests("Mithril", {
	width = 15,
	height = 6,
	sort = true,
	infotext = true,
	autosort = true,
	quickmove = true,
	digilines = true,
})
register_crafts(
	"Mithril",
	"moreores:mithril_ingot",
	"technic:gold_chest",
	"technic:gold_locked_chest",
	"technic:gold_protected_chest"
)
