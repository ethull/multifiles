#!/usr/bin/env bash

shopt -s globstar
for f in **/*.flac; do
    #flac -cd "$f" | lame -b 320 - "${f%.*}".mp3 # && rm "$f"
    ffmpeg -i "$f" -q:a 0 "${f%.*}".mp3 && rm "$f"
done
