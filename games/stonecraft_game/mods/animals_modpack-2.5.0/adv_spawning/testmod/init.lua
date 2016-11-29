

minetest.register_entity("testmod:bogus_1",
		{
			collisionbox    = { -0.5,-0.5,-0.5,0.5,0.5,0.5 },
			visual          = "sprite",
			textures        = { "testmod_num1.png" },
			physical        = false,
			groups          = { "immortal" },
		}
	)

minetest.register_entity("testmod:bogus_2",
		{
			collisionbox    = { -0.5,-0.5,-0.5,0.5,0.5,0.5 },
			visual          = "sprite",
			textures        = { "testmod_num2.png" },
			physical        = false,
			groups          = { "immortal" },
		}
	)

minetest.register_entity("testmod:bogus_3",
		{
			collisionbox    = { -0.5,-0.5,-0.5,0.5,0.5,0.5 },
			visual          = "sprite",
			textures        = { "testmod_num3.png" },
			physical        = false,
			groups          = { "immortal" },
		}
	)

minetest.register_entity("testmod:bogus_4",
		{
			collisionbox    = { -0.5,-0.5,-0.5,0.5,0.5,0.5 },
			visual          = "sprite",
			textures        = { "testmod_num4.png" },
			physical        = false,
			groups          = { "immortal" },
		}
	)

--adv_spawning.register("some_bogus_entity_1",
--	{
--	spawnee = "testmod:bogus_1",
--	spawn_interval = 10,
--
--	spawn_inside =
--		{
--			"air"
--		},
--
--	entities_around =
--		{
--			{ type="MAX",entityname = "testmod:bogus_1",distance=20,threshold=1 }
--		},
--
--	relative_height =
--		{
--		max = 1
--		}
--	})

--adv_spawning.register("some_bogus_entity_2",
--	{
--	spawnee = "testmod:bogus_2",
--	spawn_interval = 5,
--	spawn_inside =
--		{
--			"air"
--		},
--
--	entities_around =
--		{
--			{ type="MAX",distance=20,threshold=1 }
--		},
--
--	relative_height =
--		{
--		max = 1
--		},
--
--	surfaces =
--	{
--		"default:dirt_with_grass"
--	}
--	})

--adv_spawning.register("some_bogus_entity_3",
--	{
--	spawnee = "testmod:bogus_3",
--	spawn_interval = 3,
--	spawn_inside =
--		{
--			"air"
--		},
--
--	entities_around =
--		{
--			{ type="MAX",entityname = "testmod:bogus_4",distance=20,threshold=1 }
--		},
--
--	relative_height =
--		{
--		max = 4,
--		min = 4,
--		},
--	})

adv_spawning.register("some_bogus_entity_4",
	{
	spawnee = "testmod:bogus_4",
	spawn_interval = 3,
	spawn_inside =
		{
			"air"
		},

	entities_around =
		{
			{ type="MAX",distance=30,threshold=1 }
		},

	relative_height =
		{
		max = 4,
		min = 4,
		},
	surfaces =
		{
		"default:leaves"
		}
	})


minetest.register_chatcommand("adv_stats",
	{
		params		= "",
		description = "print advanced spawning satistics to logfile" ,
		func		= function()
			local stats = adv_spawning.get_statistics()

			adv_spawning.dbg_log(0, "Adv. Spawning stats:")
			adv_spawning.dbg_log(0, "----------------------------------------")
			adv_spawning.dbg_log(0, "Spawners added: " .. stats.session.spawners_created)
			adv_spawning.dbg_log(0, "Spawnees added: " .. stats.session.entities_created)
			adv_spawning.dbg_log(0, "")
			adv_spawning.dbg_log(0, "Longest step: " .. stats.step.max)
			adv_spawning.dbg_log(0, "")
			adv_spawning.dbg_log(0, "Current load: " .. stats.load.cur)
			adv_spawning.dbg_log(0, "Average load: " .. stats.load.avg)
			adv_spawning.dbg_log(0, "Maximum load: " .. stats.load.max)
		end
	})