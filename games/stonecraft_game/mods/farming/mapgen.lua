
-- decoration function
local function register_plant(name, min, max, spawnon, spawnby, num, enabled)

	if enabled ~= true then
		return
	end

	minetest.register_decoration({
		deco_type = "simple",
		place_on = spawnon or {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = farming.rarety, -- 0.006,
			spread = {x = 100, y = 100, z = 100},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		y_min = min,
		y_max = max,
		decoration = "farming:" .. name,
		spawn_by = spawnby,
		num_spawn_by = num,
	})
end


-- add crops to mapgen
register_plant("potato_3", 15, 40, nil, "", -1, farming.potato)
register_plant("tomato_7", 5, 20, nil, "", -1, farming.tomato)
register_plant("corn_7", 12, 22, nil, "", -1, farming.corn)
register_plant("coffee_5", 20, 45, {"default:dirt_with_dry_grass",
	"default:dirt_with_rainforest_litter"}, "", -1, farming.coffee)
register_plant("raspberry_4", 3, 10, nil, "", -1, farming.raspberry)
register_plant("rhubarb_3", 3, 15, nil, "", -1, farming.rhubarb)
register_plant("blueberry_4", 3, 10, nil, "", -1, farming.blueberry)
register_plant("beanbush", 18, 35, nil, "", -1, farming.beans)
register_plant("grapebush", 25, 45, nil, "", -1, farming.grapes)
register_plant("onion_5", 5, 22, nil, "", -1, farming.onion)
register_plant("garlic_5", 3, 30, nil, "group:tree", 1, farming.garlic)
register_plant("pea_5", 25, 50, nil, "", -1, farming.peas)
register_plant("beetroot_5", 1, 15, nil, "", -1, farming.beetroot)


if minetest.get_mapgen_setting("mg_name") == "v6" then

	register_plant("carrot_8", 1, 30, nil, "group:water", 1, farming.carrot)
	register_plant("cucumber_4", 1, 20, nil, "group:water", 1, farming.cucumber)
	register_plant("melon_8", 1, 20, nil, "group:water", 1, farming.melon)
	register_plant("pumpkin_8", 1, 20, nil, "group:water", 1, farming.pumpkin)
else
	-- v7 maps have a beach so plants growing near water is limited to 6 high
	register_plant("carrot_8", 1, 15, nil, "", -1, farming.carrot)
	register_plant("cucumber_4", 1, 10, nil, "", -1, farming.cucumber)
	register_plant("melon_8", 1, 6, {"default:dirt_with_dry_grass",
	"default:dirt_with_rainforest_litter"}, "", -1, farming.melon)
	register_plant("pumpkin_8", 1, 6, nil, "", -1, farming.pumpkin)
end

if farming.hemp then
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.rarety, -- 0.06,
		spread = {x = 100, y = 100, z = 100},
		seed = 420,
		octaves = 3,
		persist = 0.6
	},
	y_min = 3,
	y_max = 45,
	decoration = "farming:hemp_7",
	spawn_by = "group:tree",
	num_spawn_by = 1,
})
end

if farming.chili then
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.rarety, -- 0.06,
		spread = {x = 100, y = 100, z = 100},
		seed = 760,
		octaves = 3,
		persist = 0.6
	},
	y_min = 5,
	y_max = 35,
	decoration = {"farming:chili_8"},
	spawn_by = "group:tree",
	num_spawn_by = 1,
})
end

if farming.pepper then
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_rainforest_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.rarety, -- 0.06,
		spread = {x = 100, y = 100, z = 100},
		seed = 933,
		octaves = 3,
		persist = 0.6
	},
	y_min = 5,
	y_max = 35,
	decoration = {"farming:pepper_5"},
	spawn_by = "group:tree",
	num_spawn_by = 1,
})
end

if farming.pineapple then
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.rarety, -- 0.06,
		spread = {x = 100, y = 100, z = 100},
		seed = 917,
		octaves = 3,
		persist = 0.6
	},
	y_min = 18,
	y_max = 30,
	decoration = {"farming:pineapple_8"},
})
end
