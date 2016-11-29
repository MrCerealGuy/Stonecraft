cd ../
cmake . -DBUILD_CLIENT=0 -DIRRLICHT_SOURCE_DIR=../libraries/irrlicht-1.8.3/source/Irrlicht/
make -j$(grep -c processor /proc/cpuinfo)
 
