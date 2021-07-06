#!/bin/sh
cd $HOME
PROTON_URL=$(curl --silent "https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest" | grep -Po '"browser_download_url": "*\K[^"]*.tar.gz')
PROTON_VERSION=$(echo "$PROTON_URL" | grep -Po '\/\KProton-.*.tar.gz')
if [ -d "$HOME/.steam/root/compatibilitytools.d/$( echo $PROTON_VERSION | grep -Po '.*(?=.tar.gz)' )" ]; then
	echo -e "Latest version of Proton-GE is already installed. VERSION: $PROTON_VERSION"
	exit 0
fi
wget "$PROTON_URL" -q --show-progress
if [ ! -d ~/.steam/root/compatibilitytools.d ]; then
	mkdir ~/.steam/root/compatibilitytools.d
	echo "Made new directory"
fi
tar -xf "$PROTON_VERSION" -C ~/.steam/root/compatibilitytools.d/
rm $PROTON_VERSION*
echo "\e[1;31mPlease restart steam\e[0m"
