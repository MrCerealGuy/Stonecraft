-- Use this fixture when loading full Technic mod.
-- Loads all required modules and fixtures for technic

-- Load modules required by tests
mineunit("core")
mineunit("player")
mineunit("protection")
mineunit("common/after")
mineunit("server")
mineunit("voxelmanip")
if mineunit:config("engine_version") ~= "mineunit" then
	mineunit("game/voxelarea")
end

-- Load fixtures required by tests
fixture("default")
fixture("mesecons")
fixture("digilines")
fixture("pipeworks")

-- Load technic_worldgen
fixture("technic_worldgen")
