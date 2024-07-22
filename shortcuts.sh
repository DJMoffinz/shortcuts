#!/bin/bash

usage() {
    echo "Shortcuts (or sc for short) is a small utility I've written in bash to give me shortcuts to commands I use a lot."
    echo "usage: sc command <parameters> [optional parameters]"
    echo "  YouTube Downloader:"
    echo "    ytdl <url> [timestamp] [custom name]"
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
               if [ "$1" != "" ]; then # optional timestamp parameter
                   COMMAND+=" --download-sections \"*$1\""
                   shift # past optional second parameter
               fi
               if [ "$1" != "" ]; then # optional name parameter
                   COMMAND+=" -o \"$1 [%(id)s].%(ext)s\""
               fi
               COMMAND+=" -f \"bestvideo[height<=720][fps<=30]+bestaudio/best\""
               COMMAND+=" --extractor-args \"youtube:player_client=android,web\""
               ;;
        * )    usage
               exit 1
    esac
    shift
done

echo "evaluating $COMMAND"
eval $COMMAND
