add_subdirectory(erosion)

# Used by server and client
set(common_SCRIPT_CPP_MODS_SRCS
	${common_SCRIPT_CPP_MODS_EROSION_SRCS}
	PARENT_SCOPE)

# Used by client only
set(client_SCRIPT_CPP_MODS_SRCS
	${client_SCRIPT_CPP_MODS_EROSION_SRCS}
	PARENT_SCOPE)

