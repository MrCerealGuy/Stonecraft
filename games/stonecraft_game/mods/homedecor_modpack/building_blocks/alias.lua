local S = homedecor_i18n.gettext

if minetest.get_modpath("moreblocks") or minetest.get_modpath("stairs") then
	minetest.register_alias("building_blocks:slab_tar", "stairs:slab_Tar")
	minetest.register_alias("building_blocks:stair_tar", "stairs:stair_Tar")
	minetest.register_alias("building_blocks:slab_marble", "stairs:slab_Marble")
	minetest.register_alias("building_blocks:stair_marble", "stairs:stair_Marble")
end

if minetest.get_modpath("moreblocks") then
	stairsplus:register_alias_all("building_blocks", "tar", "building_blocks", "Tar")
	stairsplus:register_alias_all("building_blocks", "marble", "building_blocks", "Marble")
	for _, i in ipairs(stairsplus.shapes_list) do
		local class = i[1]
		local cut = i[2]
		minetest.unregister_item("moreblocks:"..class.."tar"..cut)
		minetest.register_alias("moreblocks:"..class.."tar"..cut, "building_blocks:"..class.."tar"..cut)
	end
	minetest.unregister_item("moreblocks:tar")
	minetest.register_alias("moreblocks:tar", "building_blocks:Tar")
	stairsplus:register_alias_all("moreblocks", "tar", "building_blocks", "Tar")

	if minetest.get_modpath("gloopblocks") then
		minetest.register_alias("building_blocks:gravel_spread", "gloopblocks:slab_gravel_1")
	end
end

minetest.register_alias("adobe", "building_blocks:Adobe")
minetest.register_alias("fakegrass", "building_blocks:fakegrass")
minetest.register_alias("hardwood", "building_blocks:hardwood")
minetest.register_alias("tar_knife", "building_blocks:knife")
minetest.register_alias("marble", "building_blocks:Marble")
minetest.register_alias("building_blocks_roofing", "building_blocks:Roofing")
minetest.register_alias("sticks", "building_blocks:sticks")
minetest.register_alias("building_blocks:faggot", "building_blocks:sticks")
minetest.register_alias("tar", "building_blocks:Tar")

if not minetest.get_modpath("technic") then
	minetest.register_node( ":technic:granite", {
		    description = S("Granite"),
		    tiles = { "technic_granite.png" },
		    is_ground_content = true,
		    groups = {cracky=1},
		    sounds = default.node_sound_stone_defaults(),
	})
	minetest.register_craft({
		output = "technic:granite 9",
		recipe = {
			{ "group:tar_block", "group:marble", "group:tar_block" },
			{ "group:marble", "group:tar_block", "group:marble" },
			{ "group:tar_block", "group:marble", "group:tar_block" }
		},
	})
	if minetest.get_modpath("moreblocks") then
		stairsplus:register_all("technic", "granite", "technic:granite", {
				description=S("Granite"),
				groups={cracky=1, not_in_creative_inventory=1},
				tiles={"technic_granite.png"},
		})
	end
end
