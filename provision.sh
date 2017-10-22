#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

apt-get -y update && apt-get -y upgrade
apt-get install -y git-core bash-completion git
apt-get install -y jq
apt-get install -y mailutils
apt-get install -y python-pip
pip install virtualenvwrapper
