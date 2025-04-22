
-- Generate schematics

local air = {name = "air"}
local san = {name = "default:sand"}
local sst = {name = "default:sandstone"}
local ssb = {name = "default:sandstonebrick"}
local luc = {name = "lucky_block:lucky_block"}
local lav = {name = "default:lava_source"}
local dir = {name = "default:dirt"}
local sow = {name = "farming:soil_wet"}
local wat = {name = "default:water_source"}
local whe = {name = "farming:wheat_8"}
local cot = {name = "farming:cotton_8"}
local obg = {name = "default:obsidian_glass"}
local fir = {name = "fire:basic_flame"}
local obs = {name = "default:obsidian"}

local platform = {
	size = {x = 5, y = 3, z = 5},
	data = {
		sst, sst, sst, sst, sst,
		ssb, ssb, ssb, ssb, ssb,
		ssb, ssb, ssb, ssb, ssb,

		sst, sst, sst, sst, sst,
		ssb, luc, air, luc, ssb,
		ssb, air, air, air, ssb,

		sst, sst, sst, sst, sst,
		ssb, air, air, air, ssb,
		ssb, air, air, air, ssb,

		sst, sst, sst, sst, sst,
		ssb, luc, air, luc, ssb,
		ssb, air, air, air, ssb,

		sst, sst, sst, sst, sst,
		ssb, ssb, ssb, ssb, ssb,
		ssb, ssb, ssb, ssb, ssb
	}
}

local insta_farm = {
	size = {x = 5, y = 3, z = 3},
	data = {
		dir, dir, dir, dir, dir,
		sow, sow, sow, sow, sow,
		cot, cot, cot, cot, cot,

		sow, dir, dir, dir, sow,
		sow, wat, wat, wat, sow,
		cot, air, air, air, whe,

		dir, dir, dir, dir, san,
		sow, sow, sow, sow, sow,
		whe, whe, whe, whe, whe
	}
}

local lava_trap = {
	size = {x = 3, y = 6, z = 3},
	data = {
		lav, lav, lav,
		air, air, air,
		air, air, air,
		air, air, air,
		air, air, air,
		air, air, air,

		lav, lav, lav,
		air, air, air,
		air, air, air,
		air, air, air,
		air, air, air,
		air, air, air,

		lav, lav, lav,
		air, air, air,
		air, air, air,
		air, air, air,
		air, air, air,
		air, air, air
	}
}

local sand_trap = {
	size = {x = 3, y = 3, z = 3},
	data = {
		san, san, san,
		san, san, san,
		san, san, san,

		san, san, san,
		san, san, san,
		san, san, san,

		san, san, san,
		san, san, san,
		san, san, san
	}
}

local water_trap = {
	size = {x = 3, y = 3, z = 3},
	data = {
		obg, obg, obg,
		obg, obg, obg,
		obg, obg, obg,

		obg, obg, obg,
		obg, wat, obg,
		obg, obg, obg,

		obg, obg, obg,
		obg, obg, obg,
		obg, obg, obg
	}
}

local fire_trap = {
	size = {x = 3, y = 3, z = 3},
	data = {
		fir, fir, fir,
		fir, fir, fir,
		fir, fir, fir,

		fir, fir, fir,
		fir, fir, fir,
		fir, fir, fir,

		fir, fir, fir,
		fir, fir, fir,
		fir, fir, fir
	}
}

local obsidian_trap = {
	size = {x = 3, y = 3, z = 3},
	data = {
		obs, obs, obs,
		obs, obs, obs,
		obs, obs, obs,

		obs, air, obs,
		obs, air, obs,
		obs, lav, obs,

		obs, obs, obs,
		obs, obs, obs,
		obs, obs, obs
	}
}

-- add schematics to list

lucky_block:add_schematics({
	{"watertrap", water_trap, {x = 1, y = 0, z = 1}},
	{"sandtrap", sand_trap, {x = 1, y = 0, z = 1}},
	{"lavatrap", lava_trap, {x = 1, y = 5, z = 1}},
	{"platform", platform, {x = 2, y = 1, z = 2}},
	{"instafarm", insta_farm, {x = 2, y = 2, z = 1}},
	{"firetrap", fire_trap, {x = 1, y = 0, z = 1}},
	{"obsidiantrap", obsidian_trap, {x = 1, y = 0, z = 1}}
})
