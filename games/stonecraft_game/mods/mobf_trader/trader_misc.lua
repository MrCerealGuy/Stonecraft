--------------------------------------------
-- Trader for miscelaneus items
--------------------------------------------

-- the old mobf trader
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
    "Trader of miscelanous",
    "misc",
     {
	{ "default:mese 1", "default:dirt 99", "default:cobble 50"},
	{ "default:steel_ingot 1", "default:mese_crystal 5", "default:cobble 20"},
	{ "default:stone 5", "default:mese_crystal 1", "default:cobble 50"},
	{ "default:furnace 1", "default:mese_crystal 3", nil},
	{ "default:sword_steel 1", "default:mese_crystal 4", "default:stone 20"},
	{ "bucket:bucket_empty 1", "default:cobble 10", "default:stone 2"},
	{ "default:pick_mese 1", "default:mese_crystal 12", "default:stone 60"},
	{ "default:shovel_steel 1", "default:mese_crystal 2", "default:stone 10"},
	{ "default:axe_steel 1", "default:mese_crystal 2", "default:stone 22"},
	{ "default:torch 33", "default:mese_crystal 2", "default:stone 10"},
	{ "default:ladder 12", "default:mese_crystal 1", "default:stone 5"},
	{ "default:paper 12", "default:mese_crystal 2", "default:stone 10"},
	{ "default:chest 1", "default:mese_crystal 2", "default:stone 10"},
    },
    { "Ali"},
    ""
    );
		


mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
    "Trader",
    "default",
     {
	{ "default:mese 1", "default:iron_lump 30",},
	{ "doors:door_wood 1", "default:mese_crystal 1", "default:cobble 10"},
	{ "default:fence_wood 20", "default:mese_crystal 5", "default:cobble 25"},
	{ "animalmaterials:saddle 1", "default:mese 1", "default:cobble 50"},
	{ "default:sword_steel 1", "default:mese_crystal 4", "default:stone 20"},
	{ "default:iron_lump 1", "default:dirt 99", "default:cobble 50"},
	{ "default:pick_mese 1", "default:mese_crystal 12", "default:stone 60"},
	{ "default:shovel_steel 1", "default:mese_crystal 2", "default:stone 10"},
	{ "default:axe_steel 1", "default:mese_crystal 2", "default:stone 22"},
	{ "default:torch 33", "default:mese_crystal 2", "default:stone 10"},
	{ "default:ladder 12", "default:mese 1", "default:cobble 50"},
	{ "default:paper 12", "default:mese_crystal 2", "default:stone 10"},
	{ "default:chest_locked 1", "default:mese_crystal 5", "default:cobble 25"},
	{ "mob_archer:archer 1","default:mese_crystal 10",nil},
	{ "mob_guard:guard 1","default:mese_crystal 10",nil},
	{ "doors:door_steel 1","default:mese_crystal 3","default:cobble 20"},
    },
    { "Kurt"},
    ""
    );

