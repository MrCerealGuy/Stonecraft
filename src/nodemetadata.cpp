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

#include "nodemetadata.h"
#include "exceptions.h"
#include "gamedef.h"
#include "inventory.h"
#include "log.h"
#include "util/serialize.h"
#include "util/basic_macros.h"
#include "constants.h" // MAP_BLOCKSIZE
#include <sstream>

/*
	NodeMetadata
*/

NodeMetadata::NodeMetadata(IItemDefManager *item_def_mgr):
	m_inventory(new Inventory(item_def_mgr))
{}

NodeMetadata::~NodeMetadata()
{
	delete m_inventory;
}

void NodeMetadata::serialize(std::ostream &os, u8 version, bool disk) const
{
	int num_vars = disk ? m_stringvars.size() : countNonPrivate();
	writeU32(os, num_vars);
	for (StringMap::const_iterator
			it = m_stringvars.begin();
			it != m_stringvars.end(); ++it) {
		bool priv = isPrivate(it->first);
		if (!disk && priv)
			continue;

		os << serializeString(it->first);
		os << serializeLongString(it->second);
		if (version >= 2)
			writeU8(os, (priv) ? 1 : 0);
	}

	m_inventory->serialize(os);
}

void NodeMetadata::deSerialize(std::istream &is, u8 version)
{
	clear();
	int num_vars = readU32(is);
	for(int i=0; i<num_vars; i++){
		std::string name = deSerializeString(is);
		std::string var = deSerializeLongString(is);
		m_stringvars[name] = var;
		if (version >= 2) {
			if (readU8(is) == 1)
				markPrivate(name, true);
		}
	}

	m_inventory->deSerialize(is);
}

void NodeMetadata::clear()
{
	Metadata::clear();
	m_privatevars.clear();
	m_inventory->clear();
}

bool NodeMetadata::empty() const
{
	return Metadata::empty() && m_inventory->getLists().size() == 0;
}


void NodeMetadata::markPrivate(const std::string &name, bool set)
{
	if (set)
		m_privatevars.insert(name);
	else
		m_privatevars.erase(name);
}

int NodeMetadata::countNonPrivate() const
{
	// m_privatevars can contain names not actually present
	// DON'T: return m_stringvars.size() - m_privatevars.size();
	int n = 0;
	for (StringMap::const_iterator
			it = m_stringvars.begin();
			it != m_stringvars.end(); ++it) {
		if (isPrivate(it->first) == false)
			n++;
	}
	return n;
}

/*
	NodeMetadataList
*/

void NodeMetadataList::serialize(std::ostream &os, u8 blockver, bool disk) const
{
	/*
		Version 0 is a placeholder for "nothing to see here; go away."
	*/

	u16 count = countNonEmpty();
	if (count == 0) {
		writeU8(os, 0); // version
		return;
	}

	u8 version = (blockver > 27) ? 2 : 1;
	writeU8(os, version);
	writeU16(os, count);

	for(std::map<v3s16, NodeMetadata*>::const_iterator
			i = m_data.begin();
			i != m_data.end(); ++i)
	{
		v3s16 p = i->first;
		NodeMetadata *data = i->second;
		if (data->empty())
			continue;

		u16 p16 = p.Z * MAP_BLOCKSIZE * MAP_BLOCKSIZE + p.Y * MAP_BLOCKSIZE + p.X;
		writeU16(os, p16);

		data->serialize(os, version, disk);
	}
}

void NodeMetadataList::deSerialize(std::istream &is, IItemDefManager *item_def_mgr)
{
	clear();

	u8 version = readU8(is);

	if (version == 0) {
		// Nothing
		return;
	}

	if (version > 2) {
		std::string err_str = std::string(FUNCTION_NAME)
			+ ": version " + itos(version) + " not supported";
		infostream << err_str << std::endl;
		throw SerializationError(err_str);
	}

	u16 count = readU16(is);

	for (u16 i = 0; i < count; i++) {
		u16 p16 = readU16(is);

		v3s16 p;
		p.Z = p16 / MAP_BLOCKSIZE / MAP_BLOCKSIZE;
		p16 &= MAP_BLOCKSIZE * MAP_BLOCKSIZE - 1;
		p.Y = p16 / MAP_BLOCKSIZE;
		p16 &= MAP_BLOCKSIZE - 1;
		p.X = p16;

		if (m_data.find(p) != m_data.end()) {
			warningstream << "NodeMetadataList::deSerialize(): "
					<< "already set data at position " << PP(p)
					<< ": Ignoring." << std::endl;
			continue;
		}

		NodeMetadata *data = new NodeMetadata(item_def_mgr);
		data->deSerialize(is, version);
		m_data[p] = data;
	}
}

NodeMetadataList::~NodeMetadataList()
{
	clear();
}

std::vector<v3s16> NodeMetadataList::getAllKeys()
{
	std::vector<v3s16> keys;

	std::map<v3s16, NodeMetadata *>::const_iterator it;
	for (it = m_data.begin(); it != m_data.end(); ++it)
		keys.push_back(it->first);

	return keys;
}

NodeMetadata *NodeMetadataList::get(v3s16 p)
{
	std::map<v3s16, NodeMetadata *>::const_iterator n = m_data.find(p);
	if (n == m_data.end())
		return NULL;
	return n->second;
}

void NodeMetadataList::remove(v3s16 p)
{
	NodeMetadata *olddata = get(p);
	if (olddata) {
		delete olddata;
		m_data.erase(p);
	}
}

void NodeMetadataList::set(v3s16 p, NodeMetadata *d)
{
	remove(p);
	m_data.insert(std::make_pair(p, d));
}

void NodeMetadataList::clear()
{
	std::map<v3s16, NodeMetadata*>::iterator it;
	for (it = m_data.begin(); it != m_data.end(); ++it) {
		delete it->second;
	}
	m_data.clear();
}

int NodeMetadataList::countNonEmpty() const
{
	int n = 0;
	std::map<v3s16, NodeMetadata*>::const_iterator it;
	for (it = m_data.begin(); it != m_data.end(); ++it) {
		if (!it->second->empty())
			n++;
	}
	return n;
}
