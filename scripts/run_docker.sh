#!/bin/bash

# Build docker
sudo docker build -t mattersim:9.2-devel-ubuntu18.04 .

# Run docker container
sudo nvidia-docker run -it --mount type=bind,source=$MATTERPORT_DATA_DIR,target=/root/mount/Matterport3DSimulator/data/v1/scans --volume `pwd`:/root/mount/Matterport3DSimulator mattersim:9.2-devel-ubuntu18.04

sudo nvidia-docker run -it \
  --mount type=bind,source=$MATTERPORT_DATA_DIR,target=/root/mount/Matterport3DSimulator/data/v1/scans \
  --mount type=bind,source=/home/jihun/workspace/repositories/commonsense/mqa/NaviLLM,target=/root/mount/NaviLLm \
  --volume `pwd`:/root/mount/Matterport3DSimulator \
  mattersim:9.2-devel-ubuntu18.04

# Inside docker container: below codes do not run.
# Build simulator code
cd /root/mount/Matterport3DSimulator/build
#cmake -DEGL_RENDERING=ON ..
cmake -DEGL_RENDERING=ON -DPYTHON_EXECUTABLE=$(which python3) ..
make
cd ../