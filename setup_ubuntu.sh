# Copyright (c) Meta Platforms, Inc. and affiliates.
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

# needed for torchserve
# if no java..
if ! command -v java &> /dev/null
then
	sudo apt install openjdk-19-jre-headless
fi

#conda install pytorch==2.0.0 torchvision==0.15.0 torchaudio==2.0.0 pytorch-cuda=11.8 -c pytorch -c nvidia
#!/bin/bash

# install os dependencies
sudo apt-get update 
sudo apt install ca-certificates
sudo apt install default-jre

# install python dependencies
#conda install python=3.8.13 -y

pip install openmim
pip install torch==2.0.0
mim install mmcv-full==1.7.0
pip install mmdet==2.27.0
pip install torchserve

# Check if the directory exists
if [ ! -d "xtcocoapi" ]; then
	git clone https://github.com/jin-s13/xtcocoapi.git
fi
cd xtcocoapi
pip install -r requirements.txt
python setup.py install
cd ../

# bugfix for xtcocoapi, an mmpose dependency
pip install mmpose==0.29.0
pip install torchvision==0.15.1  # solve torch version problem

if [ ! -d "model-store" ]; then
	wget https://github.com/facebookresearch/AnimatedDrawings/releases/download/v0.0.1/drawn_humanoid_detector.mar -P ./model-store/
	wget https://github.com/facebookresearch/AnimatedDrawings/releases/download/v0.0.1/drawn_humanoid_pose_estimator.mar -P ./model-store/
fi

echo "*** Now run torchserve:"
echo "torchserve --start --ts-config torchserve/config.local.properties --foreground"


