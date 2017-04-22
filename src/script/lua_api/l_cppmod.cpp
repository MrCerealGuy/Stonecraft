
#include "lua_api/l_internal.h"
#include "common/c_converter.h"
#include "common/c_content.h"
#include "lua_api/l_cppmod.h"
#include "settings.h"
#include "debug.h"
#include "log.h"

#include <algorithm>
#include <iomanip>
#include <cctype>

#include <pthread.h>

/* CPP mods */
extern "C" {
#include "cpp_mods/cpp_mods_init.h"
}

typedef struct {
  int c;
  const char ** v;
} lc_args_t;

int ModApiCPPMod::l_run_cppmod(lua_State *L)
{
	enum { lc_nformalargs = 1 };
	lua_settop(L,1);

	int status = -1;
	lua_CFunction func = NULL;

	/* parse modname argument */
	if (strcmp(lua_tostring(L,1), "erosion") == 0) {
		func = lc_pmain_mod_erosion_init;
	}
	else if (strcmp(lua_tostring(L,1), "darkage") == 0) {
		func = lc_pmain_mod_darkage_init;
	}
	else if (strcmp(lua_tostring(L,1), "forest") == 0) {
		func = lc_pmain_mod_forest_init;
	}
	else if (strcmp(lua_tostring(L,1), "mg_villages") == 0) {
		func = lc_pmain_mod_mg_villages_init;
	}
	else if (strcmp(lua_tostring(L,1), "biome_lib") == 0) {
		func = lc_pmain_mod_biome_lib_init;
	}
	else if (strcmp(lua_tostring(L,1), "mines") == 0) {
		func = lc_pmain_mod_mines_init;
	}
	else if (strcmp(lua_tostring(L,1), "nssm") == 0) {
		func = lc_pmain_mod_nssm_init;
	}

	/* call cpp mod */
	if (func != NULL)
		status = lua_cpcall(L, func, NULL);
  	
  	if (status != 0) {
    	fputs(lua_tostring(L,-1), stderr);
  	}

	return 0;
}

void ModApiCPPMod::Initialize(lua_State *L, int top)
{
	API_FCT(run_cppmod);
}
