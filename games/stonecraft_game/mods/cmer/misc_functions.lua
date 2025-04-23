

local function translate_name(name)
	if name:find(":") == 1 then
		name = name:sub(2)
	end

	return name
end

local function is_water_node(node)
	if type(node) == "table" and node.groups ~= nil and (node.groups.liquid or node.groups.water) then
		return true
	end
	return false
end

local function is_burning_node(node)
	if type(node) == "table" and node.groups ~= nil and (node.groups.igniter or node.groups.fire or node.groups.lava) then
		return true
	end
	return false
end

return translate_name, is_water_node, is_burning_node
