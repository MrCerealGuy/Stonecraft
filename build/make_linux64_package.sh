cd ../
make package -j$(grep -c processor /proc/cpuinfo)
 
