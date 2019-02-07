/*
Minetest
Copyright (C) 2010-2013 celeron55, Perttu Ahola <celeron55@gmail.com>
Copyright (C) 2017 numzero, Lobachevskiy Vitaliy <numzer0@yandex.ru>

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
#include "stereo.h"

// The support is absent in 1.9.0 (dropped in r5068)
#if (IRRLICHT_VERSION_MAJOR == 1) && (IRRLICHT_VERSION_MINOR <= 8)
#define STEREO_PAGEFLIP_SUPPORTED

class RenderingCorePageflip : public RenderingCoreStereo
{
protected:
	video::ITexture *hud = nullptr;

	void initTextures() override;
	void clearTextures() override;
	void useEye(bool right) override;
	void resetEye() override;

public:
	using RenderingCoreStereo::RenderingCoreStereo;
	void drawAll() override;
};

#endif
