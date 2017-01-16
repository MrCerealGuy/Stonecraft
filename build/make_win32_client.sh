#!/bin/bash
set -e

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set directories
platform="win-i686" 
builddir="$( cd "$platform" && pwd )"

cd $builddir/_build

make package -j$(grep -c processor /proc/cpuinfo)

# EOF