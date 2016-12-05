#!/bin/bash

cd ..

find . -type f -name "Makefile" -exec rm {} \;
find . -type f -name "CMakeCache.txt" -exec rm {} \;
find . -type f -name "cmake_install.cmake" -exec rm {} \;
find . -type f -name "CPackConfig.cmake" -exec rm {} \;
find . -type f -name "CPackSourceConfig.cmake" -exec rm {} \;
find . -type d -name CMakeFiles -exec rm -r {} \;