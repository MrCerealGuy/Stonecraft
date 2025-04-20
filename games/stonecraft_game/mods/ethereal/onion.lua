
local S = minetest.get_translator("ethereal")

-- wild onion

minetest.register_craftitem("ethereal:wild_onion_plant", {
	description = S("Wild Onion"),
	inventory_image = "ethereal_wild_onion.png",
	wield_image = "ethereal_wild_onion.png",
	groups = {food_onion = 1},
	on_use = minetest.item_eat(2),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "ethereal:wild_onion_1")
	end
})

ethereal.add_eatable("ethereal:wild_onion_plant", 2)

-- Onion definition

local def = {
	description = S("Wild Onion") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"ethereal_wild_onion_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = {
		type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
	},
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		growing = 1, not_in_creative_inventory = 1
	},
	sounds = default.node_sound_leaves_defaults()
}

--stage 1

minetest.register_node("ethereal:onion_1", table.copy(def))

--stage 2

def.tiles = {"ethereal_wild_onion_2.png"}
minetest.register_node("ethereal:onion_2", table.copy(def))

--stage 3

def.tiles = {"ethereal_wild_onion_3.png"}
minetest.register_node("ethereal:onion_3", table.copy(def))

--stage 4

def.tiles = {"ethereal_wild_onion_4.png"}
def.drop = {
	items = {
		{items = {"ethereal:wild_onion_plant"}, rarity = 1},
		{items = {"ethereal:wild_onion_plant"}, rarity = 3},
	}
}
minetest.register_node("ethereal:onion_4", table.copy(def))

--stage 5

def.tiles = {"ethereal_wild_onion_5.png"}
def.groups.growing = nil
def.selection_box = {
	type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -2.5/16, 0.5}
}
def.drop = {
	items = {
		{items = {"ethereal:wild_onion_plant 2"}, rarity = 1},
		{items = {"ethereal:wild_onion_plant"}, rarity = 2},
		{items = {"ethereal:wild_onion_plant"}, rarity = 3}
	}
}
minetest.register_node("ethereal:onion_5", table.copy(def))

-- register for use with farming redo growth routines

if farming and farming.mod and farming.mod == "redo" then

	-- add to registered_plants
	farming.registered_plants["ethereal:wild_onion_plant"] = {
		crop = "ethereal:onion",
		seed = "ethereal:wild_onion_plant",
		minlight = farming.min_light,
		maxlight = farming.max_light,
		steps = 5
	}
else
	minetest.register_abm({
		label = "Ethereal grow onion",
		nodenames = {
			"ethereal:onion_1", "ethereal:onion_2", "ethereal:onion_3",
			"ethereal:onion_4"
		},
		neighbors = {"farming:soil_wet"},
		interval = 11,
		chance = 20,
		catch_up = false,

		action = function(pos, node)

			-- are we on wet soil?
			pos.y = pos.y - 1

			if minetest.get_item_group(minetest.get_node(pos).name, "soil") < 3 then
				return
			end

			pos.y = pos.y + 1

			-- do we have enough light?
			local light = minetest.get_node_light(pos) or 0 ; if light < 13 then return end

			-- grow to next stage
			local num = node.name:split("_")[2]

			node.name = "ethereal:onion_" .. tonumber(num + 1)

			minetest.swap_node(pos, node)
		end
	})
end
