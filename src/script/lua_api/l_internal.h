/*
Minetest
Copyright (C) 2013 celeron55, Perttu Ahola <celeron55@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/

/******************************************************************************/
/******************************************************************************/
/* WARNING!!!! do NOT add this header in any include file or any code file    */
/*             not being a modapi file!!!!!!!!                                */
/******************************************************************************/
/******************************************************************************/

#ifndef L_INTERNAL_H_
#define L_INTERNAL_H_

#include "common/c_internal.h"

#define luamethod(class, name) {#name, class::l_##name}
#define API_FCT(name) registerFunction(L, #name, l_##name,top)
#define ASYNC_API_FCT(name) engine.registerFunction(#name, l_##name)

#define MAP_LOCK_REQUIRED
#define NO_MAP_LOCK_REQUIRED

/*
#if (defined(WIN32) || defined(_WIN32_WCE))
	#define NO_MAP_LOCK_REQUIRED
#else
	#include "profiler.h"
	#define NO_MAP_LOCK_REQUIRED \
		ScopeProfiler nolocktime(g_profiler,"Scriptapi: unlockable time",SPT_ADD)
#endif
*/

#define GET_ENV_PTR_NO_MAP_LOCK                              \
	ServerEnvironment *env = (ServerEnvironment *)getEnv(L); \
	if (env == NULL)                                         \
		return 0

#define GET_ENV_PTR         \
	MAP_LOCK_REQUIRED;      \
	GET_ENV_PTR_NO_MAP_LOCK

#endif /* L_INTERNAL_H_ */
