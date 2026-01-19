#! /usr/bin/env sh

# /usr/bin/env nix
# nix shell nixpkgs#bash nixpkgs#playerctl nixpkgs#gnused --command bash

# check that there is actual data to read, overwrite data with nothing and exit otherwise
if [ -z "$(playerctl metadata 2> /dev/null)" ]
then
	# echo so that something is returned, to clear the module text when nothing is playing
	echo
	exit
fi

STATUS=$(playerctl status)
PLAYER=$(playerctl metadata -f '{{playerName}}' | sed 's/"/\\"/g')
ARTIST=$(playerctl metadata -f '{{artist}}' | sed 's/"/\\"/g')
ALBUM=$(playerctl metadata -f '{{album}}' | sed 's/"/\\"/g')
TITLE=$(playerctl metadata -f '{{title}}' | sed 's/"/\\"/g')
POSITION=$(playerctl metadata -f '{{duration(position)}}' | sed 's/"/\\"/g')
LENGTH=$(playerctl metadata -f '{{duration(mpris:length)}}' | sed 's/"/\\"/g')

# show the symbol according to the status
if ! [ -z $STATUS ]
then
	if [ "$STATUS" = "Playing" ]
	then
		TEXT="  "
	fi
	if [ "$STATUS" = "Paused" ]
	then
		TEXT="  "
	fi
	if [ "$STATUS" = "Stopped" ]
	then
		TEXT="⏹  "
	fi
fi

# show player name if available
if ! [ -z "PLAYER" ]
then
	TEXT=$TEXT$PLAYER
fi

# count up artist, album and title (used to only show as many '/'s as needed
TRACK_DATA_COUNT=0

if ! [ -z "$ARTIST" ]
then
	TRACK_DATA_COUNT=$(( $TRACK_DATA_COUNT + 1 ))
fi

if ! [ -z "$ALBUM" ]
then
	TRACK_DATA_COUNT=$(( $TRACK_DATA_COUNT + 1 ))
fi

if ! [ -z "$TITLE" ]
then
	TRACK_DATA_COUNT=$(( $TRACK_DATA_COUNT + 1 ))
fi

# if we have track data, print it
if [ $TRACK_DATA_COUNT -ge 1 ]
then
	# if we know the player (so we have printed it already) add a divider
	if ! [ -z "$PLAYER" ]
	then
		TEXT=$TEXT" | "
	fi

	# if we know the artist, print it and decrease the counter
	if ! [ -z "$ARTIST" ]
	then
		TEXT=$TEXT$ARTIST

		# if there is more data to print after this, add a divider for it
		if [ $TRACK_DATA_COUNT -gt 1 ]
		then
			TEXT=$TEXT"/"
		fi

		TRACK_DATA_COUNT=$(( $TRACK_DATA_COUNT - 1 ))
	fi

	# if we know the album, print it and decrease the counter
	if ! [ -z "$ALBUM" ]
	then
		TEXT=$TEXT$ALBUM

		# if there is more data to print after this, add a divider for it
		if [ $TRACK_DATA_COUNT -gt 1 ]
		then
			TEXT=$TEXT"/"
		fi

		TRACK_DATA_COUNT=$(( $TRACK_DATA_COUNT - 1 ))
	fi

	# if we know the title, print it (counter is not decreased because it does not matter)
	if ! [ -z "$TITLE" ]
	then
		TEXT=$TEXT$TITLE
	fi
fi

# check if we have time related information to show
SHOW_TIMES=false

if ! [ -z "$POSITION" ]; then SHOW_TIMES=true; fi
if ! [ -z "$LENGTH" ]; then SHOW_TIMES=true; fi

# add a divider if we have time information to show
if $SHOW_TIMES
then
	TEXT=$TEXT" | "
fi

# if we know the position, print it
if ! [ -z "$POSITION" ]
then
	TEXT=$TEXT$POSITION

	# if theres also a length, add a divider
	if ! [ -z "$LENGTH" ]
	then
		TEXT=$TEXT"/"
	fi
fi

# if we know the length, print it
if ! [ -z "$LENGTH" ]
then
	TEXT=$TEXT$LENGTH
fi

# escape characters that will break the json
TEXT=$(echo $TEXT | sed 's/\\/\\\\/g')
TEXT=$(echo $TEXT | sed "s/\"/\\\"/g")

# format the text to be set to waybar as json

echo '{ "text": "'$TEXT'" }' | sed "s/\&/\&amp\;/"
