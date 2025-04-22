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

function papi.set_animation(_, _, _, _)
    --stub to keep from crashing
end

--nothing to do here as we have no globalstep .....that we know about anyways
papi.player_attached = {}

return papi