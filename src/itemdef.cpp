/*
Minetest
Copyright (C) 2010-2013 celeron55, Perttu Ahola <celeron55@gmail.com>
Copyright (C) 2013 Kahrl <kahrl@gmx.net>

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

#include "itemdef.h"

#include "nodedef.h"
#include "tool.h"
#include "inventory.h"
#ifndef SERVER
#include "mapblock_mesh.h"
#include "mesh.h"
#include "wieldmesh.h"
#include "client/tile.h"
#include "client.h"
#endif
#include "log.h"
#include "settings.h"
#include "util/serialize.h"
#include "util/container.h"
#include "util/thread.h"
#include <map>
#include <set>

#ifdef __ANDROID__
#include <GLES/gl.h>
#endif

/*
	ItemDefinition
*/
ItemDefinition::ItemDefinition()
{
	resetInitial();
}

ItemDefinition::ItemDefinition(const ItemDefinition &def)
{
	resetInitial();
	*this = def;
}

ItemDefinition& ItemDefinition::operator=(const ItemDefinition &def)
{
	if(this == &def)
		return *this;

	reset();

	type = def.type;
	name = def.name;
	description = def.description;
	inventory_image = def.inventory_image;
	wield_image = def.wield_image;
	wield_scale = def.wield_scale;
	stack_max = def.stack_max;
	usable = def.usable;
	liquids_pointable = def.liquids_pointable;
	if(def.tool_capabilities)
	{
		tool_capabilities = new ToolCapabilities(
				*def.tool_capabilities);
	}
	groups = def.groups;
	node_placement_prediction = def.node_placement_prediction;
	sound_place = def.sound_place;
	sound_place_failed = def.sound_place_failed;
	range = def.range;
	palette_image = def.palette_image;
	color = def.color;
	return *this;
}

ItemDefinition::~ItemDefinition()
{
	reset();
}

void ItemDefinition::resetInitial()
{
	// Initialize pointers to NULL so reset() does not delete undefined pointers
	tool_capabilities = NULL;
	reset();
}

void ItemDefinition::reset()
{
	type = ITEM_NONE;
	name = "";
	description = "";
	inventory_image = "";
	wield_image = "";
	palette_image = "";
	color = video::SColor(0xFFFFFFFF);
	wield_scale = v3f(1.0, 1.0, 1.0);
	stack_max = 99;
	usable = false;
	liquids_pointable = false;
	if(tool_capabilities)
	{
		delete tool_capabilities;
		tool_capabilities = NULL;
	}
	groups.clear();
	sound_place = SimpleSoundSpec();
	sound_place_failed = SimpleSoundSpec();
	range = -1;

	node_placement_prediction = "";
}

void ItemDefinition::serialize(std::ostream &os, u16 protocol_version) const
{

	writeU8(os, 3); // version (proto > 20)
	writeU8(os, type);
	os << serializeString(name);
	os << serializeString(description);
	os << serializeString(inventory_image);
	os << serializeString(wield_image);
	writeV3F1000(os, wield_scale);
	writeS16(os, stack_max);
	writeU8(os, usable);
	writeU8(os, liquids_pointable);
	std::string tool_capabilities_s = "";
	if(tool_capabilities){
		std::ostringstream tmp_os(std::ios::binary);
		tool_capabilities->serialize(tmp_os, protocol_version);
		tool_capabilities_s = tmp_os.str();
	}
	os << serializeString(tool_capabilities_s);
	writeU16(os, groups.size());
	for (ItemGroupList::const_iterator
			i = groups.begin(); i != groups.end(); ++i){
		os << serializeString(i->first);
		writeS16(os, i->second);
	}
	os << serializeString(node_placement_prediction);
	os << serializeString(sound_place.name);
	writeF1000(os, sound_place.gain);
	writeF1000(os, range);
	os << serializeString(sound_place_failed.name);
	writeF1000(os, sound_place_failed.gain);
	os << serializeString(palette_image);
	writeU32(os, color.color);
}

void ItemDefinition::deSerialize(std::istream &is)
{
	// Reset everything
	reset();

	// Deserialize
	int version = readU8(is);
	if(version < 1 || version > 3)
		throw SerializationError("unsupported ItemDefinition version");
	type = (enum ItemType)readU8(is);
	name = deSerializeString(is);
	description = deSerializeString(is);
	inventory_image = deSerializeString(is);
	wield_image = deSerializeString(is);
	wield_scale = readV3F1000(is);
	stack_max = readS16(is);
	usable = readU8(is);
	liquids_pointable = readU8(is);
	std::string tool_capabilities_s = deSerializeString(is);
	if(!tool_capabilities_s.empty())
	{
		std::istringstream tmp_is(tool_capabilities_s, std::ios::binary);
		tool_capabilities = new ToolCapabilities;
		tool_capabilities->deSerialize(tmp_is);
	}
	groups.clear();
	u32 groups_size = readU16(is);
	for(u32 i=0; i<groups_size; i++){
		std::string name = deSerializeString(is);
		int value = readS16(is);
		groups[name] = value;
	}
	if(version == 1){
		// We cant be sure that node_placement_prediction is send in version 1
		try{
			node_placement_prediction = deSerializeString(is);
		}catch(SerializationError &e) {};
		// Set the old default sound
		sound_place.name = "default_place_node";
		sound_place.gain = 0.5;
	} else if(version >= 2) {
		node_placement_prediction = deSerializeString(is);
		//deserializeSimpleSoundSpec(sound_place, is);
		sound_place.name = deSerializeString(is);
		sound_place.gain = readF1000(is);
	}
	if(version == 3) {
		range = readF1000(is);
	}
	// If you add anything here, insert it primarily inside the try-catch
	// block to not need to increase the version.
	try {
		sound_place_failed.name = deSerializeString(is);
		sound_place_failed.gain = readF1000(is);
		palette_image = deSerializeString(is);
		color.set(readU32(is));
	} catch(SerializationError &e) {};
}

/*
	CItemDefManager
*/

// SUGG: Support chains of aliases?

class CItemDefManager: public IWritableItemDefManager
{
#ifndef SERVER
	struct ClientCached
	{
		video::ITexture *inventory_texture;
		ItemMesh wield_mesh;
		Palette *palette;

		ClientCached():
			inventory_texture(NULL),
			wield_mesh(),
			palette(NULL)
		{}
	};
#endif

public:
	CItemDefManager()
	{

#ifndef SERVER
		m_main_thread = thr_get_current_thread_id();
#endif
		clear();
	}
	virtual ~CItemDefManager()
	{
#ifndef SERVER
		const std::vector<ClientCached*> &values = m_clientcached.getValues();
		for(std::vector<ClientCached*>::const_iterator
				i = values.begin(); i != values.end(); ++i)
		{
			ClientCached *cc = *i;
			if (cc->wield_mesh.mesh)
				cc->wield_mesh.mesh->drop();
			delete cc;
		}

#endif
		for (std::map<std::string, ItemDefinition*>::iterator iter =
				m_item_definitions.begin(); iter != m_item_definitions.end();
				++iter) {
			delete iter->second;
		}
		m_item_definitions.clear();
	}
	virtual const ItemDefinition& get(const std::string &name_) const
	{
		// Convert name according to possible alias
		std::string name = getAlias(name_);
		// Get the definition
		std::map<std::string, ItemDefinition*>::const_iterator i;
		i = m_item_definitions.find(name);
		if(i == m_item_definitions.end())
			i = m_item_definitions.find("unknown");
		assert(i != m_item_definitions.end());
		return *(i->second);
	}
	virtual const std::string &getAlias(const std::string &name) const
	{
		StringMap::const_iterator it = m_aliases.find(name);
		if (it != m_aliases.end())
			return it->second;
		return name;
	}
	virtual void getAll(std::set<std::string> &result) const
	{
		result.clear();
		for(std::map<std::string, ItemDefinition *>::const_iterator
				it = m_item_definitions.begin();
				it != m_item_definitions.end(); ++it) {
			result.insert(it->first);
		}
		for (StringMap::const_iterator
				it = m_aliases.begin();
				it != m_aliases.end(); ++it) {
			result.insert(it->first);
		}
	}
	virtual bool isKnown(const std::string &name_) const
	{
		// Convert name according to possible alias
		std::string name = getAlias(name_);
		// Get the definition
		std::map<std::string, ItemDefinition*>::const_iterator i;
		return m_item_definitions.find(name) != m_item_definitions.end();
	}
#ifndef SERVER
public:
	ClientCached* createClientCachedDirect(const std::string &name,
			Client *client) const
	{
		infostream<<"Lazily creating item texture and mesh for \""
				<<name<<"\""<<std::endl;

		// This is not thread-safe
		sanity_check(thr_is_current_thread(m_main_thread));

		// Skip if already in cache
		ClientCached *cc = NULL;
		m_clientcached.get(name, &cc);
		if(cc)
			return cc;

		ITextureSource *tsrc = client->getTextureSource();
		const ItemDefinition &def = get(name);

		// Create new ClientCached
		cc = new ClientCached();

		// Create an inventory texture
		cc->inventory_texture = NULL;
		if(def.inventory_image != "")
			cc->inventory_texture = tsrc->getTexture(def.inventory_image);

		ItemStack item = ItemStack();
		item.name = def.name;

		getItemMesh(client, item, &(cc->wield_mesh));

		cc->palette = tsrc->getPalette(def.palette_image);

		// Put in cache
		m_clientcached.set(name, cc);

		return cc;
	}
	ClientCached* getClientCached(const std::string &name,
			Client *client) const
	{
		ClientCached *cc = NULL;
		m_clientcached.get(name, &cc);
		if(cc)
			return cc;

		if(thr_is_current_thread(m_main_thread))
		{
			return createClientCachedDirect(name, client);
		}
		else
		{
			// We're gonna ask the result to be put into here
			static ResultQueue<std::string, ClientCached*, u8, u8> result_queue;

			// Throw a request in
			m_get_clientcached_queue.add(name, 0, 0, &result_queue);
			try{
				while(true) {
					// Wait result for a second
					GetResult<std::string, ClientCached*, u8, u8>
						result = result_queue.pop_front(1000);

					if (result.key == name) {
						return result.item;
					}
				}
			}
			catch(ItemNotFoundException &e)
			{
				errorstream<<"Waiting for clientcached " << name << " timed out."<<std::endl;
				return &m_dummy_clientcached;
			}
		}
	}
	// Get item inventory texture
	virtual video::ITexture* getInventoryTexture(const std::string &name,
			Client *client) const
	{
		ClientCached *cc = getClientCached(name, client);
		if(!cc)
			return NULL;
		return cc->inventory_texture;
	}
	// Get item wield mesh
	virtual ItemMesh* getWieldMesh(const std::string &name,
			Client *client) const
	{
		ClientCached *cc = getClientCached(name, client);
		if(!cc)
			return NULL;
		return &(cc->wield_mesh);
	}

	// Get item palette
	virtual Palette* getPalette(const std::string &name,
			Client *client) const
	{
		ClientCached *cc = getClientCached(name, client);
		if(!cc)
			return NULL;
		return cc->palette;
	}

	virtual video::SColor getItemstackColor(const ItemStack &stack,
		Client *client) const
	{
		// Look for direct color definition
		const std::string &colorstring = stack.metadata.getString("color", 0);
		video::SColor directcolor;
		if ((colorstring != "")
				&& parseColorString(colorstring, directcolor, true))
			return directcolor;
		// See if there is a palette
		Palette *palette = getPalette(stack.name, client);
		const std::string &index = stack.metadata.getString("palette_index", 0);
		if ((palette != NULL) && (index != ""))
			return (*palette)[mystoi(index, 0, 255)];
		// Fallback color
		return get(stack.name).color;
	}
#endif
	void clear()
	{
		for(std::map<std::string, ItemDefinition*>::const_iterator
				i = m_item_definitions.begin();
				i != m_item_definitions.end(); ++i)
		{
			delete i->second;
		}
		m_item_definitions.clear();
		m_aliases.clear();

		// Add the four builtin items:
		//   "" is the hand
		//   "unknown" is returned whenever an undefined item
		//     is accessed (is also the unknown node)
		//   "air" is the air node
		//   "ignore" is the ignore node

		ItemDefinition* hand_def = new ItemDefinition;
		hand_def->name = "";
		hand_def->wield_image = "wieldhand.png";
		hand_def->tool_capabilities = new ToolCapabilities;
		m_item_definitions.insert(std::make_pair("", hand_def));

		ItemDefinition* unknown_def = new ItemDefinition;
		unknown_def->type = ITEM_NODE;
		unknown_def->name = "unknown";
		m_item_definitions.insert(std::make_pair("unknown", unknown_def));

		ItemDefinition* air_def = new ItemDefinition;
		air_def->type = ITEM_NODE;
		air_def->name = "air";
		m_item_definitions.insert(std::make_pair("air", air_def));

		ItemDefinition* ignore_def = new ItemDefinition;
		ignore_def->type = ITEM_NODE;
		ignore_def->name = "ignore";
		m_item_definitions.insert(std::make_pair("ignore", ignore_def));
	}
	virtual void registerItem(const ItemDefinition &def)
	{
		verbosestream<<"ItemDefManager: registering \""<<def.name<<"\""<<std::endl;
		// Ensure that the "" item (the hand) always has ToolCapabilities
		if(def.name == "")
			FATAL_ERROR_IF(!def.tool_capabilities, "Hand does not have ToolCapabilities");

		if(m_item_definitions.count(def.name) == 0)
			m_item_definitions[def.name] = new ItemDefinition(def);
		else
			*(m_item_definitions[def.name]) = def;

		// Remove conflicting alias if it exists
		bool alias_removed = (m_aliases.erase(def.name) != 0);
		if(alias_removed)
			infostream<<"ItemDefManager: erased alias "<<def.name
					<<" because item was defined"<<std::endl;
	}
	virtual void unregisterItem(const std::string &name)
	{
		verbosestream<<"ItemDefManager: unregistering \""<<name<<"\""<<std::endl;

		delete m_item_definitions[name];
		m_item_definitions.erase(name);
	}
	virtual void registerAlias(const std::string &name,
			const std::string &convert_to)
	{
		if (m_item_definitions.find(name) == m_item_definitions.end()) {
			verbosestream<<"ItemDefManager: setting alias "<<name
				<<" -> "<<convert_to<<std::endl;
			m_aliases[name] = convert_to;
		}
	}
	void serialize(std::ostream &os, u16 protocol_version)
	{
		writeU8(os, 0); // version
		u16 count = m_item_definitions.size();
		writeU16(os, count);

		for (std::map<std::string, ItemDefinition *>::const_iterator
				it = m_item_definitions.begin();
				it != m_item_definitions.end(); ++it) {
			ItemDefinition *def = it->second;
			// Serialize ItemDefinition and write wrapped in a string
			std::ostringstream tmp_os(std::ios::binary);
			def->serialize(tmp_os, protocol_version);
			os << serializeString(tmp_os.str());
		}

		writeU16(os, m_aliases.size());

		for (StringMap::const_iterator
				it = m_aliases.begin();
				it != m_aliases.end(); ++it) {
			os << serializeString(it->first);
			os << serializeString(it->second);
		}
	}
	void deSerialize(std::istream &is)
	{
		// Clear everything
		clear();
		// Deserialize
		int version = readU8(is);
		if(version != 0)
			throw SerializationError("unsupported ItemDefManager version");
		u16 count = readU16(is);
		for(u16 i=0; i<count; i++)
		{
			// Deserialize a string and grab an ItemDefinition from it
			std::istringstream tmp_is(deSerializeString(is), std::ios::binary);
			ItemDefinition def;
			def.deSerialize(tmp_is);
			// Register
			registerItem(def);
		}
		u16 num_aliases = readU16(is);
		for(u16 i=0; i<num_aliases; i++)
		{
			std::string name = deSerializeString(is);
			std::string convert_to = deSerializeString(is);
			registerAlias(name, convert_to);
		}
	}
	void processQueue(IGameDef *gamedef)
	{
#ifndef SERVER
		//NOTE this is only thread safe for ONE consumer thread!
		while(!m_get_clientcached_queue.empty())
		{
			GetRequest<std::string, ClientCached*, u8, u8>
					request = m_get_clientcached_queue.pop();

			m_get_clientcached_queue.pushResult(request,
					createClientCachedDirect(request.key, (Client *)gamedef));
		}
#endif
	}
private:
	// Key is name
	std::map<std::string, ItemDefinition*> m_item_definitions;
	// Aliases
	StringMap m_aliases;
#ifndef SERVER
	// The id of the thread that is allowed to use irrlicht directly
	threadid_t m_main_thread;
	// A reference to this can be returned when nothing is found, to avoid NULLs
	mutable ClientCached m_dummy_clientcached;
	// Cached textures and meshes
	mutable MutexedMap<std::string, ClientCached*> m_clientcached;
	// Queued clientcached fetches (to be processed by the main thread)
	mutable RequestQueue<std::string, ClientCached*, u8, u8> m_get_clientcached_queue;
#endif
};

IWritableItemDefManager* createItemDefManager()
{
	return new CItemDefManager();
}
