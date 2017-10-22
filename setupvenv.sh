#!/bin/bash
set -e

source /usr/local/bin/virtualenvwrapper.sh
echo "source /usr/local/bin/virtualenvwrapper.sh" >> /home/ubuntu/.bashrc
mkvirtualenv --python=/usr/bin/python3 py3-morph
