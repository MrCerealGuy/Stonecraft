# NDK_TOOLCHAIN_VERSION := clang3.8

APP_PLATFORM := android-9
APP_MODULES := stonecraft
APP_STL := gnustl_static

APP_CPPFLAGS += -fexceptions
APP_GNUSTL_FORCE_CPP_FEATURES := rtti

