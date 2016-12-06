#!/bin/bash

cd ..

echo -e "\E[34;47mRemove previous CMake files..."
find . -type f -name "Makefile" -exec rm -vf {} \;
find . -type f -name "CMakeCache.txt" -exec rm -vf {} \;
find . -type f -name "cmake_install.cmake" -exec rm -vf {} \;
find . -type f -name "CPackConfig.cmake" -exec rm -vf {} \;
find . -type f -name "CPackSourceConfig.cmake" -exec rm -vf {} \;
find . -type d -name CMakeFiles -exec rm -rvf {} \;
echo -e "\E[34;47mdone!"