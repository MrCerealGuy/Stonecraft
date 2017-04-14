/*
Minetest
Copyright (C) 2016 nerzhul, Loic Blot <loic.blot@unix-experience.fr>

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

#ifndef MT_CPP11_HEADER
#define MT_CPP11_HEADER

#if __cplusplus < 201103L || _MSC_VER < 1600
#define USE_CPP11_FAKE_KEYWORD
#endif

#ifdef USE_CPP11_FAKE_KEYWORD
#define constexpr const
#define nullptr NULL
#endif

#endif
