#!/bin/bash
apt-get update && apt-get upgrade
apt-get install -y git-core bash-completion git
apt-get install -y jq
DEBIAN_FRONTEND=noninteractive apt-get install -y mailutils
apt-get install -y python-pip
pip install virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh
echo "source /usr/local/bin/virtualenvwrapper.sh" >> /home/ubuntu/.bashrc
mkvirtualenv --python=/usr/bin/python3 py3-morph
