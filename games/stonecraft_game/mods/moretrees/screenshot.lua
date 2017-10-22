-- Usage:
-- - Create a new world
-- - Set world mapgen: v6
-- - Set world seed: 2625051331357512570
-- - Enable the moretrees mod
-- - Edit the moretrees source
--   - Disable all trees in default_settings.lua
--   - Recommended: make saplings grow fast in default_settings.lua:
--     sapling_interval = 5
--     sapling_chance = 1
--   - Apply the patch below to moretrees
--     (so that jungle trees are always large, and differently-colored):
--     use 'git apply --ignore-space-change'
--   - Make sure this file (you are reading) will be loaded when minetest starts !
--     (e.g. add 'dofile(modpath.."/screenshot.lua")' to init.lua)
-- - Start minetest
-- - Goto 700,y,-280 (approximately)
-- - Make sure the world is loaded between x = 650 .. 780 and z = -350 .. -180
-- - Give the chat command '/make-scene'
-- - Wait & walk/fly around until all trees have grown
-- - goto the platform at 780, 30, -277
-- - Set the viewing range to 300, with fog enabled
-- - Take a screenshot.

-- Patch to apply to moretrees
--[[
diff --git a/init.lua b/init.lua
index 8189ffd..afd4644 100644
--- a/init.lua
+++ b/init.lua
@@ -225,9 +225,12 @@ moretrees.ct_rules_b1 = "[-FBf][+FBf]"
 moretrees.ct_rules_a2 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
 moretrees.ct_rules_b2 = "[-fB][+fB]"
 
+local jleaves = 1
 function moretrees.grow_jungletree(pos)
        local r1 = math.random(2)
        local r2 = math.random(3)
+       r1 = jleaves
+       jleaves = jleaves % 2 + 1
        if r1 == 1 then
                moretrees.jungletree_model.leaves2 = "moretrees:jungletree_leaves_red"
        else 
@@ -235,6 +238,7 @@ function moretrees.grow_jungletree(pos)
        end
        moretrees.jungletree_model.leaves2_chance = math.random(25, 75)
 
+       r2=3
        if r2 == 1 then
                moretrees.jungletree_model.trunk_type = "single"
                moretrees.jungletree_model.iterations = 2
]]


minetest.register_chatcommand("make-scene", {
	func = function()
		minetest.place_node({x=780, y=30, z=-277}, {name="default:obsidian"})
		minetest.place_node({x=780, y=30, z=-278}, {name="default:obsidian"})
		minetest.place_node({x=781, y=30, z=-277}, {name="default:obsidian"})
		minetest.place_node({x=781, y=30, z=-278}, {name="default:obsidian"})
		minetest.place_node({x=781, y=30, z=-276}, {name="default:obsidian"})
		minetest.place_node({x=780, y=30, z=-276}, {name="default:obsidian"})

		for z = -360, -300 do
			dy=2
			for x = 630 + (-z - 360)/3, 660 + (-z - 300)/3 do
				for y = 5, 22 do
					minetest.place_node({x=x, y=y, z=z}, {name="default:desert_stone"})
				end
				for y = 23, 25 + dy do
					minetest.place_node({x=x, y=y, z=z}, {name="default:desert_sand"})
				end
				dy = 0
			end
		end

		minetest.place_node({x=717, y=2, z=-298}, {name = "moretrees:palm_sapling"})
		minetest.place_node({x=713, y=2, z=-302}, {name = "moretrees:palm_sapling"})
		minetest.place_node({x=713, y=2, z=-307}, {name = "moretrees:palm_sapling"})
		minetest.place_node({x=717, y=2, z=-318}, {name = "moretrees:palm_sapling"})
		minetest.place_node({x=723, y=2, z=-320}, {name = "moretrees:palm_sapling"})

		minetest.place_node({x=645, y=26, z=-314}, {name="moretrees:date_palm_sapling"})
		minetest.place_node({x=653, y=26, z=-322}, {name="moretrees:date_palm_sapling"})
		minetest.place_node({x=649, y=26, z=-334}, {name="moretrees:date_palm_sapling"})
		minetest.place_node({x=662, y=26, z=-342}, {name="moretrees:date_palm_sapling"})

		minetest.place_node({x=672, y=5, z=-305}, {name="moretrees:oak_sapling"})
		minetest.place_node({x=690, y=6, z=-322}, {name="moretrees:oak_sapling"})
		minetest.place_node({x=695, y=7, z=-335}, {name="moretrees:oak_sapling"})
		minetest.place_node({x=699, y=4, z=-301}, {name="moretrees:oak_sapling"})

		minetest.place_node({x=751, y=5, z=-254}, {name="moretrees:apple_tree_sapling"})
		minetest.place_node({x=729, y=3, z=-275}, {name="moretrees:apple_tree_sapling"})
		minetest.place_node({x=747, y=4, z=-270}, {name="moretrees:apple_tree_sapling"})

		minetest.place_node({x=671, y=5, z=-283}, {name="default:junglesapling"})
		minetest.place_node({x=680, y=4, z=-287}, {name="default:junglesapling"})
		minetest.place_node({x=702, y=4, z=-288}, {name="default:junglesapling"})

		minetest.place_node({x=646, y=12, z=-199}, {name="moretrees:spruce_sapling"})
		minetest.place_node({x=644, y=14, z=-177}, {name="moretrees:spruce_sapling"})
		minetest.place_node({x=678, y=9, z=-211}, {name="moretrees:spruce_sapling"})
		minetest.place_node({x=663, y=10, z=-215}, {name="moretrees:spruce_sapling"})

		minetest.place_node({x=637, y=3, z=-263}, {name="moretrees:sequoia_sapling"})
		minetest.place_node({x=625, y=3, z=-250}, {name="moretrees:sequoia_sapling"})
		minetest.place_node({x=616, y=3, z=-233}, {name="moretrees:sequoia_sapling"})
		minetest.place_node({x=635, y=3, z=-276}, {name="moretrees:sequoia_sapling"})
		minetest.place_node({x=681, y=11, z=-260}, {name="moretrees:sequoia_sapling"})
		minetest.place_node({x=682, y=10, z=-247}, {name="moretrees:sequoia_sapling"})

		minetest.place_node({x=737, y=7, z=-195}, {name="moretrees:cedar_sapling"})
		minetest.place_node({x=720, y=8, z=-189}, {name="moretrees:cedar_sapling"})
		minetest.place_node({x=704, y=7, z=-187}, {name="moretrees:cedar_sapling"})

		minetest.place_node({x=731, y=2, z=-227}, {name="moretrees:poplar_sapling"})
		minetest.place_node({x=721, y=2, z=-233}, {name="moretrees:poplar_sapling"})
		minetest.place_node({x=712, y=1, z=-237}, {name="moretrees:poplar_sapling"})
		minetest.place_node({x=743, y=3, z=-228}, {name="moretrees:poplar_small_sapling"})
		minetest.place_node({x=750, y=3, z=-230}, {name="moretrees:poplar_small_sapling"})
		minetest.place_node({x=731, y=5, z=-233}, {name="moretrees:poplar_small_sapling"})

		minetest.place_node({x=702, y=2, z=-274}, {name="moretrees:birch_sapling"})
		minetest.place_node({x=697, y=2, z=-271}, {name="moretrees:birch_sapling"})
		minetest.place_node({x=696, y=2, z=-264}, {name="moretrees:birch_sapling"})
		minetest.place_node({x=710, y=2, z=-265}, {name="moretrees:birch_sapling"})

		minetest.place_node({x=707, y=8, z=-247}, {name="moretrees:fir_sapling"})
		minetest.place_node({x=699, y=10, z=-254}, {name="moretrees:fir_sapling"})
		minetest.place_node({x=729, y=5, z=-261}, {name="moretrees:fir_sapling"})
		minetest.place_node({x=732, y=5, z=-252}, {name="moretrees:fir_sapling"})
		minetest.place_node({x=741, y=4, z=-262}, {name="moretrees:fir_sapling"})

		minetest.place_node({x=751, y=2, z=-286}, {name="moretrees:willow_sapling"})

		minetest.place_node({x=760, y=5, z=-223}, {name="moretrees:rubber_tree_sapling"})
		minetest.place_node({x=762, y=5, z=-230}, {name="moretrees:rubber_tree_sapling"})
		minetest.place_node({x=766, y=5, z=-243}, {name="moretrees:rubber_tree_sapling"})
		minetest.place_node({x=764, y=6, z=-252}, {name="moretrees:rubber_tree_sapling"})
	end
})

--[[
The following is a search/replace command suitable for vi (/vim) or sed, to convert minetest log
messages to equivalent lua commands:

s/.*\(\(moretrees\|default\)[^ ]*\) at (\([-0-9]\+\),\([-0-9]\+\),\([-0-9]\+\)).*/\t\tminetest.place_node({x=\3, y=\4, z=\5}, {name="\1"})/

E.g. a minetest log line of the following kind:
		2016-07-03 11:30:50: ACTION[Server]: singleplayer places node moretrees:rubber_tree_sapling at  (760,5,-223)
Becomes:
		minetest.place_node({x=760, y=5, z=-223}, {name="moretrees:rubber_tree_sapling"})
(Except that the example log line above has an extra space added, so it won't be converted)

vi/vim users: Add the minetest log lines to this file, then enter the following command, with
<expression> replaced with the search/replace expression above.
	:%<expression>

sed users: Add the minetest log lines to this file, then execute the following command at the shell
prompt with <expression> replaced by the search/replace expression above. Don't forget the
single-quotes.
	sed '<expression>' < screenshot.lua > screenshot-new.lua

Windows users: You're probably out of luck. And the effort of doing such a thing is probably
larger anyway than the effort of copying an existing line and typing things manually.
]]

