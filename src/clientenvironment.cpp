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

#include "util/serialize.h"
#include "util/pointedthing.h"
#include "client.h"
#include "clientenvironment.h"
#include "clientsimpleobject.h"
#include "clientmap.h"
#include "scripting_client.h"
#include "mapblock_mesh.h"
#include "event.h"
#include "collision.h"
#include "nodedef.h"
#include "profiler.h"
#include "raycast.h"
#include "voxelalgorithms.h"
#include "settings.h"
#include "content_cao.h"
#include <algorithm>
#include "client/renderingengine.h"

/*
	ClientEnvironment
*/

ClientEnvironment::ClientEnvironment(ClientMap *map,
	ITextureSource *texturesource, Client *client):
	Environment(client),
	m_map(map),
	m_texturesource(texturesource),
	m_client(client)
{
	char zero = 0;
	memset(attachement_parent_ids, zero, sizeof(attachement_parent_ids));
}

ClientEnvironment::~ClientEnvironment()
{
	// delete active objects
	for (auto &active_object : m_active_objects) {
		delete active_object.second;
	}

	for (auto &simple_object : m_simple_objects) {
		delete simple_object;
	}

	// Drop/delete map
	m_map->drop();

	delete m_local_player;
}

Map & ClientEnvironment::getMap()
{
	return *m_map;
}

ClientMap & ClientEnvironment::getClientMap()
{
	return *m_map;
}

void ClientEnvironment::setLocalPlayer(LocalPlayer *player)
{
	/*
		It is a failure if already is a local player
	*/
	FATAL_ERROR_IF(m_local_player != NULL,
		"Local player already allocated");

	m_local_player = player;
}

void ClientEnvironment::step(float dtime)
{
	/* Step time of day */
	stepTimeOfDay(dtime);

	// Get some settings
	bool fly_allowed = m_client->checkLocalPrivilege("fly");
	bool free_move = fly_allowed && g_settings->getBool("free_move");

	// Get local player
	LocalPlayer *lplayer = getLocalPlayer();
	assert(lplayer);
	// collision info queue
	std::vector<CollisionInfo> player_collisions;

	/*
		Get the speed the player is going
	*/
	bool is_climbing = lplayer->is_climbing;

	f32 player_speed = lplayer->getSpeed().getLength();

	/*
		Maximum position increment
	*/
	//f32 position_max_increment = 0.05*BS;
	f32 position_max_increment = 0.1*BS;

	// Maximum time increment (for collision detection etc)
	// time = distance / speed
	f32 dtime_max_increment = 1;
	if(player_speed > 0.001)
		dtime_max_increment = position_max_increment / player_speed;

	// Maximum time increment is 10ms or lower
	if(dtime_max_increment > 0.01)
		dtime_max_increment = 0.01;

	// Don't allow overly huge dtime
	if(dtime > 0.5)
		dtime = 0.5;

	f32 dtime_downcount = dtime;

	/*
		Stuff that has a maximum time increment
	*/

	u32 loopcount = 0;
	do
	{
		loopcount++;

		f32 dtime_part;
		if(dtime_downcount > dtime_max_increment)
		{
			dtime_part = dtime_max_increment;
			dtime_downcount -= dtime_part;
		}
		else
		{
			dtime_part = dtime_downcount;
			/*
				Setting this to 0 (no -=dtime_part) disables an infinite loop
				when dtime_part is so small that dtime_downcount -= dtime_part
				does nothing
			*/
			dtime_downcount = 0;
		}

		/*
			Handle local player
		*/

		{
			// Apply physics
			if(!free_move && !is_climbing)
			{
				// Gravity
				v3f speed = lplayer->getSpeed();
				if(!lplayer->in_liquid)
					speed.Y -= lplayer->movement_gravity * lplayer->physics_override_gravity * dtime_part * 2;

				// Liquid floating / sinking
				if(lplayer->in_liquid && !lplayer->swimming_vertical)
					speed.Y -= lplayer->movement_liquid_sink * dtime_part * 2;

				// Liquid resistance
				if(lplayer->in_liquid_stable || lplayer->in_liquid)
				{
					// How much the node's viscosity blocks movement, ranges between 0 and 1
					// Should match the scale at which viscosity increase affects other liquid attributes
					const f32 viscosity_factor = 0.3;

					v3f d_wanted = -speed / lplayer->movement_liquid_fluidity;
					f32 dl = d_wanted.getLength();
					if(dl > lplayer->movement_liquid_fluidity_smooth)
						dl = lplayer->movement_liquid_fluidity_smooth;
					dl *= (lplayer->liquid_viscosity * viscosity_factor) + (1 - viscosity_factor);

					v3f d = d_wanted.normalize() * dl;
					speed += d;
				}

				lplayer->setSpeed(speed);
			}

			/*
				Move the lplayer.
				This also does collision detection.
			*/
			lplayer->move(dtime_part, this, position_max_increment,
				&player_collisions);
		}
	}
	while(dtime_downcount > 0.001);

	//std::cout<<"Looped "<<loopcount<<" times."<<std::endl;

	bool player_immortal = lplayer->getCAO() && lplayer->getCAO()->isImmortal();

	for (const CollisionInfo &info : player_collisions) {
		v3f speed_diff = info.new_speed - info.old_speed;;
		// Handle only fall damage
		// (because otherwise walking against something in fast_move kills you)
		if (speed_diff.Y < 0 || info.old_speed.Y >= 0)
			continue;
		// Get rid of other components
		speed_diff.X = 0;
		speed_diff.Z = 0;
		f32 pre_factor = 1; // 1 hp per node/s
		f32 tolerance = BS*14; // 5 without damage
		f32 post_factor = 1; // 1 hp per node/s
		if (info.type == COLLISION_NODE) {
			const ContentFeatures &f = m_client->ndef()->
				get(m_map->getNodeNoEx(info.node_p));
			// Determine fall damage multiplier
			int addp = itemgroup_get(f.groups, "fall_damage_add_percent");
			pre_factor = 1.0 + (float)addp/100.0;
		}
		float speed = pre_factor * speed_diff.getLength();
		if (speed > tolerance && !player_immortal) {
			f32 damage_f = (speed - tolerance) / BS * post_factor;
			u8 damage = (u8)MYMIN(damage_f + 0.5, 255);
			if (damage != 0) {
				damageLocalPlayer(damage, true);
				MtEvent *e = new SimpleTriggerEvent("PlayerFallingDamage");
				m_client->event()->put(e);
			}
		}
	}

	if (m_client->moddingEnabled()) {
		m_script->environment_step(dtime);
	}

	// Update lighting on local player (used for wield item)
	u32 day_night_ratio = getDayNightRatio();
	{
		// Get node at head

		// On InvalidPositionException, use this as default
		// (day: LIGHT_SUN, night: 0)
		MapNode node_at_lplayer(CONTENT_AIR, 0x0f, 0);

		v3s16 p = lplayer->getLightPosition();
		node_at_lplayer = m_map->getNodeNoEx(p);

		u16 light = getInteriorLight(node_at_lplayer, 0, m_client->ndef());
		final_color_blend(&lplayer->light_color, light, day_night_ratio);
	}

	/*
		Step active objects and update lighting of them
	*/

	g_profiler->avg("CEnv: num of objects", m_active_objects.size());
	bool update_lighting = m_active_object_light_update_interval.step(dtime, 0.21);
	for (auto &ao_it : m_active_objects) {
		ClientActiveObject* obj = ao_it.second;
		// Step object
		obj->step(dtime, this);

		if (update_lighting) {
			// Update lighting
			u8 light = 0;
			bool pos_ok;

			// Get node at head
			v3s16 p = obj->getLightPosition();
			MapNode n = m_map->getNodeNoEx(p, &pos_ok);
			if (pos_ok)
				light = n.getLightBlend(day_night_ratio, m_client->ndef());
			else
				light = blend_light(day_night_ratio, LIGHT_SUN, 0);

			obj->updateLight(light);
		}
	}

	/*
		Step and handle simple objects
	*/
	g_profiler->avg("CEnv: num of simple objects", m_simple_objects.size());
	for (auto i = m_simple_objects.begin(); i != m_simple_objects.end();) {
		auto cur = i;
		ClientSimpleObject *simple = *cur;

		simple->step(dtime);
		if(simple->m_to_be_removed) {
			delete simple;
			i = m_simple_objects.erase(cur);
		}
		else {
			++i;
		}
	}
}

void ClientEnvironment::addSimpleObject(ClientSimpleObject *simple)
{
	m_simple_objects.push_back(simple);
}

GenericCAO* ClientEnvironment::getGenericCAO(u16 id)
{
	ClientActiveObject *obj = getActiveObject(id);
	if (obj && obj->getType() == ACTIVEOBJECT_TYPE_GENERIC)
		return (GenericCAO*) obj;

	return NULL;
}

ClientActiveObject* ClientEnvironment::getActiveObject(u16 id)
{
	auto n = m_active_objects.find(id);
	if (n == m_active_objects.end())
		return NULL;
	return n->second;
}

bool isFreeClientActiveObjectId(const u16 id,
	ClientActiveObjectMap &objects)
{
	return id != 0 && objects.find(id) == objects.end();

}

u16 getFreeClientActiveObjectId(ClientActiveObjectMap &objects)
{
	//try to reuse id's as late as possible
	static u16 last_used_id = 0;
	u16 startid = last_used_id;
	for(;;) {
		last_used_id ++;
		if (isFreeClientActiveObjectId(last_used_id, objects))
			return last_used_id;

		if (last_used_id == startid)
			return 0;
	}
}

u16 ClientEnvironment::addActiveObject(ClientActiveObject *object)
{
	assert(object); // Pre-condition
	if(object->getId() == 0)
	{
		u16 new_id = getFreeClientActiveObjectId(m_active_objects);
		if(new_id == 0)
		{
			infostream<<"ClientEnvironment::addActiveObject(): "
				<<"no free ids available"<<std::endl;
			delete object;
			return 0;
		}
		object->setId(new_id);
	}
	if (!isFreeClientActiveObjectId(object->getId(), m_active_objects)) {
		infostream<<"ClientEnvironment::addActiveObject(): "
			<<"id is not free ("<<object->getId()<<")"<<std::endl;
		delete object;
		return 0;
	}
	infostream<<"ClientEnvironment::addActiveObject(): "
		<<"added (id="<<object->getId()<<")"<<std::endl;
	m_active_objects[object->getId()] = object;
	object->addToScene(m_texturesource);
	{ // Update lighting immediately
		u8 light = 0;
		bool pos_ok;

		// Get node at head
		v3s16 p = object->getLightPosition();
		MapNode n = m_map->getNodeNoEx(p, &pos_ok);
		if (pos_ok)
			light = n.getLightBlend(getDayNightRatio(), m_client->ndef());
		else
			light = blend_light(getDayNightRatio(), LIGHT_SUN, 0);

		object->updateLight(light);
	}
	return object->getId();
}

void ClientEnvironment::addActiveObject(u16 id, u8 type,
	const std::string &init_data)
{
	ClientActiveObject* obj =
		ClientActiveObject::create((ActiveObjectType) type, m_client, this);
	if(obj == NULL)
	{
		infostream<<"ClientEnvironment::addActiveObject(): "
			<<"id="<<id<<" type="<<type<<": Couldn't create object"
			<<std::endl;
		return;
	}

	obj->setId(id);

	try
	{
		obj->initialize(init_data);
	}
	catch(SerializationError &e)
	{
		errorstream<<"ClientEnvironment::addActiveObject():"
			<<" id="<<id<<" type="<<type
			<<": SerializationError in initialize(): "
			<<e.what()
			<<": init_data="<<serializeJsonString(init_data)
			<<std::endl;
	}

	addActiveObject(obj);
}

void ClientEnvironment::removeActiveObject(u16 id)
{
	verbosestream<<"ClientEnvironment::removeActiveObject(): "
		<<"id="<<id<<std::endl;
	ClientActiveObject* obj = getActiveObject(id);
	if (obj == NULL) {
		infostream<<"ClientEnvironment::removeActiveObject(): "
			<<"id="<<id<<" not found"<<std::endl;
		return;
	}
	obj->removeFromScene(true);
	delete obj;
	m_active_objects.erase(id);
}

void ClientEnvironment::processActiveObjectMessage(u16 id, const std::string &data)
{
	ClientActiveObject *obj = getActiveObject(id);
	if (obj == NULL) {
		infostream << "ClientEnvironment::processActiveObjectMessage():"
			<< " got message for id=" << id << ", which doesn't exist."
			<< std::endl;
		return;
	}

	try {
		obj->processMessage(data);
	} catch (SerializationError &e) {
		errorstream<<"ClientEnvironment::processActiveObjectMessage():"
			<< " id=" << id << " type=" << obj->getType()
			<< " SerializationError in processMessage(): " << e.what()
			<< std::endl;
	}
}

/*
	Callbacks for activeobjects
*/

void ClientEnvironment::damageLocalPlayer(u8 damage, bool handle_hp)
{
	LocalPlayer *lplayer = getLocalPlayer();
	assert(lplayer);

	if (handle_hp) {
		if (lplayer->hp > damage)
			lplayer->hp -= damage;
		else
			lplayer->hp = 0;
	}

	ClientEnvEvent event;
	event.type = CEE_PLAYER_DAMAGE;
	event.player_damage.amount = damage;
	event.player_damage.send_to_server = handle_hp;
	m_client_event_queue.push(event);
}

void ClientEnvironment::updateLocalPlayerBreath(u16 breath)
{
	ClientEnvEvent event;
	event.type = CEE_PLAYER_BREATH;
	event.player_breath.amount = breath;
	m_client_event_queue.push(event);
}

/*
	Client likes to call these
*/

void ClientEnvironment::getActiveObjects(v3f origin, f32 max_d,
	std::vector<DistanceSortedActiveObject> &dest)
{
	for (auto &ao_it : m_active_objects) {
		ClientActiveObject* obj = ao_it.second;

		f32 d = (obj->getPosition() - origin).getLength();

		if (d > max_d)
			continue;

		dest.emplace_back(obj, d);
	}
}

ClientEnvEvent ClientEnvironment::getClientEnvEvent()
{
	FATAL_ERROR_IF(m_client_event_queue.empty(),
			"ClientEnvironment::getClientEnvEvent(): queue is empty");

	ClientEnvEvent event = m_client_event_queue.front();
	m_client_event_queue.pop();
	return event;
}

void ClientEnvironment::getSelectedActiveObjects(
	const core::line3d<f32> &shootline_on_map,
	std::vector<PointedThing> &objects)
{
	std::vector<DistanceSortedActiveObject> allObjects;
	getActiveObjects(shootline_on_map.start,
		shootline_on_map.getLength() + 10.0f, allObjects);
	const v3f line_vector = shootline_on_map.getVector();

	for (const auto &allObject : allObjects) {
		ClientActiveObject *obj = allObject.obj;
		aabb3f selection_box;
		if (!obj->getSelectionBox(&selection_box))
			continue;

		const v3f &pos = obj->getPosition();
		aabb3f offsetted_box(selection_box.MinEdge + pos,
			selection_box.MaxEdge + pos);

		v3f current_intersection;
		v3s16 current_normal;
		if (boxLineCollision(offsetted_box, shootline_on_map.start, line_vector,
				&current_intersection, &current_normal)) {
			objects.emplace_back((s16) obj->getId(), current_intersection, current_normal,
				(current_intersection - shootline_on_map.start).getLengthSQ());
		}
	}
}
