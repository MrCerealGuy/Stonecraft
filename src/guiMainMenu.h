/*
Minetest
Copyright (C) 2010-2013 celeron55, Perttu Ahola <celeron55@gmail.com>

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

#ifndef GUIMAINMENU_HEADER
#define GUIMAINMENU_HEADER

#include "irrlichttypes_extrabloated.h"
#include "modalMenu.h"
#include <string>
#include <list>

struct MainMenuDataForScript {

	MainMenuDataForScript() :
		reconnect_requested(false)
	{}

	// Whether the server has requested a reconnect
	bool reconnect_requested;

	std::string errormessage;
};

struct MainMenuData {
	// Client options
	std::string servername;
	std::string serverdescription;
	std::string address;
	std::string port;
	std::string name;
	std::string password;
	// Whether to reconnect
	bool do_reconnect;

	// Server options
	bool enable_public;
	int selected_world;
	bool simple_singleplayer_mode;

	// Data to be passed to the script
	MainMenuDataForScript script_data;

	MainMenuData():
		do_reconnect(false),
		enable_public(false),
		selected_world(0),
		simple_singleplayer_mode(false)
	{}
};

#endif

