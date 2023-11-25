#!/bin/bash
# packages that are for the youtube-dl scirpt to work
sudo apt install ffmpeg xclip python3-pip mp3gain -y
pip3 install youtube-dl --user
# may not be in python but may be installed through the apt package manager
#sudo apt install -y youtube-dl
sudo apt install -y yt-dlp ffmpeg
