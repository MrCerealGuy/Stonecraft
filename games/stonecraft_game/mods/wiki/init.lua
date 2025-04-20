
local MODPATH = minetest.get_modpath("wiki")

wikilib = { }

-- TODO: just adopt io.open and minetest.mkdir
local private = {}
private.open = io.open
private.mkdir = minetest.mkdir

loadfile(MODPATH.."/strfile.lua")(private)
loadfile(MODPATH.."/wikilib.lua")(private)
loadfile(MODPATH.."/internal.lua")(private)
loadfile(MODPATH.."/wikicmd.lua")(private)
loadfile(MODPATH.."/plugins.lua")(private)

loadfile(MODPATH.."/plugin_forum.lua")(private)
