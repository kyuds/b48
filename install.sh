#!/bin/bash

# Installation of 2048.sh script to local machine
mkdir ~/2048_install
cp 2048.sh ~/2048_install/2048
chmod +x ~/2048_install/2048

echo "export PATH=~/2048_install:\$PATH" >> ~/.zprofile
source ~/.zprofile
echo "Installed 2048 in ~/2048_install directory..."

