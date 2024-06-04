#!/bin/bash

#conda create -n drawing python=3.8.13 -y
#conda install pytorch==2.0.0 torchvision==0.15.0 torchaudio==2.0.0 pytorch-cuda=11.8 -c pytorch -c nvidia


# install os dependencies
sudo apt-get update 
sudo apt install ca-certificates
sudo apt install default-jre

# install python dependencies
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

ckpt_dir="/home/torchserve/model-store"
mkdir -p $ckpt_dir
if [ ! -d "model-store" ]; then
	echo "download checkpoints to " $ckpt_dir
	wget https://github.com/facebookresearch/AnimatedDrawings/releases/download/v0.0.1/drawn_humanoid_detector.mar -P $ckpt_dir/
	wget https://github.com/facebookresearch/AnimatedDrawings/releases/download/v0.0.1/drawn_humanoid_pose_estimator.mar -P $ckpt_dir/
fi

echo "*** Now run torchserve:"
echo "torchserve --start --ts-config torchserve/config.local.properties --foreground"


