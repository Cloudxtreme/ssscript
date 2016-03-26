#!/bin/sh
sudo yum install -y python-pip
sudo yum install -y m2crypto
pip install cymysql
git clone -b manyuser https://github.com/VoganWong/shadowsocks.git
