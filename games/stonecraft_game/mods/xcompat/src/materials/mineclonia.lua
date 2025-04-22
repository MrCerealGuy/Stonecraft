--note this file handles mineclonia, mineclone2, and its rename voxelibre

local mcl_dyes = minetest.get_modpath("mcl_dyes")
local mcl_dyes_name = mcl_dyes and "mcl_dyes" or "mcl_dye"

local materials = {
    sand = "mcl_core:sand",
    sandstone = "mcl_core:sandstone",
    gravel = "mcl_core:gravel",
    flint = "mcl_core:flint",
    copper_ingot = "mcl_copper:copper_ingot",
    steel_ingot = "mcl_core:iron_ingot",
    gold_ingot = "mcl_core:gold_ingot",
    tin_ingot = "mcl_core:iron_ingot",
    copper_block = "mcl_copper:block",
    steel_block = "mcl_core:ironblock",
    gold_block = "mcl_core:goldblock",
    tin_block = "mcl_core:ironblock",
    axe_steel = "mcl_core:axe_steel",
    axe_diamond = "mcl_core:axe_diamond",
    axe_bronze = "mcl_core:axe_bronze",
    axe_stone = "mcl_core:axe_stone",
    axe_wood = "mcl_core:axe_wood",
    pick_steel = "mcl_core:pick_steel",
    torch = "mcl_torches:torch",
    diamond = "mcl_core:diamond",
    clay_lump = "mcl_core:clay_lump",
    water_bucket = "mcl_buckets:bucket_water",
    empty_bucket = "mcl_buckets:bucket_empty",
    dye_dark_grey = mcl_dyes_name .. ":dark_grey",
    dye_black = mcl_dyes_name .. ":black",
    dye_white = mcl_dyes_name .. ":white",
    dye_green = mcl_dyes_name .. ":green",
    dye_red = mcl_dyes_name .. ":red",
    dye_yellow = mcl_dyes_name .. ":yellow",
    dye_brown = mcl_dyes_name .. ":brown",
    dye_blue = mcl_dyes_name .. ":blue",
    dye_violet = mcl_dyes_name .. ":violet",
    dye_grey = mcl_dyes_name .. ":grey",
    dye_dark_green = mcl_dyes_name .. ":dark_green",
    dye_orange = mcl_dyes_name .. ":orange",
    dye_pink = mcl_dyes_name .. ":pink",
    dye_cyan = mcl_dyes_name .. ":cyan",
    dye_magenta = mcl_dyes_name .. ":magenta",
    silicon = "mcl_core:iron_ingot",
    string = "mcl_mobitems:string",
    paper = "mcl_core:paper",
    book = "mcl_books:book",
    iron_lump = "mcl_raw_ores:raw_iron",
    wool_grey = "mcl_wool:grey",
    wool_green = "mcl_wool:green",
    wool_dark_green = "mcl_wool:dark_green",
    wool_brown = "mcl_wool:brown",
    wool_black = "mcl_wool:black",
    wool_white = "mcl_wool:white",
    slab_stone = "mcl_stairs:slab_stone",
    slab_wood = "mcl_stairs:slab_wood",
    glass = "mcl_core:glass",
    glass_block = "mcl_core:glass",
    glass_bottle = "mcl_potions:glass_bottle",
    coal_lump = "mcl_core:coal_lump",
    stone = "mcl_core:stone",
    desert_stone = "mcl_core:redsandstone",
    desert_sand = "mcl_core:sand",
    chest = "mcl_chests:chest",
    cobble = "mcl_core:cobble",
    brick = "mcl_core:brick",
    obsidian_glass = "",
    water_source = "mcl_core:water_source",
    water_flowing = "mcl_core:water_flowing",
    dirt = "mcl_core:dirt",
    dirt_with_grass = "mcl_core:dirt_with_grass",
    bowl = "mcl_core:bowl",
    stick = "mcl_core:stick",
}

if minetest.get_modpath("mcl_redstone") then
    materials.mese = "mcl_redstone_torch:redstoneblock"
    materials.mese_crystal = "mcl_redstone:redstone"
    materials.mese_crystal_fragment = "mcl_core:iron_ingot"
else
    materials.mese = "mesecons_torch:redstoneblock"
    materials.mese_crystal = "mesecons:redstone"
    materials.mese_crystal_fragment = "mcl_core:iron_ingot"
end

if minetest.get_modpath("mcl_trees") then
    materials.apple_leaves = "mcl_trees:leaves_oak"
    materials.apple_log = "mcl_trees:tree_oak"
    materials.apple_planks = "mcl_trees:wood_oak"
    materials.birch_leaves = "mcl_trees:leaves_birch"
    materials.birch_log = "mcl_trees:tree_birch"
    materials.birch_planks = "mcl_trees:wood_birch"
    materials.jungle_leaves = "mcl_trees:leaves_jungle"
else
    materials.apple_leaves = "mcl_core:leaves"
    materials.apple_log = "mcl_core:tree"
    materials.apple_planks = "mcl_core:wood"
    materials.birch_leaves = "mcl_core:birchleaves"
    materials.birch_log = "mcl_core:birchtree"
    materials.birch_planks = "mcl_core:birchwood"
    materials.jungle_leaves = "mcl_core:jungleleaves"
end

if minetest.get_modpath("moreores") then
    materials.tin_ingot = "moreores:tin_ingot"
    materials.tin_block = "moreores:tin_block"
    materials.silver_ingot = "moreores:silver_ingot"
end

if minetest.get_modpath("technic") then
    materials.lead_ingot = "technic:lead_ingot"
    materials.carbon_steel_ingot = "technic:carbon_steel_ingot"
    materials.stainless_steel_ingot = "technic:stainless_steel_ingot"
end

return materials
