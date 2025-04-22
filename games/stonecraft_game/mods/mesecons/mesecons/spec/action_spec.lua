require("mineunit")

fixture("mesecons")

describe("action queue", function()
	local layout = {
		{{x =  1, y = 0, z = 0}, "mesecons:test_receptor_off"},
		{{x =  0, y = 0, z = 0}, "mesecons:test_conductor_off"},
		{{x = -1, y = 0, z = 0}, "mesecons:test_conductor_off"},
		{{x =  0, y = 1, z = 0}, "mesecons:test_effector"},
		{{x = -1, y = 1, z = 0}, "mesecons:test_effector"},
	}

	before_each(function()
		world.layout(layout)
	end)

	after_each(function()
		mesecon._test_reset()
		world.clear()
	end)

	it("executes in order", function()
		world.set_node(layout[1][1], "mesecons:test_receptor_on")
		mesecon.receptor_on(layout[1][1], mesecon.rules.alldirs)
		mineunit:execute_globalstep() -- Execute receptor_on action
		mineunit:execute_globalstep() -- Execute activate/change actions
		assert.equal(2, #mesecon._test_effector_events)
		assert.same({"on", layout[4][1]}, mesecon._test_effector_events[1])
		assert.same({"on", layout[5][1]}, mesecon._test_effector_events[2])

		world.set_node(layout[1][1], "mesecons:test_receptor_off")
		mesecon.receptor_off(layout[1][1], mesecon.rules.alldirs)
		mineunit:execute_globalstep() -- Execute receptor_off action
		mineunit:execute_globalstep() -- Execute deactivate/change actions
		assert.equal(4, #mesecon._test_effector_events)
		assert.same({"off", layout[4][1]}, mesecon._test_effector_events[3])
		assert.same({"off", layout[5][1]}, mesecon._test_effector_events[4])
	end)

	it("discards outdated/overwritten node events", function()
		world.set_node(layout[1][1], "mesecons:test_receptor_on")
		mesecon.receptor_on(layout[1][1], mesecon.rules.alldirs)
		world.set_node(layout[1][1], "mesecons:test_receptor_off")
		mesecon.receptor_off(layout[1][1], mesecon.rules.alldirs)
		mineunit:execute_globalstep() -- Execute receptor_off action
		mineunit:execute_globalstep() -- Execute deactivate/change actions
		assert.equal(0, #mesecon._test_effector_events)
	end)

	it("delays actions", function()
		world.set_node(layout[1][1], "mesecons:test_receptor_on")
		mesecon.queue:add_action(layout[1][1], "receptor_on", {mesecon.rules.alldirs}, 1, nil)
		mineunit:execute_globalstep(0.1)
		mineunit:execute_globalstep(1)
		assert.equal(0, #mesecon._test_effector_events)
		mineunit:execute_globalstep() -- Execute receptor_on action
		assert.equal(0, #mesecon._test_effector_events)
		mineunit:execute_globalstep() -- Execute activate/change actions
		assert.equal(2, #mesecon._test_effector_events)
	end)
end)
