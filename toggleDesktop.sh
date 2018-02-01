#!/bin/bash
# <bitbar.title>Toggle desktop</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author.github>ghandic</bitbar.author.github>
# <bitbar.author>AndyChallis</bitbar.author>
# <bitbar.desc>Hides/shows the desktop</bitbar.desc>


function get_state {
state=`defaults read com.apple.finder CreateDesktop`
}

if [[ "$1" = "show" ]]; then
  defaults write com.apple.finder CreateDesktop true; killall Finder
fi

if [[ "$1" = "hide" ]]; then
  defaults write com.apple.finder CreateDesktop false;killall Finder
fi


get_state;
if "$state" is true; then
	echo "🙉"
	echo "---"
	echo "Hide Desktop Icons| bash='$0' param1=hide terminal=false refresh=true";
	exit
else
	echo "🙈"
	echo "---"
	echo "Show Desktop Icons| bash='$0' param1=show terminal=false refresh=true";
	exit
fi
