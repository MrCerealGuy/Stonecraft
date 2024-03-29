1. [Technic](#technic)
	1. [Machines](#machines)
		1. [Machine details](#machine-details)
		2. [Overview](#overview)
		3. [Getting started](#getting-started)
		4. [Consumers](#consumers)
		5. [Generators](#generators)
	2. [Powered machines](#powered-machines)
		1. [Powered machine tiers](#powered-machine-tiers)
		2. [Tubes with powered machines](#tubes-with-powered-machines)
		3. [Battery boxes](#battery-boxes)
		4. [Processing machines](#processing-machines)
		5. [Music player](#music-player)
		6. [CNC machine](#cnc-machine)
		7. [Tool workshop](#tool-workshop)
		8. [Quarry](#quarry)
		9. [Forcefield emitter](#forcefield-emitter)
	3. [Power generators](#power-generators)
		1. [Fuel-fired generators](#fuel-fired-generators)
		2. [Solar generators](#solar-generators)
		3. [Hydro generator](#hydro-generator)
		4. [Geothermal generator](#geothermal-generator)
		5. [Wind generator](#wind-generator)
		6. [Nuclear generator](#nuclear-generator)
		7. [Administrative world anchor](#administrative-world-anchor)
	3. [Other machines](#other-machines)
		1. [Switching station](#switching-station)
		2. [LV/MV/HV Battery Box](#lvmvhv-battery-box)
		3. [Supply Converter](#supply-converter)
	4. [Resources](#resources)
		1. [Ore](#ore)
		2. [Rock](#rock)
		3. [Rubber](#rubber)
		4. [Metal](#metal)
		5. [Iron and its alloys](#iron-and-its-alloys)
		6. [Uranium enrichment](#uranium-enrichment)
		7. [Concrete](#concrete)
		8. [Latex](#latex)
	5. [Industrial processes](#industrial-processes)
		1. [Alloying](#)
		2. [Grinding, extracting, and compressing](#grinding-extracting-and-compressing)
		3. [Centrifuging](#centrifuging)
	6. [Radioactivity](#radioactivity)
	7. [Electrical power](#electrical-power)
	8. [Chests](#chests)
	9. [Tools](#tools)
		1. [Chainsaw](#chainsaw)
		2. [Flashlight](#flashlight)
		3. [Lava can](#lava-can)
		4. [Mining drill](#mining-drill)
		5. [Mining laser](#mining-laser)
		6. [Sonic screwdriver](#sonic-screwdriver)
		7. [Tree tap](#tree-tap)
		8. [Water can](#water-can)
		9. [Wrench](#wrench)
	10. [Digilines](#digilines)
		1. [Switching Station](#switching-station)
		2. [Supply Converter](#supply-converter)
		3. [Battery Boxes](#battery-boxes)
		4. [Forcefield Emitter](#forcefield-emitter)
		5. [Nuclear Reactor Remote Control](#nuclear-reactor-remote-control)
	11. [Reactors](#reactors)
		1. [Nuclear Reactor](#nuclear-reactor)
	12. [Geothermal EU generator](#geothermal-eu-generator)
	13. [Solar array](#solar-array)
	14. [Solar panel](#solar-panel)
	15. [Watermill](#watermill)

# Technic

Become an engineer in Stonecraft! From simple water-wheel ore proccessing centers, to massive nuclear-powered force-field networks!

![](/doc/github-wiki/images/Technic_Screenshot.png)

* ![](/doc/github-wiki/images/technic_mv_alloy_furnace_front.png) [Machines](#machines)
* ![](/doc/github-wiki/images/technic_mv_compressor_front.png) [Consumers](#consumers)
* ![](/doc/github-wiki/images/technic_hv_generator_front.png) [Generators](#generators)
* ![](/doc/github-wiki/images/technic_mithril_chest_front.png) [Chests](#chests)
* ![](/doc/github-wiki/images/technic_uranium_ingot.png) [Resources](#resources)
* ![](/doc/github-wiki/images/technic_mining_laser_mk3.png) [Tools](#tools)

## Machines

### Machine details

* [Generators](#generators)
* [Consumers](#consumers)
* [Other machines](#other-machines)

### Overview

Many of the important machines in Technic run on electricity, using wires to connect generators with the consuming machines. These electric circuits consist of a generator, a consumer, wiring, and a switching station. Every independent circuit requires all 4 of these elements to function. In general the machines are all connected on the bottom by wire. Machines should be placed first and then the wire placed under and around them. The wiring should automatically adjust itself to connect to each machine and adjacent wires. If the wiring looks incorrect, it's likely that it won't work so be sure to check this!

Circuits are also grouped into 3 different categories based on how much power they transfer and the corresponding voltage: low voltage (LV), medium voltage (MV), and high voltage (HV). The base level for all electronics is low voltage, so if voltage isn't specified for a electrical component, you may safely assume it's low voltage. Most low-voltage components are upgradable to medium- and high-voltage through further crafting. To get started, you won't need to worry about any MV or HV components, and the basic low-voltage components are fine.

### Getting started

The first step to working with the more advanced machines are to get a basic electrical circuit set up for converting coal into power for other machines. This will rely on the following:

![](/doc/github-wiki/images/LV_Fuel_Fired_Generator_Crafting.png)
1x LV Fuel Fired Generator

![](/doc/github-wiki/images/Switching_station_crafting.png)
1x Switching station

![](/doc/github-wiki/images/LV_cable_Crafting.png)
2x LV Cable

The generator and switching station should be placed side-by-side with the wire underneath connecting both of them. Once this is done, additional consumers can be added to the network. A grinder or extractor are both good choices to expand the capabilities of the coal-fired smelter and coal-fired alloy furnace that you already have.

### Consumers

Consumer is a machine which consume energy to do something.

This is the list of all consumers avaible in Technic:

* Alloy furnace
* MV Alloy furnace
* Grinder
* Electric Furnace
* MV - Electric Furnace
* Force field emitter
* CNC machine
* Power radiator
* Tool workshop

### Generators

This is list of all generators available in Technic:

* Coal generator 
* [Geothermal EU generator](#geothermal-eu-generator) 
* [Watermill](#watermill) 
* [Solar-panel](#solar-panel) 
* LV [solar-array](#solar-array) 
* MV [solar-array](#solar-array) 
* HV [solar-array](#solar-array) 

## Powered machines

### Powered machine tiers

Each powered machine takes its power in some specific form, being either fuel-fired (burning fuel directly) or electrically powered at some specific voltage. There is a general progression through the game from using fuel-fired machines to electrical machines, and to higher electrical voltages. The most important kinds of machine come in multiple variants that are powered in different ways, so the earlier ones can be superseded. However, some machines are only available for a specific power tier, so the tier can't be entirely superseded.

Powered machine upgrades

Some machines have inventory slots that are used to upgrade them in some way. Generally, machines of MV and HV tiers have two upgrade slots, and machines of lower tiers (fuel-fired and LV) do not. Any item can be placed in an upgrade slot, but only specific items will have any upgrading effect. It is possible to have multiple upgrades of the same type, but this can't be achieved by stacking more than one upgrade item in one slot: it is necessary to put the same kind of item in more than one upgrade slot. The ability to upgrade machines is therefore very limited. Two kinds of upgrade are currently possible: an energy upgrade and a tube upgrade.

An energy upgrade consists of a battery item, the same kind of battery that serves as a mobile energy store. The effect of an energy upgrade is to improve in some way the machine's use of electrical energy, most often by making it use less energy. The upgrade effect has no relation to energy stored in the battery: the battery's charge level is irrelevant and will not be affected.

A tube upgrade consists of a control logic unit item. The effect of a tube upgrade is to make the machine able, or more able, to eject items it has finished with into pneumatic tubes. The machines that can take this kind of upgrade are in any case capable of accepting inputs from pneumatic tubes. These upgrades are essential in using powered machines as components in larger automated systems.

### Tubes with powered machines

Generally, powered machines of MV and HV tiers can work with pneumatic tubes, and those of lower tiers cannot. (As an exception, the fuel-fired furnace from the basic Stonecraft game can accept inputs through tubes, but can't output into tubes.)

If a machine can accept inputs through tubes at all, then this is a capability of the basic machine, not requiring any upgrade. Most item-processing machines take only one kind of input, and in that case they will accept that input from any direction. This doesn't match how tubes visually connect to the machines: generally tubes will visually connect to any face except the front, but an item passing through a tube in front of the machine will actually be accepted into the machine.

A minority of machines take more than one kind of input, and in that case the input slot into which an arriving item goes is determined by the direction from which it arrives. In this case the machine may be picky about the direction of arriving items, associating each input type with a single face of the machine and not accepting inputs at all through the remaining faces. Again, the visual connection of tubes doesn't match: generally tubes will still visually connect to any face except the front, thus connecting to faces that neither accept inputs nor emit outputs.

Machines do not accept items from tubes into non-input inventory slots: the output slots or upgrade slots. Output slots are normally filled only by the processing operation of the machine, and upgrade slots must be filled manually.

Powered machines generally do not eject outputs into tubes without an upgrade. One tube upgrade will make them eject outputs at a slow rate; a second tube upgrade will increase the rate. Whether the slower rate is adequate depends on how it compares to the rate at which the machine produces outputs, and on how the machine is being used as part of a larger construct. The machine always ejects its outputs through a particular face, usually a side. Due to a bug, the side through which outputs are ejected is not consistent: when the machine is rotated one way, the direction of ejection is rotated the other way. This will probably be fixed some day, but because a straightforward fix would break half the machines already in use, the fix may be tied to some larger change such as free selection of the direction of ejection.

### Battery boxes

The primary purpose of battery boxes is to temporarily store electrical energy to let an electrical network cope with mismatched supply and demand. They have a secondary purpose of charging and discharging powered tools. They are thus a mixture of electrical infrastructure, powered machine, and generator. Battery boxes connect to cables only from the bottom.

MV and HV battery boxes have upgrade slots. Energy upgrades increase the capacity of a battery box, each by 10% of the un-upgraded capacity. This increase is far in excess of the capacity of the battery that forms the upgrade.

For charging and discharging of power tools, rather than having input and output slots, each battery box has a charging slot and a discharging slot. A fully charged/discharged item stays in its slot. The rates at which a battery box can charge and discharge increase with voltage, so it can be worth building a battery box of higher tier before one has other infrastructure of that tier, just to get access to faster charging.

MV and HV battery boxes work with pneumatic tubes. An item can be input to the charging slot through the sides or back of the battery box, or to the discharging slot through the top. With a tube upgrade, fully charged/discharged tools (as appropriate for their slot) will be ejected through a side.

### Processing machines
The furnace, alloy furnace, grinder, extractor, compressor, and centrifuge have much in common. Each implements some industrial process that transforms items into other items, and the manner in which they present these processes as powered machines is essentially identical.

Most of the processing machines operate on inputs of only a single type at a time, and correspondingly have only a single input slot. The alloy furnace is an exception: it operates on inputs of two distinct types at once, and correspondingly has two input slots. It doesn't matter which way round the alloy furnace's inputs are placed in the two slots.

The processing machines are mostly available in variants for multiple tiers. The furnace and alloy furnace are each available in fuel-fired, LV, and MV forms. The grinder, extractor, and compressor are each available in LV and MV forms. The centrifuge is the only single-tier processing machine, being only available in MV form. The higher-tier machines process items faster than the lower-tier ones, but also have higher power consumption, usually taking more energy overall to perform the same amount of processing. The MV machines have upgrade slots, and energy upgrades reduce their energy consumption.

The MV machines can work with pneumatic tubes. They accept inputs via tubes from any direction. For most of the machines, having only a single input slot, this is perfectly simple behavior. The alloy furnace is more complex: it will put an arriving item in either input slot, preferring to stack it with existing items of the same type. It doesn't matter which slot each of the alloy furnace's inputs is in, so it doesn't matter that there's no direct control over that, but there is a risk that supplying a lot of one item type through tubes will result in both slots containing the same type of item, leaving no room for the second input.

The MV machines can be given a tube upgrade to make them automatically eject output items into pneumatic tubes. The items are always ejected through a side, though which side it is depends on the machine's orientation, due to a bug. Output items are always ejected singly. For some machines, such as the grinder, the ejection rate with a single tube upgrade doesn't keep up with the rate at which items can be processed. A second tube upgrade increases the ejection rate.

The LV and fuel-fired machines do not work with pneumatic tubes, except that the fuel-fired furnace (actually part of the basic Stonecraft game) can accept inputs from tubes. Items arriving through the bottom of the furnace go into the fuel slot, and items arriving from all other directions go into the input slot.

### Music player

The music player is an LV powered machine that plays audio recordings. It offers a selection of up to nine tracks. Technic doesn't include specific music tracks for this purpose; they have to be installed separately.

The music player gives the impression that the music is being played in the Stonecraft world. The music only plays as long as the music player is in place and is receiving electrical power, and the choice of music is controlled by interaction with the machine. The sound also appears to emanate specifically from the music player: the ability to hear it depends on the player's distance from the music player. However, the game engine doesn't currently support any other positional cues for sound, such as attenuation, panning, or HRTF. The impression of the sound being located in the Stonecraft world is also compromised by the subjective nature of track choice: the specific music that is played to a player depends on what media the player has installed.

### CNC machine

The CNC machine is an LV powered machine that cuts building blocks into a variety of sub-block shapes that are not covered by the crafting recipes of the stairs mod and its variants. Most of the target shapes are not rectilinear, involving diagonal or curved surfaces.

Only certain kinds of building material can be processed in the CNC machine.

### Tool workshop

The tool workshop is an MV powered machine that repairs mechanically-worn tools, such as pickaxes and the other ordinary digging tools. It has a single slot for a tool to be repaired, and gradually repairs the tool while it is powered. For any single tool, equal amounts of tool wear, resulting from equal amounts of tool use, take equal amounts of repair effort. Also, all repairable tools currently take equal effort to repair equal percentages of wear. The amount of tool use enabled by equal amounts of repair therefore depends on the tool type.

The mechanical wear that the tool workshop repairs is always indicated in inventory displays by a colored bar overlaid on the tool image. The bar can be seen to fill and change color as the tool workshop operates, eventually disappearing when the repair is complete. However, not every item that shows such a wear bar is using it to show mechanical wear. A wear bar can also be used to indicate charging of a power tool with stored electrical energy, or filling of a container, or potentially for all sorts of other uses. The tool workshop won't affect items that use wear bars to indicate anything other than mechanical wear.

The tool workshop has upgrade slots. Energy upgrades reduce its power consumption.

It can work with pneumatic tubes. Tools to be repaired are accepted via tubes from any direction. With a tube upgrade, the tool workshop will also eject fully-repaired tools via one side, the choice of side depending on the machine's orientation, as for processing machines. It is safe to put into the tool workshop a tool that is already fully repaired: assuming the presence of a tube upgrade, the tool will be quickly ejected. Furthermore, any item of unrepairable type will also be ejected as if fully repaired.

### Quarry

The quarry is an HV powered machine that automatically digs out a large area. The region that it digs out is a cuboid with a square horizontal cross section, located immediately behind the quarry machine. The quarry's action is slow and energy-intensive, but requires little player effort.

The size of the quarry's horizontal cross section is configurable through the machine's interaction form. A setting referred to as "radius" is an integer number of meters which can vary from 2 to 8 inclusive. The horizontal cross section is a square with side length of twice the radius plus one meter, thus varying from 5 to 17 inclusive. Vertically, the quarry always digs from 3 m above the machine to 100 m below it, inclusive, a total vertical height of 104 m.

Whatever the quarry digs up is ejected through the top of the machine, as if from a pneumatic tube. Normally a tube should be placed there to convey the material into a sorting system, processing machines, or at least chests. A chest may be placed directly above the machine to capture the output without sorting, but is liable to overflow.

If the quarry encounters something that cannot be dug, such as a liquid, a locked chest, or a protected area, it will skip past that and attempt to continue digging. However, anything remaining in the quarry area after the machine has attempted to dig there will prevent the machine from digging anything directly below it, all the way to the bottom of the quarry. An undiggable block therefore casts a shadow of undug blocks below it. If liquid is encountered, it is quite likely to flow across the entire cross section of the quarry, preventing all digging. The depth at which the quarry is currently attempting to dig is reported in its interaction form, and can be manually reset to the top of the quarry, which is useful to do if an undiggable obstruction has been manually removed.

The quarry consumes 10 kEU per block dug, which is quite a lot of energy. With most of what is dug being mere stone, it is usually not economically favorable to power a quarry from anything other than solar power. In particular, one cannot expect to power a quarry by burning the coal that it digs up.

Given sufficient power, the quarry digs at a rate of one block per second. This is rather tedious to wait for. Unfortunately, leaving the quarry unattended normally means that the Stonecraft server won't keep the machine running: it needs a player nearby. This can be resolved by using a world anchor. The digging is still quite slow, and independently of whether a world anchor is used the digging can be speeded up by placing multiple quarry machines with overlapping digging areas. Four can be placed to dig identical areas, one on each side of the square cross section.

### Forcefield emitter

The forcefield emitter is an HV powered machine that generates a forcefield remeniscent of those seen in many science-fiction stories.

The emitter can be configured to generate a forcefield of either spherical or cubical shape, in either case centered on the emitter. The size of the forcefield is configured using a radius parameter that is an integer number of meters which can vary from 5 to 20 inclusive. For a spherical forcefield this is simply the radius of the forcefield; for a cubical forcefield it is the distance from the emitter to the center of each square face.

The power drawn by the emitter is proportional to the surface area of the forcefield being generated. A spherical forcefield is therefore the cheapest way to enclose a specified volume of space with a forcefield, if the shape of the space doesn't matter. A cubical forcefield is less efficient at enclosing volume, but is cheaper than the larger spherical forcefield that would be required if it is necessary to enclose a cubical space.

The emitter is normally controlled merely through its interaction form, which has an enable/disable toggle. However, it can also (via the form) be placed in a mesecon-controlled mode. If mesecon control is enabled, the emitter must be receiving a mesecon signal in addition to being manually enabled, in order for it to generate the forcefield.

The forcefield itself behaves largely as if solid, despite being immaterial: it cannot be traversed, and prevents access to blocks behind it. It is transparent, but not totally invisible. It cannot be dug. Some effects can pass through it, however, such as the beam of a mining laser, and explosions. In fact, explosions as currently implemented by the tnt mod actually temporarily destroy the forcefield itself; the tnt mod assumes too much about the regularity of node types.

The forcefield occupies space that would otherwise have been air, but does not replace or otherwise interfere with materials that are solid, liquid, or otherwise not just air. If such an object blocking the forcefield is removed, the forcefield will quickly extend into the now-available space, but it does not do so instantly: there is a brief moment when the space is air and can be traversed.

It is possible to have a doorway in a forcefield, by placing in advance, in space that the forcefield would otherwise occupy, some non-air blocks that can be walked through. For example, a door suffices, and can be opened and closed while the forcefield is in place.

## Power generators

### Fuel-fired generators

The fuel-fired generators are electrical power generators that generate power by the combustion of fuel. Versions of them are available for all three voltages (LV, MV, and HV). These are all capable of burning any type of combustible fuel, such as coal. They are relatively easy to build, and so tend to be the first kind of generator used to power electrical machines. In this role they form an intermediate step between the directly fuel-fired machines and a more mature electrical network powered by means other than fuel combustion. They are also, by virtue of simplicity and controllability, a useful fallback or peak load generator for electrical networks that normally use more sophisticated generators.

The MV and HV fuel-fired generators can accept fuel via pneumatic tube, from any direction.

Keeping a fuel-fired generator fully fuelled is usually wasteful, because it will burn fuel as long as it has any, even if there is no demand for the electrical power that it generates. This is unlike the directly fuel-fired machines, which only burn fuel when they have work to do. To satisfy intermittent demand without waste, a fuel-fired generator must only be given fuel when there is either demand for the energy or at least sufficient battery capacity on the network to soak up the excess energy.

The higher-tier fuel-fired generators get much more energy out of a fuel item than the lower-tier ones. The difference is much more than is needed to overcome the inefficiency of supply converters, so it is worth operating fuel-fired generators at a higher tier than the machines being powered.

### Solar generators
The solar generators are electrical power generators that generate power from sunlight. Versions of them are available for all three voltages (LV, MV, and HV). There are four types in total, two LV and one each of MV and HV, forming a sequence of four tiers. The higher-tier ones are each built mainly from three solar generators of the next tier down, and their outputs scale in rough accordance, tripling at each tier.

To operate, an arrayed solar generator must be at elevation +1 or above and have a transparent block (typically air) immediately above it. It will generate power only when the block above is well lit during daylight hours. It will generate more power at higher elevation, reaching maximum output at elevation +36 or higher when sunlit. The small solar generator has similar rules with slightly different thresholds. These rules are an attempt to ensure that the generator will only operate from sunlight, but it is actually possible to fool them to some extent with light sources such as meselamps.

### Hydro generator

The hydro generator is an LV power generator that generates a respectable amount of power from the natural motion of water. To operate, the generator must be horizontally adjacent to flowing water. The power produced is dependent on how much flow there is across any or all four sides, the most flow of course coming from water that's flowing straight down.

### Geothermal generator

The geothermal generator is an LV power generator that generates a small amount of power from the temperature difference between lava and water. To operate, the generator must be horizontally adjacent to both lava and water. It doesn't matter whether the liquids consist of source blocks or flowing blocks.

Beware that if lava and water blocks are adjacent to each other then the lava will be solidified into stone or obsidian. If the lava adjacent to the generator is thus destroyed, the generator will stop producing power. Currently, in the default Stonecraft game, lava is destroyed even if it is only diagonally adjacent to water. Under these circumstances, the only way to operate the geothermal generator is with it adjacent to one lava block and one water block, which are on opposite sides of the generator. If diagonal adjacency doesn't destroy lava, such as with the gloopblocks mod, then it is possible to have more than one lava or water block adjacent to the geothermal generator. This increases the generator's output, with the maximum output achieved with two adjacent blocks of each liquid.

### Wind generator

The wind generator is an MV power generator that generates a moderate amount of energy from wind. To operate, the generator must be placed atop a column of at least 20 wind mill frame blocks, and must be at an elevation of +30 or higher. It generates more at higher elevation, reaching maximum output at elevation +50 or higher. Its surroundings don't otherwise matter; it doesn't actually need to be in open air.

### Nuclear generator

The nuclear generator (nuclear reactor) is an HV power generator that generates a large amount of energy from the controlled fission of uranium-235. It must be fuelled, with uranium fuel rods, but consumes the fuel quite slowly in relation to the rate at which it is likely to be mined. The operation of a nuclear reactor poses radiological hazards to which some thought must be given. Economically, the use of nuclear power requires a high capital investment, and a secure infrastructure, but rewards the investment well.

Nuclear fuel is made from uranium. Natural uranium doesn't have a sufficiently high proportion of U-235, so it must first be enriched via centrifuge. Producing one unit of 3.5%-fissile uranium requires the input of five units of 0.7%-fissile (natural) uranium, and produces four units of 0.0%-fissile (fully depleted) uranium as a byproduct. It takes five ingots of 3.5%-fissile uranium to make each fuel rod, and six rods to fuel a reactor. It thus takes the input of the equivalent of 150 ingots of natural uranium, which can be obtained from the mining of 75 blocks of uranium ore, to make a full set of reactor fuel.

The nuclear reactor is a large multi-block structure. Only one block in the structure, the reactor core, is of a type that is truly specific to the reactor; the rest of the structure consists of blocks that have mainly non-nuclear uses. The reactor core is where all the generator-specific action happens: it is where the fuel rods are inserted, and where the power cable must connect to draw off the generated power.

The reactor structure consists of concentric layers, each a cubical shell, around the core. Immediately around the core is a layer of water, representing the reactor coolant; water blocks may be either source blocks or flowing blocks. Around that is a layer of stainless steel blocks, representing the reactor pressure vessel, and around that a layer of blast-resistant concrete blocks, representing a containment structure. It is customary, though no longer mandatory, to surround this with a layer of ordinary concrete blocks. The mandatory reactor structure makes a 7×7×7 cube, and the full customary structure a 9×9×9 cube.

The layers surrounding the core don't have to be absolutely complete. Indeed, if they were complete, it would be impossible to cable the core to a power network. The cable makes it necessary to have at least one block missing from each surrounding layer. The water layer is only permitted to have one water block missing of the 26 possible. The steel layer may have up to two blocks missing of the 98 possible, and the blast-resistant concrete layer may have up to two blocks missing of the 218 possible. Thus it is possible to have not only a cable duct, but also a separate inspection hole through the solid layers. The separate inspection hole is of limited use: the cable duct can serve double duty.

Once running, the reactor core is significantly radioactive. The layers of reactor structure provide quite a lot of shielding, but not enough to make the reactor safe to be around, in two respects. Firstly, the shortest possible path from the core to a player outside the reactor is sufficiently short, and has sufficiently little shielding material, that it will damage the player. This only affects a player who is extremely close to the reactor, and close to a face rather than a vertex. The customary additional layer of ordinary concrete around the reactor adds sufficient distance and shielding to negate this risk, but it can also be addressed by just keeping extra distance (a little over two meters of air).

The second radiological hazard of a running reactor arises from shine paths; that is, specific paths from the core that lack sufficient shielding. The necessary cable duct, if straight, forms a perfect shine path, because the cable itself has no radiation shielding effect. Any secondary inspection hole also makes a shine path, along which the only shielding material is the water of the reactor coolant. The shine path aspect of the cable duct can be ameliorated by adding a kink in the cable, but this still yields paths with reduced shielding. Ultimately, shine paths must be managed either with specific shielding outside the mandatory structure, or with additional no-go areas.

The radioactivity of an operating reactor core makes starting up a reactor hazardous, and can come as a surprise because the non-operating core isn't radioactive at all. The radioactive damage is survivable, but it is normally preferable to avoid it by some care around the startup sequence. To start up, the reactor must have a full set of fuel inserted, have all the mandatory structure around it, and be cabled to a switching station. Only the fuel insertion requires direct access to the core, so irradiation of the player can be avoided by making one of the other two criteria be the last one satisfied. Completing the cabling to a switching station is the easiest to do from a safe distance.

Once running, the reactor will generate 100 kEU/s for a week (168 hours, 604800 seconds), a total of 6.048 GEU from one set of fuel. After the week is up, it will stop generating and no longer be radioactive. It can then be refuelled to run for another week. It is not really intended to be possible to pause a running reactor, but actually disconnecting it from a switching station will have the effect of pausing the week. This will probably change in the future. A paused reactor is still radioactive, just not generating electrical power.

A running reactor can't be safely dismantled, and not only because dismantling the reactor implies removing the shielding that makes it safe to be close to the core. The mandatory parts of the reactor structure are not just mandatory in order to start the reactor; they're mandatory in order to keep it intact. If the structure around the core gets damaged, and remains damaged, the core will eventually melt down. How long there is before meltdown depends on the extent of the damage; if only one mandatory block is missing, meltdown will follow in 100 seconds. While the structure of a running reactor is in a damaged state, heading towards meltdown, a siren built into the reactor core will sound. If the structure is rectified, the siren will signal all-clear. If the siren stops sounding without signalling all-clear, then it was stopped by meltdown.

If meltdown is imminent because of damaged reactor structure, digging the reactor core is not a way to avert it. Digging the core of a running reactor causes instant meltdown. The only way to dismantle a reactor without causing meltdown is to start by waiting for it to finish the week-long burning of its current set of fuel. Once a reactor is no longer operating, it can be dismantled by ordinary means, with no special risks.

Meltdown, if it occurs, destroys the reactor and poses a major environmental hazard. The reactor core melts, becoming a hot, highly radioactive liquid known as "corium". A single meltdown yields a single corium source block, where the core used to be. Corium flows, and the flowing corium is very destructive to whatever it comes into contact with. Flowing corium also randomly solidifies into a radioactive solid called "Chernobylite". The random solidification and random destruction of solid blocks means that the flow of corium is constantly changing. This combined with the severe radioactivity makes corium much more challenging to deal with than lava. If a meltdown is left to its own devices, it gets worse over time, as the corium works its way through the reactor structure and starts to flow over a variety of paths. It is best to tackle a meltdown quickly; the priority is to extinguish the corium source block, normally by dropping gravel into it. Only the most motivated should attempt to pick up the corium in a bucket.

### Administrative world anchor

A world anchor is an object in the Stonecraft world that causes the server to keep surrounding parts of the world running even when no players are nearby. It is mainly used to allow machines to run unattended: normally machines are suspended when not near a player. Technic supplies a form of world anchor, as a placable block, but it is not straightforwardly available to players. There is no recipe for it, so it is only available if explicitly spawned into existence by someone with administrative privileges. In a single-player world, the single player normally has administrative privileges, and can obtain a world anchor by entering the chat command "/give singleplayer technic:admin_anchor".

The world anchor tries to force a cubical area, centered upon the anchor, to stay loaded. The distance from the anchor to the most distant map nodes that it will keep loaded is referred to as the "radius", and can be set in the world anchor's interaction form. The radius can be set as low as 0, meaning that the anchor only tries to keep itself loaded, or as high as 255, meaning that it will operate on a 511×511×511 cube. Larger radii are forbidden, to avoid typos causing the server excessive work; to keep a larger area loaded, use multiple anchors. Also use multiple anchors if the area to be kept loaded is not well approximated by a cube.

The world is always kept loaded in units of 16×16×16 cubes, confusingly known as "map blocks". The anchor's configured radius takes no account of map block boundaries, but the anchor's effect is actually to keep loaded each map block that contains any part of the configured cube. The anchor's interaction form includes a status note showing how many map blocks this is, and how many of those it is successfully keeping loaded. When the anchor is disabled, as it is upon placement, it will always show that it is keeping no map blocks loaded; this does not indicate any kind of failure.

The world anchor can optionally be locked. When it is locked, only the anchor's owner, the player who placed it, can reconfigure it or remove it. Only the owner can lock it. Locking an anchor is useful if the use of anchors is being tightly controlled by administrators: an administrator can set up a locked anchor and be sure that it will not be set by ordinary players to an unapproved configuration.

The server limits the ability of world anchors to keep parts of the world loaded, to avoid overloading the server. The total number of map blocks that can be kept loaded in this way is set by the server configuration item "max_forceloaded_blocks" (in stonecraft.conf), which defaults to only 16. For comparison, each player normally keeps 125 map blocks loaded (a radius of 32). If an enabled world anchor shows that it is failing to keep all the map blocks loaded that it would like to, this can be fixed by increasing max_forceloaded_blocks by the amount of the shortfall.

The tight limit on force-loading is the reason why the world anchor is not directly available to players. With the limit so low both by default and in common practice, the only feasible way to determine where world anchors should be used is for administrators to decide it directly.

## Other machines

Some machines in Technic can not be classified as producers or consumers.

This is a list of this machines:

* Switching station 
* LV Battery Box 
* MV Battery Box 
* HV Battery Box 
* Constructor 
* Deployer 
* Node Breaker 
* Supply Converter 

### Switching Station

The Switching station is the most important part of any network, since without a switching station, no machine will operate!

### LV/MV/HV Battery Box

These peculiar machines can both generate *and* consume, depending on what's needed. Do note that higher tier machines will charge tools faster!

### Supply Converter

The Supply Converter can convert one voltage to the next highest or lowest. It will pull a load of 10,000 EU, but will waste it if the other side is unable to accept it. The top is the input voltage, and the bottom is the output. Both sides will require their own switching station!

## Resources

Technic provides additional resources for building these machines.

### Ore

Technic makes extensive use of not just the default ores but also some that are added by mods. You will need to mine for all the ore types in the course of the game. Each ore type is found at a specific range of elevations, and while the ranges mostly overlap, some have non-overlapping ranges, so you will ultimately need to mine at more than one elevation to find all the ores. Also, because one of the best elevations to mine at is very deep, you will be unable to mine there early in the game.

Elevation is measured in meters, relative to a reference plane that is not quite sea level. (The standard sea level is at an elevation of about +1.4.) Positive elevations are above the reference plane and negative elevations below. Because elevations are always described this way round, greater numbers when higher, we avoid the word "depth".

The ores that matter in Technic are coal, iron, copper, tin, zinc, chromium, uranium, silver, gold, mithril, mese, and diamond.

Coal is found from elevation +64 downwards, so is available right on the surface at the start of the game, but it is far less abundant above elevation 0 than below. It is initially used as a fuel, driving important machines in the early part of the game. It becomes less important as a fuel once most of your machines are electrically powered, but burning fuel remains a way to generate electrical power. Coal is also used, usually in dust form, as an ingredient in alloying recipes, wherever elemental carbon is required.

Iron is found from elevation +2 downwards, and its abundance increases in stages as one descends, reaching its maximum from elevation -64 downwards. It is a common metal, used frequently as a structural component. In Technic, unlike the basic game, iron is used in multiple forms, mainly alloys based on iron and including carbon (coal).

Copper is found from elevation -16 downwards, but is more abundant from elevation -64 downwards. It is a common metal, used either on its own for its electrical conductivity, or as the base component of alloys. Although common, it is very heavily used, and most of the time it will be the material that most limits your activity.

Tin is found from elevation +8 downwards, with no elevation-dependent variations in abundance beyond that point.
It is a common metal. Its main use in pure form is as a component of electrical batteries. Apart from that its main purpose is as the secondary ingredient in bronze (the base being copper), but bronze is itself little used. Its abundance is well in excess of its usage, so you will usually have a surplus of it.

Zinc is supplied by Technic. It is found from elevation +2 downwards, with no elevation-dependent variations in abundance beyond that point. It is a common metal. Its main use is as the secondary ingredient in brass (the base being copper), but brass is itself little used. Its abundance is well in excess of its usage, so you will usually have a surplus of it.

Chromium is supplied by Technic. It is found from elevation -100 downwards, with no elevation-dependent variations in abundance beyond that point. It is a moderately common metal. Its main use is as the secondary ingredient in stainless steel (the base being iron).

Uranium is supplied by Technic. It is found only from elevation -80 down to -300; using it therefore requires one to mine above elevation -300 even though deeper mining is otherwise more productive. It is a moderately common metal, useful only for reasons related to radioactivity: it forms the fuel for nuclear reactors, and is also one of the best radiation shielding materials available. It is not difficult to find enough uranium ore to satisfy these uses. Beware that the ore is slightly radioactive: it will slightly harm you if you stand as close as possible to it. It is safe when more than a meter away or when mined.

Silver is found from elevation -2 downwards, with no elevation-dependent variations in abundance beyond that point. It is a semi-precious metal. It is little used, being most notably used in electrical items due to its conductivity, being the best conductor of all the pure elements.

Gold is found from elevation -64 downwards, but is more abundant from elevation -256 downwards. It is a precious metal. It is little used, being most notably used in electrical items due to its combination of good conductivity (third best of all the pure elements) and corrosion resistance.

Mithril is found from elevation -512 downwards, the deepest ceiling of any minable substance, with no elevation-dependent variations in abundance beyond that point. It is a rare precious metal, and unlike all the other metals described here it is entirely fictional, being derived from J. R. R. Tolkien's Middle-Earth setting. It is little used.

Mese is found from elevation -64 downwards. The ore is more abundant from elevation -256 downwards, and from elevation -1024 downwards there are also occasional blocks of solid mese (each yielding as much mese as nine blocks of ore). It is a precious gemstone, and unlike diamond it is entirely fictional. It is used in many recipes, though mainly not in large quantities, wherever some magical quality needs to be imparted.

Diamond is found from elevation -128 downwards, but is more abundant from elevation -256 downwards. It is a precious gemstone. It is used moderately, mainly for reasons connected to its extreme hardness.

### Rock

In addition to the ores, there are multiple kinds of rock that need to be mined in their own right, rather than for minerals. The rock types that matter in Technic are standard stone, desert stone, marble, and granite.

Standard stone is extremely common. As in the basic game, when dug it yields cobblestone, which can be cooked to turn it back into standard stone. Cobblestone is used in recipes only for some relatively primitive machines. Standard stone is used in a couple of machine recipes. These rock types gain additional significance with Technic because the grinder can be used to turn them into dirt and sand. This, especially when combined with an automated cobblestone generator, can be an easier way to acquire sand than collecting it where it occurs naturally.

Desert stone is found specifically in desert biomes, and only from elevation +2 upwards. Although it is easily accessible, therefore, its quantity is ultimately quite limited. It is used in a few recipes.

Marble is supplied by Technic. It is found in dense clusters from elevation -50 downwards. It has mainly decorative use, but also appears in one machine recipe.

Granite is supplied by Technic. It is found in dense clusters from elevation -150 downwards. It is much harder to dig than standard stone, so impedes mining when it is encountered. It has mainly decorative use, but also appears in a couple of machine recipes.

### Rubber

Rubber is a biologically-derived material that has industrial uses due to its electrical resistivity and its impermeability. In Technic, it is used in a few recipes, and it must be acquired by tapping rubber trees.

If you have 'More trees' enabled, the rubber trees you need are those defined by that mod. If not, Technic supplies a copy of the 'More trees' rubber tree.

Extracting rubber requires a specific tool, a tree tap. Using the tree tap (by left-clicking) on a rubber tree trunk block extracts a lump of raw latex from the trunk. Each trunk block can be repeatedly tapped for latex, at intervals of several minutes; its appearance changes to show whether it is currently ripe for tapping. Each tree has several trunk blocks, so several latex lumps can be extracted from a tree in one visit.

Raw latex isn't used directly. It must be vulcanized to produce finished rubber. This can be performed by alloying the latex with coal dust.

### Metal

Many of the substances important in Technic are metals, and there is a common pattern in how metals are handled. Generally, each metal can exist in five forms: ore, lump, dust, ingot, and block. With a couple of tricky exceptions in mods outside Technic, metals are only used in dust, ingot, and block forms. Metals can be readily converted between these three forms, but can't be converted from them back to ore or lump forms.

As in the basic Stonecraft game, a "lump" of metal is acquired directly by digging ore, and will then be processed into some other form for use. A lump is thus more akin to ore than to refined metal. (In real life, metal ore rarely yields lumps ("nuggets") of pure metal directly. More often the desired metal is chemically bound into the rock as an oxide or some other compound, and the ore must be chemically processed to yield pure metal.)

Not all metals occur directly as ore. Generally, elemental metals (those consisting of a single chemical element) occur as ore, and alloys (those consisting of a mixture of multiple elements) do not. In fact, if the fictional mithril is taken to be elemental, this pattern is currently followed perfectly. (It is not clear in the Middle-Earth setting whether mithril is elemental or an alloy.) This might change in the future: in real life some alloys do occur as ore, and some elemental metals rarely occur naturally outside such alloys. Metals that do not occur as ore also lack the "lump" form.

The basic Stonecraft game offers a single way to refine metals: cook a lump in a furnace to produce an ingot. With Technic this refinement method still exists, but is rarely used outside the early part of the game, because Technic offers a more efficient method once some machines have been built. The grinder, available only in electrically-powered forms, can grind a metal lump into two piles of metal dust. Each dust pile can then be cooked into an ingot, yielding two ingots from one lump. This doubling of material value means that you should only cook a lump directly when you have no choice, mainly early in the game when you haven't yet built a grinder.

An ingot can also be ground back to (one pile of) dust. Thus it is always possible to convert metal between ingot and dust forms, at the expense of some energy consumption. Nine ingots of a metal can be crafted into a block, which can be used for building. The block can also be crafted back to nine ingots. Thus it is possible to freely convert metal between ingot and block forms, which is convenient to store the metal compactly. Every metal has dust, ingot, and block forms.

Alloying recipes in which a metal is the base ingredient, to produce a metal alloy, always come in two forms, using the metal either as dust or as an ingot. If the secondary ingredient is also a metal, it must be supplied in the same form as the base ingredient. The output alloy is also returned in the same form. For example, brass can be produced by alloying two copper ingots with one zinc ingot to make three brass ingots, or by alloying two piles of copper dust with one pile of zinc dust to make three piles of brass dust. The two ways of alloying produce equivalent results.

### Iron and its alloys

Iron forms several important alloys. In real-life history, iron was the second metal to be used as the base component of deliberately-constructed alloys (the first was copper), and it was the first metal whose working required processes of any metallurgical sophistication. The game mechanics around iron broadly imitate the historical progression of processes around it, rather than the less-varied modern processes.

The two-component alloying system of iron with carbon is of huge importance, both in the game and in real life. The basic Stonecraft game doesn't distinguish between these pure iron and these alloys at all, but Technic introduces a distinction based on the carbon content, and renames some items of the basic game accordingly.

The iron/carbon spectrum is represented in the game by three metal substances: wrought iron, carbon steel, and cast iron. Wrought iron has low carbon content (less than 0.25%), resists shattering, and is easily welded, but is relatively soft and susceptible to rusting. In real-life history it was used for rails, gates, chains, wire, pipes, fasteners, and other purposes. Cast iron has high carbon content (2.1% to 4%), is especially hard, and resists corrosion, but is relatively brittle, and difficult to work. Historically it was used to build large structures such as bridges, and for cannons, cookware, and engine cylinders. Carbon steel has medium carbon content (0.25% to 2.1%), and intermediate properties: moderately hard and also tough, somewhat resistant to corrosion. In real life it is now used for most of the purposes previously satisfied by wrought iron and many of those of cast iron, but has historically been especially important for its use in swords, armor, skyscrapers, large bridges, and machines.

In real-life history, the first form of iron to be refined was wrought iron, which is nearly pure iron, having low carbon content. It was produced from ore by a low-temperature furnace process (the "bloomery") in which the ore/iron remains solid and impurities (slag) are progressively removed by hammering ("working", hence "wrought"). This began in the middle East, around 1800 BCE.

Historically, the next forms of iron to be refined were those of high carbon content. This was the result of the development of a more sophisticated kind of furnace, the blast furnace, capable of reaching higher temperatures. The real advantage of the blast furnace is that it melts the metal, allowing it to be cast straight into a shape supplied by a mould, rather than having to be gradually beaten into the desired shape. A side effect of the blast furnace is that carbon from the furnace's fuel is unavoidably incorporated into the metal. Normally iron is processed twice through the blast furnace: once producing "pig iron", which has very high carbon content and lots of impurities but lower melting point, casting it into rough ingots, then remelting the pig iron and casting it into the final moulds. The result is called "cast iron". Pig iron was first produced in China around 1200 BCE, and cast iron later in the 5th century BCE. Incidentally, the Chinese did not have the bloomery process, so this was their first iron refining process, and, unlike the rest of the world, their first wrought iron was made from pig iron rather than directly from ore.

Carbon steel, with intermediate carbon content, was developed much later, in Europe in the 17th century CE. It required a more sophisticated process, because the blast furnace made it extremely difficult to achieve a controlled carbon content. Tweaks of the blast furnace would sometimes produce an intermediate carbon content by luck, but the first processes to reliably produce steel were based on removing almost all the carbon from pig iron and then explicitly mixing a controlled amount of carbon back in.

In the game, the bloomery process is represented by ordinary cooking or grinding of an iron lump. The lump represents unprocessed ore, and is identified only as "iron", not specifically as wrought iron. This standard refining process produces dust or an ingot which is specifically identified as wrought iron. Thus the standard refining process produces the (nearly) pure metal.

Cast iron is trickier. You might expect from the real-life notes above that cooking an iron lump (representing ore) would produce pig iron that can then be cooked again to produce cast iron. This is kind of the case, but not exactly, because as already noted cooking an iron lump produces wrought iron. The game doesn't distinguish between low-temperature and high-temperature cooking processes: the same furnace is used not just to cast all kinds of metal but also to cook food. So there is no distinction between cooking processes to produce distinct wrought iron and pig iron. But repeated cooking is available as a game mechanic, and is indeed used to produce cast iron: re-cooking a wrought iron ingot produces a cast iron ingot. So pig iron isn't represented in the game as a distinct item; instead wrought iron stands in for pig iron in addition to its realistic uses as wrought iron.

Carbon steel is produced by a more regular in-game process: alloying wrought iron with coal dust (which is essentially carbon). This bears a fair resemblance to the historical development of carbon steel. This alloying recipe is relatively time-consuming for the amount of material processed, when compared against other alloying recipes, and carbon steel is heavily used, so it is wise to alloy it in advance, when you're not waiting for it.

There are additional recipes that permit all three of these types of iron to be converted into each other. Alloying carbon steel again with coal dust produces cast iron, with its higher carbon content. Cooking carbon steel or cast iron produces wrought iron, in an abbreviated form of the bloomery process.

There's one more iron alloy in the game: stainless steel. It is managed in a completely regular manner, created by alloying carbon steel with chromium.

### Uranium enrichment

When uranium is to be used to fuel a nuclear reactor, it is not sufficient to merely isolate and refine uranium metal. It is necessary to control its isotopic composition, because the different isotopes behave differently in nuclear processes.

The main isotopes of interest are U-235 and U-238. U-235 is good at sustaining a nuclear chain reaction, because when a U-235 nucleus is bombarded with a neutron it will usually fission (split) into fragments. It is therefore described as "fissile". U-238, on the other hand, is not fissile: if bombarded with a neutron it will usually capture it, becoming U-239, which is very unstable and quickly decays into semi-stable (and fissile) plutonium-239.

Inconveniently, the fissile U-235 makes up only about 0.7% of natural uranium, almost all of the other 99.3% being U-238. Natural uranium therefore doesn't make a great nuclear fuel. (In real life there are a small number of reactor types that can use it, but Technic doesn't have such a reactor.) Better nuclear fuel needs to contain a higher proportion of U-235.

Achieving a higher U-235 content isn't as simple as separating the U-235 from the U-238 and just using the required amount of U-235. Because U-235 and U-238 are both uranium, and therefore chemically identical, they cannot be chemically separated, in the way that different elements are separated from each other when refining metal. They do differ in atomic mass, so they can be separated by centrifuging, but because their atomic masses are very close, centrifuging doesn't separate them very well. They cannot be separated completely, but it is possible to produce uranium that has the isotopes mixed in different proportions. Uranium with a significantly larger fissile U-235 fraction than natural uranium is called "enriched", and that with a significantly lower fissile fraction is called "depleted".

A single pass through a centrifuge produces two output streams, one with a fractionally higher fissile proportion than the input, and one with a fractionally lower fissile proportion. To alter the fissile proportion by a significant amount, these output streams must be centrifuged again, repeatedly. The usual arrangement is a "cascade", a linear arrangement of many centrifuges. Each centrifuge takes as input uranium with some specific fissile proportion, and passes its two output streams to the two adjacent centrifuges. Natural uranium is input somewhere in the middle of the cascade, and the two ends of the cascade produce properly enriched and depleted uranium.

Fuel for Technic's nuclear reactor consists of enriched uranium of which 3.5% is fissile. (This is a typical value for a real-life light water reactor, a common type for power generation.) To enrich uranium in the game, it must first be in dust form: the centrifuge will not operate on ingots. (In real life uranium enrichment is done with the uranium in the form of a gas.) It is best to grind uranium lumps directly to dust, rather than cook them to ingots first, because this yields twice as much metal dust. When uranium is in refined form (dust, ingot, or block), the name of the inventory item indicates its fissile proportion. Uranium of any available fissile proportion can be put through all the usual processes for metal.

A single centrifuge operation takes two uranium dust piles, and produces as output one dust pile with a fissile proportion 0.1% higher and one with a fissile proportion 0.1% lower. Uranium can be enriched up to the 3.5% required for nuclear fuel, and depleted down to 0.0%. Thus a cascade covering the full range of fissile fractions requires 34 cascade stages. (In real life, enriching to 3.5% uses thousands of cascade stages. Also, centrifuging is less effective when the input isotope ratio is more skewed, so the steps in fissile proportion are smaller for relatively depleted uranium. Zero fissile content is only asymptotically approachable, and natural uranium relatively cheap, so uranium is normally only depleted to around 0.3%. On the other hand, much higher enrichment than 3.5% isn't much more difficult than enriching that far.)

Although centrifuges can be used manually, it is not feasible to perform uranium enrichment by hand. It is a practical necessity to set up an automated cascade, using pneumatic tubes to transfer uranium dust piles between centrifuges. Because both outputs from a centrifuge are ejected into the same tube, sorting tubes are needed to send the outputs in different directions along the cascade. It is possible to send items into the centrifuges through the same tubes that take the outputs, so the simplest version of the cascade structure has a line of 34 centrifuges linked by a line of 34 sorting tube segments.

Assuming that the cascade depletes uranium all the way to 0.0%, producing one unit of 3.5%-fissile uranium requires the input of five units of 0.7%-fissile (natural) uranium, takes 490 centrifuge operations, and produces four units of 0.0%-fissile (fully depleted) uranium as a byproduct. It is possible to reduce the number of required centrifuge operations by using more natural uranium input and outputting only partially depleted uranium, but (unlike in real life) this isn't usually an economical approach. The 490 operations are not spread equally over the cascade stages: the busiest stage is the one taking 0.7%-fissile uranium, which performs 28 of the 490 operations. The least busy is the one taking 3.4%-fissile uranium, which performs 1 of the 490 operations.

A centrifuge cascade will consume quite a lot of energy. It is worth putting a battery upgrade in each centrifuge. (Only one can be accommodated, because a control logic unit upgrade is also required for tube operation.) An MV centrifuge, the only type presently available, draws 7 kEU/s in this state, and takes 5 s for each uranium centrifuging operation. It thus takes 35 kEU per operation, and the cascade requires 17.15 MEU to produce each unit of enriched uranium. It takes five units of enriched uranium to make each fuel rod, and six rods to fuel a reactor, so the enrichment cascade requires 514.5 MEU to process a full set of reactor fuel. This is about 0.85% of the 6.048 GEU that the reactor will generate from that fuel.

If there is enough power available, and enough natural uranium input, to keep the cascade running continuously, and exactly one centrifuge at each stage, then the overall speed of the cascade is determined by the busiest stage, the 0.7% stage. It can perform its 28 operations towards the enrichment of a single uranium unit in 140 s, so that is the overall cycle time of the cascade. It thus takes 70 min to enrich a full set of reactor fuel. While the cascade is running at this full speed, its average power consumption is 122.5 kEU/s. The instantaneous power consumption varies from second to second over the 140 s cycle, and the maximum possible instantaneous power consumption (with all 34 centrifuges active simultaneously) is 238 kEU/s. It is recommended to have some battery boxes to smooth out these variations.

If the power supplied to the centrifuge cascade averages less than 122.5 kEU/s, then the cascade can't run continuously. (Also, if the power supply is intermittent, such as solar, then continuous operation requires more battery boxes to smooth out the supply variations, even if the average power is high enough.) Because it's automated and doesn't require continuous player attention, having the cascade run at less than full speed shouldn't be a major problem. The enrichment work will consume the same energy overall regardless of how quickly it's performed, and the speed will vary in direct proportion to the average power supply (minus any supply lost because battery boxes filled completely).

If there is insufficient power to run both the centrifuge cascade at full speed and whatever other machines require power, all machines on the same power network as the centrifuge will be forced to run at the same fractional speed. This can be inconvenient, especially if use of the other machines is less automated than the centrifuge cascade. It can be avoided by putting the centrifuge cascade on a separate power network from other machines, and limiting the proportion of the generated power that goes to it.

If there is sufficient power and it is desired to enrich uranium faster than a single cascade can, the process can be speeded up more economically than by building an entire second cascade. Because the stages of the cascade do different proportions of the work, it is possible to add a second and subsequent centrifuges to only the busiest stages, and have the less busy stages still keep up with only a single centrifuge each.

Another possible approach to uranium enrichment is to have no fixed assignment of fissile proportions to centrifuges, dynamically putting whatever uranium is available into whichever centrifuges are available. Theoretically all of the centrifuges can be kept almost totally busy all the time, making more efficient use of capital resources, and the number of centrifuges used can be as little (down to one) or as large as desired. The difficult part is that it is not sufficient to put each uranium dust pile individually into whatever centrifuge is available: they must be input in matched pairs. Any odd dust pile in a centrifuge will not be processed and will prevent that centrifuge from accepting any other input.

### Concrete

Concrete is a synthetic building material. Technic implements it in the game.

Two forms of concrete are available as building blocks: ordinary "concrete" and more advanced "blast-resistant concrete". Despite its name, the latter has no special resistance to explosions or to any other means of destruction.

Concrete can also be used to make fences. They act just like wooden fences, but aren't flammable. Confusingly, the item that corresponds to a wooden "fence" is called "concrete post". Posts placed adjacently will implicitly create fence between them. Fencing also appears between a post and adjacent concrete block.

### Latex ![](/doc/github-wiki/images/technic_raw_latex.png)

Latex is used for manufacturing rubber, which is heavily used for the medium- and high-voltage components within Technic. Latex can be harvested directly from rubber trees (look for the pale green/seafoam leaves) using the tree tap like any other tool. Rubber trees regenerate their latex supplies after about a day.

## Industrial processes

### Alloying

In Technic, alloying is a way of combining items to create other items, distinct from standard crafting. Alloying always uses inputs of exactly two distinct types, and produces a single output. Like cooking, which takes a single input, it is performed using a powered machine, known generically as an "alloy furnace". An alloy furnace always has two input slots, and it doesn't matter which way round the two ingredients are placed in the slots. Many alloying recipes require one or both slots to contain a stack of more than one of the ingredient item: the quantity required of each ingredient is part of the recipe.

As with the furnaces used for cooking, there are multiple kinds of alloy furnace, powered in different ways. The most-used alloy furnaces are electrically powered. There is also an alloy furnace that is powered by directly burning fuel, just like the basic cooking furnace. Building almost any electrical machine, including the electrically-powered alloy furnaces, requires a machine casing component, one ingredient of which is brass, an alloy. It is therefore necessary to use the fuel-fired alloy furnace in the early part of the game, on the way to building electrical machinery.

Alloying recipes are mainly concerned with metals. These recipes combine a base metal with some other element, most often another metal, to produce a new metal. This is discussed in the section on metal. There are also a few alloying recipes in which the base ingredient is non-metallic, such as the recipe for the silicon wafer.

### Grinding, extracting, and compressing

Grinding, extracting, and compressing are three distinct, but very similar, ways of converting one item into another. They are all quite similar to the cooking found in the basic Stonecraft game. Each uses an input consisting of a single item type, and produces a single output. They are all performed using powered machines, respectively known generically as a "grinder", "extractor", and "compressor". Some compressing recipes require the input to be a stack of more than one of the input item: the quantity required is part of the recipe. Grinding and extracting recipes never require such a stacked input.

There are multiple kinds of grinder, extractor, and compressor. Unlike cooking furnaces and alloy furnaces, there are none that directly burn fuel; they are all electrically powered.

Grinding recipes always produce some kind of dust, loosely speaking, as output. The most important grinding recipes are concerned with metals: every metal lump or ingot can be ground into metal dust. Coal can also be ground into dust, and burning the dust as fuel produces much more energy than burning the original coal lump. There are a few other grinding recipes that make block types from the basic Stonecraft game more interconvertible: standard stone can be ground to standard sand, desert stone to desert sand, cobblestone to gravel, and gravel to dirt.

Extracting is a miscellaneous category, used for a small group of processes that just don't fit nicely anywhere else. (Its name is notably vaguer than those of the other kinds of processing.) It is used for recipes that produce dye, mainly from flowers. (However, for those recipes using flowers, the basic Stonecraft game provides parallel crafting recipes that are easier to use and produce more dye, and those recipes are not suppressed by Technic.) Its main use is to generate rubber from raw latex, which it does three times as efficiently as merely cooking the latex. Extracting was also formerly used for uranium enrichment for use as nuclear fuel, but this use has been superseded by a new enrichment system using the centrifuge.

Compressing recipes are mainly used to produce a few relatively advanced artificial item types, such as the copper and carbon plates used in advanced machine recipes. There are also a couple of compressing recipes making natural block types more interconvertible.

### Centrifuging

Centrifuging is another way of using a machine to convert items. Centrifuging takes an input of a single item type, and produces outputs of two distinct types. The input may be required to be a stack of more than one of the input item: the quantity required is part of the recipe. Centrifuging is only performed by a single machine type, the MV (electrically-powered) centrifuge.

Currently, centrifuging recipes don't appear in the unified_inventory craft guide, because unified_inventory can't yet handle recipes with multiple outputs.

Generally, centrifuging separates the input item into constituent substances, but it can only work when the input is reasonably fluid, and in marginal cases it is quite destructive to item structure. (In real life, centrifuges require their input to be mainly fluid, that is either liquid or gas. Few items in the game are described as liquid or gas, so the concept of the centrifuge is stretched a bit to apply to finely-divided solids.)

The main use of centrifuging is in uranium enrichment, where it separates the isotopes of uranium dust that otherwise appears uniform. Enrichment is a necessary process before uranium can be used as nuclear fuel, and the radioactivity of uranium blocks is also affected by its isotopic composition.

A secondary use of centrifuging is to separate the components of metal alloys. This can only be done using the dust form of the alloy. It recovers both components of binary metal/metal alloys. It can't recover the carbon from steel or cast iron.

## Radioactivity

Technic adds radioactivity to the game, as a hazard that can harm player characters. Certain substances in the game are radioactive, and when placed as blocks in the game world will damage nearby players. Conversely, some substances attenuate radiation, and so can be used for shielding. The radioactivity system is based on reality, but is not an attempt at serious simulation: like the rest of the game, it has many simplifications and deliberate deviations from reality in the name of game balance.

In real life radiological hazards can be roughly divided into three categories based on the time scale over which they act: prompt radiation damage (such as radiation burns) that takes effect immediately; radiation poisoning that becomes visible in hours and lasts weeks; and cumulative effects such as increased cancer risk that operate over decades. The game's version of radioactivity causes only prompt damage, not any delayed effects. Damage comes in the abstracted form of removing the player's hit points, and is immediately visible to the player. As with all other kinds of damage in the game, the player can restore the hit points by eating food items. High-nutrition foods, such as the pie baskets supplied, are a useful tool in dealing with radiological hazards.

Only a small range of items in the game are radioactive. From Technic, the only radioactive items are uranium ore, refined uranium blocks, nuclear reactor cores (when operating), and the materials released when a nuclear reactor melts down. Other mods can plug into the Technic system to make their own block types radioactive. Radioactive items are harmless when held in inventories. They only cause radiation damage when placed as blocks in the game world.

The rate at which damage is caused by a radioactive block depends on the distance between the source and the player. Distance matters because the damaging radiation is emitted equally in all directions by the source, so with distance it spreads out, so less of it will strike a target of any specific size. The amount of radiation absorbed by a target thus varies in proportion to the inverse square of the distance from the source. The game imitates this aspect of real-life radioactivity, but with some simplifications. While in real life the inverse square law is only really valid for sources and targets that are small relative to the distance between them, in the game it is applied even when the source and target are large and close together. Specifically, the distance is measured from the center of the radioactive block to the abdomen of the player character. For extremely close encounters, such as where the player swims in a radioactive liquid, there is an enforced lower limit on the effective distance.

Different types of radioactive block emit different amounts of radiation. The least radioactive of the radioactive block types is uranium ore, which causes 0.25 HP/s damage to a player 1 m away. A block of refined but unenriched uranium, as an example, is nine times as radioactive, and so will cause 2.25 HP/s damage to a player 1 m away. By the inverse square law, the damage caused by that uranium block reduces by a factor of four at twice the distance, that is to 0.5625 HP/s at a distance of 2 m, or by a factor of nine at three times the distance, that is to 0.25 HP/s at a distance of 3 m. Other radioactive block types are far more radioactive than these: the most radioactive of all, the result of a nuclear reactor melting down, is 1024 times as radioactive as uranium ore.

Uranium blocks are radioactive to varying degrees depending on their isotopic composition. An isotope being fissile, and thus good as reactor fuel, is essentially uncorrelated with it being radioactive. The fissile U-235 is about six times as radioactive than the non-fissile U-238 that makes up the bulk of natural uranium, so one might expect that enriching from 0.7% fissile to 3.5% fissile (or depleting to 0.0%) would only change the radioactivity of uranium by a few percent. But actually the radioactivity of enriched uranium is dominated by the non-fissile U-234, which makes up only about 50 parts per million of natural uranium but is about 19000 times more radioactive than U-238. The radioactivity of natural uranium comes just about half from U-238 and half from U-234, and the uranium gets enriched in U-234 along with the U-235. This makes 3.5%-fissile uranium about three times as radioactive as natural uranium, and 0.0%-fissile uranium about half as radioactive as natural uranium.

Radiation is attenuated by the shielding effect of material along the path between the radioactive block and the player. In general, only blocks of homogeneous material contribute to the shielding effect: for example, a block of solid metal has a shielding effect, but a machine does not, even though the machine's ingredients include a metal case. The shielding effect of each block type is based on the real-life resistance of the material to ionising radiation, but for game balance the effectiveness of shielding is scaled down from real life, more so for stronger shield materials than for weaker ones. Also, whereas in real life materials have different shielding effects against different types of radiation, the game only has one type of damaging radiation, and so only one set of shielding values.

Almost any solid or liquid homogeneous material has some shielding value. At the low end of the scale, 5 meters of wooden planks nearly halves radiation, though in that case the planks probably contribute more to safety by forcing the player to stay 5 m further away from the source than by actual attenuation. Dirt halves radiation in 2.4 m, and stone in 1.7 m. When a shield must be deliberately constructed, the preferred materials are metals, the denser the better. Iron and steel halve radiation in 1.1 m, copper in 1.0 m, and silver in 0.95 m. Lead would halve in 0.69 m (its in-game shielding value is 80). Gold halves radiation in 0.53 m (factor of 3.7 per meter), but is a bit scarce to use for this purpose. Uranium halves radiation in 0.31 m (factor of 9.4 per meter), but is itself radioactive. The very best shielding in the game is nyancat material (nyancats and their rainbow blocks), which halves radiation in 0.22 m (factor of 24 per meter), but is extremely scarce. See technic/technic/radiation.lua for the in-game shielding values, which are different from real-life values.

If the theoretical radiation damage from a particular source is sufficiently small, due to distance and shielding, then no damage at all will actually occur. This means that for any particular radiation source and shielding arrangement there is a safe distance to which a player can approach without harm. The safe distance is where the radiation damage would theoretically be 0.25 HP/s. This damage threshold is applied separately for each radiation source, so to be safe in a multi-source situation it is only necessary to be safe from each source individually.

The best way to use uranium as shielding is in a two-layer structure, of uranium and some non-radioactive material. The uranium layer should be nearer to the primary radiation source and the non-radioactive layer nearer to the player. The uranium provides a great deal of shielding against the primary source, and the other material shields against the uranium layer. Due to the damage threshold mechanism, a meter of dirt is sufficient to shield fully against a layer of fully-depleted (0.0%-fissile) uranium. Obviously this is only worthwhile when the primary radiation source is more radioactive than a uranium block.

When constructing permanent radiation shielding, it is necessary to pay attention to the geometry of the structure, and particularly to any holes that have to be made in the shielding, for example to accommodate power cables. Any hole that is aligned with the radiation source makes a "shine path" through which a player may be irradiated when also aligned. Shine paths can be avoided by using bent paths for cables, passing through unaligned holes in multiple shield layers. If the desired shielding effect depends on multiple layers, a hole in one layer still produces a partial shine path, along which the shielding is reduced, so the positioning of holes in each layer must still be considered. Tricky shine paths can also be addressed by just keeping players out of the dangerous area.

## Electrical power

Most machines in Technic are electrically powered. To operate them it is necessary to construct an electrical power network. The network links together power generators and power-consuming machines, connecting them using power cables.

There are three tiers of electrical networking: low voltage (LV), medium voltage (MV), and high voltage (HV). Each network must operate at a single voltage, and most electrical items are specific to a single voltage. Generally, the machines of higher tiers are more powerful, but consume more energy and are more expensive to build, than machines of lower tiers. It is normal to build networks of all three tiers, in ascending order as one progresses through the game, but it is not strictly necessary to do this. Building HV equipment requires some parts that can only be manufactured using electrical machines, either LV or MV, so it is not possible to build an HV network first, but it is possible to skip either LV or MV on the way to HV.

Each voltage has its own cable type, with distinctive insulation. Cable segments connect to each other and to compatible machines automatically. Incompatible electrical items don't connect. All non-cable electrical items must be connected via cable: they don't connect directly to each other. Most electrical items can connect to cables in any direction, but there are a couple of important exceptions noted below.

To be useful, an electrical network must connect at least one power generator to at least one power-consuming machine. In addition to these items, the network must have a "switching station" in order to operate: no energy will flow without one. Unlike most electrical items, the switching station is not voltage-specific: the same item will manage a network of any tier. However, also unlike most electrical items, it is picky about the direction in which it is connected to the cable: the cable must be directly below the switching station.

Hovering over a network's switching station will show the aggregate energy supply and demand, which is useful for troubleshooting. Electrical energy is measured in "EU", and power (energy flow) in EU per second (EU/s). Energy is shifted around a network instantaneously once per second.

In a simple network with only generators and consumers, if total demand exceeds total supply then no energy will flow, the machines will do nothing, and the generators' output will be lost. To handle this situation, it is recommended to add a battery box to the network. A battery box will store generated energy, and when enough has been stored to run the consumers for one second it will deliver it to the consumers, letting them run part-time. It also stores spare energy when supply exceeds demand, to let consumers run full-time when their demand occasionally peaks above the supply. More battery boxes can be added to cope with larger periods of mismatched supply and demand, such as those resulting from using solar generators (which only produce energy in the daytime).

When there are electrical networks of multiple tiers, it can be appealing to generate energy on one tier and transfer it to another. The most direct way to do this is with the "supply converter", which can be directly wired into two networks. It is another tier-independent item, and also particular about the direction of cable connections: it must have the cable of one network directly above, and the cable of another network directly below. The supply converter demands 10000 EU/s from the network above, and when this network gives it power it supplies 9000 EU/s to the network below. Thus it is only 90% efficient, unlike most of the electrical system which is 100% efficient in moving energy around. To transfer more than 10000 EU/s between networks, connect multiple supply converters in parallel.

## Chests

Technic, if activated, replaces the basic Stonecraft's single type of chest with a range of chests that have different sizes and features. The chest types are identified by the materials from which they are made; the better chests are made from more exotic materials. The chest types form a linear sequence, each being (with one exception noted below) strictly more powerful than the preceding one. The sequence begins with the wooden chest from the basic game, and each later chest type is built by upgrading a chest of the preceding type. The chest types are:

* ![](/doc/github-wiki/images/technic_iron_chest_front.png) Iron chest, 9x10 slots
* ![](/doc/github-wiki/images/technic_copper_chest_front.png) Copper chest, 10x10 slots
* ![](/doc/github-wiki/images/technic_silver_chest_front.png) Silver chest, 11x10 slots. Can also be named.
* ![](/doc/github-wiki/images/technic_gold_chest_front.png) Gold chest, 12x10 slots. Can be named and given a unique color.
* ![](/doc/github-wiki/images/technic_mithril_chest_front.png) Mithril chest, 13x10 slots. **Note:** The mithril chest is not implemented yet, but when implemented will allow for connecting chests around the world to a shared network.

The iron and later chests have the ability to sort their contents, when commanded by a button in their interaction forms. Item types are sorted in the same order used in the unified_inventory craft guide. The copper and later chests also have an auto-sorting facility that can be enabled from the interaction form. An auto-sorting chest automatically sorts its contents whenever a player closes the chest. The contents will then usually be in a sorted state when the chest is opened, but may not be if pneumatic tubes have operated on the chest while it was closed, or if two players have the chest open simultaneously.

The silver and gold chests, but not the mithril chest, have a built-in sign-like capability. They can be given a textual label, which will be visible when hovering over the chest. The gold chest, but again not the mithril chest, can be further labelled with a colored patch that is visible from a moderate distance.

The mithril chest is currently an exception to the upgrading system. It has only as many inventory slots as the preceding (gold) type, and has fewer of the features. It has no feature that other chests don't have: it is strictly weaker than the gold chest. It is planned that in the future it will acquire some unique features, but for now the only reason to use it is aesthetic.

The size of the largest chests is dictated by the maximum size of interaction form that the game engine can successfully display. If in the future the engine becomes capable of handling larger forms, by scaling them to fit the screen, the sequence of chest sizes will likely be revised.

As with the chest of the basic Stonecraft game, each chest type comes in both locked and unlocked flavors. All of the chests work with the pneumatic tubes of 'Pipeworks'.

## Tools

Tools in Technic fall into two categories: manual and electric. Both sets of tools are unstackable in the inventory. They have limited durability that is reduced during use (they disappear after they hit 0 durability). Manual tools can be regenerated by using the Tool Workshop, so that valuable tools, such as mese or diamond tools can be preserved. Electric tools require charging in Battery Boxes (of any voltage) and will not be destroyed when they reach 0 charge. Higher levels of electric tools are more powerful and contain more charge so they work longer.

### Chainsaw ![](/doc/github-wiki/images/technic_chainsaw.png)

This electric tool speeds up harvesting of wood by allowing the harvesting of an entire tree in a single click. Just click on any part of a tree, and the wood and leaves of that tree at that point and above will be cut and dropped on the ground as blocks. It has enough charge to cut down about 5 trees before running out of power.

**Note:** If you can't find the drops from using the chainsaw, dig around as they can be buried under neighbouring terrain blocks.

### Flashlight ![](/doc/github-wiki/images/technic_flashlight.png)

This electric tool illumates the area in front of the player. While it is electric, and so requires charging, to use it one only needs to equip it. Punching with this tool does nothing.

### Lava can ![](/doc/github-wiki/images/technic_lava_can.png)

The lava can works similarly to the bucket tool and the water can, but instead of carrying water, it can carry lava source blocks (the ones that aren't animated), up to 8 at a time. To use, simply equip and click on lava source blocks (they will highlight in black). Then clicking anywhere where there isn't a lava source block will place them again.

**Warning:** Be careful where you place these source blocks! Since you're placing lava source blocks, lava will flow out of them and may trap or burn you depending on where you are.

### Mining drill ![](/doc/github-wiki/images/technic_mining_drill.png) ![](/doc/github-wiki/images/technic_mining_drill_mk2.png) ![](/doc/github-wiki/images/technic_mining_drill_mk3.png)

This electric tool operates similarly to a pickaxe, though every block takes exactly one click to drill out. While the Mining Laser allows for faster collection of bulk minerals, it's cutting path can sometimes be undesirable, and the mining drill is useful in these instances.

The higher levels of the mining drill allow for drilling more blocks at once, substantially reducing mining time. At mark-2, the mining drill can drill 3 blocks at once, either 3-deep, 3-wide, or 3-tall. At mark-3, the mining drill can drill 9-blocks at once in a 3x3 layout around the block selected. Switching between these modes can be done by shift-clicking.

**Advice:** Since these tools require substantially more diamonds than the mining laser, and yet drills slower, it is suggested that a mining laser be built first.

### Mining laser ![](/doc/github-wiki/images/technic_mining_laser_mk1.png) ![](/doc/github-wiki/images/technic_mining_laser_mk2.png) ![](/doc/github-wiki/images/technic_mining_laser_mk3.png)

This electric tool is a substantial upgrade above the pickaxe that you start mining with. The laser works by drilling directly forward 7 blocks making a path that's roughly 1-block in diameter. The laser is electric, requiring charging in a battery box (any voltage). As soon as an LV electrical system is set up, this is a great next step.

### Sonic screwdriver ![](/doc/github-wiki/images/technic_sonic_screwdriver.png)

This electric tool is used for rotating nodes, much like the default Screwdriver tool, but loses charge instead of durability. This is useful for any nodes which have a "front" direction, like stairs, machines, furniture, etc. Nodes are rotated around the Y-axes (vertical).

### Tree tap ![](/doc/github-wiki/images/technic_tree_tap.png)

This manual tool allows for harvesting latex from rubber trees. Extracting latex can be done by hitting rubber trees with it yields for 1 latex. The rubber tree will regenerate its latex supply over the course of a day.

### Water can ![](/doc/github-wiki/images/technic_water_can.png)

The water can works similarly to the normal bucket tool, but it can hold 16 `water_source` (the water blocks that don't look like they're flowing) blocks instead of 1. To use, simply equip the water can and click on water source blocks (they will highlight in black). Then clicking anywhere where there isn't a `water_source` block with the water can equipped will place them.

**Warning:** Be careful where you place these source blocks! Since you're placing water source blocks, water will flow out of them and may trap or drown you depending on where you are.

### Wrench ![](/doc/github-wiki/images/technic_wrench.png)

The manual tool allows for moving blocks which contain an inventory, like chests. A shift-right-click on a machine/chest will immediately add it to the inventory.

## Digilines

You can control some machines with the digilines.

### Switching Station

There are two ways getting information from the switching station:

1. Give it a mesecon signal (eg. with a lever) and it will send always when the supply or demand changes. 
2. Send to the switching station `"get"` or `"GET"` and it will send back. 

The sent message is always a table containing the supply and demand.

### Supply Converter

You can send the following to it:

* `"get"`: It will send back a table containing the fields `"enabled"`, `"power"` and `"mesecon_mode"` which are all integers. 
* `"off"`: Deactivate the supply converter. 
* `"on"`: Activate the supply converter. 
* `"toggle"`: Activate or deactivate the supply converter depending on its current state. 
* `"power "..power`: Set the amount of the power, it shall convert. 
* `"mesecon_mode "..<int>`: Set the mesecon mode. 

### Battery Boxes

Send to it `"get"` or `"GET"` and it will send a table back containing:

* `demand`: A number. 
* `supply`: A number. 
* `input`: A number. 
* `charge`: A number. 
* `max_charge`: A number. 
* `src`: Itemstack made to table. 
* `dst`: Itemstack made to table. 
* `upgrade1`: Itemstack made to table. 
* `upgrade2`: Itemstack made to table. 

### Forcefield Emitter

You should send a table to it containing the `command` and for some commands the `value` field.
Some strings will automatically be made to tables:

* `"get"` :arrow_right: `{command = "get"}` 
* `"off"` :arrow_right: `{command = "off"}` 
* `"on"` :arrow_right: `{command = "on"}` 
* `"toggle"` :arrow_right: `{command = "toggle"}` 
* `"range "..range` :arrow_right: `{command = "range", value = range}` 
* `"shape "..shape` :arrow_right: `{command = "shape", value = shape}` 

The commands:

* `"get"`: The forcefield emitter sends back a table containing: 
	* `"enabled"`: `0` is off, `1` is on. 
	* `"range"` 
	* `"shape"`: `0` is spheric, `1` is cubic. 
* `"off"`: Deactivate the forcefield emitter. 
* `"on"`: Activate the forcefield emitter. 
* `"toggle"`: Activate or deactivate the forcefield emitter depending on its current state. 
* `"range"`: Set the range to `value`. 
* `"shape"`: `value` can be a number (`0` or `1`) or a string (`"sphere"` or `"cube"`). 

### Nuclear Reactor Remote Control

Since the nuclear reactor core can't be accessed by digiline wire because the water layer which mustn't have a hole, you need the digiline_remote to control it.
You should send a table to it containing at least the `command` field and for some commands other fields.
Some strings will automatically be made to tables:

* `"get"` :arrow_right: `{command = "get"}` 
* `"self_destruct "..time` :arrow_right: `{command = "self_destruct", timer = time}` 
* `"start"` :arrow_right: `{command = "start"}` 

The commands:

* `"get"`: The nuclear reactor sends back a table containing: 
	* `"burn_time"`: The time in seconds how long the reactor already runs. One week after start, when it reaches 7 * 24 * 60 * 60 (=604800), the fuel is completely used. 
	* `"enabled"`: A bool. 
	* `"siren"`: A bool. 
	* `"structure_accumulated_badness"` 
	* `"rods"`: A table with 6 numbers in it, one for each fuel slot. 
		*  A positive value is the count of fuel rods in the slot. 
		* `0` means the slot is empty. 
		*  A negative value means some other items are in the slot. The absolute value is the count of these items. 
* `"self_destruct"`: A setting has to be enabled to use this. The reactor will melt down after `timer` seconds or instantly. 
* `"start"`: Tries to start the reactor, `"Start successful"` is sent back on success, `"Error"` if something is wrong. 

If the automatic start is enabled, it will always send `"fuel used"` when it uses fuel.

## Reactors

### Nuclear Reactor

If no amount of solar power is enough to sate your hunger for power, why not give reactors a try? Utilising the latest micro-fission technology, you can produce up to 100,000 EU per second!

#### Setup

The standard reactor structure consists of a 9x9x9 cube.

For the reactor to operate and not melt down, it insists on the inner 7x7x7 portion (from the core out to the blast-resistant concrete) being intact. Intactness only depends on the number of nodes of the right type in each layer. The water layer must have water in all but at most one node; the lead and blast-resistant concrete layers must have the right material in all but at most two nodes. The permitted gaps are meant for the cable and man-hole, but can actually be anywhere and contain anything. For the reactor to be useful, a cable must connect to the core, but it can go in any direction. The outer concrete layer of the standard structure is not required for the reactor to operate.

#### Step-by-Step Construction

First we build the first layer consisting of 9x9 concrete blocks. If you don't want use concrete for your reactor, you can start with 7x7 blast-resistant concrete blocks.

![](/doc/github-wiki/images/Nuclear_Reactor_1.png)

Now we have to build a 7x7 layer consisting of blast-resistant concrete blocks. The outer reactor consists of normale concrete blocks.

![](/doc/github-wiki/images/Nuclear_Reactor_2.png)

The next inner layer consists of 5x5 lead blocks.

![](/doc/github-wiki/images/Nuclear_Reactor_3.png)

We fill the bottom of the lead layer with water nodes.

![](/doc/github-wiki/images/Nuclear_Reactor_4.png)

Now we build the next layer of lead, blast-resistant concrete blocks and normal concrete blocks. It's time to place some HV cable and the reactor core.

![](/doc/github-wiki/images/Nuclear_Reactor_5.png)

We place a new layer of of lead blocks, blast-resistant concrete blocks and normal concrete blocks and fill it with water nodes.

![](/doc/github-wiki/images/Nuclear_Reactor_6.png)

Now we can close the lead layer, the permitted gap in the middle is for our man-hole to reach our reactor core.

![](/doc/github-wiki/images/Nuclear_Reactor_7.png)

In the next stept we use again blast-resistant concrete blocks and normal concrete blocks.

![](/doc/github-wiki/images/Nuclear_Reactor_8.png)

Last but not least we build a layer of 9x9 concrete blocks. The reactor structure is now complete.

![](/doc/github-wiki/images/Nuclear_Reactor_9.png)

Now it's time to connect a switching station to our HV cable.

![](/doc/github-wiki/images/Nuclear_Reactor_10.png)

Through the man-hole we can reach the reactor core.

![](/doc/github-wiki/images/Nuclear_Reactor_11.png)

We fill the slots with uranium fuel and press the 'Start' button. If we did everything right, the reactor would have to be operational.

![](/doc/github-wiki/images/Nuclear_Reactor_12.png)

Yes! You can see we have an energy output of 10kEU!

![](/doc/github-wiki/images/Nuclear_Reactor_13.png)


## Geothermal EU generator

Using hot lava and water this device can create energy from steam

The machine is only producing LV EUs and can thus not drive more advanced equipment

The output is a little more than the coal burning generator (max 300EUs)

## Solar array

The solar array is an assembly of panels into a powerful array

The assembly can deliver more energy than the individual panel because of the transformer unit which converts the panel output variations into a stable supply.

Solar arrays are not able to store large amounts of energy.

The LV arrays are used to make medium voltage arrays.


## Solar Panel

Solar panels are the building blocks of LV solar arrays

They can however also be used separately but with reduced efficiency due to the missing transformer.

Individual panels are less efficient than when the panels are combined into full arrays.

## Watermill

A water mill produces LV EUs by exploiting flowing water across it

It is a LV EU supplyer and fairly low yield (max 120EUs)

It is a little under half as good as the thermal generator.