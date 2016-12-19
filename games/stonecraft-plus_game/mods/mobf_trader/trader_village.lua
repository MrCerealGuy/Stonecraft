--------------------------------------------
-- Trader for villages
--------------------------------------------

-- general textures shared by the traders in the villages
mobf_trader.VILLAGE_TRADER_TEXTURES = {'kuhhaendler.png', 'bauer_in_sonntagskleidung.png', 'character.png'};

-- the smith takes twice as much as he'll really need
mobf_trader.price_smith = function( anz_iron, anz_copper, anz_stick )
	local price = {};
	if( anz_iron > 0 ) then
		table.insert( price, 'default:iron_lump '..tostring(   anz_iron * 2 ) );	
	end
	if( anz_copper > 0 ) then
		table.insert( price, 'default:copper_lump '..tostring( anz_copper * 2 ) );	
	end
	if( anz_iron > 0 or anz_copper > 0 ) then
		table.insert( price, 'default:coal_lump '..tostring(  (anz_iron + anz_copper) * 2 ));	
	end
	if( anz_stick > 0 ) then
		table.insert( price, 'default:stick '..tostring(       anz_stick * 2 ));
	end
	return price;
end

-- a smith; does steel and bronze
-- sells pick, axe, shovel, hoe and sword out of steel
-- also sells blocks and ingots out of those materials
-- also sells locked chests, buckets, steel doors, hatch, stovepipe, rails, steel bottle and scredriver 
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'Blacksmith',
	'blacksmith',
	{

		{ 'default:pick_steel',     mobf_trader.price_smith( 3, 0, 2 ) },
		{ 'default:axe_steel',      mobf_trader.price_smith( 3, 0, 2 ) },
		{ 'default:shovel_steel',   mobf_trader.price_smith( 1, 0, 2 ) },
		{ 'farming:hoe_steel',      mobf_trader.price_smith( 2, 0, 2 ) },
		{ 'default:sword_steel',    mobf_trader.price_smith( 2, 0, 1 ) },
		{ 'screwdriver:screwdriver',mobf_trader.price_smith( 1, 0, 1 ) },
		{ 'cottages:hammer',        mobf_trader.price_smith( 6, 0, 1 ) },

		{ 'cottages:anvil',         mobf_trader.price_smith( 7, 0, 1 ) },

		{ 'default:steelblock',     mobf_trader.price_smith( 9, 0, 0 ) },

		{ 'default:steel_ingot',    mobf_trader.price_smith( 1, 0, 0 ) },

		{ 'default:chest_locked',   {'default:tree 4', 'default:iron_lump 2', 'default:coal_lump 2'}},
		{ 'bucket:bucket_empty',    mobf_trader.price_smith( 3, 0, 0 ) },
		{ 'doors:door_steel',       mobf_trader.price_smith( 6, 0, 0 ) },
		{ 'cottages:hatch_steel',   mobf_trader.price_smith( 2, 0, 0 ) },
-- the stovepipe is too seldom needed, and there was one item too many offered
--		{ 'cottages:stovepipe',     mobf_trader.price_smith( 1, 0, 0 ) },
		{ 'default:rail 15',        mobf_trader.price_smith( 6, 0, 2 ) },
		{ 'vessels:steel_bottle',   mobf_trader.price_smith( 1, 0, 0 ) },

		{ 'animalmaterials:scissors',mobf_trader.price_smith(2, 0, 2 ) },

	},
	{ 'Blacky','Simon'},
	{'blacksmith.png'}
	);


-- copper/bronze is done by another guy (too much for one smith)
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'Bronze smith',
	'bronzesmith',
	{

		{ 'default:pick_bronze',    mobf_trader.price_smith( 3, 3, 2 ) },
		{ 'default:axe_bronze',     mobf_trader.price_smith( 3, 3, 2 ) },
		{ 'default:shovel_bronze',  mobf_trader.price_smith( 1, 1, 2 ) },
		{ 'farming:hoe_bronze',     mobf_trader.price_smith( 2, 2, 2 ) },
		{ 'default:sword_bronze',   mobf_trader.price_smith( 2, 2, 1 ) },

		{ 'default:copperblock',    mobf_trader.price_smith( 0, 9, 0 ) },
		{ 'default:bronzeblock',    mobf_trader.price_smith( 9, 9, 0 ) },

		{ 'default:copper_ingot',   mobf_trader.price_smith( 0, 1, 0 ) },
		{ 'default:bronze_ingot',   mobf_trader.price_smith( 1, 1, 0 ) },

	},
	{ 'Charly','Bert'},
	{'blacksmith.png'}
	);


-- the stonemason calculates his prices based on cobble, stone and sticks used;
-- he takes wood instead of cobble because he's got a lot of cobble already and
--    intends to either use the wood or trade it for other items
-- (obtaining wood is roughly comparable to obtaining cobble; at least for players)
mobf_trader.price_stonemason = function( anz_cobble, anz_stone, anz_stick )
	local price = {};
	if( anz_cobble > 0 ) then
		table.insert( price, 'default:wood '..tostring(    anz_cobble * 2 ) );	
	end
	if( anz_stone > 0 ) then
		table.insert( price, 'default:wood '..tostring(    anz_stone  * 2 ));	
		-- cobble needs to be smelted in order to get stone
		table.insert( price, 'default:coal_lump '..tostring( anz_stone  * 2 ));	
	end
	if( anz_stick > 0 ) then
		table.insert( price, 'default:stick '..tostring(     anz_stick * 2 ));
	end
	return price;
end


-- a stonemason (=Steinmetz)
-- this one does NOT provide sandstone and such - that's the domain of the clay trader
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'Stonemason',
	'stonemason',
	{
		{ 'default:pick_stone',        mobf_trader.price_stonemason( 3, 0, 2 ) },
		{ 'default:axe_stone',         mobf_trader.price_stonemason( 3, 0, 2 ) },
		{ 'default:shovel_stone',      mobf_trader.price_stonemason( 1, 0, 2 ) },
		{ 'farming:hoe_stone',         mobf_trader.price_stonemason( 2, 0, 2 ) },
		{ 'default:sword_stone',       mobf_trader.price_stonemason( 2, 0, 1 ) },
 
		-- even a furnace is a bit of work
		{ 'default:furnace',           {'default:tree 2', 'default:pick_steel' }},
		-- this is a useful and rather expensive item; it seperates harvested wheat into straw and seeds
		{ 'cottages:threshing_floor',  {'default:tree 4', 'default:chest', 'default:chest_locked 2', 'default:pick_bronze' }},
		-- the mill allows to craft wheat seeds into flour
		{ 'cottages:handmill',         {'default:tree 12', 'default:coal_lump 24', 'default:steel_ingot', 'default:pick_bronze' }},

		-- stairs and slabs are sold in larger quantities
		{ 'stairs:stair_cobble 12',    mobf_trader.price_stonemason(12, 0, 0 ) }, 
		{ 'stairs:stair_stone 12',     mobf_trader.price_stonemason( 0,12, 0 ) }, 
		{ 'stairs:stair_sandstone 12', mobf_trader.price_stonemason( 0,48, 0 ) }, 
		{ 'stairs:stair_stonebrick 12',mobf_trader.price_stonemason( 0,48, 0 ) }, 

		{ 'stairs:slab_cobble 24',     mobf_trader.price_stonemason(12, 0, 0 ) }, 
		{ 'stairs:slab_stone 24',      mobf_trader.price_stonemason( 0,12, 0 ) }, 
		{ 'stairs:slab_sandstone  24', mobf_trader.price_stonemason( 0,48, 0 ) }, 
		{ 'stairs:slab_stonebrick 24', mobf_trader.price_stonemason( 0,48, 0 ) }, 

	},
	{ 'Metz'},
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);


-- TODO: a better name for this guy would be helpful
-- all these items where too many for the stonemason; plus the stones themshelves are better sold by a miner
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'stoneminer',
	'stoneminer',
	{
		-- those items are needed in larger quantities
		{ 'default:stone 24',          mobf_trader.price_stonemason( 0,24, 1 ) }, 
		{ 'default:mossycobble 12',    mobf_trader.price_stonemason( 3,24, 0 ) }, 
		{ 'default:stonebrick 12',     mobf_trader.price_stonemason( 0,24, 0 ) },
		{ 'default:desert_stone 12',   mobf_trader.price_stonemason(12, 0, 1 ) }, 
		{ 'default:desert_stonebrick 12',mobf_trader.price_stonemason(24,0, 1 ) }, 
		{ 'default:gravel 12',         mobf_trader.price_stonemason( 0, 2, 0 ) }, -- he probably has a grinder from technic at home :-)
	},
	{'Stoni'},
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);


-- woodworkers use wood and turn it into other useful stuff
mobf_trader.price_woodworker = function( anz_wood, anz_tree, anz_stick )
	local price = {};
	if( anz_wood   > 0 ) then
		table.insert( price, 'default:wood '..tostring(    anz_wood   * 2 ) );	
	end
	if( anz_tree  > 0 ) then
		table.insert( price, 'default:tree '..tostring(    anz_tree   * 2 ));	
	end
	if( anz_stick > 0 ) then
		table.insert( price, 'default:stick '..tostring(   anz_stick * 2 ));
	end
	return price;
end


-- carpenter (=Zimmerer)
-- It is very unlikely that players want individual fences; thus, packages are sold
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'Carpenter, specialized in fences',
	'carpenter',
	{
		{ 'default:fence_wood 16',     mobf_trader.price_woodworker( 0, 3, 0 ) },
		{ 'cottages:fence_small 24',   mobf_trader.price_woodworker( 0, 3, 0 ) },
		{ 'cottages:fence_corner 4',   mobf_trader.price_woodworker( 0, 1, 0 ) },
		{ 'cottages:fence_end 2',      mobf_trader.price_woodworker( 0, 1, 0 ) },
		{ 'cottages:gate_closed',      mobf_trader.price_woodworker( 0, 1, 0 ) },
	},
	{ 'Friedrich', 'Friedhelm' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);

-- this one does wooden tools
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'Joiner, specialized in tools',
	'toolmaker',
	{
		{ 'default:pick_wood',         mobf_trader.price_woodworker( 3, 0, 2 ) },
		{ 'default:axe_wood',          mobf_trader.price_woodworker( 3, 0, 2 ) },
		{ 'default:shovel_wood',       mobf_trader.price_woodworker( 1, 0, 2 ) },
		{ 'farming:hoe_wood',          mobf_trader.price_woodworker( 2, 0, 2 ) },
		{ 'default:sword_wood',        mobf_trader.price_woodworker( 2, 0, 1 ) },
	},
	{ 'Ted' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);

-- joiner (=Schreiner, Tischler)
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'Joiner, specialized in doors',
	'doormaker',
	{
		{ 'doors:door_wood',                mobf_trader.price_woodworker( 6, 0, 0 ) },
		{ 'cottages:hatch_wood',            mobf_trader.price_woodworker( 2, 0, 0 ) },
		{ 'cottages:window_shutter_open',   mobf_trader.price_woodworker( 2, 0, 0 ) },
		{ 'cottages:half_door 2',           mobf_trader.price_woodworker( 7, 0, 0 ) },
		{ 'cottages:gate_closed',           mobf_trader.price_woodworker( 2, 0, 0 ) },
	},
	{ 'Donald' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);

-- this is done by a joiner as well..
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'Joiner, specialized in furniture',
	'furnituremaker',
	{
		{ 'cottages:bench',                 mobf_trader.price_woodworker( 0, 0, 4 ) },
		{ 'cottages:table',                 mobf_trader.price_woodworker( 1, 0, 1 ) },
		{ 'cottages:shelf',                 mobf_trader.price_woodworker( 2, 0, 6 ) },
		{ 'default:chest',                  mobf_trader.price_woodworker( 8, 0, 0 ) },
		{ 'default:bookshelf',              {'default:book 3', 'default:wood 12'}},
		{ {'cottages:bed_head', 'cottages:bed_foot'}, {'wool:white 2', 'default:wood 4', 'default:stick 6'}},
		{ 'default:ladder 3',               mobf_trader.price_woodworker( 0, 0, 7 ) },
		{ 'default:sign_wall 4',            mobf_trader.price_woodworker( 6, 0, 1 ) },
	},
	{ 'Donald' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);

-- a joiner who does ladders and staircases
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'Joiner, specialized in stairs',
	'stairmaker',
	{
		{ 'stairs:stair_wood 12',           mobf_trader.price_woodworker(12, 0, 0 ) }, 
		{ 'stairs:stair_junglewood 12',     mobf_trader.price_woodworker(12, 0, 0 ) }, 

		{ 'stairs:slab_wood 24',            mobf_trader.price_woodworker(12, 0, 0 ) }, 
		{ 'stairs:slab_junglewood 24',      mobf_trader.price_woodworker(12, 0, 0 ) }, 

		{ 'default:ladder 3',               mobf_trader.price_woodworker( 0, 0, 7 ) },
	},
	{ 'Siegfried' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);


-- cooper (=Boettcher)
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'cooper',
	'cooper',
	{
		{ 'cottages:barrel',                {'default:wood 10', 'default:steel_ingot 4'}},
		{ 'cottages:tub',                   {'default:wood 5',  'default:steel_ingot 2'}},
	},
	{ 'Balduin' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);


-- weelwright (=Wagner)
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'wheelwright',
	'wheelwright',
	{
		{ 'cottages:wagon_wheel',           {'default:wood 4', 'default:stick 20', 'default:steel_ingot 2'}},
	},
	{ 'Werner' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);


-- saddler (=Sattler)
-- most of these products are from animalmaterials
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'Saddler',
	'saddler',
	{
		{ 'cottages:sleeping_mat',          {'wool:white', 'cottages:straw_mat 4'}},
		{ 'unified_inventory:bag_small 2',  {'default:wood 8', 'default:stick 2'}},
		{ 'unified_inventory:bag_medium',   {'wool:white 2', 'default:stick 2'}},
		{ 'unified_inventory:bag_large',    {'wool:white 4', 'default:stick 3'}},
		{ 'animalmaterials:lasso',          'wool:white 8'},
		{ 'animalmaterials:net',            'wool:white 10'},
		{ 'animalmaterials:saddle',         {'wool:white 5', 'default:sword_steel'}},
	},
	{ 'Sammy' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);



-- roofer (=Dachdecker); although they tend to place that stuff on the roof and not create it...
-- the actual receipes require diffrent dye-replacements (i.e. coal, dirt, clay lump), but that
--    would be impractical here
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'Roofer',
	'roofer',
	{
		{ 'cottages:roof_straw 24',         'cottages:straw_mat 12'},
		{ 'cottages:roof_reet 24',          'default:papyrus 12'},
		{ 'cottages:roof_wood 24',          mobf_trader.price_woodworker( 8, 0, 0 ) },
		{ 'cottages:roof_red 24',           mobf_trader.price_woodworker( 8, 0, 0 ) },
		{ 'cottages:roof_black 24',         mobf_trader.price_woodworker( 8, 0, 0 ) },
		{ 'cottages:roof_brown 24',         mobf_trader.price_woodworker( 8, 0, 0 ) },
		{ 'cottages:roof_slate 24',         mobf_trader.price_woodworker( 8, 0, 0 ) },

-- removed the roof connectors as those would be too many; left one so that all the items are aligned well
		{ 'cottages:roof_connector_straw 6',{'cottages:straw_mat 3', 'default:wood 1'} },
--		{ 'cottages:roof_connector_reet 6', {'default:papyrus 3', 'default:wood 1'} },
--		{ 'cottages:roof_connector_wood 6', mobf_trader.price_woodworker( 3, 0, 0 ) },
--		{ 'cottages:roof_connector_red  6', mobf_trader.price_woodworker( 3, 0, 0 ) },
--		{ 'cottages:roof_connector_black 6',mobf_trader.price_woodworker( 3, 0, 0 ) },
--		{ 'cottages:roof_connector_brown 6',mobf_trader.price_woodworker( 3, 0, 0 ) },
--		{ 'cottages:roof_connector_slate 6',mobf_trader.price_woodworker( 3, 0, 0 ) },

		{ 'cottages:roof_flat_straw 6',     'cottages:straw_mat 6'},
		{ 'cottages:roof_flat_reet 6',      'default:papyrus 6'},
		{ 'cottages:roof_flat_wood 6',      mobf_trader.price_woodworker( 2, 0, 0 ) },
		{ 'cottages:roof_flat_red  6',      mobf_trader.price_woodworker( 2, 0, 0 ) },
		{ 'cottages:roof_flat_black 6',     mobf_trader.price_woodworker( 2, 0, 0 ) },
		{ 'cottages:roof_flat_brown 6',     mobf_trader.price_woodworker( 2, 0, 0 ) },
		{ 'cottages:roof_flat_slate 6',     mobf_trader.price_woodworker( 2, 0, 0 ) },
	},
	{ 'Ronald', 'Robert' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);



-- bread production:
-- (anyone) digging wheat      -> farming:wheat
-- (anyone) farming:wheat      -> farming:seed_wheat + cottages:straw_mat

-- miller:  farming:seed_wheat -> farming:flour  (same as the handmill)
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'miller', 
	'miller', 
	{
		{ 'farming:flour 10',               'farming:seed_wheat 15'},
		{ 'farming:flour 40',               'farming:seed_wheat 49'},
		{ 'farming:flour 90',               'farming:seed_wheat 99'},
	},
	{ 'Martin' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);


-- baker:   farming:flour      -> farming:bread  (can be done in a furnace as well); also sells pies
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'baker', 
	'baker', 
	{
		{ 'farming:bread 6',                {'farming:flour 10', 'default:coal_lump 3'}},
		{ 'bushes:blueberry_pie_slice',     {'default:papyrus 2'}},

		{ 'bushes:blackberry_pie_cooked',   {'bushes:blackberry 9', 'default:coal_lump 2'}}, 
		{ 'bushes:blueberry_pie_cooked',    {'bushes:blueberry 9', 'default:coal_lump 2'}}, 
		{ 'bushes:gooseberry_pie_cooked',   {'bushes:gooseberry 9', 'default:coal_lump 2'}}, 
		{ 'bushes:mixed_berry_pie_cooked',  {'bushes:blackberry 18', 'default:coal_lump 2'}}, 
		{ 'bushes:raspberry_pie_cooked',    {'bushes:raspberry 9', 'default:coal_lump 2'}}, 
		{ 'bushes:strawberry_pie_cooked',   {'bushes:strawberry 9', 'default:coal_lump 2'}}, 

		{ 'farming:bread 34',               {'farming:flour 49', 'default:coal_lump 12'}},
		{ 'farming:bread 80',               {'farming:flour 90', 'default:coal_lump 20'}},

		{ 'bushes:basket_blackberry',       {'bushes:blackberry 24', 'default:coal_lump 2'}}, 
		{ 'bushes:basket_blueberry',        {'bushes:blueberry 24', 'default:coal_lump 2'}}, 
		{ 'bushes:basket_gooseberry',       {'bushes:gooseberry 24', 'default:coal_lump 2'}}, 
		{ 'bushes:basket_mixed_berry',      {'bushes:blackberry 36', 'default:coal_lump 2'}}, 
		{ 'bushes:basket_raspberry',        {'bushes:raspberry 24', 'default:coal_lump 2'}}, 
		{ 'bushes:basket_strawberry',       {'bushes:strawberry 24', 'default:coal_lump 2'}}, 

	},
	{ 'Ben', 'Berthold' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);


-- a teacher - sells paper and books (librarians are less likely to be found in villages)
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'teacher',
	'teacher',
	{
		{'default:paper 2',                 {'default:papyrus 6', 'default:coal_lump 1'}},
		{'default:book',                    {'default:papyrus 9', 'default:tree 4'}}, -- for heating the school
	},
	{ 'Lars', 'Leon' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);
	
-- ice trader
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'iceman',
	'iceman',
	{
		{'default:ice',                     'default:pick_steel'},
	},
	{ 'Ian', 'Jan' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);
	

-- potterer (Toepfer)
-- TODO: the potterer could have more work to do...
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'potterer',
	'potterer',
	{
		{'default:clay_lump 2',             'default:coal_lump'},
		{'default:clay 6',                  'default:shovel_stone'},
		{'cottages:washing',                'default:shovel_steel'}, -- 1 clay
	},
	{ 'Peter', 'Paul' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);
	
-- a bricklayer
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'bricklayer',
	'bricklayer',
	{
		{'default:clay_brick 8',            {'default:shovel_stone', 'default:coal_lump 2'}},
		{'default:brick 12',                {'default:shovel_steel', 'default:coal_lump 12'}},
		{'stairs:stair_brick 8',            {'default:shovel_stone', 'default:coal_lump 12'}},
		{'stairs:slab_brick 6',             {'default:shovel_stone', 'default:coal_lump 3'}},
	},
	{ 'Billy' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);

-- someone has to color the wool
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'dyemaker',
	'dyemaker',
	{
		{'wool:red 4',                     {'wool:white 4', 'flowers:rose'}},
		{'wool:yellow 4',                  {'wool:white 4', 'flowers:dandelion_yellow'}},
		{'wool:green 4',                   {'wool:white 4', 'default:cactus'}},
		{'wool:dark_green 4',              {'wool:white 4', 'default:cactus', 'default:coal_lump'}},
		{'wool:cyan 4',                    {'wool:white 4', 'flowers:geranium'}},
		{'wool:blue 4',                    {'wool:white 4', 'flowers:geranium'}},
		{'wool:magenta 4',                 {'wool:white 4', 'flowers:tulip'}},
		{'wool:orange 4',                  {'wool:white 4', 'flowers:tulip'}},
		{'wool:violet 4',                  {'wool:white 4', 'flowers:viola'}},
		{'wool:brown 4',                   {'wool:white 4', 'default:junglewood 4'}},
		{'wool:pink 4',                    {'wool:white 4', 'flowers:rose'}},
		{'wool:grey 4',                    {'wool:white 4', 'default:coal_lump'}},
		{'wool:dark_grey 4',               {'wool:white 4', 'default:coal_lump 2'}},
		{'wool:black 4',                   {'wool:white 4', 'default:coal_lump 3'}},
	},
	{ 'Fabian' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);


mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'dyemaker, specialized in large quantities',
	'dyemakerl',
	{
		{'wool:red 24',                    {'wool:white 24', 'flowers:rose 2', 'cottages:tub'}},
		{'wool:yellow 24',                 {'wool:white 24', 'flowers:dandelion_yellow 2', 'cottages:tub'}},
		{'wool:green 24',                  {'wool:white 24', 'default:cactus 2', 'cottages:tub'}},
		{'wool:dark_green 24',             {'wool:white 24', 'default:cactus', 'default:coal_lump 2', 'cottages:tub'}},
		{'wool:cyan 24',                   {'wool:white 24', 'flowers:geranium 2', 'cottages:tub'}},
		{'wool:blue 24',                   {'wool:white 24', 'flowers:geranium 2', 'cottages:tub'}},
		{'wool:magenta 24',                {'wool:white 24', 'flowers:tulip 2', 'cottages:tub'}},
		{'wool:orange 24',                 {'wool:white 24', 'flowers:tulip 2', 'cottages:tub'}},
		{'wool:violet 24',                 {'wool:white 24', 'flowers:viola 2', 'cottages:tub'}},
		{'wool:brown 24',                  {'wool:white 24', 'default:junglewood 8', 'cottages:tub'}},
		{'wool:pink 24',                   {'wool:white 24', 'flowers:rose 2', 'cottages:tub'}},
		{'wool:grey 24',                   {'wool:white 24', 'default:coal_lump 2', 'cottages:tub'}},
		{'wool:dark_grey 24',              {'wool:white 24', 'default:coal_lump 4', 'cottages:tub'}},
		{'wool:black 24',                  {'wool:white 24', 'default:coal_lump 6', 'cottages:tub'}},
	},
	{ 'Friedrich' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);

	
-- there is the clay trader who also sells glass; however, for the medieval villages, an extra trader is more practical
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'glassmaker',
	'glassmaker',
	{
		{'default:glass 2',                 {'default:sand 1',  'default:coal_lump 3'}},
		{'default:glass 12',                {'default:sand 5',  'default:coal_lump 9',  'default:shovel_stone'}},
		{'default:glass 48',                {'default:sand 19', 'default:coal_lump 30', 'default:shovel_steel'}},
		{'default:obsidian_glass 2',        {'default:obsidian_shard 2', 'default:wood 2'}},
		{'default:obsidian_glass 12',       {'default:obsidian',         'default:coal_lump 6', 'default:shovel_stone'}},
		{'default:obsidian_glass 48',       {'default:obsidian 4',       'default:coal_lump 30','default:shovel_steel', 'default:pick_steel'}},
		{'cottages:glass_pane 12',          {'default:sand 2',  'default:coal_lump 1'}},
		{'vessels:glass_bottle',            {'default:sand',    'default:wood 1'}},
		{'vessels:drinking_glass 2',        {'default:sand',    'default:wood 1'}},

	},
	{ 'Peter', 'Paul' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);
	

-- charachoal burners (=Koehler) used to be located outside villages
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
	'characoal burner',
	'charachoal',
	{
		{'default:coal_lump',		'default:tree 2', 'default:apple'},
		{'default:coal_lump 12',	'default:tree 16', 'default:apple 12'},
		{'default:coal_lump 19',	'default:tree 25', 'farming:bread 2', 'default:apple 19', 'bucket:bucket_empty'},
		{'default:coalblock',		'default:tree 12', 'farming:bread 1', 'default:apple 9'},
		{'default:coalblock 9',	        'default:tree 99', 'farming:bread 8'},
	},
	{ 'Christian', 'Rauchi' },
	mobf_trader.VILLAGE_TRADER_TEXTURES
	);
	

-- someone has to color the wool
mobf_trader.village_jobs = {
	forge     = {'blacksmith', 'bronzesmith'},
	farm_tiny = { 'stonemason', 'stoneminer', 'carpenter', 'toolmaker', 'doormaker', 'furnituremaker', 'stairmaker', 'cooper', 'wheelwright', 'saddler', 'roofer',
			'iceman', 'potterer', 'dyemaker', 'dyemakerl', 'glassmaker'},
--			-- candidates for independent buildings
--			'stonemason', 'iceman', 'potterer', 'dyemaker', 'glassmaker'
	mill      = {'miller'},
	bakery    = {'baker'},
	school    = {'teacher'},
	outside   = {'charachoal'}, -- plus lumberjacks and miners
	};

-- TODO: innkeeper - sell drinks, food and beds for restoring health?
-- TODO: fisher

-- animalmaterials: feather, milk, eggs -> something for the females

-- loam, reet - can be produced by all villagers

-- TODO: apple
-- TODO: gold stuff; mese, diamond


-- TODO nicht sinnvoll: schuster, tuchmacher (evtl. wollhaendler?), weber (auch wolle?), schneider (auch wolle?), maler, barbiere, 
-- TODO sinnvoll: fischer, schlachter, gerber, schaefer, tuermer (eher in stadt/burg), bader?, spielleute

-- TODO: jaeger, waechter
-- TODO: fahrender haendler

-- TODO: bei den villages auch ab und an nur mal einen wagen hinstellen
-- TODO: neben wagen auch backhaus, wachturm, fischerhuette/loeschteich, kohlenmeiler
