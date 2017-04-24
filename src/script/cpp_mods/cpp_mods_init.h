#ifndef CPP_MODS_INIT_H_
#define CPP_MODS_INIT_H_

/* erosion */
int lc_pmain_mod_erosion_init(lua_State * L);

/* darkage */
int lc_pmain_mod_darkage_init(lua_State * L);
int lc_pmain_mod_darkage_building(lua_State * L);
int lc_pmain_mod_darkage_furniture(lua_State * L);
int lc_pmain_mod_darkage_mapgen(lua_State * L);
int lc_pmain_mod_darkage_stairs(lua_State * L);

/* forest */
int lc_pmain_mod_forest_init(lua_State * L);
int lc_pmain_mod_forest_fir(lua_State * L);
int lc_pmain_mod_forest_mapgen(lua_State * L);
int lc_pmain_mod_forest_mud(lua_State * L);
int lc_pmain_mod_forest_oil(lua_State * L);
int lc_pmain_mod_forest_ores(lua_State * L);
int lc_pmain_mod_forest_seasons(lua_State * L);
int lc_pmain_mod_forest_register_tree(lua_State * L);
int lc_pmain_mod_forest_thermometer(lua_State * L);
int lc_pmain_mod_forest_tree_growing(lua_State * L);
int lc_pmain_mod_forest_trees(lua_State * L);

/* mg_villages */
int lc_pmain_mod_mg_villages_init(lua_State * L);
int lc_pmain_mod_mg_villages_buildings(lua_State * L);
int lc_pmain_mod_mg_villages_chat_commands(lua_State * L);
int lc_pmain_mod_mg_villages_config(lua_State * L);
int lc_pmain_mod_mg_villages_fill_chest(lua_State * L);
int lc_pmain_mod_mg_villages_highlandpools(lua_State * L);
int lc_pmain_mod_mg_villages_init_weights(lua_State * L);
int lc_pmain_mod_mg_villages_mapgen(lua_State * L);
int lc_pmain_mod_mg_villages_map_of_world(lua_State * L);
int lc_pmain_mod_mg_villages_name_gen(lua_State * L);
int lc_pmain_mod_mg_villages_nodes(lua_State * L);
int lc_pmain_mod_mg_villages_protection(lua_State * L);
int lc_pmain_mod_mg_villages_replacements(lua_State * L);
int lc_pmain_mod_mg_villages_spawn_player(lua_State * L);
int lc_pmain_mod_mg_villages_terrain_blend(lua_State * L);
int lc_pmain_mod_mg_villages_trees(lua_State * L);
int lc_pmain_mod_mg_villages_villages(lua_State * L);
int lc_pmain_mod_mg_villages_village_types(lua_State * L);

/* biome_lib */
int lc_pmain_mod_biome_lib_init(lua_State * L);

/* mines */
int lc_pmain_mod_mines_init(lua_State * L);

/* nssm */
int lc_pmain_mod_nssm_init(lua_State * L);
int lc_pmain_mod_nssm_ant_queen(lua_State * L);
int lc_pmain_mod_nssm_ant_soldier(lua_State * L);
int lc_pmain_mod_nssm_ant_worker(lua_State * L);
int lc_pmain_mod_nssm_api(lua_State * L);
int lc_pmain_mod_nssm_black_widow(lua_State * L);
int lc_pmain_mod_nssm_bloco(lua_State * L);
int lc_pmain_mod_nssm_crab(lua_State * L);
int lc_pmain_mod_nssm_crocodile(lua_State * L);
int lc_pmain_mod_nssm_daddy_long_legs(lua_State * L);
int lc_pmain_mod_nssm_darts(lua_State * L);
int lc_pmain_mod_nssm_dolidrosaurus(lua_State * L);
int lc_pmain_mod_nssm_duck(lua_State * L);
int lc_pmain_mod_nssm_duckking(lua_State * L);
int lc_pmain_mod_nssm_echidna(lua_State * L);
int lc_pmain_mod_nssm_enderduck(lua_State * L);
int lc_pmain_mod_nssm_flying_duck(lua_State * L);
int lc_pmain_mod_nssm_giant_sandworm(lua_State * L);
int lc_pmain_mod_nssm_icelamander(lua_State * L);
int lc_pmain_mod_nssm_icesnake(lua_State * L);
int lc_pmain_mod_nssm_kraken(lua_State * L);
int lc_pmain_mod_nssm_larva(lua_State * L);
int lc_pmain_mod_nssm_lava_titan(lua_State * L);
int lc_pmain_mod_nssm_manticore(lua_State * L);
int lc_pmain_mod_nssm_mantis(lua_State * L);
int lc_pmain_mod_nssm_mantis_beast(lua_State * L);
int lc_pmain_mod_nssm_masticone(lua_State * L);
int lc_pmain_mod_nssm_mese_dragon(lua_State * L);
int lc_pmain_mod_nssm_moonheron(lua_State * L);
int lc_pmain_mod_nssm_night_master(lua_State * L);
int lc_pmain_mod_nssm_nssm_api(lua_State * L);
int lc_pmain_mod_nssm_nssm_materials(lua_State * L);
int lc_pmain_mod_nssm_nssm_spears(lua_State * L);
int lc_pmain_mod_nssm_nssm_weapons(lua_State * L);
int lc_pmain_mod_nssm_octopus(lua_State * L);
int lc_pmain_mod_nssm_phoenix(lua_State * L);
int lc_pmain_mod_nssm_pumpboom(lua_State * L);
int lc_pmain_mod_nssm_pumpking(lua_State * L);
int lc_pmain_mod_nssm_rainbow_staff(lua_State * L);
int lc_pmain_mod_nssm_sand_bloco(lua_State * L);
int lc_pmain_mod_nssm_sandworm(lua_State * L);
int lc_pmain_mod_nssm_scrausics(lua_State * L);
int lc_pmain_mod_nssm_signosigno(lua_State * L);
int lc_pmain_mod_nssm_snow_biter(lua_State * L);
int lc_pmain_mod_nssm_spawn(lua_State * L);
int lc_pmain_mod_nssm_spiderduck(lua_State * L);
int lc_pmain_mod_nssm_stone_eater(lua_State * L);
int lc_pmain_mod_nssm_swimming_duck(lua_State * L);
int lc_pmain_mod_nssm_tarantula(lua_State * L);
int lc_pmain_mod_nssm_uloboros(lua_State * L);
int lc_pmain_mod_nssm_werewolf(lua_State * L);
int lc_pmain_mod_nssm_white_werewolf(lua_State * L);

/* ethereal */
int lc_pmain_mod_ethereal_init(lua_State * L);
int lc_pmain_mod_ethereal_bonemeal(lua_State * L);
int lc_pmain_mod_ethereal_compatibility(lua_State * L);
int lc_pmain_mod_ethereal_crystal(lua_State * L);
int lc_pmain_mod_ethereal_dirt(lua_State * L);
int lc_pmain_mod_ethereal_extra(lua_State * L);
int lc_pmain_mod_ethereal_fences(lua_State * L);
int lc_pmain_mod_ethereal_fishing(lua_State * L);
int lc_pmain_mod_ethereal_flowers(lua_State * L);
int lc_pmain_mod_ethereal_food(lua_State * L);
int lc_pmain_mod_ethereal_gates(lua_State * L);
int lc_pmain_mod_ethereal_leaves(lua_State * L);
int lc_pmain_mod_ethereal_mapgen(lua_State * L);
int lc_pmain_mod_ethereal_mushroom(lua_State * L);
int lc_pmain_mod_ethereal_onion(lua_State * L);
int lc_pmain_mod_ethereal_ores(lua_State * L);
int lc_pmain_mod_ethereal_papyrus(lua_State * L);
int lc_pmain_mod_ethereal_plantpack(lua_State * L);
int lc_pmain_mod_ethereal_plantlife(lua_State * L);
int lc_pmain_mod_ethereal_sapling(lua_State * L);
int lc_pmain_mod_ethereal_sealife(lua_State * L);
int lc_pmain_mod_ethereal_stairs(lua_State * L);
int lc_pmain_mod_ethereal_strawberry(lua_State * L);
int lc_pmain_mod_ethereal_water(lua_State * L);
int lc_pmain_mod_ethereal_wood(lua_State * L);
int lc_pmain_mod_ethereal_bamboo_tree(lua_State * L);
int lc_pmain_mod_ethereal_banana_tree(lua_State * L);
int lc_pmain_mod_ethereal_birch_tree(lua_State * L);
int lc_pmain_mod_ethereal_bush(lua_State * L);
int lc_pmain_mod_ethereal_orange_tree(lua_State * L);
int lc_pmain_mod_ethereal_waterlily(lua_State * L);

#endif /* CPP_MODS_INIT_H_ */
