#!/bin/bash
man_help () {
cat <<eof
--------------------------------------------------------------------------------------
{ Youtube-DL Help Menu. ';..;' }
--------------------------------------------------------------------------------------
-S // -E || Start Time or End Time of the download video <hours:minutes:seconds>
-l | A Youtube Link/URL To Download.\n-t | File type (mp3,a,audio) OR (mp4,v,video).
-f | File with a list of multiple youtube URL to all download. With each URL on its own new line.
-y | Manually set the tool path to (yt-dlp) from (github) if the original path is broken
-n | Normalize the audio of all the .mp3 files from a desired directory
-b | Leverage browser session cookie to download video/audio you have subbed to. Like from Twitch. {firefox, chrome, chromium, or whatever you are signed into}
-q | Set MP4 Video Quality to something else other than (bestvideo) to prevent poor playback on older devices like smart phones
-c | Use the URL saved to the secondary Ctrl-C/Ctrl-v Clipboard. Instead of having put the link in the command with xclip.

-p | Change the resolution of the MP4 from -t video to another resolution so it works better on older devices.
-o | Output filename of the new MP4 from the -v <video_resolution> option. (p,phone) 0r L:W -> 1920:1080.
-v | Original MP4 Video that you want to change the resolution with.

---------------------------------------------------------------------------------------------------------------
Examples:
# Download video as MP3 file.
./opt_youtube-dl.sh -t mp3 -l https://youtube.com/watch?=link\n

# Download video as MP4 file.
./opt_youtube-dl.sh -l https://Youtube.com/watch?link -t video\n

# Download from URL file.
./opt_youtube-dl.sh -f yt_url_list.txt -t audio

# Download a single URL that is saved to your secondary Ctrl-C/Ctrl-V clipboard read with xclip.
./opt_youtube-dl.sh -c -t mp3
./opt_youtube-dl.sh -c -t a

# Download URL with a custom tool path if yt-dlp is NOT in your current path. Like git cloned from GitHub
./opt_youtube-dl.sh -f url_file -t a -y ~/Music/yt-dlp/yt-dlp.sh

# Download part of the URL between a custom starting and ending timestap
./opt_youtube-dl.sh -l <url> -t audio -S 0:0:14 -E 0:2:55

# Download URL with a browser's Session Cookie
./opt_youtube-dl.sh -l <url> -t video -b chromium

# Normalize Audio. NOTE must have a forward slash at the end of the directory to work properly
./opt_youtube-dl.sh -n .
./opt_youtube-dl.sh -n ~/Music/new_music/

# Change the resolution of a downloaded Video
./opt_youtube-dl.sh -v <org-video.mp4> -p <option> -o <mod_vid.mp4>

./opt_youtube-dl.sh -v vid.mp4 -p phone -o mod_vid.mp4
./opt_youtube-dl.sh -v vid.mp4 -p '4096×2160' -o mod_vid.mp4
eof
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
			-y) yt_tool=$2;;
			-n) norm_audio=$2;;
			-c) url_clip=$(xclip -o -sel clip);;
			-b) browser=$2;;
			-q) mp4_quality=$2;;
			-S) start_time=$2;;
			-E) end_time=$2;;
			-p) pixel_opt=$2;;
			-v) mp4_video=$2;;
			-o) mp4_output=$2;;
			-h) man_help
		esac
		shift
	done
fi
yt_tool="yt-dlp"
if [[ "$pixel_opt" != '' ]]; then
	if [[ "$pixel_opt" == "phone" ]] || [[ "$pixel_opt" == "p" ]]; then
		ffmpeg -i "$mp4_video" -vf "scale=1920:1080" "$mp4_output"
	else
		ffmpeg -i "$mp4_video" -vf "scale=$pixel_opt" "$mp4_output"
	fi
fi
if [[ "$norm_audio" != '' ]]; then
	if [[ "$norm_audio" == '.' ]]; then
		mp3gain -c -r *.mp3
		exit 0
	elif [[ "$norm_audio" != '.' ]]; then
		mp3gain -c -r $norm_audio*.mp3
		exit 0
	else
		echo "Error Failed At Normalize audio..."
		exit 0
	fi
fi
if [[ "$browser" != '' ]]; then
	cookie="--cookies-from-browser "
	cookie+="${browser}"
else
	cookie=""
fi
# https://unix.stackexchange.com/questions/230481/how-to-download-portion-of-video-with-youtube-dl-command
# yt-dlp --postprocessor-args "-ss 0:0:00 -to 0:2:55" <url>
# yt-dlp --postprocessor-args "-ss 0:0:00 -to 0:2:55" <url> -x -f bestaudio --audio-quality 0 --audio-format mp3
#---------------------------------------------------------------------------------------------------------------------------------------------
# Download with (--postprocessor-args)
if [[ "$start_time" != '' ]] || [[ "$end_time" != '' ]]; then
echo $start_time
echo $end_time
	if [[ "$url_clip" != '' ]]; then
		if [[ "$f_type" == 'mp4' ]] || [[ "$f_type" == 'video' ]] || [[ "$f_type" == 'v' ]]; then
			$yt_tool -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' --postprocessor-args "-ss $start_time -to $end_time" $url_clip $cookie
			# pulls the best quilty it could be for that video. Saved as a .mp4 file
			exit 1
		elif [[ "$f_type" == 'mp3' ]] || [[ "$f_type" == 'audio' ]] || [[ "$f_type" == 'a' ]]; then
			$yt_tool -x -f bestaudio --audio-quality 0 --audio-format mp3 --postprocessor-args "-ss $start_time -to $end_time" $url_clip $cookie
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
			while IFS= read -r line; do $yt_tool -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' --postprocessor-args "-ss $start_time -to $end_time" $line $cookie; done < <(printf '%s\n' "$title_file")
				# pulls the best quilty it could be for that video. Saved as a .mp4 file
				exit 1
			elif [[ "$f_type" == 'mp3' ]] || [[ "$f_type" == 'audio' ]] || [[ "$f_type" == 'a' ]]; then
				title_file=$(grep "http" $file)
				while IFS= read -r line; do $yt_tool -x -f bestaudio --audio-quality 0 --audio-format mp3 --postprocessor-args "-ss $start_time -to $end_time" $line $cookie; done < <(printf '%s\n' "$title_file")
					# pulls the best quality audio for "X" video. Saved as a .mp3 file
					exit 1
				else
					echo "Error Youtube Video Failed Convert... File"
		fi
	elif [[ "$f_type" == 'mp4' ]] || [[ "$f_type" == 'video' ]] || [[ "$f_type" == 'v' ]]; then
		$yt_tool -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' --postprocessor-args "-ss $start_time -to $end_time" $link $cookie
		# pulls the best quilty it could be for that video. Saved as a .mp4 file
		exit 1
	elif [[ "$f_type" == 'mp3' ]] || [[ "$f_type" == 'audio' ]] || [[ "$f_type" == 'a' ]]; then
		$yt_tool -x -f bestaudio --audio-quality 0 --audio-format mp3 --postprocessor-args "-ss $start_time -to $end_time" $link $cookie
		# pulls the best quality audio for "X" video. Saved as a .mp3 file
		exit 1
	else
		echo "Error Youtube Video Failed Convert... Link"
	fi
fi
#---------------------------------------------------------------------------------------------------------------------------------------
# download without (--postprocessor-args)
if [[ "$url_clip" != '' ]]; then
	if [[ "$f_type" == 'mp4' ]] || [[ "$f_type" == 'video' ]] || [[ "$f_type" == 'v' ]]; then
		$yt_tool -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' $url_clip $cookie
		# pulls the best quilty it could be for that video. Saved as a .mp4 file
		exit 1
	elif [[ "$f_type" == 'mp3' ]] || [[ "$f_type" == 'audio' ]] || [[ "$f_type" == 'a' ]]; then
		$yt_tool -x -f bestaudio --audio-quality 0 --audio-format mp3 $url_clip $cookie
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
		while IFS= read -r line; do $yt_tool -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' $line $cookie; done < <(printf '%s\n' "$title_file")
			# pulls the best quilty it could be for that video. Saved as a .mp4 file
			exit 1
		elif [[ "$f_type" == 'mp3' ]] || [[ "$f_type" == 'audio' ]] || [[ "$f_type" == 'a' ]]; then
			title_file=$(grep "http" $file)
			while IFS= read -r line; do $yt_tool -x -f bestaudio --audio-quality 0 --audio-format mp3 $line $cookie; done < <(printf '%s\n' "$title_file")
				# pulls the best quality audio for "X" video. Saved as a .mp3 file
				exit 1
			else
				echo "Error Youtube Video Failed Convert... File"
	fi
elif [[ "$f_type" == 'mp4' ]] || [[ "$f_type" == 'video' ]] || [[ "$f_type" == 'v' ]]; then
	$yt_tool -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' $link $cookie
	# pulls the best quilty it could be for that video. Saved as a .mp4 file
	exit 1
elif [[ "$f_type" == 'mp3' ]] || [[ "$f_type" == 'audio' ]] || [[ "$f_type" == 'a' ]]; then
	$yt_tool -x -f bestaudio --audio-quality 0 --audio-format mp3 $link $cookie
	# pulls the best quality audio for "X" video. Saved as a .mp3 file
	exit 1
else
	echo "Error Youtube Video Failed Convert... Link"
fi
