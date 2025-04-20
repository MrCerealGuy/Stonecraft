
-- All textures by (C) Auke Kok <sofar@foo-projects.org> CC-BY-SA-3.0

local S = minetest.get_translator("farming")
local a = farming.recipe_items

-- place beans helper

local function place_beans(itemstack, placer, pointed_thing, plantname)

	local pt = pointed_thing

	-- check if pointing at a node
	if not pt or pt.type ~= "node" then return end

	local under = minetest.get_node(pt.under)

	-- return if any of the nodes are not registered
	if not minetest.registered_nodes[under.name] then return end

	-- am I right-clicking on something that has a custom on_place set?
	-- thanks to Krock for helping with this issue :)
	local def = minetest.registered_nodes[under.name]

	if placer and itemstack and def and def.on_rightclick then
		return def.on_rightclick(pt.under, under, placer, itemstack, pt)
	end

	-- is player planting crop?
	local name = placer and placer:get_player_name() or ""

	-- check for protection
	if minetest.is_protected(pt.under, name) then return end

	-- check if pointing at bean pole
	if under.name ~= "farming:beanpole" then return end

	-- add the node and remove 1 item from the itemstack
	minetest.set_node(pt.under, {name = plantname})

	minetest.sound_play("default_place_node", {pos = pt.under, gain = 1.0}, true)

	if placer or not farming.is_creative(placer:get_player_name()) then

		itemstack:take_item()

		-- check for refill
		if itemstack:get_count() == 0 then

			minetest.after(0.20,
				farming.refill_plant, placer, "farming:beans", placer:get_wield_index())
		end
	end

	return itemstack
end

-- item/seed

minetest.register_craftitem("farming:beans", {
	description = S("Green Beans"),
	inventory_image = "farming_beans.png",
	groups = {compostability = 48, seed = 2, food_beans = 1},
	on_use = minetest.item_eat(1),

	on_place = function(itemstack, placer, pointed_thing)
		return place_beans(itemstack, placer, pointed_thing, "farming:beanpole_1")
	end
})

farming.add_eatable("farming:beans", 1)

-- beanpole

minetest.register_node("farming:beanpole", {
	description = S("Bean Pole (place on soil before planting beans)"),
	drawtype = "plantlike",
	tiles = {"farming_beanpole.png"},
	inventory_image = "farming_beanpole.png",
	visual_scale = 1.90,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = "farming:beanpole",
	selection_box = farming.select,
	groups = {handy = 1, snappy = 3, flammable = 2, attached_node = 1},
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults(),

	on_place = function(itemstack, placer, pointed_thing)

		local pt = pointed_thing

		-- check if pointing at a node
		if not pt or pt.type ~= "node" then return end

		local under = minetest.get_node(pt.under)

		-- return if any of the nodes are not registered
		if not minetest.registered_nodes[under.name] then return end

		-- am I right-clicking on something that has a custom on_place set?
		-- thanks to Krock for helping with this issue :)
		local def = minetest.registered_nodes[under.name]

		if def and def.on_rightclick then
			return def.on_rightclick(pt.under, under, placer, itemstack, pt)
		end

		if minetest.is_protected(pt.above, placer:get_player_name()) then
			return
		end

		local nodename = under.name

		if minetest.get_item_group(nodename, "soil") < 2 then return end

		local top = {
			x = pointed_thing.above.x,
			y = pointed_thing.above.y + 1,
			z = pointed_thing.above.z
		}

		nodename = minetest.get_node(top).name

		if nodename ~= "air" then return end

		minetest.set_node(pointed_thing.above, {name = "farming:beanpole"})

		if not farming.is_creative(placer:get_player_name()) then
			itemstack:take_item()
		end

		return itemstack
	end
})

-- crop definition

local def = {
	description = S("Green Beans") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_beanpole_1.png"},
	visual_scale = 1.90,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {"farming:beanpole"}, rarity = 1}
		}
	},
	selection_box = farming.select,
	groups = {
		handy = 1, snappy = 3, flammable = 3, not_in_creative_inventory = 1,
		attached_node = 1, growing = 1, plant = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults()
}

-- stage 1

minetest.register_node("farming:beanpole_1", table.copy(def))

-- stage2

def.tiles = {"farming_beanpole_2.png"}
minetest.register_node("farming:beanpole_2", table.copy(def))

-- stage 3

def.tiles = {"farming_beanpole_3.png"}
minetest.register_node("farming:beanpole_3", table.copy(def))

-- stage 4

def.tiles = {"farming_beanpole_4.png"}
minetest.register_node("farming:beanpole_4", table.copy(def))

-- stage 5 (final)

def.tiles = {"farming_beanpole_5.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:beanpole"}, rarity = 1},
		{items = {"farming:beans 3"}, rarity = 1},
		{items = {"farming:beans"}, rarity = 2},
		{items = {"farming:beans"}, rarity = 3}
	}
}
minetest.register_node("farming:beanpole_5", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:beans"] = {
	trellis = "farming:beanpole",
	crop = "farming:beanpole",
	seed = "farming:beans",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 5
}

-- wild green bean bush (this is what you find on the map)

minetest.register_node("farming:beanbush", {
	drawtype = "plantlike",
	tiles = {"farming_beanbush.png"},
	paramtype = "light",
	waving = 1,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {"farming:beans 1"}, rarity = 1},
			{items = {"farming:beans 1"}, rarity = 2},
			{items = {"farming:beans 1"}, rarity = 3}
		}
	},
	selection_box = farming.select,
	groups = {
		handy = 1, snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		compostability = 35, not_in_creative_inventory = 1
	},
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults()
})

-- mapgen

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "mcl_core:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.beans,
		spread = {x = 100, y = 100, z = 100},
		seed = 345,
		octaves = 3,
		persist = 0.6
	},
	y_min = 18, y_max = 38,
	decoration = "farming:beanbush"
})
