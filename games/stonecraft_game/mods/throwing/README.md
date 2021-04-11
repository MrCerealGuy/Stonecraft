# Throwing

## Developed by the Eurythmia team

This mod is an API for registering throwing and throwable things.

Mods based on this API:
* [throwing_arrows](https://github.com/minetest-mods/throwing_arrows) is a compatible replacement for the throwing mod by PilzAdam.
* [sling](https://github.com/minetest-mods/sling) is a mod written by @tacotexmex that enables item stack and single item throwing of any item.
* [Native American Village](https://github.com/Steamed-Punk/Native-American-Village), by Steamed-Punk, adds, among many other various items, a tomahawk that can be thrown.

## Configuration

The settings are the following:
```
# Trajectory parameters
throwing.vertical_acceleration = -10
throwing.realistic_trajectory = false
throwing.frictional_coefficient = -.5

# How the initial velocity of arrows is computed: simple, strength, or momentum
throwing.velocity_mode = strength
throwing.velocity_factor = 19

# Whether to allow placing an arrow as a node
throwing.allow_arrow_placing = false

# Minimum time between two shots
throwing.bow_cooldown = 0.2

# Whether to enable toolranks for bows
throwing.toolranks = true
```

### Trajectory parameters

By default, the trajectory of the arrow is a simple parabola. You can set the vertical acceleration (acceleration of gravity) using `throwing.vertical_acceleration`.

If you want a more realistic trajectory that uses a first-order modelling of air friction, you can set `throwing.realistic_trajectory` to true. In this mode, `throwing.frictional_coefficient` indicates the ratio between the friction force on the arrow and its velocity. It should be negative. The acceleration of the arrow is subsequently determined by dividing the force by the "mass" of the arrow, the reference mass of 1 being the mass of the steel arrow in `throwing_arrows`. Generally, the frictional coefficient should be quite small; a value of -1 will already drastically shorten the range of the arrow. The default is -0.5.

### Initial velocity computation

The mod provides three modes to compute the initial velocity of an arrow after it is shot: simple, strength and momentum.

In simple mode, the initial velocity of the arrow is always the same. The value of this velocity is controlled by the `throwing.velocity_factor` setting, which defaults to 19.

In strength mode (the default), the initial velocity of the arrow only depends on the bow that is used---the more expensive the bow, the faster the arrow. The bow strength is multiplied by the velocity factor to compute the speed of the arrow. For reference, the steel bow in `throwing_arrows` has a strength of about 1.

Finally, momentum mode is the most realistic. It computes the velocity of the arrow based on the bow strength, as in the strength mode, and on the mass of the arrow: the heavier the arrow, the slower it will be shot. It is called the momentum mode because, in this mode, the strength of a bow indicates the initial momentum of the arrow rather than its initial speed.

## API

There are two available functions in the mod API:
```lua
function throwing.register_bow(name, definition)
--[[
Name: Bow name. If it doesn't contain ":", the "throwing:" prefix will be added.
Definition: definition table, containing:
  * description (highly recommended): description of the bow.
  * texture (essential): texture of the bow, shown in inventory.
  * groups (optional): groups of the item.
  * uses: number of uses of the bow (the default is 50).
  * allow_shot (optional): function(player, itemstack, index, last_run):
    - player: the player using the bow
    - itemstack: the itemstack of the bow
    - index: index of the arrow in the inventory
    - last_run: whether this is the last time this function is called before actually calling `spawn_arrow_entity`.
      Currently, `allow_shot` is actually run twice (once before the delay, and once after).
    - should return true if the shot can be made, and false otherwise
    - the default function checks that the arrow to be thrown is a registered arrow
    - it can return a second return value, which is the new itemstack to replace the arrow after the shot
  * throw_itself (optional): whether the bow should throw itself instead of the arrow next to it in the inventory.
    The default is false.
  * cooldown: bow cooldown. Default is setting throwing.bow_cooldown
  * function spawn_arrow_entity(position, arrow, player): defaults to throwing.spawn_arrow_entity
  * sound: sound to be played when the bow is used
  * delay: delay before throwing the arrow
  * no_toolranks: If true, toolranks support is disabled for this item. Defaults to false.
  * strength: strength of the bow, see above. Defaults to 1.
]]

-- Example:
throwing.register_bow("bow_wood", {
	itemcraft = "default:wood",
	description = "Wooden Bow",
	texture = "throwing_bow_wood.png"
})

itemcraft, craft_quantity, description, tiles, on_hit_sound, on_hit[, on_throw[, groups]]
function throwing.register_arrow(name, definition table)
--[[
Name: Arrow name. If it doesn't contain ":", the "throwing:" prefix will be added.
Definition: definition table, containing:
  * tiles (essential): tiles of the arrow.
  * target (optional, defaulting to throwing.target_both): what the arrow is able to hit (throwing.target_node, throwing.target_object, throwing.target_both).
  * allow_protected (optional, defaulting to false): whether the arrow can be throw in a protected area
  * mass (optional, defaulting to 1): the mass of the arrow (see above)
  * on_hit_sound (optional): sound played when the arrow hits a node or an object.
  * on_hit(self, pos, last_pos, node, object, hitter, data) (optional but very useful): callback function:
    - pos: the position of the hit node or object.
    - last_pos: the last air node where the arrow was
    - node and object: hit node or object. Either node or object is nil, depending
      whether the arrow hit a node or an object.
    - hitter: an ObjectRef to the thrower player.
    - data: a data table associated to the entity where you can store what you want
    - self: the arrow entity table (it allows you to hack a lot!)
    - If it fails, it should return:
      false[, reason]
  * on_throw(self, pos, thrower, itemstack, index, data) (optional): callback function: on_throw:
    - pos: the position from where the arrow is throw (which a bit higher than the hitter position)
    - thrower: an ObjectRef to the thrower player
    - next_index: the index next to the arrow in the "main" inventory
    - data: a data table associated to the entity where you can store what you want
    - self: the arrow entity table
    - If the arrow shouldn't be thrown, it should return false.
  * on_throw_sound (optional, there is a default sound, specify "" for no sound): sound to be played when the arrow is throw
  * on_hit_fails(self, pos, thrower, data) (optional): callback function called if the hit failed (e.g. because on_hit returned false or because the area was protected)
]]

-- Example:
throwing.register_arrow("arrow", {
	itemcraft = "default:steel_ingot",
	craft_quantity = 16,
	description = "Arrow",
	tiles = {"throwing_arrow.png", "throwing_arrow.png", "throwing_arrow_back.png", "throwing_arrow_front.png", "throwing_arrow_2.png", "throwing_arrow.png"},
	target = throwing.target_object,
	on_hit_sound = "throwing_arrow",
	on_hit = function(pos, _, _, object, hitter)
		object:punch(hitter, 1, {
			full_punch_interval = 1,
			damage_groups = {fleshy = 3}
		})
	end
})
```

If the item to throw is an arrow registered using `throwing.register_arrow`, the entity used will be the entity automatically registered by this function.
Otherwise, if its definition contains a `throwing_entity` field, this field will be used as the entity name if it is a string, otherwise it will be called as a `function(pos, player)` that has to spawn the object and return the corresponding ObjectRef.
If the item is neither an arrow nor has a `throwing_entity` field, the corresponding `__builtin:item` will be used.
