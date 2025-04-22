local papi = {}

function papi.register_model(name, def)
    return mcl_player.player_register_model(name, def)
end

function papi.set_model(player, model)
    return mcl_player.player_set_model(player, model)
end

function papi.get_animation(player)
    return mcl_player.player_get_animation(player)
end

function papi.get_textures(player)
    return player:get_properties().textures
end

function papi.set_textures(player, textures)
    player:set_properties({textures = textures})
end

function papi.set_animation(player, anim_name, speed, _)
    return mcl_player.player_set_animation(player, anim_name, speed)
end

local metatable = {
    __index = function (_, key)
        return mcl_player.player_attached[key]
    end,
    __newindex = function (_, key, value)
        rawset(mcl_player.player_attached, key, value)
    end
}

papi.player_attached = {}

setmetatable(papi.player_attached, metatable)

return papi