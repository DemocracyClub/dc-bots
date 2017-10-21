#!/bin/bash
apt-get update && apt-get upgrade
apt-get install -y git-core bash-completion git
apt-get install -y jq
apt-get install -y python-pip
pip install virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh
echo "source /usr/local/bin/virtualenvwrapper.sh" >> /home/ubuntu/.bashrc
mkvirtualenv --python=/usr/bin/python3 py3-morph
