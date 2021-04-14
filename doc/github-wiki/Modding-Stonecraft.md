1. [Modding Stonecraft](#modding-stonecraft)
	1. [Installing mods](#installing-mods)
	2. [Installing texture packs](#installing-texture-packs)
		1. [Server texture pack](#server-texture-pack)
	3. [Profiling mods](#profiling-mods)

# Modding Stonecraft

If you wish to make your own mod for Stonecraft, I recommend to learn how the engine works and to become familiar with the Lua API. The following links can be useful:

1. Learn the structure of the **Minetest engine**  
http://dev.minetest.net/Main_Page

2. Learn the **Lua programming language**  
https://www.lua.org/pil/contents.html

3. Learn the **Lua Mod API**  
http://rubenwardy.com/minetest_modding_book/

## Installing mods

You can get mods from the [Minetest community](http://www.minetest.net/customize/), I can give no warranties that they work with Stonecraft. The mods are installed globally and enabled per world.

The common place to install them is _&lt;YOUR/STONECRAFT/DIRECTORY&gt;/mods/_. After extracting the mod there you need to enable it for your world. This can either be done in the GUI by clicking on "Configure" in the world selection, or by adding 

```
load_mod_<modname> = true
```

in the _world.mt_ file in the world directory.

Note that newly installed mods are disabled for all worlds by default, so you explicitly need to enable them.

If you want to use a mod only in a specified world, then you have to extract your mod in _&lt;YOUR/STONECRAFT/DIRECTORY&gt;/worlds/&lt;YOUR-WORLD&gt;/worldmods/_.

## Installing texture packs

You will find a folder called _textures_ in your Stonecraft base folder. Place the texture pack there. Start Stonecraft and select a new style in the _textures tab_.

### Server texture pack

If you create a server and want that the texture pack works not only for you, change the texture pack name to _server_.

## Profiling mods

To activate the profiler simple add to stonecraft.conf following line:

```
profiler.load = true
```

Start a game and make sure you have server privileges. Open the console and type

```
/profiler print
```

to get the current statistics.

Here you see the usage of the profiler command:

```
/profiler print [filter] | dump [filter] | save [format [filter]] | reset
```

Available save formats: txt, csv, lua, json, json_pretty