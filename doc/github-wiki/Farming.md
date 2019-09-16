1. [Farming](#farming)
	1. [Saplings](#saplings)
	2. [Plants, Food and Utensils](#plants-food-and-utensils)

# Farming

Farmable blocks will spawn either new blocks or yield new items, when mined. All farmable blocks have to be on top of another certain kind of block to grow. Some farmable blocks also need light. The “Maximum profit” column shows the maximum possible outcome a single block will yield, including itself. Please notice: Light level 13 on a farmable crop cannot be achieved at night!

![](/doc/github-wiki/images/Farming_redo.jpg)

## Saplings

Saplings are a group of blocks which grow into trees. They are dropped by leaf-type blocks with a chance of 1 in 20 for each leaf block. The sapling drop “replaces” the leaf block drop—you do not get the leaf block if you get a sapling.

All saplings can be can be placed on any block.

**Growth**

Saplings will, provided they are under sunlight and are on placed on any dirt or another block that supports growth, will grow into trees after a while. They instantly go from sapling to full tree, there are no intermediate growth stages.

Specifically, all saplings only grow on the following blocks:

  * Dirt
  * Dirt with Grass
  * Dirt with Grass and Footsteps
  * Dirt with Rainforest Litter
  * Dirt with Dry Grass
  * Soil
  * Wet Soil
  * Desert Sand (!)
  * Desert Sand Soil
  * Wet Desert Sand Soil

**Types**

There are different saplings, each sapling grows into a different tree.

| Block | Grows on | Needs light? | Drops | Stages |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| ![](/doc/github-wiki/images/32px-Sapling.png) Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | ![](/doc/github-wiki/images/32px-Tree.png) Trees, ![](/doc/github-wiki/images/32px-Leaves.png) Leaves and ![](/doc/github-wiki/images/32px-Apple.png) Apples | 2 |
| ![](/doc/github-wiki/images/32px-Jungle_Sapling.png) Jungle Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | ![](/doc/github-wiki/images/32px-Jungle_Tree.png) Jungle Trees and ![](/doc/github-wiki/images/32px-Jungle_Leaves.png) Jungle Leaves | 2 |
| ![](/doc/github-wiki/images/32px-Acacia_Tree_Sapling.png) Acacia Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | ![](/doc/github-wiki/images/32px-Acacia_Tree.png) Acacia Trees and ![](/doc/github-wiki/images/32px-Acacia_Leaves.png) Acacia Leaves | 2 |
| ![](/doc/github-wiki/images/32px-Pine_Sapling.png) Pine Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | ![](/doc/github-wiki/images/32px-Pine_Tree.png) Pine Trees and ![](/doc/github-wiki/images/32px-Pine_Needles.png) Pine Needles | 2 |
| ![](/doc/github-wiki/images/32px-Aspen_Tree_Sapling.png) Aspen Sapling | Dirt, Dirt with Grass, Dirt with Grass and Footsteps, Dirt with Dry Grass, Dirt with Snow, Soil, Wet Soil, Desert Sand Soil, Wet Desert Sand Soil | No | ![](/doc/github-wiki/images/32px-Aspen_Tree.png) Aspen Trees and ![](/doc/github-wiki/images/32px-Aspen_Leaves.png) Aspen Leaves | 2 |
| ![](/doc/github-wiki/images/32px-Cactus.png) Cactus | Any kind of sand | No | ![](/doc/github-wiki/images/32px-Cactus.png) Cacti | 4 |
| ![](/doc/github-wiki/images/32px-Papyrus.png) Papyrus | Dirt, Dirt with Grass. (Water must be to 3 blocks away) | No | ![](/doc/github-wiki/images/32px-Papyrus.png) Papyri | 4 |
| Group:flora | Dirt with Grass | Yes, 13 or higher | Flora blocks of the same kind | 1 |
| Group:flora | Desert Sand | No | ![](/doc/github-wiki/images/32px-Dry_Shrub.png) Dry Shrub | 1 |

## Plants, Food and Utensils

**Plants and their Products**

  * Barley; Barley Seed
  * Green Beans; Bean Pole (place on soil before planting beans)
  * Beetroot; Beetroot Soup
  * Blueberries; Blueberry Muffin, Blueberry Pie
  * Carrot; Golden Carrot
  * Chili; Chili Pepper, Bowl of Chili
  * Cocoa; Cocoa Beans, Cookie, Bar of Dark Chocolate
  * Coffee; Coffee Beans, Drinking Cup (empty), Cold Cup of Coffee, Hot Cup of Coffee
  * Corn; Corn on the Cob, Bottle of Ethanol
  * Cotton; Cotton Seed
  * Cucumber
  * Donut; Chocolate Donut, Apple Donut
  * Garlic; Garlic clove, Garlic Braid
  * Grapes; Trellis (place on soil before planting grapes)
  * Hemp; Hemp Seed, Hemp Leaf, Bottle of Hemp Oil, Hemp Fibre, Hemp Rope
  * Melon; Melon Slice
  * Onion
  * Peas; Pea Pod, Pea Soup
  * Pepper; Peppercorn, Ground Pepper
  * Pinapple; Pineapple Top, Pineapple Ring, Pineapple Juice
  * Potato; Baked Potato, Potato Salad
  * Pumpkin; Pumpkin Slice, Jack 'O Lantern, Pumpkin Bread, Pumpkin Dough
  * Raspberries; Raspberry Smoothie
  * Rhubarb, Rhubarb Pie
  * Sugar (from Papyrus), Salt (from cooking water)
  * Tomato
  * Wheat; Wheat Seed, Straw, Flour, Bread

**Utensils**

  * Wooden Bowl
  * Sauce Pan
  * Cooking Pot
  * Backing Tray
  * Skillet
  * Mortar and Pestle
  * Cutting Board
  * Juicer
  * Glass mixing Bowl

**Other**

  * overides to Soil, Wet Soil, Grass
  * Hoes; Wooden Hoe, Stone Hoe, Steel Hoe, Bronze Hoe, Mese Hoe, Diamond Hoe
  * Seed

| Plant | Name | Stages | Item | Itemstring |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| ![](/doc/github-wiki/images/40px-Farming_barley_7_(farming_redo).png) | Barley | 7 | ![](/doc/github-wiki/images/40px-Farming_barley.png) | farming:barley |
| ![](/doc/github-wiki/images/40px-Farming_beanpole_5_(farming_redo).png) | Beans (green) | 5 | ![](/doc/github-wiki/images/40px-Farming_beans_(farming_redo).png) | farming:beans |
| ![](/doc/github-wiki/images/40px-Farming_beetroot_5_(farming_redo).png) | Beetroot | 5 | ![](/doc/github-wiki/images/40px-Farming_beetroot_(farming_redo).png) | farming:beetroot |
| ![](/doc/github-wiki/images/40px-Farming_blueberry_4_(farming_redo).png) | Blueberries | 4 | ![](/doc/github-wiki/images/40px-Farming_blueberries_(farming_redo).png) | farming:blueberry |
| ![](/doc/github-wiki/images/40px-Farming_carrot_8_(farming_redo).png) | Carrot | 8 | ![](/doc/github-wiki/images/40px-Farming_carrot_(farming_redo).png) | farming:carrot |
| ![](/doc/github-wiki/images/40px-Farming_chili_8_(farming_redo).png) | Chili | 8 | ![](/doc/github-wiki/images/40px-Farming_chili_pepper_(farming_redo).png) | farming:chili |
| ![](/doc/github-wiki/images/40px-Farming_cocoa_4_(farming_redo).png) | Cocoa | 4 | ![](/doc/github-wiki/images/40px-Farming_cocoa_beans_(farming_redo).png) | farming:cocoa |
| ![](/doc/github-wiki/images/40px-Farming_coffee_5_(farming_redo).png) | Coffee | 5 | ![](/doc/github-wiki/images/40px-Farming_coffee_beans_(farming_redo).png) | farming:coffee |
| ![](/doc/github-wiki/images/40px-Farming_corn_8_(farming_redo).png) | Corn | 8 | ![](/doc/github-wiki/images/40px-Farming_corn_(farming_redo).png) | farming:corn |
| ![](/doc/github-wiki/images/40px-Farming_cotton_8_(farming_redo).png) | Cotton | 8 | ![](/doc/github-wiki/images/40px-Farming_cotton_(farming_redo).png) | farming:cotton |
| ![](/doc/github-wiki/images/40px-Farming_cucumber_4_(farming_redo).png) | Cucumber | 4 | ![](/doc/github-wiki/images/40px-Farming_cucumber_(farming_redo)r.png) | farming:cucumber |
| ![](/doc/github-wiki/images/40px-Crops_garlic_plant_5_(farming_redo).png) | Garlic | 5 | ![](/doc/github-wiki/images/40px-Crops_garlic_(farming_redo).png) | farming:garlic |
| ![](/doc/github-wiki/images/40px-Farming_grapes_8_(farming_redo).png) | Grapes | 8 | ![](/doc/github-wiki/images/40px-Farming_grapes_(farming_redo).png) | farming:grapes |
| ![](/doc/github-wiki/images/40px-Farming_hemp_8_(farming_redo).png) | Hemp | 8 | ![](/doc/github-wiki/images/40px-Farming_hemp_leaf_(farming_redo).png) | farming:hemp |
| ![](/doc/github-wiki/images/40px-Farming_melon_top_(farming_redo).png) | Melon | 8 | ![](/doc/github-wiki/images/40px-Farming_melon_slice_(farming_redo).png) | farming:melon |
| ![](/doc/github-wiki/images/40px-Crops_onion_plant_5_(farming_redo).png) | Onion | 5 | ![](/doc/github-wiki/images/40px-Crops_onion_(farming_redo).png) | farming:onion |
| ![](/doc/github-wiki/images/40px-Crops_pepper_plant_5_(farming_redo).png) | Pepper | 5 | ![](/doc/github-wiki/images/40px-Crops_pepper_(farming_redo).png) | farming:pepper |
| ![](/doc/github-wiki/images/40px-Farming_pineapple_8_(farming_redo).png) | Pineapple | 8 | ![](/doc/github-wiki/images/40px-Farming_pineapple_(farming_redo).png) | farming:pineapple |
| ![](/doc/github-wiki/images/40px-Farming_potato_4_(farming_redo).png) | Potato | 4 | ![](/doc/github-wiki/images/40px-Farming_potato_(farming_redo).png) | farming:potato |
| ![](/doc/github-wiki/images/40px-Farming_pea_5_(farming_redo).png) | Peas | 5 | ![](/doc/github-wiki/images/40px-Farming_pea_peas_(farming_redo).png) | farming:peas |
| ![](/doc/github-wiki/images/40px-Farming_pumpkin_8_(farming_redo).png) | Pumpkin | 8 | ![](/doc/github-wiki/images/40px-Farming_pumpkin_top_(farming_redo).png) | farming:pumpkin |
| ![](/doc/github-wiki/images/40px-Farming_raspberry_4_(farming_redo).png) | Raspberries | 4 | ![](/doc/github-wiki/images/40px-Farming_raspberries_(farming_redo).png) | farming:raspberry |
| ![](/doc/github-wiki/images/40px-Farming_rhubarb_3_(farming_redo).png) | Rhubarb | 3 | ![](/doc/github-wiki/images/40px-Farming_rhubarb_(farming_redo).png) | farming:rhubarb |
| ![](/doc/github-wiki/images/40px-Farming_tomato_(farming_redo).png) | Tomato | 8 | ![](/doc/github-wiki/images/40px-Farming_tomato_8_(farming_redo).png) | farming:tomato |
| ![](/doc/github-wiki/images/40px-Farming_wheat_8_(farming_redo).png) | Wheat | 8 | ![](/doc/github-wiki/images/40px-Farming_wheat_(farming_redo).png) | farming:wheat |