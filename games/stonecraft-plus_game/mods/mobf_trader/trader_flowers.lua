
if( minetest.get_modpath("flowers") ~= nil ) then

	local flowers = { 
		"flowers:rose",
		"flowers:tulip",
		"flowers:dandelion_yellow", 
		"flowers:dandelion_white", 
		"flowers:geranium", 
		"flowers:viola",
		"default:junglegrass",
		"default:grass_1",
		"default:sapling",
		"default:junglesapling",
		"default:dry_shrub",
		}
	local goods = {};
	for i,v in ipairs( flowers ) do
		table.insert( goods, { v.." 3", "default:steel_ingot", "default:copper_ingot"});
	end

	table.insert( goods, { "default:cactus 16",     "default:steel_ingot", "default:copper_ingot"});
	table.insert( goods, { "default:papyrus 16",    "default:steel_ingot", "default:copper_ingot"});
	table.insert( goods, { "default:seed_wheat 1",  "default:steel_ingot", "default:copper_ingot"});
	table.insert( goods, { "default:seed_cotton 1", "default:steel_ingot", "default:copper_ingot"});

	mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
		"flower trader selling plants",
		"flowers",
		goods,
		{ "Gert" },
		""
      );
end

