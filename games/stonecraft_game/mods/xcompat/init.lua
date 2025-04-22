local modpath = minetest.get_modpath("xcompat")

xcompat = {
    modpath = modpath,
}

xcompat.gameid = dofile(modpath .. "/src/gameid.lua")
xcompat.utilities = dofile(modpath .. "/src/utilities.lua")

xcompat.sounds = dofile(modpath .. "/src/sounds.lua")
xcompat.materials = dofile(modpath .. "/src/materials.lua")
xcompat.textures = dofile(modpath .. "/src/textures.lua")
xcompat.functions = dofile(modpath .. "/src/functions.lua")
xcompat.player = dofile(modpath .. "/src/player.lua")

local function validate_sound(key)
    if key and xcompat.sounds[key] then
        return true
    elseif key then
        minetest.log("warning", "attempted to call invalid sound: "..key)
    else
        minetest.log("warning", "sound_def is missing a sound_api key")
    end
    return false
end

minetest.register_on_mods_loaded(function()
    for name, def in pairs(minetest.registered_nodes) do
        if def._sound_def and validate_sound(def._sound_def.key) then
            minetest.override_item(name, {
                sounds = xcompat.sounds[def._sound_def.key](def._sound_def.input)
            })
        end
    end

    local old_reg_node = minetest.register_node
    function minetest.register_node(name, def)
        if def._sound_def and validate_sound(def._sound_def.key) then
            def.sounds = xcompat.sounds[def._sound_def.key](def._sound_def.input)
        end

        old_reg_node(name, def)
    end
end)

dofile(modpath .. "/src/commands.lua")

if minetest.get_modpath("mtt") and mtt.enabled then
    -- register tests
    dofile(modpath .. "/mtt.lua")
end
