#!/bin/bash

if [ ! -d build ]; then
	mkdir build
	cd build
	cmake ../ -DCMAKE_BUILD_TYPE=Release
	cd ..
fi

/home/ubuntu/sto/mount_hugepages.sh 102400
./run_scripts.sh
sudo shutdown -h +1
