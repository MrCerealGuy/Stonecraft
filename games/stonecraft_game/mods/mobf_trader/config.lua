
mobf_trader.MAX_TRADER_PER_PLAYER = 12; -- players can only have this many traders
mobf_trader.MAX_MOBS_PER_PLAYER   = 24; -- ..and this many mobs alltogether

mobf_trader.TRADER_PRICE = 'default:gold_ingot 12';

-- all traders will offer a random subset of their possible trades
mobf_trader.ALL_TRADERS_RANDOM = true;
-- whenever a random trader gets a new offer added, he will have a random number of
-- these items in stock; the number is choosen randombly between these two values:
mobf_trader.RANDOM_STACK_MIN_SIZE = 1;
mobf_trader.RANDOM_STACK_MAX_SIZE = 10;

mobf_trader.global_trade_offers = {}

mobf_trader.add_as_trader = {"mobs:male1_npc", "mobs:male2_npc", "mobs:male3_npc",
			"mobs:female1_npc", "mobs:female2_npc", "mobs:female3_npc",
			"mobs:npc",
			"lottmobs:elf", "lottmobs:rohan_guard", "lottmobs:gondor_guard", "lottmobs:dunlending", "lottmobs:hobbit", "lottmobs:dwarf"}
