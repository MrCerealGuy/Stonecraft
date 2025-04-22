# [mod] Visible Player Armor [3d_armor]

|  |  |  |  | 
|--|--|--|--|
|-[Overview](#overview)                                                     |||-[API](#api)
|-[Armor Configuration](#armor-configuration)                               |||- - [3d_Armor Item Storage](#3d_armor-item-storage)
|- - [disable_specific_materials](#to-disable-individual-armor-materials)   |||- - [Armor Registration](#armor-registration)
|- - [armor_init_delay](#initialization-glitches-when-a-player-first-joins) |||- - [Registering Armor Groups](#registering-armor-groups)
|- - [wieldview_update_time](#how-often-player-wield-items-are-updated)     |||- - [Groups used by 3d_Armor](#groups-used-by-3d_armor)
|- - [armor_bones_delay](#armor-not-in-bones-due-to-server-lag)             |||- - - [Elements](#elements)
|- - [armor_update_time](#how-often-player-armor-items-are-updated)         |||- - - [Attributes](#attributes)
|- - [armor_drop](#drop-armor-when-a-player-dies)                           |||- - - [Physics](#physics)
|- - [armor_destroy](#destroy-armor-when-a-player-dies)                     |||- - - [Durability](#durability)
|- - [armor_level_multiplier](#armor-level-multiplyer)                      |||- - - [Armor Material](#armor-material)
|- - [armor_heal_multiplier](#armor-healing-multiplyer)                     |||- - [Armour Functions](#armor-functions)
|- - [armor_set_elements](#allows-the-customisation-of-armor-set)           |||- - - [armor:set_player_armor](#armor-set_player_armor)
|- - [armor_set_bonus](#armor-set-bonus-multiplier)                         |||- - - [armor:punch](#armor-punch)
|- - [armor_water_protect](#enable-water-protection)                        |||- - - [armor:damage](#armor-damage)
|- - [armor_fire_protect](#enable-fire-protection)                          |||- - - [armor:remove_all](#armor-remove_all)
|- - [armor_punch_damage](#enable-punch-damage-effects)                     |||- - - [armor:equip](#armor-equip)
|- - [armor_migrate_old_inventory](#migration-of-old-armor-inventories)     |||- - - [armor:unequip](#armor-unequip)
|                                                                           |||- - - [armor:update_skin](#armor-update_skin)
|-[Credits](#credits)                                                       |||- - [Callbacks](#Callbacks)
|                                                                           |||- - - [Item callbacks](#item-callbacks)
|                                                                           |||- - - [Global callbacks](#global-callbacks)

# Overview

**Depends:** default

**Recommends:** sfinv, unified_inventory or smart_inventory (use only one to avoid conflicts)

**Supports:** player_monoids, armor_monoid and POVA

Adds craftable armor that is visible to other players. Each armor item worn contributes to
a player's armor group level making them less vulnerable to weapons.

Armor takes damage when a player is hurt but also offers a percentage chance of healing.
Overall level is boosted by 10% when wearing a full matching set.

# Armor Configuration

Change the following default settings by going to Main Menu>>Settings(Tab)>>All Settings(Button)>>Mods>>minetest-3d_Armor>>3d_Armor

### To disable individual armor materials
 **set the below to false**

    armor_material_wood = true
    armor_material_cactus = true
    armor_material_steel = true
    armor_material_bronze = true
    armor_material_diamond = true
    armor_material_gold = true
    armor_material_mithril = true
    armor_material_crystal = true
    armor_material_nether = true

### Initialization glitches when a player first joins
 **Increase to prevent glitches**
 
    armor_init_delay = 2

### Armor not in bones due to server lag
 **Increase to help resolve**
 
    armor_bones_delay = 1

### How often player armor items are updated
**Number represents how often per second update is performed, higher value means less performance hit for servers but armor items maybe delayed in updating when switching.Fractional seconds also supported eg 0.1**

    armor_update_time = 1
	
### Drop armor when a player dies
 **Uses bones mod if present, otherwise items are dropped around the player when false.**

    armor_drop = true

### Destroy armor when a player dies
 **overrides armor_drop.**

    armor_destroy = false

### Armor level multiplyer
 **Increase to make armor more effective and decrease to make armor less effective**
 **eg: level_multiplier = 0.5 will reduce armor level by half.**

    armor_level_multiplier = 1

### Armor healing multiplyer
 **Increase to make armor healing more effective and decrease to make healing less effective**
 **eg: armor_heal_multiplier = 0 will disable healing altogether.**

    armor_heal_multiplier = 1
	
### Allows the customisation of armor set 
 **Shields already configured as need to be worn to complete an armor set**   
 **These names come from [Element names](#groups-used-by-3d_armor), the second half of the element name only is used eg armor_head is head**
 
    armor_set_elements = head torso legs feet shield

### Armor set bonus multiplier 
 **Set to 1 to disable set bonus**
 
    armor_set_multiplier = 1.1

### Enable water protection
 **periodically restores breath when activated**

    armor_water_protect = true

### Enable fire protection 
**defaults to true if using ethereal mod**

    armor_fire_protect = false
	
### Fire protection enabled, disable torch fire damage 
**when fire protection is enabled allows you to disable fire damage from torches**
**defaults to true if using ethereal mod**

    armor_fire_protect_torch = false

### Enable punch damage effects

    armor_punch_damage = true

### Migration of old armor inventories

    armor_migrate_old_inventory = true
	
### How often player wield items are updated
**Number represents how often per second update is performed, higher value means less performance hit for servers but wield items maybe delayed in updating when switching. Fractional seconds also supported eg 0.1**   
***Note this is MT engine functionality but included for completness***

    wieldview_update_time = 1

# API

## 3d_Armor item storage
3d_Armor stores each armor piece a player currently has equiped in a ***detached*** inventory. The easiest way to access this inventory if needed is using this line of code

	local _, armor_inv = armor:get_valid_player(player, "3d_armor")

**Example** 

	armor:register_on_equip(function(player, index, stack)
		local _, armor_inv = armor:get_valid_player(player, "3d_armor")
			for i = 1, 6 do
				local stack = armor_inv:get_stack("armor", i)
					if stack:get_name() == "3d_armor:chestplate_gold" then
						minetest.chat_send_player(player:get_player_name(),"Got to love the Bling!!!")
					end
			end
	end)

## Armor Registration

    armor:register_armor(name, def)

Wrapper function for `minetest.register_tool`, which enables the easy registration of new armor items. While registering armor as a tool item is still supported, this may be deprecated in future so all armor items should be registered using *armor:register_armor(name,def)*.

### Additional fields supported by 3d_armor

	texture = <filename>
	preview = <filename>
	armor_groups = <table>
	damage_groups = <table>
	reciprocate_damage = <bool>
	on_equip = <function>
	on_unequip = <function>
	on_destroy = <function>
	on_damage = <function>
	on_punched = <function>

***Reciprocal tool*** damage will apply damage back onto the attacking tool/weapon, however this will only be done by the first armor inventory item with `reciprocate_damage = true`, damage does not stack.
 
**Example Simple:**

    armor:register_armor("mod_name:chestplate_leather", {
    	description = "Leather Chestplate",
    	inventory_image = "mod_name_inv_chestplate_leather.png",
    	texture = "mod_name_leather_chestplate.png",
    	preview = "mod_name_leather_chestplate_preview.png",
    	groups = {armor_torso=1, armor_heal=0, armor_use=2000, flammable=1},
    	armor_groups = {fleshy=10},
    	damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1}
    })
*See ***armor.lua*** under **3d_armor>>3d_armor** for further examples*

**Extended functionality**   
The values for ***texture*** and ***preview*** do not need to be included when registering armor if they follow the naming convention in the textures mod folder of:   
***texture:*** *mod_name_leather_chestplate.png*   
***preview:*** *mod_name_leather_chestplate_preview.png*

## Registering Armor Groups
3d armor has a built in armor group which is ***fleshy*** all players base vulnerability to being fleshy is ***100***. 
 3d armour allows for the easy registration/addition of new armor groups::

    armor:register_armor_group(group, base)
    
***group:*** Is the name of the new armor group 
***base*** Is the starting vulnerability that all players have to that new group. This dosent need to be 100.

**Example**

    armor:register_armor_group("radiation", 100)

New armor group is registered called *radiation* and all players start off with a base vulnerability of *100* to radiation.

**Example** *Showing armor reg, new group usage and custom function*

    armor:register_armor("mod_name:speed_boots", {
    	description = "Speed Boots",
    	inventory_image = "mod_name_speed_boots_inv.png",
    	texture = "mod_name_speed_boots.png",
    	preview = "mod_name_speed_boots_preview.png",
    	groups = {armor_feet=1, armor_use=500, physics_speed=1.2, flammable=1},
    	armor_groups = {fleshy=10, radiation=10},
    	damage_groups = {cracky=3, snappy=3, choppy=3, crumbly=3, level=1},
    	reciprocate_damage = true,
    	on_destroy = function(player, index, stack)
    		local pos = player:get_pos()
    		if pos then
    			minetest.sound_play({
    				name = "mod_name_break_sound",
    				pos = pos,
    				gain = 0.5,
    			})
    		end
    	end,
    })

### Tools/weapons and new armor groups
The above allows armor to block/prevent new damage types but you also need to assign the new damage group to a tool/weapon or even a node (see technic mod) to make wearing the armor item meaningful. Simply add the ***armor_groups*** name to the tool items ***damage_groups***. 

**Example**

    minetest.register_tool("mod_name:glowing_sword", {
	    description = "Glowing Sword",
	    inventory_image = "mod_name_tool_glowingsword.png",
	    tool_capabilities = {full_punch_interval = 1.2,max_drop_level=0,
	    groupcaps={
		    cracky = {times={[3]=1.60}, uses=10, maxlevel=1},},
		    damage_groups = {fleshy=10,radiation=20},
		    },
		sound = {breaks = "default_tool_breaks"},
	    groups = {pickaxe = 1, flammable = 2}
    })

## Groups used by 3d_Armor
3d_armor has many default groups already registered, these are categorized under 4 main headings
 - **Elements:** armor_head, armor_torso, armor_legs, armor_feet
 - **Attributes:** armor_heal, armor_fire, armor_water, armor_feather
 - **Physics:** physics_jump, physics_speed, physics_gravity
 - **Durability:** armor_use, flammable
 
***Note: for calculation purposes "Attributes" and "Physics" values stack***

### Elements
Additional armor elements can be added by dependant mods, for example shields adds the group armor_shield which has by default a limit that only 1 shield can be worn at a time.

Adding Elements is more complex but the below code can be used to add new elements;

    if minetest.global_exists("armor") and armor.elements then
    	table.insert(armor.elements, "hands")
    end
**1st line** not strictly needed but checks that the global table "armor" and subtable "elements" exists   
**2nd line** adds a new value to the armor.elements table called "hands"  

See ***init.lua*** under **3d_armor>>shields** for a further example

The new armor item can now be registered using the new element
**Example**

    armor:register_armor("mod_name:gloves_wood", {    
	    description = "Wood Gauntlets",   
	    inventory_image = "mod_name_inv_gloves_wood.png",
	    texture = "mod_name_gloves_wood.png",
    	preview = "mod_name_gloves_wood_preview.png",   
	    groups = {armor_hands=1, armor_heal=0, armor_use=2000, flammable=1},   
	    armor_groups = {fleshy=5},    
	    damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
	})

### Attributes
Three attributes are avaliable in 3d_armor these are armor_heal, armor_fire and armor_water. Although possible to add additional attributes they would do nothing as code needs to be provide to specifiy the behaviour this could be done in a dependant mod

#### Armor_heal
This isn't how much the armor will heal but relates to the chance the armor will completely block the damage. For each point of ***armor_heal*** there is a 1% chance that damage will be completely blocked, this value will stack between all armor pieces

**Example**
The below Diamond chestplate has a 12% chance to completely block all damage (armor_heal=12), however so do boots, helmet and trousers so if the player was wearing all 4 pieces they would have a 48% chance of blocking all damage each attack.
 
	armor:register_armor("3d_armor:chestplate_diamond", {
		description = S("Diamond Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_diamond.png",
		groups = {armor_torso=1, armor_heal=12, armor_use=200},
		armor_groups = {fleshy=20},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
	}) 

#### Armor_fire
***"Armor_fire"*** provides 5 levels of fire protection    
 - level 1 protects against torches
 - level 2 protects against crystal spike (Ethereal mod)
 - level 3 protects against fire
 - level 4 unused
 - level 5 protects against lava
	
**Example**

	armor:register_armor("mod_name:fire_proof_jacket", {
		description = "Fire Proof Jacket",
		inventory_image = "mod_name_inv_fire_proof_jacket.png",
		groups = {armor_torso=1, armor_fire=3, armor_use=1000},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
	})

#### Armor_water
***"Armor_water"*** will periodically restore a players breath when underwater. This only has one level or state, which is armor_water=1  

**Example**

	armor:register_armor("mod_name:helmet_underwater_breath", {
		description = "Helmet of Underwater Breathing",
		inventory_image = "mod_name_inv_helmet_underwater_breath.png",
		groups = {armor_head=1, armor_water=1, armor_use=1000},
		armor_groups = {fleshy=5},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
	})

#### Armor_feather
***"Armor_feather"*** will slow a player when falling. This only has one level or state, which is armor_feather=1

### Physics
The physics attributes supported by 3d_armor are ***physics_jump, physics_speed and physics_gravity***. Although 3d_armor supports the use of this with no other mods it is recommended that the mod [player_monoids](https://forum.minetest.net/viewtopic.php?t=14895) is used to help with intermod compatability. 

***physics_jump*** - Will increase/decrease the jump strength of the player so they can jump more/less. The base number is "1" and any value is added or subtracted, supports fractional so "physics_jump=1" will increase jump strength by 100%. "physics_jump= -0.5" will decrease jump by 50%.  

***physics_speed*** - Will increase/decrease the walk speed of the player so they walk faster/slower. The base number is "1" and any value is added or subtracted, supports fractional so "physics_speed=1.5" will increase speed by 150%, "physics_speed= -0.5" will decrease speed by 50%. 

***physics_gravity*** - Will increase/decrease gravity the player experiences so it's higher/lower. The base number is "1" and any value is added or subtracted, supports fractional so "physics_gravity=2" will increase gravity by 200%, "physics_gravity= -1" will decrease gravity by 100%. 

*Note: The player physics modifications won't be applied via `set_physics_override` if `player_physics_locked` is set to 1 in the respective player's meta.*

### Durability
Durability is determined by the value assigned to the group ***armor_use***. The higher the ***armor_use*** value the faster/more quickly it is damaged/degrades. This is calculated using the formula:

     Total uses = approx(65535/armor_use)
	 
 **Example**  
 All wood armor items have an ***armor_use=2000***;
 
	65535/2000 = 32.76 (32)   
 After 32 uses(hits) the armor item will break.   
 
 All diamond armor items have an  ***armor_use=200***;
 
	65535/2000 = 327.6 (327)   
 After 327 uses(hits) the armor item will break. 

### Armor Material 
The material the armor is made from is defined by adding the material to the end of registered armor item name. It is very important the material is the last item in the registered item name and it is preceeded by an "_" eg "_materialname".
The material name is what 3d_armor uses to determine if a player is wearing a set of armor. To recieve the set bonus all items worn must be made of the same material.
So to get a set bonus under the default set settings the players armor items listed below must be made of the same material:
* head - Helmet
* torso - Chestplate
* legs - Leggings
* feet - Boots
* shield - Shields   

If all of the above were made of material "wood" the player would recieve an ***armor_set_bonus*** of armor_level * 1.1, essentially +10%  

 **Example One** 
 
	armor:register_armor("3d_armor:helmet_bronze", {
		description = S("Bronze Helmet"),
		inventory_image = "3d_armor_inv_helmet_bronze.png",
		groups = {armor_head=1, armor_heal=6, armor_use=400, physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	})
	
 **Example Two** 
 
	armor:register_armor("new_mod:helmet_spartan_bronze", {
		description = S("Spartan Helmet"),
		inventory_image = "new_mod_inv_helmet_spartan_bronze.png",
		groups = {armor_head=1, armor_heal=6, armor_use=350, physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=12},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	})

***Note: At the moment an armor item can only be made of one material***

## Armor Functions

See also: [API Reference](https://minetest-mods.github.io/3d_armor/reference/)

### armor set_player_armor

	armor:set_player_armor(player)

Primarily an internal function but can be called externally to apply any
changes that might not otherwise get handled.

### armor punch

	armor:punch(player, hitter, time_from_last_punch, tool_capabilities)

Used to apply damage to all equipped armor based on the damage groups of
each individual item.`hitter`, `time_from_last_punch` and `tool_capabilities`
are optional but should be valid if included.

### armor damage

	armor:damage(player, index, stack, use)

Adds wear to a single armor itemstack, triggers `on_damage` callbacks and
updates the necessary inventories. Also handles item destruction callbacks
and so should NOT be called from `on_unequip` to avoid an infinite loop.

### armor remove_all

	armor:remove_all(player)

Removes all armors from the player's inventory without triggering any callback.

### armor equip

	armor:equip(player, armor_name)

Equip the armor, removing the itemstack from the main inventory if there's one.

### armor unequip

	armor:unequip(player, armor_name)

Unequip the armor, adding the itemstack to the main inventory.

### armor update_skin

	armor:update_skin(player_name)

Triggers a skin update with the same action as if a field with `skins_set` was submitted.

## Callbacks

### Item Callbacks

In all of the below when armor is destroyed `stack` will contain a copy of the previous stack.

*unsure what this note means may apply to all item callbacks or just on_punched*   
Return `false` to override armor damage effects.

#### on_equip

	on_equip = func(player, index, stack)

#### on_unequip

	on_unequip = func(player, index, stack)

#### on_destroy 

	on_destroy = func(player, index, stack)

#### on_damage

	on_damage = func(player, index, stack)

#### on_punched

	on_punched = func(player, hitter, time_from_last_punch, tool_capabilities)

`on_punched` is called every time a player is punched or takes damage, `hitter`, `time_from_last_punch` and `tool_capabilities` can be `nil` and will be in the case of fall damage.  
When fire protection is enabled, hitter == "fire" in the event of fire damage.    


### Global Callbacks

#### armor register_on_update

	armor:register_on_update(function(player))

#### armor register_on_equip

	armor:register_on_equip(function(player, index, stack))

#### armor register_on_unequip

	armor:register_on_unequip(function(player, index, stack))

#### armor register_on_destroy
armor:register_on_destroy(function(player, index, stack))

 **Example**

	armor:register_on_update(function(player)
		print(player:get_player_name().." armor updated!")
	end)


# Credits
 
### The below have added too, tested or in other ways contributed to the development and ongoing support of 3d_Armor

|Stu              |Stujones11       |Stu              |Github Ghosts    |
|:---------------:|:---------------:|:---------------:|:---------------:|
|Pavel_S          |BlockMen         |Tenplus1         |donat-b          |
|JPRuehmann       |BrandonReese     |Megaf            |Zeg9             |
|poet.nohit       |Echoes91         |Adimgar          |Khonkhortisan    |
|VanessaE         |CraigyDavi       |proller          |Thomasrudin      |
|Byakuren         |kilbith (jp)     |afflatus         |G1ov4            |
|Thomas-S         |Dragonop         |Napiophelios     |Emojigit         |
|rubenwardy       |daviddoesminetest|bell07           |OgelGames        |
|tobyplowy        |crazyginger72    |fireglow         |bhree            |
|Lone_Wolf(HT)    |Wuzzy(2)         |numberZero       |Monte48          |
|AntumDeluge      |Terumoc          |runsy            |Dacmot           |
|codexp           |davidthecreator  |SmallJoker       |orbea            |
|BuckarooBanzay   |daret            |Exeterdad        |Calinou          |
|Pilcrow182       |indriApollo      |HybridDog        |CraigyDavi       |
|Paly-2           |Diogogomes       |                 |                 |

*Note: Names gathered from 3d_armor forum thread and github, I may have missed some people, apologises if I have - S01*  
