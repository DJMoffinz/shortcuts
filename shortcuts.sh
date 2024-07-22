#!/bin/bash

usage() {
    echo "Shortcuts (or sc for short) is a small utility I've written in bash to give me shortcuts to commands I use a lot."
    echo "usage: sc command <parameters> [optional parameters]"
    echo "  YouTube Downloader:"
    echo "    ytdl <url> [timestamp] [custom name]"
}

if [ $# -eq 0 ]; then # runs if there are no arguments, displays usage and exits
    usage
    exit 1
fi

COMMAND="" # initialise the variable that stores the command to be executed

while [ "$1" != "" ]; do # while there are still arguments to be processed, do
    case $1 in # finds commands, only ytdl and the default case is implemented so far
        ytdl ) shift # shifts past argument
               COMMAND+="yt-dlp \"$1\"" # the first parameter is now $1
               shift # past the first parameter (the url)
               if [ "$1" != "" ]; then # optional timestamp parameter
                   COMMAND+=" --download-sections \"*$1\"" # i don't know why the asterisk needs to be there, but it does
                   shift # past optional second parameter
               fi
               if [ "$1" != "" ]; then # optional output file name parameter
                   COMMAND+=" -o \"$1 [%(id)s].%(ext)s\""
               fi
               COMMAND+=" -f \"bestvideo[height<=720][fps<=30]+bestaudio/best\"" # this caps the resolution and framerate because it saves space and i only use this for downloading memes anyway
               COMMAND+=" --extractor-args \"youtube:player_client=android,web\"" # if this wasnt here video probably wouldn't download. see https://github.com/yt-dlp/yt-dlp/issues/8066
               ;;
        * )    usage # default case for handling unexpected input, displays usage and exits
               exit 1
    esac
    shift
done

echo "evaluating $COMMAND" # useful for me, should probably make this exclusive to a debug flag
eval $COMMAND
