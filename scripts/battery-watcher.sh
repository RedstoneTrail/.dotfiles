#! /bin/bash
WAS_CHARGING=0
ASKED_CAPACITY=0
while true
do
	CAPACITY=$(</sys/class/power_supply/BAT1/capacity)
	CHARGING=$(</sys/class/power_supply/ACAD/online)

	if [ $CHARGING = 1 ] && [ $WAS_CHARGING = 0 ]
	then
		WAS_CHARGING=1
		hyprctl -i 0 notify 1 5000 0 "charging ($CAPACITY%)"
	elif [ $CHARGING = 0 ] && [ $WAS_CHARGING = 1 ]
	then
		WAS_CHARGING=0
		hyprctl -i 0 notify 1 5000 0 "no longer charging ($CAPACITY%)"
	elif [ $CAPACITY -le 5 ] && [ $ASKED_CAPACITY = 0 ] && [ $CHARGING = 0 ]
	then
		hyprctl -i 0 notify 3 5000 0 "battery critical! ($CAPACITY%)"
		ASKED_CAPACITY=240
	elif [ $CAPACITY -le 10 ] && [ $ASKED_CAPACITY = 0 ] && [ $CHARGING = 0 ]
	then
		hyprctl -i 0 notify 0 5000 0 "battery very low! ($CAPACITY%)"
		ASKED_CAPACITY=1200
	elif [ $CAPACITY -le 20 ] && [ $ASKED_CAPACITY = 0 ] && [ $CHARGING = 0 ]
	then
		hyprctl -i 0 notify 2 5000 0 "battery low! ($CAPACITY%)"
		ASKED_CAPACITY=2400
	fi

	if [ $ASKED_CAPACITY -gt 0 ]
	then
		ASKED_CAPACITY=$(($ASKED_CAPACITY-1))
	fi

	sleep 0.25
done
