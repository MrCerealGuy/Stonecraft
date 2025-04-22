# minetest-toolranks [toolranks]

Minetest tool ranks mod

Tools gain levels for digging nodes. Higher level tools dig faster and take longer to wear out.

## Licence
Code: LGPLv2.1+  
Tool level sound: [CC BY 3.0](https://freesound.org/people/MakoFox/sounds/126422/)

## Are you a mod developer?

Does one of your mods add new tools?
If so, to support this mod, add this code to your mod, after your tool's code:

```lua
if minetest.get_modpath("toolranks") then
    minetest.override_item("mymod:mytool", {
        original_description = "My Tool",
        description = toolranks.create_description("My Tool"),
        after_use = toolranks.new_afteruse
    })
    end
end
```

Or alternatively, you can use the helper function:

```lua
toolranks.add_tool("mymod:mytool")
```
