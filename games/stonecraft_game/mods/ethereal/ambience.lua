
-- mushroom biome

ambience.add_set("ethereal_mushroom", {

	frequency = 40,

	sounds = {
		{name = "ethereal_mushroom", length = 1.3, ephemeral = true},
		{name = "ethereal_mushroom", length = 1.3, pitch = 0.9, ephemeral = true},
		{name = "ethereal_mushroom", length = 1.3, pitch = 1.2, ephemeral = true},
	},

	nodes = ({"ethereal:mushroom_trunk", "ethereal:mushroom_dirt"}),

	sound_check = function(def)

		local c = (def.totals["ethereal:mushroom_trunk"] or 0)
		local d = (def.totals["ethereal:mushroom_dirt"] or 0)

		if c > 30 and d > 70 then return "ethereal_mushroom" end
	end
})

-- frost biome

ambience.add_set("ethereal_crystal", {

	frequency = 50,

	sounds = {
		{name = "ethereal_crystal", length = 2.3, gain = 2.0, ephemeral = true},
		{name = "ethereal_crystal", length = 2.3, gain = 2.0, pitch = 0.9, ephemeral = true},
		{name = "ethereal_crystal", length = 2.3, gain = 2.0, pitch = 1.1, ephemeral = true},
	},

	nodes = ({"ethereal:crystal_spike", "ethereal:crystal_dirt"}),

	sound_check = function(def)

		local c = (def.totals["ethereal:crystal_spike"] or 0)
		local d = (def.totals["ethereal:crystal_dirt"] or 0)

		if c > 0 and d > 70 then return "ethereal_crystal" end
	end
})
