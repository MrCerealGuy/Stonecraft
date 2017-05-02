/*
Minetest
Copyright (C) 2010-2017 celeron55, Perttu Ahola <celeron55@gmail.com>

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

#include "serverenvironment.h"
#include "content_sao.h"
#include "settings.h"
#include "log.h"
#include "nodedef.h"
#include "nodemetadata.h"
#include "gamedef.h"
#include "map.h"
#include "profiler.h"
#include "raycast.h"
#include "remoteplayer.h"
#include "scripting_server.h"
#include "server.h"
#include "voxelalgorithms.h"
#include "util/serialize.h"
#include "util/basic_macros.h"
#include "util/pointedthing.h"
#include "threading/mutex_auto_lock.h"
#include "filesys.h"
#include "gameparams.h"
#include "database-dummy.h"
#include "database-files.h"
#include "database-sqlite3.h"
#if USE_POSTGRESQL
#include "database-postgresql.h"
#endif

#define LBM_NAME_ALLOWED_CHARS "abcdefghijklmnopqrstuvwxyz0123456789_:"

// A number that is much smaller than the timeout for particle spawners should/could ever be
#define PARTICLE_SPAWNER_NO_EXPIRY -1024.f

/*
	ABMWithState
*/

ABMWithState::ABMWithState(ActiveBlockModifier *abm_):
	abm(abm_),
	timer(0)
{
	// Initialize timer to random value to spread processing
	float itv = abm->getTriggerInterval();
	itv = MYMAX(0.001, itv); // No less than 1ms
	int minval = MYMAX(-0.51*itv, -60); // Clamp to
	int maxval = MYMIN(0.51*itv, 60);   // +-60 seconds
	timer = myrand_range(minval, maxval);
}

/*
	LBMManager
*/

void LBMContentMapping::deleteContents()
{
	for (std::vector<LoadingBlockModifierDef *>::iterator it = lbm_list.begin();
		it != lbm_list.end(); ++it) {
		delete *it;
	}
}

void LBMContentMapping::addLBM(LoadingBlockModifierDef *lbm_def, IGameDef *gamedef)
{
	// Add the lbm_def to the LBMContentMapping.
	// Unknown names get added to the global NameIdMapping.
	INodeDefManager *nodedef = gamedef->ndef();

	lbm_list.push_back(lbm_def);

	for (std::set<std::string>::const_iterator it = lbm_def->trigger_contents.begin();
		it != lbm_def->trigger_contents.end(); ++it) {
		std::set<content_t> c_ids;
		bool found = nodedef->getIds(*it, c_ids);
		if (!found) {
			content_t c_id = gamedef->allocateUnknownNodeId(*it);
			if (c_id == CONTENT_IGNORE) {
				// Seems it can't be allocated.
				warningstream << "Could not internalize node name \"" << *it
					<< "\" while loading LBM \"" << lbm_def->name << "\"." << std::endl;
				continue;
			}
			c_ids.insert(c_id);
		}

		for (std::set<content_t>::const_iterator iit =
			c_ids.begin(); iit != c_ids.end(); ++iit) {
			content_t c_id = *iit;
			map[c_id].push_back(lbm_def);
		}
	}
}

const std::vector<LoadingBlockModifierDef *> *
LBMContentMapping::lookup(content_t c) const
{
	container_map::const_iterator it = map.find(c);
	if (it == map.end())
		return NULL;
	// This first dereferences the iterator, returning
	// a std::vector<LoadingBlockModifierDef *>
	// reference, then we convert it to a pointer.
	return &(it->second);
}

LBMManager::~LBMManager()
{
	for (std::map<std::string, LoadingBlockModifierDef *>::iterator it =
		m_lbm_defs.begin(); it != m_lbm_defs.end(); ++it) {
		delete it->second;
	}
	for (lbm_lookup_map::iterator it = m_lbm_lookup.begin();
		it != m_lbm_lookup.end(); ++it) {
		(it->second).deleteContents();
	}
}

void LBMManager::addLBMDef(LoadingBlockModifierDef *lbm_def)
{
	// Precondition, in query mode the map isn't used anymore
	FATAL_ERROR_IF(m_query_mode == true,
		"attempted to modify LBMManager in query mode");

	if (!string_allowed(lbm_def->name, LBM_NAME_ALLOWED_CHARS)) {
		throw ModError("Error adding LBM \"" + lbm_def->name +
			"\": Does not follow naming conventions: "
				"Only chararacters [a-z0-9_:] are allowed.");
	}

	m_lbm_defs[lbm_def->name] = lbm_def;
}

void LBMManager::loadIntroductionTimes(const std::string &times,
	IGameDef *gamedef, u32 now)
{
	m_query_mode = true;

	// name -> time map.
	// Storing it in a map first instead of
	// handling the stuff directly in the loop
	// removes all duplicate entries.
	// TODO make this std::unordered_map
	std::map<std::string, u32> introduction_times;

	/*
	The introduction times string consists of name~time entries,
	with each entry terminated by a semicolon. The time is decimal.
	 */

	size_t idx = 0;
	size_t idx_new;
	while ((idx_new = times.find(";", idx)) != std::string::npos) {
		std::string entry = times.substr(idx, idx_new - idx);
		std::vector<std::string> components = str_split(entry, '~');
		if (components.size() != 2)
			throw SerializationError("Introduction times entry \""
				+ entry + "\" requires exactly one '~'!");
		const std::string &name = components[0];
		u32 time = from_string<u32>(components[1]);
		introduction_times[name] = time;
		idx = idx_new + 1;
	}

	// Put stuff from introduction_times into m_lbm_lookup
	for (std::map<std::string, u32>::const_iterator it = introduction_times.begin();
		it != introduction_times.end(); ++it) {
		const std::string &name = it->first;
		u32 time = it->second;

		std::map<std::string, LoadingBlockModifierDef *>::iterator def_it =
			m_lbm_defs.find(name);
		if (def_it == m_lbm_defs.end()) {
			// This seems to be an LBM entry for
			// an LBM we haven't loaded. Discard it.
			continue;
		}
		LoadingBlockModifierDef *lbm_def = def_it->second;
		if (lbm_def->run_at_every_load) {
			// This seems to be an LBM entry for
			// an LBM that runs at every load.
			// Don't add it just yet.
			continue;
		}

		m_lbm_lookup[time].addLBM(lbm_def, gamedef);

		// Erase the entry so that we know later
		// what elements didn't get put into m_lbm_lookup
		m_lbm_defs.erase(name);
	}

	// Now also add the elements from m_lbm_defs to m_lbm_lookup
	// that weren't added in the previous step.
	// They are introduced first time to this world,
	// or are run at every load (introducement time hardcoded to U32_MAX).

	LBMContentMapping &lbms_we_introduce_now = m_lbm_lookup[now];
	LBMContentMapping &lbms_running_always = m_lbm_lookup[U32_MAX];

	for (std::map<std::string, LoadingBlockModifierDef *>::iterator it =
		m_lbm_defs.begin(); it != m_lbm_defs.end(); ++it) {
		if (it->second->run_at_every_load) {
			lbms_running_always.addLBM(it->second, gamedef);
		} else {
			lbms_we_introduce_now.addLBM(it->second, gamedef);
		}
	}

	// Clear the list, so that we don't delete remaining elements
	// twice in the destructor
	m_lbm_defs.clear();
}

std::string LBMManager::createIntroductionTimesString()
{
	// Precondition, we must be in query mode
	FATAL_ERROR_IF(m_query_mode == false,
		"attempted to query on non fully set up LBMManager");

	std::ostringstream oss;
	for (lbm_lookup_map::iterator it = m_lbm_lookup.begin();
		it != m_lbm_lookup.end(); ++it) {
		u32 time = it->first;
		std::vector<LoadingBlockModifierDef *> &lbm_list = it->second.lbm_list;
		for (std::vector<LoadingBlockModifierDef *>::iterator iit = lbm_list.begin();
			iit != lbm_list.end(); ++iit) {
			// Don't add if the LBM runs at every load,
			// then introducement time is hardcoded
			// and doesn't need to be stored
			if ((*iit)->run_at_every_load)
				continue;
			oss << (*iit)->name << "~" << time << ";";
		}
	}
	return oss.str();
}

void LBMManager::applyLBMs(ServerEnvironment *env, MapBlock *block, u32 stamp)
{
	// Precondition, we need m_lbm_lookup to be initialized
	FATAL_ERROR_IF(m_query_mode == false,
		"attempted to query on non fully set up LBMManager");
	v3s16 pos_of_block = block->getPosRelative();
	v3s16 pos;
	MapNode n;
	content_t c;
	lbm_lookup_map::const_iterator it = getLBMsIntroducedAfter(stamp);
	for (pos.X = 0; pos.X < MAP_BLOCKSIZE; pos.X++)
		for (pos.Y = 0; pos.Y < MAP_BLOCKSIZE; pos.Y++)
			for (pos.Z = 0; pos.Z < MAP_BLOCKSIZE; pos.Z++)
			{
				n = block->getNodeNoEx(pos);
				c = n.getContent();
				for (LBMManager::lbm_lookup_map::const_iterator iit = it;
					iit != m_lbm_lookup.end(); ++iit) {
					const std::vector<LoadingBlockModifierDef *> *lbm_list =
						iit->second.lookup(c);
					if (!lbm_list)
						continue;
					for (std::vector<LoadingBlockModifierDef *>::const_iterator iit =
						lbm_list->begin(); iit != lbm_list->end(); ++iit) {
						(*iit)->trigger(env, pos + pos_of_block, n);
					}
				}
			}
}

/*
	ActiveBlockList
*/

void fillRadiusBlock(v3s16 p0, s16 r, std::set<v3s16> &list)
{
	v3s16 p;
	for(p.X=p0.X-r; p.X<=p0.X+r; p.X++)
		for(p.Y=p0.Y-r; p.Y<=p0.Y+r; p.Y++)
			for(p.Z=p0.Z-r; p.Z<=p0.Z+r; p.Z++)
			{
				// limit to a sphere
				if (p.getDistanceFrom(p0) <= r) {
					// Set in list
					list.insert(p);
				}
			}
}

void ActiveBlockList::update(std::vector<v3s16> &active_positions,
	s16 radius,
	std::set<v3s16> &blocks_removed,
	std::set<v3s16> &blocks_added)
{
	/*
		Create the new list
	*/
	std::set<v3s16> newlist = m_forceloaded_list;
	for(std::vector<v3s16>::iterator i = active_positions.begin();
		i != active_positions.end(); ++i)
	{
		fillRadiusBlock(*i, radius, newlist);
	}

	/*
		Find out which blocks on the old list are not on the new list
	*/
	// Go through old list
	for(std::set<v3s16>::iterator i = m_list.begin();
		i != m_list.end(); ++i)
	{
		v3s16 p = *i;
		// If not on new list, it's been removed
		if(newlist.find(p) == newlist.end())
			blocks_removed.insert(p);
	}

	/*
		Find out which blocks on the new list are not on the old list
	*/
	// Go through new list
	for(std::set<v3s16>::iterator i = newlist.begin();
		i != newlist.end(); ++i)
	{
		v3s16 p = *i;
		// If not on old list, it's been added
		if(m_list.find(p) == m_list.end())
			blocks_added.insert(p);
	}

	/*
		Update m_list
	*/
	m_list.clear();
	for(std::set<v3s16>::iterator i = newlist.begin();
		i != newlist.end(); ++i)
	{
		v3s16 p = *i;
		m_list.insert(p);
	}
}

/*
	ServerEnvironment
*/

ServerEnvironment::ServerEnvironment(ServerMap *map,
	ServerScripting *scriptIface, Server *server,
	const std::string &path_world):
	Environment(server),
	m_map(map),
	m_script(scriptIface),
	m_server(server),
	m_path_world(path_world),
	m_send_recommended_timer(0),
	m_active_block_interval_overload_skip(0),
	m_game_time(0),
	m_game_time_fraction_counter(0),
	m_last_clear_objects_time(0),
	m_recommended_send_interval(0.1),
	m_max_lag_estimate(0.1),
	m_player_database(NULL)
{
	// Determine which database backend to use
	std::string conf_path = path_world + DIR_DELIM + "world.mt";
	Settings conf;
	bool succeeded = conf.readConfigFile(conf_path.c_str());
	if (!succeeded || !conf.exists("player_backend")) {
		// fall back to files
		conf.set("player_backend", "files");
		warningstream << "/!\\ You are using old player file backend. "
				<< "This backend is deprecated and will be removed in next release /!\\"
				<< std::endl << "Switching to SQLite3 or PostgreSQL is advised, "
				<< "please read http://wiki.minetest.net/Database_backends." << std::endl;

		if (!conf.updateConfigFile(conf_path.c_str())) {
			errorstream << "ServerEnvironment::ServerEnvironment(): "
				<< "Failed to update world.mt!" << std::endl;
		}
	}

	std::string name = "";
	conf.getNoEx("player_backend", name);
	m_player_database = openPlayerDatabase(name, path_world, conf);
}

ServerEnvironment::~ServerEnvironment()
{
	// Clear active block list.
	// This makes the next one delete all active objects.
	m_active_blocks.clear();

	// Convert all objects to static and delete the active objects
	deactivateFarObjects(true);

	// Drop/delete map
	m_map->drop();

	// Delete ActiveBlockModifiers
	for (std::vector<ABMWithState>::iterator
		i = m_abms.begin(); i != m_abms.end(); ++i){
		delete i->abm;
	}

	// Deallocate players
	for (std::vector<RemotePlayer *>::iterator i = m_players.begin();
		i != m_players.end(); ++i) {
		delete (*i);
	}

	delete m_player_database;
}

Map & ServerEnvironment::getMap()
{
	return *m_map;
}

ServerMap & ServerEnvironment::getServerMap()
{
	return *m_map;
}

RemotePlayer *ServerEnvironment::getPlayer(const u16 peer_id)
{
	for (std::vector<RemotePlayer *>::iterator i = m_players.begin();
		i != m_players.end(); ++i) {
		RemotePlayer *player = *i;
		if (player->peer_id == peer_id)
			return player;
	}
	return NULL;
}

RemotePlayer *ServerEnvironment::getPlayer(const char* name)
{
	for (std::vector<RemotePlayer *>::iterator i = m_players.begin();
		i != m_players.end(); ++i) {
		RemotePlayer *player = *i;
		if (strcmp(player->getName(), name) == 0)
			return player;
	}
	return NULL;
}

void ServerEnvironment::addPlayer(RemotePlayer *player)
{
	DSTACK(FUNCTION_NAME);
	/*
		Check that peer_ids are unique.
		Also check that names are unique.
		Exception: there can be multiple players with peer_id=0
	*/
	// If peer id is non-zero, it has to be unique.
	if (player->peer_id != 0)
		FATAL_ERROR_IF(getPlayer(player->peer_id) != NULL, "Peer id not unique");
	// Name has to be unique.
	FATAL_ERROR_IF(getPlayer(player->getName()) != NULL, "Player name not unique");
	// Add.
	m_players.push_back(player);
}

void ServerEnvironment::removePlayer(RemotePlayer *player)
{
	for (std::vector<RemotePlayer *>::iterator it = m_players.begin();
		it != m_players.end(); ++it) {
		if ((*it) == player) {
			delete *it;
			m_players.erase(it);
			return;
		}
	}
}

bool ServerEnvironment::removePlayerFromDatabase(const std::string &name)
{
	return m_player_database->removePlayer(name);
}

bool ServerEnvironment::line_of_sight(v3f pos1, v3f pos2, float stepsize, v3s16 *p)
{
	float distance = pos1.getDistanceFrom(pos2);

	//calculate normalized direction vector
	v3f normalized_vector = v3f((pos2.X - pos1.X)/distance,
		(pos2.Y - pos1.Y)/distance,
		(pos2.Z - pos1.Z)/distance);

	//find out if there's a node on path between pos1 and pos2
	for (float i = 1; i < distance; i += stepsize) {
		v3s16 pos = floatToInt(v3f(normalized_vector.X * i,
			normalized_vector.Y * i,
			normalized_vector.Z * i) +pos1,BS);

		MapNode n = getMap().getNodeNoEx(pos);

		if(n.param0 != CONTENT_AIR) {
			if (p) {
				*p = pos;
			}
			return false;
		}
	}
	return true;
}

void ServerEnvironment::kickAllPlayers(AccessDeniedCode reason,
	const std::string &str_reason, bool reconnect)
{
	for (std::vector<RemotePlayer *>::iterator it = m_players.begin();
		it != m_players.end(); ++it) {
		RemotePlayer *player = dynamic_cast<RemotePlayer *>(*it);
		m_server->DenyAccessVerCompliant(player->peer_id,
			player->protocol_version, reason, str_reason, reconnect);
	}
}

void ServerEnvironment::saveLoadedPlayers()
{
	std::string players_path = m_path_world + DIR_DELIM + "players";
	fs::CreateDir(players_path);

	for (std::vector<RemotePlayer *>::iterator it = m_players.begin();
		it != m_players.end();
		++it) {
		if ((*it)->checkModified() ||
			((*it)->getPlayerSAO() && (*it)->getPlayerSAO()->extendedAttributesModified())) {
			try {
				m_player_database->savePlayer(*it);
			} catch (DatabaseException &e) {
				errorstream << "Failed to save player " << (*it)->getName() << " exception: "
					<< e.what() << std::endl;
				throw;
			}
		}
	}
}

void ServerEnvironment::savePlayer(RemotePlayer *player)
{
	try {
		m_player_database->savePlayer(player);
	} catch (DatabaseException &e) {
		errorstream << "Failed to save player " << player->getName() << " exception: "
			<< e.what() << std::endl;
		throw;
	}
}

PlayerSAO *ServerEnvironment::loadPlayer(RemotePlayer *player, bool *new_player,
	u16 peer_id, bool is_singleplayer)
{
	PlayerSAO *playersao = new PlayerSAO(this, player, peer_id, is_singleplayer);
	// Create player if it doesn't exist
	if (!m_player_database->loadPlayer(player, playersao)) {
		*new_player = true;
		// Set player position
		infostream << "Server: Finding spawn place for player \""
			<< player->getName() << "\"" << std::endl;
		playersao->setBasePosition(m_server->findSpawnPos());

		// Make sure the player is saved
		player->setModified(true);
	} else {
		// If the player exists, ensure that they respawn inside legal bounds
		// This fixes an assert crash when the player can't be added
		// to the environment
		if (objectpos_over_limit(playersao->getBasePosition())) {
			actionstream << "Respawn position for player \""
				<< player->getName() << "\" outside limits, resetting" << std::endl;
			playersao->setBasePosition(m_server->findSpawnPos());
		}
	}

	// Add player to environment
	addPlayer(player);

	/* Clean up old HUD elements from previous sessions */
	player->clearHud();

	/* Add object to environment */
	addActiveObject(playersao);

	return playersao;
}

void ServerEnvironment::saveMeta()
{
	std::string path = m_path_world + DIR_DELIM "env_meta.txt";

	// Open file and serialize
	std::ostringstream ss(std::ios_base::binary);

	Settings args;
	args.setU64("game_time", m_game_time);
	args.setU64("time_of_day", getTimeOfDay());
	args.setU64("last_clear_objects_time", m_last_clear_objects_time);
	args.setU64("lbm_introduction_times_version", 1);
	args.set("lbm_introduction_times",
		m_lbm_mgr.createIntroductionTimesString());
	args.setU64("day_count", m_day_count);
	args.writeLines(ss);
	ss<<"EnvArgsEnd\n";

	if(!fs::safeWriteToFile(path, ss.str()))
	{
		infostream<<"ServerEnvironment::saveMeta(): Failed to write "
			<<path<<std::endl;
		throw SerializationError("Couldn't save env meta");
	}
}

void ServerEnvironment::loadMeta()
{
	std::string path = m_path_world + DIR_DELIM "env_meta.txt";

	// Open file and deserialize
	std::ifstream is(path.c_str(), std::ios_base::binary);
	if (!is.good()) {
		infostream << "ServerEnvironment::loadMeta(): Failed to open "
			<< path << std::endl;
		throw SerializationError("Couldn't load env meta");
	}

	Settings args;

	if (!args.parseConfigLines(is, "EnvArgsEnd")) {
		throw SerializationError("ServerEnvironment::loadMeta(): "
			"EnvArgsEnd not found!");
	}

	try {
		m_game_time = args.getU64("game_time");
	} catch (SettingNotFoundException &e) {
		// Getting this is crucial, otherwise timestamps are useless
		throw SerializationError("Couldn't load env meta game_time");
	}

	setTimeOfDay(args.exists("time_of_day") ?
		// set day to morning by default
		args.getU64("time_of_day") : 9000);

	m_last_clear_objects_time = args.exists("last_clear_objects_time") ?
		// If missing, do as if clearObjects was never called
		args.getU64("last_clear_objects_time") : 0;

	std::string lbm_introduction_times = "";
	try {
		u64 ver = args.getU64("lbm_introduction_times_version");
		if (ver == 1) {
			lbm_introduction_times = args.get("lbm_introduction_times");
		} else {
			infostream << "ServerEnvironment::loadMeta(): Non-supported"
				<< " introduction time version " << ver << std::endl;
		}
	} catch (SettingNotFoundException &e) {
		// No problem, this is expected. Just continue with an empty string
	}
	m_lbm_mgr.loadIntroductionTimes(lbm_introduction_times, m_server, m_game_time);

	m_day_count = args.exists("day_count") ?
		args.getU64("day_count") : 0;
}

void ServerEnvironment::loadDefaultMeta()
{
	m_lbm_mgr.loadIntroductionTimes("", m_server, m_game_time);
}

struct ActiveABM
{
	ActiveBlockModifier *abm;
	int chance;
	std::set<content_t> required_neighbors;
};

class ABMHandler
{
private:
	ServerEnvironment *m_env;
	std::vector<std::vector<ActiveABM> *> m_aabms;
public:
	ABMHandler(std::vector<ABMWithState> &abms,
		float dtime_s, ServerEnvironment *env,
		bool use_timers):
		m_env(env)
	{
		if(dtime_s < 0.001)
			return;
		INodeDefManager *ndef = env->getGameDef()->ndef();
		for(std::vector<ABMWithState>::iterator
			i = abms.begin(); i != abms.end(); ++i) {
			ActiveBlockModifier *abm = i->abm;
			float trigger_interval = abm->getTriggerInterval();
			if(trigger_interval < 0.001)
				trigger_interval = 0.001;
			float actual_interval = dtime_s;
			if(use_timers){
				i->timer += dtime_s;
				if(i->timer < trigger_interval)
					continue;
				i->timer -= trigger_interval;
				actual_interval = trigger_interval;
			}
			float chance = abm->getTriggerChance();
			if(chance == 0)
				chance = 1;
			ActiveABM aabm;
			aabm.abm = abm;
			if(abm->getSimpleCatchUp()) {
				float intervals = actual_interval / trigger_interval;
				if(intervals == 0)
					continue;
				aabm.chance = chance / intervals;
				if(aabm.chance == 0)
					aabm.chance = 1;
			} else {
				aabm.chance = chance;
			}
			// Trigger neighbors
			std::set<std::string> required_neighbors_s
				= abm->getRequiredNeighbors();
			for(std::set<std::string>::iterator
				i = required_neighbors_s.begin();
				i != required_neighbors_s.end(); ++i)
			{
				ndef->getIds(*i, aabm.required_neighbors);
			}
			// Trigger contents
			std::set<std::string> contents_s = abm->getTriggerContents();
			for(std::set<std::string>::iterator
				i = contents_s.begin(); i != contents_s.end(); ++i)
			{
				std::set<content_t> ids;
				ndef->getIds(*i, ids);
				for(std::set<content_t>::const_iterator k = ids.begin();
					k != ids.end(); ++k)
				{
					content_t c = *k;
					if (c >= m_aabms.size())
						m_aabms.resize(c + 256, NULL);
					if (!m_aabms[c])
						m_aabms[c] = new std::vector<ActiveABM>;
					m_aabms[c]->push_back(aabm);
				}
			}
		}
	}

	~ABMHandler()
	{
		for (size_t i = 0; i < m_aabms.size(); i++)
			delete m_aabms[i];
	}

	// Find out how many objects the given block and its neighbours contain.
	// Returns the number of objects in the block, and also in 'wider' the
	// number of objects in the block and all its neighbours. The latter
	// may an estimate if any neighbours are unloaded.
	u32 countObjects(MapBlock *block, ServerMap * map, u32 &wider)
	{
		wider = 0;
		u32 wider_unknown_count = 0;
		for(s16 x=-1; x<=1; x++)
			for(s16 y=-1; y<=1; y++)
				for(s16 z=-1; z<=1; z++)
				{
					MapBlock *block2 = map->getBlockNoCreateNoEx(
						block->getPos() + v3s16(x,y,z));
					if(block2==NULL){
						wider_unknown_count++;
						continue;
					}
					wider += block2->m_static_objects.m_active.size()
						+ block2->m_static_objects.m_stored.size();
				}
		// Extrapolate
		u32 active_object_count = block->m_static_objects.m_active.size();
		u32 wider_known_count = 3*3*3 - wider_unknown_count;
		wider += wider_unknown_count * wider / wider_known_count;
		return active_object_count;

	}
	void apply(MapBlock *block)
	{
		if(m_aabms.empty() || block->isDummy())
			return;

		ServerMap *map = &m_env->getServerMap();

		u32 active_object_count_wider;
		u32 active_object_count = this->countObjects(block, map, active_object_count_wider);
		m_env->m_added_objects = 0;

		v3s16 p0;
		for(p0.X=0; p0.X<MAP_BLOCKSIZE; p0.X++)
		for(p0.Y=0; p0.Y<MAP_BLOCKSIZE; p0.Y++)
		for(p0.Z=0; p0.Z<MAP_BLOCKSIZE; p0.Z++)
		{
			const MapNode &n = block->getNodeUnsafe(p0);
			content_t c = n.getContent();

			if (c >= m_aabms.size() || !m_aabms[c])
				continue;

			v3s16 p = p0 + block->getPosRelative();
			for(std::vector<ActiveABM>::iterator
				i = m_aabms[c]->begin(); i != m_aabms[c]->end(); ++i) {
				if(myrand() % i->chance != 0)
					continue;

				// Check neighbors
				if(!i->required_neighbors.empty())
				{
					v3s16 p1;
					for(p1.X = p0.X-1; p1.X <= p0.X+1; p1.X++)
					for(p1.Y = p0.Y-1; p1.Y <= p0.Y+1; p1.Y++)
					for(p1.Z = p0.Z-1; p1.Z <= p0.Z+1; p1.Z++)
					{
						if(p1 == p0)
							continue;
						content_t c;
						if (block->isValidPosition(p1)) {
							// if the neighbor is found on the same map block
							// get it straight from there
							const MapNode &n = block->getNodeUnsafe(p1);
							c = n.getContent();
						} else {
							// otherwise consult the map
							MapNode n = map->getNodeNoEx(p1 + block->getPosRelative());
							c = n.getContent();
						}
						std::set<content_t>::const_iterator k;
						k = i->required_neighbors.find(c);
						if(k != i->required_neighbors.end()){
							goto neighbor_found;
						}
					}
					// No required neighbor found
					continue;
				}
				neighbor_found:

				// Call all the trigger variations
				i->abm->trigger(m_env, p, n);
				i->abm->trigger(m_env, p, n,
					active_object_count, active_object_count_wider);

				// Count surrounding objects again if the abms added any
				if(m_env->m_added_objects > 0) {
					active_object_count = countObjects(block, map, active_object_count_wider);
					m_env->m_added_objects = 0;
				}
			}
		}
	}
};

void ServerEnvironment::activateBlock(MapBlock *block, u32 additional_dtime)
{
	// Reset usage timer immediately, otherwise a block that becomes active
	// again at around the same time as it would normally be unloaded will
	// get unloaded incorrectly. (I think this still leaves a small possibility
	// of a race condition between this and server::AsyncRunStep, which only
	// some kind of synchronisation will fix, but it at least reduces the window
	// of opportunity for it to break from seconds to nanoseconds)
	block->resetUsageTimer();

	// Get time difference
	u32 dtime_s = 0;
	u32 stamp = block->getTimestamp();
	if (m_game_time > stamp && stamp != BLOCK_TIMESTAMP_UNDEFINED)
		dtime_s = m_game_time - stamp;
	dtime_s += additional_dtime;

	/*infostream<<"ServerEnvironment::activateBlock(): block timestamp: "
			<<stamp<<", game time: "<<m_game_time<<std::endl;*/

	// Remove stored static objects if clearObjects was called since block's timestamp
	if (stamp == BLOCK_TIMESTAMP_UNDEFINED || stamp < m_last_clear_objects_time) {
		block->m_static_objects.m_stored.clear();
		// do not set changed flag to avoid unnecessary mapblock writes
	}

	// Set current time as timestamp
	block->setTimestampNoChangedFlag(m_game_time);

	/*infostream<<"ServerEnvironment::activateBlock(): block is "
			<<dtime_s<<" seconds old."<<std::endl;*/

	// Activate stored objects
	activateObjects(block, dtime_s);

	/* Handle LoadingBlockModifiers */
	m_lbm_mgr.applyLBMs(this, block, stamp);

	// Run node timers
	std::vector<NodeTimer> elapsed_timers =
		block->m_node_timers.step((float)dtime_s);
	if (!elapsed_timers.empty()) {
		MapNode n;
		for (std::vector<NodeTimer>::iterator
			i = elapsed_timers.begin();
			i != elapsed_timers.end(); ++i){
			n = block->getNodeNoEx(i->position);
			v3s16 p = i->position + block->getPosRelative();
			if (m_script->node_on_timer(p, n, i->elapsed))
				block->setNodeTimer(NodeTimer(i->timeout, 0, i->position));
		}
	}

	/* Handle ActiveBlockModifiers */
	ABMHandler abmhandler(m_abms, dtime_s, this, false);
	abmhandler.apply(block);
}

void ServerEnvironment::addActiveBlockModifier(ActiveBlockModifier *abm)
{
	m_abms.push_back(ABMWithState(abm));
}

void ServerEnvironment::addLoadingBlockModifierDef(LoadingBlockModifierDef *lbm)
{
	m_lbm_mgr.addLBMDef(lbm);
}

bool ServerEnvironment::setNode(v3s16 p, const MapNode &n)
{
	INodeDefManager *ndef = m_server->ndef();
	MapNode n_old = m_map->getNodeNoEx(p);

	// Call destructor
	if (ndef->get(n_old).has_on_destruct)
		m_script->node_on_destruct(p, n_old);

	// Replace node
	if (!m_map->addNodeWithEvent(p, n))
		return false;

	// Update active VoxelManipulator if a mapgen thread
	m_map->updateVManip(p);

	// Call post-destructor
	if (ndef->get(n_old).has_after_destruct)
		m_script->node_after_destruct(p, n_old);

	// Call constructor
	if (ndef->get(n).has_on_construct)
		m_script->node_on_construct(p, n);

	return true;
}

bool ServerEnvironment::removeNode(v3s16 p)
{
	INodeDefManager *ndef = m_server->ndef();
	MapNode n_old = m_map->getNodeNoEx(p);

	// Call destructor
	if (ndef->get(n_old).has_on_destruct)
		m_script->node_on_destruct(p, n_old);

	// Replace with air
	// This is slightly optimized compared to addNodeWithEvent(air)
	if (!m_map->removeNodeWithEvent(p))
		return false;

	// Update active VoxelManipulator if a mapgen thread
	m_map->updateVManip(p);

	// Call post-destructor
	if (ndef->get(n_old).has_after_destruct)
		m_script->node_after_destruct(p, n_old);

	// Air doesn't require constructor
	return true;
}

bool ServerEnvironment::swapNode(v3s16 p, const MapNode &n)
{
	if (!m_map->addNodeWithEvent(p, n, false))
		return false;

	// Update active VoxelManipulator if a mapgen thread
	m_map->updateVManip(p);

	return true;
}

void ServerEnvironment::getObjectsInsideRadius(std::vector<u16> &objects, v3f pos, float radius)
{
	for (ActiveObjectMap::iterator i = m_active_objects.begin();
		i != m_active_objects.end(); ++i) {
		ServerActiveObject* obj = i->second;
		u16 id = i->first;
		v3f objectpos = obj->getBasePosition();
		if (objectpos.getDistanceFrom(pos) > radius)
			continue;
		objects.push_back(id);
	}
}

void ServerEnvironment::clearObjects(ClearObjectsMode mode)
{
	infostream << "ServerEnvironment::clearObjects(): "
		<< "Removing all active objects" << std::endl;
	std::vector<u16> objects_to_remove;
	for (ActiveObjectMap::iterator i = m_active_objects.begin();
		i != m_active_objects.end(); ++i) {
		ServerActiveObject* obj = i->second;
		if (obj->getType() == ACTIVEOBJECT_TYPE_PLAYER)
			continue;
		u16 id = i->first;
		// Delete static object if block is loaded
		if (obj->m_static_exists) {
			MapBlock *block = m_map->getBlockNoCreateNoEx(obj->m_static_block);
			if (block) {
				block->m_static_objects.remove(id);
				block->raiseModified(MOD_STATE_WRITE_NEEDED,
					MOD_REASON_CLEAR_ALL_OBJECTS);
				obj->m_static_exists = false;
			}
		}
		// If known by some client, don't delete immediately
		if (obj->m_known_by_count > 0) {
			obj->m_pending_deactivation = true;
			obj->m_removed = true;
			continue;
		}

		// Tell the object about removal
		obj->removingFromEnvironment();
		// Deregister in scripting api
		m_script->removeObjectReference(obj);

		// Delete active object
		if (obj->environmentDeletes())
			delete obj;
		// Id to be removed from m_active_objects
		objects_to_remove.push_back(id);
	}

	// Remove references from m_active_objects
	for (std::vector<u16>::iterator i = objects_to_remove.begin();
		i != objects_to_remove.end(); ++i) {
		m_active_objects.erase(*i);
	}

	// Get list of loaded blocks
	std::vector<v3s16> loaded_blocks;
	infostream << "ServerEnvironment::clearObjects(): "
		<< "Listing all loaded blocks" << std::endl;
	m_map->listAllLoadedBlocks(loaded_blocks);
	infostream << "ServerEnvironment::clearObjects(): "
		<< "Done listing all loaded blocks: "
		<< loaded_blocks.size()<<std::endl;

	// Get list of loadable blocks
	std::vector<v3s16> loadable_blocks;
	if (mode == CLEAR_OBJECTS_MODE_FULL) {
		infostream << "ServerEnvironment::clearObjects(): "
			<< "Listing all loadable blocks" << std::endl;
		m_map->listAllLoadableBlocks(loadable_blocks);
		infostream << "ServerEnvironment::clearObjects(): "
			<< "Done listing all loadable blocks: "
			<< loadable_blocks.size() << std::endl;
	} else {
		loadable_blocks = loaded_blocks;
	}

	infostream << "ServerEnvironment::clearObjects(): "
		<< "Now clearing objects in " << loadable_blocks.size()
		<< " blocks" << std::endl;

	// Grab a reference on each loaded block to avoid unloading it
	for (std::vector<v3s16>::iterator i = loaded_blocks.begin();
		i != loaded_blocks.end(); ++i) {
		v3s16 p = *i;
		MapBlock *block = m_map->getBlockNoCreateNoEx(p);
		assert(block != NULL);
		block->refGrab();
	}

	// Remove objects in all loadable blocks
	u32 unload_interval = U32_MAX;
	if (mode == CLEAR_OBJECTS_MODE_FULL) {
		unload_interval = g_settings->getS32("max_clearobjects_extra_loaded_blocks");
		unload_interval = MYMAX(unload_interval, 1);
	}
	u32 report_interval = loadable_blocks.size() / 10;
	u32 num_blocks_checked = 0;
	u32 num_blocks_cleared = 0;
	u32 num_objs_cleared = 0;
	for (std::vector<v3s16>::iterator i = loadable_blocks.begin();
		i != loadable_blocks.end(); ++i) {
		v3s16 p = *i;
		MapBlock *block = m_map->emergeBlock(p, false);
		if (!block) {
			errorstream << "ServerEnvironment::clearObjects(): "
				<< "Failed to emerge block " << PP(p) << std::endl;
			continue;
		}
		u32 num_stored = block->m_static_objects.m_stored.size();
		u32 num_active = block->m_static_objects.m_active.size();
		if (num_stored != 0 || num_active != 0) {
			block->m_static_objects.m_stored.clear();
			block->m_static_objects.m_active.clear();
			block->raiseModified(MOD_STATE_WRITE_NEEDED,
				MOD_REASON_CLEAR_ALL_OBJECTS);
			num_objs_cleared += num_stored + num_active;
			num_blocks_cleared++;
		}
		num_blocks_checked++;

		if (report_interval != 0 &&
			num_blocks_checked % report_interval == 0) {
			float percent = 100.0 * (float)num_blocks_checked /
				loadable_blocks.size();
			infostream << "ServerEnvironment::clearObjects(): "
				<< "Cleared " << num_objs_cleared << " objects"
				<< " in " << num_blocks_cleared << " blocks ("
				<< percent << "%)" << std::endl;
		}
		if (num_blocks_checked % unload_interval == 0) {
			m_map->unloadUnreferencedBlocks();
		}
	}
	m_map->unloadUnreferencedBlocks();

	// Drop references that were added above
	for (std::vector<v3s16>::iterator i = loaded_blocks.begin();
		i != loaded_blocks.end(); ++i) {
		v3s16 p = *i;
		MapBlock *block = m_map->getBlockNoCreateNoEx(p);
		assert(block);
		block->refDrop();
	}

	m_last_clear_objects_time = m_game_time;

	infostream << "ServerEnvironment::clearObjects(): "
		<< "Finished: Cleared " << num_objs_cleared << " objects"
		<< " in " << num_blocks_cleared << " blocks" << std::endl;
}

void ServerEnvironment::step(float dtime)
{
	DSTACK(FUNCTION_NAME);

	//TimeTaker timer("ServerEnv step");

	/* Step time of day */
	stepTimeOfDay(dtime);

	// Update this one
	// NOTE: This is kind of funny on a singleplayer game, but doesn't
	// really matter that much.
	static const float server_step = g_settings->getFloat("dedicated_server_step");
	m_recommended_send_interval = server_step;

	/*
		Increment game time
	*/
	{
		m_game_time_fraction_counter += dtime;
		u32 inc_i = (u32)m_game_time_fraction_counter;
		m_game_time += inc_i;
		m_game_time_fraction_counter -= (float)inc_i;
	}

	/*
		Handle players
	*/
	{
		ScopeProfiler sp(g_profiler, "SEnv: handle players avg", SPT_AVG);
		for (std::vector<RemotePlayer *>::iterator i = m_players.begin();
			i != m_players.end(); ++i) {
			RemotePlayer *player = dynamic_cast<RemotePlayer *>(*i);
			assert(player);

			// Ignore disconnected players
			if(player->peer_id == 0)
				continue;

			// Move
			player->move(dtime, this, 100*BS);
		}
	}

	/*
		Manage active block list
	*/
	if (m_active_blocks_management_interval.step(dtime, m_cache_active_block_mgmt_interval)) {
		ScopeProfiler sp(g_profiler, "SEnv: manage act. block list avg per interval", SPT_AVG);
		/*
			Get player block positions
		*/
		std::vector<v3s16> players_blockpos;
		for (std::vector<RemotePlayer *>::iterator i = m_players.begin();
			i != m_players.end(); ++i) {
			RemotePlayer *player = dynamic_cast<RemotePlayer *>(*i);
			assert(player);

			// Ignore disconnected players
			if (player->peer_id == 0)
				continue;

			PlayerSAO *playersao = player->getPlayerSAO();
			assert(playersao);

			v3s16 blockpos = getNodeBlockPos(
				floatToInt(playersao->getBasePosition(), BS));
			players_blockpos.push_back(blockpos);
		}

		/*
			Update list of active blocks, collecting changes
		*/
		static const s16 active_block_range = g_settings->getS16("active_block_range");
		std::set<v3s16> blocks_removed;
		std::set<v3s16> blocks_added;
		m_active_blocks.update(players_blockpos, active_block_range,
			blocks_removed, blocks_added);

		/*
			Handle removed blocks
		*/

		// Convert active objects that are no more in active blocks to static
		deactivateFarObjects(false);

		for(std::set<v3s16>::iterator
			i = blocks_removed.begin();
			i != blocks_removed.end(); ++i) {
			v3s16 p = *i;

			/* infostream<<"Server: Block " << PP(p)
				<< " became inactive"<<std::endl; */

			MapBlock *block = m_map->getBlockNoCreateNoEx(p);
			if(block==NULL)
				continue;

			// Set current time as timestamp (and let it set ChangedFlag)
			block->setTimestamp(m_game_time);
		}

		/*
			Handle added blocks
		*/

		for(std::set<v3s16>::iterator
			i = blocks_added.begin();
			i != blocks_added.end(); ++i)
		{
			v3s16 p = *i;

			MapBlock *block = m_map->getBlockOrEmerge(p);
			if(block==NULL){
				m_active_blocks.m_list.erase(p);
				continue;
			}

			activateBlock(block);
			/* infostream<<"Server: Block " << PP(p)
				<< " became active"<<std::endl; */
		}
	}

	/*
		Mess around in active blocks
	*/
	if (m_active_blocks_nodemetadata_interval.step(dtime, m_cache_nodetimer_interval)) {
		ScopeProfiler sp(g_profiler, "SEnv: mess in act. blocks avg per interval", SPT_AVG);

		float dtime = m_cache_nodetimer_interval;

		for(std::set<v3s16>::iterator
			i = m_active_blocks.m_list.begin();
			i != m_active_blocks.m_list.end(); ++i)
		{
			v3s16 p = *i;

			/*infostream<<"Server: Block ("<<p.X<<","<<p.Y<<","<<p.Z
					<<") being handled"<<std::endl;*/

			MapBlock *block = m_map->getBlockNoCreateNoEx(p);
			if(block==NULL)
				continue;

			// Reset block usage timer
			block->resetUsageTimer();

			// Set current time as timestamp
			block->setTimestampNoChangedFlag(m_game_time);
			// If time has changed much from the one on disk,
			// set block to be saved when it is unloaded
			if(block->getTimestamp() > block->getDiskTimestamp() + 60)
				block->raiseModified(MOD_STATE_WRITE_AT_UNLOAD,
					MOD_REASON_BLOCK_EXPIRED);

			// Run node timers
			std::vector<NodeTimer> elapsed_timers =
				block->m_node_timers.step((float)dtime);
			if (!elapsed_timers.empty()) {
				MapNode n;
				for (std::vector<NodeTimer>::iterator i = elapsed_timers.begin();
					i != elapsed_timers.end(); ++i) {
					n = block->getNodeNoEx(i->position);
					p = i->position + block->getPosRelative();
					if (m_script->node_on_timer(p, n, i->elapsed)) {
						block->setNodeTimer(NodeTimer(
							i->timeout, 0, i->position));
					}
				}
			}
		}
	}

	if (m_active_block_modifier_interval.step(dtime, m_cache_abm_interval))
		do{ // breakable
			if(m_active_block_interval_overload_skip > 0){
				ScopeProfiler sp(g_profiler, "SEnv: ABM overload skips");
				m_active_block_interval_overload_skip--;
				break;
			}
			ScopeProfiler sp(g_profiler, "SEnv: modify in blocks avg per interval", SPT_AVG);
			TimeTaker timer("modify in active blocks per interval");

			// Initialize handling of ActiveBlockModifiers
			ABMHandler abmhandler(m_abms, m_cache_abm_interval, this, true);

			for(std::set<v3s16>::iterator
				i = m_active_blocks.m_list.begin();
				i != m_active_blocks.m_list.end(); ++i)
			{
				v3s16 p = *i;

				/*infostream<<"Server: Block ("<<p.X<<","<<p.Y<<","<<p.Z
						<<") being handled"<<std::endl;*/

				MapBlock *block = m_map->getBlockNoCreateNoEx(p);
				if(block == NULL)
					continue;

				// Set current time as timestamp
				block->setTimestampNoChangedFlag(m_game_time);

				/* Handle ActiveBlockModifiers */
				abmhandler.apply(block);
			}

			u32 time_ms = timer.stop(true);
			u32 max_time_ms = 200;
			if(time_ms > max_time_ms){
				warningstream<<"active block modifiers took "
					<<time_ms<<"ms (longer than "
					<<max_time_ms<<"ms)"<<std::endl;
				m_active_block_interval_overload_skip = (time_ms / max_time_ms) + 1;
			}
		}while(0);

	/*
		Step script environment (run global on_step())
	*/
	m_script->environment_Step(dtime);

	/*
		Step active objects
	*/
	{
		ScopeProfiler sp(g_profiler, "SEnv: step act. objs avg", SPT_AVG);
		//TimeTaker timer("Step active objects");

		g_profiler->avg("SEnv: num of objects", m_active_objects.size());

		// This helps the objects to send data at the same time
		bool send_recommended = false;
		m_send_recommended_timer += dtime;
		if(m_send_recommended_timer > getSendRecommendedInterval())
		{
			m_send_recommended_timer -= getSendRecommendedInterval();
			send_recommended = true;
		}

		for(ActiveObjectMap::iterator i = m_active_objects.begin();
			i != m_active_objects.end(); ++i) {
			ServerActiveObject* obj = i->second;
			// Don't step if is to be removed or stored statically
			if(obj->m_removed || obj->m_pending_deactivation)
				continue;
			// Step object
			obj->step(dtime, send_recommended);
			// Read messages from object
			while(!obj->m_messages_out.empty())
			{
				m_active_object_messages.push(
					obj->m_messages_out.front());
				obj->m_messages_out.pop();
			}
		}
	}

	/*
		Manage active objects
	*/
	if(m_object_management_interval.step(dtime, 0.5))
	{
		ScopeProfiler sp(g_profiler, "SEnv: remove removed objs avg /.5s", SPT_AVG);
		/*
			Remove objects that satisfy (m_removed && m_known_by_count==0)
		*/
		removeRemovedObjects();
	}

	/*
		Manage particle spawner expiration
	*/
	if (m_particle_management_interval.step(dtime, 1.0)) {
		for (UNORDERED_MAP<u32, float>::iterator i = m_particle_spawners.begin();
			i != m_particle_spawners.end(); ) {
			//non expiring spawners
			if (i->second == PARTICLE_SPAWNER_NO_EXPIRY) {
				++i;
				continue;
			}

			i->second -= 1.0f;
			if (i->second <= 0.f)
				m_particle_spawners.erase(i++);
			else
				++i;
		}
	}
}

u32 ServerEnvironment::addParticleSpawner(float exptime)
{
	// Timers with lifetime 0 do not expire
	float time = exptime > 0.f ? exptime : PARTICLE_SPAWNER_NO_EXPIRY;

	u32 id = 0;
	for (;;) { // look for unused particlespawner id
		id++;
		UNORDERED_MAP<u32, float>::iterator f = m_particle_spawners.find(id);
		if (f == m_particle_spawners.end()) {
			m_particle_spawners[id] = time;
			break;
		}
	}
	return id;
}

u32 ServerEnvironment::addParticleSpawner(float exptime, u16 attached_id)
{
	u32 id = addParticleSpawner(exptime);
	m_particle_spawner_attachments[id] = attached_id;
	if (ServerActiveObject *obj = getActiveObject(attached_id)) {
		obj->attachParticleSpawner(id);
	}
	return id;
}

void ServerEnvironment::deleteParticleSpawner(u32 id, bool remove_from_object)
{
	m_particle_spawners.erase(id);
	UNORDERED_MAP<u32, u16>::iterator it = m_particle_spawner_attachments.find(id);
	if (it != m_particle_spawner_attachments.end()) {
		u16 obj_id = (*it).second;
		ServerActiveObject *sao = getActiveObject(obj_id);
		if (sao != NULL && remove_from_object) {
			sao->detachParticleSpawner(id);
		}
		m_particle_spawner_attachments.erase(id);
	}
}

ServerActiveObject* ServerEnvironment::getActiveObject(u16 id)
{
	ActiveObjectMap::iterator n = m_active_objects.find(id);
	return (n != m_active_objects.end() ? n->second : NULL);
}

bool isFreeServerActiveObjectId(u16 id, ActiveObjectMap &objects)
{
	if (id == 0)
		return false;

	return objects.find(id) == objects.end();
}

u16 getFreeServerActiveObjectId(ActiveObjectMap &objects)
{
	//try to reuse id's as late as possible
	static u16 last_used_id = 0;
	u16 startid = last_used_id;
	for(;;)
	{
		last_used_id ++;
		if(isFreeServerActiveObjectId(last_used_id, objects))
			return last_used_id;

		if(last_used_id == startid)
			return 0;
	}
}

u16 ServerEnvironment::addActiveObject(ServerActiveObject *object)
{
	assert(object);	// Pre-condition
	m_added_objects++;
	u16 id = addActiveObjectRaw(object, true, 0);
	return id;
}

/*
	Finds out what new objects have been added to
	inside a radius around a position
*/
void ServerEnvironment::getAddedActiveObjects(PlayerSAO *playersao, s16 radius,
	s16 player_radius,
	std::set<u16> &current_objects,
	std::queue<u16> &added_objects)
{
	f32 radius_f = radius * BS;
	f32 player_radius_f = player_radius * BS;

	if (player_radius_f < 0)
		player_radius_f = 0;
	/*
		Go through the object list,
		- discard m_removed objects,
		- discard objects that are too far away,
		- discard objects that are found in current_objects.
		- add remaining objects to added_objects
	*/
	for (ActiveObjectMap::iterator i = m_active_objects.begin();
		i != m_active_objects.end(); ++i) {
		u16 id = i->first;

		// Get object
		ServerActiveObject *object = i->second;
		if (object == NULL)
			continue;

		// Discard if removed or deactivating
		if(object->m_removed || object->m_pending_deactivation)
			continue;

		f32 distance_f = object->getBasePosition().
			getDistanceFrom(playersao->getBasePosition());
		if (object->getType() == ACTIVEOBJECT_TYPE_PLAYER) {
			// Discard if too far
			if (distance_f > player_radius_f && player_radius_f != 0)
				continue;
		} else if (distance_f > radius_f)
			continue;

		// Discard if already on current_objects
		std::set<u16>::iterator n;
		n = current_objects.find(id);
		if(n != current_objects.end())
			continue;
		// Add to added_objects
		added_objects.push(id);
	}
}

/*
	Finds out what objects have been removed from
	inside a radius around a position
*/
void ServerEnvironment::getRemovedActiveObjects(PlayerSAO *playersao, s16 radius,
	s16 player_radius,
	std::set<u16> &current_objects,
	std::queue<u16> &removed_objects)
{
	f32 radius_f = radius * BS;
	f32 player_radius_f = player_radius * BS;

	if (player_radius_f < 0)
		player_radius_f = 0;
	/*
		Go through current_objects; object is removed if:
		- object is not found in m_active_objects (this is actually an
		  error condition; objects should be set m_removed=true and removed
		  only after all clients have been informed about removal), or
		- object has m_removed=true, or
		- object is too far away
	*/
	for(std::set<u16>::iterator
		i = current_objects.begin();
		i != current_objects.end(); ++i)
	{
		u16 id = *i;
		ServerActiveObject *object = getActiveObject(id);

		if (object == NULL) {
			infostream << "ServerEnvironment::getRemovedActiveObjects():"
				<< " object in current_objects is NULL" << std::endl;
			removed_objects.push(id);
			continue;
		}

		if (object->m_removed || object->m_pending_deactivation) {
			removed_objects.push(id);
			continue;
		}

		f32 distance_f = object->getBasePosition().getDistanceFrom(playersao->getBasePosition());
		if (object->getType() == ACTIVEOBJECT_TYPE_PLAYER) {
			if (distance_f <= player_radius_f || player_radius_f == 0)
				continue;
		} else if (distance_f <= radius_f)
			continue;

		// Object is no longer visible
		removed_objects.push(id);
	}
}

void ServerEnvironment::setStaticForActiveObjectsInBlock(
	v3s16 blockpos, bool static_exists, v3s16 static_block)
{
	MapBlock *block = m_map->getBlockNoCreateNoEx(blockpos);
	if (!block)
		return;

	for (std::map<u16, StaticObject>::iterator
		so_it = block->m_static_objects.m_active.begin();
		so_it != block->m_static_objects.m_active.end(); ++so_it) {
		// Get the ServerActiveObject counterpart to this StaticObject
		ActiveObjectMap::iterator ao_it = m_active_objects.find(so_it->first);
		if (ao_it == m_active_objects.end()) {
			// If this ever happens, there must be some kind of nasty bug.
			errorstream << "ServerEnvironment::setStaticForObjectsInBlock(): "
				"Object from MapBlock::m_static_objects::m_active not found "
				"in m_active_objects";
			continue;
		}

		ServerActiveObject *sao = ao_it->second;
		sao->m_static_exists = static_exists;
		sao->m_static_block  = static_block;
	}
}

ActiveObjectMessage ServerEnvironment::getActiveObjectMessage()
{
	if(m_active_object_messages.empty())
		return ActiveObjectMessage(0);

	ActiveObjectMessage message = m_active_object_messages.front();
	m_active_object_messages.pop();
	return message;
}

/*
	************ Private methods *************
*/

u16 ServerEnvironment::addActiveObjectRaw(ServerActiveObject *object,
	bool set_changed, u32 dtime_s)
{
	assert(object); // Pre-condition
	if(object->getId() == 0){
		u16 new_id = getFreeServerActiveObjectId(m_active_objects);
		if(new_id == 0)
		{
			errorstream<<"ServerEnvironment::addActiveObjectRaw(): "
				<<"no free ids available"<<std::endl;
			if(object->environmentDeletes())
				delete object;
			return 0;
		}
		object->setId(new_id);
	}
	else{
		verbosestream<<"ServerEnvironment::addActiveObjectRaw(): "
			<<"supplied with id "<<object->getId()<<std::endl;
	}

	if(!isFreeServerActiveObjectId(object->getId(), m_active_objects)) {
		errorstream<<"ServerEnvironment::addActiveObjectRaw(): "
			<<"id is not free ("<<object->getId()<<")"<<std::endl;
		if(object->environmentDeletes())
			delete object;
		return 0;
	}

	if (objectpos_over_limit(object->getBasePosition())) {
		v3f p = object->getBasePosition();
		warningstream << "ServerEnvironment::addActiveObjectRaw(): "
			<< "object position (" << p.X << "," << p.Y << "," << p.Z
			<< ") outside maximum range" << std::endl;
		if (object->environmentDeletes())
			delete object;
		return 0;
	}

	/*infostream<<"ServerEnvironment::addActiveObjectRaw(): "
			<<"added (id="<<object->getId()<<")"<<std::endl;*/

	m_active_objects[object->getId()] = object;

	verbosestream<<"ServerEnvironment::addActiveObjectRaw(): "
		<<"Added id="<<object->getId()<<"; there are now "
		<<m_active_objects.size()<<" active objects."
		<<std::endl;

	// Register reference in scripting api (must be done before post-init)
	m_script->addObjectReference(object);
	// Post-initialize object
	object->addedToEnvironment(dtime_s);

	// Add static data to block
	if(object->isStaticAllowed())
	{
		// Add static object to active static list of the block
		v3f objectpos = object->getBasePosition();
		std::string staticdata = "";
		object->getStaticData(&staticdata);
		StaticObject s_obj(object->getType(), objectpos, staticdata);
		// Add to the block where the object is located in
		v3s16 blockpos = getNodeBlockPos(floatToInt(objectpos, BS));
		MapBlock *block = m_map->emergeBlock(blockpos);
		if(block){
			block->m_static_objects.m_active[object->getId()] = s_obj;
			object->m_static_exists = true;
			object->m_static_block = blockpos;

			if(set_changed)
				block->raiseModified(MOD_STATE_WRITE_NEEDED,
					MOD_REASON_ADD_ACTIVE_OBJECT_RAW);
		} else {
			v3s16 p = floatToInt(objectpos, BS);
			errorstream<<"ServerEnvironment::addActiveObjectRaw(): "
				<<"could not emerge block for storing id="<<object->getId()
				<<" statically (pos="<<PP(p)<<")"<<std::endl;
		}
	}

	return object->getId();
}

/*
	Remove objects that satisfy (m_removed && m_known_by_count==0)
*/
void ServerEnvironment::removeRemovedObjects()
{
	std::vector<u16> objects_to_remove;
	for(ActiveObjectMap::iterator i = m_active_objects.begin();
		i != m_active_objects.end(); ++i) {
		u16 id = i->first;
		ServerActiveObject* obj = i->second;
		// This shouldn't happen but check it
		if(obj == NULL)
		{
			infostream<<"NULL object found in ServerEnvironment"
				<<" while finding removed objects. id="<<id<<std::endl;
			// Id to be removed from m_active_objects
			objects_to_remove.push_back(id);
			continue;
		}

		/*
			We will delete objects that are marked as removed or thatare
			waiting for deletion after deactivation
		*/
		if (!obj->m_removed && !obj->m_pending_deactivation)
			continue;

		/*
			Delete static data from block if is marked as removed
		*/
		if(obj->m_static_exists && obj->m_removed)
		{
			MapBlock *block = m_map->emergeBlock(obj->m_static_block, false);
			if (block) {
				block->m_static_objects.remove(id);
				block->raiseModified(MOD_STATE_WRITE_NEEDED,
					MOD_REASON_REMOVE_OBJECTS_REMOVE);
				obj->m_static_exists = false;
			} else {
				infostream<<"Failed to emerge block from which an object to "
					<<"be removed was loaded from. id="<<id<<std::endl;
			}
		}

		// If m_known_by_count > 0, don't actually remove. On some future
		// invocation this will be 0, which is when removal will continue.
		if(obj->m_known_by_count > 0)
			continue;

		/*
			Move static data from active to stored if not marked as removed
		*/
		if(obj->m_static_exists && !obj->m_removed){
			MapBlock *block = m_map->emergeBlock(obj->m_static_block, false);
			if (block) {
				std::map<u16, StaticObject>::iterator i =
					block->m_static_objects.m_active.find(id);
				if(i != block->m_static_objects.m_active.end()){
					block->m_static_objects.m_stored.push_back(i->second);
					block->m_static_objects.m_active.erase(id);
					block->raiseModified(MOD_STATE_WRITE_NEEDED,
						MOD_REASON_REMOVE_OBJECTS_DEACTIVATE);
				}
			} else {
				infostream<<"Failed to emerge block from which an object to "
					<<"be deactivated was loaded from. id="<<id<<std::endl;
			}
		}

		// Tell the object about removal
		obj->removingFromEnvironment();
		// Deregister in scripting api
		m_script->removeObjectReference(obj);

		// Delete
		if(obj->environmentDeletes())
			delete obj;

		// Id to be removed from m_active_objects
		objects_to_remove.push_back(id);
	}
	// Remove references from m_active_objects
	for(std::vector<u16>::iterator i = objects_to_remove.begin();
		i != objects_to_remove.end(); ++i) {
		m_active_objects.erase(*i);
	}
}

static void print_hexdump(std::ostream &o, const std::string &data)
{
	const int linelength = 16;
	for(int l=0; ; l++){
		int i0 = linelength * l;
		bool at_end = false;
		int thislinelength = linelength;
		if(i0 + thislinelength > (int)data.size()){
			thislinelength = data.size() - i0;
			at_end = true;
		}
		for(int di=0; di<linelength; di++){
			int i = i0 + di;
			char buf[4];
			if(di<thislinelength)
				snprintf(buf, 4, "%.2x ", data[i]);
			else
				snprintf(buf, 4, "   ");
			o<<buf;
		}
		o<<" ";
		for(int di=0; di<thislinelength; di++){
			int i = i0 + di;
			if(data[i] >= 32)
				o<<data[i];
			else
				o<<".";
		}
		o<<std::endl;
		if(at_end)
			break;
	}
}

/*
	Convert stored objects from blocks near the players to active.
*/
void ServerEnvironment::activateObjects(MapBlock *block, u32 dtime_s)
{
	if(block == NULL)
		return;

	// Ignore if no stored objects (to not set changed flag)
	if(block->m_static_objects.m_stored.empty())
		return;

	verbosestream<<"ServerEnvironment::activateObjects(): "
		<<"activating objects of block "<<PP(block->getPos())
		<<" ("<<block->m_static_objects.m_stored.size()
		<<" objects)"<<std::endl;
	bool large_amount = (block->m_static_objects.m_stored.size() > g_settings->getU16("max_objects_per_block"));
	if (large_amount) {
		errorstream<<"suspiciously large amount of objects detected: "
			<<block->m_static_objects.m_stored.size()<<" in "
			<<PP(block->getPos())
			<<"; removing all of them."<<std::endl;
		// Clear stored list
		block->m_static_objects.m_stored.clear();
		block->raiseModified(MOD_STATE_WRITE_NEEDED,
			MOD_REASON_TOO_MANY_OBJECTS);
		return;
	}

	// Activate stored objects
	std::vector<StaticObject> new_stored;
	for (std::vector<StaticObject>::iterator
		i = block->m_static_objects.m_stored.begin();
		i != block->m_static_objects.m_stored.end(); ++i) {
		StaticObject &s_obj = *i;

		// Create an active object from the data
		ServerActiveObject *obj = ServerActiveObject::create
			((ActiveObjectType) s_obj.type, this, 0, s_obj.pos, s_obj.data);
		// If couldn't create object, store static data back.
		if(obj == NULL) {
			errorstream<<"ServerEnvironment::activateObjects(): "
				<<"failed to create active object from static object "
				<<"in block "<<PP(s_obj.pos/BS)
				<<" type="<<(int)s_obj.type<<" data:"<<std::endl;
			print_hexdump(verbosestream, s_obj.data);

			new_stored.push_back(s_obj);
			continue;
		}
		verbosestream<<"ServerEnvironment::activateObjects(): "
			<<"activated static object pos="<<PP(s_obj.pos/BS)
			<<" type="<<(int)s_obj.type<<std::endl;
		// This will also add the object to the active static list
		addActiveObjectRaw(obj, false, dtime_s);
	}
	// Clear stored list
	block->m_static_objects.m_stored.clear();
	// Add leftover failed stuff to stored list
	for(std::vector<StaticObject>::iterator
		i = new_stored.begin();
		i != new_stored.end(); ++i) {
		StaticObject &s_obj = *i;
		block->m_static_objects.m_stored.push_back(s_obj);
	}

	// Turn the active counterparts of activated objects not pending for
	// deactivation
	for(std::map<u16, StaticObject>::iterator
		i = block->m_static_objects.m_active.begin();
		i != block->m_static_objects.m_active.end(); ++i)
	{
		u16 id = i->first;
		ServerActiveObject *object = getActiveObject(id);
		assert(object);
		object->m_pending_deactivation = false;
	}

	/*
		Note: Block hasn't really been modified here.
		The objects have just been activated and moved from the stored
		static list to the active static list.
		As such, the block is essentially the same.
		Thus, do not call block->raiseModified(MOD_STATE_WRITE_NEEDED).
		Otherwise there would be a huge amount of unnecessary I/O.
	*/
}

/*
	Convert objects that are not standing inside active blocks to static.

	If m_known_by_count != 0, active object is not deleted, but static
	data is still updated.

	If force_delete is set, active object is deleted nevertheless. It
	shall only be set so in the destructor of the environment.

	If block wasn't generated (not in memory or on disk),
*/
void ServerEnvironment::deactivateFarObjects(bool _force_delete)
{
	std::vector<u16> objects_to_remove;
	for(ActiveObjectMap::iterator i = m_active_objects.begin();
		i != m_active_objects.end(); ++i) {
		// force_delete might be overriden per object
		bool force_delete = _force_delete;

		ServerActiveObject* obj = i->second;
		assert(obj);

		// Do not deactivate if static data creation not allowed
		if(!force_delete && !obj->isStaticAllowed())
			continue;

		// If pending deactivation, let removeRemovedObjects() do it
		if(!force_delete && obj->m_pending_deactivation)
			continue;

		u16 id = i->first;
		v3f objectpos = obj->getBasePosition();

		// The block in which the object resides in
		v3s16 blockpos_o = getNodeBlockPos(floatToInt(objectpos, BS));

		// If object's static data is stored in a deactivated block and object
		// is actually located in an active block, re-save to the block in
		// which the object is actually located in.
		if(!force_delete &&
			obj->m_static_exists &&
			!m_active_blocks.contains(obj->m_static_block) &&
			m_active_blocks.contains(blockpos_o))
		{
			v3s16 old_static_block = obj->m_static_block;

			// Save to block where object is located
			MapBlock *block = m_map->emergeBlock(blockpos_o, false);
			if(!block){
				errorstream<<"ServerEnvironment::deactivateFarObjects(): "
					<<"Could not save object id="<<id
					<<" to it's current block "<<PP(blockpos_o)
					<<std::endl;
				continue;
			}
			std::string staticdata_new = "";
			obj->getStaticData(&staticdata_new);
			StaticObject s_obj(obj->getType(), objectpos, staticdata_new);
			block->m_static_objects.insert(id, s_obj);
			obj->m_static_block = blockpos_o;
			block->raiseModified(MOD_STATE_WRITE_NEEDED,
				MOD_REASON_STATIC_DATA_ADDED);

			// Delete from block where object was located
			block = m_map->emergeBlock(old_static_block, false);
			if(!block){
				errorstream<<"ServerEnvironment::deactivateFarObjects(): "
					<<"Could not delete object id="<<id
					<<" from it's previous block "<<PP(old_static_block)
					<<std::endl;
				continue;
			}
			block->m_static_objects.remove(id);
			block->raiseModified(MOD_STATE_WRITE_NEEDED,
				MOD_REASON_STATIC_DATA_REMOVED);
			continue;
		}

		// If block is active, don't remove
		if(!force_delete && m_active_blocks.contains(blockpos_o))
			continue;

		verbosestream<<"ServerEnvironment::deactivateFarObjects(): "
			<<"deactivating object id="<<id<<" on inactive block "
			<<PP(blockpos_o)<<std::endl;

		// If known by some client, don't immediately delete.
		bool pending_delete = (obj->m_known_by_count > 0 && !force_delete);

		/*
			Update the static data
		*/

		if(obj->isStaticAllowed())
		{
			// Create new static object
			std::string staticdata_new = "";
			obj->getStaticData(&staticdata_new);
			StaticObject s_obj(obj->getType(), objectpos, staticdata_new);

			bool stays_in_same_block = false;
			bool data_changed = true;

			if (obj->m_static_exists) {
				if (obj->m_static_block == blockpos_o)
					stays_in_same_block = true;

				MapBlock *block = m_map->emergeBlock(obj->m_static_block, false);

				if (block) {
					std::map<u16, StaticObject>::iterator n =
						block->m_static_objects.m_active.find(id);
					if (n != block->m_static_objects.m_active.end()) {
						StaticObject static_old = n->second;

						float save_movem = obj->getMinimumSavedMovement();

						if (static_old.data == staticdata_new &&
							(static_old.pos - objectpos).getLength() < save_movem)
							data_changed = false;
					} else {
						errorstream<<"ServerEnvironment::deactivateFarObjects(): "
							<<"id="<<id<<" m_static_exists=true but "
							<<"static data doesn't actually exist in "
							<<PP(obj->m_static_block)<<std::endl;
					}
				}
			}

			bool shall_be_written = (!stays_in_same_block || data_changed);

			// Delete old static object
			if(obj->m_static_exists)
			{
				MapBlock *block = m_map->emergeBlock(obj->m_static_block, false);
				if(block)
				{
					block->m_static_objects.remove(id);
					obj->m_static_exists = false;
					// Only mark block as modified if data changed considerably
					if(shall_be_written)
						block->raiseModified(MOD_STATE_WRITE_NEEDED,
							MOD_REASON_STATIC_DATA_CHANGED);
				}
			}

			// Add to the block where the object is located in
			v3s16 blockpos = getNodeBlockPos(floatToInt(objectpos, BS));
			// Get or generate the block
			MapBlock *block = NULL;
			try{
				block = m_map->emergeBlock(blockpos);
			} catch(InvalidPositionException &e){
				// Handled via NULL pointer
				// NOTE: emergeBlock's failure is usually determined by it
				//       actually returning NULL
			}

			if(block)
			{
				if (block->m_static_objects.m_stored.size() >= g_settings->getU16("max_objects_per_block")) {
					warningstream << "ServerEnv: Trying to store id = " << obj->getId()
						<< " statically but block " << PP(blockpos)
						<< " already contains "
						<< block->m_static_objects.m_stored.size()
						<< " objects."
						<< " Forcing delete." << std::endl;
					force_delete = true;
				} else {
					// If static counterpart already exists in target block,
					// remove it first.
					// This shouldn't happen because the object is removed from
					// the previous block before this according to
					// obj->m_static_block, but happens rarely for some unknown
					// reason. Unsuccessful attempts have been made to find
					// said reason.
					if(id && block->m_static_objects.m_active.find(id) != block->m_static_objects.m_active.end()){
						warningstream<<"ServerEnv: Performing hack #83274"
							<<std::endl;
						block->m_static_objects.remove(id);
					}
					// Store static data
					u16 store_id = pending_delete ? id : 0;
					block->m_static_objects.insert(store_id, s_obj);

					// Only mark block as modified if data changed considerably
					if(shall_be_written)
						block->raiseModified(MOD_STATE_WRITE_NEEDED,
							MOD_REASON_STATIC_DATA_CHANGED);

					obj->m_static_exists = true;
					obj->m_static_block = block->getPos();
				}
			}
			else{
				if(!force_delete){
					v3s16 p = floatToInt(objectpos, BS);
					errorstream<<"ServerEnv: Could not find or generate "
						<<"a block for storing id="<<obj->getId()
						<<" statically (pos="<<PP(p)<<")"<<std::endl;
					continue;
				}
			}
		}

		/*
			If known by some client, set pending deactivation.
			Otherwise delete it immediately.
		*/

		if(pending_delete && !force_delete)
		{
			verbosestream<<"ServerEnvironment::deactivateFarObjects(): "
				<<"object id="<<id<<" is known by clients"
				<<"; not deleting yet"<<std::endl;

			obj->m_pending_deactivation = true;
			continue;
		}

		verbosestream<<"ServerEnvironment::deactivateFarObjects(): "
			<<"object id="<<id<<" is not known by clients"
			<<"; deleting"<<std::endl;

		// Tell the object about removal
		obj->removingFromEnvironment();
		// Deregister in scripting api
		m_script->removeObjectReference(obj);

		// Delete active object
		if(obj->environmentDeletes())
			delete obj;
		// Id to be removed from m_active_objects
		objects_to_remove.push_back(id);
	}

	// Remove references from m_active_objects
	for(std::vector<u16>::iterator i = objects_to_remove.begin();
		i != objects_to_remove.end(); ++i) {
		m_active_objects.erase(*i);
	}
}

PlayerDatabase *ServerEnvironment::openPlayerDatabase(const std::string &name,
		const std::string &savedir, const Settings &conf)
{

	if (name == "sqlite3")
		return new PlayerDatabaseSQLite3(savedir);
	else if (name == "dummy")
		return new Database_Dummy();
#if USE_POSTGRESQL
	else if (name == "postgresql") {
		std::string connect_string = "";
		conf.getNoEx("pgsql_player_connection", connect_string);
		return new PlayerDatabasePostgreSQL(connect_string);
	}
#endif
	else if (name == "files")
		return new PlayerDatabaseFiles(savedir + DIR_DELIM + "players");
	else
		throw BaseException(std::string("Database backend ") + name + " not supported.");
}

bool ServerEnvironment::migratePlayersDatabase(const GameParams &game_params,
		const Settings &cmd_args)
{
	std::string migrate_to = cmd_args.get("migrate-players");
	Settings world_mt;
	std::string world_mt_path = game_params.world_path + DIR_DELIM + "world.mt";
	if (!world_mt.readConfigFile(world_mt_path.c_str())) {
		errorstream << "Cannot read world.mt!" << std::endl;
		return false;
	}

	if (!world_mt.exists("player_backend")) {
		errorstream << "Please specify your current backend in world.mt:"
			<< std::endl
			<< "	player_backend = {files|sqlite3|postgresql}"
			<< std::endl;
		return false;
	}

	std::string backend = world_mt.get("player_backend");
	if (backend == migrate_to) {
		errorstream << "Cannot migrate: new backend is same"
			<< " as the old one" << std::endl;
		return false;
	}

	const std::string players_backup_path = game_params.world_path + DIR_DELIM
		+ "players.bak";

	if (backend == "files") {
		// Create backup directory
		fs::CreateDir(players_backup_path);
	}

	try {
		PlayerDatabase *srcdb = ServerEnvironment::openPlayerDatabase(backend,
			game_params.world_path, world_mt);
		PlayerDatabase *dstdb = ServerEnvironment::openPlayerDatabase(migrate_to,
			game_params.world_path, world_mt);

		std::vector<std::string> player_list;
		srcdb->listPlayers(player_list);
		for (std::vector<std::string>::const_iterator it = player_list.begin();
			it != player_list.end(); ++it) {
			actionstream << "Migrating player " << it->c_str() << std::endl;
			RemotePlayer player(it->c_str(), NULL);
			PlayerSAO playerSAO(NULL, &player, 15000, false);

			srcdb->loadPlayer(&player, &playerSAO);

			playerSAO.finalize(&player, std::set<std::string>());
			player.setPlayerSAO(&playerSAO);

			dstdb->savePlayer(&player);

			// For files source, move player files to backup dir
			if (backend == "files") {
				fs::Rename(
					game_params.world_path + DIR_DELIM + "players" + DIR_DELIM + (*it),
					players_backup_path + DIR_DELIM + (*it));
			}
		}

		actionstream << "Successfully migrated " << player_list.size() << " players"
			<< std::endl;
		world_mt.set("player_backend", migrate_to);
		if (!world_mt.updateConfigFile(world_mt_path.c_str()))
			errorstream << "Failed to update world.mt!" << std::endl;
		else
			actionstream << "world.mt updated" << std::endl;

		// When migration is finished from file backend, remove players directory if empty
		if (backend == "files") {
			fs::DeleteSingleFileOrEmptyDirectory(game_params.world_path + DIR_DELIM
				+ "players");
		}

		delete srcdb;
		delete dstdb;

	} catch (BaseException &e) {
		errorstream << "An error occured during migration: " << e.what() << std::endl;
		return false;
	}
	return true;
}
