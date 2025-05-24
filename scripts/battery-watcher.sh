#! /bin/bash
WAS_CHARGING=0
ASKED_CAPACITY=0
APPNAME=battery-watcher

while true
do
	CAPACITY=$(</sys/class/power_supply/BAT1/capacity)
	CHARGING=$(</sys/class/power_supply/ACAD/online)

	if [ $CHARGING = 1 ] && [ $WAS_CHARGING = 0 ]
	then
		WAS_CHARGING=1
		notify-send -u low -a $APPNAME now\ charging
	elif [ $CHARGING = 0 ] && [ $WAS_CHARGING = 1 ]
	then
		WAS_CHARGING=0
		notify-send -u low -a $APPNAME no\ longer\ charging
	elif [ $CAPACITY -le 5 ] && [ $ASKED_CAPACITY = 0 ] && [ $CHARGING = 0 ]
	then
		ASKED_CAPACITY=240
		notify-send -u critical -a $APPNAME critically\ low\ battery!
	elif [ $CAPACITY -le 10 ] && [ $ASKED_CAPACITY = 0 ] && [ $CHARGING = 0 ]
	then
		ASKED_CAPACITY=1200
		notify-send -u normal -a $APPNAME very\ low\ battery
	elif [ $CAPACITY -le 20 ] && [ $ASKED_CAPACITY = 0 ] && [ $CHARGING = 0 ]
	then
		ASKED_CAPACITY=2400
		notify-send -u low -a $APPNAME low\ battery
	fi

	if [ $ASKED_CAPACITY -gt 0 ]
	then
		ASKED_CAPACITY=$(($ASKED_CAPACITY-1))
	fi

	sleep 0.25
done
