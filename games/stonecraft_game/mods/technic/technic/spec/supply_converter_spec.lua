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

sourcefile("machines/supply_converter")

function get_network_fixture(sw_pos)
	-- Build network
	local net_id = technic.create_network(sw_pos)
	assert.is_number(net_id)
	local net = technic.networks[net_id]
	assert.is_table(net)
	return net
end

describe("Supply converter", function()

	describe("building", function()

		world.layout({
			{{x=100,y=820,z=100}, "technic:hv_cable"},
			{{x=100,y=821,z=100}, "technic:switching_station"},
			{{x=101,y=820,z=100}, "technic:hv_cable"},
			{{x=101,y=821,z=100}, "technic:supply_converter"},
			{{x=102,y=820,z=100}, "technic:hv_cable"},
			-- {{x=102,y=821,z=100}, "technic:supply_converter"}, -- This machine is built
			{{x=102,y=822,z=100}, "technic:mv_cable"},            -- Supply network for placed SC
			{{x=102,y=823,z=100}, "technic:switching_station"},   -- Supply network for placed SC
			{{x=102,y=821,z= 99}, "technic:hv_cable"},            -- This should not be added to network
			{{x=102,y=821,z=101}, "technic:hv_cable"},            -- This should not be added to network
			{{x=103,y=820,z=100}, "technic:hv_cable"},
			-- Second network for overload test
			{{x=100,y=820,z=102}, "technic:hv_cable"},
			{{x=100,y=821,z=102}, "technic:switching_station"},
			-- {{x=100,y=820,z=101}, "technic:supply_converter"}, -- This machine is built, it should overload
		})
		-- Build network
		local net = get_network_fixture({x=100,y=821,z=100}) -- Output network for SC
		local net2 = get_network_fixture({x=102,y=823,z=100}) -- Input network for SC
		local net3 = get_network_fixture({x=100,y=821,z=102}) -- Overload test network (tests currently disabled)
		local build_pos = {x=102,y=821,z=100}
		local build_pos2 = {x=100,y=820,z=101}

		it("does not crash", function()
			assert.equals(1, #net.PR_nodes)
			assert.equals(1, #net.RE_nodes)
			assert.equals(5, count(net.all_nodes))
			assert.equals(0, #net2.PR_nodes)
			assert.equals(0, #net2.RE_nodes)
			assert.equals(1, count(net2.all_nodes))
			world.set_node(build_pos, {name="technic:supply_converter",param2=0})
			technic.network_node_on_placenode(build_pos, {"HV"}, "technic:supply_converter")
		end)

		it("is added to network without duplicates", function()
			assert.same(build_pos, net.all_nodes[minetest.hash_node_position(build_pos)])
			assert.equals(6, count(net.all_nodes))
			assert.equals(2, #net.PR_nodes)
			assert.equals(2, #net.RE_nodes)
			assert.equals(2, count(net2.all_nodes))
			assert.equals(1, #net2.PR_nodes)
			assert.equals(1, #net2.RE_nodes)
			assert.is_nil(technic.is_overloaded(net.id))
			assert.is_nil(technic.is_overloaded(net2.id))
		end)

		it("does not remove connected machines from network", function()
			assert.same({x=101,y=821,z=100},net.all_nodes[minetest.hash_node_position({x=101,y=821,z=100})])
		end)

		it("does not remove networks", function()
			assert.is_hashed(technic.networks[net.id])
			assert.is_hashed(technic.networks[net2.id])
		end)

		it("does not add cables to network", function()
			assert.is_nil(net.all_nodes[minetest.hash_node_position({x=102,y=821,z=99})])
			assert.is_nil(net.all_nodes[minetest.hash_node_position({x=102,y=821,z=101})])
		end)

		it("overloads network", function()
			pending("overload does not work with supply converter")
			world.set_node(build_pos2, {name="technic:supply_converter",param2=0})
			technic.network_node_on_placenode(build_pos2, {"HV"}, "technic:supply_converter")
			assert.not_nil(technic.is_overloaded(net.id))
			assert.is_nil(technic.is_overloaded(net2.id))
			assert.not_nil(technic.is_overloaded(net3.id))
		end)

	end)

	describe("digging", function()

		world.layout({
			{{x=100,y=990,z=100}, "technic:hv_cable"},
			{{x=100,y=991,z=100}, "technic:switching_station"},
			{{x=101,y=990,z=100}, "technic:hv_cable"},
			{{x=102,y=990,z=100}, "technic:hv_cable"},
			{{x=102,y=991,z=100}, "technic:supply_converter"}, -- This machine is digged
			{{x=102,y=991,z=101}, "technic:hv_cable"},
		})
		-- Build network
		local net = get_network_fixture({x=100,y=991,z=100})
		local build_pos = {x=102,y=991,z=100}

		it("does not crash", function()
			assert.equals(1, #net.PR_nodes)
			assert.equals(1, #net.RE_nodes)
			assert.equals(4, count(net.all_nodes))
			world.set_node(build_pos, {name="air",param2=0})
			technic.network_node_on_dignode(build_pos, {"HV"}, "technic:supply_converter")
		end)

		it("is removed from network", function()
			assert.is_nil(technic.pos2network(build_pos))
			assert.is_nil(technic.cables[minetest.hash_node_position(build_pos)])
			assert.is_nil(net.all_nodes[minetest.hash_node_position(build_pos)])
		end)

		it("does not remove other nodes from network", function()
			assert.equals(3, count(net.all_nodes))
		end)

		it("does not remove network", function()
			assert.is_hashed(technic.networks[net.id])
		end)

	end)

	describe("formspec", function()

		it("is protected", function()
			local pos = {x=-10,y=-10,z=-10}
			local Sam = Player("Sam", { interact = 1 })
			local SX = Player("SX", { interact = 1 })
			local def = minetest.registered_nodes["technic:supply_converter"]

			-- Build supply converter to pos and protect it for Sam
			world.set_node(pos, "technic:supply_converter")
			def.on_construct(pos)
			mineunit:protect(pos, "Sam")

			-- Read current metadata for validation
			local meta = minetest.get_meta(pos)
			local power = meta:get_int("power")
			local enabled = meta:get_int("enabled")

			assert.equals(10000, power)
			assert.equals(1, enabled)

			-- SX is not owner and cannot edit, values should not change
			def.on_receive_fields(pos, nil, { power = 1500, disable = 1}, SX)
			assert.equals(power, meta:get_int("power"))
			assert.equals(enabled, meta:get_int("enabled"))

			-- If missing player data values should not change
			def.on_receive_fields(pos, nil, { power = 1500, disable = 1}, nil)
			assert.equals(power, meta:get_int("power"))
			assert.equals(enabled, meta:get_int("enabled"))

			-- Sam is owner and can edit, values should change
			def.on_receive_fields(pos, nil, { power = 1500, disable = 1}, Sam)
			assert.equals(1500, meta:get_int("power"))
			assert.equals(0, meta:get_int("enabled"))
		end)

	end)

end)
