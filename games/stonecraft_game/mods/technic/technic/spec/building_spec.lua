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

function get_network_fixture(sw_pos)
	-- Build network
	local net_id = technic.create_network(sw_pos)
	assert.is_number(net_id)
	local net = technic.networks[net_id]
	assert.is_table(net)
	return net
end

describe("Power network building", function()

	describe("cable building", function()

		world.layout({
			{{x=100,y=800,z=100}, "technic:hv_cable"},
			{{x=100,y=801,z=100}, "technic:switching_station"},
			{{x=101,y=800,z=100}, "technic:hv_cable"},
			{{x=101,y=801,z=100}, "technic:hv_generator"},
			--{{x=102,y=800,z=100}, "technic:hv_cable"}, -- This cable is built
			--{{x=102,y=801,z=100}, "technic:hv_cable"}, -- TODO: Add this cable as test case?
			{{x=103,y=800,z=100}, "technic:hv_cable"}, -- This should appear
			{{x=103,y=801,z=100}, "technic:hv_generator"}, -- This should appear
		})
		-- Build network
		local net = get_network_fixture({x=100,y=801,z=100})
		local build_pos = {x=102,y=800,z=100}

		it("does not crash", function()
			assert.equals(1, #net.PR_nodes)
			assert.equals(3, count(net.all_nodes))
			world.set_node(build_pos, {name="technic:hv_cable", param2=0})
			technic.network_node_on_placenode(build_pos, {"HV"}, "technic:hv_cable")
		end)

		it("is added to network", function()
			assert.same(build_pos, net.all_nodes[minetest.hash_node_position(build_pos)])
		end)

		it("adds all network nodes", function()
			assert.equals(6, count(net.all_nodes))
		end)

		it("adds connected machines to network without duplicates", function()
			assert.equals(2, #net.PR_nodes)
			--assert.equals({x=103,y=801,z=100}, net.PR_nodes[2])
		end)

	end)

	describe("cable building to machine", function()

		world.layout({
			{{x=100,y=810,z=100}, "technic:hv_cable"},
			{{x=100,y=811,z=100}, "technic:switching_station"},
			{{x=101,y=810,z=100}, "technic:hv_cable"},
			{{x=101,y=811,z=100}, "technic:hv_generator"},
			{{x=102,y=810,z=100}, "technic:hv_cable"}, 
            --{{x=102,y=811,z=100}, "technic:hv_cable"}, -- This cable is built
			--{{x=103,y=810,z=100}, "technic:hv_cable"}, -- This cable is built
			{{x=103,y=811,z=100}, "technic:hv_generator"}, -- This should appear
			{{x=103,y=812,z=100}, "technic:hv_cable"}, -- Unconnected cable
		})
		-- Build network
		local net = get_network_fixture({x=100,y=811,z=100})
		local build_pos = {x=103,y=810,z=100}
		local build_pos2 = {x=102,y=811,z=100}

		it("does not crash", function()
			assert.equals(1, #net.PR_nodes)
			assert.equals(4, count(net.all_nodes))
			world.set_node(build_pos, {name="technic:hv_cable", param2=0})
			technic.network_node_on_placenode(build_pos, {"HV"}, "technic:hv_cable")
		end)

		it("is added to network", function()
			assert.same(build_pos, net.all_nodes[minetest.hash_node_position(build_pos)])
		end)

		it("adds all network nodes", function()
			assert.equals(6, count(net.all_nodes))
		end)

		it("adds connected machines to network without duplicates", function()
			assert.equals(2, #net.PR_nodes)
			--assert.equals({x=103,y=801,z=100}, net.PR_nodes[2])
		end)

		it("does not add unconnected cables to network", function()
			assert.is_nil(net.all_nodes[minetest.hash_node_position({x=103,y=812,z=100})])
		end)

		it("does not duplicate already added machine", function()
			world.set_node(build_pos2, {name="technic:hv_cable", param2=0})
			technic.network_node_on_placenode(build_pos2, {"HV"}, "technic:hv_cable")
			assert.equals(2, #net.PR_nodes)
			assert.equals(7, count(net.all_nodes))
		end)

	end)

	describe("machine building", function()

		world.layout({
			{{x=100,y=820,z=100}, "technic:hv_cable"},
			{{x=100,y=821,z=100}, "technic:switching_station"},
			{{x=101,y=820,z=100}, "technic:hv_cable"},
			{{x=101,y=821,z=100}, "technic:hv_generator"},
			{{x=102,y=820,z=100}, "technic:hv_cable"},
			-- {{x=102,y=821,z=100}, "technic:hv_generator"}, -- This machine is built
			{{x=102,y=821,z= 99}, "technic:hv_cable"}, -- This should not be added to network
			{{x=102,y=821,z=101}, "technic:hv_cable"}, -- This should not be added to network
			{{x=103,y=820,z=100}, "technic:hv_cable"},
			{{x=103,y=821,z=100}, "technic:hv_generator"},
			-- Second network for overload test
			{{x=100,y=820,z=102}, "technic:hv_cable"},
			{{x=100,y=821,z=102}, "technic:switching_station"},
			-- {{x=100,y=820,z=101}, "technic:hv_generator"}, -- This machine is built, it should overload
		})
		-- Build network
		local net = get_network_fixture({x=100,y=821,z=100})
		local net2 = get_network_fixture({x=100,y=821,z=102})
		local build_pos = {x=102,y=821,z=100}
		local build_pos2 = {x=100,y=820,z=101}

		it("does not crash", function()
			assert.equals(2, #net.PR_nodes)
			assert.equals(6, count(net.all_nodes))
			world.set_node(build_pos, {name="technic:hv_generator",param2=0})
			technic.network_node_on_placenode(build_pos, {"HV"}, "technic:hv_generator")
		end)

		it("is added to network without duplicates", function()
			assert.same(build_pos, net.all_nodes[minetest.hash_node_position(build_pos)])
			assert.equals(7, count(net.all_nodes))
			assert.equals(3, #net.PR_nodes)
			assert.is_nil(technic.is_overloaded(net.id))
			assert.is_nil(technic.is_overloaded(net2.id))
		end)

		it("does not remove connected machines from network", function()
			assert.same({x=101,y=821,z=100},net.all_nodes[minetest.hash_node_position({x=101,y=821,z=100})])
			assert.same({x=103,y=821,z=100},net.all_nodes[minetest.hash_node_position({x=103,y=821,z=100})])
		end)

		it("does not remove network", function()
			assert.is_hashed(technic.networks[net.id])
		end)

		it("does not add cables to network", function()
			assert.is_nil(net.all_nodes[minetest.hash_node_position({x=102,y=821,z=99})])
			assert.is_nil(net.all_nodes[minetest.hash_node_position({x=102,y=821,z=101})])
		end)

		it("overloads network", function()
			world.set_node(build_pos2, {name="technic:hv_generator",param2=0})
			technic.network_node_on_placenode(build_pos2, {"HV"}, "technic:hv_generator")
			assert.not_nil(technic.is_overloaded(net.id))
			assert.not_nil(technic.is_overloaded(net2.id))
		end)

	end)

	describe("cable building between networks", function()

		world.layout({
			{{x=100,y=830,z=100}, "technic:hv_cable"},
			{{x=100,y=831,z=100}, "technic:switching_station"},
			--{{x=101,y=830,z=100}, "technic:hv_cable"}, -- This cable is built
			--{{x=101,y=831,z=100}, "technic:hv_cable"}, -- TODO: Add this cable as test case?
			{{x=102,y=830,z=100}, "technic:hv_cable"},
			{{x=102,y=831,z=100}, "technic:switching_station"},
		})
		-- Build network
		local net = get_network_fixture({x=100,y=831,z=100})
		local net2 = get_network_fixture({x=102,y=831,z=100})
		local build_pos = {x=101,y=830,z=100}

		it("does not crash", function()
			assert.equals(1, count(net.all_nodes))
			assert.equals(1, count(net2.all_nodes))
			world.set_node(build_pos, {name="technic:hv_cable", param2=0})
			technic.network_node_on_placenode(build_pos, {"HV"}, "technic:hv_cable")
		end)

		it("removes network", function()
			assert.is_nil(technic.networks[net.id])
			assert.is_nil(technic.networks[net2.id])
		end)

	end)

	describe("cable cutting", function()

		world.layout({
			{{x=100,y=900,z=100}, "technic:hv_cable"},
			{{x=100,y=901,z=100}, "technic:switching_station"},
			{{x=101,y=900,z=100}, "technic:hv_cable"},
			{{x=101,y=901,z=100}, "technic:hv_generator"},
			{{x=102,y=900,z=100}, "technic:hv_cable"}, -- This cable is digged
			{{x=103,y=900,z=100}, "technic:hv_cable"}, -- This should disappear
			{{x=103,y=901,z=100}, "technic:hv_generator"}, -- This should disappear
		})
		-- Build network
		local net = get_network_fixture({x=100,y=901,z=100})
		local build_pos = {x=102,y=900,z=100}

		it("does not crash", function()
			assert.equals(2, #net.PR_nodes)
			assert.equals(6, count(net.all_nodes))
			world.set_node(build_pos, {name="air",param2=0})
			technic.network_node_on_dignode(build_pos, {"HV"}, "technic:hv_cable")
		end)

		--[[ NOTE: Whole network is currently removed when cutting cables

		it("is removed from network", function()
			assert.is_nil(net.all_nodes[minetest.hash_node_position(build_pos)])
		end)

		it("removes connected cables from network", function()
			--assert.is_nil(net.all_nodes[minetest.hash_node_position({x=103,y=900,z=100})])
			assert.equals(3, count(net.all_nodes))
		end)

		it("removes connected machines from network", function()
			--assert.is_nil(net.all_nodes[minetest.hash_node_position({x=103,y=901,z=100})])
			assert.equals(1, #net.PR_nodes)
		end)
		--]]

		it("removes network", function()
			assert.is_nil(technic.networks[net.id])
		end)

	end)

	describe("cable digging below machine", function()

		world.layout({
			{{x=100,y=910,z=100}, "technic:hv_cable"},
			{{x=100,y=911,z=100}, "technic:switching_station"},
			{{x=101,y=910,z=100}, "technic:hv_cable"},
			{{x=101,y=911,z=100}, "technic:hv_generator"},
			{{x=102,y=910,z=100}, "technic:hv_cable"},
			{{x=103,y=910,z=100}, "technic:hv_cable"}, -- This cable is digged
			{{x=103,y=911,z=100}, "technic:hv_generator"}, -- This should disappear
			-- Multiple cable connections to machine at x 101, vertical cable
			{{x=101,y=910,z=101}, "technic:hv_cable"}, -- cables for second connection
			{{x=101,y=911,z=101}, "technic:hv_cable"}, -- cables for second connection, this cable is digged
		})
		-- Build network
		local net = get_network_fixture({x=100,y=911,z=100})
		local build_pos = {x=103,y=910,z=100}
		local build_pos2 = {x=101,y=911,z=101}

		it("does not crash", function()
			assert.equals(2, #net.PR_nodes)
			assert.equals(8, count(net.all_nodes))
			world.set_node(build_pos, {name="air",param2=0})
			technic.network_node_on_dignode(build_pos, {"HV"}, "technic:hv_cable")
		end)

		it("is removed from network", function()
			assert.is_nil(net.all_nodes[minetest.hash_node_position(build_pos)])
			assert.equals(6, count(net.all_nodes))
		end)

		it("removes connected machines from network", function()
			assert.is_nil(net.all_nodes[minetest.hash_node_position({x=103,y=911,z=100})])
			assert.equals(1, #net.PR_nodes)
		end)

		it("does not remove network", function()
			assert.is_hashed(technic.networks[net.id])
		end)

		it("keeps connected machines in network", function()
			world.set_node(build_pos2, {name="air",param2=0})
			technic.network_node_on_dignode(build_pos2, {"HV"}, "technic:hv_cable")
			assert.same({x=101,y=911,z=100}, net.all_nodes[minetest.hash_node_position({x=101,y=911,z=100})])
			assert.equals(1, #net.PR_nodes)
			assert.equals(5, count(net.all_nodes))
		end)

	end)

	describe("machine digging", function()

		world.layout({
			{{x=100,y=920,z=100}, "technic:hv_cable"},
			{{x=100,y=921,z=100}, "technic:switching_station"},
			{{x=101,y=920,z=100}, "technic:hv_cable"},
			{{x=101,y=921,z=100}, "technic:hv_generator"},
			{{x=102,y=920,z=100}, "technic:hv_cable"},
			{{x=102,y=921,z=100}, "technic:hv_generator"}, -- This machine is digged
			{{x=103,y=920,z=100}, "technic:hv_cable"},
			{{x=103,y=921,z=100}, "technic:hv_generator"},
		})
		-- Build network
		local net = get_network_fixture({x=100,y=921,z=100})
		local build_pos = {x=102,y=921,z=100}

		it("does not crash", function()
			assert.equals(3, #net.PR_nodes)
			assert.equals(7, count(net.all_nodes))
			world.set_node(build_pos, {name="air",param2=0})
			technic.network_node_on_dignode(build_pos, {"HV"}, "technic:hv_generator")
		end)

		it("is removed from network", function()
			assert.is_nil(net.all_nodes[minetest.hash_node_position(build_pos)])
		end)

		it("does not remove other nodes from network", function()
			assert.equals(2, #net.PR_nodes)
			assert.equals(6, count(net.all_nodes))
		end)

		it("does not remove connected machines from network", function()
			assert.same({x=101,y=921,z=100},net.all_nodes[minetest.hash_node_position({x=101,y=921,z=100})])
			assert.same({x=103,y=921,z=100},net.all_nodes[minetest.hash_node_position({x=103,y=921,z=100})])
			assert.equals(2, #net.PR_nodes)
		end)

		it("does not remove network", function()
			assert.is_hashed(technic.networks[net.id])
		end)

	end)

end)
