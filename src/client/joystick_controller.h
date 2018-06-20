/*
Minetest
Copyright (C) 2016 est31, <MTest31@outlook.com>

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
#include "keys.h"
#include <bitset>
#include <vector>

enum JoystickAxis {
	JA_SIDEWARD_MOVE,
	JA_FORWARD_MOVE,

	JA_FRUSTUM_HORIZONTAL,
	JA_FRUSTUM_VERTICAL,

	// To know the count of enum values
	JA_COUNT,
};

struct JoystickAxisLayout {
	u16 axis_id;
	// -1 if to invert, 1 if to keep it.
	int invert;
};


struct JoystickCombination {

	virtual bool isTriggered(const irr::SEvent::SJoystickEvent &ev) const=0;

	GameKeyType key;
};

struct JoystickButtonCmb : public JoystickCombination {

	JoystickButtonCmb() = default;

	JoystickButtonCmb(GameKeyType key, u32 filter_mask, u32 compare_mask) :
		filter_mask(filter_mask),
		compare_mask(compare_mask)
	{
		this->key = key;
	}

	virtual ~JoystickButtonCmb() = default;

	virtual bool isTriggered(const irr::SEvent::SJoystickEvent &ev) const;

	u32 filter_mask;
	u32 compare_mask;
};

struct JoystickAxisCmb : public JoystickCombination {

	JoystickAxisCmb() = default;

	JoystickAxisCmb(GameKeyType key, u16 axis_to_compare, int direction, s16 thresh) :
		axis_to_compare(axis_to_compare),
		direction(direction),
		thresh(thresh)
	{
		this->key = key;
	}

	virtual ~JoystickAxisCmb() = default;

	bool isTriggered(const irr::SEvent::SJoystickEvent &ev) const override;

	u16 axis_to_compare;

	// if -1, thresh must be smaller than the axis value in order to trigger
	// if  1, thresh must be bigger  than the axis value in order to trigger
	int direction;
	s16 thresh;
};

struct JoystickLayout {
	std::vector<JoystickButtonCmb> button_keys;
	std::vector<JoystickAxisCmb> axis_keys;
	JoystickAxisLayout axes[JA_COUNT];
	s16 axes_dead_border;
};

class JoystickController {

public:
	JoystickController();

	void onJoystickConnect(const std::vector<irr::SJoystickInfo> &joystick_infos);

	bool handleEvent(const irr::SEvent::SJoystickEvent &ev);
	void clear();

	bool wasKeyDown(GameKeyType b)
	{
		bool r = m_past_pressed_keys[b];
		m_past_pressed_keys[b] = false;
		return r;
	}
	bool getWasKeyDown(GameKeyType b)
	{
		return m_past_pressed_keys[b];
	}
	void clearWasKeyDown(GameKeyType b)
	{
		m_past_pressed_keys[b] = false;
	}

	bool wasKeyReleased(GameKeyType b)
	{
		bool r = m_past_released_keys[b];
		m_past_released_keys[b] = false;
		return r;
	}
	bool getWasKeyReleased(GameKeyType b)
	{
		return m_past_pressed_keys[b];
	}
	void clearWasKeyReleased(GameKeyType b)
	{
		m_past_pressed_keys[b] = false;
	}

	bool isKeyDown(GameKeyType b)
	{
		return m_pressed_keys[b];
	}

	s16 getAxis(JoystickAxis axis)
	{
		return m_axes_vals[axis];
	}

	s16 getAxisWithoutDead(JoystickAxis axis);

	f32 doubling_dtime;

private:
	void setLayoutFromControllerName(const std::string &name);

	JoystickLayout m_layout;

	s16 m_axes_vals[JA_COUNT];

	u8 m_joystick_id = 0;

	std::bitset<KeyType::INTERNAL_ENUM_COUNT> m_pressed_keys;

	f32 m_internal_time;

	f32 m_past_pressed_time[KeyType::INTERNAL_ENUM_COUNT];

	std::bitset<KeyType::INTERNAL_ENUM_COUNT> m_past_pressed_keys;
	std::bitset<KeyType::INTERNAL_ENUM_COUNT> m_past_released_keys;
};
