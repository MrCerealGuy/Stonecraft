[Mod] fence registration [fence_registration]

This mod adds a function for adding fences.  
For example to add an acacia wood fence, you only need to write following:  
```
minetest.register_fence({fence_of = "default:acacia_wood"})
```
the syntax looks approximately like this:
```
minetest.register_fence({fence_of = string[, texture = string, recipe = string, add_crafting = bool]}, table)
```
the second param can be used to set custom parts of the node definition, e.g.  
https://github.com/HybridDog/sumpf/blob/master/sumpf/birke.lua#L81-L82

**License:** see [LICENSE.txt](https://raw.githubusercontent.com/HybridDog/fence_registration/master/LICENSE.txt)  
**Download:** [zip](https://github.com/HybridDog/fence_registration/archive/master.zip), [tar.gz](https://github.com/HybridDog/fence_registration/tarball/master)  

![I'm a screenshot!](https://cloud.githubusercontent.com/assets/3192173/12020479/453e6578-ad7d-11e5-8a38-af972bd8360f.png)

If you got ideas or found bugs, please tell them to me.

[How to install a mod?](http://wiki.minetest.net/Installing_Mods)

