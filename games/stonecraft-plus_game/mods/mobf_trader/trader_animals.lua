-------------------------------------------------------------------
-- Traders for Mobf animals
-------------------------------------------------------------------
-- adds traders for cows, sheep, chicken and "exotic" animals (=everything else)

-- trader for cows and steers
if( minetest.get_modpath("animal_cow") ~= nil ) then
   mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
    "Trader of cows",
    "animal_cow",
    {
       {"animal_cow:cow 1",           "default:mese_crystal 39", "moreores:gold_ingot 19"},
       {"animal_cow:steer 1",         "default:mese_crystal 39", "moreores:gold_ingot 19"},
       {"animal_cow:baby_calf_f 1",   "default:mese_crystal 19", "moreores:gold_ingot 9"},
       {"animal_cow:baby_calf_m 1",   "default:mese_crystal 19", "moreores:gold_ingot 9"},

       {"animalmaterials:milk 1",     "default:apple 10",        "default:leaves 29"},
       {"animalmaterials:meat_beef 1","default:steel_ingot 1",    "default:leaves 29"},

       {"animalmaterials:lasso 5",    "default:steel_ingot 2",    "default:leaves 39"},
       {"animalmaterials:net 1",      "default:steel_ingot 2",    "default:leaves 39"}, -- to protect the animals
    },
    { "cow trader" },
    ""
    );
end


-- trader for sheep and lambs
if( minetest.get_modpath("animal_sheep") ~= nil ) then
   mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
    "Trader of sheep",
    "animal_sheep",
    {
       {"animal_sheep:sheep 1",       "default:mese_crystal 19", "moreores:gold_ingot 19"},
       {"animal_sheep:lamb 1",        "default:mese_crystal 9",  "moreores:gold_ingot 5"},

       {"wool:white 10",              "default:steel_ingot 1",    "default:leaves 29"},
       {"animalmaterials:meat_lamb 2","default:steel_ingot 1",    "default:leaves 29"},
       {"animalmaterials:scissors 1", "default:steel_ingot 8",    "default:mese_crystal 3"}, -- TODO: sell elsewhere as well?

       {"animalmaterials:lasso 5",    "default:steel_ingot 2",    "default:leaves 39"},
       {"animalmaterials:net 1",      "default:steel_ingot 2",    "default:leaves 39"}, -- to protect the animals
    },
    { "sheep trader" },
    ""
    );
end


-- trader for chicken
if( minetest.get_modpath("animal_chicken") ~= nil ) then
   mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
    "Trader of chicken",
    "animal_chicken",
    {
       {"animal_chicken:chicken 1",   "default:apple 10",      "default:coal_lump 20"},
       {"animal_chicken:rooster 1",   "default:apple 5",       "default:coal_lump 10"},
       {"animal_chicken:chick_f 1",   "default:apple 4",       "default:coal_lump 8"},
       {"animal_chicken:chick_m 1",   "default:apple 2",       "default:coal_lump 4"},

       {"animalmaterials:feather 1",  "default:leaves 1",      "default:leaves 1"},
       {"animalmaterials:egg 2",      "default:leaves 4",      "default:leaves 4"},
       {"animalmaterials:meat_chicken 1","default:apple 6",    "default:coal_lump 11"},

       {"animalmaterials:lasso 5",    "default:steel_ingot 2",  "default:leaves 39"},
       {"animalmaterials:net 1",      "default:steel_ingot 2",  "default:leaves 39"}, -- to protect the animals
    },
    { "chicken trader" },
    ""
    );
end


-- trader for exotic animals
exotic_animals = {};
-- deers are expensive
if( minetest.get_modpath("animal_deer") ~= nil ) then
   table.insert( exotic_animals,  { "animal_deer:deer_m 1",           "default:mese_crystal 49", "moreores:gold_ingot 39"});
   table.insert( exotic_animals,  { "animalmaterials:meat_venison 1", "default:steel_ingot 5",    "default:mese_crystal 1"});
end
-- rats are...not expensive
if( minetest.get_modpath("animal_rat") ~= nil ) then
   table.insert( exotic_animals,  { "animal_rat:rat 1",               "default:coal_lump 1",     "default:leaves 9"});
end
-- wolfs are sold only in the tamed version (the rest end up as fur)
if( minetest.get_modpath("animal_wolf") ~= nil ) then
   table.insert( exotic_animals,  { "animal_wolf:tamed_wolf 1",       "default:mese_crystal 89", "moreores:gold_ingot 59"});
   table.insert( exotic_animals,  { "animalmaterials:fur 1",          "default:steel_ingot 5",    "default:mese_crystal 3"});
end
-- ostrichs - great to ride on :-)
if( minetest.get_modpath("mob_ostrich") ~= nil ) then
   table.insert( exotic_animals,  { "mob_ostrich:ostrich_f 1",        "default:mese_crystal 39", "moreores:gold_ingot 24"});
   table.insert( exotic_animals,  { "mob_ostrich:ostrich_m 1",        "default:mese_crystal 29", "moreores:gold_ingot 14"});
   table.insert( exotic_animals,  { "animalmaterials:meat_ostrich 1", "default:steel_ingot 6",    "default:mese_crystal 2"});
   table.insert( exotic_animals,  { "animalmaterials:egg_big 1",      "default:steel_ingot 1",    "default:leaves 29"});
end
-- general tools for usage with animals
if( minetest.get_modpath("animalmaterials") ~= nil ) then
   table.insert( exotic_animals,  { "animalmaterials:scissors 1",     "default:steel_ingot 8",    "default:mese_crystal 3"});
   table.insert( exotic_animals,  { "animalmaterials:lasso 5",        "default:steel_ingot 2",    "default:leaves 39"});
   table.insert( exotic_animals,  { "animalmaterials:net 1",          "default:steel_ingot 2",    "default:leaves 39"});
   table.insert( exotic_animals,  { "animalmaterials:saddle 1",       "default:steel_ingot 19",   "default:leaves 99"});
end
-- barns to breed animals
if( minetest.get_modpath("barn") ~= nil ) then
   table.insert( exotic_animals,  { "barn:barn_empty 1",              "default:steel_ingot 1",    "default:leaves 29"});
   table.insert( exotic_animals,  { "barn:barn_small_empty 2",        "default:steel_ingot 1",    "default:leaves 29"});
   table.insert( exotic_animals,  { "default:leaves 9",               "default:steel_ingot 1",    "default:coal_lump 5"});
end

-- IMPORTANT: this trader has no more spaces left for further goods!
-- add the trader
if( #exotic_animals > 0 ) then
   mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
    "Trader of exotic animals",
    "animal_exotic",
    exotic_animals,
    { "trader of exotic animals" },
    ""
    );
end

