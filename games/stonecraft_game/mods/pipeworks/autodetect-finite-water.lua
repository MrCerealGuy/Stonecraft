-- enable finite liquid in the presence of dynamic liquid to preserve water volume.
local enable = false

if minetest.get_modpath("dynamic_liquid") then
	pipeworks.logger("detected mod dynamic_liquid, enabling finite liquid flag")
	enable = true
end

pipeworks.toggles.finite_water = enable
