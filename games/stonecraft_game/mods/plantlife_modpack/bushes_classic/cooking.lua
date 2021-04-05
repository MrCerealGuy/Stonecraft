-- support for i18n
local S = minetest.get_translator("bushes_classic")

-- Basket

minetest.register_craft({
	output = "bushes:basket_empty",
	recipe = {
		{ "default:stick", "default:stick", "default:stick" },
		{ "", "default:stick", "" },
	},
})

-- Sugar

if not minetest.registered_items["farming:sugar"] then
	minetest.register_craftitem(":bushes:sugar", {
		description = S("Sugar"),
		inventory_image = "bushes_sugar.png",
		on_use = minetest.item_eat(1),
		groups = {food_sugar=1, flammable = 2}
	})

	minetest.register_craft({
		output = "bushes:sugar 1",
		recipe = {
			{ "default:papyrus", "default:papyrus" },
		},
	})
else
	minetest.register_alias("bushes:sugar", "farming:sugar")
end

-- override farming_plus strawberry and add food_ group
if minetest.get_modpath("farming_plus") then

	minetest.override_item("farming_plus:strawberry_item", {
		groups = {food_strawberry = 1, food_berry = 1, flammable = 2},
	})
end


for i, berry in ipairs(bushes_classic.bushes) do

	local groups = {food_berry = 1, flammable = 2}

	if berry ~= "mixed_berry" then

		groups["food_" .. berry] = 1

		-- Berry
		minetest.register_craftitem(":bushes:"..berry, {
			description = bushes_classic.bushes_descriptions[i][1],
			inventory_image = "bushes_"..berry..".png",
			groups = groups,
			on_use = minetest.item_eat(1),
		})
	end

	-- Raw pie
	minetest.register_craftitem(":bushes:"..berry.."_pie_raw", {
		description = bushes_classic.bushes_descriptions[i][2],
		inventory_image = "bushes_"..berry.."_pie_raw.png",
		on_use = minetest.item_eat(4),
	})

	if berry ~= "mixed_berry" then

		minetest.register_craft({
			output = "bushes:"..berry.."_pie_raw 1",
			recipe = {
			{ "group:food_sugar", "farming:flour", "group:food_sugar" },
			{ "group:food_"..berry, "group:food_"..berry, "group:food_"..berry },
			},
		})
	else
		minetest.register_craft({
			output = "bushes:mixed_berry_pie_raw 2",
			recipe = {
			{ "group:food_sugar", "farming:flour", "group:food_sugar" },
			{ "group:food_berry", "group:food_berry", "group:food_berry" },
			{ "group:food_berry", "group:food_berry", "group:food_berry" },
			},
		})
	end

	-- Cooked pie
	minetest.register_craftitem(":bushes:"..berry.."_pie_cooked", {
		description = bushes_classic.bushes_descriptions[i][3],
		inventory_image = "bushes_"..berry.."_pie_cooked.png",
		on_use = minetest.item_eat(6),
	})

	minetest.register_craft({
		type = "cooking",
		output = "bushes:"..berry.."_pie_cooked",
		recipe = "bushes:"..berry.."_pie_raw",
		cooktime = 30,
	})

	-- Slice of pie
	minetest.register_craftitem(":bushes:"..berry.."_pie_slice", {
		description = bushes_classic.bushes_descriptions[i][4],
		inventory_image = "bushes_"..berry.."_pie_slice.png",
		on_use = minetest.item_eat(1),
	})

	minetest.register_craft({
		output = "bushes:"..berry.."_pie_slice 6",
		recipe = {
		{ "bushes:"..berry.."_pie_cooked" },
		},
	})

	-- Basket with pies
	minetest.register_craft({
		output = "bushes:basket_"..berry.." 1",
		recipe = {
		{ "bushes:"..berry.."_pie_cooked", "bushes:"..berry.."_pie_cooked", "bushes:"..berry.."_pie_cooked" },
		{ "", "bushes:basket_empty", "" },
		},
	})
end
