#!/bin/bash
man_help () {
	echo -e "\n{ Youtube-DL Help Menu. ';..;' }\n-----------------------------------------------------"
	echo -e "-l | A Youtube Link/URL To Download.\n-t | File type (mp3,a,audio) OR (mp4,v,video)."
	echo -e "-f | File with a list of multiple youtube URL to all download. With each URL on its own new line."
	echo -e "-c | Use the URL saved to the secondary Ctrl-C/Ctrl-v Clipboard. Instead of having put the link in the command with xclip.\n\nExamples:"
	echo -e "# Download video as MP3 file.\n./opt_youtube-dl.sh -t mp3 -l https://youtube.com/watch?=link\n"
	echo -e "# Download video as MP4 file.\n./opt_youtube-dl.sh -l https://Youtube.com/watch?link -t video\n"
	echo -e "# Download from URL file.\n./opt_youtube-dl.sh -f yt_url_list.txt -t audio\n"
	echo -e "# Download a single URL that is saved to your secondary Ctrl-C/Ctrl-V clipboard read with xclip.\n./opt_youtube-dl.sh -c -t mp3"
	echo -e "./opt_youtube-dl.sh -c -t a"
	exit 1
}
if [ -z "$1" ]; then
	man_help
elif  [ "$1" == "-h" ]; then
	man_help
else
while [[ "$#" -gt 0 ]]
do
case "$1" in
	-l) link=$2;;
	-t) f_type=$2;;
	-f) file=$2;;
	-c) url_clip=$(xclip -o -sel clip);;
	-h) man_help
esac
shift
done
fi
if [[ "$url_clip" != '' ]]; then
	if [[ "$f_type" == 'mp4' ]] || [[ "$f_type" == 'video' ]] || [[ "$f_type" == 'v' ]]; then
		youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' $url_clip
		# pulls the best quilty it could be for that video. Saved as a .mp4 file
		exit 1
	elif [[ "$f_type" == 'mp3' ]] || [[ "$f_type" == 'audio' ]] || [[ "$f_type" == 'a' ]]; then
		youtube-dl -x -f bestaudio --audio-quality 0 --audio-format mp3 $url_clip
		# pulls the best quality audio for "X" video. Saved as a .mp3 file
		exit 1
	else
		echo "Error Youtube Video Failed Convert... Clip"
	fi
elif [[ -z "$link" ]]; then
	if [[ -z "$file" ]]; then
		printf "Error No Link 0r File Provided"
	elif [[ "$f_type" == 'mp4' ]] || [[ "$f_type" == 'video' ]] || [[ "$f_type" == 'v' ]]; then
		title_file=$(grep "http" $file)
		while IFS= read -r line; do youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' $line; done < <(printf '%s\n' "$title_file")
		# pulls the best quilty it could be for that video. Saved as a .mp4 file
		exit 1
	elif [[ "$f_type" == 'mp3' ]] || [[ "$f_type" == 'audio' ]] || [[ "$f_type" == 'a' ]]; then
		title_file=$(grep "http" $file)
		while IFS= read -r line; do youtube-dl -x -f bestaudio --audio-quality 0 --audio-format mp3 $line; done < <(printf '%s\n' "$title_file")
		# pulls the best quality audio for "X" video. Saved as a .mp3 file
		exit 1
        else
		echo "Error Youtube Video Failed Convert... File"
	fi
elif [[ "$f_type" == 'mp4' ]] || [[ "$f_type" == 'video' ]] || [[ "$f_type" == 'v' ]]; then
		youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' $link
		# pulls the best quilty it could be for that video. Saved as a .mp4 file
		exit 1
elif [[ "$f_type" == 'mp3' ]] || [[ "$f_type" == 'audio' ]] || [[ "$f_type" == 'a' ]]; then
		youtube-dl -x -f bestaudio --audio-quality 0 --audio-format mp3 $link
		# pulls the best quality audio for "X" video. Saved as a .mp3 file
		exit 1
else
	echo "Error Youtube Video Failed Convert... Link"
fi
