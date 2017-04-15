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

#endif /* CPP_MODS_INIT_H_ */
