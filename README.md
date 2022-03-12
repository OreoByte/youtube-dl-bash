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

# Updated for new version 1.3.1 opt_youtube-dl (Now with IFS built in)
	./opt_youtube-dl_v1.3.1.sh -h

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
./opt_youtube-dl_v1.4.sh -c <any-string> -t <format>
./opt_youtube-dl_v1.4.sh -c c -t mp3
```

## Note that youtube-dl also works with Twitch Vods

```
./opt_youtube-dl_v1.4.sh -l <url-of-clip-or-complete-vod> -t <format>
./opt_youtube-dl_v1.4.sh -l http://www.twitch.tv/videos/<video-number> -t mp4
```
