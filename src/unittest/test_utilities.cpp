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

#include "test.h"

#include <cmath>
#include "util/enriched_string.h"
#include "util/numeric.h"
#include "util/string.h"

class TestUtilities : public TestBase {
public:
	TestUtilities() { TestManager::registerTestModule(this); }
	const char *getName() { return "TestUtilities"; }

	void runTests(IGameDef *gamedef);

	void testAngleWrapAround();
	void testWrapDegrees_0_360_v3f();
	void testLowercase();
	void testTrim();
	void testIsYes();
	void testRemoveStringEnd();
	void testUrlEncode();
	void testUrlDecode();
	void testPadString();
	void testStartsWith();
	void testStrEqual();
	void testStringTrim();
	void testStrToIntConversion();
	void testStringReplace();
	void testStringAllowed();
	void testAsciiPrintableHelper();
	void testUTF8();
	void testRemoveEscapes();
	void testWrapRows();
	void testEnrichedString();
	void testIsNumber();
	void testIsPowerOfTwo();
	void testMyround();
	void testStringJoin();
	void testEulerConversion();
};

static TestUtilities g_test_instance;

void TestUtilities::runTests(IGameDef *gamedef)
{
	TEST(testAngleWrapAround);
	TEST(testWrapDegrees_0_360_v3f);
	TEST(testLowercase);
	TEST(testTrim);
	TEST(testIsYes);
	TEST(testRemoveStringEnd);
	TEST(testUrlEncode);
	TEST(testUrlDecode);
	TEST(testPadString);
	TEST(testStartsWith);
	TEST(testStrEqual);
	TEST(testStringTrim);
	TEST(testStrToIntConversion);
	TEST(testStringReplace);
	TEST(testStringAllowed);
	TEST(testAsciiPrintableHelper);
	TEST(testUTF8);
	TEST(testRemoveEscapes);
	TEST(testWrapRows);
	TEST(testEnrichedString);
	TEST(testIsNumber);
	TEST(testIsPowerOfTwo);
	TEST(testMyround);
	TEST(testStringJoin);
	TEST(testEulerConversion);
}

////////////////////////////////////////////////////////////////////////////////

inline float ref_WrapDegrees180(float f)
{
	// This is a slower alternative to the wrapDegrees_180() function;
	// used as a reference for testing
	float value = fmodf(f + 180, 360);
	if (value < 0)
		value += 360;
	return value - 180;
}


inline float ref_WrapDegrees_0_360(float f)
{
	// This is a slower alternative to the wrapDegrees_0_360() function;
	// used as a reference for testing
	float value = fmodf(f, 360);
	if (value < 0)
		value += 360;
	return value < 0 ? value + 360 : value;
}


void TestUtilities::testAngleWrapAround() {
    UASSERT(fabs(modulo360f(100.0) - 100.0) < 0.001);
    UASSERT(fabs(modulo360f(720.5) - 0.5) < 0.001);
    UASSERT(fabs(modulo360f(-0.5) - (-0.5)) < 0.001);
    UASSERT(fabs(modulo360f(-365.5) - (-5.5)) < 0.001);

    for (float f = -720; f <= -360; f += 0.25) {
        UASSERT(std::fabs(modulo360f(f) - modulo360f(f + 360)) < 0.001);
    }

    for (float f = -1440; f <= 1440; f += 0.25) {
        UASSERT(std::fabs(modulo360f(f) - fmodf(f, 360)) < 0.001);
        UASSERT(std::fabs(wrapDegrees_180(f) - ref_WrapDegrees180(f)) < 0.001);
        UASSERT(std::fabs(wrapDegrees_0_360(f) - ref_WrapDegrees_0_360(f)) < 0.001);
        UASSERT(wrapDegrees_0_360(
                std::fabs(wrapDegrees_180(f) - wrapDegrees_0_360(f))) < 0.001);
    }

}

void TestUtilities::testWrapDegrees_0_360_v3f()
{
    // only x test with little step
	for (float x = -720.f; x <= 720; x += 0.05) {
        v3f r = wrapDegrees_0_360_v3f(v3f(x, 0, 0));
        UASSERT(r.X >= 0.0f && r.X < 360.0f)
        UASSERT(r.Y == 0.0f)
        UASSERT(r.Z == 0.0f)
    }

    // only y test with little step
    for (float y = -720.f; y <= 720; y += 0.05) {
        v3f r = wrapDegrees_0_360_v3f(v3f(0, y, 0));
        UASSERT(r.X == 0.0f)
        UASSERT(r.Y >= 0.0f && r.Y < 360.0f)
        UASSERT(r.Z == 0.0f)
    }

    // only z test with little step
    for (float z = -720.f; z <= 720; z += 0.05) {
        v3f r = wrapDegrees_0_360_v3f(v3f(0, 0, z));
        UASSERT(r.X == 0.0f)
        UASSERT(r.Y == 0.0f)
        UASSERT(r.Z >= 0.0f && r.Z < 360.0f)
	}

    // test the whole coordinate translation
    for (float x = -720.f; x <= 720; x += 2.5) {
        for (float y = -720.f; y <= 720; y += 2.5) {
            for (float z = -720.f; z <= 720; z += 2.5) {
                v3f r = wrapDegrees_0_360_v3f(v3f(x, y, z));
                UASSERT(r.X >= 0.0f && r.X < 360.0f)
                UASSERT(r.Y >= 0.0f && r.Y < 360.0f)
                UASSERT(r.Z >= 0.0f && r.Z < 360.0f)
            }
        }
    }
}


void TestUtilities::testLowercase()
{
	UASSERT(lowercase("Foo bAR") == "foo bar");
	UASSERT(lowercase("eeeeeeaaaaaaaaaaaààààà") == "eeeeeeaaaaaaaaaaaààààà");
	UASSERT(lowercase("MINETEST-powa") == "minetest-powa");
}


void TestUtilities::testTrim()
{
	UASSERT(trim("") == "");
	UASSERT(trim("dirt_with_grass") == "dirt_with_grass");
	UASSERT(trim("\n \t\r  Foo bAR  \r\n\t\t  ") == "Foo bAR");
	UASSERT(trim("\n \t\r    \r\n\t\t  ") == "");
}


void TestUtilities::testIsYes()
{
	UASSERT(is_yes("YeS") == true);
	UASSERT(is_yes("") == false);
	UASSERT(is_yes("FAlse") == false);
	UASSERT(is_yes("-1") == true);
	UASSERT(is_yes("0") == false);
	UASSERT(is_yes("1") == true);
	UASSERT(is_yes("2") == true);
}


void TestUtilities::testRemoveStringEnd()
{
	const char *ends[] = {"abc", "c", "bc", "", NULL};
	UASSERT(removeStringEnd("abc", ends) == "");
	UASSERT(removeStringEnd("bc", ends) == "b");
	UASSERT(removeStringEnd("12c", ends) == "12");
	UASSERT(removeStringEnd("foo", ends) == "");
}


void TestUtilities::testUrlEncode()
{
	UASSERT(urlencode("\"Aardvarks lurk, OK?\"")
			== "%22Aardvarks%20lurk%2C%20OK%3F%22");
}


void TestUtilities::testUrlDecode()
{
	UASSERT(urldecode("%22Aardvarks%20lurk%2C%20OK%3F%22")
			== "\"Aardvarks lurk, OK?\"");
}


void TestUtilities::testPadString()
{
	UASSERT(padStringRight("hello", 8) == "hello   ");
}

void TestUtilities::testStartsWith()
{
	UASSERT(str_starts_with(std::string(), std::string()) == true);
	UASSERT(str_starts_with(std::string("the sharp pickaxe"),
		std::string()) == true);
	UASSERT(str_starts_with(std::string("the sharp pickaxe"),
		std::string("the")) == true);
	UASSERT(str_starts_with(std::string("the sharp pickaxe"),
		std::string("The")) == false);
	UASSERT(str_starts_with(std::string("the sharp pickaxe"),
		std::string("The"), true) == true);
	UASSERT(str_starts_with(std::string("T"), std::string("The")) == false);
}

void TestUtilities::testStrEqual()
{
	UASSERT(str_equal(narrow_to_wide("abc"), narrow_to_wide("abc")));
	UASSERT(str_equal(narrow_to_wide("ABC"), narrow_to_wide("abc"), true));
}


void TestUtilities::testStringTrim()
{
	UASSERT(trim("  a") == "a");
	UASSERT(trim("   a  ") == "a");
	UASSERT(trim("a   ") == "a");
	UASSERT(trim("") == "");
}


void TestUtilities::testStrToIntConversion()
{
	UASSERT(mystoi("123", 0, 1000) == 123);
	UASSERT(mystoi("123", 0, 10) == 10);
}


void TestUtilities::testStringReplace()
{
	std::string test_str;
	test_str = "Hello there";
	str_replace(test_str, "there", "world");
	UASSERT(test_str == "Hello world");
	test_str = "ThisAisAaAtest";
	str_replace(test_str, 'A', ' ');
	UASSERT(test_str == "This is a test");
}


void TestUtilities::testStringAllowed()
{
	UASSERT(string_allowed("hello", "abcdefghijklmno") == true);
	UASSERT(string_allowed("123", "abcdefghijklmno") == false);
	UASSERT(string_allowed_blacklist("hello", "123") == true);
	UASSERT(string_allowed_blacklist("hello123", "123") == false);
}

void TestUtilities::testAsciiPrintableHelper()
{
	UASSERT(IS_ASCII_PRINTABLE_CHAR('e') == true);
	UASSERT(IS_ASCII_PRINTABLE_CHAR('\0') == false);

	// Ensures that there is no cutting off going on...
	// If there were, 331 would be cut to 75 in this example
	// and 73 is a valid ASCII char.
	int ch = 331;
	UASSERT(IS_ASCII_PRINTABLE_CHAR(ch) == false);
}

void TestUtilities::testUTF8()
{
	UASSERT(wide_to_utf8(utf8_to_wide("")) == "");
	UASSERT(wide_to_utf8(utf8_to_wide("the shovel dug a crumbly node!"))
		== "the shovel dug a crumbly node!");
}

void TestUtilities::testRemoveEscapes()
{
	UASSERT(unescape_enriched<wchar_t>(
		L"abc\x1bXdef") == L"abcdef");
	UASSERT(unescape_enriched<wchar_t>(
		L"abc\x1b(escaped)def") == L"abcdef");
	UASSERT(unescape_enriched<wchar_t>(
		L"abc\x1b((escaped with parenthesis\\))def") == L"abcdef");
	UASSERT(unescape_enriched<wchar_t>(
		L"abc\x1b(incomplete") == L"abc");
	UASSERT(unescape_enriched<wchar_t>(
		L"escape at the end\x1b") == L"escape at the end");
	// Nested escapes not supported
	UASSERT(unescape_enriched<wchar_t>(
		L"abc\x1b(outer \x1b(inner escape)escape)def") == L"abcescape)def");
}

void TestUtilities::testWrapRows()
{
	UASSERT(wrap_rows("12345678",4) == "1234\n5678");
	// test that wrap_rows doesn't wrap inside multibyte sequences
	{
		const unsigned char s[] = {
			0x2f, 0x68, 0x6f, 0x6d, 0x65, 0x2f, 0x72, 0x61, 0x70, 0x74, 0x6f,
			0x72, 0x2f, 0xd1, 0x82, 0xd0, 0xb5, 0xd1, 0x81, 0xd1, 0x82, 0x2f,
			0x6d, 0x69, 0x6e, 0x65, 0x74, 0x65, 0x73, 0x74, 0x2f, 0x62, 0x69,
			0x6e, 0x2f, 0x2e, 0x2e, 0};
		std::string str((char *)s);
		UASSERT(utf8_to_wide(wrap_rows(str, 20)) != L"<invalid UTF-8 string>");
	};
	{
		const unsigned char s[] = {
			0x74, 0x65, 0x73, 0x74, 0x20, 0xd1, 0x82, 0xd0, 0xb5, 0xd1, 0x81,
			0xd1, 0x82, 0x20, 0xd1, 0x82, 0xd0, 0xb5, 0xd1, 0x81, 0xd1, 0x82,
			0x20, 0xd1, 0x82, 0xd0, 0xb5, 0xd1, 0x81, 0xd1, 0x82, 0};
		std::string str((char *)s);
		UASSERT(utf8_to_wide(wrap_rows(str, 8)) != L"<invalid UTF-8 string>");
	}
}

void TestUtilities::testEnrichedString()
{
	EnrichedString str(L"Test bar");
	irr::video::SColor color(0xFF, 0, 0, 0xFF);

	UASSERT(str.substr(1, 3).getString() == L"est");
	str += L" BUZZ";
	UASSERT(str.substr(9, std::string::npos).getString() == L"BUZZ");
	str.setDefaultColor(color); // Blue foreground
	UASSERT(str.getColors()[5] == color);
	// Green background, then white and yellow text
	str = L"\x1b(b@#0F0)Regular \x1b(c@#FF0)yellow";
	UASSERT(str.getColors()[2] == 0xFFFFFFFF);
	str.setDefaultColor(color); // Blue foreground
	UASSERT(str.getColors()[13] == 0xFFFFFF00); // Still yellow text
	UASSERT(str.getBackground() == 0xFF00FF00); // Green background
}

void TestUtilities::testIsNumber()
{
	UASSERT(is_number("123") == true);
	UASSERT(is_number("") == false);
	UASSERT(is_number("123a") == false);
}


void TestUtilities::testIsPowerOfTwo()
{
	UASSERT(is_power_of_two(0) == false);
	UASSERT(is_power_of_two(1) == true);
	UASSERT(is_power_of_two(2) == true);
	UASSERT(is_power_of_two(3) == false);
	for (int exponent = 2; exponent <= 31; ++exponent) {
		UASSERT(is_power_of_two((1 << exponent) - 1) == false);
		UASSERT(is_power_of_two((1 << exponent)) == true);
		UASSERT(is_power_of_two((1 << exponent) + 1) == false);
	}
	UASSERT(is_power_of_two(U32_MAX) == false);
}

void TestUtilities::testMyround()
{
	UASSERT(myround(4.6f) == 5);
	UASSERT(myround(1.2f) == 1);
	UASSERT(myround(-3.1f) == -3);
	UASSERT(myround(-6.5f) == -7);
}

void TestUtilities::testStringJoin()
{
	std::vector<std::string> input;
	UASSERT(str_join(input, ",") == "");

	input.emplace_back("one");
	UASSERT(str_join(input, ",") == "one");

	input.emplace_back("two");
	UASSERT(str_join(input, ",") == "one,two");

	input.emplace_back("three");
	UASSERT(str_join(input, ",") == "one,two,three");

	input[1] = "";
	UASSERT(str_join(input, ",") == "one,,three");

	input[1] = "two";
	UASSERT(str_join(input, " and ") == "one and two and three");
}


static bool within(const f32 value1, const f32 value2, const f32 precision)
{
	return std::fabs(value1 - value2) <= precision;
}

static bool within(const v3f &v1, const v3f &v2, const f32 precision)
{
	return within(v1.X, v2.X, precision) && within(v1.Y, v2.Y, precision)
		&& within(v1.Z, v2.Z, precision);
}

static bool within(const core::matrix4 &m1, const core::matrix4 &m2,
		const f32 precision)
{
	const f32 *M1 = m1.pointer();
	const f32 *M2 = m2.pointer();
	for (int i = 0; i < 16; i++)
		if (! within(M1[i], M2[i], precision))
			return false;
	return true;
}

static bool roundTripsDeg(const v3f &v, const f32 precision)
{
	core::matrix4 m;
	setPitchYawRoll(m, v);
	return within(v, getPitchYawRoll(m), precision);
}

void TestUtilities::testEulerConversion()
{
	// This test may fail on non-IEEE systems.
	// Low tolerance is 4 ulp(1.0) for binary floats with 24 bit mantissa.
	// (ulp = unit in the last place; ulp(1.0) = 2^-23).
	const f32 tolL = 4.76837158203125e-7f;
	// High tolerance is 2 ulp(180.0), needed for numbers in degrees.
	// ulp(180.0) = 2^-16
	const f32 tolH = 3.0517578125e-5f;
	v3f v1, v2;
	core::matrix4 m1, m2;
	const f32 *M1 = m1.pointer();
	const f32 *M2 = m2.pointer();

	// Check that the radians version and the degrees version
	// produce the same results. Check also that the conversion
	// works both ways for these values.
	v1 = v3f(M_PI/3.0, M_PI/5.0, M_PI/4.0);
	v2 = v3f(60.0f, 36.0f, 45.0f);
	setPitchYawRollRad(m1, v1);
	setPitchYawRoll(m2, v2);
	UASSERT(within(m1, m2, tolL));
	UASSERT(within(getPitchYawRollRad(m1), v1, tolL));
	UASSERT(within(getPitchYawRoll(m2), v2, tolH));

	// Check the rotation matrix produced.
	UASSERT(within(M1[0], 0.932004869f, tolL));
	UASSERT(within(M1[1], 0.353553385f, tolL));
	UASSERT(within(M1[2], 0.0797927827f, tolL));
	UASSERT(within(M1[4], -0.21211791f, tolL));
	UASSERT(within(M1[5], 0.353553355f, tolL));
	UASSERT(within(M1[6], 0.911046684f, tolL));
	UASSERT(within(M1[8], 0.293892622f, tolL));
	UASSERT(within(M1[9], -0.866025448f, tolL));
	UASSERT(within(M1[10], 0.404508471f, tolL));

	// Check that the matrix is still homogeneous with no translation
	UASSERT(M1[3] == 0.0f);
	UASSERT(M1[7] == 0.0f);
	UASSERT(M1[11] == 0.0f);
	UASSERT(M1[12] == 0.0f);
	UASSERT(M1[13] == 0.0f);
	UASSERT(M1[14] == 0.0f);
	UASSERT(M1[15] == 1.0f);
	UASSERT(M2[3] == 0.0f);
	UASSERT(M2[7] == 0.0f);
	UASSERT(M2[11] == 0.0f);
	UASSERT(M2[12] == 0.0f);
	UASSERT(M2[13] == 0.0f);
	UASSERT(M2[14] == 0.0f);
	UASSERT(M2[15] == 1.0f);

	// Compare to Irrlicht's results. To be comparable, the
	// angles must come in a different order and the matrix
	// elements to compare are different too.
	m2.setRotationRadians(v3f(v1.Z, v1.X, v1.Y));
	UASSERT(within(M1[0], M2[5], tolL));
	UASSERT(within(M1[1], M2[6], tolL));
	UASSERT(within(M1[2], M2[4], tolL));

	UASSERT(within(M1[4], M2[9], tolL));
	UASSERT(within(M1[5], M2[10], tolL));
	UASSERT(within(M1[6], M2[8], tolL));

	UASSERT(within(M1[8], M2[1], tolL));
	UASSERT(within(M1[9], M2[2], tolL));
	UASSERT(within(M1[10], M2[0], tolL));

	// Check that Eulers that produce near gimbal-lock still round-trip
	UASSERT(roundTripsDeg(v3f(89.9999f, 17.f, 0.f), tolH));
	UASSERT(roundTripsDeg(v3f(89.9999f, 0.f, 19.f), tolH));
	UASSERT(roundTripsDeg(v3f(89.9999f, 17.f, 19.f), tolH));

	// Check that Eulers at an angle > 90 degrees may not round-trip...
	v1 = v3f(90.00001f, 1.f, 1.f);
	setPitchYawRoll(m1, v1);
	v2 = getPitchYawRoll(m1);
	//UASSERT(within(v1, v2, tolL)); // this is typically false
	// ... however the rotation matrix is the same for both
	setPitchYawRoll(m2, v2);
	UASSERT(within(m1, m2, tolL));
}
