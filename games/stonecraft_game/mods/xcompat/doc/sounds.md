# Sound API

## Option 1: Agnostically depend

You can do this by using a custom field in your node def instead of the `sounds` key.

```lua
minetest.register_node(nodename, {
    ...
    _sound_def = {
        key = "",
        input = {},
    },
    ...
})
```

where:

* key: string name of the field from the sound api you want to use, for example `node_sound_stone_defaults`
* input: table input of fields you want passed to the key field, used to override specific sounds.

## Option 2: Hard depend

add this mod to your mod.confs depends and directly call the sound_api as follows

```lua
minetest.register_node(nodename, {
    ...
    sounds = xcompat.sounds.node_sound_stone_defaults(input)
    ...
})
```

* input: optional table to override some or all of returned values