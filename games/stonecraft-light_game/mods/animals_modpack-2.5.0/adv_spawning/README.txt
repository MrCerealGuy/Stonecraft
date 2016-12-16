********************************************************************************
*                                                                              *
*              Advanced spawning mod (adv_spawning) 0.0.6                      *
*                                                                              *
*     URL: http://github.com/sapier/adv_spawning                               *
*     Author: sapier                                                           *
*                                                                              *
********************************************************************************


Description:
--------------------
Advances spawning mod is designed to provide a feature rich yet easy to use
spawner for entites. It's purpose is to support spawning within large numbers
of different environments. While adv_spawning supports a wide configurable range
of spawning situations, it's performance impact is clamped at minimal level.
To achieve this performance goal adv_spawning is intended for low frequency
entity spawning only. Typical spawn rate will be a low single digit count of
entities per second throughout whole world.


API:
--------------------
adv_spawning.register(spawner_name,spawning_def) --> successfull true/false
^ register a spawn to adv_spawning mechanisms
^ spawner_name a unique spawner name
^ spawning_def is configuration of spawner

adv_spawning.statistics() --> statistics data about spawning

Spawning definition:
--------------------
{
	spawnee = "some_mod:entity_name", -- name of entity to spawn OR function to be called e.g. func(pos)
	absolute_height =     -- absolute y value to check
	{
		min = 1,          -- minimum height to spawn at
		max = 5           -- maximum height to spawn at
	}

	relative_height =     --relative y value to next non environment node
	{
		min = 1,          -- minimum height above non environment node
		max = 5           -- maximum height above non environment node
	}

	spawn_inside,         -- [MANDATORY] list of nodes to to spawn within (see spawn inside example)
	surfaces,             -- list of nodes to spawn uppon (same format as spawn_inside)

	entities_around =     -- list of surrounding entity definitions
	{
		entity_def_1,
		entity_def_2,
		...
	},

	nodes_around =        -- list of surrounding node definitions
	{
		node_def_1,
		node_def_2,
		...
	},

	light_around =        -- list of light around definitions
	{
		light_around_def_1,
		light_around_def_2,
		...
	},

	humidity_around =     -- list of humidity around definitions
	{
		humidity_around_def_1,
		humidity_around_def_2,
		...
	},

	temperature_around =  -- list of temperature around definitions
	{
		temperature_around_def_1,
		temperature_around_def_2,
		...
	},

	mapgen =                 -- configuration for initial mapgen spawning
	{
		enabled = true,      -- mapgen spawning enabled or not
		retries = 5,         -- number of tries to spawn a entity prior giving up
		spawntotal = 3,      -- number of entities to try on mapgen
	},


	flat_area =              -- check for amount of flat area around,
							 -- (only usefull for ground bound mobs)
	{
		range = 3,           -- range to be checked for flattness
		deviation = 2,       -- maximum number of nodes not matching flat check
	},

	daytimes =               -- do only spawn within these daytimes
	{
		daytime_def_1,
		daytime_def_2,
		...
	}

	collisionbox = {},       -- collisionbox of entity to spawn (usually same as used for entiy itself)
	spawn_interval = 200,    -- [MANDATORY] interval to try to spawn a entity
	spawns_per_interval = 1, -- try to spawn multiple mobs (if time available)
	custom_check = fct(pos,spawndef), -- a custom check to be called return true for pass, false for not pass
	cyclic_spawning = true   -- spawn per spawner step (defaults to true)
}

Light around definition:
{
	type = "TIMED_MIN",       -- type of light around check
							  -- TIMED_MIN/TIMED_MAX at least this light level at specified time within whole distance
							  -- OVERALL_MAX,OVERALL_MIN at least this light level at any time
							  -- CURRENT_MIN,CURRENT_MAX at least this light level now
	distance = 2,             -- distance to check (be carefull high distances may cause lag)
							  -- WARNING: light check is a very very heavy operation don't use large distances
	threashold = 2,           -- value to match at max/at least to pass this check
	time = 6000               -- time to do check at (TIMED_MIN/TIMED_MAX only)
}

Surrounding node definition:
{
	type = "MIN",             -- type of surround check valid types are MIN and MAX
	name = { "default:tree" },-- name(s) of node(s) to check
	distance = 7,             -- distance to look for node
	threshold = 1             -- number to match at max/at least to pass this check
}

Surrounding entity definition:
{
	type = "MIN",              -- type of surround check valid types are MIN and MAX
	entityname = "mod:entity", -- name of entity to check (nil to match all)
	distance = 3,              -- distance to look for this entity
	threshold = 2              -- number to match at max/at least to pass this check
}

Surrounding temperature definition:
{
	type = "MIN",              -- type of surround check valid types are MIN and MAX
	distance = 3,              -- distance to look for this temperature
	threshold = 2              -- number to match at max/at least to pass this check
}

Surrounding humidity definition:
{
	type = "MIN",              -- type of surround check valid types are MIN and MAX
	distance = 3,              -- distance to look for this humidity
	threshold = 2              -- number to match at max/at least to pass this check
}

spawn_inside definition (list of nodenames):
{
	"air",
	"default:water_source",
	"default:water_flowing"
}

Daytime definition:
{
	begin = 0.0,               --minimum daytime
	stop  = 0.25,              --maximum daytime
}

Statistics:
{
	session =
	{
		spawners_created = 0,   -- number of spawners created this session
		entities_created = 0,   -- number of spawns done
		steps = 0,              -- number of steps
	},
	step =
	{
		min = 0,                -- minimum time required for a single step
		max = 0,                -- maximum time required for a single step
		last = 0,               -- last steps time
	},
	load =
	{
		min = 0,                -- minimum load caused
		max = 0,                -- maximum load caused
		cur = 0,                -- load caused in last step
		avg = 0                 -- average load caused
	}
}

Settings:
  adv_spawning_validate_spawners = false
  ^ make advanced_spawning check area around active players for lost spawner seeds

Changelog:

0.0.9
 -Fix broken spawner initialization
 -Add support for regenerating spawner seeds (only around active players)
  set >>adv_spawning_validate_spawners<< to true if you want advanced spawning
  to do this.
  Note: this might need some additional cpu time

0.0.8
 -Fix large steps caused by uninterruptable spawn seed initialization within activation

0.0.7
 -handle time steps backward without assertion

0.0.6
 -add configuration option adv_spawing.debug to show or hide spawner entities
 -fix quota overflow calculation
 -add rightclick function to show debug info

0.0.5
 -fix MIN/MAX to always return a number value
 -fix default activity range to use a initial value if not manually configured
 -don't calculate statistics with zero dtime
 -fix invalid debug log using old variable name