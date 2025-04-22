local materials = {
    sand = "default:sand",
    sandstone = "default:sandstone",
    gravel = "default:gravel",
    flint = "default:flint",
    copper_ingot = "default:copper_ingot",
    steel_ingot = "default:steel_ingot",
    gold_ingot = "default:gold_ingot",
    tin_ingot = "default:tin_ingot",
    copper_block = "default:copperblock",
    steel_block = "default:steelblock",
    gold_block = "default:goldblock",
    tin_block = "default:tinblock",
    axe_steel = "default:axe_steel",
    axe_diamond = "default:axe_diamond",
    axe_bronze = "default:axe_bronze",
    axe_stone = "default:axe_stone",
    axe_wood = "default:axe_wood",
    pick_steel = "default:pick_steel",
    mese = "default:mese",
    mese_crystal = "default:mese_crystal",
    mese_crystal_fragment = "default:mese_crystal_fragment",
    torch = "default:torch",
    diamond = "default:diamond",
    clay_lump = "default:clay_lump",
    water_bucket = "bucket:bucket_water",
    empty_bucket = "bucket:bucket_empty",
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
    silicon = "mesecons_materials:silicon",
    string = "farming:string",
    paper = "default:paper",
    book = "default:book",
    iron_lump = "default:iron_lump",
    wool_grey = "wool:grey",
    wool_green = "wool:green",
    wool_dark_green = "wool:dark_green",
    wool_brown = "wool:brown",
    wool_black = "wool:black",
    wool_white = "wool:white",
    slab_stone = "stairs:slab_stone",
    slab_wood = "stairs:slab_wood",
    glass = "default:glass",
    glass_block = "default:glass",
    glass_bottle = "vessels:glass_bottle",
    coal_lump = "default:coal_lump",
    stone = "default:stone",
    desert_stone = "default:desert_stone",
    desert_sand = "default:desert_sand",
    chest = "default:chest",
    cobble = "default:cobble",
    brick = "default:brick",
    obsidian_glass = "default:obsidian_glass",
    water_source = "default:water_source",
    water_flowing = "default:water_flowing",
    dirt = "default:dirt",
    dirt_with_grass = "default:dirt_with_grass",
    apple_leaves = "default:leaves",
    apple_log = "default:tree",
    apple_planks = "default:wood",
    birch_leaves = "default:aspen_leaves",
    birch_log = "default:aspen_tree",
    birch_planks = "default:aspen_wood",
    jungle_leaves = "default:jungleleaves",
    bowl = "",
    stick = "default:stick",
}

if minetest.registered_items["farming:bowl"] then
    materials.bowl = "farming:bowl"
elseif minetest.get_modpath("x_farming") then
    materials.bowl = "x_farming:bowl"
end

if minetest.get_modpath("moreores") then
    materials.silver_ingot = "moreores:silver_ingot"
end

if minetest.get_modpath("technic") then
	materials.lead_ingot = "technic:lead_ingot"
	materials.carbon_steel_ingot = "technic:carbon_steel_ingot"
	materials.stainless_steel_ingot = "technic:stainless_steel_ingot"
end

if minetest.get_modpath("aloz") then
	materials.aluminum_ingot = "aloz:aluminum_ingot"
end

if minetest.get_modpath("techage") then
	materials.aluminum_ingot = "techage:aluminum"
end

return materials