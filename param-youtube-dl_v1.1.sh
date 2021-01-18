#!/bin/bash
# input in order of option than youtube-url
flag=$1
link=$2

# for option used choose solution or error
for flag in "$@"
do
	if [ "$flag" == "--help" ] || [ "$flag" == "-h" ]
		then
			printf "Download the video as MP4:\n./script.sh -v <youtube-video-url>\n"
			printf "\nDownload the Audio as MP3:\n./script.sh -a <youtube-video-url>\n"
	elif [ "$flag" == "--video" ] || [ "$flag" == "-v" ]
	then
		youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' $link
		# pulls the best quilty it could be for that video. Saved as a .mp4 file
		exit 1
	elif [ "$flag" == "--audio" ] || [ "$flag" == "-a" ]
	then
		youtube-dl -x -f bestaudio --audio-quality 0 --audio-format mp3 $link
		# pulls the best quality audio for "X" video. Saved as a .mp3 file
		exit 1
	else
        	printf "Error: Invalid Option\n"
	fi
done
