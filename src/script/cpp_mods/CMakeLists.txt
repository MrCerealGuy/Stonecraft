add_subdirectory(erosion)
add_subdirectory(darkage)
add_subdirectory(forest)
add_subdirectory(mg_villages)
add_subdirectory(biome_lib)
add_subdirectory(mines)
add_subdirectory(nssm)
# add_subdirectory(ethereal) -- not working: lua "attempt to call a string value"

# Used by server and client
set(common_SCRIPT_CPP_MODS_SRCS
	${common_SCRIPT_CPP_MODS_EROSION_SRCS}
	${common_SCRIPT_CPP_MODS_DARKAGE_SRCS}
	${common_SCRIPT_CPP_MODS_FOREST_SRCS}
	${common_SCRIPT_CPP_MODS_MG_VILLAGES_SRCS}
	${common_SCRIPT_CPP_MODS_BIOME_LIB_SRCS}
	${common_SCRIPT_CPP_MODS_MINES_SRCS}
	${common_SCRIPT_CPP_MODS_NSSM_SRCS}
#	${common_SCRIPT_CPP_MODS_ETHEREAL_SRCS}
	PARENT_SCOPE)

# Used by client only
set(client_SCRIPT_CPP_MODS_SRCS
	${client_SCRIPT_CPP_MODS_EROSION_SRCS}
	${client_SCRIPT_CPP_MODS_DARKAGE_SRCS}
	${client_SCRIPT_CPP_MODS_FOREST_SRCS}
	${client_SCRIPT_CPP_MODS_MG_VILLAGES_SRCS}
	${client_SCRIPT_CPP_MODS_BIOME_LIB_SRCS}
	${client_SCRIPT_CPP_MODS_MINES_SRCS}
	${client_SCRIPT_CPP_MODS_NSSM_SRCS}
#	${client_SCRIPT_CPP_MODS_ETHEREAL_SRCS}
	PARENT_SCOPE)

