local sound_api = {}

--ks_sounds conversion
--currently loggy and bedrock are ignored
local ks = {}

function ks.node_sound_defaults(soundtable)
	soundtable = soundtable or {}
	soundtable.footstep = soundtable.footstep or ks_sounds.generalnode_sounds.footstep
	soundtable.dug = soundtable.dug or ks_sounds.generalnode_sounds.dug
    soundtable.dig = soundtable.dig or ks_sounds.generalnode_sounds.dig
	soundtable.place = soundtable.place or ks_sounds.generalnode_sounds.place
	return soundtable
end

function ks.node_sound_wood_defaults(soundtable)
	soundtable = soundtable or {}
	soundtable.footstep = soundtable.footstep or ks_sounds.woodennode_sounds.footstep
	soundtable.dug = soundtable.dug or ks_sounds.woodennode_sounds.dug
    soundtable.dig = soundtable.dig or ks_sounds.woodennode_sounds.dig
	soundtable.place = soundtable.place or ks_sounds.woodennode_sounds.place
	ks.node_sound_defaults(soundtable)
	return soundtable
end

function ks.node_sound_leaves_defaults(soundtable)
	soundtable = soundtable or {}
	soundtable.footstep = soundtable.footstep or ks_sounds.leafynode_sounds.footstep
	soundtable.dug = soundtable.dug or ks_sounds.leafynode_sounds.dug
    soundtable.dig = soundtable.dig or ks_sounds.leafynode_sounds.dig
	soundtable.place = soundtable.place or ks_sounds.leafynode_sounds.place
	ks.node_sound_defaults(soundtable)
	return soundtable
end

function ks.node_sound_snow_defaults(soundtable)
	soundtable = soundtable or {}
	soundtable.footstep = soundtable.footstep or ks_sounds.snowynode_sounds.footstep
	soundtable.dug = soundtable.dug or ks_sounds.snowynode_sounds.dug
    soundtable.dig = soundtable.dig or ks_sounds.snowynode_sounds.dig
	soundtable.place = soundtable.place or ks_sounds.snowynode_sounds.place
	ks.node_sound_defaults(soundtable)
	return soundtable
end

function sound_api.node_sound_default(soundtable)
    return ks.node_sound_default(soundtable)
end

function sound_api.node_sound_stone_defaults(soundtable)
    return soundtable
end

function sound_api.node_sound_dirt_defaults(soundtable)
    return soundtable
end

--return dirt as some games use dirt vs grass
function sound_api.node_sound_grass_defaults(soundtable)
    return sound_api.node_sound_dirt_defaults(soundtable)
end

function sound_api.node_sound_sand_defaults(soundtable)
    return soundtable
end

function sound_api.node_sound_gravel_defaults(soundtable)
    return soundtable
end

function sound_api.node_sound_wood_defaults(soundtable)
    return ks.node_sound_wood_default(soundtable)
end

function sound_api.node_sound_leaves_defaults(soundtable)
    return ks.node_sound_leaves_default(soundtable)
end

function sound_api.node_sound_glass_defaults(soundtable)
    return soundtable
end

function sound_api.node_sound_ice_defaults(soundtable)
    return soundtable
end

function sound_api.node_sound_metal_defaults(soundtable)
    return soundtable
end

function sound_api.node_sound_water_defaults(soundtable)
    return soundtable
end

function sound_api.node_sound_lava_defaults(soundtable)
    return soundtable
end

function sound_api.node_sound_snow_defaults(soundtable)
    return ks.node_sound_snow_default(soundtable)
end

function sound_api.node_sound_wool_defaults(soundtable)
    return soundtable
end

return sound_api