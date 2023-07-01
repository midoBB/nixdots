{
  pkgs,
  workMode,
  ...
}: let
  convertvideos = pkgs.writeScriptBin "convertvideos" ''
    #!/usr/bin/env bash
    original=$(basename "$1")
    newfile=$(echo "$original" | sed 's/\(.*\)\..*/\1/')

    # Get the video dimensions using ffprobe
    dimensions=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0 "$original")
    width=$(echo "$dimensions" | cut -d ',' -f 1)
    height=$(echo "$dimensions" | cut -d ',' -f 2)

    # Determine if the video is horizontal or vertical
    if (( $height > $width )); then
      # Vertical video
      newheight=720
      newwidth=$(( $width * $newheight / $height ))
    else
      # Horizontal video
      newwidth=-1
      newheight=720
    fi

    # if ffmpeg -i "$original" -vf scale=$newwidth:$newheight -c:v libx264 -crf 23 -preset slow -c:a aac -b:a 128k "$newfile-720.mp4"; then
    if ffmpeg -vaapi_device /dev/dri/renderD128 -i "$original" -vf "scale=$newwidth:$newheight:force_original_aspect_ratio=decrease,format=nv12,hwupload" -c:v h264_vaapi  -b:v 1200k -preset superfast -c:a aac -b:a 128k -v verbose "$newfile-720.mp4" ; then
      rm "$original"
      mv "$newfile-720.mp4" "$original"
    else
        echo "ffmpeg command failed"
        rm "$newfile-720.mp4"
    fi
  '';
in {
  home.packages =
    if workMode
    then []
    else [
      convertvideos
      pkgs.coreutils
      # tools needed for my ocr setup
      pkgs.ffmpeg
    ];
}
