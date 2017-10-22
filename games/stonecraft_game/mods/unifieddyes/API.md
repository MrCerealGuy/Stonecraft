### API

This section details the Unified Dyes API and how to use it with your mods.

In your node definition, you must include a few things to interface with Unified Dyes. Here is an example:

```lua
minetest.register_node("mymod:colored_node", {
   description = "My custom colored node",
   tiles = { "mymod_custom_colored_node.png" },
   paramtype = "light",
   paramtype2 = "color",
   palette = "unifieddyes_palette_extended.png",
   place_param2 = 240,
   groups = {snappy = 1, cracky = 2, ud_param2_colorable = 1}
   on_construct = unifieddyes.on_construct,
   after_place_node = unifieddyes.recolor_on_place,
   after_dig_node = unifieddyes.after_dig_node,
})
```

`paramtype2` must be one of:
- "color" this is an 89-color or 256-color node
- "colorwallmounted" this is a 32-color node using "wallmounted" mode
- "colorfacedir" this node uses one of the "split" 89-color palettes.

`palette` must be set to match the `paramtype2` setting, and must be one of:
- "unifieddyes_palette.png"
- "unifieddyes_palette_extended.png"
- "unifieddyes_palette_colorwallmounted.png"
- or one of the "split" hues palettes (see below).

`place_param2` generally is only needed for the 256-color palette, and should usually be set to 240 (which corresponds to white).
`groups` If your node can be colored by punching it with dye, its groups entry must contain the key ud_param2_colorable = 1, among whatever else you'd normally put there. If the node is software-controlled, as might be the case for some mesecons-digilines aware node, then this group key should be omitted.
`on_construct` see below.
`after_place_node` see below.
`after_dig_node` see below.

#### Function calls

**`unifieddyes.recolor_on_place(pos, placer, itemstack, pointed_thing)`**

Call this within your node's `after_place_node` callback to allow Unified Dyes to automatically color the node using the dye you last used on that kind of node The feature will remain active until the dye runs out, or the user places a different kind of colorable node, or the user cancels the feature.

**`unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)`
`unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)`**

These two are used to re-orient `wallmounted` nodes after placing. The former allows positioning to floor, ceiling, and four walls, while the latter restricts the rotation to just the four walls. The latter is most often used with a node whose model is designed so that the four wall positions actually place the model "upright", facing +/- X or Z. This is a hacky way to make a node look like it has basic `facedir` capability, while being able to use the 32-color palette.

**`unifieddyes.fix_after_screwdriver_nsew(pos, node, user, mode, new_param2)`**

This serves the same purpose as the `fix_rotation_nsew`, but is used to restrict the node's rotation after it's been hit with the screwdriver.

**`unifieddyes.select_node(pointed_thing)`**

Just what it says on the tin. :-) This function returns a position and node definition of whatever is being pointed at. 

**`unifieddyes.is_buildable_to(placer_name, ...)`**

Again, another obvious one, returns whether or not the pointed node is `buildable_to` (can be overwritten by another node).

**`unifieddyes.get_hsv(name)`**

Accepts an item name, and returns the corresponding hue, saturation, and value (in that order), as strings.

If the item name is a color (not greyscale), then hue will be the basic hue for that color, saturation will be empty string for high saturation or `_s50` for low, and value will be `dark_`, `medium_`, `light_`, or an empty string if it's full color.

If the item name is greyscale, then hue will contain `white`, `light_grey`, `grey`, `dark_grey`, or `black`, saturation will (ironically) be an empty string, and value will be `light_`, `dark_`, or empty string if it's medium grey.

For example:
"mymod:mynode_red" would return ("red", "", "")
"mymod:mynode_light_blue" would return ("blue", "", "light_")
"mymod:mynode_dark_yellow_s50" would return ("yellow", "_s50", "dark_")
"mymod:mynode_dark_grey" would return ("dark_grey", "", "dark_")

**`unifieddyes.getpaletteidx(color, palette_type)`**

When given a `color` string (in the form of "dye:foo" or "unifieddyes:foo") and `palette_type` (either a boolean or string), this function returns the numerical index into that palette, and the hue name as a string.
    `false` or `nil`: the 89-color palette
    `true`: 89 color "split" palette mode, for nodes that need full `facedir` support. In this case, the hue field would match whichever of the 13 "split" palettes the node is using, and the index will be 1-7, representing the shade within that palette. See my coloredwoods mod for more information on how this mode is used.
    `wallmounted`: the 32-color palette, for nodes using `colorwallmounted` mode.
    `extended`: the 256-color "extended" palette

**`unifieddyes.on_construct(pos)`**

This function, called in your node definition's on_construct, just sets the `palette = "ext"` metadata key for the node after it's been placed. This can then be read in an LBM to determine if this node needs to be converted from the old 89-color palette to the extended 256-color palette. Although it is good practice to call this for any node that uses the 256-color palette, it isn't strictly necessary as long as the node has never used the 89-color palette and won't be subjected to an LBM that changes its color.

**`unifieddyes.after_dig_node(pos, oldnode, oldmetadata, digger)`**

This function handles returning dyes to the user when a node is dug. All colorized nodes need to call this in `after_dig_node`.

**`unifieddyes.on_use(itemstack, player, pointed_thing)`**

This function is used internally by Unfiied Dyes to actually make a dye able to colorize a node when you wield and punch with it. Unified Dyes redefines the minetest_game default dye items to call this function.

#### Tables

In addition to the above API calls, Unified Dyes provides several useful tables

`unifieddyes.HUES` contains a list of the 12 hues used by the 89-color palette.

`unifieddyes.HUES_EXTENDED` contains a list of the 24 hues in the 256-color palette. Each line contains the color name and its RGB value expressed as three numbers (rather than the usual `#RRGGBB` string).

`unifieddyes.base_color_crafts` contains a condensed list of crafting recipes for all 24 basic hues, plus black and white, most of which have multiple alternative recipes. Each line contains the name of the color, up to five dye itemstrings (with `nil` in each unused space), and the yield for that craft. 

`unifieddyes.shade_crafts` contains recipes for each of the 10 shades a hue can take on, used with one or two portions of the dye corresponding to that hue. Each line contains the shade name with trailing "_", the saturation name (either `_s50` or empty string), up to three dye itemstrings, and the yield for that craft.

`unifieddyes.greymixes` contains the recipes for the 14 shades of grey. Each line contains the grey shade number from 1-14, up to four dye item names, and the yield for that craft.
