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

#pragma once

#include "irrlichttypes_extrabloated.h"
#include "activeobject.h"
#include <unordered_map>

class ClientEnvironment;
class ITextureSource;
class Client;
class IGameDef;
class LocalPlayer;
struct ItemStack;
class WieldMeshSceneNode;

class ClientActiveObject : public ActiveObject
{
public:
	ClientActiveObject(u16 id, Client *client, ClientEnvironment *env);
	virtual ~ClientActiveObject();

	virtual void addToScene(ITextureSource *tsrc) {};
	virtual void removeFromScene(bool permanent) {}
	// 0 <= light_at_pos <= LIGHT_SUN
	virtual void updateLight(u8 light_at_pos){}
	virtual void updateLightNoCheck(u8 light_at_pos){}
	virtual v3s16 getLightPosition(){return v3s16(0,0,0);}
	virtual bool getCollisionBox(aabb3f *toset) const { return false; }
	virtual bool getSelectionBox(aabb3f *toset) const { return false; }
	virtual bool collideWithObjects() const { return false; }
	virtual v3f getPosition(){ return v3f(0,0,0); }
	virtual float getYaw() const { return 0; }
	virtual scene::ISceneNode *getSceneNode() { return NULL; }
	virtual scene::IAnimatedMeshSceneNode *getAnimatedMeshSceneNode() { return NULL; }
	virtual bool isLocalPlayer() const {return false;}
	virtual ClientActiveObject *getParent() const { return nullptr; };
	virtual void setAttachments() {}
	virtual bool doShowSelectionBox(){return true;}

	// Step object in time
	virtual void step(float dtime, ClientEnvironment *env){}

	// Process a message sent by the server side object
	virtual void processMessage(const std::string &data){}

	virtual std::string infoText() {return "";}
	virtual std::string debugInfoText() {return "";}

	/*
		This takes the return value of
		ServerActiveObject::getClientInitializationData
	*/
	virtual void initialize(const std::string &data){}

	// Create a certain type of ClientActiveObject
	static ClientActiveObject* create(ActiveObjectType type, Client *client,
			ClientEnvironment *env);

	// If returns true, punch will not be sent to the server
	virtual bool directReportPunch(v3f dir, const ItemStack *punchitem=NULL,
			float time_from_last_punch=1000000)
	{ return false; }

protected:
	// Used for creating objects based on type
	typedef ClientActiveObject* (*Factory)(Client *client, ClientEnvironment *env);
	static void registerType(u16 type, Factory f);
	Client *m_client;
	ClientEnvironment *m_env;
private:
	// Used for creating objects based on type
	static std::unordered_map<u16, Factory> m_types;
};

struct DistanceSortedActiveObject
{
	ClientActiveObject *obj;
	f32 d;

	DistanceSortedActiveObject(ClientActiveObject *a_obj, f32 a_d)
	{
		obj = a_obj;
		d = a_d;
	}

	bool operator < (const DistanceSortedActiveObject &other) const
	{
		return d < other.d;
	}
};
