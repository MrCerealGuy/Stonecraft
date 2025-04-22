require("mineunit")
--[[
	Technic network unit tests.
	Execute busted at technic source directory.
--]]

-- Load fixtures required by tests
mineunit("core")
mineunit("player")
mineunit("protection")

fixture("pipeworks")
fixture("network")

sourcefile("machines/network")

sourcefile("machines/register/cables")
sourcefile("machines/LV/cables")
sourcefile("machines/MV/cables")
sourcefile("machines/HV/cables")

sourcefile("machines/register/generator")
sourcefile("machines/HV/generator")

world.layout({
	{{x=100,y=100,z=100}, "technic:lv_cable"},
	{{x=101,y=100,z=100}, "technic:lv_cable"},
	{{x=102,y=100,z=100}, "technic:lv_cable"},
	{{x=103,y=100,z=100}, "technic:lv_cable"},
	{{x=104,y=100,z=100}, "technic:lv_cable"},
	{{x=100,y=101,z=100}, "technic:switching_station"},

	{{x=100,y=200,z=100}, "technic:mv_cable"},
	{{x=101,y=200,z=100}, "technic:mv_cable"},
	{{x=102,y=200,z=100}, "technic:mv_cable"},
	{{x=103,y=200,z=100}, "technic:mv_cable"},
	{{x=104,y=200,z=100}, "technic:mv_cable"},
	{{x=100,y=201,z=100}, "technic:switching_station"},

	{{x=100,y=300,z=100}, "technic:hv_cable"},
	{{x=101,y=300,z=100}, "technic:hv_cable"},
	{{x=102,y=300,z=100}, "technic:hv_cable"},
	{{x=103,y=300,z=100}, "technic:hv_cable"},
	{{x=104,y=300,z=100}, "technic:hv_cable"},
	{{x=100,y=301,z=100}, "technic:switching_station"},

	-- For network lookup function -> returns correct network for position
	{{x=100,y=500,z=100}, "technic:hv_cable"},
	{{x=101,y=500,z=100}, "technic:hv_cable"},
	{{x=102,y=500,z=100}, "technic:hv_cable"},
	{{x=103,y=500,z=100}, "technic:hv_cable"},
	{{x=104,y=500,z=100}, "technic:hv_cable"},
	{{x=100,y=501,z=100}, "technic:hv_generator"},
	{{x=101,y=501,z=100}, "technic:hv_cable"},
	{{x=102,y=501,z=100}, "technic:switching_station"},
	{{x=100,y=502,z=100}, "technic:hv_cable"},
	{{x=101,y=502,z=100}, "technic:hv_cable"},
})

describe("Power network helper", function()

	-- Simple network position fixtures
	local net_id = 65536
	local pos    = { x = -32768, y = -32767, z = -32768 }
	local sw_pos = { x = -32768, y = -32766, z = -32768 }

	describe("network lookup functions", function()

		it("does not fail if network missing", function()
			assert.is_nil( technic.remove_network(9999) )
		end)

		it("returns correct position for network", function()
			assert.same(pos,    technic.network2pos(net_id) )
			assert.same(sw_pos, technic.network2sw_pos(net_id) )
		end)

		it("returns correct network for position", function()
			local net_id = technic.create_network({x=100,y=501,z=100})
			assert.same(net_id, technic.pos2network({x=100,y=500,z=100}) )
			assert.same(net_id, technic.sw_pos2network({x=100,y=501,z=100}) )
		end)

		it("returns nil tier for empty position", function()
			assert.is_nil(technic.sw_pos2tier({x=9999,y=9999,z=9999}))
		end)

		it("returns correct tier for switching station position", function()
			-- World is defined in fixtures/network.lua
			assert.same("LV", technic.sw_pos2tier({x=100,y=101,z=100}))
			assert.same("MV", technic.sw_pos2tier({x=100,y=201,z=100}))
			assert.same("HV", technic.sw_pos2tier({x=100,y=301,z=100}))
		end)

	end)

	describe("network constructors/destructors", function()

		-- Build network
		local net_id = technic.create_network({x=100,y=501,z=100})
		assert.is_number(net_id)

		it("creates network", function()
			assert.is_hashed(technic.networks[net_id])
		end)

		it("builds network", function()
			local net = technic.networks[net_id]
			-- Network table is valid
			assert.is_indexed(net.PR_nodes)
			assert.is_indexed(net.RE_nodes)
			assert.is_indexed(net.BA_nodes)
			assert.equals(9, count(net.all_nodes))
			assert.is_hashed(net.all_nodes)
		end)

		it("does not add duplicates to network", function()
			local net = technic.networks[net_id]
			-- Local network table is still valid
			assert.equals(1, count(net.PR_nodes))
			assert.equals(0, count(net.RE_nodes))
			assert.equals(0, count(net.BA_nodes))
			assert.equals(9, count(net.all_nodes))
			-- FIXME: This might be wrong if technic.cables should contain only cables and not machines
			assert.equals(9, count(technic.cables))
		end)

		it("removes network", function()
			technic.remove_network(net_id)
			assert.is_nil(technic.networks[net_id])
			-- TODO: Verify that there's no lefover positions in technic.cables
		end)

	end)

	--[[ TODO:
	technic.remove_network_node
	--]]

	describe("Power network timeout functions technic.touch_node and technic.get_timeout", function()

		it("returns zero if no data available", function()
			assert.equals(0,
				technic.get_timeout("LV", {x=9999,y=9999,z=9999})
			)
			assert.equals(0,
				technic.get_timeout("HV", {x=9999,y=9999,z=9999})
			)
		end)

		it("returns timeout if data is available", function()
			technic.touch_node("LV", {x=123,y=123,z=123}, 42)
			assert.equals(42,
				technic.get_timeout("LV", {x=123,y=123,z=123})
			)
			technic.touch_node("HV", {x=123,y=123,z=123}, 74)
			assert.equals(74,
				technic.get_timeout("HV", {x=123,y=123,z=123})
			)
		end)

	end)

end)

-- Clean up, left following here just for easy copy pasting stuff from previous proj

--[[
describe("Metatool API protection", function()

	it("metatool.is_protected bypass privileges", function()
		local value = metatool.is_protected(ProtectedPos(), Player(), "test_priv", true)
		assert.equals(false, value)
	end)

	it("metatool.is_protected no bypass privileges", function()
		local value = metatool.is_protected(ProtectedPos(), Player(), "test_priv2", true)
		assert.equals(true, value)
	end)

	it("metatool.is_protected bypass privileges, unprotected", function()
		local value = metatool.is_protected(UnprotectedPos(), Player(), "test_priv", true)
		assert.equals(false, value)
	end)

	it("metatool.is_protected no bypass privileges, unprotected", function()
		local value = metatool.is_protected(UnprotectedPos(), Player(), "test_priv2", true)
		assert.equals(false, value)
	end)

end)

describe("Metatool API tool namespace", function()

	it("Create invalid namespace", function()
		local tool = { ns = metatool.ns, name = 'invalid' }
		local value = tool:ns("invalid", {
			testkey = "testvalue"
		})
		assert.is_nil(metatool:ns("testns"))
	end)

	it("Get nonexistent namespace", function()
		assert.is_nil(metatool.ns("nonexistent"))
	end)

	it("Create tool namespace", function()
		-- FIXME: Hack to get fake tool available, replace with real tool
		local tool = { ns = metatool.ns, name = 'mytool' }
		metatool.tools["metatool:mytool"] = tool
		-- Actual tests
		local value = tool:ns({
			testkey = "testvalue"
		})
		local expected = {
			testkey = "testvalue"
		}
		assert.same(expected, metatool.ns("mytool"))
	end)

end)

describe("Metatool API tool registration", function()

	it("Register tool default configuration", function()
		-- Tool registration
		local definition = {
			description = 'UnitTestTool Description',
			name = 'UnitTestTool',
			texture = 'utt.png',
			recipe = {{'air'},{'air'},{'air'}},
			on_read_node = function(tooldef, player, pointed_thing, node, pos)
				local data, group = tooldef:copy(node, pos, player)
				return data, group, "on_read_node description"
			end,
			on_write_node = function(tooldef, data, group, player, pointed_thing, node, pos)
				tooldef:paste(node, pos, player, data, group)
			end,
		}
		local tool = metatool:register_tool('testtool0', definition)

		assert.is_table(tool)
		assert.equals("metatool:testtool0", tool.name)

		assert.is_table(tool)
		assert.equals(definition.description, tool.description)
		assert.equals(definition.name, tool.nice_name)
		assert.equals(definition.on_read_node, tool.on_read_node)
		assert.equals(definition.on_write_node, tool.on_write_node)

		-- Test configurable tool attributes
		assert.is_nil(tool.privs)
		assert.same({}, tool.settings)

		-- Namespace creation
		local mult = function(a,b) return a * b end
		tool:ns({ k1 = "v1", fn = mult })

		-- Retrieve namespace and and execute tests
		local ns = metatool.ns("testtool0")
		assert.same({ k1 = "v1", fn = mult }, ns)
		assert.equals(8, ns.fn(2,4))
	end)

	it("Register tool with configuration", function()
		-- Tool registration
		local definition = {
			description = 'UnitTestTool Description',
			name = 'UnitTestTool',
			texture = 'utt.png',
			recipe = {{'air'},{'air'},{'air'}},
			on_read_node = function(tooldef, player, pointed_thing, node, pos)
				local data, group = tooldef:copy(node, pos, player)
				return data, group, "on_read_node description"
			end,
			on_write_node = function(tooldef, data, group, player, pointed_thing, node, pos)
				tooldef:paste(node, pos, player, data, group)
			end,
		}
		local tool = metatool:register_tool('testtool2', definition)

		assert.is_table(tool)
		assert.equals("metatool:testtool2", tool.name)

		assert.is_table(tool)
		assert.equals(definition.description, tool.description)
		assert.equals(definition.name, tool.nice_name)
		assert.equals(definition.on_read_node, tool.on_read_node)
		assert.equals(definition.on_write_node, tool.on_write_node)

		-- Test configurable tool attributes
		assert.equals("test_testtool2_privs", tool.privs)
		local expected_settings = {
			extra_config_key = "testtool2_extra_config_value",
		}
		assert.same(expected_settings, tool.settings)

		-- Namespace creation
		local sum = function(a,b) return a + b end
		tool:ns({ k1 = "v1", fn = sum })

		-- Retrieve namespace and and execute tests
		local ns = metatool.ns("testtool2")
		assert.same({ k1 = "v1", fn = sum }, ns)
		assert.equals(9, ns.fn(2,7))
	end)

end)

describe("Metatool API node registration", function()

	it("Register node default configuration", function()
		local tool = metatool.tool("testtool0")
		assert.is_table(tool)
		assert.equals("metatool:testtool0", tool.name)
		assert.is_table(tool)

		local definition = {
			name = 'testnode1',
			nodes = {
				"testnode1",
				"nonexistent1",
				"testnode2",
				"nonexistent2",
			},
			tooldef = {
				group = 'test node',
				protection_bypass_write = "default_bypass_write_priv",
				copy = function(node, pos, player)
					print("nodedef copy callback executed")
				end,
				paste = function(node, pos, player, data)
					print("nodedef paste callback executed")
				end,
			}
		}
		tool:load_node_definition(definition)

		assert.is_table(tool.nodes)
		assert.is_table(tool.nodes.testnode1)
		assert.is_table(tool.nodes.testnode2)
		assert.is_nil(tool.nodes.nonexistent1)
		assert.is_nil(tool.nodes.nonexistent2)

		assert.is_function(tool.nodes.testnode1.before_read)
		assert.is_function(tool.nodes.testnode2.before_write)

		assert.equals(definition.tooldef.copy, tool.nodes.testnode1.copy)
		assert.equals(definition.tooldef.paste, tool.nodes.testnode2.paste)
		assert.equals("default_bypass_write_priv", definition.tooldef.protection_bypass_write)

		local expected_settings = {
			protection_bypass_write = "default_bypass_write_priv"
		}
		assert.same(expected_settings, tool.nodes.testnode1.settings)
		assert.same(expected_settings, tool.nodes.testnode2.settings)

	end)

	it("Register node with configuration", function()
		local tool = metatool.tool("testtool2")
		assert.is_table(tool)
		assert.equals("metatool:testtool2", tool.name)
		assert.is_table(tool)

		local definition = {
			name = 'testnode2',
			nodes = {
				"testnode1",
				"nonexistent1",
				"testnode2",
				"nonexistent2",
			},
			tooldef = {
				group = 'test node',
				protection_bypass_write = "default_bypass_write_priv",
				copy = function(node, pos, player)
					print("nodedef copy callback executed")
				end,
				paste = function(node, pos, player, data)
					print("nodedef paste callback executed")
				end,
			}
		}
		tool:load_node_definition(definition)

		assert.is_table(tool.nodes)
		assert.is_table(tool.nodes.testnode1)
		assert.is_table(tool.nodes.testnode2)
		assert.is_nil(tool.nodes.nonexistent1)
		assert.is_nil(tool.nodes.nonexistent2)

		assert.is_function(tool.nodes.testnode1.before_read)
		assert.is_function(tool.nodes.testnode2.before_write)

		assert.equals(definition.tooldef.copy, tool.nodes.testnode1.copy)
		assert.equals(definition.tooldef.paste, tool.nodes.testnode2.paste)
		assert.equals("testtool2_testnode2_bypass_write", tool.nodes.testnode1.protection_bypass_write)
		assert.equals("testtool2_testnode2_bypass_write", tool.nodes.testnode2.protection_bypass_write)
		assert.equals("testtool2_testnode2_bypass_info", tool.nodes.testnode1.protection_bypass_info)
		assert.equals("testtool2_testnode2_bypass_info", tool.nodes.testnode2.protection_bypass_info)
		assert.equals("testtool2_testnode2_bypass_read", tool.nodes.testnode1.protection_bypass_read)
		assert.equals("testtool2_testnode2_bypass_read", tool.nodes.testnode2.protection_bypass_read)

		local expected_settings = {
			protection_bypass_write = "testtool2_testnode2_bypass_write",
			protection_bypass_info = "testtool2_testnode2_bypass_info",
			protection_bypass_read = "testtool2_testnode2_bypass_read",
		}
		assert.same(expected_settings, tool.nodes.testnode1.settings)
		assert.same(expected_settings, tool.nodes.testnode2.settings)

	end)

end)

--]]
