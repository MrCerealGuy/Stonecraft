Minetest Lua Client Modding API Reference 0.4.15
================================================
* More information at <http://www.minetest.net/>
* Developer Wiki: <http://dev.minetest.net/>

Introduction
------------

**WARNING: The client API is currently unstable, and may break/change without warning.**

Content and functionality can be added to Minetest 0.4.15-dev+ by using Lua
scripting in run-time loaded mods.

A mod is a self-contained bunch of scripts, textures and other related
things that is loaded by and interfaces with Minetest.

Transfering client-sided mods form the server to the client is planned, but not implemented yet.

If you see a deficiency in the API, feel free to attempt to add the
functionality in the engine and API. You can send such improvements as
source code patches on GitHub (https://github.com/minetest/minetest).

Programming in Lua
------------------
If you have any difficulty in understanding this, please read
[Programming in Lua](http://www.lua.org/pil/).

Startup
-------
Mods are loaded during client startup from the mod load paths by running
the `init.lua` scripts in a shared environment.

Paths
-----
* `RUN_IN_PLACE=1` (Windows release, local build)
    *  `$path_user`:
        * Linux: `<build directory>`
        * Windows: `<build directory>`
    * `$path_share`
        * Linux: `<build directory>`
        * Windows:  `<build directory>`
* `RUN_IN_PLACE=0`: (Linux release)
    * `$path_share`
        * Linux: `/usr/share/minetest`
        * Windows: `<install directory>/minetest-0.4.x`
    * `$path_user`:
        * Linux: `$HOME/.minetest`
        * Windows: `C:/users/<user>/AppData/minetest` (maybe)

Mod load path
-------------
Generic:

* `$path_share/clientmods/`
* `$path_user/clientmods/` (User-installed mods)

In a run-in-place version (e.g. the distributed windows version):

* `minetest-0.4.x/clientmods/` (User-installed mods)

On an installed version on Linux:

* `/usr/share/minetest/clientmods/`
* `$HOME/.minetest/clientmods/` (User-installed mods)

Modpack support
----------------
**NOTE: Not implemented yet.**

Mods can be put in a subdirectory, if the parent directory, which otherwise
should be a mod, contains a file named `modpack.txt`. This file shall be
empty, except for lines starting with `#`, which are comments.

Mod directory structure
------------------------

    clientmods
    ├── modname
    |   ├── depends.txt
    |   ├── init.lua
    └── another

### modname
The location of this directory.

### depends.txt
List of mods that have to be loaded before loading this mod.

A single line contains a single modname.

Optional dependencies can be defined by appending a question mark
to a single modname. Their meaning is that if the specified mod
is missing, that does not prevent this mod from being loaded.

### init.lua
The main Lua script. Running this script should register everything it
wants to register. Subsequent execution depends on minetest calling the
registered callbacks.

`minetest.setting_get(name)` and `minetest.setting_getbool(name)` can be used
to read custom or existing settings at load time, if necessary.

### `sounds`
Media files (sounds) that will be transferred to the
client and will be available for use by the mod.

Naming convention for registered textual names
----------------------------------------------
Registered names should generally be in this format:

    "modname:<whatever>" (<whatever> can have characters a-zA-Z0-9_)

This is to prevent conflicting names from corrupting maps and is
enforced by the mod loader.

### Example
In the mod `experimental`, there is the ideal item/node/entity name `tnt`.
So the name should be `experimental:tnt`.

Enforcement can be overridden by prefixing the name with `:`. This can
be used for overriding the registrations of some other mod.

Example: Any mod can redefine `experimental:tnt` by using the name

    :experimental:tnt

when registering it.
(also that mod is required to have `experimental` as a dependency)

The `:` prefix can also be used for maintaining backwards compatibility.

Sounds
------
**NOTE: max_hear_distance and connecting to objects is not implemented.**

Only Ogg Vorbis files are supported.

For positional playing of sounds, only single-channel (mono) files are
supported. Otherwise OpenAL will play them non-positionally.

Mods should generally prefix their sounds with `modname_`, e.g. given
the mod name "`foomod`", a sound could be called:

    foomod_foosound.ogg

Sounds are referred to by their name with a dot, a single digit and the
file extension stripped out. When a sound is played, the actual sound file
is chosen randomly from the matching sounds.

When playing the sound `foomod_foosound`, the sound is chosen randomly
from the available ones of the following files:

* `foomod_foosound.ogg`
* `foomod_foosound.0.ogg`
* `foomod_foosound.1.ogg`
* (...)
* `foomod_foosound.9.ogg`

Examples of sound parameter tables:

    -- Play locationless
    {
        gain = 1.0, -- default
    }
    -- Play locationless, looped
    {
        gain = 1.0, -- default
        loop = true,
    }
    -- Play in a location
    {
        pos = {x = 1, y = 2, z = 3},
        gain = 1.0, -- default
        max_hear_distance = 32, -- default, uses an euclidean metric
    }
    -- Play connected to an object, looped
    {
        object = <an ObjectRef>,
        gain = 1.0, -- default
        max_hear_distance = 32, -- default, uses an euclidean metric
        loop = true,
    }

Looped sounds must either be connected to an object or played locationless.

### SimpleSoundSpec
* e.g. `""`
* e.g. `"default_place_node"`
* e.g. `{}`
* e.g. `{name = "default_place_node"}`
* e.g. `{name = "default_place_node", gain = 1.0}`

Representations of simple things
--------------------------------

### Position/vector

    {x=num, y=num, z=num}

For helper functions see "Vector helpers".

### pointed_thing
* `{type="nothing"}`
* `{type="node", under=pos, above=pos}`
* `{type="object", ref=ObjectRef}`

Flag Specifier Format
---------------------
Flags using the standardized flag specifier format can be specified in either of
two ways, by string or table.

The string format is a comma-delimited set of flag names; whitespace and
unrecognized flag fields are ignored. Specifying a flag in the string sets the
flag, and specifying a flag prefixed by the string `"no"` explicitly
clears the flag from whatever the default may be.

In addition to the standard string flag format, the schematic flags field can
also be a table of flag names to boolean values representing whether or not the
flag is set. Additionally, if a field with the flag name prefixed with `"no"`
is present, mapped to a boolean of any value, the specified flag is unset.

E.g. A flag field of value

    {place_center_x = true, place_center_y=false, place_center_z=true}

is equivalent to

    {place_center_x = true, noplace_center_y=true, place_center_z=true}

which is equivalent to

    "place_center_x, noplace_center_y, place_center_z"

or even

    "place_center_x, place_center_z"

since, by default, no schematic attributes are set.

Formspec
--------
Formspec defines a menu. It is a string, with a somewhat strange format.

Spaces and newlines can be inserted between the blocks, as is used in the
examples.

### Examples

#### Chest

    size[8,9]
    list[context;main;0,0;8,4;]
    list[current_player;main;0,5;8,4;]

#### Furnace

    size[8,9]
    list[context;fuel;2,3;1,1;]
    list[context;src;2,1;1,1;]
    list[context;dst;5,1;2,2;]
    list[current_player;main;0,5;8,4;]

#### Minecraft-like player inventory

    size[8,7.5]
    image[1,0.6;1,2;player.png]
    list[current_player;main;0,3.5;8,4;]
    list[current_player;craft;3,0;3,3;]
    list[current_player;craftpreview;7,1;1,1;]

### Elements

#### `size[<W>,<H>,<fixed_size>]`
* Define the size of the menu in inventory slots
* `fixed_size`: `true`/`false` (optional)
* deprecated: `invsize[<W>,<H>;]`

#### `container[<X>,<Y>]`
* Start of a container block, moves all physical elements in the container by (X, Y)
* Must have matching container_end
* Containers can be nested, in which case the offsets are added
  (child containers are relative to parent containers)

#### `container_end[]`
* End of a container, following elements are no longer relative to this container

#### `list[<inventory location>;<list name>;<X>,<Y>;<W>,<H>;]`
* Show an inventory list

#### `list[<inventory location>;<list name>;<X>,<Y>;<W>,<H>;<starting item index>]`
* Show an inventory list

#### `listring[<inventory location>;<list name>]`
* Allows to create a ring of inventory lists
* Shift-clicking on items in one element of the ring
  will send them to the next inventory list inside the ring
* The first occurrence of an element inside the ring will
  determine the inventory where items will be sent to

#### `listring[]`
* Shorthand for doing `listring[<inventory location>;<list name>]`
  for the last two inventory lists added by list[...]

#### `listcolors[<slot_bg_normal>;<slot_bg_hover>]`
* Sets background color of slots as `ColorString`
* Sets background color of slots on mouse hovering

#### `listcolors[<slot_bg_normal>;<slot_bg_hover>;<slot_border>]`
* Sets background color of slots as `ColorString`
* Sets background color of slots on mouse hovering
* Sets color of slots border

#### `listcolors[<slot_bg_normal>;<slot_bg_hover>;<slot_border>;<tooltip_bgcolor>;<tooltip_fontcolor>]`
* Sets background color of slots as `ColorString`
* Sets background color of slots on mouse hovering
* Sets color of slots border
* Sets default background color of tooltips
* Sets default font color of tooltips

#### `tooltip[<gui_element_name>;<tooltip_text>;<bgcolor>,<fontcolor>]`
* Adds tooltip for an element
* `<bgcolor>` tooltip background color as `ColorString` (optional)
* `<fontcolor>` tooltip font color as `ColorString` (optional)

#### `image[<X>,<Y>;<W>,<H>;<texture name>]`
* Show an image
* Position and size units are inventory slots

#### `item_image[<X>,<Y>;<W>,<H>;<item name>]`
* Show an inventory image of registered item/node
* Position and size units are inventory slots

#### `bgcolor[<color>;<fullscreen>]`
* Sets background color of formspec as `ColorString`
* If `true`, the background color is drawn fullscreen (does not effect the size of the formspec)

#### `background[<X>,<Y>;<W>,<H>;<texture name>]`
* Use a background. Inventory rectangles are not drawn then.
* Position and size units are inventory slots
* Example for formspec 8x4 in 16x resolution: image shall be sized
  8 times 16px  times  4 times 16px.

#### `background[<X>,<Y>;<W>,<H>;<texture name>;<auto_clip>]`
* Use a background. Inventory rectangles are not drawn then.
* Position and size units are inventory slots
* Example for formspec 8x4 in 16x resolution:
  image shall be sized 8 times 16px  times  4 times 16px
* If `true` the background is clipped to formspec size
  (`x` and `y` are used as offset values, `w` and `h` are ignored)

#### `pwdfield[<X>,<Y>;<W>,<H>;<name>;<label>]`
* Textual password style field; will be sent to server when a button is clicked
* When enter is pressed in field, fields.key_enter_field will be sent with the name
  of this field.
* `x` and `y` position the field relative to the top left of the menu
* `w` and `h` are the size of the field
* Fields are a set height, but will be vertically centred on `h`
* Position and size units are inventory slots
* `name` is the name of the field as returned in fields to `on_receive_fields`
* `label`, if not blank, will be text printed on the top left above the field
* See field_close_on_enter to stop enter closing the formspec

#### `field[<X>,<Y>;<W>,<H>;<name>;<label>;<default>]`
* Textual field; will be sent to server when a button is clicked
* When enter is pressed in field, fields.key_enter_field will be sent with the name
  of this field.
* `x` and `y` position the field relative to the top left of the menu
* `w` and `h` are the size of the field
* Fields are a set height, but will be vertically centred on `h`
* Position and size units are inventory slots
* `name` is the name of the field as returned in fields to `on_receive_fields`
* `label`, if not blank, will be text printed on the top left above the field
* `default` is the default value of the field
    * `default` may contain variable references such as `${text}'` which
      will fill the value from the metadata value `text`
    * **Note**: no extra text or more than a single variable is supported ATM.
* See field_close_on_enter to stop enter closing the formspec

#### `field[<name>;<label>;<default>]`
* As above, but without position/size units
* When enter is pressed in field, fields.key_enter_field will be sent with the name
  of this field.
* Special field for creating simple forms, such as sign text input
* Must be used without a `size[]` element
* A "Proceed" button will be added automatically
* See field_close_on_enter to stop enter closing the formspec

#### `field_close_on_enter[<name>;<close_on_enter>]`
* <name> is the name of the field
* if <close_on_enter> is false, pressing enter in the field will submit the form but not close it
* defaults to true when not specified (ie: no tag for a field)

#### `textarea[<X>,<Y>;<W>,<H>;<name>;<label>;<default>]`
* Same as fields above, but with multi-line input

#### `label[<X>,<Y>;<label>]`
* `x` and `y` work as per field
* `label` is the text on the label
* Position and size units are inventory slots

#### `vertlabel[<X>,<Y>;<label>]`
* Textual label drawn vertically
* `x` and `y` work as per field
* `label` is the text on the label
* Position and size units are inventory slots

#### `button[<X>,<Y>;<W>,<H>;<name>;<label>]`
* Clickable button. When clicked, fields will be sent.
* `x`, `y` and `name` work as per field
* `w` and `h` are the size of the button
* `label` is the text on the button
* Position and size units are inventory slots

#### `image_button[<X>,<Y>;<W>,<H>;<texture name>;<name>;<label>]`
* `x`, `y`, `w`, `h`, and `name` work as per button
* `texture name` is the filename of an image
* Position and size units are inventory slots

#### `image_button[<X>,<Y>;<W>,<H>;<texture name>;<name>;<label>;<noclip>;<drawborder>;<pressed texture name>]`
* `x`, `y`, `w`, `h`, and `name` work as per button
* `texture name` is the filename of an image
* Position and size units are inventory slots
* `noclip=true` means the image button doesn't need to be within specified formsize
* `drawborder`: draw button border or not
* `pressed texture name` is the filename of an image on pressed state

#### `item_image_button[<X>,<Y>;<W>,<H>;<item name>;<name>;<label>]`
* `x`, `y`, `w`, `h`, `name` and `label` work as per button
* `item name` is the registered name of an item/node,
   tooltip will be made out of its description
   to override it use tooltip element
* Position and size units are inventory slots

#### `button_exit[<X>,<Y>;<W>,<H>;<name>;<label>]`
* When clicked, fields will be sent and the form will quit.

#### `image_button_exit[<X>,<Y>;<W>,<H>;<texture name>;<name>;<label>]`
* When clicked, fields will be sent and the form will quit.

#### `textlist[<X>,<Y>;<W>,<H>;<name>;<listelem 1>,<listelem 2>,...,<listelem n>]`
* Scrollable item list showing arbitrary text elements
* `x` and `y` position the itemlist relative to the top left of the menu
* `w` and `h` are the size of the itemlist
* `name` fieldname sent to server on doubleclick value is current selected element
* `listelements` can be prepended by #color in hexadecimal format RRGGBB (only),
     * if you want a listelement to start with "#" write "##".

#### `textlist[<X>,<Y>;<W>,<H>;<name>;<listelem 1>,<listelem 2>,...,<listelem n>;<selected idx>;<transparent>]`
* Scrollable itemlist showing arbitrary text elements
* `x` and `y` position the item list relative to the top left of the menu
* `w` and `h` are the size of the item list
* `name` fieldname sent to server on doubleclick value is current selected element
* `listelements` can be prepended by #RRGGBB (only) in hexadecimal format
     * if you want a listelement to start with "#" write "##"
* Index to be selected within textlist
* `true`/`false`: draw transparent background
* See also `minetest.explode_textlist_event` (main menu: `engine.explode_textlist_event`)

#### `tabheader[<X>,<Y>;<name>;<caption 1>,<caption 2>,...,<caption n>;<current_tab>;<transparent>;<draw_border>]`
* Show a tab**header** at specific position (ignores formsize)
* `x` and `y` position the itemlist relative to the top left of the menu
* `name` fieldname data is transferred to Lua
* `caption 1`...: name shown on top of tab
* `current_tab`: index of selected tab 1...
* `transparent` (optional): show transparent
* `draw_border` (optional): draw border

#### `box[<X>,<Y>;<W>,<H>;<color>]`
* Simple colored semitransparent box
* `x` and `y` position the box relative to the top left of the menu
* `w` and `h` are the size of box
* `color` is color specified as a `ColorString`

#### `dropdown[<X>,<Y>;<W>;<name>;<item 1>,<item 2>, ...,<item n>;<selected idx>]`
* Show a dropdown field
* **Important note**: There are two different operation modes:
     1. handle directly on change (only changed dropdown is submitted)
     2. read the value on pressing a button (all dropdown values are available)
* `x` and `y` position of dropdown
* Width of dropdown
* Fieldname data is transferred to Lua
* Items to be shown in dropdown
* Index of currently selected dropdown item

#### `checkbox[<X>,<Y>;<name>;<label>;<selected>]`
* Show a checkbox
* `x` and `y`: position of checkbox
* `name` fieldname data is transferred to Lua
* `label` to be shown left of checkbox
* `selected` (optional): `true`/`false`

#### `scrollbar[<X>,<Y>;<W>,<H>;<orientation>;<name>;<value>]`
* Show a scrollbar
* There are two ways to use it:
     1. handle the changed event (only changed scrollbar is available)
     2. read the value on pressing a button (all scrollbars are available)
* `x` and `y`: position of trackbar
* `w` and `h`: width and height
* `orientation`:  `vertical`/`horizontal`
* Fieldname data is transferred to Lua
* Value this trackbar is set to (`0`-`1000`)
* See also `minetest.explode_scrollbar_event` (main menu: `engine.explode_scrollbar_event`)

#### `table[<X>,<Y>;<W>,<H>;<name>;<cell 1>,<cell 2>,...,<cell n>;<selected idx>]`
* Show scrollable table using options defined by the previous `tableoptions[]`
* Displays cells as defined by the previous `tablecolumns[]`
* `x` and `y`: position the itemlist relative to the top left of the menu
* `w` and `h` are the size of the itemlist
* `name`: fieldname sent to server on row select or doubleclick
* `cell 1`...`cell n`: cell contents given in row-major order
* `selected idx`: index of row to be selected within table (first row = `1`)
* See also `minetest.explode_table_event` (main menu: `engine.explode_table_event`)

#### `tableoptions[<opt 1>;<opt 2>;...]`
* Sets options for `table[]`
* `color=#RRGGBB`
     * default text color (`ColorString`), defaults to `#FFFFFF`
* `background=#RRGGBB`
     * table background color (`ColorString`), defaults to `#000000`
* `border=<true/false>`
     * should the table be drawn with a border? (default: `true`)
* `highlight=#RRGGBB`
     * highlight background color (`ColorString`), defaults to `#466432`
* `highlight_text=#RRGGBB`
     * highlight text color (`ColorString`), defaults to `#FFFFFF`
* `opendepth=<value>`
     * all subtrees up to `depth < value` are open (default value = `0`)
     * only useful when there is a column of type "tree"

#### `tablecolumns[<type 1>,<opt 1a>,<opt 1b>,...;<type 2>,<opt 2a>,<opt 2b>;...]`
* Sets columns for `table[]`
* Types: `text`, `image`, `color`, `indent`, `tree`
    * `text`:   show cell contents as text
    * `image`:  cell contents are an image index, use column options to define images
    * `color`:   cell contents are a ColorString and define color of following cell
    * `indent`: cell contents are a number and define indentation of following cell
    * `tree`:   same as indent, but user can open and close subtrees (treeview-like)
* Column options:
    * `align=<value>`
        * for `text` and `image`: content alignment within cells.
          Available values: `left` (default), `center`, `right`, `inline`
    * `width=<value>`
        * for `text` and `image`: minimum width in em (default: `0`)
        * for `indent` and `tree`: indent width in em (default: `1.5`)
    * `padding=<value>`: padding left of the column, in em (default `0.5`).
      Exception: defaults to 0 for indent columns
    * `tooltip=<value>`: tooltip text (default: empty)
    * `image` column options:
        * `0=<value>` sets image for image index 0
        * `1=<value>` sets image for image index 1
        * `2=<value>` sets image for image index 2
        * and so on; defined indices need not be contiguous empty or
          non-numeric cells are treated as `0`.
    * `color` column options:
        * `span=<value>`: number of following columns to affect (default: infinite)

**Note**: do _not_ use a element name starting with `key_`; those names are reserved to
pass key press events to formspec!

Spatial Vectors
---------------
* `vector.new(a[, b, c])`: returns a vector:
    * A copy of `a` if `a` is a vector.
    * `{x = a, y = b, z = c}`, if all `a, b, c` are defined
* `vector.direction(p1, p2)`: returns a vector
* `vector.distance(p1, p2)`: returns a number
* `vector.length(v)`: returns a number
* `vector.normalize(v)`: returns a vector
* `vector.floor(v)`: returns a vector, each dimension rounded down
* `vector.round(v)`: returns a vector, each dimension rounded to nearest int
* `vector.apply(v, func)`: returns a vector
* `vector.equals(v1, v2)`: returns a boolean

For the following functions `x` can be either a vector or a number:

* `vector.add(v, x)`: returns a vector
* `vector.subtract(v, x)`: returns a vector
* `vector.multiply(v, x)`: returns a scaled vector or Schur product
* `vector.divide(v, x)`: returns a scaled vector or Schur quotient

Helper functions
----------------
* `dump2(obj, name="_", dumped={})`
     * Return object serialized as a string, handles reference loops
* `dump(obj, dumped={})`
    * Return object serialized as a string
* `math.hypot(x, y)`
    * Get the hypotenuse of a triangle with legs x and y.
      Useful for distance calculation.
* `math.sign(x, tolerance)`
    * Get the sign of a number.
      Optional: Also returns `0` when the absolute value is within the tolerance (default: `0`)
* `string.split(str, separator=",", include_empty=false, max_splits=-1,
* sep_is_pattern=false)`
    * If `max_splits` is negative, do not limit splits.
    * `sep_is_pattern` specifies if separator is a plain string or a pattern (regex).
    * e.g. `string:split("a,b", ",") == {"a","b"}`
* `string:trim()`
    * e.g. `string.trim("\n \t\tfoo bar\t ") == "foo bar"`
* `minetest.is_yes(arg)`
    * returns whether `arg` can be interpreted as yes
* `minetest.get_us_time()`
    * returns time with microsecond precision. May not return wall time.
* `table.copy(table)`: returns a table
    * returns a deep copy of `table`

Minetest namespace reference
------------------------------

### Utilities

* `minetest.get_current_modname()`: returns the currently loading mod's name, when we are loading a mod
* `minetest.get_version()`: returns a table containing components of the
   engine version.  Components:
    * `project`: Name of the project, eg, "Minetest"
    * `string`: Simple version, eg, "1.2.3-dev"
    * `hash`: Full git version (only set if available), eg, "1.2.3-dev-01234567-dirty"
  Use this for informational purposes only. The information in the returned
  table does not represent the capabilities of the engine, nor is it
  reliable or verifyable. Compatible forks will have a different name and
  version entirely. To check for the presence of engine features, test
  whether the functions exported by the wanted features exist. For example:
  `if minetest.nodeupdate then ... end`.

### Logging
* `minetest.debug(...)`
    * Equivalent to `minetest.log(table.concat({...}, "\t"))`
* `minetest.log([level,] text)`
    * `level` is one of `"none"`, `"error"`, `"warning"`, `"action"`,
      `"info"`, or `"verbose"`.  Default is `"none"`.

### Global callback registration functions
Call these functions only at load time!

* `minetest.register_globalstep(func(dtime))`
    * Called every client environment step, usually interval of 0.1s
* `minetest.register_on_shutdown(func())`
    * Called before client shutdown
    * **Warning**: If the client terminates abnormally (i.e. crashes), the registered
      callbacks **will likely not be run**. Data should be saved at
      semi-frequent intervals as well as on server shutdown.
* `minetest.register_on_connect(func())`
    * Called at the end of client connection (when player is loaded onto map)
* `minetest.register_on_receiving_chat_message(func(name, message))`
    * Called always when a client receive a message
    * Return `true` to mark the message as handled, which means that it will not be shown to chat
* `minetest.register_on_sending_chat_message(func(name, message))`
    * Called always when a client send a message from chat
    * Return `true` to mark the message as handled, which means that it will not be sent to server
* `minetest.register_chatcommand(cmd, chatcommand definition)`
    * Adds definition to minetest.registered_chatcommands
* `minetest.register_on_death(func())`
    * Called when the local player dies
* `minetest.register_on_hp_modification(func(hp))`
    * Called when server modified player's HP
* `minetest.register_on_damage_taken(func(hp))`
    * Called when the local player take damages
* `minetest.register_on_formspec_input(func(formname, fields))`
    * Called when a button is pressed in the local player's inventory form
    * Newest functions are called first
    * If function returns `true`, remaining functions are not called
* `minetest.register_on_dignode(func(pos, node))`
    * Called when the local player digs a node
    * Newest functions are called first
    * If any function returns true, the node isn't dug
* `minetest.register_on_punchnode(func(pos, node))`
    * Called when the local player punches a node
    * Newest functions are called first
    * If any function returns true, the punch is ignored
* `minetest.register_on_placenode(function(pointed_thing, node))`    
    * Called when a node has been placed
### Sounds
* `minetest.sound_play(spec, parameters)`: returns a handle
    * `spec` is a `SimpleSoundSpec`
    * `parameters` is a sound parameter table
* `minetest.sound_stop(handle)`

### Timing
* `minetest.after(time, func, ...)`
    * Call the function `func` after `time` seconds, may be fractional
    * Optional: Variable number of arguments that are passed to `func`

### Map
* `minetest.get_node(pos)`
    * Returns the node at the given position as table in the format
      `{name="node_name", param1=0, param2=0}`, returns `{name="ignore", param1=0, param2=0}`
      for unloaded areas.
* `minetest.get_node_or_nil(pos)`
    * Same as `get_node` but returns `nil` for unloaded areas.
* `minetest.get_meta(pos)`
    * Get a `NodeMetaRef` at that position

### Player
* `minetest.get_wielded_item()`
    * Returns the itemstack the local player is holding
* `minetest.localplayer`
    * Reference to the LocalPlayer object. See `LocalPlayer` class reference for methods.

### Client Environment
* `minetest.get_player_names()`
    * Returns list of player names on server
* `minetest.disconnect()`
    * Disconnect from the server and exit to main menu.
    * Returns `false` if the client is already disconnecting otherwise returns `true`.
* `minetest.get_protocol_version()`
    * Returns the protocol version of the server.
    * Might not be accurate at start up as the client might not be connected to the server yet, in that case it will return 0.
* `minetest.take_screenshot()`
    * Take a screenshot.

### Misc.
* `minetest.parse_json(string[, nullvalue])`: returns something
    * Convert a string containing JSON data into the Lua equivalent
    * `nullvalue`: returned in place of the JSON null; defaults to `nil`
    * On success returns a table, a string, a number, a boolean or `nullvalue`
    * On failure outputs an error message and returns `nil`
    * Example: `parse_json("[10, {\"a\":false}]")`, returns `{10, {a = false}}`
* `minetest.write_json(data[, styled])`: returns a string or `nil` and an error message
    * Convert a Lua table into a JSON string
    * styled: Outputs in a human-readable format if this is set, defaults to false
    * Unserializable things like functions and userdata are saved as null.
    * **Warning**: JSON is more strict than the Lua table format.
        1. You can only use strings and positive integers of at least one as keys.
        2. You can not mix string and integer keys.
           This is due to the fact that JSON has two distinct array and object values.
    * Example: `write_json({10, {a = false}})`, returns `"[10, {\"a\": false}]"`
* `minetest.serialize(table)`: returns a string
    * Convert a table containing tables, strings, numbers, booleans and `nil`s
      into string form readable by `minetest.deserialize`
    * Example: `serialize({foo='bar'})`, returns `'return { ["foo"] = "bar" }'`
* `minetest.deserialize(string)`: returns a table
    * Convert a string returned by `minetest.deserialize` into a table
    * `string` is loaded in an empty sandbox environment.
    * Will load functions, but they cannot access the global environment.
    * Example: `deserialize('return { ["foo"] = "bar" }')`, returns `{foo='bar'}`
    * Example: `deserialize('print("foo")')`, returns `nil` (function call fails)
        * `error:[string "print("foo")"]:1: attempt to call global 'print' (a nil value)`
* `minetest.compress(data, method, ...)`: returns `compressed_data`
    * Compress a string of data.
    * `method` is a string identifying the compression method to be used.
    * Supported compression methods:
    *     Deflate (zlib): `"deflate"`
    * `...` indicates method-specific arguments.  Currently defined arguments are:
    *     Deflate: `level` - Compression level, `0`-`9` or `nil`.
* `minetest.decompress(compressed_data, method, ...)`: returns data
    * Decompress a string of data (using ZLib).
    * See documentation on `minetest.compress()` for supported compression methods.
    * currently supported.
    * `...` indicates method-specific arguments. Currently, no methods use this.
* `minetest.encode_base64(string)`: returns string encoded in base64
    * Encodes a string in base64.
* `minetest.decode_base64(string)`: returns string
    * Decodes a string encoded in base64.
* `minetest.gettext(string) : returns string
    * look up the translation of a string in the gettext message catalog
* `fgettext_ne(string, ...)`
    * call minetest.gettext(string), replace "$1"..."$9" with the given
      extra arguments and return the result
* `fgettext(string, ...)` : returns string
    * same as fgettext_ne(), but calls minetest.formspec_escape before returning result
* `minetest.pointed_thing_to_face_pos(placer, pointed_thing)`: returns a position
    * returns the exact position on the surface of a pointed node

### UI
* `minetest.ui.minimap`
    * Reference to the minimap object. See `Minimap` class reference for methods.
* `minetest.show_formspec(formname, formspec)` : returns true on success
	* Shows a formspec to the player
* `minetest.display_chat_message(message)` returns true on success
	* Shows a chat message to the current player.

Class reference
---------------

### Minimap
An interface to manipulate minimap on client UI

* `show()`: shows the minimap (if not disabled by server)
* `hide()`: hides the minimap
* `set_pos(pos)`: sets the minimap position on screen
* `get_pos()`: returns the minimap current position
* `set_angle(deg)`: sets the minimap angle in degrees
* `get_angle()`: returns the current minimap angle in degrees
* `set_mode(mode)`: sets the minimap mode (0 to 6)
* `get_mode()`: returns the current minimap mode
* `set_shape(shape)`: Sets the minimap shape. (0 = square, 1 = round)
* `get_shape()`: Gets the minimap shape. (0 = square, 1 = round)

### LocalPlayer
An interface to retrieve information about the player. The player is
not accessible until the client is fully done loading and therefore
not at module init time.

To get the localplayer handle correctly, use `on_connect()` as follows:

```lua
local localplayer
minetest.register_on_connect(function()
        localplayer = minetest.localplayer
end)
```

Methods:

* `get_pos()`
    * returns current player current position
* `get_velocity()`
    * returns player speed vector
* `get_hp()`
    * returns player HP
* `get_name()`
    * returns player name
* `got_teleported()`
    * returns true if player was teleported
* `is_attached()`
    * returns true if player is attached
* `is_touching_ground()`
    * returns true if player touching ground
* `is_in_liquid()`
    * returns true if player is in a liquid (This oscillates so that the player jumps a bit above the surface)
* `is_in_liquid_stable()`
    * returns true if player is in a stable liquid (This is more stable and defines the maximum speed of the player)
* `get_liquid_viscosity()`
    * returns liquid viscosity (Gets the viscosity of liquid to calculate friction)
* `is_climbing()`
    * returns true if player is climbing
* `swimming_vertical()`
    * returns true if player is swimming in vertical
* `get_physics_override()`
    * returns:

```lua
    {
        speed = float,
        jump = float,
        gravity = float,
        sneak = boolean,
        sneak_glitch = boolean
    }
```

* `get_override_pos()`
    * returns override position
* `get_last_pos()`
    * returns last player position before the current client step
* `get_last_velocity()`
    * returns last player speed
* `get_breath()`
    * returns the player's breath
* `get_look_dir()`
    * returns look direction vector
* `get_look_horizontal()`
    * returns look horizontal angle
* `get_look_vertical()`
    * returns look vertical angle
* `get_eye_pos()`
    * returns the player's eye position
* `get_eye_offset()`
    * returns the player's eye shift vector
* `get_movement_acceleration()`
    * returns acceleration of the player in different environments:

```lua
    {
       fast = float,
       air = float,
       default = float,
    }
```

* `get_movement_speed()`
    * returns player's speed in different environments:

```lua
    {
       walk = float,
       jump = float,
       crouch = float,
       fast = float,
       climb = float,
    }
```

* `get_movement()`
    * returns player's movement in different environments:

```lua
    {
       liquid_fluidity = float,
       liquid_sink = float,
       liquid_fluidity_smooth = float,
       gravity = float,
    }
```

* `get_last_look_horizontal()`:
    * returns last look horizontal angle
* `get_last_look_vertical()`:
    * returns last look vertical angle
* `get_key_pressed()`:
    * returns last key typed by the player

### Settings
An interface to read config files in the format of `minetest.conf`.

It can be created via `Settings(filename)`.

#### Methods
* `get(key)`: returns a value
* `get_bool(key)`: returns a boolean
* `set(key, value)`
* `remove(key)`: returns a boolean (`true` for success)
* `get_names()`: returns `{key1,...}`
* `write()`: returns a boolean (`true` for success)
    * write changes to file
* `to_table()`: returns `{[key1]=value1,...}`

### NodeMetaRef
Node metadata: reference extra data and functionality stored in a node.
Can be obtained via `minetest.get_meta(pos)`.

#### Methods
* `get_string(name)`
* `get_int(name)`
* `get_float(name)`
* `to_table()`: returns `nil` or a table with keys:
    * `fields`: key-value storage
    * `inventory`: `{list1 = {}, ...}}`

-----------------

### Chat command definition (`register_chatcommand`)

    {
        params = "<name> <privilege>", -- Short parameter description
        description = "Remove privilege from player", -- Full description
        func = function(param), -- Called when command is run.
                                      -- Returns boolean success and text output.
    }

Escape sequences
----------------
Most text can contain escape sequences, that can for example color the text.
There are a few exceptions: tab headers, dropdowns and vertical labels can't.
The following functions provide escape sequences:
* `minetest.get_color_escape_sequence(color)`:
    * `color` is a ColorString
    * The escape sequence sets the text color to `color`
* `minetest.colorize(color, message)`:
    * Equivalent to:
      `minetest.get_color_escape_sequence(color) ..
       message ..
       minetest.get_color_escape_sequence("#ffffff")`
* `color.get_background_escape_sequence(color)`
    * `color` is a ColorString
    * The escape sequence sets the background of the whole text element to
      `color`. Only defined for item descriptions and tooltips.
* `color.strip_foreground_colors(str)`
    * Removes foreground colors added by `get_color_escape_sequence`.
* `color.strip_background_colors(str)`
    * Removes background colors added by `get_background_escape_sequence`.
* `color.strip_colors(str)`
    * Removes all color escape sequences.

`ColorString`
-------------
`#RGB` defines a color in hexadecimal format.

`#RGBA` defines a color in hexadecimal format and alpha channel.

`#RRGGBB` defines a color in hexadecimal format.

`#RRGGBBAA` defines a color in hexadecimal format and alpha channel.

Named colors are also supported and are equivalent to
[CSS Color Module Level 4](http://dev.w3.org/csswg/css-color/#named-colors).
To specify the value of the alpha channel, append `#AA` to the end of the color name
(e.g. `colorname#08`). For named colors the hexadecimal string representing the alpha
value must (always) be two hexadecimal digits.
