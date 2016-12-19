-------------------------------------------
-- Traders for moretrees (and normal trees)
--------------------------------------------
-- without moretrees, you get only one lumberjack that sells default trees
-- with moretrees, traders for all tree types are added as well: normal trees, birch, spruce, jungletree, fir, beech, apple_tree, oak, sequoia, palm, pine, willow, rubber_tree

-- sell normal wood - rather expensive...
mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
    "Trader of common wood",
    "common_wood",
    {
       {"default:wood 4",             "default:dirt 24",       "default:cobble 24"},
       {"default:tree 4",             "default:apple 2",       "default:coal_lump 4"},
       {"default:tree 8",             "default:pick_stone 1",  "default:axe_stone 1"},
       {"default:tree 12",            "default:cobble 80",     "default:steel_ingot 1"},
       {"default:tree 36",            "bucket:bucket_empty 1", "bucket:bucket_water 1"},
       {"default:tree 42",            "default:axe_steel 1",   "default:mese_crystal 4"},

       {"default:sapling 1",          "default:dirt 10",       "default:cobble 10"},
       {"default:leaves 10",          "default:dirt 10",       "default:cobble 10"}
    },
    { "lumberjack" },
    {"holzfaeller.png"}
    );


-- not everyone has moretrees (though selling wood is one of the main purposes of this mod)
if( minetest.get_modpath("moretrees") ~= nil ) then

   mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
    "Trader of wood",
    "wood",
    {
       {"moretrees:birch_trunk 8",       "default:cobble 80", "default:steel_ingot 1"},
       {"moretrees:spruce_trunk 8",      "default:cobble 80", "default:steel_ingot 1"},
       {"moretrees:jungletree_trunk 8",  "default:cobble 80", "default:steel_ingot 1"},
       {"moretrees:fir_trunk 8",         "default:cobble 80", "default:steel_ingot 1"},
       {"moretrees:beech_trunk 8",       "default:cobble 80", "default:steel_ingot 1"},
       {"moretrees:apple_tree_trunk 8",  "default:cobble 80", "default:steel_ingot 1"},
       {"moretrees:oak_trunk 8",         "default:cobble 80", "default:steel_ingot 1"},
       {"moretrees:sequoia_trunk 8",     "default:cobble 80", "default:steel_ingot 1"},
       {"moretrees:palm_trunk 8",        "default:cobble 80", "default:steel_ingot 1"},
       {"moretrees:pine_trunk 8",        "default:cobble 80", "default:steel_ingot 1"},
       {"moretrees:willow_trunk 8",      "default:cobble 80", "default:steel_ingot 1"},
       {"moretrees:rubber_tree_trunk 8", "default:cobble 80", "default:steel_ingot 1"},
    },
    { "Woody" },
    {"holzfaeller.png"}
    );


   -- add traders for the diffrent versions of wood
   for i,v in ipairs( {'birch', 'spruce', 'jungletree', 'fir', 'beech', 'apple_tree', 'oak', 'sequoia', 'palm', 'pine', 'willow', 'rubber_tree' }) do
   
      -- all trunk types cost equally much
      local goods = {
       {"moretrees:"..v.."_planks 4",    "default:dirt 24",       "default:cobble 24"},
       {"moretrees:"..v.."_trunk 4",     "default:apple 2",       "default:coal_lump 4"},
       {"moretrees:"..v.."_trunk 8",     "default:pick_stone 1",  "default:axe_stone 1"},
       {"moretrees:"..v.."_trunk 12",    "default:cobble 80",     "default:steel_ingot 1"},
       {"moretrees:"..v.."_trunk 36",    "bucket:bucket_empty 1", "bucket:bucket_water 1"},
       {"moretrees:"..v.."_trunk 42",    "default:axe_steel 1",   "default:mese_crystal 4"},

       {"moretrees:"..v.."_sapling 1",   "default:mese 10",       "default:steel_ingot 48"},
       {"moretrees:"..v.."_leaves 10",   "default:cobble 1",      "default:dirt 2"}
       };

      -- sell the fruits of the trees (apples and coconuts have a slightly higher value than the rest)
      if( v=='oak' ) then
         table.insert( goods, { "moretrees:acorn 10",       "default:cobble 10", "default:dirt 10"} );
      elseif( v=='palm' ) then
         table.insert( goods, { "moretrees:coconut 1",      "default:cobble 10", "default:dirt 10"} );
      elseif( v=='spruce' ) then
         table.insert( goods, { "moretrees:spruce_cone 10", "default:cobble 10", "default:dirt 10"} );
      elseif( v=='pine' ) then
         table.insert( goods, { "moretrees:pine_cone 10",   "default:cobble 10", "default:dirt 10"} );
      elseif( v=='fir' ) then
         table.insert( goods, { "moretrees:fir_cone 10",    "default:cobble 10", "default:dirt 10"} );
      elseif( v=='apple_tree' ) then
         table.insert( goods, { "default:apple 1",          "default:cobble 10", "default:dirt 10"} );
      end
      -- TODO: rubber_tree: sell rubber? (or rather do so in the farmingplus-trader?)

      mobf_trader.add_trader( mobf_trader.npc_trader_prototype,
        "Trader of "..( v or "unknown" ).." wood",
        v.."_wood",
        goods,
        { "lumberjack" },
        {"holzfaeller.png"}
        );
   end
end

