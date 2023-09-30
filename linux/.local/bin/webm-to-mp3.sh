#!/usr/bin/env bash

# convert all flacs in a directory to mp3

# echo $PWD
# echo *.flac
# echo -e "\n"

# for file in "*.flac"; do ffmpeg -i $file -q:a 0 "${file%.*}.mp3"; done

for i in *.webm ; do 
    ffmpeg -i "$i" -q:a 0 "$(basename "${i/.flac}").mp3"
    #sleep 60
done
