local materials = {
    sand = "hades_core:fertile_sand",
    sandstone = "hades_core:sandstone",
    gravel = "hades_core:gravel",
    flint = "",
    copper_ingot = "hades_core:copper_ingot",
    steel_ingot = "hades_core:steel_ingot",
    gold_ingot = "hades_core:gold_ingot",
    tin_ingot = "hades_core:tin_ingot",
    silver_ingot = "--unknown--",
    copper_block = "hades_core:copperblock",
    steel_block = "hades_core:steelblock",
    gold_block = "hades_core:goldblock",
    tin_block = "hades_core:tinblock",
    axe_steel = "hades_core:axe_steel",
    axe_diamond = "hades_core:axe_diamond",
    axe_bronze = "hades_core:axe_bronze",
    axe_stone = "hades_core:axe_stone",
    axe_wood = "hades_core:axe_wood",
    pick_steel = "hades_core:pick_steel",
    mese = "hades_core:mese",
    mese_crystal = "hades_core:mese_crystal",
    mese_crystal_fragment = "hades_core:mese_crystal_fragment",
    torch = "hades_torches:torch",
    diamond = "hades_core:diamond",
    clay_lump = "hades_core:clay_lump",
    clay_brick = "hades_core:clay_brick",

    --[[
        Since hades doesnt have buckets or water for the user,
        using dirt from near water to pull the water out
    ]]
    water_bucket = "hades_core:dirt",
    empty_bucket = "hades_core:fertile_sand",
    dye_dark_grey = "dye:dark_grey",
    dye_black = "dye:black",
    dye_white = "dye:white",
    dye_green = "dye:green",
    dye_red = "dye:red",
    dye_yellow = "dye:yellow",
    dye_brown = "dye:brown",
    dye_blue = "dye:blue",
    dye_violet = "dye:violet",
    dye_grey = "dye:grey",
    dye_dark_green = "dye:dark_green",
    dye_orange = "dye:orange",
    dye_pink = "dye:pink",
    dye_cyan = "dye:cyan",
    dye_magenta = "dye:magenta",
    silicon = "hades_materials:silicon",
    string = "hades_farming:string",
    paper = "hades_core:paper",
    book = "hades_core:book",
    iron_lump = "hades_core:iron_lump",
    wool_grey = "wool:grey",
    wool_green = "wool:green",
    wool_dark_green = "wool:dark_green",
    wool_brown = "wool:brown",
    wool_black = "wool:black",
    wool_white = "wool:white",
    slab_stone = "stairs:slab_stone",
    slab_wood = "stairs:slab_wood",
    glass = "hades_core:glass",
    glass_block = "hades_core:glass",
    glass_bottle = "vessels:glass_bottle",
    obsidian_glass = "hades_core:obsidian_glass",
    coal_lump = "hades_core:coal_lump",
    stone = "hades_core:stone",
    desert_stone = "hades_core:stone_baked",
    desert_sand = "hades_core:volcanic_sand",
    chest = "hades_chests:chest";
    cobble = "hades_core:cobble",
    brick = "hades_core:brick",
    water_source = "hades_core:water_source",
    water_flowing = "hades_core:water_flowing",
    dirt = "hades_core:dirt",
    dirt_with_grass = "hades_core:dirt_with_grass",
    apple_leaves = "hades_trees:leaves",
    apple_log = "hades_trees:tree",
    apple_planks = "hades_trees:wood",
    birch_leaves = "hades_core:birch_leaves",
    birch_log = "hades_trees:birch_tree",
    birch_planks = "hades_trees:cream_wood",
    jungle_leaves = "hades_trees:jungle_leaves",
--hades has no bowl but you get plate on eat so makes most sense?
    bowl = "hades_food:plate",
    stick = "hades_core:stick",
}

if minetest.get_modpath("hades_bucket") then
    materials["water_bucket"] = "hades_bucket:bucket_water"
    materials["empty_bucket"] = "hades_bucket:bucket_empty"
end
if minetest.get_modpath("hades_extraores") then
    materials["silver_ingot"] = "hades_extraores:silver_ingot"
    materials["aluminum_ingot"] = "hades_extraores:aluminum_ingot"
end
if minetest.get_modpath("hades_default") then
    materials.desert_sand = "hades_default:desert_sand"
end
if minetest.get_modpath("hades_technic") then
    materials.lead_ingot = "hades_technic:lead_ingot"
    materials.carbon_steel_ingot = "hades_technic:carbon_steel_ingot"
    materials.stainless_steel_ingot = "hades_technic:stainless_steel_ingot"
end

return materials