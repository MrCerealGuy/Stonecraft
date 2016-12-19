------------------------------------------
-- farming and farming_plus
------------------------------------------
-- adds traders for wheat, cotton and pumpkin (with farming);
-- additionally trader for carrot, orange, potatoe, rhubarb, strawberry, tomatoe, banana, cacoa, rubber (with farming_plus)

local seeds = {}; -- there will be a special trader for seeds

if( minetest.get_modpath("farming") ~= nil ) then

   for i,v in ipairs( {'wheat','cotton','pumpkin'}) do
      
      local goods = {
       {"farming:"..v.."_seed 1",        "farming:scarecrow",      "farming:scarecrow_light 1"},
       {"farming:hoe_wood 1",            "default:wood 10",        "default:cobble 10"},
      };

      table.insert( seeds, {"farming:"..v.."_seed 2", "default:dirt 20", "default:bucket_water", "default:steel_ingot 4", "default:leaves 99" });

      if(     v=='wheat') then
         table.insert( goods, {"farming:bread 1",               "default:coal_lump 9",    "default:apple 2"});
         table.insert( goods, {"farming:bread 10",              "default:steel_ingot 4",  "bucket:bucket_water 1"});
         table.insert( goods, {"farming:flour 5",               "default:coal_lump 5",    "default:apple 1"});
         table.insert( goods, {"farming:flour 10",              "default:coal_lump 9",    "default:apple 4"});
      elseif( v=='cotton') then
         table.insert( goods, {"farming:string 1",              "default:coal_lump 3",    "default:wood 8"} );
         table.insert( goods, {"farming:string 10",             "default:steel_ingot 2",  "default:chest_locked 1"});
         table.insert( goods, {"wool:white 1",                  "default:coal_lump 3",    "default:wood 8"});
         table.insert( goods, {"wool:white 10";                 "default:steel_ingot 2",  "default:chest_locked 1"});
      elseif( v=='pumpkin') then
         table.insert( goods, {"farming:pumpkin 1",             "default:coal_lump 1",    "default:cobble 3"});
         table.insert( goods, {"farming:pumpkin 10",            "default:coal_lump 18",   "bucket:bucket_empty 1"});
         table.insert( goods, {"farming:pumpkin_bread 1",       "default:coal_lump 9",    "default:apple 2"});
         table.insert( goods, {"farming:pumpkin_bread 10",      "default:steel_ingot 4",  "bucket:bucket_empty 1"});
         table.insert( goods, {"farming:pumpkin_seed 1",        "default:mese_crystal 9", "moreores:gold_ingot 5"});
         table.insert( goods, {"farming:pumpkin_face 1",        "default:steel_ingot 4",  "bucket:bucket_empty 1"});
         table.insert( goods, {"farming:pumpkin_face_light 1",  "default:steel_ingot 4",  "bucket:bucket_empty 1"});
         table.insert( goods, {"farming:big_pumpkin 1",         "default:steel_ingot 4",  "bucket:bucket_empty 1"});
         table.insert( goods, {"farming:scarecrow 1",           "default:mese_crystal 99", "moreores:gold_ingot 48"});
      end

      mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
       "farmer growing "..v,
       v.."_farmer",
       goods,
       { v.." farmer" },
       ""
      );
end


-- for each type of farming product, there is a specialized trader
if( minetest.get_modpath("farming_plus") ~= nil ) then
   -- add traders for the diffrent versions of wood
   for i,v in ipairs( {'carrot', 'orange', 'potatoe', 'rhubarb', 'strawberry', 'tomato' }) do
   
      table.insert( seeds, {"farming_plus:"..v.."_seed 2", "default:dirt 20", "default:bucket_water", "default:steel_ingot 4", "default:leaves 99" });

      local goods = {
       {"farming_plus:"..v.."_item 1",   "default:coal_lump 3",    "default:wood 8"},
       {"farming_plus:"..v.."_item 10",  "default:steel_ingot 2",  "default:chest_locked 1"},
       {"farming_plus:"..v.."_seed 1",   "farming:scarecrow",      "farming:scarecrow_light 1"},
       {"farming:hoe_wood 1",            "default:wood 10",        "default:cobble 10"},
      };

      mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
        "farmer growing "..v.."s", -- not always the right grammatical form
        v.."_farmer",
        goods,
        { "farmer" },
        ""
        );
   end

   for i,v in ipairs( {'banana','cocoa','rubber'} ) do 
       
      table.insert( seeds, {"farming_plus:"..v.."_sapling", "default:dirt 40", "default:steel_ingot 16", "default:gold_ingot 2" });

      local goods = {
       {"farming_plus:"..v.."_sapling 1", "default:mese_crystal 3", "bucket:bucket_water 1"},
       {"farming_plus:"..v.."_leaves 10", "default:coal_lump 1",    "default:wood 4"},
       {"default:axe_wood 1",             "default:coal_lump 3",    "default:wood 9"},
       {"default:axe_stone 1",            "default:steel_ingot 1",  "bucket:bucket_empty 1"}, -- a bit expensive :-)
      };

      if( v ~= 'rubber' ) then
         table.insert( goods, {"farming_plus:"..v.." 1",         "default:coal_lump 4",    "default:wood 8"} );
         table.insert( goods, {"farming_plus:"..v.." 10",        "default:steel_ingot 1",  "default:axe_stone 1"} );
      else
         table.insert( goods, {"farming_plus:bucket_rubber 1",   "default:steel_ingot 19", "default:mese_crystal 8"} );
      end

      if( v=='cocoa' ) then
         table.insert( goods,  { "farming_plus:cocoa_bean 1",   "default:coal_lump 3",   "default:wood 6"});
         table.insert( goods,  { "farming_plus:cocoa_bean 12",  "default:steel_ingot 1", "default:axe_stone 1"});
      end

      mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
        "farmer growing "..v.." trees",
        v.."_tree_farmer",
        goods,
        { "farmer" },
        ""
        );
   end

   -- not sold here because they are no fruits: cotton and bucket_rubber; bread and pumpkin_bread are sold
   goods = {};
   for i,v in ipairs( {
                        'carrot_item', 'orange_item', 'potatoe_item', 'rhubarb_item', 'strawberry_item', 'tomato_item',
                        'banana', 'cocoa' }) do
      table.insert( goods,  { "farming_plus:"..v.." 1",   "default:coal_lump 5",  "default:cobble 20"});
   end
   for i,v in ipairs( {'pumpkin', 'pumpkin_bread','bread' }) do
      table.insert( goods,  { "farming:"..v.." 1",   "default:coal_lump 5",  "default:cobble 20"});
   end

   table.insert( goods,  { "default:apple 1",   "default:coal_lump 5",  "default:wood 6"});

   mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
        "fruit trader",
        "fruit_trader", 
        goods,
        { "fruit trader" },
        ""
        );
   end

end

if( seeds and #seeds > 0 ) then
	mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
		"trader specialized in seeds",
		"seeds",
		seeds,
		{ "Sebastian" },
		""
	);
   end
