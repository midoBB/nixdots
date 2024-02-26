#!/usr/bin/env bash
original=$(basename "$1")
newfile=$(echo "$original" | sed 's/\(.*\)\..*/\1/')
# Get the video dimensions using ffprobe
dimensions=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0 "$original")
width=$(echo "$dimensions" | cut -d ',' -f 1)
height=$(echo "$dimensions" | cut -d ',' -f 2)

# Determine if the video is horizontal or vertical
if (( height > width )); then
    # Vertical video
    newheight=720
    newwidth=$(( width * newheight / height ))
else
    # Horizontal video
    newwidth=1280
    newheight=720
fi
if ffmpeg -init_hw_device vaapi=foo:/dev/dri/renderD128 -hwaccel vaapi -hwaccel_output_format vaapi -hwaccel_device foo -i  "$original" -filter_hw_device foo -vf "scale_vaapi=w=$newwidth:h=$newheight,format=nv12|vaapi,hwupload" -c:v h264_vaapi -b:v 2M -maxrate 2M  -bufsize  2M -preset slow -c:a aac -b:a 128k "$newfile-720.mp4" ; then
    rm "$original"
    mv "$newfile-720.mp4" "$original"
else
    echo "ffmpeg command failed"
    rm "$newfile-720.mp4"
fi
