#!/bin/bash

usage() {
    echo "usage: $0 ytdl url [timestamp]"
}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

COMMAND=""

while [ "$1" != "" ]; do
    case $1 in
        ytdl ) shift # shifts past argument
               COMMAND+="yt-dlp \"$1\"" # the first parameter is now $1
               shift # past the first parameter (the url)
               if [ "$1" != "" ]; then
                   COMMAND+=" --download-sections \"*$1\""
                   shift # past optional second parameter
               fi
               COMMAND+=" --extractor-args \"youtube:player_client=android,web\""
               ;;
        * )    usage
               exit 1
    esac
    shift
done

echo "evaluating $COMMAND"
eval $COMMAND
