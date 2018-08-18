-- register new flow logic ABMs
-- written 2017 by thetaepsilon

local register = {}
pipeworks.flowlogic.abmregister = register

local flowlogic = pipeworks.flowlogic

-- register node list for the main logic function.
-- see flowlogic.run() in abms.lua.

local register_flowlogic_abm = function(nodename)
	if pipeworks.toggles.pipe_mode == "pressure" then
		minetest.register_abm({
			label = "pipeworks new_flow_logic run",
			nodenames = { nodename },
			interval = 1,
			chance = 1,
			action = function(pos, node, active_object_count, active_object_count_wider)
				flowlogic.run(pos, node)
			end
		})
	else
		minetest.log("warning", "pipeworks pressure_logic not enabled but register.flowlogic() requested")
	end
end
register.flowlogic = register_flowlogic_abm
