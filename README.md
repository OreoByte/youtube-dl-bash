# youtube-dl-bash
NOTE; install and update youtube-dl through your Linux distro's package manager
Enjoy!

---

## Then `Retired for old scripts built into opt script`
	while IFS= read -r line; do  bash param-youtube-dl.sh -a $line; done <list
	# or
	while IFS= read -r line; do  bash param-youtube-dl.sh -v $line; done <list

---

# installing requirements
`cd youtube-dl-bash && bash ./required_packages.sh`

# Updated for new version  opt_youtube-dl (Now with IFS built in) 
```

{ Youtube-DL Help Menu. ';..;' }
--------------------------------------------------------------------------------------
-S // -E || Start Time or End Time of the download video <hours:minutes:seconds>

-l | A Youtube Link/URL To Download.
-t | File type (mp3,a,audio) OR (mp4,v,video).
-f | File with a list of multiple youtube URL to all download. With each URL on its own new line.
-y | Manually set the tool path to (yt-dlp) from (github) if the original path is broken
-n | Normalize the audio of all the .mp3 files from a desired directory
-b | Leverage browser session cookie to download video/audio you have subbed to. Like from Twitch. {firefox, chrome, chromium, or whatever you are signed into}
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

# Download URL with a custom tool path if yt-dlp is NOT in your current path. Like git cloned from GitHub
./opt_youtube-dl.sh -f url_file -t a -y ~/Music/yt-dlp/yt-dlp.sh

# Download part of the URL between a custom starting and ending timestap
./opt_youtube-dl.sh -l <url> -t audio -S 0:0:14 -E 0:2:55

# Download URL with a browser's Session Cookie
./opt_youtube-dl.sh -l <url> -t video -b chromium

# Normalize Audio. NOTE must have a forward slash at the end of the directory to work properly
./opt_youtube-dl.sh -n .
./opt_youtube-dl.sh -n ~/Music/new_music/
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

## Downloading a Twitch VOD the browser's cookie when it's Subs only

Not build into the script yet ):

```
yt-dlp --cookies-from-browser <brower-in-use> -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' https://www.twitch.tv/videos/<video-number>
yt-dlp --cookies-from-browser firefox -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' https://www.twitch.tv/videos/31337
```
