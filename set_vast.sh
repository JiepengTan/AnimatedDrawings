#!/bin/bash



git config --global user.name 'jiepengtan' 
git config --global user.email 'jiepengtan@gmail.com'

ssh-keygen -t rsa -C "jiepengtan@gmail.com"



mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh


~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh


conda create --name draw python=3.8.13 -y
conda activate draw

sudo apt-get install libosmesa6-dev freeglut3-dev -y
sudo apt-get install libglfw3-dev libgles2-mesa-dev -y 
sudo apt-get install libosmesa6 - y
export PYOPENGL_PLATFORM=osmesa 
#conda install -c conda-forge libstdcxx-ng