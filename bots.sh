#!/bin/bash

set -e

# grab settings from json files
SETTINGS_FILE="./settings.json"
# check required settings exist before we start
jq -e 'has("BASE_DIR")' $SETTINGS_FILE > /dev/null || (echo "must define BASE_DIR" && exit 1)
jq -e 'has("VIRTUALENV")' $SETTINGS_FILE > /dev/null || (echo "must define VIRTUALENV" && exit 1)
# turn any settings declared in $SETTINGS_FILE into env vars
for key in $(jq -r 'keys[]' $SETTINGS_FILE)
do
    export $key=$(jq -r ".$key" $SETTINGS_FILE)
done
# grab a list of scrapers to run
declare -a repos=( $(jq -r '.[]' ./scrapers.json) )

SUCCESS="\n"
ERRORS="\n"
NOW="$(date +%Y%m%d%H%M%S)"
LOGFILE="./logs/$NOW.log"


{
    source $VIRTUALENV
    for repo in "${repos[@]}"
    do
        cd /
        echo "fetching $repo ..."
        if [ -d "$BASE_DIR$repo" ]; then
            # if checkout already exists, update the repo
            cd "$BASE_DIR$repo"
            git pull
        else
            # otherwise create the repo
            git clone "http://github.com/$repo.git" "$BASE_DIR$repo"
            cd "$BASE_DIR$repo"
        fi

        # update the virtualenv
        pip install --upgrade -r requirements.txt

        # run the job
        echo "running job $repo ..."
        {
            # set a timeout so that the job will fail if it has
            # been trying to run for more than 20 mins
            timeout 20m python scraper.py &&
            SUCCESS="${SUCCESS}Successfully ran $repo\n"
        } || {
            ERRORS="${ERRORS}Failed to run $repo\n"
        }
        echo ""
    done
    deactivate

    echo -e $SUCCESS
    echo -e $ERRORS

} |& tee -a $LOGFILE
