local sound_api = {}

function sound_api.node_sound_default(soundtable)
    return default.node_sound_defaults(soundtable)
end

function sound_api.node_sound_stone_defaults(soundtable)
    return default.node_sound_stone_defaults(soundtable)
end

function sound_api.node_sound_dirt_defaults(soundtable)
    return default.node_sound_dirt_defaults(soundtable)
end

--return dirt as some games use dirt vs grass
function sound_api.node_sound_grass_defaults(soundtable)
    return sound_api.node_sound_dirt_defaults(soundtable)
end

function sound_api.node_sound_sand_defaults(soundtable)
    return default.node_sound_sand_defaults(soundtable)
end

function sound_api.node_sound_gravel_defaults(soundtable)
    return default.node_sound_gravel_defaults(soundtable)
end

function sound_api.node_sound_wood_defaults(soundtable)
    return default.node_sound_wood_defaults(soundtable)
end

function sound_api.node_sound_leaves_defaults(soundtable)
    return default.node_sound_leaves_defaults(soundtable)
end

function sound_api.node_sound_glass_defaults(soundtable)
    return default.node_sound_glass_defaults(soundtable)
end


function sound_api.node_sound_ice_defaults(soundtable)
    return default.node_sound_ice_defaults(soundtable)
end

function sound_api.node_sound_metal_defaults(soundtable)
    return default.node_sound_metal_defaults(soundtable)
end

function sound_api.node_sound_water_defaults(soundtable)
    return default.node_sound_water_defaults(soundtable)
end

function sound_api.node_sound_lava_defaults(soundtable)
    --s/lava/water
    return default.node_sound_water_defaults(soundtable)
end

function sound_api.node_sound_snow_defaults(soundtable)
    return default.node_sound_snow_defaults(soundtable)
end

function sound_api.node_sound_wool_defaults(soundtable)
    --s/wool/default
    return default.node_sound_defaults(soundtable)
end

return sound_api