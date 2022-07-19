# youtube-dl-bash
NOTE; install and update youtube-dl through your Linux distro's package manager
Enjoy!

---

# Then `Retired for old scripts built into opt script`
	while IFS= read -r line; do  bash param-youtube-dl.sh -a $line; done <list
	# or
	while IFS= read -r line; do  bash param-youtube-dl.sh -v $line; done <list

---

# installing requirements
`cd youtube-dl-bash && bash ./required_packages.sh`

# Updated for new version  opt_youtube-dl (Now with IFS built in) 
```
./opt_youtube-dl.sh

{ Youtube-DL Help Menu. ';..;' }
-----------------------------------------------------
-l | A Youtube Link/URL To Download.
-t | File type (mp3,a,audio) OR (mp4,v,video).
-f | File with a list of multiple youtube URL to all download. With each URL on its own new line.
-c | Use the URL saved to the secondary Ctrl-C/Ctrl-v Clipboard. Instead of having put the link in the command with xclip.

Examples:
# Download video as MP3 file.
./opt_youtube-dl.sh -t mp3 -l https://youtube.com/watch?=link

# Download video as MP4 file.
./opt_youtube-dl.sh -l https://Youtube.com/watch?link -t video

# Download from URL file.
./opt_youtube-dl.sh -f yt_url_list.txt -t audio

# Download a single URL that is saved to your secondary Ctrl-C/Ctrl-V clipboard read with xclip.
./opt_youtube-dl.sh -c -t mp3
./opt_youtube-dl.sh -c -t a
```

# Example. Creating a custom music URL.lst for the `-f` file option

## Updated script will filter out all `#` custom song titles
```
nano OR vim url.lst

# name of song (rick roll)
https://www.youtube.com/watch?v=dQw4w9WgXcQ
# name of song 2 (Neoni - Bloodstream "ft Jung Youth")
https://www.youtube.com/watch?v=3OUneqQqad4
```

## Youtube-dl all URLs in the `url.lst` file

```
chmod +x ./opt_youtube-dl_v1.4.sh
./opt_youtube-dl_v1.4.sh -f url.lst -t mp3
```

## Download a video URL that is saved to thesecondary ctrl-v/c clipboard with `xclip` installed

```
./opt_youtube-dl_v1.4.sh -c -t mp3
```

## Note that youtube-dl also works with Twitch Vods

```
./opt_youtube-dl_v1.4.sh -l <url-of-clip-or-complete-vod> -t <format>
./opt_youtube-dl_v1.4.sh -l http://www.twitch.tv/videos/<video-number> -t mp4
```
