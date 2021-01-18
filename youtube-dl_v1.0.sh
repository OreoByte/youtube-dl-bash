#!/bin/bash
# basic script to download any Youtube video as mp4 or mp3
# not to be used with more than on video, at least not yet

# is youtube-dl installed or not
test() {
	if type -a youtube-dl 2>&1 > /dev/null; then
		printf "Please enter a Youtube video link to convert: "
		read url
		eval link=$url
	else
		printf "youtube-dl has not been installed"
        exit 1
	fi
}
#option menu for mp3 or mp4 max quality
options() {

printf "Enter 1 to convert media to mp4\nOr\nEnter 2 to convert media to mp3 only\nInput: "; read input
	if [ $input == 1 ]; then
		youtube-dl youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' $link
	        # pulls the best quilty it could be for that video. Saved as a .mp4 file
    elif [ $input == 2 ]; then
		youtube-dl -x -f bestaudio --audio-quality 0 --audio-format mp3 $link
            # pulls the best quality audio for "X" video. Saved as a .mp3 file
	else
        printf "Error: Invalid Option"; exit 1
	fi
}
#running
test; options
