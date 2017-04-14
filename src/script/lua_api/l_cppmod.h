#ifndef L_CPPMOD_H_
#define L_CPPMOD_H_

#include "lua_api/l_base.h"
#include "config.h"

class ModApiCPPMod : public ModApiBase {
private:

	static int l_run_cppmod(lua_State *L);//, std::vector<std::string> &mod_name);

public:
	static void Initialize(lua_State *L, int top);
};

#endif /* L_CPPMOD_H_ */
