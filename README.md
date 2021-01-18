# youtube-dl-bash
NOTE; install and update youtube-dl through your Linux distro's package manager
Enjoy!

# Run script by
	bash youtube-dl.sh
	or
	chmod +x youtube-dl.sh && ./youtube-dl.sh

# NOTE use the updated script for one line use
	chmod +x param-youtube-dl.sh
	./param-youtube-dl.sh -h (for help)

# Extra (1) download a custom youtube list
	vi list # put each complete youtube url on each line
# then
	while IFS= read -r line; do  bash param-youtube-dl.sh -a $line; done <list
	# or
	while IFS= read -r line; do  bash param-youtube-dl.sh -v $line; done <list

# Updated for new version 1.2 opt_youtube-dl (Now with IFS built in)
	./opt_youtube-dl_v1.2.sh -h
