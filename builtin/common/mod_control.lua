
function core.is_world_option(option)
	assert(type(option) == "string")

	local world_conf_option = nil

	local DIR_DELIM = DIR_DELIM or "/"
	local world_file = core.get_worldpath()..DIR_DELIM.."world.mt"
	local world_conf = Settings(world_file)

	if world_conf ~= nil then
		world_conf_option = world_conf:get(option)
	end 

	if world_conf_option == "true" then
		return true
	end

	return false
end

function core.skip_mod(mod)
	assert(type(mod) == "string")

	return not core.is_world_option("enable_" .. mod)
end
