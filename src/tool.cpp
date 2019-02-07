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

#include "tool.h"
#include "itemgroup.h"
#include "log.h"
#include "inventory.h"
#include "exceptions.h"
#include "util/serialize.h"
#include "util/numeric.h"

void ToolGroupCap::toJson(Json::Value &object) const
{
	object["maxlevel"] = maxlevel;
	object["uses"] = uses;

	Json::Value times_object;
	for (auto time : times)
		times_object[time.first] = time.second;
	object["times"] = times_object;
}

void ToolGroupCap::fromJson(const Json::Value &json)
{
	if (json.isObject()) {
		if (json["maxlevel"].isInt())
			maxlevel = json["maxlevel"].asInt();
		if (json["uses"].isInt())
			uses = json["uses"].asInt();
		const Json::Value &times_object = json["times"];
		if (times_object.isArray()) {
			Json::ArrayIndex size = times_object.size();
			for (Json::ArrayIndex i = 0; i < size; ++i)
				if (times_object[i].isDouble())
					times[i] = times_object[i].asFloat();
		}
	}
}

void ToolCapabilities::serialize(std::ostream &os, u16 protocol_version) const
{
	writeU8(os, 4); // protocol_version >= 37
	writeF32(os, full_punch_interval);
	writeS16(os, max_drop_level);
	writeU32(os, groupcaps.size());
	for (const auto &groupcap : groupcaps) {
		const std::string *name = &groupcap.first;
		const ToolGroupCap *cap = &groupcap.second;
		os << serializeString(*name);
		writeS16(os, cap->uses);
		writeS16(os, cap->maxlevel);
		writeU32(os, cap->times.size());
		for (const auto &time : cap->times) {
			writeS16(os, time.first);
			writeF32(os, time.second);
		}
	}

	writeU32(os, damageGroups.size());

	for (const auto &damageGroup : damageGroups) {
		os << serializeString(damageGroup.first);
		writeS16(os, damageGroup.second);
	}
}

void ToolCapabilities::deSerialize(std::istream &is)
{
	int version = readU8(is);
	if (version < 4)
		throw SerializationError("unsupported ToolCapabilities version");

	full_punch_interval = readF32(is);
	max_drop_level = readS16(is);
	groupcaps.clear();
	u32 groupcaps_size = readU32(is);
	for (u32 i = 0; i < groupcaps_size; i++) {
		std::string name = deSerializeString(is);
		ToolGroupCap cap;
		cap.uses = readS16(is);
		cap.maxlevel = readS16(is);
		u32 times_size = readU32(is);
		for(u32 i = 0; i < times_size; i++) {
			int level = readS16(is);
			float time = readF32(is);
			cap.times[level] = time;
		}
		groupcaps[name] = cap;
	}

	u32 damage_groups_size = readU32(is);
	for (u32 i = 0; i < damage_groups_size; i++) {
		std::string name = deSerializeString(is);
		s16 rating = readS16(is);
		damageGroups[name] = rating;
	}
}

void ToolCapabilities::serializeJson(std::ostream &os) const
{
	Json::Value root;
	root["full_punch_interval"] = full_punch_interval;
	root["max_drop_level"] = max_drop_level;

	Json::Value groupcaps_object;
	for (auto groupcap : groupcaps) {
		groupcap.second.toJson(groupcaps_object[groupcap.first]);
	}
	root["groupcaps"] = groupcaps_object;

	Json::Value damage_groups_object;
	DamageGroup::const_iterator dgiter;
	for (dgiter = damageGroups.begin(); dgiter != damageGroups.end(); ++dgiter) {
		damage_groups_object[dgiter->first] = dgiter->second;
	}
	root["damage_groups"] = damage_groups_object;

	os << root;
}

void ToolCapabilities::deserializeJson(std::istream &is)
{
	Json::Value root;
	is >> root;
	if (root.isObject()) {
		if (root["full_punch_interval"].isDouble())
			full_punch_interval = root["full_punch_interval"].asFloat();
		if (root["max_drop_level"].isInt())
			max_drop_level = root["max_drop_level"].asInt();

		Json::Value &groupcaps_object = root["groupcaps"];
		if (groupcaps_object.isObject()) {
			Json::ValueIterator gciter;
			for (gciter = groupcaps_object.begin();
					gciter != groupcaps_object.end(); ++gciter) {
				ToolGroupCap groupcap;
				groupcap.fromJson(*gciter);
				groupcaps[gciter.key().asString()] = groupcap;
			}
		}

		Json::Value &damage_groups_object = root["damage_groups"];
		if (damage_groups_object.isObject()) {
			Json::ValueIterator dgiter;
			for (dgiter = damage_groups_object.begin();
					dgiter != damage_groups_object.end(); ++dgiter) {
				Json::Value &value = *dgiter;
				if (value.isInt())
					damageGroups[dgiter.key().asString()] =
						value.asInt();
			}
		}
	}
}

DigParams getDigParams(const ItemGroupList &groups,
		const ToolCapabilities *tp)
{
	// Group dig_immediate has fixed time and no wear
	switch (itemgroup_get(groups, "dig_immediate")) {
	case 2:
		return DigParams(true, 0.5, 0, "dig_immediate");
	case 3:
		return DigParams(true, 0, 0, "dig_immediate");
	default:
		break;
	}

	// Values to be returned (with a bit of conversion)
	bool result_diggable = false;
	float result_time = 0.0;
	float result_wear = 0.0;
	std::string result_main_group;

	int level = itemgroup_get(groups, "level");
	for (const auto &groupcap : tp->groupcaps) {
		const ToolGroupCap &cap = groupcap.second;

		int leveldiff = cap.maxlevel - level;
		if (leveldiff < 0)
			continue;

		const std::string &groupname = groupcap.first;
		float time = 0;
		int rating = itemgroup_get(groups, groupname);
		bool time_exists = cap.getTime(rating, &time);
		if (!time_exists)
			continue;

		if (leveldiff > 1)
			time /= leveldiff;
		if (!result_diggable || time < result_time) {
			result_time = time;
			result_diggable = true;
			if (cap.uses != 0)
				result_wear = 1.0 / cap.uses / pow(3.0, leveldiff);
			else
				result_wear = 0;
			result_main_group = groupname;
		}
	}

	u16 wear_i = U16_MAX * result_wear;
	return DigParams(result_diggable, result_time, wear_i, result_main_group);
}

HitParams getHitParams(const ItemGroupList &armor_groups,
		const ToolCapabilities *tp, float time_from_last_punch)
{
	s16 damage = 0;
	float full_punch_interval = tp->full_punch_interval;

	for (const auto &damageGroup : tp->damageGroups) {
		s16 armor = itemgroup_get(armor_groups, damageGroup.first);
		damage += damageGroup.second
				* rangelim(time_from_last_punch / full_punch_interval, 0.0, 1.0)
				* armor / 100.0;
	}

	return {damage, 0};
}

HitParams getHitParams(const ItemGroupList &armor_groups,
		const ToolCapabilities *tp)
{
	return getHitParams(armor_groups, tp, 1000000);
}

PunchDamageResult getPunchDamage(
		const ItemGroupList &armor_groups,
		const ToolCapabilities *toolcap,
		const ItemStack *punchitem,
		float time_from_last_punch
){
	bool do_hit = true;
	{
		if (do_hit && punchitem) {
			if (itemgroup_get(armor_groups, "punch_operable") &&
					(toolcap == NULL || punchitem->name.empty()))
				do_hit = false;
		}

		if (do_hit) {
			if(itemgroup_get(armor_groups, "immortal"))
				do_hit = false;
		}
	}

	PunchDamageResult result;
	if(do_hit)
	{
		HitParams hitparams = getHitParams(armor_groups, toolcap,
				time_from_last_punch);
		result.did_punch = true;
		result.wear = hitparams.wear;
		result.damage = hitparams.hp;
	}

	return result;
}


