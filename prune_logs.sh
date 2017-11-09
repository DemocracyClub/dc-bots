#!/bin/bash

set -e

echo "deleting log files older than 60 days..."
find /home/ubuntu/dc-bots/logs/ -mtime +60 -name '*.log' -exec rm {} \;
