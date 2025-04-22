local papi = {}

local models = {}
function papi.register_model(name, def)
    models[name] = def
end

function papi.set_model(player, model_name)
    local model = models[model_name]

    if not model then return end

    player:set_properties({
        mesh = model_name,
        textures = model.textures,
        visual = "mesh",
        visual_size = model.visual_size,
        stepheight = model.stepheight
    })
end

function papi.get_animation(_)
    --stub to keep from crashing
end

function papi.get_textures(player)
    return player:get_properties().textures
end

function papi.set_textures(player, textures)
    player:set_properties({textures = textures})
end

function papi.set_animation(player, anim_name, speed, loop)
    player:set_animation(fl_player.animations[anim_name], speed, 0, loop)
end

local metatable = {
    __index = function (_, key)
        return fl_player.ignore[key]
    end,
    __newindex = function (_, key, value)
        rawset(fl_player.ignore, key, value)
    end
}

papi.player_attached = {}

setmetatable(papi.player_attached, metatable)

return papi