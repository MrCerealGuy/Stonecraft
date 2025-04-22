
-- add group helper

local function add_groups(item, groups)

	local def = minetest.registered_items[item]

	if def then

		local grps = table.copy(def.groups) or {}

		for k, v in pairs(groups) do
			grps[k] = v
		end

		minetest.override_item(item, {groups = grps})
	end
end

-- default recipe items

farming.recipe_items = {

	-- if utensils are disabled then use blank item
	saucepan = farming.use_utensils and "farming:saucepan" or "",
	pot = farming.use_utensils and "farming:pot" or "",
	baking_tray = farming.use_utensils and "farming:baking_tray" or "",
	skillet = farming.use_utensils and "farming:skillet" or "",
	mortar_pestle = farming.use_utensils and "farming:mortar_pestle" or "",
	cutting_board = farming.use_utensils and "farming:cutting_board" or "",
	juicer = farming.use_utensils and "farming:juicer" or "",
	mixing_bowl = farming.use_utensils and "farming:mixing_bowl" or "",

	water_source = "default:water_source",
	river_water_source = "default:river_water_source",
	bucket_empty = "bucket:bucket_empty",
	bucket_water = "bucket:bucket_water",
	bucket_river_water = "bucket:bucket_river_water",
	drinking_glass = "vessels:drinking_glass",
	glass_bottle = "vessels:glass_bottle",
	sugar = "farming:sugar",
	rose = "flowers:rose",
	dye_red = "dye:red",
	dye_pink = "dye:pink",
	dye_orange = "dye:orange",
	dye_green = "dye:green",
	dye_brown = "dye:brown",
	dye_blue = "dye:blue",
	dye_violet = "dye:violet",
	dye_yellow = "dye:yellow",
	bowl = "farming:bowl",
	flour = "group:food_flour",
	bread = "farming:bread",
	cactus = "default:cactus",
	paper = "default:paper",
	snow = "default:snow",
	string = "farming:string",
	wool = "wool:white",
	steel_ingot = "default:steel_ingot",
	clay_brick = "default:clay_brick",
	stone = "default:stone",
	glass = "default:glass",
}

add_groups("default:apple", {food_apple = 1})


-- if mineclone found then change recipe items

if farming.mcl then

	local a = farming.recipe_items

	a.water_source = "mcl_core:water_source"
	a.river_water_source = "mclx_core:river_water_source"
	a.bucket_empty = "mcl_buckets:bucket_empty"
	a.bucket_water = "mcl_buckets:bucket_water"
	a.bucket_river_water = "mcl_buckets:bucket_river_water"
	a.drinking_glass = "mcl_potions:glass_bottle"
	a.glass_bottle = "mcl_potions:glass_bottle"
	a.sugar = "mcl_core:sugar"
	a.rose = "mcl_flowers:rose_bush"
	a.dye_red = "mcl_dye:red"
	a.dye_pink = "mcl_dye:pink"
	a.dye_orange = "mcl_dye:orange"
	a.dye_green = "mcl_dye:green"
	a.dye_brown = "mcl_dye:brown"
	a.dye_blue = "mcl_dye:blue"
	a.dye_violet = "mcl_dye:violet"
	a.dye_yellow = "mcl_dye:yellow"
	a.bowl = "mcl_core:bowl"
--	a.flour = "mcl_farming:bread"
	a.bread = "mcl_farming:bread"
	a.cactus = "mcl_core:cactus"
	a.paper = "mcl_core:paper"
	a.snow = "mcl_throwing:snowball"
	a.string = "mcl_mobitems:string"
	a.wool = "mcl_wool:white"
	a.steel_ingot = "mcl_core:iron_ingot"
	a.clay_brick = "mcl_core:clay_lump"
	a.stone = "mcl_core:stone"
	a.glass = "mcl_core:glass"

	-- add missing groups for recipes to work properly

	add_groups("mcl_core:sugar", {food_sugar = 1})
	add_groups("mcl_throwing:egg", {food_egg = 1})
	add_groups("mcl_farming:wheat_item", {food_wheat = 1})
	add_groups("mcl_cocoas:cocoa_beans", {food_cocoa = 1})
	add_groups("mcl_core:apple", {food_apple = 1})
	add_groups("mcl_core:bowl", {food_bowl = 1})
	add_groups("mcl_mobitems:chicken", {food_chicken_raw = 1})
	add_groups("mcl_mobitems:cooked_chicken", {food_chicken = 1})
	add_groups("mcl_mushrooms:mushroom_brown", {food_mushroom = 1})
	add_groups("mcl_farming:carrot_item", {food_carrot = 1})
	add_groups("mcl_mobitems:cooked_beef", {food_meat = 1})
	add_groups("mcl_mobitems:beef", {food_meat_raw = 1})
	add_groups("mcl_farming:potato_item", {food_potato = 1})
	add_groups("mcl_farming:bread", {food_bread = 1})
	add_groups("mcl_mobitems:milk_bucket", {food_milk = 1})
	add_groups("mcl_ocean:dried_kelp", {food_seaweed = 1})
	add_groups("mcl_potions:river_water", {food_glass_water = 1})
	add_groups("mcl_dye:yellow", {food_lemon = 1, food_banana = 1})
	add_groups("mcl_dye:orange", {food_orange = 1})
	add_groups("mcl_flowers:sunflower", {food_olive_oil = 1, food_butter = 1})
end
