-- Load technic_worldgen mod

mineunit:set_modpath("technic_worldgen", "../technic_worldgen")

mineunit:set_current_modname("technic_worldgen")
sourcefile("../technic_worldgen/init")
mineunit:restore_current_modname()
