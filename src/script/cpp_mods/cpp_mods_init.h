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

#endif /* CPP_MODS_INIT_H_ */
