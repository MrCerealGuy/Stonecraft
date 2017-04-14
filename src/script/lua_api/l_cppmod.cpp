
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
#include "cpp_mods/erosion/init.h"
}

typedef struct {
  int c;
  const char ** v;
} lc_args_t;

int ModApiCPPMod::l_run_cppmod(lua_State *L)
{
	int status = lua_cpcall(L, lc_pmain_mod_erosion, NULL);
  	
  	if (status != 0) {
    	fputs(lua_tostring(L,-1), stderr);
  	}

	return 0;
}

void ModApiCPPMod::Initialize(lua_State *L, int top)
{
	API_FCT(run_cppmod);
}
