-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file constants.lua
--! @brief constants used within miner mob
--! @copyright Sapier
--! @author Sapier
--! @date 2015-12-20
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

MINER_MAX_TUNNEL_SIZE = 5
MINER_DIG_SOUND_INTERVAL = 0.6

MINER_HAND_TOOLDEF = {
	tool_capabilities = 
	{
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
			snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
			oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0}
		},
		damage_groups = {fleshy=1},
	}
}

MINER_GROUPS = { not_in_creative_inventory=1 }

DIR_NORTH = "zplus"
DIR_SOUTH = "zminus"
DIR_EAST  = "xplus"
DIR_WEST  = "xminus"