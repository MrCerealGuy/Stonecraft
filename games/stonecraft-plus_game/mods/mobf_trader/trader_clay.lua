--------------------------------------------
-- Trader for clay, sand, desert_sand, glass, some glass items etc.
--------------------------------------------

-- everyone has clay and sand; no mod dependencies for this trader!
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
    "Trader of clay",
    "clay",
    {
       {"default:clay 1",        "default:dirt 10", "default:cobble 20"},
       {"default:brick 1",       "default:dirt 49", "default:cobble 99"},
       {"default:sand 1",        "default:dirt 2",  "default:cobble 10"},
       {"default:sandstone 1",   "default:dirt 10", "default:cobble 48"},
       {"default:sandstonebrick 1", "default:dirt 20", "default:cobble 99"},
       {"default:desert_sand 1", "default:dirt 2",  "default:cobble 10"},
       {"default:glass 1",       "default:dirt 10", "default:cobble 48"},

       {"vessels:glass_bottle 2",  "default:steel_ingot 1", "default:coal_lump 10"},

       {"default:clay 10",       "default:steel_ingot 2", "default:coal_lump 20"},
       {"default:brick 10",      "default:steel_ingot 9", "default:mese_crystal 1"},
       {"default:sand 10",       "default:steel_ingot 1", "default:coal_lump 20"},
       {"default:sandstone 10",  "default:steel_ingot 2", "default:coal_lump 38"},
       {"default:sandstonebrick 10", "default:steel_ingot 4", "default:coal_lump 99"},
       {"default:desert_sand 10","default:steel_ingot 1", "default:coal_lump 20"},
       {"default:glass 10",      "default:steel_ingot 2", "default:coal_lump 38"},

       {"vessels:drinking_glass 2","default:steel_ingot 1", "default:coal_lump 10"},
    },
    { "Toni" },
    ""
    );

