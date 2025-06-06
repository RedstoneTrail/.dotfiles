#!/bin/env zsh

if [ -z $(echo $@ | rev | cut -f1 -d\  | rev | grep CRITICAL) ]
then
else
	paplay ~/.dotfiles/dunst/notification-sound.mp3 & sleep 0.1
	paplay ~/.dotfiles/dunst/notification-sound.mp3 & sleep 0.1
fi

if [ -z $(echo $@ | rev | cut -f1 -d\  | rev | grep NORMAL) ]
then
else
	paplay ~/.dotfiles/dunst/notification-sound.mp3 & sleep 0.1
fi

paplay ~/.dotfiles/dunst/notification-sound.mp3 &
