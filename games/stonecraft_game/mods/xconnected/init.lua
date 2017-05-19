
-----------------------------------------------------------------------
-- xconnected.lua contains the actual code and api for xconnected nodes
-----------------------------------------------------------------------
dofile(minetest.get_modpath("xconnected").."/xconnected.lua");


-----------------------------------------------------------------------
-- register some example panes, walls and fences
-----------------------------------------------------------------------

-- for comparison: xpanes
xconnected.register_pane( 'xconnected:pane_glass',              S('Glass'),					'default_glass.png',			'default:glass');
xconnected.register_pane( 'xconnected:pane_obsidian_glass',     S('Obsidian Glass'),		'default_obsidian_glass.png',	'default:obsidian_glass');

-- diffrent types of walls
xconnected.register_wall( 'xconnected:wall_tree',               S('Tree'),					'default_tree.png',               'default:tree' );
xconnected.register_wall( 'xconnected:wall_wood',               S('Wood'),					'default_wood.png',               'default:fence_wood' ); 
xconnected.register_wall( 'xconnected:wall_stone',              S('Stone'),					'default_stone.png',              'default:stone' );
xconnected.register_wall( 'xconnected:wall_cobble',             S('Cobble'),				'default_cobble.png',             'default:cobble' );
xconnected.register_wall( 'xconnected:wall_brick',              S('Brick'),					'default_brick.png',              'default:brick' );
xconnected.register_wall( 'xconnected:wall_stone_brick',        S('Stone Brick'),			'default_stone_brick.png',        'default:stonebrick' );
xconnected.register_wall( 'xconnected:wall_sandstone_brick',    S('Sandstone Brick'),		'default_sandstone_brick.png',    'default:sandstonebrick' );
xconnected.register_wall( 'xconnected:wall_desert_stone_brick', S('Desert Stone Brick'),	'default_desert_stone_brick.png', 'default:desert_stonebrick' );
xconnected.register_wall( 'xconnected:wall_obsidian_brick',     S('Obsidian Brick'),		'default_obsidian_brick.png',     'default:obsidianbrick' );
xconnected.register_wall( 'xconnected:wall_hedge',              S('Hedge'),					'default_leaves.png',             'default:leaves' );
xconnected.register_wall( 'xconnected:wall_clay',               S('Clay'),					'default_clay.png',               'default:clay' );
xconnected.register_wall( 'xconnected:wall_coal_block',         S('Coal Block'),			'default_coal_block.png',         'default:coalblock' );

-- xfences can also be emulated
xconnected.register_fence('xconnected:fence',        			S('Wood'),					'default_wood.png',        'default:wood');
xconnected.register_fence('xconnected:fence_pine',				S('Pine Wood'),				'default_pine_wood.png',   'default:pine_wood');
xconnected.register_fence('xconnected:fence_jungle', 			S('Junglewood'),			'default_junglewood.png',  'default:junglewood');
xconnected.register_fence('xconnected:fence_acacia', 			S('Acacia Wood'),			'default_acacia_wood.png', 'default:acacia_wood');

--[[
-- this innocent loop creates quite a lot of nodes - but only if you have the stained_glass mod installed
if(    minetest.get_modpath( "stained_glass" )
   and minetest.global_exists( stained_glass_hues)
   and minetest.global_exists( stained_glass_shade)) then

	for _,hue in ipairs( stained_glass_hues ) do
		for _,shade in ipairs( stained_glass_shade ) do
			xconnected.register_pane( 'xconnected:pane_'..shade[1]..hue[1], 'stained_glass_'..shade[1]..hue[1]..'.png');
		end
	end
end
--]]
