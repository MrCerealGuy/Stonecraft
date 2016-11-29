
-- TODO: make these chests as chests and indicate that they are owned by npc
-- TODO: add bags (not for carrying around but for decoration)

-- Boilerplate to support localized strings if intllib mod is installed.
local S = cottages.S

cottages_chests = {}
-- uses default.chest_formspec for now
cottages_chests.on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",default.chest_formspec)
--		meta:set_string("infotext", "Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end

cottages_chests.can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end

-- the chests do not need receipes since they are only placeholders and not intended to be built by players
-- (they are later on supposed to be filled with diffrent items by fill_chest.lua)
minetest.register_node("cottages:chest_private", {
        description = S("private NPC chest"),
        infotext = "chest containing the possesions of one of the inhabitants",
	tiles = cottages.texture_chest,
        paramtype2 = "facedir",
        groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
        legacy_facedir_simple = true,
        on_construct = cottages_chests.on_construct,
        can_dig      = cottages_chests.can_dig,
	is_ground_content = false,
})

minetest.register_node("cottages:chest_work", {
        description = S("chest for work utils and kitchens"),
        infotext = "everything the inhabitant needs for his work",
	tiles = cottages.texture_chest,
        paramtype2 = "facedir",
        groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
        legacy_facedir_simple = true,
        on_construct = cottages_chests.on_construct,
        can_dig      = cottages_chests.can_dig,
	is_ground_content = false,
})

minetest.register_node("cottages:chest_storage", {
        description = S("storage chest"),
        infotext = "stored food reserves",
	tiles = cottages.texture_chest,
        paramtype2 = "facedir",
        groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
        legacy_facedir_simple = true,
        on_construct = cottages_chests.on_construct,
        can_dig      = cottages_chests.can_dig,
	is_ground_content = false,
})

