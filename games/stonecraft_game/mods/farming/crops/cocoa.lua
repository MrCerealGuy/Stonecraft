
local S = minetest.get_translator("farming")

-- place cocoa
local function place_cocoa(itemstack, placer, pointed_thing, plantname)

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

	-- check if pointing at jungletree
	if (under.name ~= "default:jungletree" and under.name ~= "mcl_core:jungletree")
	or minetest.get_node(pt.above).name ~= "air" then
		return
	end

	-- is player planting crop?
	local name = placer and placer:get_player_name() or ""

	-- check for protection
	if minetest.is_protected(pt.above, name) then return end

	-- add the node and remove 1 item from the itemstack
	minetest.set_node(pt.above, {name = plantname})

	minetest.sound_play("default_place_node", {pos = pt.above, gain = 1.0}, true)

	if placer and not farming.is_creative(placer:get_player_name()) then

		itemstack:take_item()

		-- check for refill
		if itemstack:get_count() == 0 then

			minetest.after(0.20, farming.refill_plant, placer,
					"farming:cocoa_beans_raw", placer:get_wield_index())
		end
	end

	return itemstack
end

-- item/seed

minetest.register_craftitem("farming:cocoa_beans_raw", {
	description = S("Raw Cocoa Beans"),
	inventory_image = "farming_cocoa_beans.png^[brighten",
	groups = {compostability = 48, seed = 1, flammable = 2},

	on_place = function(itemstack, placer, pointed_thing)
		return place_cocoa(itemstack, placer, pointed_thing, "farming:cocoa_1")
	end
})

-- crop definition

local def = {
	description = S("Cocoa Beans") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_cocoa_1.png"},
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	drop = {},
	groups = {
		handy = 1, snappy = 3, flammable = 2, plant = 1, growing = 1,
		not_in_creative_inventory = 1, leafdecay = 1, leafdecay_drop = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults(),

	-- custom function that returns True when conditions are met
	growth_check = function(pos, node_name)

		if minetest.find_node_near(pos, 1,
				{"default:jungletree", "mcl_core:jungletree"}) then
			return true -- place next growth stage
		end

		return false -- condition not met, skip growth stage until next check
	end
}

-- stage 1

minetest.register_node("farming:cocoa_1", table.copy(def))

-- stage 2

def.tiles = {"farming_cocoa_2.png"}
minetest.register_node("farming:cocoa_2", table.copy(def))

-- stage3

def.tiles = {"farming_cocoa_3.png"}
def.drop = {
	items = {
		{items = {"farming:cocoa_beans_raw"}, rarity = 1}
	}
}
minetest.register_node("farming:cocoa_3", table.copy(def))

-- stage 4 (final)

def.tiles = {"farming_cocoa_4.png"}
def.groups.growing = nil
def.growth_check = nil
def.drop = {
	items = {
		{items = {"farming:cocoa_beans_raw 2"}, rarity = 1},
		{items = {"farming:cocoa_beans_raw"}, rarity = 2},
		{items = {"farming:cocoa_beans_raw"}, rarity = 3}
	}
}
minetest.register_node("farming:cocoa_4", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:cocoa_beans"] = {
	trellis = "default:jungletree",
	crop = "farming:cocoa",
	seed = "farming:cocoa_beans_raw",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 4
}

-- add random cocoa pods to jungle tree's

local random = math.random -- localise for speed

minetest.register_on_generated(function(minp, maxp)

	if maxp.y < 0 then return end

	local pos, dir
	local cocoa = minetest.find_nodes_in_area(minp, maxp,
			{"default:jungletree", "mcl_core:jungletree"})

	for n = 1, #cocoa do

		pos = cocoa[n]

		if minetest.find_node_near(pos, 1,
			{"default:jungleleaves", "moretrees:jungletree_leaves_green",
			"mcl_core:jungleleaves"}) then

			dir = random(80)

			    if dir == 1 then pos.x = pos.x + 1
			elseif dir == 2 then pos.x = pos.x - 1
			elseif dir == 3 then pos.z = pos.z + 1
			elseif dir == 4 then pos.z = pos.z - 1
			end

			if dir < 5
			and minetest.get_node(pos).name == "air"
			and minetest.get_node_light(pos) > 12 then

--print ("Cocoa Pod added at " .. minetest.pos_to_string(pos))

				minetest.set_node(pos, {
					name = "farming:cocoa_" .. tostring(random(4))
				})
			end
		end
	end
end)
