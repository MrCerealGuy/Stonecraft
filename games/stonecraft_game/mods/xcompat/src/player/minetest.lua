local papi = {}

function papi.register_model(name, def)
    return player_api.register_model(name, def)
end

function papi.set_model(player, model)
    return player_api.set_model(player, model)
end

function papi.get_animation(player)
    return player_api.get_animation(player)
end

function papi.get_textures(player)
    return player_api.get_textures(player)
end

function papi.set_textures(player, texture)
    return player_api.set_textures(player, texture)
end

function papi.set_animation(player, anim_name, speed, loop)
    return player_api.set_animation(player, anim_name, speed, loop)
end


local metatable = {
    __index = function (_, key)
        return player_api.player_attached[key]
    end,
    __newindex = function (_, key, value)
        rawset(player_api.player_attached, key, value)
    end
}

papi.player_attached = {}

setmetatable(papi.player_attached, metatable)

return papi