#!/bin/bash

#conda create -n drawing python=3.8.13 -y
#conda install pytorch==2.0.0 torchvision==0.15.0 torchaudio==2.0.0 pytorch-cuda=11.8 -c pytorch -c nvidia


# install os dependencies
if ! command -v java &> /dev/null
then
	sudo apt-get update 
	sudo apt install ca-certificates
	echo "java could not be found, installing"
	sudo apt install default-jre
fi


# install python dependencies

pip install -U openmim torch==1.13.0 torchserve
# Check if the directory exists
if [ ! -d "xtcocoapi" ]; then
	git clone https://github.com/jin-s13/xtcocoapi.git
fi
cd xtcocoapi
pip install -r requirements.txt
python setup.py install
cd ../


echo "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
cd torchserve
ckpt_dir="./model-store"
mkdir -p $ckpt_dir
if [ ! -d "model-store" ]; then
	echo "download checkpoints to " $ckpt_dir
	wget https://github.com/facebookresearch/AnimatedDrawings/releases/download/v0.0.1/drawn_humanoid_detector.mar -P $ckpt_dir/
	wget https://github.com/facebookresearch/AnimatedDrawings/releases/download/v0.0.1/drawn_humanoid_pose_estimator.mar -P $ckpt_dir/
fi
cd ..

echo "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"

pip install -U openmim torch==1.13.0 torchserve mmdet==2.27.0 mmpose==0.29.0 numpy==1.23.3 requests==2.31.0 scipy==1.10.0 tqdm==4.64.1
mim install mmcv-full==1.7.0

# bugfix for xtcocoapi, an mmpose dependency
pip install mmpose==0.29.0

echo "*** Now run torchserve:"
echo "cd torchserve && torchserve --start --ts-config config.local.properties --foreground"