add_subdirectory(erosion)
add_subdirectory(darkage)
add_subdirectory(forest)

# Used by server and client
set(common_SCRIPT_CPP_MODS_SRCS
	${common_SCRIPT_CPP_MODS_EROSION_SRCS}
	${common_SCRIPT_CPP_MODS_DARKAGE_SRCS}
	${common_SCRIPT_CPP_MODS_FOREST_SRCS}
	PARENT_SCOPE)

# Used by client only
set(client_SCRIPT_CPP_MODS_SRCS
	${client_SCRIPT_CPP_MODS_EROSION_SRCS}
	${client_SCRIPT_CPP_MODS_DARKAGE_SRCS}
	${client_SCRIPT_CPP_MODS_FOREST_SRCS}
	PARENT_SCOPE)

